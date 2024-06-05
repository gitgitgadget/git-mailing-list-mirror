Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA2191475
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583405; cv=none; b=dnrlFtLkLgD+TzNwpK1dC2DBq21hUGAPU7kTJ8E9L+FFHv9UWlASA1dV7JzXP9kFl8xTQd60uzyG81pl1Rz/WbOQdcjjCL73XfSExX6L2rhd7I7tZ+OOTBjSlGUkVW6SkwPcAi4OStPvDVE/jv4dQsUHSMAZsW8HrtdAwSeyKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583405; c=relaxed/simple;
	bh=4mu8PMhREAzeogJjov3XHSYwwxuKDmsxoN6gRqaUs7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNB8zRMWLSqqpgfHMCd3Z6KhagwD88e0fgy5ZE3Rtjo9wrrGwR7eMPQzmOIt9D867hRaw2iK/YruIao/i+VnXcva/AAkk9sRdjn97frITA9HIoAD1HvhZP/AGVOKXlf1qExK/tvkK9f6sMbXus5VAVmqAP0XDYnyDi28/x8yfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYV5XiXd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYV5XiXd"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a68ee841138so412040966b.1
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717583402; x=1718188202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cjaLvOYDaz48+OfD2i8KP4jj0OHGiYycoEz2ERZP4Q=;
        b=OYV5XiXd8fa807FPJ70g7gyiU+vqc+K19I8Hy7yy4flkRtKKWn96m/W1xFv0543Ps8
         76PbWzDVMhneL9AY2bRVoODgc+I3Y5wj/J0PEo2kLSlWaoopuHBXEUmB9trOWvSVKKuU
         Og8J7XnTrj1njdVB5JBEApRMGg13zYvYfWnV5bMAIMhrD7BM/AVrEYlueDjrTACX6pcs
         aWzDOxxInzww9/Gv1tRArx0/yPDO0fq7WEb+aHF8P1Xpaj2iYDwmcclRKKMq0hZVznqf
         myfCUrs9reD3e1106qMjqW/BFaoIRdOfphXAZ9BjXjNtbwOCbLEKOgRkDLXa1OfMNlyW
         63oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583402; x=1718188202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cjaLvOYDaz48+OfD2i8KP4jj0OHGiYycoEz2ERZP4Q=;
        b=gew+AiJiVldHs4K5LgK6nddj2vlBh4sQFtCg89sTy1OuJyD80FgWAIQLJch7b76qNF
         aZ8DzQdMuv9NyDKMhYrdlgq0dFjaiTec82SJ+krKleA1Y96FTAnzFFWnZvVvEObrvPHV
         Wu/o9MM2CuCTz0hFg+bfHh5RqIav+QF0GnGkGJIOD8UYE2Vdb2zKh/dqLC7O1ukGRQef
         5R+lzWdseBk4Ewua3cpobm4jLMvJvgOOW+kr3BCkOiRjaq2+xMsUCcu6dMTiKMND6bba
         jci2Pe8TMxHb8vSpBiuk3mxznLz5gR74FgSxS9LIakyeG3/3Ng64KXkuZfHkqZQiRugX
         fNHQ==
X-Gm-Message-State: AOJu0Yzwvlk06CqBbTaqSkQhy60T3+4syjTgcLo3UvbuIXTSmSSkOcFB
	yxKaeKgjQ437isjuqjIofRePyzNCMX6UF1Y6kp+A1g3Kwfap8mIYtUdmenI+
X-Google-Smtp-Source: AGHT+IFoES9edwGcxWGh8+aOegjW7m93rqJRn0S/CAc8XDhMusits2lXX3Z71tcnqM9I11d9MPgPvQ==
X-Received: by 2002:a17:906:2759:b0:a58:eba0:6716 with SMTP id a640c23a62f3a-a69a002e87dmr119101966b.60.1717583401678;
        Wed, 05 Jun 2024 03:30:01 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f0e03cfdsm510453166b.195.2024.06.05.03.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:30:01 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 0/7] update-ref: add symref support for --stdin
Date: Wed,  5 Jun 2024 12:29:51 +0200
Message-ID: <20240605102958.716432-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
References: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
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

The patches 1, 2, & 6 fix small issues in the reference backends. The other
patches 3, 4, 5, & 7 each add one of the new sub-commands.

The series is based off master, with 'kn/ref-transaction-symref' merged
in.

There was some discussion [1] also about adding `old_target` support to
the existing `update` command. I think its worthwhile to do this with
some tests cleanup, will follow that up as a separate series.

Changes since v3:
* Changed the position of `old_target` and `flags` in `ref_transaction_delete`
to make it a coherent.
* Added tests for deletion of regular refs using 'symref-delete', this lead to
adding a new commit to have specific errors for when a regular update contains
`old_target`.

[1]: https://lore.kernel.org/r/CAOLa=ZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft1Wf9kAX=_bw@mail.gmail.com

Karthik Nayak (7):
  refs: create and use `ref_update_expects_existing_old_ref()`
  refs: specify error for regular refs with `old_target`
  update-ref: add support for 'symref-verify' command
  update-ref: add support for 'symref-delete' command
  update-ref: add support for 'symref-create' command
  reftable: pick either 'oid' or 'target' for new updates
  update-ref: add support for 'symref-update' command

 Documentation/git-update-ref.txt |  25 ++
 builtin/clone.c                  |   2 +-
 builtin/fetch.c                  |   4 +-
 builtin/receive-pack.c           |   3 +-
 builtin/update-ref.c             | 237 ++++++++++++++++-
 refs.c                           |  40 ++-
 refs.h                           |   6 +-
 refs/files-backend.c             |  16 +-
 refs/refs-internal.h             |   6 +
 refs/reftable-backend.c          |  16 +-
 t/t0600-reffiles-backend.sh      |  32 +++
 t/t1400-update-ref.sh            | 430 ++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh |  54 ++++
 t/t5605-clone-local.sh           |   2 +-
 14 files changed, 832 insertions(+), 41 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  cab5265c3c refs: create and use `ref_update_expects_existing_old_ref()`
-:  ---------- > 2:  57b5ff46c0 refs: specify error for regular refs with `old_target`
1:  ed54b0dfb9 = 3:  5710fa81bf update-ref: add support for 'symref-verify' command
2:  b82b86ff40 ! 4:  5f8fc4eb6e update-ref: add support for 'symref-delete' command
    @@ Commit message
         within a transaction, which promises atomicity of the operation and can
         be batched with other commands.
     
    +    When no 'old_target' is provided it can also delete regular refs,
    +    similar to how the 'delete' command can delete symrefs when no 'old_oid'
    +    is provided.
    +
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Documentation/git-update-ref.txt: verify::
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
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
    @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct sh
      					   namespaced_name,
      					   old_oid,
     -					   0, "push", &err)) {
    -+					   0, NULL,
    ++					   NULL, 0,
     +					   "push", &err)) {
      			rp_error("%s", err.buf);
      			ret = "failed to delete";
    @@ builtin/update-ref.c: static void parse_cmd_delete(struct ref_transaction *trans
      	if (ref_transaction_delete(transaction, refname,
      				   have_old ? &old_oid : NULL,
     -				   update_flags, msg, &err))
    -+				   update_flags, NULL, msg, &err))
    ++				   NULL, update_flags, msg, &err))
      		die("%s", err.buf);
      
      	update_flags = default_flags;
    @@ builtin/update-ref.c: static void parse_cmd_delete(struct ref_transaction *trans
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
    ++	test_expect_success "stdin $type symref-delete fails deleting regular ref" '
    ++		test_when_finished "git update-ref -d refs/heads/regularref" &&
    ++		git update-ref refs/heads/regularref $a &&
    ++		format_command $type "symref-delete refs/heads/regularref" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
    ++		grep "fatal: cannot update regular ref: ${SQ}refs/heads/regularref${SQ}: symref target ${SQ}$a${SQ} set" err
    ++	'
    ++
     +	test_expect_success "stdin $type symref-delete fails with too many arguments" '
     +		format_command $type "symref-delete refs/heads/symref" "$a" "$a" >stdin &&
     +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
    @@ t/t1400-update-ref.sh: do
     +		git update-ref --stdin $type --no-deref <stdin &&
     +		test_must_fail git symbolic-ref -d refs/heads/symref2
     +	'
    ++
    ++	test_expect_success "stdin $type symref-delete fails deleting regular ref without target" '
    ++		git update-ref refs/heads/regularref $a &&
    ++		format_command $type "symref-delete refs/heads/regularref" >stdin &&
    ++		git update-ref --stdin $type --no-deref <stdin
    ++	'
     +
      done
      
3:  ae127f7d52 ! 5:  1542cfb806 update-ref: add support for 'symref-create' command
    @@ t/t0600-reffiles-backend.sh: test_expect_success POSIXPERM 'git reflog expire ho
     
      ## t/t1400-update-ref.sh ##
     @@ t/t1400-update-ref.sh: do
    - 		test_must_fail git symbolic-ref -d refs/heads/symref2
    + 		git update-ref --stdin $type --no-deref <stdin
      	'
      
     +	test_expect_success "stdin $type symref-create fails with too many arguments" '
4:  8889dcbf40 = 6:  ec5380743d reftable: pick either 'oid' or 'target' for new updates
5:  19d85d56c4 ! 7:  f8d91f7fc9 update-ref: add support for 'symref-update' command
    @@ Commit message
         we don't use a `(ref | oid)` prefix for the old_value, then there is
         ambiguity around if the value provided should be treated as an oid or a
         reference. This is more so the reason, because we allow anything
    -    committish to be provided as an oid.
    +    committish to be provided as an oid. While 'symref-verify' and
    +    'symref-delete' also take in `<old-target>` we do not have this
    +    divergence there as those commands only work with symrefs. Whereas
    +    'symref-update' also works with regular refs and allows users to convert
    +    regular refs to symrefs.
     
         The command allows users to perform symbolic ref updates within a
         transaction. This provides atomicity and allows users to perform a set
-- 
2.43.GIT

