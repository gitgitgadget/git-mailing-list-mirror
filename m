Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C380055
	for <git@vger.kernel.org>; Wed, 22 May 2024 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368615; cv=none; b=W/u/VoIrlj7G+2lUi/axfSGO0lWVWFVy0NXwh80QnWPaRqIc2kGG55dnY7aH8TR+cr/MRtjrR+pFIvmL130LJvqAHZyol17zswO58u2HnHsZRs61eQ9B2k5H5oSVYHoSb0Y0cNUEV9seOTRf0qVNHmEcT9CB1vVP8cl/y/+jldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368615; c=relaxed/simple;
	bh=uNLAcZfRHAPM9gdO8AUygyRb+Lt7hOy7MfFHPoYmK84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfw2licJwuirG31HdhepBetX/rNWlXp0JqTU0s6XzQj0EBZ6jeLY+zaN3fPb2HSzX2/x08rIZJSYamRdmqxABUx+JsfVlUv/1W6n/0sMFchGHqD6pxhEXKWVOj0AS6D37PVLu36uDsAdU5K4c+O+9hpKqNFk8LkaE1oL7a1QW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DovKJkvr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DovKJkvr"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572b37afd73so11080920a12.2
        for <git@vger.kernel.org>; Wed, 22 May 2024 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716368610; x=1716973410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OnQruf4ORA7/v9+PBPCNoeidT0rhdtYjj/ZYrbBzVo=;
        b=DovKJkvrRm6+I1yyyniljcL9sICqo1dFR0Axd8Qx7od1t9xa/HZMVq0IQ3CvPIrDdG
         yHFv72fQ0nISwyR+KzvjEDhQOdvXHW8c0sFDJ/3RVDyaA91O+moRcUCDkpsWwzujT0h5
         N+Ek1Ub3h/BsxlWBQwvZuryY1ka53R4X4+gcmUfhM5VVBsx+COP4mzOO6OTlhDywdCq1
         uSAxX5HDwSFsJswitzPgP1khC0rnloWRPtTwaBO1381eGsdFV+B6rxEQCU2RU+yv4vRv
         ThzmJm+6wAjZlXfFjxRfnCyO+6NCOYkN4fPvywC7HF6oUkLcehYPO67paic8X1p+L5zf
         57+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368610; x=1716973410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OnQruf4ORA7/v9+PBPCNoeidT0rhdtYjj/ZYrbBzVo=;
        b=DgOb8JWPtB6RKQo3Y77w/nZXSgq4ee3O2iwm0d9jtZD+325WvdKHmgmaAXe+oz/Clw
         uNaBe3f2c4qJGnUQ0NSf4bDXhquAjFIMK3YQvQREiXaA1v1C07+tU9d3R+27eXLzecKR
         FuBFuqrYpcsUhs6iCDvqodNTYH2QYrv6roHCr2CoSAyXhD5ybshhATmKyEPCu6QjKRw5
         Cp5Jz1tit74S800wkMjG4HnM0MTh6Cx2zOb0Lr/i2k5B+lplpPDkJ9FGF8gxyBbzWAp5
         oY7uxIPCL9ULWKZPfSfiZQriWZY7wtFy3hvd1Hh9d8lNM2+R07N2pifdipMuByNj3JuK
         9nDA==
X-Gm-Message-State: AOJu0YwlQgYyD7y8BXIj6jrdUVDpmQoJ02zNwvXSUkRz5cLsS/eTKKO4
	JTTNbfMaGzlnDibwE2axHkUzsHMkVztOBRSl5RGutkas1hJLXToX
X-Google-Smtp-Source: AGHT+IE+Id2znl0GpRnOxWBhT3P46XRPmDTEekNvVewgxpP50EngOP/+DyJm0P2zDZMdl7Vmqfensw==
X-Received: by 2002:a50:9349:0:b0:571:fc6b:966c with SMTP id 4fb4d7f45d1cf-57832a2678dmr752440a12.13.1716368609762;
        Wed, 22 May 2024 02:03:29 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:414d:df4b:1d67:e754])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509d459desm8281354a12.61.2024.05.22.02.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:03:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 0/6] update-ref: add symref support for --stdin
Date: Wed, 22 May 2024 11:03:20 +0200
Message-ID: <20240522090326.1268326-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514124411.1037019-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'update-ref' command is used to update refs using transactions. The
command allows users to also utilize a '--stdin' mode to provide a
batch of sub-commands which can be processed in a transaction.

Currently, the sub-commands involve {verify, delete, create, update}
and they allow users to work with regular refs in the repository. To
work with symrefs, users only have the option of using
'git-symbolic-ref', which doesn't provide transaction support to the
users eventhough it uses the same behind the hood. 

Recently, we modified the reference backend to add symref support,
following which, 'git-symbolic-ref' also uses the transaction backend.
But, it doesn't expose this to the user. To allow users to work with
symrefs via transaction, this series adds support for new sub-commands
{symrer-verify, symref-delete, symref-create, symref-update} to the
'--stdin' mode of update-ref. These complement the existing
sub-commands.

The patches 1, 5 fix small issues in the reference backends. The other
patches 2, 3, 4 & 6, each add one of the new sub-commands.

The series is based off master, with 'kn/ref-transaction-symref' merged
in. There seem to be no conflicts with 'next' or 'seen'.

There was some discussion [1] also about adding `old_target` support to
the existing `update` command. I think its worthwhile to do this with
some tests cleanup, will follow that up as a separate series.  

Changes since v1:
* Rename the function `ref_update_ref_must_exist` to `ref_update_expects_existing_old_ref`
to better clarify its usage.
* Add checks in all the `ref_transaction_*()` functions to check if both
_target_ and _oid_ values are set.
* Clean up the tests
  - Change `create_stdin_buf` to `format_command` and allow clients to
  decide the destination.
  - Remove unecessary curly braces.
  - Rename TESTSYMREFONE to TEST_SYMREF_HEAD to stay compatible with our
  new definitions of refs and pseudorefs.
* Add more explanation in the commit message around the deviation of syntax
for the `symref-update` command.

[1]: https://lore.kernel.org/r/CAOLa=ZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft1Wf9kAX=_bw@mail.gmail.com

Range diff vs v1:
 1:  1bc4cc3fc4 =  1:  1bc4cc3fc4 refs: accept symref values in `ref_transaction_update()`
 2:  57d0b1e2ea =  2:  57d0b1e2ea files-backend: extract out `create_symref_lock()`
 3:  a8ae923f85 =  3:  a8ae923f85 refs: support symrefs in 'reference-transaction' hook
 4:  e9965ba477 =  4:  e9965ba477 refs: move `original_update_refname` to 'refs.c'
 5:  644daf7785 =  5:  644daf7785 refs: add support for transactional symref updates
 6:  300b38e46f =  6:  300b38e46f refs: use transaction in `refs_create_symref()`
 7:  f151dfe3c9 =  7:  f151dfe3c9 refs: rename `refs_create_symref()` to `refs_update_symref()`
 8:  4865707bda =  8:  4865707bda refs: remove `create_symref` and associated dead code
 9:  4cb67dce7c !  9:  2bbdeff798 refs: create and use `ref_update_ref_must_exist()`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: create and use `ref_update_ref_must_exist()`
    +    refs: create and use `ref_update_expects_existing_old_ref()`
     
         The files and reftable backend, need to check if a ref must exist, so
         that the required validation can be done. A ref must exist only when the
    @@ Commit message
         path. As we introduce the 'symref-verify' command in the upcoming
         commits, it is important to fix this.
     
    -    So let's export this to a function called `ref_update_ref_must_exist()`
    -    and expose it internally via 'refs-internal.h'.
    +    So let's export this to a function called
    +    `ref_update_expects_existing_old_ref()` and expose it internally via
    +    'refs-internal.h'.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct ref_update
      	return -1;
      }
     +
    -+int ref_update_ref_must_exist(struct ref_update *update)
    ++int ref_update_expects_existing_old_ref(struct ref_update *update)
     +{
     +	return (update->flags & REF_HAVE_OLD) &&
     +		(!is_null_oid(&update->old_oid) || update->old_target);
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      	struct strbuf referent = STRBUF_INIT;
     -	int mustexist = (update->flags & REF_HAVE_OLD) &&
     -		!is_null_oid(&update->old_oid);
    -+	int mustexist = ref_update_ref_must_exist(update);
    ++	int mustexist = ref_update_expects_existing_old_ref(update);
      	int ret = 0;
      	struct ref_lock *lock;
      
    @@ refs/refs-internal.h: int ref_update_has_null_new_value(struct ref_update *updat
     + * Check if the ref must exist, this means that the old_oid or
     + * old_target is non NULL.
     + */
    -+int ref_update_ref_must_exist(struct ref_update *update);
    ++int ref_update_expects_existing_old_ref(struct ref_update *update);
     +
      #endif /* REFS_REFS_INTERNAL_H */
     
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		if (ret < 0)
      			goto done;
     -		if (ret > 0 && (!(u->flags & REF_HAVE_OLD) || is_null_oid(&u->old_oid))) {
    -+		if (ret > 0 && !ref_update_ref_must_exist(u)) {
    ++		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
      			/*
      			 * The reference does not exist, and we either have no
      			 * old object ID or expect the reference to not exist.
10:  9fda13b468 ! 10:  f509066cab update-ref: add support for 'symref-verify' command
    @@ Commit message
         point to an object and not a ref and the regular 'verify' command can be
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
    @@ t/t1400-update-ref.sh: test_expect_success PIPE 'transaction flushes status upda
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
    -+	test_expect_success "stdin ${type} symref-verify fails without --no-deref" '
    ++	test_expect_success "stdin $type symref-verify fails without --no-deref" '
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
    -+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		format_command $type "symref-verify refs/heads/symref" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type <stdin 2>err &&
     +		grep "fatal: symref-verify: cannot operate with deref mode" err
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify fails with too many arguments" '
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" "$a" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err  &&
    ++	test_expect_success "stdin $type symref-verify fails with too many arguments" '
    ++		format_command $type "symref-verify refs/heads/symref" "$a" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err  &&
     +		if test "$type" = "-z"
     +		then
     +			grep "fatal: unknown command: $a" err
    @@ t/t1400-update-ref.sh: test_expect_success PIPE 'transaction flushes status upda
     +		fi
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify succeeds for correct value" '
    ++	test_expect_success "stdin $type symref-verify succeeds for correct value" '
     +		git symbolic-ref refs/heads/symref >expect &&
     +		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
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
    -+	test_expect_success "stdin ${type} symref-verify no value is treated as zero value" '
    ++	test_expect_success "stdin $type symref-verify fails with no value" '
     +		git symbolic-ref refs/heads/symref >expect &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
    ++		format_command $type "symref-verify refs/heads/symref" "" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify succeeds for dangling reference" '
    ++	test_expect_success "stdin $type symref-verify succeeds for dangling reference" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
     +		test_must_fail git symbolic-ref refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref2" "refs/heads/nonexistent" &&
    -+		git update-ref --stdin ${type} --no-deref <stdin
    ++		format_command $type "symref-verify refs/heads/symref2" "refs/heads/nonexistent" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-verify fails for missing reference" '
    ++	test_expect_success "stdin $type symref-verify fails for missing reference" '
     +		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/missing" "refs/heads/unknown" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++		format_command $type "symref-verify refs/heads/missing" "refs/heads/unknown" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		grep "fatal: cannot lock ref ${SQ}refs/heads/missing${SQ}: unable to resolve reference ${SQ}refs/heads/missing${SQ}" err &&
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
    -+	test_expect_success "stdin ${type} symref-verify fails for mistaken null value" '
    ++	test_expect_success "stdin $type symref-verify fails for mistaken null value" '
     +		git symbolic-ref refs/heads/symref >expect &&
    -+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$Z" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-verify refs/heads/symref" "$Z" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
11:  d07031827b ! 11:  a11f4c1e48 update-ref: add support for 'symref-delete' command
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
    --	test_expect_success "stdin ${type} symref-verify no value is treated as zero value" '
    -+	test_expect_success "stdin ${type} symref-verify fails with no value" '
    - 		git symbolic-ref refs/heads/symref >expect &&
    - 		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
    - 		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
     @@ t/t1400-update-ref.sh: do
      		test_cmp expect actual
      	'
      
    -+	test_expect_success "stdin ${type} symref-delete fails without --no-deref" '
    ++	test_expect_success "stdin $type symref-delete fails without --no-deref" '
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
    -+	test_expect_success "stdin ${type} symref-delete fails with too many arguments" '
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" "$a" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-delete fails with too many arguments" '
    ++		format_command $type "symref-delete refs/heads/symref" "$a" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		if test "$type" = "-z"
     +		then
     +			grep "fatal: unknown command: $a" err
    @@ t/t1400-update-ref.sh: do
     +		fi
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete fails with wrong old value" '
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$m" &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-delete fails with wrong old value" '
    ++		format_command $type "symref-delete refs/heads/symref" "$m" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err &&
     +		git symbolic-ref refs/heads/symref >expect &&
     +		echo $a >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete works with right old value" '
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++	test_expect_success "stdin $type symref-delete works with right old value" '
    ++		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		test_must_fail git rev-parse --verify -q refs/heads/symref
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete works with empty old value" '
    -+		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "" &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++	test_expect_success "stdin $type symref-delete works with empty old value" '
    ++		git symbolic-ref refs/heads/symref $a >stdin &&
    ++		format_command $type "symref-delete refs/heads/symref" "" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		test_must_fail git rev-parse --verify -q $b
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-delete succeeds for dangling reference" '
    ++	test_expect_success "stdin $type symref-delete succeeds for dangling reference" '
     +		test_must_fail git symbolic-ref refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-delete refs/heads/symref2" "refs/heads/nonexistent" &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-delete refs/heads/symref2" "refs/heads/nonexistent" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		test_must_fail git symbolic-ref -d refs/heads/symref2
     +	'
     +
12:  1038e96a44 ! 12:  9b71c9e07b update-ref: add support for 'symref-create' command
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
    @@ t/t0600-reffiles-backend.sh: test_expect_success POSIXPERM 'git reflog expire ho
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
      
    -+	test_expect_success "stdin ${type} symref-create fails with too many arguments" '
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" "$a" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-create fails with too many arguments" '
    ++		format_command $type "symref-create refs/heads/symref" "$a" "$a" >stdin &&
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
    -+	test_expect_success "stdin ${type} symref-create fails with empty target" '
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
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
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
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref" "refs/heads/unkown" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-create refs/heads/symref" "refs/heads/unkown" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/heads/symref >expect &&
     +		echo refs/heads/unkown >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-create does not create reflogs by default" '
    ++	test_expect_success "stdin $type symref-create does not create reflogs by default" '
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
    -+	test_expect_success "stdin ${type} symref-create reflogs with --create-reflog" '
    ++	test_expect_success "stdin $type symref-create reflogs with --create-reflog" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
    -+		git update-ref --create-reflog --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-create refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --create-reflog --stdin $type --no-deref <stdin &&
     +		git symbolic-ref refs/heads/symref >expect &&
     +		echo $a >actual &&
     +		test_cmp expect actual &&
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook gets all queued symr
      	prepare
      	commit
      	EOF
    +
    + ## t/t5605-clone-local.sh ##
    +@@ t/t5605-clone-local.sh: test_expect_success REFFILES 'local clone from repo with corrupt refs fails grac
    + 	echo a >corrupt/.git/refs/heads/topic &&
    + 
    + 	test_must_fail git clone corrupt working 2>err &&
    +-	grep "has a null OID" err
    ++	grep "has neither a valid OID nor a target" err
    + '
    + 
    + test_done
13:  78dd51b65f = 13:  a9b1a31756 reftable: pick either 'oid' or 'target' for new updates
14:  562e061063 ! 14:  1bbbe86743 update-ref: add support for 'symref-update' command
    @@ Commit message
         OID before the update. This by extension also means that this when a
         zero <old-oid> is provided, it ensures that the ref didn't exist before.
     
    +    The divergence in syntax from the regular `update` command is because if
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
    @@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *trans
     +	char *old_target = NULL;
     +	struct strbuf err = STRBUF_INIT;
     +	struct object_id old_oid;
    -+	int have_old = 0;
    ++	int have_old_oid = 0;
     +
     +	refname = parse_refname(&next);
     +	if (!refname)
    @@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *trans
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
     +			die("symref-update %s: invalid arg '%s' for old value", refname, old_arg);
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
      
    -+	test_expect_success "stdin ${type} symref-update fails with too many arguments" '
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "ref" "$a" "$a" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-update fails with too many arguments" '
    ++		format_command $type "symref-update refs/heads/symref" "$a" "ref" "$a" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		if test "$type" = "-z"
     +		then
     +			grep "fatal: unknown command: $a" err
    @@ t/t1400-update-ref.sh: do
     +		fi
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update fails with wrong old value argument" '
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "foo" "$a" "$a" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++	test_expect_success "stdin $type symref-update fails with wrong old value argument" '
    ++		format_command $type "symref-update refs/heads/symref" "$a" "foo" "$a" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		grep "fatal: symref-update refs/heads/symref: invalid arg ${SQ}foo${SQ} for old value" err
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update creates with zero old value" '
    ++	test_expect_success "stdin $type symref-update creates with zero old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "oid" "$Z" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a" "oid" "$Z" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update creates with no old value" '
    ++	test_expect_success "stdin $type symref-update creates with no old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
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
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "refs/heads/nonexistent" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "refs/heads/nonexistent" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo refs/heads/nonexistent >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update fails with wrong old value" '
    ++	test_expect_success "stdin $type symref-update fails with wrong old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" "ref" "$b" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++		format_command $type "symref-update refs/heads/symref" "$m" "ref" "$b" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
     +		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err &&
     +		test_must_fail git rev-parse --verify -q $c
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update updates dangling ref" '
    ++	test_expect_success "stdin $type symref-update updates dangling ref" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		test_must_fail git rev-parse refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update updates dangling ref with old value" '
    ++	test_expect_success "stdin $type symref-update updates dangling ref with old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		test_must_fail git rev-parse refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "ref" "refs/heads/nonexistent" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a" "ref" "refs/heads/nonexistent" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update fails update dangling ref with wrong old value" '
    ++	test_expect_success "stdin $type symref-update fails update dangling ref with wrong old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		test_must_fail git rev-parse refs/heads/nonexistent &&
     +		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "ref" "refs/heads/wrongref" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$a" "ref" "refs/heads/wrongref" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
     +		echo refs/heads/nonexistent >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update works with right old value" '
    ++	test_expect_success "stdin $type symref-update works with right old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" "ref" "$a" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$m" "ref" "$a" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $m >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update works with no old value" '
    ++	test_expect_success "stdin $type symref-update works with no old value" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" >stdin &&
    -+		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$m" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin &&
     +		echo $m >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update fails with empty old ref-target" '
    ++	test_expect_success "stdin $type symref-update fails with empty old ref-target" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" "ref" "" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    ++		format_command $type "symref-update refs/heads/symref" "$m" "ref" "" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update creates (with deref)" '
    ++	test_expect_success "stdin $type symref-update creates (with deref)" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
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
    -+	test_expect_success "stdin ${type} symref-update regular ref to symref with correct old-oid" '
    ++	test_expect_success "stdin $type symref-update regular ref to symref with correct old-oid" '
     +		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
     +		git update-ref --no-deref refs/heads/regularref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/regularref" "$a" "oid" "$(git rev-parse $a)" >stdin &&
    -+		git update-ref --stdin ${type} <stdin &&
    ++		format_command $type "symref-update refs/heads/regularref" "$a" "oid" "$(git rev-parse $a)" >stdin &&
    ++		git update-ref --stdin $type <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
     +		test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update regular ref to symref fails with wrong old-oid" '
    ++	test_expect_success "stdin $type symref-update regular ref to symref fails with wrong old-oid" '
    ++		test_when_finished "git update-ref -d refs/heads/regularref" &&
    ++		git update-ref --no-deref refs/heads/regularref $a &&
    ++		format_command $type "symref-update refs/heads/regularref" "$a" "oid" "$(git rev-parse refs/heads/target2)" >stdin &&
    ++		test_must_fail git update-ref --stdin $type <stdin 2>err &&
    ++		grep "fatal: cannot lock ref ${SQ}refs/heads/regularref${SQ}: is at $(git rev-parse $a) but expected $(git rev-parse refs/heads/target2)" err &&
    ++		echo $(git rev-parse $a) >expect &&
    ++		git rev-parse refs/heads/regularref >actual &&
    ++		test_cmp expect actual
    ++	'
    ++
    ++	test_expect_success "stdin $type symref-update regular ref to symref fails with invalid old-oid" '
     +		test_when_finished "git update-ref -d refs/heads/regularref" &&
     +		git update-ref --no-deref refs/heads/regularref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/regularref" "$a" "oid" "$(git rev-parse refs/heads/target2)" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		format_command $type "symref-update refs/heads/regularref" "$a" "oid" "not-a-ref-oid" >stdin &&
    ++		test_must_fail git update-ref --stdin $type <stdin 2>err &&
    ++		grep "fatal: symref-update refs/heads/regularref: invalid oid: not-a-ref-oid" err &&
     +		echo $(git rev-parse $a) >expect &&
     +		git rev-parse refs/heads/regularref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update existing symref with zero old-oid" '
    ++	test_expect_success "stdin $type symref-update existing symref with zero old-oid" '
     +		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/symref" &&
     +		git symbolic-ref refs/heads/symref refs/heads/target2 &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "oid" "$Z" >stdin &&
    -+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		format_command $type "symref-update refs/heads/symref" "$a" "oid" "$Z" >stdin &&
    ++		test_must_fail git update-ref --stdin $type <stdin 2>err &&
     +		grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}: reference already exists" err &&
     +		echo refs/heads/target2 >expect &&
     +		git symbolic-ref refs/heads/symref >actual &&
     +		test_cmp expect actual
     +	'
     +
    -+	test_expect_success "stdin ${type} symref-update regular ref to symref (with deref)" '
    ++	test_expect_success "stdin $type symref-update regular ref to symref (with deref)" '
     +		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
     +		test_when_finished "git update-ref -d --no-deref refs/heads/symref2" &&
     +		git update-ref refs/heads/symref2 $a &&
     +		git symbolic-ref --no-recurse refs/heads/symref refs/heads/symref2 &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
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
     +		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
     +		git update-ref --no-deref refs/heads/regularref $a &&
    -+		create_stdin_buf ${type} "symref-update refs/heads/regularref" "$a" >stdin &&
    -+		git update-ref ${type} --stdin <stdin &&
    ++		format_command $type "symref-update refs/heads/regularref" "$a" >stdin &&
    ++		git update-ref $type --stdin <stdin &&
     +		echo $a >expect &&
     +		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
     +		test_cmp expect actual &&

Karthik Nayak (6):
  refs: create and use `ref_update_expects_existing_old_ref()`
  update-ref: add support for 'symref-verify' command
  update-ref: add support for 'symref-delete' command
  update-ref: add support for 'symref-create' command
  reftable: pick either 'oid' or 'target' for new updates
  update-ref: add support for 'symref-update' command

 Documentation/git-update-ref.txt |  25 ++
 builtin/clone.c                  |   2 +-
 builtin/fetch.c                  |   2 +-
 builtin/receive-pack.c           |   3 +-
 builtin/update-ref.c             | 235 ++++++++++++++++-
 refs.c                           |  40 ++-
 refs.h                           |   6 +-
 refs/files-backend.c             |   3 +-
 refs/refs-internal.h             |   6 +
 refs/reftable-backend.c          |   7 +-
 t/t0600-reffiles-backend.sh      |  32 +++
 t/t1400-update-ref.sh            | 416 ++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh |  54 ++++
 t/t5605-clone-local.sh           |   2 +-
 14 files changed, 799 insertions(+), 34 deletions(-)

-- 
2.43.GIT

