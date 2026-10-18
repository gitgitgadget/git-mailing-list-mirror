Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3243846B
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348048; cv=none; b=T/4nQ3onatm1kyBUz+SbcEzo91TlYIn8r3nwECnUx5m+lwMlu4Es7DLJTic8qsDm5rBj/qy2w2X0TD0jweT1o8HZBndDdaPlyFukJA60zj/V1TIwwQAmIHXeKwced2xsoZ+dvclTvPQ7Pkb7vM3Szh+zVA5S4OyIdnZI4IkLbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348048; c=relaxed/simple;
	bh=7zhZ+lJoREYdW8w//1VmqdtCmZH0+gCPYpfVIZdK31A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G0JVSkAACEB+UN8JHDhG4N85rOwqAox+P3W3Jz1kD8Bn66/IisyomTf9lSKf+8jYTYKjlB9G05Jcro3oUjN7XFN/rzGk3mtUn5JmAVJcmNWYCXr/3CfSOhmiHlx6QQPqDubOeQpMqumxvj8l5eXhympgB4U9OPzecBS6AVwgPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux+xSVaP; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux+xSVaP"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-17bc533fda3so1566314c88.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792348041; x=1792952841; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I33VS3bND46C9R7jk3mklQb6pB0WCoIynum9HdAWER4=;
        b=Ux+xSVaPT3b6tIgllQD9DOgRgjL8b4AP8lMUzSDwK5UgvIue25b/TN53TM/o2lNLqq
         0kbVWuKPzHg3dOdlZS7e9mJN13twK4mXsbiNv/a6Rbs2VYuVsgt+ly/dQ8hgTzxKp6Em
         /AOfWGZ9RlIhQ1vLwGuPN0nOxfwfOSkL1yxcv+5sOA1+mGhYokiP/e+8bwOvYCyukUGy
         B+XaATE0fYeX9tOkUn2lPyc2sajbo/lozYeOtgmdNjBjp42ToQMI6hEZEQb8VTRt2QoR
         2eLFso9ZUub5m7pJBkiQH9eKpT9YTN45Z6u5p9ZcYsSJy18tZH3vQgeb2AenR87XTGoJ
         Hmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792348041; x=1792952841;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I33VS3bND46C9R7jk3mklQb6pB0WCoIynum9HdAWER4=;
        b=GokgQQEcEm9uBDsOp4WkSKEuC5ITwoCPUIs0frL2hxadgBnaexlsHbyO+WtxgMQ1em
         Dwbkp96suf2bNvelkHLZfBJoLVZr5avQn7bysP0cgR8Nf22sKMO/swFHA90R84XSL7IH
         iDvYcORog3wW4bF7AvUfMvMVY4LIp7N9m+q9Ag3MXsctiyTIcS1rHW/411eqdwAleRa6
         xmICSz0/1XZeLcc3SejGQvhxGjpCzZKhsgrcjBk/V+V+xIHaXgYzfo3OBBNDYu9yv7wf
         0wkW9NTppzpc6wHUnmVh93bnamndR+jnS6F1A46zo8k7lTFwsuaxywOQwwN3yhPsi0Ni
         1HDg==
X-Gm-Message-State: AFq9FYKI4p2rkUE3fVCiSgkwVqU3C2S6+2oCzGAtzZeGC2EKUafKmeLo
	Yfv1cY9cLKSgY7C9aGz5REAe4IZVtSen0cMziU2/HjIGK2Eb8RH/738LsdQBfLyz
X-Gm-Gg: AYBFou2smOH1d8A69NKXP0LuCcKui2gV8l3xWLg3jUxIhYnndFvFDy94rCFuAuRUbzs
	G2RPaaWAMGNNi8oYmy//CJ8UVignkorrD1SWrHnevCxKk4ASStIr9bauTYys1UNA3uvjBfcpWHI
	p/IB60bNnlTOdZcpVB46GLvvYol42s3nnwDZ2LcaxkiszE/d43+EGnemvI0EG+Ra7rZHLPjusG8
	Exl/2Y8cwfYDePvKMXr6iod2+tYVvKppBtoanonrE3UkO98sQWtK7+M/Nti4MV0zl7fVv5OvUER
	onTpRY3VW6bbl9yqhgEh7dBbD2UcRjwemStC8AuImzMwWmy0hbzXKGbgMKAtIn97zIK1NiJr294
	hM90T8t927aER1MsXCv+/raDQgYdZ4QpbLx2scp/FZjrsKXjM39ZbMAqOwrrkmswo8oy4f4jKqU
	ChFBxrAjM+IyyXd09WqIP1Q+eXUaxZdt8NP0K2HuusHrEhUj/qNPLelcfi4jULrNIM1OZOvNic5
	A==
X-Received: by 2002:a05:7023:c019:b0:183:3c2a:ae8 with SMTP id a92af1059eb24-1851453f8famr7956194c88.41.1792348040914;
        Sun, 18 Oct 2026 11:27:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.179.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18319d3b880sm21410166c88.10.2026.10.18.11.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 11:27:20 -0700 (PDT)
Message-Id: <745929bd805784bebeccc7e3ddee638aaffaeded.1792348037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 18:27:15 +0000
Subject: [PATCH v2 1/3] reflog: name the strings that mark switches, renames
 and rebase steps
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The next commit adds "git reflog --operations", which finds branch
switches, branch renames and the start and end of a rebase by the
messages they leave in the reflog. The commands that write these
messages spell out the strings by hand, and "@{-<n>}" and "git status"
each keep their own copy of the switch prefix to read it back. Reading
them in one more place would add yet another copy that has to stay in
sync.

Name the strings once in reflog.h and use the names wherever the
messages are written or read: the "checkout: moving from " prefix
written by "git checkout", the "Branch: renamed " prefix written by
"git branch -m", and the "start", "finish" and "abort" steps written
by "git rebase".

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c   |  3 ++-
 builtin/checkout.c |  3 ++-
 builtin/rebase.c   | 17 +++++++++--------
 object-name.c      |  3 ++-
 reflog.h           |  6 ++++++
 sequencer.c        | 13 +++++++------
 wt-status.c        |  3 ++-
 7 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..30062ceb7c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -13,6 +13,7 @@
 #include "editor.h"
 #include "environment.h"
 #include "refs.h"
+#include "reflog.h"
 #include "commit.h"
 #include "gettext.h"
 #include "object-name.h"
@@ -669,7 +670,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: copied %s to %s",
 			    oldref.buf, newref.buf);
 	else
-		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
+		strbuf_addf(&logmsg, REFLOG_RENAME_PREFIX "%s to %s",
 			    oldref.buf, newref.buf);
 
 	if (!copy && !(oldref_usage & IS_ORPHAN) &&
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d575a4f57..f011284084 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -25,6 +25,7 @@
 #include "preload-index.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "reflog.h"
 #include "remote.h"
 #include "repo-settings.h"
 #include "resolve-undo.h"
@@ -999,7 +1000,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (!reflog_msg)
-		strbuf_addf(&msg, "checkout: moving from %s to %s",
+		strbuf_addf(&msg, REFLOG_SWITCH_PREFIX "%s to %s",
 			old_desc ? old_desc : "(invalid)", new_branch_info->name);
 	else
 		strbuf_insertstr(&msg, 0, reflog_msg);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 535db60181..26ef589e89 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -17,6 +17,7 @@
 #include "strvec.h"
 #include "dir.h"
 #include "refs.h"
+#include "reflog.h"
 #include "config.h"
 #include "unpack-trees.h"
 #include "lockfile.h"
@@ -601,11 +602,11 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
-		    opts->reflog_action,
+	strbuf_addf(&branch_reflog, "%s (%s): %s onto %s",
+		    opts->reflog_action, REFLOG_STEP_FINISH,
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
-	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
-		    opts->reflog_action, opts->head_name);
+	strbuf_addf(&head_reflog, "%s (%s): returning to %s",
+		    opts->reflog_action, REFLOG_STEP_FINISH, opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_WORKING_TREE_REFS_ONLY |
 		      RESET_WORKING_TREE_UPDATE_HEAD;
@@ -1413,8 +1414,8 @@ int cmd_rebase(int argc,
 		if (read_basic_state(&options))
 			exit(1);
 
-		strbuf_addf(&head_msg, "%s (abort): returning to %s",
-			    options.reflog_action,
+		strbuf_addf(&head_msg, "%s (%s): returning to %s",
+			    options.reflog_action, REFLOG_STEP_ABORT,
 			    options.head_name ? options.head_name
 					      : oid_to_hex(&options.orig_head->object.oid));
 		ropts.oid = &options.orig_head->object.oid;
@@ -1884,8 +1885,8 @@ int cmd_rebase(int argc,
 		printf(_("First, rewinding head to replay your work on top of "
 			 "it...\n"));
 
-	strbuf_addf(&msg, "%s (start): checkout %s",
-		    options.reflog_action, options.onto_name);
+	strbuf_addf(&msg, "%s (%s): checkout %s", options.reflog_action,
+		    REFLOG_STEP_START, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid;
 	ropts.flags = RESET_WORKING_TREE_DETACH |
diff --git a/object-name.c b/object-name.c
index 6546685760..5b6ce8e0e0 100644
--- a/object-name.c
+++ b/object-name.c
@@ -13,6 +13,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "reflog.h"
 #include "remote.h"
 #include "dir.h"
 #include "odb.h"
@@ -1251,7 +1252,7 @@ static int grab_nth_branch_switch(const char *refname UNUSED,
 	const char *match = NULL, *target = NULL;
 	size_t len;
 
-	if (skip_prefix(message, "checkout: moving from ", &match))
+	if (skip_prefix(message, REFLOG_SWITCH_PREFIX, &match))
 		target = strstr(match, " to ");
 
 	if (!match || !target)
diff --git a/reflog.h b/reflog.h
index 3bdd1ca8a5..32c3737db4 100644
--- a/reflog.h
+++ b/reflog.h
@@ -2,6 +2,12 @@
 #define REFLOG_H
 #include "refs.h"
 
+#define REFLOG_SWITCH_PREFIX "checkout: moving from "
+#define REFLOG_RENAME_PREFIX "Branch: renamed "
+#define REFLOG_STEP_START "start"
+#define REFLOG_STEP_FINISH "finish"
+#define REFLOG_STEP_ABORT "abort"
+
 #define REFLOG_EXPIRE_TOTAL   (1 << 0)
 #define REFLOG_EXPIRE_UNREACH (1 << 1)
 
diff --git a/sequencer.c b/sequencer.c
index efbfd1315b..c55df2d38f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -31,6 +31,7 @@
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "refs.h"
+#include "reflog.h"
 #include "sparse-index.h"
 #include "strvec.h"
 #include "quote.h"
@@ -5011,8 +5012,8 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 RESET_WORKING_TREE_UPDATE_HEAD |
 			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
 			 RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK,
-		.head_msg = reflog_message(opts, "start", "checkout %s",
-					   onto_name),
+		.head_msg = reflog_message(opts, REFLOG_STEP_START,
+					   "checkout %s", onto_name),
 		.default_reflog_action = sequencer_reflog_action(opts)
 	};
 	if (reset_working_tree(r, &ropts)) {
@@ -5310,16 +5311,16 @@ cleanup_head_ref:
 				res = error(_("could not read 'onto'"));
 				goto cleanup_head_ref;
 			}
-			msg = reflog_message(opts, "finish", "%s onto %s",
-				head_ref.buf, buf.buf);
+			msg = reflog_message(opts, REFLOG_STEP_FINISH,
+				"%s onto %s", head_ref.buf, buf.buf);
 			if (refs_update_ref(get_main_ref_store(the_repository), msg, head_ref.buf, &head, &orig,
 					    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 				res = error(_("could not update %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
 			}
-			msg = reflog_message(opts, "finish", "returning to %s",
-				head_ref.buf);
+			msg = reflog_message(opts, REFLOG_STEP_FINISH,
+				"returning to %s", head_ref.buf);
 			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg)) {
 				res = error(_("could not update HEAD to %s"),
 					head_ref.buf);
diff --git a/wt-status.c b/wt-status.c
index 57772c7501..ffd54353a8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -22,6 +22,7 @@
 #include "strvec.h"
 #include "remote.h"
 #include "refs.h"
+#include "reflog.h"
 #include "submodule.h"
 #include "column.h"
 #include "read-cache.h"
@@ -1790,7 +1791,7 @@ static int grab_1st_switch(const char *refname UNUSED,
 	struct grab_1st_switch_cbdata *cb = cb_data;
 	const char *target = NULL, *end;
 
-	if (!skip_prefix(message, "checkout: moving from ", &message))
+	if (!skip_prefix(message, REFLOG_SWITCH_PREFIX, &message))
 		return 0;
 	target = strstr(message, " to ");
 	if (!target)
-- 
gitgitgadget

