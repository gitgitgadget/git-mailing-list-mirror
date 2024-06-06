Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3C194C61
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671797; cv=none; b=ixxgXibP3nkjv/Ey62TqtIuv0ZWI3c2bJ98b8jJfyA2T2n+eGs1je3Ef7xIe8ZOJoofkRmSYfhrI8ch6vzm2+m/i5OBwpNoMHqYsbSfUv2vwmuh+15MmQOadty4xBooEafCGyvcZ3qlR2VTpzuXs3nKhm/xsRAPztmsovrwAWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671797; c=relaxed/simple;
	bh=y5zmjLOljfdOKQ6ZIrUna/wrBC9tBf4CuJdS/ZHd8ys=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 Cc:Content-Type; b=lnCNlzUaSldRLsD9ZA72O4jFSXIJV7kWk1hyN8kucDWQuIyYE3BnHmDUL/gNU+ngKCWS9TSY4y3MErXg/HPIhd78z0TBZZYJFxMwjbtFNZBzPs2aFqfgbyE9/2X5AyHUJ2JMJcuHtHyGcS/zGAvhjQCSpNuUxDZ2D1OH06703uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajE4VJHD; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajE4VJHD"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9c36db8eeso439229b6e.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717671794; x=1718276594; darn=vger.kernel.org;
        h=cc:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kd1Zzw/3W8T7qT6Co79l+BmcMwx2vVPtXGybOJoZjH4=;
        b=ajE4VJHDL6P2F4cZnro+kAlFso93SkWQ5DZSW0BOJdiBBgfxI36IDm1m6Dvoem8MKA
         Ui8cDvzAF5JEkg0T9019h/r6jc3eO/EiWhyr/n99hJ8mvDSw2pEjY+BO/YhR7Sjs/CN5
         usdHXBvu11M6yz3RMhbllUZRTDVn5XhUzsMjZa3VJw5LmfWedMe3MOJK+bKdAACgBE8c
         9Txz3+Kn3z0QGxUNmpqXAWJGBNCejMdzXYS4EVVSYrCdurOxjR6E1De7MeP+gjcpHwGW
         knSG9VSb+3K8AK1csDJxQVkp8UHkWq8df/x+T5QFkVy5Ev+gsoiAexExlbiXnkwb64Lh
         vGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717671794; x=1718276594;
        h=cc:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kd1Zzw/3W8T7qT6Co79l+BmcMwx2vVPtXGybOJoZjH4=;
        b=ufENV82O1bA57ShaEoaSFTQvQgpSje/zx2mJf7XsMbb02OH39HUra/dWmF6IjRfBoP
         zh6g5ePN2r2aE/jP6CN2Emk8ODw8CXv+IvBjDrKis3RN7wNbbozw/mvOTFkUu2NSWx1y
         QHLfOG216IakWPdjUZmIAKNVsnlA8ODe8tGexSA5OaQTSS8FMMsQdQsIJzILvteTJvIk
         qe23PUbyl7lnVsrs7m+Dk4W6PwhF0MUKI9KKQ7jhINFae+jg9CxA0f1T0wjpiLeh86iR
         H9TQKDtVkB40+tC8HRAeTdiAT0aLLloLvEnYpd1jdH+SIh2vM1X+4vVM2jo3LTqyeY53
         TIaw==
X-Gm-Message-State: AOJu0Yzl1mh2O5YAPDP6jpJy0gJbu+7sEqyYlF7WQNu083zGm05y4qJw
	TxTd+HJ54GrIXdLT25cCZ4s6+if/UwIp4BtfonXFeTLlB9nh77S2BREGb29an4SdTh2EDyQ5m8Q
	jrZiyskuvRFyJWGpTEymcZw+PoimHXcKG
X-Received: by 2002:aca:2405:0:b0:3d2:33:84aa with SMTP id 5614622812f47-3d20425be3fmt5883489b6e.12.1717671793802;
 Thu, 06 Jun 2024 04:03:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 11:03:13 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240605102958.716432-1-knayak@gitlab.com>
References: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
 <20240605102958.716432-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Jun 2024 11:03:13 +0000
Message-ID: <CAOLa=ZR_EQfrjK90=zebOiiMUCAdEzPe9+SxHVoFrfkq4A+9jg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] update-ref: add symref support for --stdin
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000001d35ca061a36a108"

--0000000000001d35ca061a36a108
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The 'update-ref' command is used to update refs using transactions. The
> command allows users to also utilize a '--stdin' mode to provide a
> batch of sub-commands which can be processed in a transaction.
>
> Currently, the sub-commands involve {verify, delete, create, update}
> and they allow users to work with regular refs in the repository. To
> work with symrefs, users only have the option of using
> 'git-symbolic-ref', which doesn't provide transaction support to the
> users eventhough it uses the same behind the hood.
>
> Recently, we modified the reference backend to add symref support,
> following which, 'git-symbolic-ref' also uses the transaction backend.
> But, it doesn't expose this to the user. To allow users to work with
> symrefs via transaction, this series adds support for new sub-commands
> {symrer-verify, symref-delete, symref-create, symref-update} to the
> '--stdin' mode of update-ref. These complement the existing
> sub-commands.
>
> The patches 1, 2, & 6 fix small issues in the reference backends. The other
> patches 3, 4, 5, & 7 each add one of the new sub-commands.
>
> The series is based off master, with 'kn/ref-transaction-symref' merged
> in.
>
> There was some discussion [1] also about adding `old_target` support to
> the existing `update` command. I think its worthwhile to do this with
> some tests cleanup, will follow that up as a separate series.
>
> Changes since v3:
> * Changed the position of `old_target` and `flags` in `ref_transaction_delete`
> to make it a coherent.
> * Added tests for deletion of regular refs using 'symref-delete', this lead to
> adding a new commit to have specific errors for when a regular update contains
> `old_target`.
>
> [1]: https://lore.kernel.org/r/CAOLa=ZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft1Wf9kAX=_bw@mail.gmail.com
>
> Karthik Nayak (7):
>   refs: create and use `ref_update_expects_existing_old_ref()`
>   refs: specify error for regular refs with `old_target`
>   update-ref: add support for 'symref-verify' command
>   update-ref: add support for 'symref-delete' command
>   update-ref: add support for 'symref-create' command
>   reftable: pick either 'oid' or 'target' for new updates
>   update-ref: add support for 'symref-update' command
>
>  Documentation/git-update-ref.txt |  25 ++
>  builtin/clone.c                  |   2 +-
>  builtin/fetch.c                  |   4 +-
>  builtin/receive-pack.c           |   3 +-
>  builtin/update-ref.c             | 237 ++++++++++++++++-
>  refs.c                           |  40 ++-
>  refs.h                           |   6 +-
>  refs/files-backend.c             |  16 +-
>  refs/refs-internal.h             |   6 +
>  refs/reftable-backend.c          |  16 +-
>  t/t0600-reffiles-backend.sh      |  32 +++
>  t/t1400-update-ref.sh            | 430 ++++++++++++++++++++++++++++++-
>  t/t1416-ref-transaction-hooks.sh |  54 ++++
>  t/t5605-clone-local.sh           |   2 +-
>  14 files changed, 832 insertions(+), 41 deletions(-)
>
> Range-diff against v3:
> -:  ---------- > 1:  cab5265c3c refs: create and use `ref_update_expects_existing_old_ref()`
> -:  ---------- > 2:  57b5ff46c0 refs: specify error for regular refs with `old_target`
> 1:  ed54b0dfb9 = 3:  5710fa81bf update-ref: add support for 'symref-verify' command
> 2:  b82b86ff40 ! 4:  5f8fc4eb6e update-ref: add support for 'symref-delete' command
>     @@ Commit message
>          within a transaction, which promises atomicity of the operation and can
>          be batched with other commands.
>
>     +    When no 'old_target' is provided it can also delete regular refs,
>     +    similar to how the 'delete' command can delete symrefs when no 'old_oid'
>     +    is provided.
>     +
>          Helped-by: Patrick Steinhardt <ps@pks.im>
>          Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
>     @@ Documentation/git-update-ref.txt: verify::
>
>       ## builtin/fetch.c ##
>      @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
>     + 	if (!dry_run) {
>       		if (transaction) {
>       			for (ref = stale_refs; ref; ref = ref->next) {
>     - 				result = ref_transaction_delete(transaction, ref->name, NULL, 0,
>     +-				result = ref_transaction_delete(transaction, ref->name, NULL, 0,
>      -								"fetch: prune", &err);
>     -+								NULL, "fetch: prune", &err);
>     ++				result = ref_transaction_delete(transaction, ref->name, NULL,
>     ++								NULL, 0, "fetch: prune", &err);
>       				if (result)
>       					goto cleanup;
>       			}
>     @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct sh
>       					   namespaced_name,
>       					   old_oid,
>      -					   0, "push", &err)) {
>     -+					   0, NULL,
>     ++					   NULL, 0,
>      +					   "push", &err)) {
>       			rp_error("%s", err.buf);
>       			ret = "failed to delete";
>     @@ builtin/update-ref.c: static void parse_cmd_delete(struct ref_transaction *trans
>       	if (ref_transaction_delete(transaction, refname,
>       				   have_old ? &old_oid : NULL,
>      -				   update_flags, msg, &err))
>     -+				   update_flags, NULL, msg, &err))
>     ++				   NULL, update_flags, msg, &err))
>       		die("%s", err.buf);
>
>       	update_flags = default_flags;
>     @@ builtin/update-ref.c: static void parse_cmd_delete(struct ref_transaction *trans
>      +		die("symref-delete %s: extra input: %s", refname, next);
>      +
>      +	if (ref_transaction_delete(transaction, refname, NULL,
>     -+				   update_flags, old_target, msg, &err))
>     ++				   old_target, update_flags, msg, &err))
>      +		die("%s", err.buf);
>      +
>      +	update_flags = default_flags;
>     @@ refs.c: int refs_delete_ref(struct ref_store *refs, const char *msg,
>       	if (!transaction ||
>       	    ref_transaction_delete(transaction, refname, old_oid,
>      -				   flags, msg, &err) ||
>     -+				   flags, NULL, msg, &err) ||
>     ++				   NULL, flags, msg, &err) ||
>       	    ref_transaction_commit(transaction, &err)) {
>       		error("%s", err.buf);
>       		ref_transaction_free(transaction);
>     @@ refs.c: int ref_transaction_create(struct ref_transaction *transaction,
>       			   const char *refname,
>       			   const struct object_id *old_oid,
>      -			   unsigned int flags, const char *msg,
>     -+			   unsigned int flags,
>      +			   const char *old_target,
>     ++			   unsigned int flags,
>      +			   const char *msg,
>       			   struct strbuf *err)
>       {
>     @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
>       	for_each_string_list_item(item, refnames) {
>       		ret = ref_transaction_delete(transaction, item->string,
>      -					     NULL, flags, msg, &err);
>     -+					     NULL, flags, NULL, msg, &err);
>     ++					     NULL, NULL, flags, msg, &err);
>       		if (ret) {
>       			warning(_("could not delete reference %s: %s"),
>       				item->string, err.buf);
>     @@ refs.h: int ref_transaction_create(struct ref_transaction *transaction,
>       			   const char *refname,
>       			   const struct object_id *old_oid,
>      -			   unsigned int flags, const char *msg,
>     -+			   unsigned int flags,
>      +			   const char *old_target,
>     ++			   unsigned int flags,
>      +			   const char *msg,
>       			   struct strbuf *err);
>
>     @@ t/t1400-update-ref.sh: do
>      +		grep "fatal: symref-delete: missing <ref>" err
>      +	'
>      +
>     ++	test_expect_success "stdin $type symref-delete fails deleting regular ref" '
>     ++		test_when_finished "git update-ref -d refs/heads/regularref" &&
>     ++		git update-ref refs/heads/regularref $a &&
>     ++		format_command $type "symref-delete refs/heads/regularref" "$a" >stdin &&
>     ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
>     ++		grep "fatal: cannot update regular ref: ${SQ}refs/heads/regularref${SQ}: symref target ${SQ}$a${SQ} set" err
>     ++	'
>     ++
>      +	test_expect_success "stdin $type symref-delete fails with too many arguments" '
>      +		format_command $type "symref-delete refs/heads/symref" "$a" "$a" >stdin &&
>      +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
>     @@ t/t1400-update-ref.sh: do
>      +		git update-ref --stdin $type --no-deref <stdin &&
>      +		test_must_fail git symbolic-ref -d refs/heads/symref2
>      +	'
>     ++
>     ++	test_expect_success "stdin $type symref-delete fails deleting regular ref without target" '
>     ++		git update-ref refs/heads/regularref $a &&
>     ++		format_command $type "symref-delete refs/heads/regularref" >stdin &&
>     ++		git update-ref --stdin $type --no-deref <stdin
>     ++	'
>      +
>       done
>
> 3:  ae127f7d52 ! 5:  1542cfb806 update-ref: add support for 'symref-create' command
>     @@ t/t0600-reffiles-backend.sh: test_expect_success POSIXPERM 'git reflog expire ho
>
>       ## t/t1400-update-ref.sh ##
>      @@ t/t1400-update-ref.sh: do
>     - 		test_must_fail git symbolic-ref -d refs/heads/symref2
>     + 		git update-ref --stdin $type --no-deref <stdin
>       	'
>
>      +	test_expect_success "stdin $type symref-create fails with too many arguments" '
> 4:  8889dcbf40 = 6:  ec5380743d reftable: pick either 'oid' or 'target' for new updates
> 5:  19d85d56c4 ! 7:  f8d91f7fc9 update-ref: add support for 'symref-update' command
>     @@ Commit message
>          we don't use a `(ref | oid)` prefix for the old_value, then there is
>          ambiguity around if the value provided should be treated as an oid or a
>          reference. This is more so the reason, because we allow anything
>     -    committish to be provided as an oid.
>     +    committish to be provided as an oid. While 'symref-verify' and
>     +    'symref-delete' also take in `<old-target>` we do not have this
>     +    divergence there as those commands only work with symrefs. Whereas
>     +    'symref-update' also works with regular refs and allows users to convert
>     +    regular refs to symrefs.
>
>          The command allows users to perform symbolic ref updates within a
>          transaction. This provides atomicity and allows users to perform a set
> --
> 2.43.GIT

I also noticed that the range-diff seems a bit weird. I used

    git format-patch -v 4  --cover-letter --range-diff=symref-cmd-v3 @~7..@

to generate the patch series, but seems like when doing this it
internally computes the merge-base, which happens to be the first commit
in this series, skewing the range-diff by one commit. I guess its always
better to provide the commit range to `--range-diff`. Adding the range
diff for the same, when run using

   git format-patch -v 4 --cover-letter
--range-diff=6ab505f161..symref-cmd-v3 @~7..@

where `6ab505f161` is the common base for both v3 and v4, and is from
merging in `ps/leakfixes`.

Range-diff against v3:
1:  cab5265c3c = 1:  cab5265c3c refs: create and use
`ref_update_expects_existing_old_ref()`
-:  ---------- > 2:  57b5ff46c0 refs: specify error for regular refs
with `old_target`
2:  ed54b0dfb9 = 3:  5710fa81bf update-ref: add support for
'symref-verify' command
3:  b82b86ff40 ! 4:  5f8fc4eb6e update-ref: add support for
'symref-delete' command
    @@ Commit message
         within a transaction, which promises atomicity of the operation and can
         be batched with other commands.

    +    When no 'old_target' is provided it can also delete regular refs,
    +    similar to how the 'delete' command can delete symrefs when
no 'old_oid'
    +    is provided.
    +
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

    @@ Documentation/git-update-ref.txt: verify::

      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int prune_refs(struct display_state
*display_state,
    + 	if (!dry_run) {
      		if (transaction) {
      			for (ref = stale_refs; ref; ref = ref->next) {
    - 				result = ref_transaction_delete(transaction, ref->name, NULL, 0,
    +-				result = ref_transaction_delete(transaction, ref->name, NULL, 0,
     -								"fetch: prune", &err);
    -+								NULL, "fetch: prune", &err);
    ++				result = ref_transaction_delete(transaction, ref->name, NULL,
    ++								NULL, 0, "fetch: prune", &err);
      				if (result)
      					goto cleanup;
      			}
    @@ builtin/receive-pack.c: static const char *update(struct
command *cmd, struct sh
      					   namespaced_name,
      					   old_oid,
     -					   0, "push", &err)) {
    -+					   0, NULL,
    ++					   NULL, 0,
     +					   "push", &err)) {
      			rp_error("%s", err.buf);
      			ret = "failed to delete";
    @@ builtin/update-ref.c: static void parse_cmd_delete(struct
ref_transaction *trans
      	if (ref_transaction_delete(transaction, refname,
      				   have_old ? &old_oid : NULL,
     -				   update_flags, msg, &err))
    -+				   update_flags, NULL, msg, &err))
    ++				   NULL, update_flags, msg, &err))
      		die("%s", err.buf);

      	update_flags = default_flags;
    @@ builtin/update-ref.c: static void parse_cmd_delete(struct
ref_transaction *trans
     +		die("symref-delete %s: extra input: %s", refname, next);
     +
     +	if (ref_transaction_delete(transaction, refname, NULL,
    -+				   update_flags, old_target, msg, &err))
    ++				   old_target, update_flags, msg, &err))
     +		die("%s", err.buf);
     +
     +	update_flags = default_flags;
    @@ refs.c: int refs_delete_ref(struct ref_store *refs, const char *msg,
      	if (!transaction ||
      	    ref_transaction_delete(transaction, refname, old_oid,
     -				   flags, msg, &err) ||
    -+				   flags, NULL, msg, &err) ||
    ++				   NULL, flags, msg, &err) ||
      	    ref_transaction_commit(transaction, &err)) {
      		error("%s", err.buf);
      		ref_transaction_free(transaction);
    @@ refs.c: int ref_transaction_create(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *old_oid,
     -			   unsigned int flags, const char *msg,
    -+			   unsigned int flags,
     +			   const char *old_target,
    ++			   unsigned int flags,
     +			   const char *msg,
      			   struct strbuf *err)
      {
    @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
      	for_each_string_list_item(item, refnames) {
      		ret = ref_transaction_delete(transaction, item->string,
     -					     NULL, flags, msg, &err);
    -+					     NULL, flags, NULL, msg, &err);
    ++					     NULL, NULL, flags, msg, &err);
      		if (ret) {
      			warning(_("could not delete reference %s: %s"),
      				item->string, err.buf);
    @@ refs.h: int ref_transaction_create(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *old_oid,
     -			   unsigned int flags, const char *msg,
    -+			   unsigned int flags,
     +			   const char *old_target,
    ++			   unsigned int flags,
     +			   const char *msg,
      			   struct strbuf *err);

    @@ t/t1400-update-ref.sh: do
     +		grep "fatal: symref-delete: missing <ref>" err
     +	'
     +
    ++	test_expect_success "stdin $type symref-delete fails deleting
regular ref" '
    ++		test_when_finished "git update-ref -d refs/heads/regularref" &&
    ++		git update-ref refs/heads/regularref $a &&
    ++		format_command $type "symref-delete refs/heads/regularref"
"$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
    ++		grep "fatal: cannot update regular ref:
${SQ}refs/heads/regularref${SQ}: symref target ${SQ}$a${SQ} set" err
    ++	'
    ++
     +	test_expect_success "stdin $type symref-delete fails with too
many arguments" '
     +		format_command $type "symref-delete refs/heads/symref" "$a"
"$a" >stdin &&
     +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
    @@ t/t1400-update-ref.sh: do
     +		git update-ref --stdin $type --no-deref <stdin &&
     +		test_must_fail git symbolic-ref -d refs/heads/symref2
     +	'
    ++
    ++	test_expect_success "stdin $type symref-delete fails deleting
regular ref without target" '
    ++		git update-ref refs/heads/regularref $a &&
    ++		format_command $type "symref-delete refs/heads/regularref" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin
    ++	'
     +
      done

4:  ae127f7d52 ! 5:  1542cfb806 update-ref: add support for
'symref-create' command
    @@ t/t0600-reffiles-backend.sh: test_expect_success POSIXPERM 'git
reflog expire ho

      ## t/t1400-update-ref.sh ##
     @@ t/t1400-update-ref.sh: do
    - 		test_must_fail git symbolic-ref -d refs/heads/symref2
    + 		git update-ref --stdin $type --no-deref <stdin
      	'

     +	test_expect_success "stdin $type symref-create fails with too
many arguments" '
5:  8889dcbf40 = 6:  ec5380743d reftable: pick either 'oid' or
'target' for new updates
6:  19d85d56c4 ! 7:  f8d91f7fc9 update-ref: add support for
'symref-update' command
    @@ Commit message
         we don't use a `(ref | oid)` prefix for the old_value, then there is
         ambiguity around if the value provided should be treated as an oid or a
         reference. This is more so the reason, because we allow anything
    -    committish to be provided as an oid.
    +    committish to be provided as an oid. While 'symref-verify' and
    +    'symref-delete' also take in `<old-target>` we do not have this
    +    divergence there as those commands only work with symrefs. Whereas
    +    'symref-update' also works with regular refs and allows users
to convert
    +    regular refs to symrefs.

         The command allows users to perform symbolic ref updates within a
         transaction. This provides atomicity and allows users to perform a set
-- 
2.43.GIT

--0000000000001d35ca061a36a108
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 22469b1235e4829_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aaGwyOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memUxREFDZXp3YU1manZ4TDlaMDNaSklsUjM2MkJudApoTk1IU2ZBYitZ
c1pHcUJIbk0zWGsrdUhXUGJRVXdPcGQ2TWZqOHJNZng0UXd2dldkdDJjNTJxeVRuTVFPYWRUCjBE
T0pycTRwSHEyS0pORWJpbXZKZ3VPWTlId0p1b1JWb1ZOM0NkcHJsa2hQeXE5RkZXMndwQXFxSXg4
K04waTAKS1cycW90WEc3aldHNklOL2NJL0dyamdZeWdJNDVOS3pROGVoUWp4czY4OFRYNytmcWlR
dVhoTlppM09DYVpSYgpzQVZWZUU1eDNUZGRPMC9uRFFGUktKaUNFMlJTeHhMc2ZJUjc1K2M2U2FQ
SE9pM0FTMFJQM1pSZ2VyRU05aU9vClplRnd4b1JobU1IU09uWUVpY0tZc1lJb0xTL25vOGlNVUoz
R1MreFhCb3dyMjF5RGpvTEVKN2svU0R5QUxiNTIKbkNPNXpEbWJFeEJWZ3BMdzdWODhPSXBrQnJZ
OC9nNCtTbFZiSWVoTk9JZkFXUDBIbW95RzN0WW0yVGY0QkRrSQorcnZscmRnYWpCbUpGbUd1MzZL
enU5VU13ZWdja3FMQnhiTi8rczI1WXMwbk1NTnJxNWJUc2JmSGFSby9vbDA5CnB4aUdhSkdocSs4
T2FMMUFHRDYyV3RWcXJZRkZpZ0NTZFBlUzhhWT0KPVV3YUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001d35ca061a36a108--
