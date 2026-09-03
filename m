Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9494BB5A0
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446420; cv=none; b=lf1gceUSycUu6p7o+XEKoInRkAo3JEMBYXzfgqWQ7d9JQBVHYwLcf7llD/YgGhMVzfiJ5TOGpqfCNkymqIqVmpGMqmMFDqXtByhqbNaDoWBCEpUyHShTL/jTXwd79h+HfRC80Nffju/yExo/TDRr14DPhY3Xa5Kjad2AT6u7fJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446420; c=relaxed/simple;
	bh=fgQjVoosy5WAmRrUIriwZ49lic86u1sImkLd59Kkhy8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HBupXDkZLGuhs/e80ZXM7sy9FyJYetfPjOOpxSJGqIYVEmpyTHlUqiSX5aIxlJ8M9ERJDJBZii06Uuw/DG+DaGq4NPSoQpk6E2DNKQt0z/Ij2Nt06to1UV6sHBFk/sbZgOOVcwAuM1QO7/FW9Fi289daQvp64WVRlqetlkYMUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jElckjL/; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jElckjL/"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39ca300db70so19179091fa.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 07:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446407; x=1789051207; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DC70RaKjHMMzQ0axDO2v1va6MSrbikP9nKYWshU7eEY=;
        b=jElckjL/Cv0u3Z+sMESvYvRbmQ4E6FaFNNcyu73Pt87DkXdRgsVRwlC3MoQJev0eKf
         c2pVRb9EMVGYJ9uMEzYyTNtIaOVwjg4x3LQCm8cmnQoiN+c4SvfAPDTQVERpBz2WrFVq
         EcZkfeKvKkd5KjHBfheE+pJ4GK4aYt1Uy0vh1lmTjeF7vwJAsplTb2LnEWP+NZj+Q02+
         ZIN4UFihNN9nAlqmjbKunif3L8NUd93DEGYxwkMAG/V2V1Gz6mUAv/sn3UYguXZcdsDV
         h745cOHruHl932WuYeX7Y5HqeC6jpY5gkr4vDsWE0Fos7fcyq9QExqzX51GsS+2n05Nc
         oPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446407; x=1789051207;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DC70RaKjHMMzQ0axDO2v1va6MSrbikP9nKYWshU7eEY=;
        b=CGttB/f2/JgKzBEGPFBLilv3JqscnpJaqusGMj+vUx1Gvg58cx7PgfyLzih4zaxxN1
         gzNI7iiWC9LMBKtQH4CIPO2G+UdgWbDls9Sz1awcWd19eKzitB9lQMaL16Ug1vuGv4BH
         hjGQIFXtoCwmKStM2L6cdi/T0xzN7KIDE608ygFYFWOoiiZKAaj5cHY5Fc7Re8sQzXl8
         sy9rPN54RX2qLodoqcX1xjVmG9zlg5kMXllR6AQL+aG44Xgu3IniChQib/A5MjNfMurF
         MyzI0Q9pjju2jZlIGtuwAHv5UGpsdW6fW6Y4sNwIhtIUPGOyKORspmDHXmaFGHOgIBBV
         4bcA==
X-Gm-Message-State: AFuF++mEsgO8hq0LnXH87ptyRfEgyGaKxlcAafVDVPivBnIXxwsHIGCb
	MWkBh0A6z6sYDW4kPXuoq6cqAc0M8MrN+N4Hm045dOSBMkli8PnNO+5JlxhzUu+v
X-Gm-Gg: AYBFou2ebkzy4NJ3sHDQI5fwIDHhUyzjPgNm2W+U2yahG1Q5Sb9BeLWWCqA8kUreoHK
	K0jbeBNbaSU0TWcrOO/W8Edl6AV+Shn4QKYGj/V2cHYnH+Y5dbzDtCSQ1cMtmk61on3g9CLeua2
	n7jimdhyvMiOMwi/PkjEzOq0Ga5ND/6S3cFB7HUcbGHCscJ84HbxaxvHPSDJjmOGxU/WDvw5JNR
	REEKyA3yjVSY3JGaIwCw3bhnCM92Y8AjuDjWkfHGpn/vR9XWQ/LB5kSVk8HN5EH7PHVWjlrX3Fj
	Cf8enD36iQATMX2Xvrzl38khk/HRwF68UF+3uqMS4ImRCOnsUmTPIYSSzT4Ur42kOqvAYiotUJl
	3DOnftYycKI+YlLRvTE5KyTbHQWTI3fKk+4oVRfUXF5XHIe7QIdBeSb0lk5rnKPBQm/600Sq4P3
	L8LQ7rbLCKzNxDK6yzusWIiuGvpgiMdQFnmtrzx2G6Hr+G/k8+f9RoHG+W7eSxUnnsNw==
X-Received: by 2002:a05:6512:2c8b:b0:5b5:a8ab:3500 with SMTP id 2adb3069b0e04-5b609196955mr3832225e87.2.1788446407074;
        Thu, 03 Sep 2026 07:40:07 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.215.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b606ba13desm1348299e87.59.2026.09.03.07.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:40:05 -0700 (PDT)
Message-Id: <fe22b1bfa6b04b71ca2df6f524ad8d18663b9a17.1788446398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2364.v5.git.git.1788446398.gitgitgadget@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v5.git.git.1788446398.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 14:39:57 +0000
Subject: [PATCH v5 1/2] stash: reserve exit status 1 for conflicts
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git stash apply", "pop" and "branch" exit with status 1 both when
applying the stash entry resulted in conflicts and when they fail for
other reasons, so callers cannot tell the two apart.

Follow the convention of "git merge-tree" and the merge strategies,
which exit with status 1 to indicate conflicts and with a different
non-zero status for errors: those subcommands now exit with status 1
only when applying the stash entry resulted in conflicts, in which
case the stash entry is left in place, and exit with status 128, the
status die() uses, when they fail for other reasons.  Document the
exit statuses.

The only subcommand implementations that can return a positive value
are "apply", "pop" and "branch", which return the value of
do_apply_stash(): "apply" returns it directly, and "pop" and "branch"
drop the stash entry, via do_drop_stash(), which always returns 0,
only when the application succeeded.  do_apply_stash() only returns a
positive value when the three-way merge was unclean.  cmd_stash() now
maps negative values to 128 and passes positive values through as the
exit status, so exit status 1 unambiguously indicates conflicts.
enum stash_apply_result makes the convention explicit, and the
autostash helpers use it to tell users that their stashed changes
were saved when applying them fails.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-stash.adoc |   9 +++
 builtin/stash.c              |  33 +++++++---
 sequencer.c                  | 113 ++++++++++++++++++++++-------------
 sequencer.h                  |  19 +++---
 stash.h                      |  21 +++++++
 t/t3903-stash.sh             |  25 +++++++-
 6 files changed, 160 insertions(+), 60 deletions(-)
 create mode 100644 stash.h

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 50bb89f483..fc6a9a008c 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -426,6 +426,15 @@ include::includes/cmd-config-section-all.adoc[]
 :git-stash: 1
 include::config/stash.adoc[]
 
+EXIT STATUS
+-----------
+
+The `git stash` subcommands exit with status 0 on success.  The
+subcommands that apply a stash entry, i.e. `apply`, `pop` and `branch`,
+exit with status 1 when applying the stash entry resulted in conflicts,
+in which case the stash entry is left in place, and with a non-zero
+status other than 1 when they fail for other reasons.
+
 
 SEE ALSO
 --------
diff --git a/builtin/stash.c b/builtin/stash.c
index 72c52571f8..7a9843413b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -10,6 +10,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "stash.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
@@ -640,10 +641,12 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 		die(_("could not write index"));
 }
 
-static int do_apply_stash(const char *prefix, struct stash_info *info,
-			  int index, int quiet,
-			  const char *label_ours, const char *label_theirs,
-			  const char *label_base)
+static enum stash_apply_result do_apply_stash(const char *prefix,
+					      struct stash_info *info,
+					      int index, int quiet,
+					      const char *label_ours,
+					      const char *label_theirs,
+					      const char *label_base)
 {
 	int clean, ret;
 	int has_index = index;
@@ -717,8 +720,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 	/*
 	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
-	 * merge was clean, and nonzero if the merge was unclean or encountered
-	 * an error.
+	 * merge was clean, and 1 if the merge was unclean or a negative value
+	 * if it encountered an error.
 	 */
 	ret = clean >= 0 ? !clean : clean;
 
@@ -2492,10 +2495,22 @@ int cmd_stash(int argc,
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
-	if (fn)
-		return !!fn(argc, argv, prefix, repo);
-	else if (!argc)
+	if (fn) {
+		ret = fn(argc, argv, prefix, repo);
+
+		/*
+		 * The subcommand implementations return 0 on success, a
+		 * negative value on failure, and STASH_APPLY_CONFLICT
+		 * when applying a stash entry resulted in conflicts.
+		 * Map failures to 128, the status die() uses, so that
+		 * exit status 1 unambiguously indicates conflicts.
+		 */
+		if (ret < 0)
+			return 128;
+		return ret;
+	} else if (!argc) {
 		return !!push_stash_unassumed(0, NULL, prefix, repo);
+	}
 
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..e4a6ddfd01 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -19,6 +19,7 @@
 #include "commit.h"
 #include "sequencer.h"
 #include "run-command.h"
+#include "stash.h"
 #include "hook.h"
 #include "utf8.h"
 #include "cache-tree.h"
@@ -4794,31 +4795,50 @@ void create_autostash_ref(struct repository *r, const char *refname,
 	create_autostash_internal(r, NULL, refname, message, silent);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
-				    const char *label_ours, const char *label_theirs,
-				    const char *label_base,
-				    const char *stash_msg)
+static enum stash_apply_result do_stash_apply(const char *stash_oid,
+					      const char *label_ours,
+					      const char *label_theirs,
+					      const char *label_base)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
-	int ret = 0;
 
-	if (attempt_apply) {
-		child.git_cmd = 1;
-		child.no_stdout = 1;
-		child.no_stderr = 1;
-		strvec_push(&child.args, "stash");
-		strvec_push(&child.args, "apply");
-		if (label_ours)
-			strvec_pushf(&child.args, "--label-ours=%s", label_ours);
-		if (label_theirs)
-			strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
-		if (label_base)
-			strvec_pushf(&child.args, "--label-base=%s", label_base);
-		strvec_push(&child.args, stash_oid);
-		ret = run_command(&child);
-	}
-
-	if (attempt_apply && !ret)
+	child.git_cmd = 1;
+	child.no_stdout = 1;
+	child.no_stderr = 1;
+	strvec_push(&child.args, "stash");
+	strvec_push(&child.args, "apply");
+	if (label_ours)
+		strvec_pushf(&child.args, "--label-ours=%s", label_ours);
+	if (label_theirs)
+		strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
+	if (label_base)
+		strvec_pushf(&child.args, "--label-base=%s", label_base);
+	strvec_push(&child.args, stash_oid);
+
+	switch (run_command(&child)) {
+	case 0:
+		return STASH_APPLY_CLEAN;
+	case STASH_APPLY_CONFLICT:
+		return STASH_APPLY_CONFLICT;
+	default:
+		return STASH_APPLY_ERROR;
+	}
+}
+
+static enum stash_apply_result apply_save_autostash_oid(const char *stash_oid,
+							int attempt_apply,
+							const char *label_ours,
+							const char *label_theirs,
+							const char *label_base,
+							const char *stash_msg)
+{
+	enum stash_apply_result ret = STASH_APPLY_CLEAN;
+
+	if (attempt_apply)
+		ret = do_stash_apply(stash_oid, label_ours, label_theirs,
+				     label_base);
+
+	if (attempt_apply && ret == STASH_APPLY_CLEAN)
 		fprintf(stderr, _("Applied autostash.\n"));
 	else {
 		struct child_process store = CHILD_PROCESS_INIT;
@@ -4832,13 +4852,16 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
 			ret = error(_("cannot store %s"), stash_oid);
-		else if (attempt_apply)
+		else if (attempt_apply && ret == STASH_APPLY_CONFLICT)
 			fprintf(stderr,
 				_("Your local changes are stashed, however applying them\n"
 				  "resulted in conflicts.  You can either resolve the conflicts\n"
 				  "and then discard the stash with \"git stash drop\", or, if you\n"
 				  "do not want to resolve them now, run \"git reset --hard\" and\n"
 				  "apply the local changes later by running \"git stash pop\".\n"));
+		else if (attempt_apply)
+			ret = error(_("could not apply autostash; "
+				      "your changes are safe in the stash"));
 		else
 			fprintf(stderr,
 				_("Autostash exists; creating a new stash entry.\n"
@@ -4850,15 +4873,16 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 	return ret;
 }
 
-static int apply_save_autostash(const char *path, int attempt_apply)
+static enum stash_apply_result apply_save_autostash(const char *path,
+						    int attempt_apply)
 {
 	struct strbuf stash_oid = STRBUF_INIT;
-	int ret = 0;
+	enum stash_apply_result ret = STASH_APPLY_CLEAN;
 
 	if (!read_oneliner(&stash_oid, path,
 			   READ_ONELINER_SKIP_IF_EMPTY)) {
 		strbuf_release(&stash_oid);
-		return 0;
+		return STASH_APPLY_CLEAN;
 	}
 	strbuf_trim(&stash_oid);
 
@@ -4870,37 +4894,40 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	return ret;
 }
 
-int save_autostash(const char *path)
+enum stash_apply_result save_autostash(const char *path)
 {
 	return apply_save_autostash(path, 0);
 }
 
-int apply_autostash(const char *path)
+enum stash_apply_result apply_autostash(const char *path)
 {
 	return apply_save_autostash(path, 1);
 }
 
-int apply_autostash_oid(const char *stash_oid)
+enum stash_apply_result apply_autostash_oid(const char *stash_oid)
 {
 	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
 }
 
-static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply,
-				    const char *label_ours, const char *label_theirs,
-				    const char *label_base,
-				    const char *stash_msg)
+static enum stash_apply_result apply_save_autostash_ref(struct repository *r,
+							const char *refname,
+							int attempt_apply,
+							const char *label_ours,
+							const char *label_theirs,
+							const char *label_base,
+							const char *stash_msg)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
-	int flag, ret;
+	int flag;
+	enum stash_apply_result ret;
 
 	if (!refs_ref_exists(get_main_ref_store(r), refname))
-		return 0;
+		return STASH_APPLY_CLEAN;
 
 	if (!refs_resolve_ref_unsafe(get_main_ref_store(r), refname,
 				     RESOLVE_REF_READING, &stash_oid, &flag))
-		return -1;
+		return STASH_APPLY_ERROR;
 	if (flag & REF_ISSYMREF)
 		return error(_("autostash reference is a symref"));
 
@@ -4915,15 +4942,19 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 	return ret;
 }
 
-int save_autostash_ref(struct repository *r, const char *refname)
+enum stash_apply_result save_autostash_ref(struct repository *r,
+					   const char *refname)
 {
 	return apply_save_autostash_ref(r, refname, 0,
 					NULL, NULL, NULL, NULL);
 }
 
-int apply_autostash_ref(struct repository *r, const char *refname,
-			const char *label_ours, const char *label_theirs,
-			const char *label_base, const char *stash_msg)
+enum stash_apply_result apply_autostash_ref(struct repository *r,
+					    const char *refname,
+					    const char *label_ours,
+					    const char *label_theirs,
+					    const char *label_base,
+					    const char *stash_msg)
 {
 	return apply_save_autostash_ref(r, refname, 1,
 					label_ours, label_theirs, label_base,
diff --git a/sequencer.h b/sequencer.h
index 64a9c7fb1b..804501b64c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,6 +3,7 @@
 
 #include "strbuf.h"
 #include "strvec.h"
+#include "stash.h"
 #include "wt-status.h"
 
 struct commit;
@@ -231,13 +232,17 @@ void commit_post_rewrite(struct repository *r,
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname,
 			  const char *message, bool silent);
-int save_autostash(const char *path);
-int save_autostash_ref(struct repository *r, const char *refname);
-int apply_autostash(const char *path);
-int apply_autostash_oid(const char *stash_oid);
-int apply_autostash_ref(struct repository *r, const char *refname,
-			const char *label_ours, const char *label_theirs,
-			const char *label_base, const char *stash_msg);
+enum stash_apply_result save_autostash(const char *path);
+enum stash_apply_result save_autostash_ref(struct repository *r,
+					   const char *refname);
+enum stash_apply_result apply_autostash(const char *path);
+enum stash_apply_result apply_autostash_oid(const char *stash_oid);
+enum stash_apply_result apply_autostash_ref(struct repository *r,
+					    const char *refname,
+					    const char *label_ours,
+					    const char *label_theirs,
+					    const char *label_base,
+					    const char *stash_msg);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
diff --git a/stash.h b/stash.h
new file mode 100644
index 0000000000..14ba4f946d
--- /dev/null
+++ b/stash.h
@@ -0,0 +1,21 @@
+#ifndef STASH_H
+#define STASH_H
+
+enum stash_apply_result {
+	/* The stash was applied cleanly, or there was nothing to apply. */
+	STASH_APPLY_CLEAN = 0,
+
+	/*
+	 * The stash could not be applied because it resulted in
+	 * conflicts.  The stash entry is left in place.  The "git stash
+	 * apply", "pop" and "branch" subcommands exit with this status
+	 * in this case, mirroring the convention of "git merge-tree" and
+	 * the merge strategies.
+	 */
+	STASH_APPLY_CONFLICT = 1,
+
+	/* Something went wrong. */
+	STASH_APPLY_ERROR = -1,
+};
+
+#endif /* STASH_H */
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index da27a6599a..6529508b06 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1791,13 +1791,13 @@ test_expect_success 'stash.index=false overridden by --index' '
 	test_cmp expect file
 '
 
-test_expect_success 'apply with custom conflict labels' '
+test_expect_success 'apply exits 1 on conflicts' '
 	git reset --hard initial &&
 	test_commit label-base conflict-file base-content &&
 	echo stashed >conflict-file &&
 	git stash push -m "stashed" &&
 	test_commit label-upstream conflict-file upstream-content &&
-	test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
+	test_expect_code 1 git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
 	test_grep "^<<<<<<< UP" conflict-file &&
 	test_grep "^||||||| Stash base" conflict-file &&
 	test_grep "^>>>>>>> STASH" conflict-file
@@ -1809,11 +1809,30 @@ test_expect_success 'apply with empty conflict labels' '
 	echo stashed >conflict-file &&
 	git stash push -m "stashed" &&
 	test_commit empty-label-upstream conflict-file upstream-content &&
-	test_must_fail git stash apply --label-ours= --label-theirs= &&
+	test_expect_code 1 git stash apply --label-ours= --label-theirs= &&
 	test_grep "^<<<<<<<$" conflict-file &&
 	test_grep "^>>>>>>>$" conflict-file
 '
 
+test_expect_success 'pop exits 1 on conflicts and keeps the stash entry' '
+	git reset --hard initial &&
+	echo stashed >file &&
+	git stash push -m pop-stashed &&
+	test_commit pop-upstream file upstream-content &&
+	test_expect_code 1 git stash pop &&
+	git stash list >list &&
+	test_grep pop-stashed list
+'
+
+test_expect_success 'stash branch exits with a non-1 status on errors' '
+	git reset --hard initial &&
+	echo stashed >file &&
+	git stash push -m branch-stashed &&
+	test_expect_code 128 git stash branch conflicting-branch refs/heads/does-not-exist &&
+	git stash list >list &&
+	test_grep branch-stashed list
+'
+
 test_expect_success 'stash show --include-untracked includes untracked files' '
 	git reset --hard &&
 
-- 
gitgitgadget

