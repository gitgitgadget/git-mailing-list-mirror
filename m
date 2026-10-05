Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD574CDA39
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213009; cv=none; b=PbFqZBv7VXlYTKrtfwvvUUWD83liKPHL5Q7ZTskq+3aH78Gqi7404riz3yk6dvLOTAzbga90YkJ08uOuPx/D+xPj16ajsOGkCmc8180yiWJ1LHcYXD/kSDCQJKcichn81La0VAc0LEagLSlylFh5j60q+X+w+KmjxC2wzq0t0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213009; c=relaxed/simple;
	bh=JLqALyao6iKR4svGsOzsnSVF/OYVHd90orWblTIZkG0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=rmx5mxcm+5qeRXUKmwxmgQfBJLI7+b5sbzzcEcD/QtKA9viSZPd+mO0mDJjxJBMOszqKvdG25si1dynZIdegNvNo+yl6GaVpw/7WwrOAaqVH808yo5ywir4X3WC8ciJCR/wHS5Sx1jKCfOtoTBOnGNJ4UBNRL7YP5Tgd7wxuE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBLDWIEz; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBLDWIEz"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-9178b9ca7e8so21492876d6.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791213002; x=1791817802; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n8Cr9iLkXmWmhIkWhKKNYkjeW2Ao9uR0e52RG2fsvvA=;
        b=MBLDWIEzpLLwQsJBenAQfs6xVAHGS4q+64xBg+GNSIGOowZ4N0Q2/onOa47kKaomzn
         fWuQ/w39/D1sTXiA4YxFB0cbDieS496BLyU4Lt0yvDjheGa6Uf+vSs4mpY0In5oWxibG
         U3LRUxWxy3elceOcaTncdn7kT4u9xkt4Va0N3KYQFjSfZQhajLYM/4iZi53kyiKhxuIp
         4cyUJxFoFlFQ93ng1v9XTgj0TJ0ld7JG1Lt0h2Zyxq6VjuBHNUdnx8XKypWV3j+dcstY
         mlvCo00zzBf+jhxIPpsv5/J2hoflx2Fy9G1YZXdjWo6240hCM+we7wrlcijSyBg59v4m
         uxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213002; x=1791817802;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n8Cr9iLkXmWmhIkWhKKNYkjeW2Ao9uR0e52RG2fsvvA=;
        b=lWuphzK0o1712LmPs7HuXTWGANeRoYhTJ8LZHc6nFE5i7YevfRGHpUfdouhHElcmWx
         PD7I49t0nojilxfn2iGxwJOuUNjanSibjA6n8jMX0nhwwqtqCrDxwKZFXKPeREtIDqNn
         Iak5wUsWX5CBCcY5oh7VqyC6sOrCMjZLwsd1GImTTBHn8vwU+mgi9dmCCwizy5Vq498X
         E2XgWhQhYDNtO6IuzOGg0dmVa1OjN58i11NHFyOQkbXtcH7F3UW6w7HvikIHF20fzvrh
         4Wci3/G/sR4qdfJkJ0aZOPDe11LZXWQwyG0ppqzsmYIj2g9q5BXZonefdYe7ZpGwvmh0
         7cag==
X-Gm-Message-State: AFuF++ktGSz7EWfCAEh3pgdXJdIIPYDCA+PtkGxulGxQHoaJ1NF8QFUw
	v3vXjTQ2gjyjVl5wbdcVYq8mEqiOdSG5frsfVWDGIjgCWwDOdDKbQ+JJ0r0JVg==
X-Gm-Gg: AYBFou0LN7LIYC/mtWx6ptG6RFTRiRAs2hU3Ooheskj/kaY2ZPHK63briKGnSKFZmie
	2SEFfy5u5wQ+dbONGCrmTVl8txcyOGHJzEbanAy1pu2HdYx8mRAX4sHvTiyum1eRp4LGTodAwIj
	33YQ3VKwwx1nqRPimGHj4Iq0eWKXv/xj8iQHKmoPBV2HzZkPiqP3ZmyuN51BhG2WsecQeSA5ae1
	EG7k1LYtF/mJfnhm6DMhd6khQwdOJt1/WxS0G70tfq5Q2mblK9DQGeeUgacncJHnYO/qA+Sm1Gr
	ysC5naiXftrknztFzRbmPYPRhEHph9MzdTPV6ZClHAkE+pAHGQxxKeNJtu+iVpwtm9j+KAlTgo0
	cj/CrgcGY3yE3k9z9LIk/gNQeGNXCNUuxrIlx1KrNJd9W6qKrkGlCP90HcD/IbopLlWZg1/7ZPP
	aVCCK6w07cSl3rqdNk166AfMFIUZlEscNXtg+SNZvdD5ihCKI3P/Upyzt8y+n3ruPHVh9Zt0Ppd
	w==
X-Received: by 2002:a05:6214:20c7:b0:914:1807:dc70 with SMTP id 6a1803df08f44-917c009e0b0mr228885296d6.13.1791212999072;
        Mon, 05 Oct 2026 08:09:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.67.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b19decsm89221316d6.14.2026.10.05.08.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:58 -0700 (PDT)
Message-Id: <pull.2235.git.1791212998072.gitgitgadget@gmail.com>
From: "Devi Srinivas Vasamsetti via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Oct 2026 15:09:58 +0000
Subject: [PATCH] commit: warn when a new commit is dated before its parent
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
Cc: Devi Srinivas Vasamsetti <devisrinivas.vasamsetti@gmail.com>,
    Devi Srinivas Vasamsetti <devisrinivas.vasamsetti@gmail.com>

From: Devi Srinivas Vasamsetti <devisrinivas.vasamsetti@gmail.com>

Git writes whatever the clock says into the commit object. This can
be problematic because history traversal assumes commit dates are
non-decreasing. For example, "git log --since" stops walking at the
first commit older than the cutoff, so an out-of-order date hides
the commits behind it.

Add a check gated by a new advice.clockSkew setting that warns when
the new commit's date precedes a parent's date. This allows users to
catch a wrong clock at commit time when it is still easy to fix.

This check only looks at the new commit being created and its parents.
Dates in replayed history or merges are not warned about.

Signed-off-by: Devi Srinivas Vasamsetti <devisrinivas.vasamsetti@gmail.com>
---
    commit: warn when a new commit is dated before its parent
    
    What does this PR do? This PR adds a helpful warning if you try to make
    a new commit with a date that is older than its parent commit.
    
    Why is this needed? Git just uses whatever time your computer's clock
    says when creating a commit. If your system clock is incorrect, you
    might accidentally create a commit dated in the past.
    
    This causes problems because commands like git log --since assume that
    commit dates always move forward. If a date goes backward in history,
    those commands can get confused and accidentally hide commits from the
    log.
    
    What is fixed? We added a new configuration setting called
    advice.clockSkew. Now, Git will warn you right away if your computer's
    clock seems to be wrong when you are making a new commit. This gives you
    a chance to fix your computer's time before you accidentally push
    out-of-order dates!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2235%2Fsrinivas1591%2Ffeature%2Fwarn-older-commits-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2235/srinivas1591/feature/warn-older-commits-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2235

 Documentation/config/advice.adoc |  7 +++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/commit.c                 | 46 ++++++++++++++++++++++++++++++++
 t/t7502-commit-porcelain.sh      | 27 +++++++++++++++++++
 5 files changed, 82 insertions(+)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 81f80a9274..59b643d9d0 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -38,6 +38,13 @@ all advice messages.
 		configuration variable for how to set a given remote
 		to be used by default in some situations where this
 		advice would be printed.
+	clockSkew::
+		Shown by linkgit:git-commit[1] when the commit being
+		created is dated earlier than one of its parents, which
+		usually means the system clock is wrong. History
+		traversal assumes commit dates do not decrease, so such
+		a commit can cause commands like `git log --since` to
+		skip the commits behind it.
 	commitBeforeMerge::
 		Shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..3e14859de4 100644
--- a/advice.c
+++ b/advice.c
@@ -50,6 +50,7 @@ static struct {
 	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec" },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
+	[ADVICE_CLOCK_SKEW]				= { "clockSkew" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
 	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
diff --git a/advice.h b/advice.h
index 66f6cd6a77..43de2b19a2 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ enum advice_type {
 	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
+	ADVICE_CLOCK_SKEW,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DEFAULT_BRANCH_NAME, /* To be retired sometime after Git 3.0 */
 	ADVICE_DETACHED_HEAD,
diff --git a/builtin/commit.c b/builtin/commit.c
index 205fbd57e3..78d1dde27e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
+#include "date.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "color.h"
@@ -21,6 +22,7 @@
 #include "commit.h"
 #include "add-interactive.h"
 #include "gettext.h"
+#include "ident.h"
 #include "revision.h"
 #include "wt-status.h"
 #include "run-command.h"
@@ -1693,6 +1695,48 @@ struct repository *repo UNUSED)
 	return 0;
 }
 
+static void warn_if_dated_before_parents(struct commit_list *parents)
+{
+	struct ident_split committer;
+	struct strbuf ours = STRBUF_INIT;
+	const char *info;
+	timestamp_t date, newest = 0;
+
+	if (!advice_enabled(ADVICE_CLOCK_SKEW))
+		return;
+
+	info = git_committer_info(IDENT_STRICT);
+	if (split_ident_line(&committer, info, strlen(info)) ||
+	    !committer.date_begin)
+		return;
+	date = parse_timestamp(committer.date_begin, NULL, 10);
+
+	for (; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+
+		if (repo_parse_commit(the_repository, parent))
+			continue;
+		if (parent->date > newest)
+			newest = parent->date;
+	}
+
+	if (!newest || date >= newest)
+		return;
+
+	strbuf_addstr(&ours, show_date(date, atoi(committer.date_end + 1),
+				       DATE_MODE(ISO8601)));
+
+	advise_if_enabled(ADVICE_CLOCK_SKEW,
+			  _("the new commit is dated %s,\n"
+			    "which is earlier than its parent, dated %s.\n"
+			    "This usually means the system clock is wrong.\n"
+			    "Commands that walk history in date order, such as\n"
+			    "\"git log --since\", may skip commits as a result."),
+			  ours.buf,
+			  show_date(newest, 0, DATE_MODE(ISO8601)));
+	strbuf_release(&ours);
+}
+
 static int git_commit_config(const char *k, const char *v,
 			     const struct config_context *ctx, void *cb)
 {
@@ -1962,6 +2006,8 @@ int cmd_commit(int argc,
 		append_merge_tag_headers(parents, &tail);
 	}
 
+	warn_if_dated_before_parents(parents);
+
 	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
 				 parents, &oid, author_ident.buf, NULL,
 				 sign_commit, extra)) {
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 2adfe70b3d..fb611b191b 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -1003,4 +1003,31 @@ test_expect_success WITH_BREAKING_CHANGES 'core.commentChar=auto is rejected' '
 	test_cmp expect actual
 '
 
+test_expect_success 'warn when a commit is dated before its parent' '
+	test_when_finished "git checkout main 2>/dev/null || git checkout master" &&
+	git checkout -b clock-skew &&
+	test_commit --date "2026-09-25T10:00:00+0000" skew-parent &&
+	echo skew >skew-child &&
+	git add skew-child &&
+	GIT_COMMITTER_DATE="2026-09-13T06:00:00+0000" \
+		git commit -m "behind its parent" 2>actual &&
+	test_grep "earlier than its parent" actual
+'
+
+test_expect_success 'no warning when commit dates increase' '
+	echo forward >skew-forward &&
+	git add skew-forward &&
+	GIT_COMMITTER_DATE="2026-09-26T06:00:00+0000" \
+		git commit -m "after its parent" 2>actual &&
+	test_grep ! "earlier than its parent" actual
+'
+
+test_expect_success 'advice.clockSkew silences the warning' '
+	echo quiet >skew-quiet &&
+	git add skew-quiet &&
+	GIT_COMMITTER_DATE="2026-09-14T06:00:00+0000" \
+		git -c advice.clockSkew=false commit -m quiet 2>actual &&
+	test_grep ! "earlier than its parent" actual
+'
+
 test_done

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
-- 
gitgitgadget
