Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DCE21ABC6
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495560; cv=none; b=HQyyzgihpX9ygWDYd9Wv5LhqFWX197Ps8Y09WecxYISlTmApe7odKZ2lvJsyAAD+SxwAC3N3K0EyPXmpKUOT2S0v+48XW9MotMRhj/o91qKqHe4KD7DFDcjZCrey1ri+dBhtspQLVDhGHxrUa7dmsIxZoAAR4WMbRCNDcpeNcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495560; c=relaxed/simple;
	bh=9ldNpVrj+M/8YDkFCPOGaVOJR6ef7zuD+9Tr9jtEhqk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aOIKHezpsRhXseJs1GwW4hVvbg0QxqrV2FKf2cferb1nMWRZ3fTgHOsB++8LzKhy2KvMQ0WA/35w/FYl+M+aluuyXj6ZI87+Q0Q/JqehkjhjcEzCAHKX0u8XOU5hR09c10IUN/w1sx1GTC5h1RJffs7m8V9AFZJE1oZ527RlvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+34+a1n; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+34+a1n"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f378498c9so5629387f8f.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740495556; x=1741100356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CUQRBWbOoLlhqrOpb+s8Lw0YyHFouQX23GmUFOUjkfA=;
        b=g+34+a1nKgmGPU09e6yjhmdGX9Jbq31b7mYT1qHbnmrUdsqfEqLJ+p4jKjnp6L2XvS
         tjhsXN7JshDhh9zbDyokfq07Q4Qm4hIUyvBhY4+joKyY/VFwh1jJNmlokwHkWEID6x9J
         ZUpjXxWyXv6V0MHa/BXfLDnQjvmYyZS9mEXlbnFw+QQl7JexOVLTlQUtQLBuRR3eDjni
         m1H1KWcgU/Mn8HddDvFUMJ20Li2ZNE5eI6KHp8EAJvTdG60bLYimQodDOmweefzx2bIi
         2zvbKSOtbMeyMO65v9RE4VqXZAkAC6lMWncmWo+Ob6mg9x0rlwtv+plK1aG1A9k4ckwN
         ZKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495556; x=1741100356;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUQRBWbOoLlhqrOpb+s8Lw0YyHFouQX23GmUFOUjkfA=;
        b=q0UPZTe6xMMcMNUBA0Qk1yKEXOp7KHifs2NzUbwEniS2sqAt6VPFiZgMQyX1CVepa4
         iizQRzGB6gl6Oxt1kIsX5GUODUPvl9YaA6NS/OkJMQFkXhmDVI2pmL0K0L9KbwcViGH3
         p7Fn1yR4sErS3MC6YSfMiD3RdM8mtZp2s0/NX0Nb7wXwXWAJUKhnkFiwQwolfyCnVWJB
         rfYyCKQGiTo2F7qtEnyrD1Zxl7VG+SJEEMrDBFKSJFVdcdwATF+4rwKYK0M7h58ylT4l
         YQOQypQqZPTy9NK4v0hy4T0gU+UpaiAMh9sozoMoqgc1IEX2JclAW0xKezoXQs3pP7vg
         FrUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCD8gVZQOiD8TXe1XlvDiII9JO5r95VyP1rMXEa3tnyiBFsKPmpdMBe74QFsI7cVZhqj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHioWrZpp8EmT+eH6wMMEotW8Zse6iTEIPeroB4RqFNmoZSXf
	5SFGyWAhIegt3uAWO0BTza+midoQdQ5b/YOOZKs0NYZakYrq9m5U
X-Gm-Gg: ASbGncshRT5zr4xYPe4xUhB62WfFgTxT/EPvnW2IxGrolldpuPWm+STVofH16GSiW/0
	kAsnIvLAycp4xHbDRWEwQmNFWal4kkg5PD1CUu39/Z8DBXx0Z06Icw6rSNMcf1RE8+1uytrAWS6
	ZOy+y/bLtppfg2UjGf8RrXLveC8FqglvJx2B64rzHYkWZqC8RTcEwXggZnwnwHzCOY+uvPL/68i
	kFaTR4ZO+ZnfSa/ylxMCvnriqfdyzwwDvKiZHPamUYnivgsUU0MdMykDrl2iKqRA5hLajaYqpfO
	7+TlnPC9BX6vZfZmr7lS9fX7o+XprzzEy7stp0uDOEk2fpHedRA/1+fEpBSZvCMqf12LkcmGeN9
	IbnsF
X-Google-Smtp-Source: AGHT+IH7n75cfpOK7xEOdiqswimybSd7Y2omOqhO02cAMKM5bMPyxKNMfoSL3iuH9OmLFhz6J9notw==
X-Received: by 2002:a5d:5109:0:b0:38f:2073:14a7 with SMTP id ffacd0b85a97d-390cc63bf61mr2711487f8f.47.1740495556229;
        Tue, 25 Feb 2025 06:59:16 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab15476f0sm29076635e9.23.2025.02.25.06.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 06:59:15 -0800 (PST)
Message-ID: <ceda422e-8c8e-4a1d-aaab-9a7a2fc009dd@gmail.com>
Date: Tue, 25 Feb 2025 14:59:14 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 7/7] update-ref: add --allow-partial flag for stdin
 mode
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, phillip.wood123@gmail.com
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-7-cfa3236895d7@gmail.com>
Content-Language: en-US
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-7-cfa3236895d7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 25/02/2025 09:29, Karthik Nayak wrote:
> When updating multiple references through stdin, Git's update-ref
> command normally aborts the entire transaction if any single update
> fails. While this atomic behavior prevents partial updates by default,
> there are cases where applying successful updates while reporting
> failures is desirable.
> 
> Add a new `--allow-partial` flag that allows the transaction to continue
> even when individual reference updates fail. This flag can only be used
> in `--stdin` mode and builds upon the partial transaction support added
> to the refs subsystem.

As '--stdin' allows a single instance of "git update-ref" to create more 
than one transaction perhaps we should instead allow the caller to 
specify which transactions they want to allow to fail by passing an 
argument to "start", similar to how we support "no-deref" with "update"

> following format:
> 
>    rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
> 
> or with `-z`:
> 
>    rejected NUL (<old-oid> | <old-target>) NUL (<new-oid> | <new-target>) NUL <rejection-reason> NUL

What's the reason for the different output with '-z'? In the list of 
options '-z' is documented as only applying to the input stream. Looking 
at the code the existing messages generated by report_ok() are all 
printed to stdout with a LF terminator.

> +static void print_rejected_refs(const char *refname,
> +				const struct object_id *old_oid,
> +				const struct object_id *new_oid,
> +				const char *old_target,
> +				const char *new_target,
> +				enum transaction_error err,
> +				void *cb_data UNUSED)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	char space = ' ';
> +	const char *reason = "";
> +
> +	switch (err) {
> +	case TRANSACTION_NAME_CONFLICT:
> +		reason = _("refname conflict");
> +		break;
> +	case TRANSACTION_CREATE_EXISTS:
> +		reason = _("reference already exists");
> +		break;
> +	case TRANSACTION_NONEXISTENT_REF:
> +		reason = _("reference does not exist");
> +		break;
> +	case TRANSACTION_INCORRECT_OLD_VALUE:
> +		reason = _("incorrect old value provided");
> +		break;
> +	case TRANSACTION_INVALID_NEW_VALUE:
> +		reason = _("invalid new value provided");
> +		break;
> +	case TRANSACTION_EXPECTED_SYMREF:
> +		reason = _("expected symref but found regular ref");
> +		break;
> +	default:
> +		reason = _("unkown failure");
> +	}

I agree with Patrick that these messages should not be translated.

> +	if (!line_termination)
> +		space = line_termination;
> +
> +	strbuf_addf(&sb, "rejected%c%s%c%s%c%c%s%c%s%c", space,
> +		    refname, space, new_oid ? oid_to_hex(new_oid) : new_target,
> +		    space, space, old_oid ? oid_to_hex(old_oid) : old_target,
> +		    space, reason, line_termination);
> +
> +	fwrite(sb.buf, sb.len, 1, stdout);
> +	strbuf_release(&sb);
> +	fflush(stdout);

There is no need to flush after each line, we'll flush all the error 
messages when we call report_ok() in parse_cmd_commit() or when the 
program exits. The caller has no way to know how many error messages 
there are to read so flushing each one individually does not help the 
reader avoid deadlocks.

> +}
> +
>   static void parse_cmd_commit(struct ref_transaction *transaction,
>   			     const char *next, const char *end UNUSED)
>   {
> @@ -573,6 +622,10 @@ static void parse_cmd_commit(struct ref_transaction *transaction,
>   		die("commit: extra input: %s", next);
>   	if (ref_transaction_commit(transaction, &error))
>   		die("commit: %s", error.buf);
> +
> +	ref_transaction_for_each_rejected_update(transaction,
> +						 print_rejected_refs, NULL);
> +
>   	report_ok("commit");

This is good, the caller knows to stop reading when they see "commit: ok"


Best Wishes

Phillip

>   	ref_transaction_free(transaction);
>   }
> @@ -609,7 +662,7 @@ static const struct parse_cmd {
>   	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
>   };
>   
> -static void update_refs_stdin(void)
> +static void update_refs_stdin(unsigned int flags)
>   {
>   	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
>   	enum update_refs_state state = UPDATE_REFS_OPEN;
> @@ -617,7 +670,7 @@ static void update_refs_stdin(void)
>   	int i, j;
>   
>   	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> -						  0, &err);
> +						  flags, &err);
>   	if (!transaction)
>   		die("%s", err.buf);
>   
> @@ -685,7 +738,7 @@ static void update_refs_stdin(void)
>   			 */
>   			state = cmd->state;
>   			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> -								  0, &err);
> +								  flags, &err);
>   			if (!transaction)
>   				die("%s", err.buf);
>   
> @@ -701,6 +754,8 @@ static void update_refs_stdin(void)
>   		/* Commit by default if no transaction was requested. */
>   		if (ref_transaction_commit(transaction, &err))
>   			die("%s", err.buf);
> +		ref_transaction_for_each_rejected_update(transaction,
> +						 print_rejected_refs, NULL);
>   		ref_transaction_free(transaction);
>   		break;
>   	case UPDATE_REFS_STARTED:
> @@ -726,7 +781,9 @@ int cmd_update_ref(int argc,
>   	const char *refname, *oldval;
>   	struct object_id oid, oldoid;
>   	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
> -	int create_reflog = 0;
> +	int create_reflog = 0, allow_partial = 0;
> +	unsigned int flags = 0;
> +
>   	struct option options[] = {
>   		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
>   		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
> @@ -735,6 +792,8 @@ int cmd_update_ref(int argc,
>   		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
>   		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
>   		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
> +		OPT_BIT('0', "allow-partial", &flags, N_("allow partial transactions"),
> +			REF_TRANSACTION_ALLOW_PARTIAL),
>   		OPT_END(),
>   	};
>   
> @@ -756,9 +815,10 @@ int cmd_update_ref(int argc,
>   			usage_with_options(git_update_ref_usage, options);
>   		if (end_null)
>   			line_termination = '\0';
> -		update_refs_stdin();
> +		update_refs_stdin(flags);
>   		return 0;
> -	}
> +	} else if (allow_partial)
> +		die("--allow-partial can only be used with --stdin");
>   
>   	if (end_null)
>   		usage_with_options(git_update_ref_usage, options);
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 29045aad43..fb9442982e 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -2066,6 +2066,222 @@ do
>   		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
>   	'
>   
> +	test_expect_success "stdin $type allow-partial" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit commit &&
> +			head=$(git rev-parse HEAD) &&
> +
> +			format_command $type "update refs/heads/ref1" "$head" "$Z" >stdin &&
> +			format_command $type "update refs/heads/ref2" "$head" "$Z" >>stdin &&
> +			git update-ref $type --stdin --allow-partial <stdin &&
> +			echo $head >expect &&
> +			git rev-parse refs/heads/ref1 >actual &&
> +			test_cmp expect actual &&
> +			git rev-parse refs/heads/ref2 >actual &&
> +			test_cmp expect actual
> +		)
> +	'
> +
> +	test_expect_success "stdin $type allow-partial with invalid new_oid" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +			old_head=$(git rev-parse HEAD) &&
> +			test_commit two &&
> +			head=$(git rev-parse HEAD) &&
> +			git update-ref refs/heads/ref1 $head &&
> +			git update-ref refs/heads/ref2 $head &&
> +
> +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
> +			format_command $type "update refs/heads/ref2" "$(test_oid 001)" "$head" >>stdin &&
> +			git update-ref $type --stdin --allow-partial <stdin >stdout &&
> +			echo $old_head >expect &&
> +			git rev-parse refs/heads/ref1 >actual &&
> +			test_cmp expect actual &&
> +			echo $head >expect &&
> +			git rev-parse refs/heads/ref2 >actual &&
> +			test_cmp expect actual &&
> +			test_grep -q "invalid new value provided" stdout
> +		)
> +	'
> +
> +	test_expect_success "stdin $type allow-partial with non-commit new_oid" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +			old_head=$(git rev-parse HEAD) &&
> +			test_commit two &&
> +			head=$(git rev-parse HEAD) &&
> +			head_tree=$(git rev-parse HEAD^{tree}) &&
> +			git update-ref refs/heads/ref1 $head &&
> +			git update-ref refs/heads/ref2 $head &&
> +
> +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
> +			format_command $type "update refs/heads/ref2" "$head_tree" "$head" >>stdin &&
> +			git update-ref $type --stdin --allow-partial <stdin >stdout &&
> +			echo $old_head >expect &&
> +			git rev-parse refs/heads/ref1 >actual &&
> +			test_cmp expect actual &&
> +			echo $head >expect &&
> +			git rev-parse refs/heads/ref2 >actual &&
> +			test_cmp expect actual &&
> +			test_grep -q "invalid new value provided" stdout
> +		)
> +	'
> +
> +	test_expect_success "stdin $type allow-partial with non-existent ref" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +			old_head=$(git rev-parse HEAD) &&
> +			test_commit two &&
> +			head=$(git rev-parse HEAD) &&
> +			git update-ref refs/heads/ref1 $head &&
> +
> +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
> +			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
> +			git update-ref $type --stdin --allow-partial <stdin >stdout &&
> +			echo $old_head >expect &&
> +			git rev-parse refs/heads/ref1 >actual &&
> +			test_cmp expect actual &&
> +			test_must_fail git rev-parse refs/heads/ref2 &&
> +			test_grep -q "reference does not exist" stdout
> +		)
> +	'
> +
> +	test_expect_success "stdin $type allow-partial with dangling symref" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +			old_head=$(git rev-parse HEAD) &&
> +			test_commit two &&
> +			head=$(git rev-parse HEAD) &&
> +			git update-ref refs/heads/ref1 $head &&
> +			git symbolic-ref refs/heads/ref2 refs/heads/nonexistent &&
> +
> +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
> +			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
> +			git update-ref $type --no-deref --stdin --allow-partial <stdin >stdout &&
> +			echo $old_head >expect &&
> +			git rev-parse refs/heads/ref1 >actual &&
> +			test_cmp expect actual &&
> +			echo $head >expect &&
> +			test_must_fail git rev-parse refs/heads/ref2 &&
> +			test_grep -q "reference does not exist" stdout
> +		)
> +	'
> +
> +	test_expect_success "stdin $type allow-partial with regular ref as symref" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +			old_head=$(git rev-parse HEAD) &&
> +			test_commit two &&
> +			head=$(git rev-parse HEAD) &&
> +			git update-ref refs/heads/ref1 $head &&
> +			git update-ref refs/heads/ref2 $head &&
> +
> +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
> +			format_command $type "symref-update refs/heads/ref2" "$old_head" "ref" "refs/heads/nonexistent" >>stdin &&
> +			git update-ref $type --no-deref --stdin --allow-partial <stdin >stdout &&
> +			echo $old_head >expect &&
> +			git rev-parse refs/heads/ref1 >actual &&
> +			test_cmp expect actual &&
> +			echo $head >expect &&
> +			echo $head >expect &&
> +			git rev-parse refs/heads/ref2 >actual &&
> +			test_cmp expect actual &&
> +			test_grep -q "expected symref but found regular ref" stdout
> +		)
> +	'
> +
> +	test_expect_success "stdin $type allow-partial with invalid old_oid" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +			old_head=$(git rev-parse HEAD) &&
> +			test_commit two &&
> +			head=$(git rev-parse HEAD) &&
> +			git update-ref refs/heads/ref1 $head &&
> +			git update-ref refs/heads/ref2 $head &&
> +
> +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
> +			format_command $type "update refs/heads/ref2" "$old_head" "$Z" >>stdin &&
> +			git update-ref $type --stdin --allow-partial <stdin >stdout &&
> +			echo $old_head >expect &&
> +			git rev-parse refs/heads/ref1 >actual &&
> +			test_cmp expect actual &&
> +			echo $head >expect &&
> +			git rev-parse refs/heads/ref2 >actual &&
> +			test_cmp expect actual &&
> +			test_grep -q "reference already exists" stdout
> +		)
> +	'
> +
> +	test_expect_success "stdin $type allow-partial with incorrect old oid" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +			old_head=$(git rev-parse HEAD) &&
> +			test_commit two &&
> +			head=$(git rev-parse HEAD) &&
> +			git update-ref refs/heads/ref1 $head &&
> +			git update-ref refs/heads/ref2 $head &&
> +
> +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
> +			format_command $type "update refs/heads/ref2" "$head" "$old_head" >>stdin &&
> +			git update-ref $type --stdin --allow-partial <stdin >stdout &&
> +			echo $old_head >expect &&
> +			git rev-parse refs/heads/ref1 >actual &&
> +			test_cmp expect actual &&
> +			echo $head >expect &&
> +			git rev-parse refs/heads/ref2 >actual &&
> +			test_cmp expect actual &&
> +			test_grep -q "incorrect old value provided" stdout
> +		)
> +	'
> +
> +	# F/D conflicts on the files backend are resolved on an individual
> +	# update level since refs are stored as files. On the reftable backend
> +	# this check is batched to optimize for performance, so failures cannot
> +	# be isolated to a single update.
> +	test_expect_success REFFILES "stdin $type allow-partial refname conflict" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +			old_head=$(git rev-parse HEAD) &&
> +			test_commit two &&
> +			head=$(git rev-parse HEAD) &&
> +			git update-ref refs/heads/ref/foo $head &&
> +
> +			format_command $type "update refs/heads/ref/foo" "$old_head" "$head" >stdin &&
> +			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
> +			git update-ref $type --stdin --allow-partial <stdin >stdout &&
> +			echo $old_head >expect &&
> +			git rev-parse refs/heads/ref/foo >actual &&
> +			test_cmp expect actual &&
> +			test_grep -q "refname conflict" stdout
> +		)
> +	'
>   done
>   
>   test_expect_success 'update-ref should also create reflog for HEAD' '
> 

