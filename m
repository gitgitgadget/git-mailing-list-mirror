Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07943EE1EC
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190712; cv=none; b=pndDTTV+9PjoFmkHbNp24E2uGDpvfzGfX8f7yGjiNCKgu/S5dQGPY4lAPIEkUMA3H9TjjRvXPElkDE4axlbpL7hdYF8iv0bpxHvaUZyPBwSSdoLUAszWltapHssPn5D5W4mU+rdVFvBbwbZvIhwixpdYzzgZEvABoEq5bjp8l7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190712; c=relaxed/simple;
	bh=E7ONXqoKi01Nlcq9pUgfP3zx2sFUPZKNlE3UdedM1ww=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=O4RqbNI/QUxLCXNjxyLbBU2E5xDOfHlMgqPmXrOuvq5hhuzv55Ed4yljbz+1R1x3nGL2hq0SYL+BLA/HMyD6XcT1TEZzq9ZM27VNEux0APp/oc5c/UIqjBzC4cF+l5VH1GlkJFWBZdJjgloOT8r+6UnhmZ5LYWjf7SZBK7XY2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKRSMTvt; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKRSMTvt"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4960fb63c75so1801031b6e.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784190709; x=1784795509; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OLS9JSHtoZQkwpR5Z/UXr21c7Of7u+9JVksR/1nQ754=;
        b=nKRSMTvtOh1MuJfOwJzOn28eq++mpuGeIBy2IOClNNahvQjqkaWKY0sEctJaKsUoII
         ww5bR2Gh2BhAMT45haCNOScAfn5GgXeSXtAbrLetOZmiEsyLbpzbJ6+HZNKHv3fTIt78
         HndEiLzNjtnLMq/bs7rV0ALRDD9z8SBUZytOW6600pdN2zyoKlFHN7+QC8W8p7V7kgCu
         yTJlZzYoBV+xehSDKTcS21cyJT8LWMii3DtZAKpannETEre4hdgWdIEpr4azIp/HwPaH
         YmJs5PP9irSHOxITu2rdYdFm+ypf3wQmttWITGvO0cVTH+uTqrHLsiIfYmmMogksQ5Zu
         Efiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784190709; x=1784795509;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OLS9JSHtoZQkwpR5Z/UXr21c7Of7u+9JVksR/1nQ754=;
        b=kNQz7Mdt9o9PGrodNxSWtBy/bMfHm4K/v/hy4b/M8M20fkIz35kEuaaChsHmNQFmH5
         jG09WZMYbkwwhOfMLi8iWDXsckdEevH6T2bkJpFcl2d6ZoxSCqTubi9EgAiTdm5vr5Ko
         aMo6kDKgfHAkt+I0Vg/29NLl7N23xOPGX56V6w+pf4IFdJ36vqY4wTIeJkKcQJ16LxN+
         qbixgaTEVVvVNqUcS6KMFDTg3ryT2S3bVFAbyRg74bnr5SOkenPfNfdCBR4sFTFoCoU8
         uF+Vs2UcS05KYiZhrYDMh47/yOqyWJ/mOXqma5WV6wkKWhf+dGN00u03wedoaJ8PdpDM
         0YoA==
X-Gm-Message-State: AOJu0Yx/XVODcBQUSen5GBQpnoNoVsuL+CouJ+oP3MwwCMoGd8IXZqqk
	4LKVfH+Cn+TJvUp9vAiIDwYPwN/EF6VMd4amAE0FYcI6vSjTt0Cu1dicQ4fumA==
X-Gm-Gg: AfdE7cl/v/0PCXc/tLtAPN1dpIm0O3ooRe0ft3T1xgloSVr2TVRM56BZZv8wFVS3bKR
	hfJna97zhTRQ/UZ2jLdhv+gWgFGr4PnlvnWbkLF4TAiDqlEXXjU+JNpy1QfNEUOqzU2rctwu7iF
	uB2MHoFYLAbjnfJFEZLVIgLQyruBCIqRFa848adzT1STW8oUernHVqAquAaUQqQ14x4XdJMHTLj
	a//leGwpL2ZgFVnc+6pu8Ch31yPlVcgiAcd4dWJe7yvw5fnMeBkfCc4mL6pqWn0Y3sSP7mEyk4w
	rZDkH2WPsd7h74bekUrmL/CwrTEjy9jYGA9grHeSX1/Nk5eY8Eu1RlvHAF+7yEY1OsQYirZolXo
	5Kko43VV8SQ/1HKT/JPiqTsnS45JE41SgMg0GzmuHhQngy0QzmevZaB8PC1sbNrvm25uNMd0FzJ
	mwnQ==
X-Received: by 2002:a05:6808:1405:b0:497:13b6:91b with SMTP id 5614622812f47-4a42b0bbc67mr14733290b6e.41.1784190708590;
        Thu, 16 Jul 2026 01:31:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.29.21])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b01f1722sm18121089b6e.16.2026.07.16.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 01:31:47 -0700 (PDT)
Message-Id: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
From: "Emin =?UTF-8?Q?=C3=96zata?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 08:31:45 +0000
Subject: [PATCH] stash: add 'rename' subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Greg Hewgill <greg@hewgill.com>,
    Micheil Smith <micheil@brandedcode.com>,
    Michael Haggerty <mhagger@alum.mit.edu>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Emin =?UTF-8?Q?=C3=96zata?= <eminozata@proton.me>,
    =?UTF-8?q?Emin=20=C3=96zata?= <eminozata@proton.me>

From: =?UTF-8?q?Emin=20=C3=96zata?= <eminozata@proton.me>

There is no way to change the message of a stash entry after the
fact.  The only option is dropping the entry and re-storing it by
hand, which moves it to the top of the stash list and gets fiddly
for deeper entries.

Add 'git stash rename <message> [<stash>]', defaulting to the
latest entry like the other subcommands do.  It reads the object id
and reflog message of the target entry and of the entries above it,
drops them all like 'git stash drop' would, and stores them back in
the same order, with the new message going to the target.  Position,
contents and the reflog chain stay as they were.

The command checks every entry it is about to rewrite and refuses
to start if one of them does not look like a stash commit, which
can only happen when refs/stash was written to by hand.  Finding
that out halfway through the sequence would lose entries.  Should a
write-back fail anyway, the entry's object id is reported so it can
be recovered with 'git stash store', and the command only reports
success when the reflog ended up in the requested state.

This was proposed before: in 2010, as a "git reflog update" command
that edited reflog entries in place [1].  When it came up again in
2013 [2], Junio rejected it on the grounds that reflogs are
append-only recovery logs, and that whoever really cares about a
stash message can pop and re-stash [3].  Michael Haggerty pointed
out in that thread that refs/stash does not fit the description:
its reflog is the primary data store for stash entries, and 'git
stash drop' rewrites it all the time [4].  So this patch stays away
from the reflog machinery entirely and does the suggested
pop-and-re-stash workaround mechanically, without the detour
through the working tree.

The sequence only works if entry positions hold still while it
runs, so the command takes index-based selectors (stash@{1}) and
rejects time-based ones.  It also refreshes the reflog timestamps
of the rewritten entries, and renaming stash@{n} costs n+1 reflog
deletions and ref updates.

[1] https://lore.kernel.org/git/20100620093142.GF24805@occam.hewgill.net/
[2] https://lore.kernel.org/git/loom.20130104T192132-16@post.gmane.org/
[3] https://lore.kernel.org/git/7vbod4tynt.fsf@alter.siamese.dyndns.org/
[4] https://lore.kernel.org/git/50ED2C78.1030300@alum.mit.edu/

Signed-off-by: Emin Özata <eminozata@proton.me>
---
    stash: add 'rename' subcommand
    
    eo/stash-rename
    
    "git stash rename" learned to change the message of an existing stash
    entry without changing its position or its contents.
    
    This came up in 2010 and again in 2013, and was rejected back then
    because the proposed implementation rewrote reflog entries in place.
    This version doesn't: it does the drop-and-re-store dance that was
    suggested as the manual workaround, with the machinery stash already
    uses for drop and store, and touches nothing but refs/stash. Details and
    links to the old threads are in the commit message.
    
    Costs, so nobody has to dig for them: rewritten entries get fresh reflog
    timestamps (hence index-only selectors), and renaming stash@{n} does n+1
    reflog deletions, each of them a locked rewrite of the whole reflog. The
    sequence is not atomic either: a failure halfway is handled by writing
    the collected entries back best-effort, whatever cannot be written back
    is reported with its object id so "git stash store" can recover it, and
    a process killed between the drop and store phases loses the collected
    entries (git fsck still finds them). A single refs_reflog_expire() pass
    would cut both the I/O and that window down, and closing the window for
    real needs a new refs API operation; I'd rather do either as a follow-up
    if the feature is wanted at all.
    
    I picked a positional <message> over -m <message> ("stash store" style);
    no strong opinion, happy to switch.
    
    t3903 passes with GIT_TEST_DEFAULT_REF_FORMAT=files and reftable.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2180%2Fozemin%2Fstash-rename-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2180/ozemin/stash-rename-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2180

 Documentation/git-stash.adoc           |  11 +-
 builtin/stash.c                        | 197 +++++++++++++++++++++++--
 contrib/completion/git-completion.bash |   4 +-
 t/t3903-stash.sh                       |  79 ++++++++++
 4 files changed, 276 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 50bb89f483..03f2e03096 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -25,6 +25,7 @@ git stash create [<message>]
 git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
 git stash export (--print | --to-ref <ref>) [<stash>...]
 git stash import <commit>
+git stash rename [-q | --quiet] <message> [<stash>]
 
 DESCRIPTION
 -----------
@@ -163,6 +164,12 @@ with no conflicts.
 	created by `export`, and add them to the list of stashes.  To replace the
 	existing stashes, use `clear` first.
 
+`rename [-q | --quiet] <message> [<stash>]`::
+	Change the message of a single stash entry.  The entry keeps its
+	position and its contents.  _<stash>_ must name an entry by
+	index (e.g. `stash@{1}`); renaming refreshes the reflog
+	timestamps of the entry and of the entries above it.
+
 OPTIONS
 -------
 `-a`::
@@ -258,7 +265,7 @@ literally (including newlines and quotes).
 `-q`::
 `--quiet`::
 	This option is only valid for `apply`, `drop`, `pop`, `push`,
-	`save`, `store` commands.
+	`rename`, `save`, `store` commands.
 +
 Quiet, suppress feedback messages.
 
@@ -292,7 +299,7 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 _<stash>_::
 	This option is only valid for `apply`, `branch`, `drop`, `pop`,
-	`show`, and `export` commands.
+	`show`, `export`, and `rename` commands.
 +
 A reference of the form `stash@{<revision>}`. When no _<stash>_ is
 given, the latest stash is assumed (that is, `stash@{0}`).
diff --git a/builtin/stash.c b/builtin/stash.c
index c4809f299a..94e66d6074 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -63,6 +63,8 @@
 	N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
 #define BUILTIN_STASH_IMPORT_USAGE \
 	N_("git stash import <commit>")
+#define BUILTIN_STASH_RENAME_USAGE \
+	N_("git stash rename [-q | --quiet] <message> [<stash>]")
 #define BUILTIN_STASH_CLEAR_USAGE \
 	"git stash clear"
 
@@ -80,6 +82,7 @@ static const char * const git_stash_usage[] = {
 	BUILTIN_STASH_STORE_USAGE,
 	BUILTIN_STASH_EXPORT_USAGE,
 	BUILTIN_STASH_IMPORT_USAGE,
+	BUILTIN_STASH_RENAME_USAGE,
 	NULL
 };
 
@@ -143,6 +146,11 @@ static const char * const git_stash_import_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_rename_usage[] = {
+	BUILTIN_STASH_RENAME_USAGE,
+	NULL
+};
+
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -820,18 +828,12 @@ static int reflog_is_empty(const char *refname)
 					 refname, reject_reflog_ent, NULL);
 }
 
-static int do_drop_stash(struct stash_info *info, int quiet)
+static int drop_reflog_entry(const char *revision)
 {
-	if (!reflog_delete(info->revision.buf,
-			   EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_UPDATE_REF,
-			   0)) {
-		if (!quiet)
-			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
-				  oid_to_hex(&info->w_commit));
-	} else {
-		return error(_("%s: Could not drop stash entry"),
-			     info->revision.buf);
-	}
+	if (reflog_delete(revision,
+			  EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_UPDATE_REF,
+			  0))
+		return error(_("%s: Could not drop stash entry"), revision);
 
 	if (reflog_is_empty(ref_stash))
 		do_clear_stash();
@@ -839,6 +841,18 @@ static int do_drop_stash(struct stash_info *info, int quiet)
 	return 0;
 }
 
+static int do_drop_stash(struct stash_info *info, int quiet)
+{
+	if (drop_reflog_entry(info->revision.buf))
+		return -1;
+
+	if (!quiet)
+		printf_ln(_("Dropped %s (%s)"), info->revision.buf,
+			  oid_to_hex(&info->w_commit));
+
+	return 0;
+}
+
 static int get_stash_info_assert(struct stash_info *info, int argc,
 				 const char **argv)
 {
@@ -1190,6 +1204,166 @@ out:
 	return ret;
 }
 
+struct rename_entry {
+	struct object_id oid;
+	char *msg;
+};
+
+struct rename_data {
+	struct rename_entry *entries;
+	size_t nr, alloc;
+	size_t want;
+};
+
+static int collect_rename_entries(const char *refname UNUSED,
+				  struct object_id *old_oid UNUSED,
+				  struct object_id *new_oid,
+				  const char *committer UNUSED,
+				  timestamp_t timestamp UNUSED,
+				  int tz UNUSED, const char *msg,
+				  void *cb_data)
+{
+	struct rename_data *data = cb_data;
+	const char *eol = strchrnul(msg, '\n');
+
+	ALLOC_GROW(data->entries, data->nr + 1, data->alloc);
+	oidcpy(&data->entries[data->nr].oid, new_oid);
+	data->entries[data->nr].msg = xstrndup(msg, eol - msg);
+	data->nr++;
+
+	return data->nr >= data->want;
+}
+
+static int parse_stash_index(const char *revision, size_t *idx)
+{
+	const char *num = strstr(revision, "@{");
+	char *end;
+
+	if (!num || !isdigit(num[2]))
+		return -1;
+	*idx = strtoumax(num + 2, &end, 10);
+	if (*end != '}' || end[1])
+		return -1;
+
+	return 0;
+}
+
+static int store_rename_entry(struct rename_entry *entry, const char *msg)
+{
+	if (!do_store_stash(&entry->oid, msg, 1))
+		return 0;
+	warning(_("could not restore stash entry %s; "
+		  "recover it with 'git stash store %s'"),
+		oid_to_hex(&entry->oid), oid_to_hex(&entry->oid));
+	return -1;
+}
+
+static int do_rename_stash(struct stash_info *info, size_t idx,
+			   const char *msg, int quiet)
+{
+	struct rename_data data = { .want = idx + 1 };
+	size_t i, missing = 0;
+	int ret = -1;
+
+	refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository),
+					 ref_stash, collect_rename_entries,
+					 &data);
+	if (data.nr <= idx) {
+		error(_("%s does not exist"), info->revision.buf);
+		goto cleanup;
+	}
+
+	if (!oideq(&info->w_commit, &data.entries[idx].oid)) {
+		error(_("%s changed concurrently; try again"),
+		      info->revision.buf);
+		goto cleanup;
+	}
+
+	/* refuse up front; do_store_stash() would die halfway through */
+	for (i = 0; i < data.nr; i++) {
+		struct commit *stash = lookup_commit_reference(the_repository,
+							       &data.entries[i].oid);
+
+		if (!stash || check_stash_topology(the_repository, stash)) {
+			error(_("%s does not look like a stash commit"),
+			      oid_to_hex(&data.entries[i].oid));
+			goto cleanup;
+		}
+	}
+
+	while (missing <= idx) {
+		if (drop_reflog_entry("stash@{0}"))
+			goto restore;
+		missing++;
+	}
+
+	ret = 0;
+	while (missing) {
+		i = missing - 1;
+		if (store_rename_entry(&data.entries[i],
+				       i == idx ? msg : data.entries[i].msg))
+			ret = -1;
+		missing--;
+	}
+
+	if (!ret && !quiet)
+		printf_ln(_("Renamed %s (%s)"), info->revision.buf,
+			  oid_to_hex(&data.entries[idx].oid));
+	goto cleanup;
+
+restore:
+	/* dropping failed midway; put the dropped entries back */
+	while (missing) {
+		store_rename_entry(&data.entries[missing - 1],
+				   data.entries[missing - 1].msg);
+		missing--;
+	}
+cleanup:
+	for (i = 0; i < data.nr; i++)
+		free(data.entries[i].msg);
+	free(data.entries);
+	return ret;
+}
+
+static int rename_stash(int argc, const char **argv, const char *prefix,
+			struct repository *repo UNUSED)
+{
+	int ret = -1;
+	int quiet = 0;
+	size_t idx;
+	struct stash_info info = STASH_INFO_INIT;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_rename_usage, 0);
+
+	if (!argc)
+		usage_with_options(git_stash_rename_usage, options);
+
+	if (!argv[0][strspn(argv[0], " \t\r\n")]) {
+		ret = error(_("stash message cannot be empty"));
+		goto cleanup;
+	}
+
+	if (get_stash_info_assert(&info, argc - 1, argv + 1))
+		goto cleanup;
+
+	/* positions must stay stable across the drop-and-store sequence */
+	if (parse_stash_index(info.revision.buf, &idx)) {
+		error(_("cannot rename '%s': name the entry by index, "
+			"like 'stash@{1}'"), info.revision.buf);
+		goto cleanup;
+	}
+
+	ret = do_rename_stash(&info, idx, argv[0], quiet);
+cleanup:
+	free_stash_info(&info);
+	return ret;
+}
+
 static void add_pathspecs(struct strvec *args,
 			  const struct pathspec *ps) {
 	int i;
@@ -2472,6 +2646,7 @@ int cmd_stash(int argc,
 		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
 		OPT_SUBCOMMAND("export", &fn, export_stash),
 		OPT_SUBCOMMAND("import", &fn, import_stash),
+		OPT_SUBCOMMAND("rename", &fn, rename_stash),
 		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..08c53cea49 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3465,7 +3465,7 @@ _git_sparse_checkout ()
 
 _git_stash ()
 {
-	local subcommands='push list show apply clear drop pop create branch import export'
+	local subcommands='push list show apply clear drop pop create branch import export rename'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
 
 	if [ -z "$subcommand" ]; then
@@ -3508,7 +3508,7 @@ _git_stash ()
 	import,*)
 		__git_complete_refs
 		;;
-	show,*|apply,*|drop,*|pop,*|export,*)
+	show,*|apply,*|drop,*|pop,*|export,*|rename,*)
 		__gitcomp_nl "$(__git stash list \
 				| sed -n -e 's/:.*//p')"
 		;;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ecc35aae82..f175302c1a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1831,4 +1831,83 @@ test_expect_success 'stash show --include-untracked includes untracked files' '
 	test_grep "untracked" actual
 '
 
+test_expect_success 'rename a stash entry' '
+	git stash clear &&
+	>file-to-rename &&
+	git add file-to-rename &&
+	git stash push -m "original message" &&
+	git stash rename "new message" stash@{0} >out &&
+	test_grep "Renamed stash@{0}" out &&
+	git stash list >list &&
+	test_grep "stash@{0}: new message" list &&
+	test_grep ! "original message" list
+'
+
+test_expect_success 'rename defaults to the latest stash entry' '
+	git stash rename "default target" >out &&
+	test_grep "Renamed refs/stash@{0}" out &&
+	git stash list >list &&
+	test_grep "stash@{0}: default target" list
+'
+
+test_expect_success 'rename a deeper stash entry keeps positions and states' '
+	git stash clear &&
+	for i in 1 2 3
+	do
+		>file$i &&
+		git add file$i &&
+		git stash push -m "message $i" || return 1
+	done &&
+	git rev-parse stash@{0} stash@{1} stash@{2} >expect &&
+	git stash rename "renamed middle" stash@{1} &&
+	git rev-parse stash@{0} stash@{1} stash@{2} >actual &&
+	test_cmp expect actual &&
+	git stash list >list &&
+	test_grep "stash@{0}: On.*message 3" list &&
+	test_grep "stash@{1}: renamed middle" list &&
+	test_grep "stash@{2}: On.*message 1" list
+'
+
+test_expect_success 'rename the deepest stash entry' '
+	git rev-parse stash@{0} stash@{1} stash@{2} >expect &&
+	git stash rename "renamed deepest" stash@{2} &&
+	git rev-parse stash@{0} stash@{1} stash@{2} >actual &&
+	test_cmp expect actual &&
+	git stash list >list &&
+	test_grep "stash@{2}: renamed deepest" list
+'
+
+test_expect_success 'rename accepts a bare index and honors --quiet' '
+	git stash rename -q "quietly renamed" 1 >out &&
+	test_must_be_empty out &&
+	git stash list >list &&
+	test_grep "stash@{1}: quietly renamed" list
+'
+
+test_expect_success 'rename rejects bad arguments' '
+	test_must_fail git stash rename "no such entry" stash@{99} &&
+	test_must_fail git stash rename "" &&
+	test_must_fail git stash rename "   " &&
+	test_must_fail git stash rename "not a stash" HEAD &&
+	test_must_fail git stash rename "not an index" "stash@{now}" &&
+	test_expect_code 129 git stash rename &&
+	git stash list >list &&
+	test_grep "stash@{1}: quietly renamed" list
+'
+
+test_expect_success 'rename refuses to rewrite a non-stash reflog entry' '
+	git stash clear &&
+	>real-a &&
+	git add real-a &&
+	git stash push -m "real A" &&
+	git update-ref -m junk --create-reflog refs/stash HEAD &&
+	>real-b &&
+	git add real-b &&
+	git stash push -m "real B" &&
+	git stash list >expect &&
+	test_must_fail git stash rename "renamed A" stash@{2} &&
+	git stash list >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
-- 
gitgitgadget
