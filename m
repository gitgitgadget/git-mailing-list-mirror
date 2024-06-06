Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8902E64C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694809; cv=none; b=VK8aVFy97ST5ek+uEGJBg+vBuQs28c4KD9xq0DbRngA5ip1yL23JPSoW/jqcROX5jxrs4oJVL4FBx41VfWQWLLhSIkDrrDKP9DgkhUei6A1AcETrGb10IJv2ginCHtH4D+MneZGiGrRAtUxCNvAGyz9D/Is6EXXom7cxCS5rPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694809; c=relaxed/simple;
	bh=Gef4D70OasNRbzT7ZZiVtIBBgEe+A6GoSGoo9n7TTiM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u8y21J/3pfGeLoU9f21CrqnpJ6gs0w90b5sa/IZRShrVWwSLap1vpJciJe20DlQDJcHIXRV2FnnIeh0K7qHEP4JUVovTUVgBbcNgAhQL31PA8QKFwv0etqdHt2h5ntc3+LDigHjVYs41wTkh8Pl7JFsrTpkCLm1zk1cy6SEhatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR6M0SMB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR6M0SMB"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b8e0e98adso1852223e87.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694804; x=1718299604; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlrXk1sTMcRyGVjx6emJlpfVoTURHvWmr3aq/X+myZg=;
        b=KR6M0SMB18kRlPnluFPkeqyScOpOWxPM5q9cr0W1CVJO6drUdahwQ8GNzk5UUE3ukM
         AcmHBy5fL3+YuFrIbZv9FDyP6BQAp7aqwwknjR3CiofyObWJS6OIOMjY3Zc+gQ006lyd
         X6sZLmJ7dyYaZkrjb2jBPTRAdWeI3XWuyx6TTzagMQ9rU7bzRkjZmH88G/LFf+spePLU
         xqOe94Maj7hLQS/4xetqM3JA42w4miGtRvJs4QxkneCUMEMlcxYlSOS0fW4TTN1YkCMn
         pbRB6ueBo1JAU3oJHj2k0R0q2BxV0Z/1e/r6JRRxISZFSsHH9vy+oTk3MwpCs0bJBj1p
         A8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694804; x=1718299604;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlrXk1sTMcRyGVjx6emJlpfVoTURHvWmr3aq/X+myZg=;
        b=d9koUy9OorvyRDngTtgSqFVbVhYOXUOMDFd+GsJY37BN4wr6mN+YX8swTDs2fFXjM6
         sU1OZ4UIuOICHnXFwE1eNpAjkBju9usjzf3yNQnRL2FOlu5uTXvSF4JRQA0dfZ/URoZS
         eU4/TgxjPmqeNoIr2J14pzUo/NYG/o22TBvLiUQ+IzOSosA7Apth0CFeOWCOGCrPiom8
         AGrQSZdW9D/nn1+svehnrhexQAPpkYFiV9kB5MbtAg2OVfXBoiwWEcACrmYuvqreV87B
         8b73ZOT6KEqMzBrnhdhlmTSE8da8XUFSgPcrR62t0cDtP+6gPBCncAxQZ5opLTXTAAxY
         dlQQ==
X-Gm-Message-State: AOJu0YydPI2CNKoVxB34MvsHR8OkJpqC+pvqxeUOCDkX2YxoRfFqvhzs
	I6iOACJxeaxyNOwMwui/95rFxFWNxi96cb9yugNUoQ+l1wu7UAI3SafW4A==
X-Google-Smtp-Source: AGHT+IEqRRztEnXBqtSOPTPVRVOvXBs7L+NQ5TfRH2au9dprreBDmCeg2Uiq129Is1rbuF4cwRlL5A==
X-Received: by 2002:a19:6457:0:b0:52b:8255:71cf with SMTP id 2adb3069b0e04-52bb9fcc59emr176325e87.47.1717694804191;
        Thu, 06 Jun 2024 10:26:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c364bcdsm28046275e9.19.2024.06.06.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:26:43 -0700 (PDT)
Message-Id: <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Jun 2024 17:26:37 +0000
Subject: [PATCH 1/4] refs: add referent parameter to refs_resolve_ref_unsafe
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Phillip Wood [ ]" <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    "Jeff King [ ]" <peff@peff.net>,
    "Patrick Steinhardt [ ]" <ps@pks.im>,
    "=?UTF-8?Q?Jean-No=C3=ABl?= Avila [ ]" <avila.jn@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

refs_resolve_ref_unsafe retrieves the referent, the unresolved value of
a reference. Add a parameter to allow refs_resolve_ref_unsafe to pass up
the value of referent to the caller so it can save this value in ref
iterators for more efficient access.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 add-interactive.c           |  6 +++---
 blame.c                     |  4 ++--
 builtin/bisect.c            |  2 +-
 builtin/blame.c             |  2 +-
 builtin/branch.c            |  2 +-
 builtin/fsck.c              |  2 +-
 builtin/log.c               |  1 +
 builtin/rebase.c            |  6 +++---
 builtin/receive-pack.c      |  2 +-
 builtin/remote.c            |  2 +-
 builtin/stash.c             |  2 +-
 builtin/submodule--helper.c |  4 ++--
 builtin/symbolic-ref.c      |  2 +-
 config.c                    |  2 +-
 http-backend.c              |  1 +
 log-tree.c                  |  2 +-
 ls-refs.c                   |  3 ++-
 refs.c                      | 20 ++++++++++++--------
 refs.h                      |  1 +
 refs/files-backend.c        | 16 ++++++++--------
 refs/reftable-backend.c     |  6 +++---
 remote.c                    |  6 +++---
 revision.c                  |  2 +-
 sequencer.c                 |  9 +++++----
 t/helper/test-ref-store.c   |  2 +-
 transport-helper.c          |  1 +
 transport.c                 |  2 +-
 upload-pack.c               |  2 +-
 worktree.c                  |  4 +++-
 29 files changed, 64 insertions(+), 52 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index b5d6cd689a1..041d30cf2b3 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -533,7 +533,7 @@ static int get_modified_files(struct repository *r,
 {
 	struct object_id head_oid;
 	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						  "HEAD", RESOLVE_REF_READING,
+						  "HEAD", NULL, RESOLVE_REF_READING,
 						  &head_oid, NULL);
 	struct collection_status s = { 0 };
 	int i;
@@ -763,7 +763,7 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 
 	struct object_id oid;
 	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						  "HEAD", RESOLVE_REF_READING,
+						  "HEAD", NULL, RESOLVE_REF_READING,
 						  &oid,
 						  NULL);
 	struct lock_file index_lock;
@@ -994,7 +994,7 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 
 	struct object_id oid;
 	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						  "HEAD", RESOLVE_REF_READING,
+						  "HEAD", NULL, RESOLVE_REF_READING,
 						  &oid,
 						  NULL);
 	if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
diff --git a/blame.c b/blame.c
index 33586b97772..9e5d0cd788f 100644
--- a/blame.c
+++ b/blame.c
@@ -2700,7 +2700,7 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 		return NULL;
 
 	/* Do we have HEAD? */
-	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", RESOLVE_REF_READING, &head_oid, NULL))
+	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", NULL, RESOLVE_REF_READING, &head_oid, NULL))
 		return NULL;
 	head_commit = lookup_commit_reference_gently(revs->repo,
 						     &head_oid, 1);
@@ -2803,7 +2803,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 		if (sb->final) {
 			parent_oid = &sb->final->object.oid;
 		} else {
-			if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", RESOLVE_REF_READING, &head_oid, NULL))
+			if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", NULL, RESOLVE_REF_READING, &head_oid, NULL))
 				die("no such ref: HEAD");
 			parent_oid = &head_oid;
 		}
diff --git a/builtin/bisect.c b/builtin/bisect.c
index a58432b9d90..76ce5f0e0df 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -783,7 +783,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	 * Verify HEAD
 	 */
 	head = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-				       "HEAD", 0, &head_oid, &flags);
+				       "HEAD", NULL, 0, &head_oid, &flags);
 	if (!head)
 		if (repo_get_oid(the_repository, "HEAD", &head_oid))
 			return error(_("bad HEAD - I need a HEAD"));
diff --git a/builtin/blame.c b/builtin/blame.c
index fadba1a5304..1504a2ed99d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1092,7 +1092,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		struct commit *head_commit;
 		struct object_id head_oid;
 
-		if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", RESOLVE_REF_READING,
+		if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", NULL, RESOLVE_REF_READING,
 					     &head_oid, NULL) ||
 		    !(head_commit = lookup_commit_reference_gently(revs.repo,
 							     &head_oid, 1)))
diff --git a/builtin/branch.c b/builtin/branch.c
index 48cac74f97f..dd871d44f2d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -503,7 +503,7 @@ static void print_current_branch_name(void)
 {
 	int flags;
 	const char *refname = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						      "HEAD", 0, NULL, &flags);
+						      "HEAD", NULL, 0, NULL, &flags);
 	const char *shortname;
 	if (!refname)
 		die(_("could not resolve HEAD"));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2ed..2c0ac6653ca 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -716,7 +716,7 @@ static int fsck_head_link(const char *head_ref_name,
 		fprintf_ln(stderr, _("Checking %s link"), head_ref_name);
 
 	*head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						  head_ref_name, 0, head_oid,
+						  head_ref_name, NULL, 0, head_oid,
 						  NULL);
 	if (!*head_points_at) {
 		errors_found |= ERROR_REFS;
diff --git a/builtin/log.c b/builtin/log.c
index c8ce0c0d88a..337f367e974 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2228,6 +2228,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			const char *ref, *v;
 			ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 						      "HEAD",
+						      NULL,
 						      RESOLVE_REF_READING,
 						      NULL, NULL);
 			if (ref && skip_prefix(ref, "refs/heads/", &v))
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0466d9414af..fd14b1e4505 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1641,7 +1641,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */
 		options.head_name =
-			xstrdup_or_null(refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", 0, NULL,
+			xstrdup_or_null(refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", NULL, 0, NULL,
 								&flags));
 		if (!options.head_name)
 			die(_("No such ref: %s"), "HEAD");
@@ -1736,7 +1736,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (!(options.flags & REBASE_NO_QUIET))
 				; /* be quiet */
 			else if (!strcmp(branch_name, "HEAD") &&
-				 refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", 0, NULL, &flag))
+				 refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", NULL, 0, NULL, &flag))
 				puts(_("HEAD is up to date."));
 			else
 				printf(_("Current branch %s is up to date.\n"),
@@ -1746,7 +1746,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		} else if (!(options.flags & REBASE_NO_QUIET))
 			; /* be quiet */
 		else if (!strcmp(branch_name, "HEAD") &&
-			 refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", 0, NULL, &flag))
+			 refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", NULL, 0, NULL, &flag))
 			puts(_("HEAD is up to date, rebase forced."));
 		else
 			printf(_("Current branch %s is up to date, rebase "
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be8969a84a8..d9e2c4bbe39 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1695,7 +1695,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
 	dst_name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					   buf.buf, 0, NULL, &flag);
+					   buf.buf, NULL, 0, NULL, &flag);
 	check_aliased_update_internal(cmd, list, dst_name, flag);
 	strbuf_release(&buf);
 }
diff --git a/builtin/remote.c b/builtin/remote.c
index 447ef1d3c92..039d1d6c55a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -599,7 +599,7 @@ static int read_remote_branches(const char *refname,
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, refname);
 		symref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						 refname, RESOLVE_REF_READING,
+						 refname, NULL, RESOLVE_REF_READING,
 						 NULL, &flag);
 		if (symref && (flag & REF_ISSYMREF)) {
 			item->util = xstrdup(symref);
diff --git a/builtin/stash.c b/builtin/stash.c
index 7859bc0866a..b733492cead 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1386,7 +1386,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	}
 
 	branch_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					     "HEAD", 0, NULL, &flags);
+					     "HEAD", NULL, 0, NULL, &flags);
 	if (flags & REF_ISSYMREF)
 		skip_prefix(branch_ref, "refs/heads/", &branch_name);
 	head_short_sha1 = repo_find_unique_abbrev(the_repository,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 897f19868e8..e3e1f08a58c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -44,7 +44,7 @@ static int repo_get_default_remote(struct repository *repo, char **default_remot
 	char *dest = NULL;
 	struct strbuf sb = STRBUF_INIT;
 	struct ref_store *store = get_main_ref_store(repo);
-	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
+	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", NULL, 0, NULL,
 						      NULL);
 
 	if (!refname)
@@ -2459,7 +2459,7 @@ static int remote_submodule_branch(const char *path, const char **branch)
 
 	if (!strcmp(*branch, ".")) {
 		const char *refname = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-							      "HEAD", 0, NULL,
+							      "HEAD", NULL, 0, NULL,
 							      NULL);
 
 		if (!refname)
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 81abdd170fe..96fa311b075 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -19,7 +19,7 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int recurse, i
 
 	resolve_flags = (recurse ? 0 : RESOLVE_REF_NO_RECURSE);
 	refname = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					  HEAD, resolve_flags, NULL, &flag);
+					  HEAD, NULL, resolve_flags, NULL, &flag);
 
 	if (!refname)
 		die("No such ref: %s", HEAD);
diff --git a/config.c b/config.c
index 14461312b33..3cc1dab0fb9 100644
--- a/config.c
+++ b/config.c
@@ -304,7 +304,7 @@ static int include_by_branch(const char *cond, size_t cond_len)
 	struct strbuf pattern = STRBUF_INIT;
 	const char *refname = !the_repository->gitdir ?
 		NULL : refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					       "HEAD", 0, NULL, &flags);
+					       "HEAD", NULL, 0, NULL, &flags);
 	const char *shortname;
 
 	if (!refname || !(flags & REF_ISSYMREF)	||
diff --git a/http-backend.c b/http-backend.c
index 5b65287ac90..20c3ff8fa95 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -574,6 +574,7 @@ static int show_head_ref(const char *refname, const struct object_id *oid,
 	if (flag & REF_ISSYMREF) {
 		const char *target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 							     refname,
+							     NULL,
 							     RESOLVE_REF_READING,
 							     NULL, NULL);
 
diff --git a/log-tree.c b/log-tree.c
index 41416de4e3f..da06c6e982f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -280,7 +280,7 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 
 	/* Now resolve and find the matching current branch */
 	branch_name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					      "HEAD", 0, NULL, &rru_flags);
+					      "HEAD", NULL, 0, NULL, &rru_flags);
 	if (!branch_name || !(rru_flags & REF_ISSYMREF))
 		return NULL;
 
diff --git a/ls-refs.c b/ls-refs.c
index 398afe4ce39..3d047bbc64f 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -97,6 +97,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		struct object_id unused;
 		const char *symref_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 								    refname,
+								    NULL,
 								    0,
 								    &unused,
 								    &flag);
@@ -128,7 +129,7 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 	int oid_is_null;
 
 	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
-	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), namespaced.buf, 0, &oid, &flag))
+	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), namespaced.buf, NULL, 0, &oid, &flag))
 		return; /* bad ref */
 	oid_is_null = is_null_oid(&oid);
 	if (!oid_is_null ||
diff --git a/refs.c b/refs.c
index 31032588e0e..2c592a9ae29 100644
--- a/refs.c
+++ b/refs.c
@@ -378,7 +378,7 @@ char *refs_resolve_refdup(struct ref_store *refs,
 {
 	const char *result;
 
-	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
+	result = refs_resolve_ref_unsafe(refs, refname, NULL, resolve_flags,
 					 oid, flags);
 	return xstrdup_or_null(result);
 }
@@ -394,7 +394,7 @@ struct for_each_ref_filter {
 int refs_read_ref_full(struct ref_store *refs, const char *refname,
 		       int resolve_flags, struct object_id *oid, int *flags)
 {
-	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags,
+	if (refs_resolve_ref_unsafe(refs, refname, NULL, resolve_flags,
 				    oid, flags))
 		return 0;
 	return -1;
@@ -407,7 +407,7 @@ int refs_read_ref(struct ref_store *refs, const char *refname, struct object_id
 
 int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
-	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING,
+	return !!refs_resolve_ref_unsafe(refs, refname, NULL, RESOLVE_REF_READING,
 					 NULL, NULL);
 }
 
@@ -442,7 +442,7 @@ static int warn_if_dangling_symref(const char *refname,
 	if (!(flags & REF_ISSYMREF))
 		return 0;
 
-	resolves_to = refs_resolve_ref_unsafe(d->refs, refname, 0, NULL, NULL);
+	resolves_to = refs_resolve_ref_unsafe(d->refs, refname, NULL, 0, NULL, NULL);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
@@ -716,7 +716,7 @@ int expand_ref(struct repository *repo, const char *str, int len,
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
-		r = refs_resolve_ref_unsafe(refs, fullref.buf,
+		r = refs_resolve_ref_unsafe(refs, fullref.buf, NULL,
 					    RESOLVE_REF_READING,
 					    this_result, &flag);
 		if (r) {
@@ -750,7 +750,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
-		ref = refs_resolve_ref_unsafe(refs, path.buf,
+		ref = refs_resolve_ref_unsafe(refs, path.buf, NULL,
 					      RESOLVE_REF_READING,
 					      oid ? &hash : NULL, NULL);
 		if (!ref)
@@ -1522,7 +1522,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	struct object_id oid;
 	int flag;
 
-	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
+	if (refs_resolve_ref_unsafe(refs, "HEAD", NULL, RESOLVE_REF_READING,
 				    &oid, &flag))
 		return fn("HEAD", &oid, flag, cb_data);
 
@@ -1761,6 +1761,7 @@ int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
 
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
+				    const char *referent,
 				    int resolve_flags,
 				    struct object_id *oid,
 				    int *flags)
@@ -1822,6 +1823,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		}
 
 		*flags |= read_flags;
+		if (referent && (read_flags & REF_ISSYMREF) &&
+		    sb_refname.len > 0)
+			referent = sb_refname.buf;
 
 		if (!(read_flags & REF_ISSYMREF)) {
 			if (*flags & REF_BAD_NAME) {
@@ -1865,7 +1869,7 @@ int repo_resolve_gitlink_ref(struct repository *r,
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
+	if (!refs_resolve_ref_unsafe(refs, refname, NULL, 0, oid, &flags) ||
 	    is_null_oid(oid))
 		return -1;
 	return 0;
diff --git a/refs.h b/refs.h
index fe7f0db35e6..ea4a3217658 100644
--- a/refs.h
+++ b/refs.h
@@ -68,6 +68,7 @@ const char *ref_storage_format_to_name(unsigned int ref_storage_format);
 
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
+				    const char *referent,
 				    int resolve_flags,
 				    struct object_id *oid,
 				    int *flags);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 324c59b096c..bf2ffe062ea 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -244,7 +244,7 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 	struct object_id oid;
 	int flag;
 
-	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
+	if (!refs_resolve_ref_unsafe(&refs->base, refname, NULL, RESOLVE_REF_READING,
 				     &oid, &flag)) {
 		oidclr(&oid);
 		flag |= REF_ISBROKEN;
@@ -1118,7 +1118,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (!refs_resolve_ref_unsafe(&refs->base, lock->ref_name, 0,
+	if (!refs_resolve_ref_unsafe(&refs->base, lock->ref_name, NULL, 0,
 				     &lock->old_oid, NULL))
 		oidclr(&lock->old_oid);
 	goto out;
@@ -1455,7 +1455,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
+	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname, NULL,
 				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 				     &orig_oid, &flag)) {
 		ret = error("refname %s not found", oldrefname);
@@ -1501,7 +1501,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
-	if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname,
+	if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname, NULL,
 					     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 					     NULL, NULL) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
@@ -1875,7 +1875,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 		int head_flag;
 		const char *head_ref;
 
-		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
+		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD", NULL,
 						   RESOLVE_REF_READING,
 						   NULL, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
@@ -2464,7 +2464,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * to record and possibly check old_oid:
 			 */
 			if (!refs_resolve_ref_unsafe(&refs->base,
-						     referent.buf, 0,
+						     referent.buf, NULL, 0,
 						     &lock->old_oid, NULL)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
@@ -2823,7 +2823,7 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
 		 * We want to get the resolved OID for the target, to ensure
 		 * that the correct value is added to the reflog.
 		 */
-		if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
+		if (!refs_resolve_ref_unsafe(&refs->base, update->new_target, NULL,
 					     RESOLVE_REF_READING,
 					     &update->new_oid, NULL)) {
 			/*
@@ -3229,7 +3229,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 			int type;
 			const char *ref;
 
-			ref = refs_resolve_ref_unsafe(&refs->base, refname,
+			ref = refs_resolve_ref_unsafe(&refs->base, refname, NULL,
 						      RESOLVE_REF_NO_RECURSE,
 						      NULL, &type);
 			update = !!(ref && !(type & REF_ISSYMREF));
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 438b5c478b4..9e03582e7da 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -438,7 +438,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			oidread(&iter->oid, iter->ref.value.val2.value);
 			break;
 		case REFTABLE_REF_SYMREF:
-			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
+			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname, NULL,
 						     RESOLVE_REF_READING, &iter->oid, &flags))
 				oidclr(&iter->oid);
 			break;
@@ -926,7 +926,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * so it is safe to call `refs_resolve_ref_unsafe()`
 			 * here without causing races.
 			 */
-			const char *resolved = refs_resolve_ref_unsafe(&refs->base, u->refname, 0,
+			const char *resolved = refs_resolve_ref_unsafe(&refs->base, u->refname, NULL, 0,
 								       &current_oid, NULL);
 
 			if (u->flags & REF_NO_DEREF) {
@@ -1148,7 +1148,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			int create_reflog = 1;
 
 			if (u->new_target) {
-				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target,
+				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target, NULL,
 							     RESOLVE_REF_READING, &u->new_oid, NULL)) {
 					/*
 					 * TODO: currently we skip creating reflogs for dangling
diff --git a/remote.c b/remote.c
index 5898da2bb5c..c9718ee0ca1 100644
--- a/remote.c
+++ b/remote.c
@@ -520,7 +520,7 @@ static void read_config(struct repository *repo, int early)
 	repo->remote_state->current_branch = NULL;
 	if (startup_info->have_repository && !early) {
 		const char *head_ref = refs_resolve_ref_unsafe(
-			get_main_ref_store(repo), "HEAD", 0, NULL, &flag);
+			get_main_ref_store(repo), "HEAD", NULL, 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
 			repo->remote_state->current_branch = make_branch(
@@ -1201,7 +1201,7 @@ static char *guess_ref(const char *name, struct ref *peer)
 	struct strbuf buf = STRBUF_INIT;
 
 	const char *r = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						peer->name,
+						peer->name, NULL,
 						RESOLVE_REF_READING,
 						NULL, NULL);
 	if (!r)
@@ -1321,7 +1321,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		int flag;
 
 		dst_value = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						    matched_src->name,
+						    matched_src->name, NULL,
 						    RESOLVE_REF_READING,
 						    NULL, &flag);
 		if (!dst_value ||
diff --git a/revision.c b/revision.c
index 7ddf0f151a3..6aca4f42303 100644
--- a/revision.c
+++ b/revision.c
@@ -2920,7 +2920,7 @@ static void NORETURN diagnose_missing_default(const char *def)
 	const char *refname;
 
 	refname = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					  def, 0, NULL, &flags);
+					  def, NULL, 0, NULL, &flags);
 	if (!refname || !(flags & REF_ISSYMREF) || (flags & REF_ISBROKEN))
 		die(_("your current branch appears to be broken"));
 
diff --git a/sequencer.c b/sequencer.c
index aa2a2398357..cf7a2a9a112 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -839,10 +839,10 @@ static int is_index_unchanged(struct repository *r)
 	struct index_state *istate = r->index;
 	const char *head_name;
 
-	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
+	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), "HEAD", NULL, RESOLVE_REF_READING, &head_oid, NULL)) {
 		/* Check to see if this is an unborn branch */
 		head_name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						    "HEAD",
+						    "HEAD", NULL,
 						    RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 						    &head_oid, NULL);
 		if (!head_name ||
@@ -1480,7 +1480,7 @@ void print_commit_summary(struct repository *r,
 	diff_setup_done(&rev.diffopt);
 
 	refs = get_main_ref_store(r);
-	head = refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL);
+	head = refs_resolve_ref_unsafe(refs, "HEAD", NULL, 0, NULL, NULL);
 	if (!head)
 		die(_("unable to resolve HEAD after creating commit"));
 	if (!strcmp(head, "HEAD"))
@@ -4715,7 +4715,7 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 	if (!refs_ref_exists(get_main_ref_store(r), refname))
 		return 0;
 
-	if (!refs_resolve_ref_unsafe(get_main_ref_store(r), refname,
+	if (!refs_resolve_ref_unsafe(get_main_ref_store(r), refname, NULL,
 				     RESOLVE_REF_READING, &stash_oid, &flag))
 		return -1;
 	if (flag & REF_ISSYMREF)
@@ -6213,6 +6213,7 @@ static int add_decorations_to_list(const struct commit *commit,
 	const struct name_decoration *decoration = get_name_decoration(&commit->object);
 	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 						       "HEAD",
+						       NULL,
 						       RESOLVE_REF_READING,
 						       NULL,
 						       NULL);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index c9efd74c2b5..ef1d6acbfae 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -184,7 +184,7 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 	int flags;
 	const char *ref;
 
-	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
+	ref = refs_resolve_ref_unsafe(refs, refname, NULL, resolve_flags,
 				      &oid, &flags);
 	printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", flags);
 	return ref ? 0 : 1;
diff --git a/transport-helper.c b/transport-helper.c
index 780fcaf5292..27d85748b60 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1110,6 +1110,7 @@ static int push_refs_with_export(struct transport *transport,
 					/* Follow symbolic refs (mainly for HEAD). */
 					name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 								       ref->peer_ref->name,
+								       NULL,
 								       RESOLVE_REF_READING,
 								       &oid,
 								       &flag);
diff --git a/transport.c b/transport.c
index 0ad04b77fd2..8818ba75e7a 100644
--- a/transport.c
+++ b/transport.c
@@ -101,7 +101,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		localname = ref->peer_ref->name;
 		remotename = ref->name;
 		tmp = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					      localname, RESOLVE_REF_READING,
+					      localname, NULL, RESOLVE_REF_READING,
 					      NULL, &flag);
 		if (tmp && flag & REF_ISSYMREF &&
 			starts_with(tmp, "refs/heads/"))
diff --git a/upload-pack.c b/upload-pack.c
index bbfb04c8bd8..4fddc081237 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1291,7 +1291,7 @@ static int find_symref(const char *refname,
 	if ((flag & REF_ISSYMREF) == 0)
 		return 0;
 	symref_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						refname, 0, NULL, &flag);
+						refname, NULL, 0, NULL, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
 		die("'%s' is a symref but it is not?", refname);
 	item = string_list_append(cb_data, strip_namespace(refname));
diff --git a/worktree.c b/worktree.c
index 12eadacc618..ed89bab481d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -42,6 +42,7 @@ static void add_head_info(struct worktree *wt)
 
 	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
 					 "HEAD",
+					 NULL,
 					 0,
 					 &wt->head_oid, &flags);
 	if (!target)
@@ -448,7 +449,7 @@ int is_shared_symref(const struct worktree *wt, const char *symref,
 	}
 
 	refs = get_worktree_ref_store(wt);
-	symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
+	symref_target = refs_resolve_ref_unsafe(refs, symref, NULL, 0,
 						NULL, &flags);
 	if ((flags & REF_ISSYMREF) &&
 	    symref_target && !strcmp(symref_target, target))
@@ -549,6 +550,7 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 		strbuf_worktree_ref(wt, &refname, "HEAD");
 		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 					    refname.buf,
+					    NULL,
 					    RESOLVE_REF_READING,
 					    &oid, &flag))
 			ret = fn(refname.buf, &oid, flag, cb_data);
-- 
gitgitgadget

