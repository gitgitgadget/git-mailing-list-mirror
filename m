Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3747482
	for <git@vger.kernel.org>; Thu, 23 May 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479558; cv=none; b=K5rmvhHYU163Vt2ZmD71dYbRuVcTZ4gNAMGzLnFc6jTpWU2JBaORya/dJCVduJYiQaQAOghF4Iws+plINOVOVCi2NG80O1USKwB1JHwCwC9SEby9c688CZc9au8L8tbFQMFxvEshL2BF4Rk5KF9a7Ruvjn5rlJtEVEmFpCcsI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479558; c=relaxed/simple;
	bh=kk0+sMGApyrJtkuc/pXdSUdf/+LNWiYx82Fsv8gcJDA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0uG+5OkcOhgfWbp1ZTydjcx5cte8tQ6KXDqAB8+OcwMpulq5TxcwfXuM8W8PMyDLu8zFpSuDmm6K6tiHOVkIsRpJaFi1j0061it2d4yvPiJGwDgb3NV0344owIMqCqv8nrtt67CawXzP8W4gjvugVv2QMPRBhlPtrMlsAevvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbszS4Y1; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbszS4Y1"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f12ed79fdfso3074839a34.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716479554; x=1717084354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wo2xs4CR5Nzv7C3bWET66HbX7LTI5hHfetf0ULN8RHo=;
        b=kbszS4Y1payxdGuOkPeBv7+rnDajwBd6GQmMSlfOFHWe79Fn40ohWTTuAVheo8TROg
         uk/Aic4s2z5tUTKUkj+S3Pr6vho3rXfHiJv93+lnccdgk4MRndy1ccIznvjumObIfHY1
         luGPMVfAiUIpqpPMiYyNvtZlkN0a/wEoR+IMoWqHygx2zI82PxCQpmriGpCFLWXStkTq
         /pyXCG63JICZ8FsGQxrMz4NEYJK4gDP3JQQm8ENANkr57YazgmJPcTqQM204NcDM4NHO
         b6OhyRiBnFh4cAdAljb3kSNHEVNuiAZyExXtdM2xfGWCeGnNqgHD/lAMco52pav9sgUZ
         5wVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479554; x=1717084354;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wo2xs4CR5Nzv7C3bWET66HbX7LTI5hHfetf0ULN8RHo=;
        b=iBrkRXVhMaIA2pT5VliHrtOd7OzyQNJX2Bqq10br253/G5Uq6JM3R7lzYnxZlWJqQS
         90uqVXGW2axXGiKWIcvttQ68Ez/4gMUP3gH/acbmkq0GmN4UviXHweRh2jYKbtHRXxLq
         kuzb5i3yuhkWBVOjUPx3MTWMvbrOFvdA+qdhKawDH5Sn86gmO+GvwV3bc55XB1H28bNi
         9s9QJVQvLVEatbJWdb62FhK52T+1Bu/TUtJgWYIYrLR6etNRwgwzXADwxiZ4HUxPMrAH
         7faJ6rD51mXXpIo612uRS250Ly/w8AujfgUDYpx0wUS0XSJ7mmpOd/CvMeTV/M+D/Tvw
         6Sdg==
X-Gm-Message-State: AOJu0YyH0gXQge0qVq9DkykGBTUWdjrlmCM/RLFfPW7yv6bViLwk27QX
	6WdLvDicOhJZ8gcQI82fri5GJF8N+HQn0/nB0jcjeyytnxNdj+3wEMbz1hn8UPNTyBa7DA5UCXj
	H08zeWGexLTbEj8OHPnYjZ931eTvUvY5SWdBvLQ==
X-Google-Smtp-Source: AGHT+IFtOEN25VXABiafmwMvIDIHE7NocwxLZk8rvRtCoSWd5nxKYSy3nEIPznAIjFke4OxqNcnQC6BQZvPlX4W5I3g=
X-Received: by 2002:a05:6871:d211:b0:24c:63b2:8a0f with SMTP id
 586e51a60fabf-24c68d63267mr6240305fac.30.1716479553848; Thu, 23 May 2024
 08:52:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 May 2024 08:52:32 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbk4wy3ji.fsf@gitster.g>
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240522090326.1268326-1-knayak@gitlab.com>
 <xmqqbk4wy3ji.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 May 2024 08:52:32 -0700
Message-ID: <CAOLa=ZS31CuL8kDODNfM5L8gXN6RUOG5uEP5Q9JzEuaxtLEZ8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000001268f30619210ac4"

--0000000000001268f30619210ac4
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The patches 1, 5 fix small issues in the reference backends. The other
>> patches 2, 3, 4 & 6, each add one of the new sub-commands.
>>
>> The series is based off master, with 'kn/ref-transaction-symref' merged
>> in. There seem to be no conflicts with 'next' or 'seen'.
>
> Wait.  There is something fishy going on.
>
>> Range diff vs v1:
>>  1:  1bc4cc3fc4 =  1:  1bc4cc3fc4 refs: accept symref values in `ref_transaction_update()`
>>  2:  57d0b1e2ea =  2:  57d0b1e2ea files-backend: extract out `create_symref_lock()`
>>  3:  a8ae923f85 =  3:  a8ae923f85 refs: support symrefs in 'reference-transaction' hook
>>  4:  e9965ba477 =  4:  e9965ba477 refs: move `original_update_refname` to 'refs.c'
>>  5:  644daf7785 =  5:  644daf7785 refs: add support for transactional symref updates
>>  6:  300b38e46f =  6:  300b38e46f refs: use transaction in `refs_create_symref()`
>>  7:  f151dfe3c9 =  7:  f151dfe3c9 refs: rename `refs_create_symref()` to `refs_update_symref()`
>>  8:  4865707bda =  8:  4865707bda refs: remove `create_symref` and associated dead code
>>  9:  4cb67dce7c !  9:  2bbdeff798 refs: create and use `ref_update_ref_must_exist()`
>
> 4865707bda has been part of 'next' since 0a7119f2 (Merge branch
> 'kn/ref-transaction-symref' into next, 2024-05-11) and was merged to
> 'master' with 4beb7a3b (Merge branch 'kn/ref-transaction-symref',
> 2024-05-20).
>
> I am confused why we are seeing a total reroll of such an old topic.
>
> Also you have one more patch at the end.  Neither the before or
> after version of 9/9.
>
> Is this actually a single patch submission of 9/9 alone?  Patches
> 1-8/9 are all old ones that are in 'master' already.
>
> Puzzled...

I think this is just a mess up in the range diff, I haven't changed
anything locally. So adding the correct range diff here:

Range diff agains v1:

1:  4cb67dce7c ! 1:  2bbdeff798 refs: create and use
`ref_update_ref_must_exist()`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>

      ## Commit message ##
    -    refs: create and use `ref_update_ref_must_exist()`
    +    refs: create and use `ref_update_expects_existing_old_ref()`

         The files and reftable backend, need to check if a ref must exist, so
         that the required validation can be done. A ref must exist
only when the
    @@ Commit message
         path. As we introduce the 'symref-verify' command in the upcoming
         commits, it is important to fix this.

    -    So let's export this to a function called `ref_update_ref_must_exist()`
    -    and expose it internally via 'refs-internal.h'.
    +    So let's export this to a function called
    +    `ref_update_expects_existing_old_ref()` and expose it internally via
    +    'refs-internal.h'.

         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

    @@ refs.c: int ref_update_check_old_target(const char *referent,
struct ref_update
      	return -1;
      }
     +
    -+int ref_update_ref_must_exist(struct ref_update *update)
    ++int ref_update_expects_existing_old_ref(struct ref_update *update)
     +{
     +	return (update->flags & REF_HAVE_OLD) &&
     +		(!is_null_oid(&update->old_oid) || update->old_target);
    @@ refs/files-backend.c: static int lock_ref_for_update(struct
files_ref_store *ref
      	struct strbuf referent = STRBUF_INIT;
     -	int mustexist = (update->flags & REF_HAVE_OLD) &&
     -		!is_null_oid(&update->old_oid);
    -+	int mustexist = ref_update_ref_must_exist(update);
    ++	int mustexist = ref_update_expects_existing_old_ref(update);
      	int ret = 0;
      	struct ref_lock *lock;

    @@ refs/refs-internal.h: int ref_update_has_null_new_value(struct
ref_update *updat
     + * Check if the ref must exist, this means that the old_oid or
     + * old_target is non NULL.
     + */
    -+int ref_update_ref_must_exist(struct ref_update *update);
    ++int ref_update_expects_existing_old_ref(struct ref_update *update);
     +
      #endif /* REFS_REFS_INTERNAL_H */

    @@ refs/reftable-backend.c: static int
reftable_be_transaction_prepare(struct ref_s
      		if (ret < 0)
      			goto done;
     -		if (ret > 0 && (!(u->flags & REF_HAVE_OLD) ||
is_null_oid(&u->old_oid))) {
    -+		if (ret > 0 && !ref_update_ref_must_exist(u)) {
    ++		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
      			/*
      			 * The reference does not exist, and we either have no
      			 * old object ID or expect the reference to not exist.
2:  9fda13b468 ! 2:  f509066cab update-ref: add support for
'symref-verify' command
    @@ Commit message
         point to an object and not a ref and the regular 'verify'
command can be
         used in such situations.

    -    Add required tests for symref support in 'verify' while also adding
    -    reflog checks for the pre-existing 'verify' tests.
    +    Add required tests for symref support in 'verify'. Since we're here,
    +    also add reflog checks for the pre-existing 'verify' tests, there is no
    +    divergence from behavior, but we never tested to ensure that reflog
    +    wasn't affected by the 'verify' command.

         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

    @@ refs.c: int ref_transaction_delete(struct ref_transaction *transaction,
     -		BUG("verify called with old_oid set to NULL");
     +	if (!old_target && !old_oid)
     +		BUG("verify called with old_oid and old_target set to NULL");
    ++	if (old_oid && old_target)
    ++		BUG("verify called with both old_oid and old_target set");
     +	if (old_target && !(flags & REF_NO_DEREF))
     +		BUG("verify cannot operate on symrefs with deref mode");
      	return ref_transaction_update(transaction, refname,
    @@ t/t1400-update-ref.sh: test_expect_success PIPE 'transaction
flushes status upda
      	test_cmp expected actual
      '

    -+create_stdin_buf () {
    ++format_command () {
     +	if test "$1" = "-z"
     +	then
     +		shift
    -+		printf "$F" "$@" >stdin
    ++		printf "$F" "$@"
     +	else
    -+		echo "$@" >stdin
    ++		echo "$@"
     +	fi
     +}
     +
     +for type in "" "-z"
     +do
     +
    -+	test_expect_success "stdin ${type} symref-verify fails without
--no-deref" '
    ++	test_expect_success "stdin $type symref-verify fails without
--no-deref" '
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
    -+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		format_command $type "symref-verify refs/heads/symref" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type <stdin 2>err &&
     +		grep "fatal: symref-verify: cannot operate with deref mode" err
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify fails with too
many arguments" '
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" "$a" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref
<stdin 2>err  &&
    ++	test_expect_success "stdin $type symref-verify fails with too
many arguments" '
    ++		format_command $type "symref-verify refs/heads/symref" "$a"
"$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err  &&
     +		if test "$type" = "-z"
     +		then
     +			grep "fatal: unknown command: $a" err
    @@ t/t1400-update-ref.sh: test_expect_success PIPE 'transaction
flushes status upda
     +		fi
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify succeeds for
correct value" '
    ++	test_expect_success "stdin $type symref-verify succeeds for
correct value" '
     +		git symbolic-ref refs/heads/symref >expect &&
     +		test-tool ref-store main for-each-reflog-ent refs/heads/symref
>before &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-verify refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual &&
     +		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
     +		test_cmp before after
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify no value is
treated as zero value" '
    ++	test_expect_success "stdin $type symref-verify fails with no value" '
     +		git symbolic-ref refs/heads/symref >expect &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
    ++		format_command $type "symref-verify refs/heads/symref" "" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify succeeds for
dangling reference" '
    ++	test_expect_success "stdin $type symref-verify succeeds for
dangling reference" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
     +		test_must_fail git symbolic-ref refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref2"
"refs/heads/nonexistent" &&
    -+		git update-ref --stdin ${type} --no-deref <stdin
    ++		format_command $type "symref-verify refs/heads/symref2"
"refs/heads/nonexistent" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify fails for
missing reference" '
    ++	test_expect_success "stdin $type symref-verify fails for
missing reference" '
     +		test-tool ref-store main for-each-reflog-ent refs/heads/symref
>before &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/missing"
"refs/heads/unknown" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++		format_command $type "symref-verify refs/heads/missing"
"refs/heads/unknown" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		grep "fatal: cannot lock ref ${SQ}refs/heads/missing${SQ}:
unable to resolve reference ${SQ}refs/heads/missing${SQ}" err &&
     +		test_must_fail git rev-parse --verify -q refs/heads/missing &&
     +		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
     +		test_cmp before after
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify fails for wrong value" '
    ++	test_expect_success "stdin $type symref-verify fails for wrong value" '
     +		git symbolic-ref refs/heads/symref >expect &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$b" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-verify refs/heads/symref" "$b" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify fails for
mistaken null value" '
    ++	test_expect_success "stdin $type symref-verify fails for
mistaken null value" '
     +		git symbolic-ref refs/heads/symref >expect &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$Z" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-verify refs/heads/symref" "$Z" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
3:  d07031827b ! 3:  a11f4c1e48 update-ref: add support for
'symref-delete' command
    @@ refs.c: int ref_transaction_create(struct ref_transaction *transaction,
      {
      	if (old_oid && is_null_oid(old_oid))
      		BUG("delete called with old_oid set to zeros");
    ++	if (old_oid && old_target)
    ++		BUG("delete called with both old_oid and old_target set");
     +	if (old_target && !(flags & REF_NO_DEREF))
     +		BUG("delete cannot operate on symrefs with deref mode");
      	return ref_transaction_update(transaction, refname,
    @@ refs.h: int ref_transaction_create(struct ref_transaction *transaction,
      /*

      ## t/t1400-update-ref.sh ##
    -@@ t/t1400-update-ref.sh: do
    - 		test_cmp before after
    - 	'
    -
    --	test_expect_success "stdin ${type} symref-verify no value is
treated as zero value" '
    -+	test_expect_success "stdin ${type} symref-verify fails with no value" '
    - 		git symbolic-ref refs/heads/symref >expect &&
    - 		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
    - 		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
     @@ t/t1400-update-ref.sh: do
      		test_cmp expect actual
      	'

    -+	test_expect_success "stdin ${type} symref-delete fails without
--no-deref" '
    ++	test_expect_success "stdin $type symref-delete fails without
--no-deref" '
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
    -+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type <stdin 2>err &&
     +		grep "fatal: symref-delete: cannot operate with deref mode" err
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete fails with no ref" '
    -+		create_stdin_buf ${type} "symref-delete " &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-delete fails with no ref" '
    ++		format_command $type "symref-delete " >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		grep "fatal: symref-delete: missing <ref>" err
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete fails with too
many arguments" '
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" "$a" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-delete fails with too
many arguments" '
    ++		format_command $type "symref-delete refs/heads/symref" "$a"
"$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		if test "$type" = "-z"
     +		then
     +			grep "fatal: unknown command: $a" err
    @@ t/t1400-update-ref.sh: do
     +		fi
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete fails with
wrong old value" '
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$m" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-delete fails with wrong
old value" '
    ++		format_command $type "symref-delete refs/heads/symref" "$m" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		grep "fatal: verifying symref target:
${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main"
err &&
     +		git symbolic-ref refs/heads/symref >expect &&
     +		echo $a >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete works with
right old value" '
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++	test_expect_success "stdin $type symref-delete works with right
old value" '
    ++		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		test_must_fail git rev-parse --verify -q refs/heads/symref
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete works with
empty old value" '
    -+		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "" &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++	test_expect_success "stdin $type symref-delete works with empty
old value" '
    ++		git symbolic-ref refs/heads/symref $a >stdin &&
    ++		format_command $type "symref-delete refs/heads/symref" "" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		test_must_fail git rev-parse --verify -q $b
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete succeeds for
dangling reference" '
    ++	test_expect_success "stdin $type symref-delete succeeds for
dangling reference" '
     +		test_must_fail git symbolic-ref refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref2"
"refs/heads/nonexistent" &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-delete refs/heads/symref2"
"refs/heads/nonexistent" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		test_must_fail git symbolic-ref -d refs/heads/symref2
     +	'
     +
4:  1038e96a44 ! 4:  9b71c9e07b update-ref: add support for
'symref-create' command
    @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      {
     -	if (!new_oid || is_null_oid(new_oid)) {
     -		strbuf_addf(err, "'%s' has a null OID", refname);
    ++	if (new_oid && new_target)
    ++		BUG("create called with both new_oid and new_target set");
     +	if ((!new_oid || is_null_oid(new_oid)) && !new_target) {
    -+		strbuf_addf(err, "'%s' has a null OID or no new target", refname);
    ++		strbuf_addf(err, "'%s' has neither a valid OID nor a target", refname);
      		return 1;
      	}
      	return ref_transaction_update(transaction, refname, new_oid,
    @@ t/t0600-reffiles-backend.sh: test_expect_success POSIXPERM 'git
reflog expire ho
      '

     +test_expect_success SYMLINKS 'symref transaction supports symlinks' '
    -+	test_when_finished "git symbolic-ref -d TESTSYMREFONE" &&
    ++	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
     +	git update-ref refs/heads/new @ &&
     +	test_config core.prefersymlinkrefs true &&
     +	cat >stdin <<-EOF &&
     +	start
    -+	symref-create TESTSYMREFONE refs/heads/new
    ++	symref-create TEST_SYMREF_HEAD refs/heads/new
     +	prepare
     +	commit
     +	EOF
     +	git update-ref --no-deref --stdin <stdin &&
    -+	test_path_is_symlink .git/TESTSYMREFONE &&
    -+	test "$(test_readlink .git/TESTSYMREFONE)" = refs/heads/new
    ++	test_path_is_symlink .git/TEST_SYMREF_HEAD &&
    ++	test "$(test_readlink .git/TEST_SYMREF_HEAD)" = refs/heads/new
     +'
     +
     +test_expect_success 'symref transaction supports false symlink config' '
    -+	test_when_finished "git symbolic-ref -d TESTSYMREFONE" &&
    ++	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
     +	git update-ref refs/heads/new @ &&
     +	test_config core.prefersymlinkrefs false &&
     +	cat >stdin <<-EOF &&
     +	start
    -+	symref-create TESTSYMREFONE refs/heads/new
    ++	symref-create TEST_SYMREF_HEAD refs/heads/new
     +	prepare
     +	commit
     +	EOF
     +	git update-ref --no-deref --stdin <stdin &&
    -+	test_path_is_file .git/TESTSYMREFONE &&
    -+	git symbolic-ref TESTSYMREFONE >actual &&
    ++	test_path_is_file .git/TEST_SYMREF_HEAD &&
    ++	git symbolic-ref TEST_SYMREF_HEAD >actual &&
     +	echo refs/heads/new >expect &&
     +	test_cmp expect actual
     +'
    @@ t/t1400-update-ref.sh: do
      		test_must_fail git symbolic-ref -d refs/heads/symref2
      	'

    -+	test_expect_success "stdin ${type} symref-create fails with too
many arguments" '
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref"
"$a" "$a" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-create fails with too
many arguments" '
    ++		format_command $type "symref-create refs/heads/symref" "$a"
"$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		if test "$type" = "-z"
     +		then
     +			grep "fatal: unknown command: $a" err
    @@ t/t1400-update-ref.sh: do
     +		fi
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-create fails with no target" '
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
    ++	test_expect_success "stdin $type symref-create fails with no target" '
    ++		format_command $type "symref-create refs/heads/symref" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-create fails with
empty target" '
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref" "" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
    ++	test_expect_success "stdin $type symref-create fails with empty target" '
    ++		format_command $type "symref-create refs/heads/symref" "" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-create works" '
    ++	test_expect_success "stdin $type symref-create works" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref"
"$a" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-create refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/heads/symref >expect &&
     +		echo $a >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-create works with --no-deref" '
    ++	test_expect_success "stdin $type symref-create works with --no-deref" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" &&
    -+		git update-ref --stdin ${type} <stdin 2>err
    ++		format_command $type "symref-create refs/heads/symref" "$a" &&
    ++		git update-ref --stdin $type <stdin 2>err
     +	'
     +
    -+	test_expect_success "stdin ${type} create dangling symref ref works" '
    ++	test_expect_success "stdin $type create dangling symref ref works" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref"
"refs/heads/unkown" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-create refs/heads/symref"
"refs/heads/unkown" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/heads/symref >expect &&
     +		echo refs/heads/unkown >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-create does not
create reflogs by default" '
    ++	test_expect_success "stdin $type symref-create does not create
reflogs by default" '
     +		test_when_finished "git symbolic-ref -d refs/symref" &&
    -+		create_stdin_buf ${type} "symref-create refs/symref" "$a" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-create refs/symref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/symref >expect &&
     +		echo $a >actual &&
     +		test_cmp expect actual &&
     +		test_must_fail git reflog exists refs/symref
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-create reflogs with
--create-reflog" '
    ++	test_expect_success "stdin $type symref-create reflogs with
--create-reflog" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref"
"$a" >stdin &&
    -+		git update-ref --create-reflog --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-create refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --create-reflog --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/heads/symref >expect &&
     +		echo $a >actual &&
     +		test_cmp expect actual &&
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook
gets all queued symr
      	prepare
      	commit
      	EOF
    +
    + ## t/t5605-clone-local.sh ##
    +@@ t/t5605-clone-local.sh: test_expect_success REFFILES 'local
clone from repo with corrupt refs fails grac
    + 	echo a >corrupt/.git/refs/heads/topic &&
    +
    + 	test_must_fail git clone corrupt working 2>err &&
    +-	grep "has a null OID" err
    ++	grep "has neither a valid OID nor a target" err
    + '
    +
    + test_done
5:  78dd51b65f = 5:  a9b1a31756 reftable: pick either 'oid' or
'target' for new updates
6:  562e061063 ! 6:  1bbbe86743 update-ref: add support for
'symref-update' command
    @@ Commit message
         OID before the update. This by extension also means that this when a
         zero <old-oid> is provided, it ensures that the ref didn't
exist before.

    +    The divergence in syntax from the regular `update` command is
because if
    +    we don't use a `(ref | oid)` prefix for the old_value, then there is
    +    ambiguity around if the value provided should be treated as an oid or a
    +    reference. This is more so the reason, because we allow anything
    +    committish to be provided as an oid.
    +
         The command allows users to perform symbolic ref updates within a
         transaction. This provides atomicity and allows users to perform a set
         of operations together.

    -    This command will also support deref mode, to ensure that we can update
    +    This command supports deref mode, to ensure that we can update
         dereferenced regular refs to symrefs.

         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    @@ builtin/update-ref.c: static char *parse_next_refname(const char **next)
     +		return strbuf_detach(&arg, NULL);
     +	return NULL;
     +}
    -+

      /*
       * The value being parsed is <old-oid> (as opposed to <new-oid>; the
    @@ builtin/update-ref.c: static void parse_cmd_update(struct
ref_transaction *trans
     +	char *old_target = NULL;
     +	struct strbuf err = STRBUF_INIT;
     +	struct object_id old_oid;
    -+	int have_old = 0;
    ++	int have_old_oid = 0;
     +
     +	refname = parse_refname(&next);
     +	if (!refname)
    @@ builtin/update-ref.c: static void parse_cmd_update(struct
ref_transaction *trans
     +
     +	old_arg = parse_next_arg(&next);
     +	if (old_arg) {
    -+		old_target = parse_next_refname(&next);
    ++		old_target = parse_next_arg(&next);
     +		if (!old_target)
     +			die("symref-update %s: expected old value", refname);
     +
    -+		if (!strcmp(old_arg, "oid") &&
    -+		    !repo_get_oid(the_repository, old_target, &old_oid)) {
    ++		if (!strcmp(old_arg, "oid")) {
    ++			if (repo_get_oid(the_repository, old_target, &old_oid))
    ++				die("symref-update %s: invalid oid: %s", refname, old_target);
    ++
     +			old_target = NULL;
    -+			have_old = 1;
    -+		} else if (strcmp(old_arg, "ref"))
    ++			have_old_oid = 1;
    ++		} else if (!strcmp(old_arg, "ref")) {
    ++			if (check_refname_format(old_target, REFNAME_ALLOW_ONELEVEL))
    ++				die("symref-update %s: invalid ref: %s", refname, old_target);
    ++		} else {
     +			die("symref-update %s: invalid arg '%s' for old value",
refname, old_arg);
    ++		}
     +	}
     +
     +	if (*next != line_termination)
     +		die("symref-update %s: extra input: %s", refname, next);
     +
     +	if (ref_transaction_update(transaction, refname, NULL,
    -+				   have_old ? &old_oid : NULL,
    ++				   have_old_oid ? &old_oid : NULL,
     +				   new_target, old_target,
    -+				   update_flags |= create_reflog_flag,
    ++				   update_flags | create_reflog_flag,
     +				   msg, &err))
     +		die("%s", err.buf);
     +
    @@ t/t1400-update-ref.sh: do
      		git reflog exists refs/heads/symref
      	'

    -+	test_expect_success "stdin ${type} symref-update fails with too
many arguments" '
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" "ref" "$a" "$a" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-update fails with too
many arguments" '
    ++		format_command $type "symref-update refs/heads/symref" "$a"
"ref" "$a" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		if test "$type" = "-z"
     +		then
     +			grep "fatal: unknown command: $a" err
    @@ t/t1400-update-ref.sh: do
     +		fi
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update fails with
wrong old value argument" '
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" "foo" "$a" "$a" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-update fails with wrong
old value argument" '
    ++		format_command $type "symref-update refs/heads/symref" "$a"
"foo" "$a" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		grep "fatal: symref-update refs/heads/symref: invalid arg
${SQ}foo${SQ} for old value" err
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update creates with
zero old value" '
    ++	test_expect_success "stdin $type symref-update creates with
zero old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" "oid" "$Z" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a"
"oid" "$Z" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update creates with
no old value" '
    ++	test_expect_success "stdin $type symref-update creates with no
old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update creates dangling" '
    ++	test_expect_success "stdin $type symref-update creates dangling" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		test_must_fail git rev-parse refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"refs/heads/nonexistent" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref"
"refs/heads/nonexistent" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo refs/heads/nonexistent >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update fails with
wrong old value" '
    ++	test_expect_success "stdin $type symref-update fails with wrong
old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$m" "ref" "$b" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++		format_command $type "symref-update refs/heads/symref" "$m"
"ref" "$b" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		grep "fatal: verifying symref target:
${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err &&
     +		test_must_fail git rev-parse --verify -q $c
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update updates dangling ref" '
    ++	test_expect_success "stdin $type symref-update updates dangling ref" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		test_must_fail git rev-parse refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update updates
dangling ref with old value" '
    ++	test_expect_success "stdin $type symref-update updates dangling
ref with old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		test_must_fail git rev-parse refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" "ref" "refs/heads/nonexistent" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a"
"ref" "refs/heads/nonexistent" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update fails update
dangling ref with wrong old value" '
    ++	test_expect_success "stdin $type symref-update fails update
dangling ref with wrong old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		test_must_fail git rev-parse refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" "ref" "refs/heads/wrongref" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a"
"ref" "refs/heads/wrongref" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
     +		echo refs/heads/nonexistent >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update works with
right old value" '
    ++	test_expect_success "stdin $type symref-update works with right
old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$m" "ref" "$a" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$m"
"ref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $m >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update works with no
old value" '
    ++	test_expect_success "stdin $type symref-update works with no old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$m" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$m" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $m >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update fails with
empty old ref-target" '
    ++	test_expect_success "stdin $type symref-update fails with empty
old ref-target" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$m" "ref" "" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$m"
"ref" "" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update creates (with deref)" '
    ++	test_expect_success "stdin $type symref-update creates (with deref)" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" >stdin &&
    -+		git update-ref --stdin ${type} <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --stdin $type <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref --no-recurse refs/heads/symref >actual &&
     +		test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		grep "$Z $(git rev-parse $a)" actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update regular ref to
symref with correct old-oid" '
    ++	test_expect_success "stdin $type symref-update regular ref to
symref with correct old-oid" '
     +		test_when_finished "git symbolic-ref -d --no-recurse
refs/heads/regularref" &&
     +		git update-ref --no-deref refs/heads/regularref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/regularref"
"$a" "oid" "$(git rev-parse $a)" >stdin &&
    -+		git update-ref --stdin ${type} <stdin &&
    ++		format_command $type "symref-update refs/heads/regularref"
"$a" "oid" "$(git rev-parse $a)" >stdin &&
    ++		git update-ref --stdin $type <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
     +		test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update regular ref to
symref fails with wrong old-oid" '
    ++	test_expect_success "stdin $type symref-update regular ref to
symref fails with wrong old-oid" '
    ++		test_when_finished "git update-ref -d refs/heads/regularref" &&
    ++		git update-ref --no-deref refs/heads/regularref $a &&
    ++		format_command $type "symref-update refs/heads/regularref"
"$a" "oid" "$(git rev-parse refs/heads/target2)" >stdin &&
    ++		test_must_fail git update-ref --stdin $type <stdin 2>err &&
    ++		grep "fatal: cannot lock ref ${SQ}refs/heads/regularref${SQ}:
is at $(git rev-parse $a) but expected $(git rev-parse
refs/heads/target2)" err &&
    ++		echo $(git rev-parse $a) >expect &&
    ++		git rev-parse refs/heads/regularref >actual &&
    ++		test_cmp expect actual
    ++	'
    ++
    ++	test_expect_success "stdin $type symref-update regular ref to
symref fails with invalid old-oid" '
     +		test_when_finished "git update-ref -d refs/heads/regularref" &&
     +		git update-ref --no-deref refs/heads/regularref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/regularref"
"$a" "oid" "$(git rev-parse refs/heads/target2)" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		format_command $type "symref-update refs/heads/regularref"
"$a" "oid" "not-a-ref-oid" >stdin &&
    ++		test_must_fail git update-ref --stdin $type <stdin 2>err &&
    ++		grep "fatal: symref-update refs/heads/regularref: invalid oid:
not-a-ref-oid" err &&
     +		echo $(git rev-parse $a) >expect &&
     +		git rev-parse refs/heads/regularref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update existing
symref with zero old-oid" '
    ++	test_expect_success "stdin $type symref-update existing symref
with zero old-oid" '
     +		test_when_finished "git symbolic-ref -d --no-recurse
refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref refs/heads/target2 &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" "oid" "$Z" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		format_command $type "symref-update refs/heads/symref" "$a"
"oid" "$Z" >stdin &&
    ++		test_must_fail git update-ref --stdin $type <stdin 2>err &&
     +		grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}:
reference already exists" err &&
     +		echo refs/heads/target2 >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update regular ref to
symref (with deref)" '
    ++	test_expect_success "stdin $type symref-update regular ref to
symref (with deref)" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		test_when_finished "git update-ref -d --no-deref refs/heads/symref2" &&
     +		git update-ref refs/heads/symref2 $a &&
     +		git symbolic-ref --no-recurse refs/heads/symref refs/heads/symref2 &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref"
"$a" >stdin &&
    -+		git update-ref ${type} --stdin <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a" >stdin &&
    ++		git update-ref $type --stdin <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref --no-recurse refs/heads/symref2 >actual &&
     +		test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update regular ref to symref" '
    ++	test_expect_success "stdin $type symref-update regular ref to symref" '
     +		test_when_finished "git symbolic-ref -d --no-recurse
refs/heads/regularref" &&
     +		git update-ref --no-deref refs/heads/regularref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/regularref"
"$a" >stdin &&
    -+		git update-ref ${type} --stdin <stdin &&
    ++		format_command $type "symref-update refs/heads/regularref"
"$a" >stdin &&
    ++		git update-ref $type --stdin <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
     +		test_cmp expect actual &&

--0000000000001268f30619210ac4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9465c49113f4de65_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aUFpqNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK213Qy8wY2FpQnMwemlISEEwTU1MQUEySnVHNEljNQp5NjNBUmFXTHVn
VnNMc1Z0TGs4ZXBORXg1cEZXWmtOU1NGN2xiZTh4Mlp1TldMR1A4aW5aRkVQZUtxbU5NTFhoCkor
eFpGUGk3L1RRM0tLbXMwVUN1aUViaHNEcVNNRkovRjZCV1VXNG9aa21VQWRCQU1UQlFFbUY4SGtN
aUkxSjYKQ2xQc0N3cHQwWFV1R2VqNVdoWUU3TWxpQ3hkVE52NS9Za2pFN3U3OWJpd0haZGlVKys3
c2dDOGxnSDNlTzFLbwo4WVk3MnhnbVZLbFczRXpLMzE4SmppYmVTSUwwelcwUGJWR0liby9RZUFX
eTJVamJFaXdvNGhMZW9tS0xIcmpRCmoyeEkra0hySHgrekxiY2Y2ckJNbWI0YnVkYzBuY1NUUmN0
VEl6U1lTRDdtMzdoK3hhd3JWSkZwVlVUQmFWTXAKWGhLdktqa1o1ZUFRZlJoRHdRejZXMXV0eGtN
OWZPNVAwN2RsTlRURHh6MHlIdVRUVUFGMldtOFN3NmM5UDd2bApQbzlvTHAyYm1rOGVnYWZtNnp5
QU9DUi9IdnlTTFVYUVZxc3FWS25BZitubjhFeTZuWjBrRnB3SHNXZWRvbUg2ClhKYnBCb3BBYVo0
aGd2UEZFbWJ4SjZoN0pSQnRCMFpYMTZ0bTFucz0KPTJ6dngKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001268f30619210ac4--
