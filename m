Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59085319873
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187129; cv=none; b=bZdzwWqAr+blEIUk3+G7NPGMG50I3lU69w+Btx1gJANOoKZ3WtdIS0yBIfQSgdaTUriL6Lo/3Yf3/zuIayaSa39LsU4vcm4lynkvgeJmUGdD/uwzq9dOsEVca2hHNrzyK5GzDYFeNNUxbypolifhEXhoUSIqmmuv07QRMP3H4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187129; c=relaxed/simple;
	bh=7EJD5aohQen8rxf3Qzm6rS76fKOZFsE/YU+nVi7cs3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sa4fzgfPhMJRIQR+XLjMEAH+kVBgz1bpvJhjo0czt7o6bGTXvpJ+j8a53pcS1nWMsOsj7SKcPtddtwyZEbo82Pf4sDU8ens32uFwJVZWXBNs1Q76gGtTxkTc8iIqLaqwwoGwQqQh+WKIEiFdqAFa7Sd0i3u8gklNKqSSEDg0AXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1lc3VOC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1lc3VOC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso29991025e9.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187126; x=1762791926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IuwR/KtnRD7ZfyVEXR2TZcLBWSEMCGEZnFYAO0FsM8o=;
        b=P1lc3VOCOVuFoOGpsGt/B/hROa5NRQXWxGDbHeMweOLHK6xMcFhGpcuBBhvuelmMwz
         bsfrj+AF/lP5k2afq43Flsjxt1W3bHTbsaDFVj2SZNezdsAZd6Z5ZJX2X3uc/H/2y3vu
         0Ww0h6qfe4Iy9qwzt7QAx5CUmSBg6WtTuNn86j/qAbcNF+x84p510pNyiH4VMFeY1Wgj
         Um2WXBizu3WlPsXaZjgwDSGiHAG1wUMKptAweSO+0ZoROev4QmaT3govInBL6e6ev2SV
         jvWLTzXjul8+LRLc/HvDlrljU2P40C414eCd5yHqszP2VjzW+qenG58SGXEIXpQhRCvv
         1qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187126; x=1762791926;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuwR/KtnRD7ZfyVEXR2TZcLBWSEMCGEZnFYAO0FsM8o=;
        b=LM5zWK+cyPYrD3CYKcUQ2TeJWbAQ6Q7cdIkStoOh1mj5hrMjGPE7+fEUiT8kDXse5z
         towzUBFIJV87RYr0qos2pVQWioMBmq3fWGVgJZvtft9+Q+wQ/mFkGkGO/VWnug7ymkrp
         CDrsxJPLsp6TeVL1AjN3Gr8hy0hQnhw5sfISL8vLI9was0/+FiySykaqvHOpS/Xd1Si6
         9X8EXCoTetdyRZPz+uIvSAVERJVYgyBIZaYtVcyt//3dNJGIgOCA96/N0yyr8Fk7TCmW
         5JwvB4jxBa6mBCxXEcRCsQ3q3dE+K9JeqMhNKv+KLum/mXqk0mTlGO9cAzESb4zJr2NQ
         3dPA==
X-Forwarded-Encrypted: i=1; AJvYcCXwOqkfK5uwKeGMDMymEJx+fhfOU9B86EBSComh0wNJHwOTRv2Hrlqq3BXRMJiXApxofII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIto4MemLE3WVsu+X6zC9KPE+V6Ggkh3tpnAjQR/k3DWAI0CUG
	87uf5jOcaW8iPltkoUon0eRmkijcNNSG1gLKWh1lKXiR5C+qGT+Hafax
X-Gm-Gg: ASbGncueQ12YO7kTBriVkRXmiBYoxIVV9Xyju+9/109YHWWEzanyiljc/ynDkZRgB/0
	2Uje5hXqdO5X9SyyXjpJ83mCFa7295wEp5QBPB8+/Udx7W7733MR2AxZqlNJMxs6DEcGGM4TFQN
	+kWE0od0v8HsDgfVpuCKWgBzrZYphvRkKNC1rKCDdZDlJBHQFqfd480Ob5R1HLR+IgLo47LDp1K
	XgNMpOwR8iB65hoz2WsC6OYpyQADpPWgXzi+OFecnldY5f6+HHNb91gbxi09AznZATuxxbywXSu
	qvQPNaZWc8+7iajxlmBv+B7zinRZ1vXx2nBl81IrYHuubXlf6FQW0sehJpmtn1Xpem1gT/589Cs
	qv9loZNtDrn1+7b0B4JJhYmqqgNmgiOIHCr9q/KVIWp7YN2NcP5JoUvNBLcbAExk5bXaz2r2K+o
	+u2Sy9de3TPrVHOpVLQEwiXSnhAE/hZZliRPyDZVXTwiJNM6RWQ3Om
X-Google-Smtp-Source: AGHT+IG4PW1hh/kJp+0Gk3Lo4FgNkZmA2WtFADjL+4aZOTzS174mWampLmJWJJGW7eyqsr61Q5anZA==
X-Received: by 2002:a05:6000:2908:b0:428:57b8:926f with SMTP id ffacd0b85a97d-429bd6b21a5mr11375562f8f.58.1762187125503;
        Mon, 03 Nov 2025 08:25:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429cdd11467sm11029537f8f.26.2025.11.03.08.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:25:24 -0800 (PST)
Message-ID: <a7f9c31b-2342-405e-848d-08b9de837dc6@gmail.com>
Date: Mon, 3 Nov 2025 16:25:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 2/3] replay: make atomic ref updates the default
 behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-3-siddharthasthana31@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251030191931.30837-3-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Siddharth

On 30/10/2025 19:19, Siddharth Asthana wrote:

> +	case REF_ACTION_UPDATE:
> +		return ref_transaction_update(transaction, refname, new_oid, old_oid,
> +					      NULL, NULL, 0, "git replay", err);

I wonder if we should use a more descriptive reflog message here that 
says what git replay was doing. For example "git replay --onto 
<new-base> <revs>" could include the new base in the reflog message like 
"git rebase" does. For "git replay --advance" we could include the 
commits that have been picked. It would be helpful to test the reflog 
message in the new tests as well.

Thanks

Phillip

> +	default:
> +		BUG("unknown ref_action_mode %d", mode);
> +	}
> +}
> +
>   int cmd_replay(int argc,
>   	       const char **argv,
>   	       const char *prefix,
> @@ -294,6 +321,8 @@ int cmd_replay(int argc,
>   	struct commit *onto = NULL;
>   	const char *onto_name = NULL;
>   	int contained = 0;
> +	const char *ref_action_str = NULL;
> +	enum ref_action_mode ref_action = REF_ACTION_UPDATE;
>   
>   	struct rev_info revs;
>   	struct commit *last_commit = NULL;
> @@ -302,12 +331,14 @@ int cmd_replay(int argc,
>   	struct merge_result result;
>   	struct strset *update_refs = NULL;
>   	kh_oid_map_t *replayed_commits;
> +	struct ref_transaction *transaction = NULL;
> +	struct strbuf transaction_err = STRBUF_INIT;
>   	int ret = 0;
>   
> -	const char * const replay_usage[] = {
> +	const char *const replay_usage[] = {
>   		N_("(EXPERIMENTAL!) git replay "
>   		   "([--contained] --onto <newbase> | --advance <branch>) "
> -		   "<revision-range>..."),
> +		   "[--ref-action[=<mode>]] <revision-range>..."),
>   		NULL
>   	};
>   	struct option replay_options[] = {
> @@ -319,6 +350,9 @@ int cmd_replay(int argc,
>   			   N_("replay onto given commit")),
>   		OPT_BOOL(0, "contained", &contained,
>   			 N_("advance all branches contained in revision-range")),
> +		OPT_STRING(0, "ref-action", &ref_action_str,
> +			   N_("mode"),
> +			   N_("control ref update behavior (update|print)")),
>   		OPT_END()
>   	};
>   
> @@ -333,6 +367,18 @@ int cmd_replay(int argc,
>   	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>   				  contained, "--contained");
>   
> +	/* Default to update mode if not specified */
> +	if (!ref_action_str)
> +		ref_action_str = "update";
> +
> +	/* Parse ref action mode */
> +	if (!strcmp(ref_action_str, "update"))
> +		ref_action = REF_ACTION_UPDATE;
> +	else if (!strcmp(ref_action_str, "print"))
> +		ref_action = REF_ACTION_PRINT;
> +	else
> +		die(_("unknown --ref-action mode '%s'"), ref_action_str);
> +
>   	advance_name = xstrdup_or_null(advance_name_opt);
>   
>   	repo_init_revisions(repo, &revs, prefix);
> @@ -389,6 +435,17 @@ int cmd_replay(int argc,
>   	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
>   			      &onto, &update_refs);
>   
> +	/* Initialize ref transaction if using update mode */
> +	if (ref_action == REF_ACTION_UPDATE) {
> +		transaction = ref_store_transaction_begin(get_main_ref_store(repo),
> +							  0, &transaction_err);
> +		if (!transaction) {
> +			ret = error(_("failed to begin ref transaction: %s"),
> +				    transaction_err.buf);
> +			goto cleanup;
> +		}
> +	}
> +
>   	if (!onto) /* FIXME: Should handle replaying down to root commit */
>   		die("Replaying down to root commit is not supported yet!");
>   
> @@ -434,10 +491,15 @@ int cmd_replay(int argc,
>   			if (decoration->type == DECORATION_REF_LOCAL &&
>   			    (contained || strset_contains(update_refs,
>   							  decoration->name))) {
> -				printf("update %s %s %s\n",
> -				       decoration->name,
> -				       oid_to_hex(&last_commit->object.oid),
> -				       oid_to_hex(&commit->object.oid));
> +				if (handle_ref_update(ref_action, transaction,
> +						      decoration->name,
> +						      &last_commit->object.oid,
> +						      &commit->object.oid,
> +						      &transaction_err) < 0) {
> +					ret = error(_("failed to update ref '%s': %s"),
> +						    decoration->name, transaction_err.buf);
> +					goto cleanup;
> +				}
>   			}
>   			decoration = decoration->next;
>   		}
> @@ -445,10 +507,23 @@ int cmd_replay(int argc,
>   
>   	/* In --advance mode, advance the target ref */
>   	if (result.clean == 1 && advance_name) {
> -		printf("update %s %s %s\n",
> -		       advance_name,
> -		       oid_to_hex(&last_commit->object.oid),
> -		       oid_to_hex(&onto->object.oid));
> +		if (handle_ref_update(ref_action, transaction, advance_name,
> +				      &last_commit->object.oid,
> +				      &onto->object.oid,
> +				      &transaction_err) < 0) {
> +			ret = error(_("failed to update ref '%s': %s"),
> +				    advance_name, transaction_err.buf);
> +			goto cleanup;
> +		}
> +	}
> +
> +	/* Commit the ref transaction if we have one */
> +	if (transaction && result.clean == 1) {
> +		if (ref_transaction_commit(transaction, &transaction_err)) {
> +			ret = error(_("failed to commit ref transaction: %s"),
> +				    transaction_err.buf);
> +			goto cleanup;
> +		}
>   	}
>   
>   	merge_finalize(&merge_opt, &result);
> @@ -460,6 +535,9 @@ int cmd_replay(int argc,
>   	ret = result.clean;
>   
>   cleanup:
> +	if (transaction)
> +		ref_transaction_free(transaction);
> +	strbuf_release(&transaction_err);
>   	release_revisions(&revs);
>   	free(advance_name);
>   
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 58b3759935..123734b49f 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
>   '
>   
>   test_expect_success 'using replay to rebase two branches, one on top of other' '
> -	git replay --onto main topic1..topic2 >result &&
> +	git replay --ref-action=print --onto main topic1..topic2 >result &&
>   
>   	test_line_count = 1 result &&
>   
> @@ -68,7 +68,7 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
>   '
>   
>   test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
> -	git -C bare replay --onto main topic1..topic2 >result-bare &&
> +	git -C bare replay --ref-action=print --onto main topic1..topic2 >result-bare &&
>   	test_cmp expect result-bare
>   '
>   
> @@ -86,7 +86,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
>   	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
>   	# 4th field of result is hash for main instead of hash for topic2
>   
> -	git replay --advance main topic1..topic2 >result &&
> +	git replay --ref-action=print --advance main topic1..topic2 >result &&
>   
>   	test_line_count = 1 result &&
>   
> @@ -102,7 +102,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
>   '
>   
>   test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
> -	git -C bare replay --advance main topic1..topic2 >result-bare &&
> +	git -C bare replay --ref-action=print --advance main topic1..topic2 >result-bare &&
>   	test_cmp expect result-bare
>   '
>   
> @@ -115,7 +115,7 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
>   '
>   
>   test_expect_success 'using replay to also rebase a contained branch' '
> -	git replay --contained --onto main main..topic3 >result &&
> +	git replay --ref-action=print --contained --onto main main..topic3 >result &&
>   
>   	test_line_count = 2 result &&
>   	cut -f 3 -d " " result >new-branch-tips &&
> @@ -139,12 +139,12 @@ test_expect_success 'using replay to also rebase a contained branch' '
>   '
>   
>   test_expect_success 'using replay on bare repo to also rebase a contained branch' '
> -	git -C bare replay --contained --onto main main..topic3 >result-bare &&
> +	git -C bare replay --ref-action=print --contained --onto main main..topic3 >result-bare &&
>   	test_cmp expect result-bare
>   '
>   
>   test_expect_success 'using replay to rebase multiple divergent branches' '
> -	git replay --onto main ^topic1 topic2 topic4 >result &&
> +	git replay --ref-action=print --onto main ^topic1 topic2 topic4 >result &&
>   
>   	test_line_count = 2 result &&
>   	cut -f 3 -d " " result >new-branch-tips &&
> @@ -168,7 +168,7 @@ test_expect_success 'using replay to rebase multiple divergent branches' '
>   '
>   
>   test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
> -	git -C bare replay --contained --onto main ^main topic2 topic3 topic4 >result &&
> +	git -C bare replay --ref-action=print --contained --onto main ^main topic2 topic3 topic4 >result &&
>   
>   	test_line_count = 4 result &&
>   	cut -f 3 -d " " result >new-branch-tips &&
> @@ -217,4 +217,32 @@ test_expect_success 'merge.directoryRenames=false' '
>   		--onto rename-onto rename-onto..rename-from
>   '
>   
> +test_expect_success 'default atomic behavior updates refs directly' '
> +	# Store original state for cleanup
> +	test_when_finished "git branch -f topic2 topic1" &&
> +
> +	# Test default atomic behavior (no output, refs updated)
> +	git replay --onto main topic1..topic2 >output &&
> +	test_must_be_empty output &&
> +
> +	# Verify ref was updated
> +	git log --format=%s topic2 >actual &&
> +	test_write_lines E D M L B A >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'atomic behavior in bare repository' '
> +	# Test atomic updates work in bare repo
> +	git -C bare replay --onto main topic1..topic2 >output &&
> +	test_must_be_empty output &&
> +
> +	# Verify ref was updated in bare repo
> +	git -C bare log --format=%s topic2 >actual &&
> +	test_write_lines E D M L B A >expect &&
> +	test_cmp expect actual &&
> +
> +	# Reset for other tests
> +	git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse topic1)
> +'
> +
>   test_done

