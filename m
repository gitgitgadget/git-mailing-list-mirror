Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1851C347
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801933; cv=none; b=Dn9N6NAfKwPEhlLRaf/0DVaxVmX44ejU5sADlhpUClzuEnnZZ9XVEZjvp5GwYSS1HT7ywF9MQ+MqJSPekx5rBj9zaB34K5/5WKtE76exi3MHMtINdh7V5/4eVgtmYZBfkxU9Pv6XlGirR4XxnOkrG72gOz4uIvU1klshCnO/asc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801933; c=relaxed/simple;
	bh=HNW+gPpXQ+ACDCnmjMRMSysEmaYQcf/KN5tCfRUAqmo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=eWF85uDM7q9sam7mSp0t3LQP2eKvEcJei59OyJEatsJi2Gngs3t/S/kjKhPAPZEQ14Ij6l1UBwxNy4sy4tkkyH8ey3EAjPMLkJr+eV7Ym7K5tr9eOwT22XvLsDwqQrtEO1uulPveJDjsGVERhioGR1T3vaDpHaJp3CKSmTYB9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcCMBZ0P; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcCMBZ0P"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so54316926d6.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790801930; x=1791406730; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OPiffOe2z3ZJpdbyGIaOUHtnLM2Iwth5QKG5ITfPNhQ=;
        b=RcCMBZ0PVFbm2ejgalbL42bKI+s49gk8S5lSxw9/Y0L3O7zo9aumKB78RCHoHP230U
         kCZjfk9IjpLhiqont40qwpewf9UFqsQCnzKJ6kvWFqrNFYZ9ZMeWh14sE3pAMN6dSHlh
         xxaLf9r+WtklnG49pfxVp7jX0pY7XZhYMIElrzUp7TTtjODaBgBeuU5BAiDqiV/j78W6
         +Xo3KWzI19y73wDYyVH7meB8+O3AprgDVQCJcVxgB6lOOHDYeD7Jz/Fh12r/ynvoFsG3
         qMl4QFiSVLJok+iUqhP6zDN4hd7ISVUveI16Mq4PPPWUSh58dV2d8GQc2NiIiPncsKOw
         IIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790801930; x=1791406730;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OPiffOe2z3ZJpdbyGIaOUHtnLM2Iwth5QKG5ITfPNhQ=;
        b=sfv4g/FAWYhm1jnKpOIeYaaPdWagQL/sood2SHwuwpx7tJ3vtUO2lu5CQ8uYbZWwVL
         36LVcPFknW2Pb5ebgAsUB3FWMcAHZ2gVb9ZNtMN5fMOlzLtbEdvO+wpTWpAHdMDj6VtA
         fobZJv2xbumXgxI4Vy6zf1IrgGMRZSpJFsY8vrtCe6KYtqKVPeh6tl8tqNgoDzvfjYT+
         SJJh5LEBjXrH62bYbyzvfzGNtBEhcEm9hN7tLIcwnAsb0NQzBR+ElaGyZalYt8uOnsLz
         Ew7pnTAKJjuE89vaTo5pFS2zeVwGo/1pzdaNGxCTCCik0Fb8JcBxpxb+YzJ+EAriLxvQ
         S8vw==
X-Gm-Message-State: AFq9FYKu4Culd5stsBU/Mt2PITIZaJM0qmI84GLJnsS6KosDeEc216KB
	Rk5MsJJnTC5LkV4RTYMvYT2fgpAv6LhGkEnorPb8ZiW0yprDyVzO9nrcArQt9w==
X-Gm-Gg: AYBFou09y8HILB+Q/63QIbIbmVZENZNxHzNQPZreDLXqo6DHXhIsWC9Fa0V61m/mh9c
	+S7AEMAXyZvX5GHSN4iESgF5NBbxN/lmW9zwAQFVhswZYSU8PXV0tGDfIfQh2SjBIu2zMXK98ZW
	LOSqISYEUPTYLGcGG1g6n0AJYPCNc9rhQMgLqcv3SXTgb7xRumzJRA+57PUfT0xuHhnRIvAVv+o
	AYcj8zCy2PrO1C4sw8mE//hcWJRs/WUrF1QWfOLZLUyDv8WHnoTnHW7f+B1OOgzPd+mwjeEwrOr
	Rmdmo1Yo6nSRpeccT+iT+jtUgEbKejQ43NeNpUIXjcOheVRIQP9a74MTyLMoRcU+GMl5EnGw42Y
	itHtYpvvM8Hb8SUaUkrzOhBb6y12z5kAQVjb8g56AZic+VpjUgT0yzBBKZIpD1JUHmk4CcL8u8o
	ovAAolmHLnlbfFV/lG7n1aK1YVIqf5NSoH+Xp9WygI5SepT6L1Zz0THZuKHBWUjkpyLQfUAY2+v
	oVrog==
X-Received: by 2002:a05:6214:4016:b0:912:cec:7450 with SMTP id 6a1803df08f44-917a0813ebfmr47918906d6.0.1790801930257;
        Wed, 30 Sep 2026 13:58:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.195.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a89ea9dbsm9023216d6.18.2026.09.30.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:58:49 -0700 (PDT)
Message-Id: <pull.2430.git.git.1790801929375.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Sep 2026 20:58:49 +0000
Subject: [PATCH] stash: allow custom conflict labels for pop
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Since 13817db274 (stash: add --label-ours, --label-theirs, --label-base
for apply, 2026-04-28), "git stash apply" accepts custom labels for
conflict markers, but "git stash pop" does not, although it applies the
entry the same way and only differs by dropping it afterward. A caller
that wants its own labels has to use apply and drop the entry itself.

Teach "git stash pop" the same three options.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    stash: allow custom conflict labels for pop
    
    git stash pop now accepts the conflict label options that git stash
    apply gained in 2.55.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2430%2FHaraldNordgren%2Fstash-pop-labels-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2430/HaraldNordgren/stash-pop-labels-v1
Pull-Request: https://github.com/git/git/pull/2430

 Documentation/git-stash.adoc |  4 ++--
 builtin/stash.c              | 11 +++++++++--
 t/t3903-stash.sh             | 23 +++++++++++++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index fc6a9a008c..187b1a50d3 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 git stash list [<log-options>]
 git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
 git stash drop [-q | --quiet] [<stash>]
-git stash pop [--index] [-q | --quiet] [<stash>]
+git stash pop [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]
 git stash apply [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]
 git stash branch <branchname> [<stash>]
 git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
@@ -198,7 +198,7 @@ apply the changes as they were originally).
 `--label-ours=<label>`::
 `--label-theirs=<label>`::
 `--label-base=<label>`::
-	These options are only valid for the `apply` command.
+	These options are only valid for `pop` and `apply` commands.
 +
 Use the given labels in conflict markers instead of the default
 "Updated upstream", "Stashed changes", and "Stash base".
diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..3a3c46d6cf 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -43,7 +43,7 @@
 #define BUILTIN_STASH_DROP_USAGE \
 	N_("git stash drop [-q | --quiet] [<stash>]")
 #define BUILTIN_STASH_POP_USAGE \
-	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
+	N_("git stash pop [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]")
 #define BUILTIN_STASH_APPLY_USAGE \
 	N_("git stash apply [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]")
 #define BUILTIN_STASH_BRANCH_USAGE \
@@ -885,11 +885,18 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
 	int ret = -1;
 	int index = use_index;
 	int quiet = 0;
+	const char *label_ours = NULL, *label_theirs = NULL, *label_base = NULL;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "index", &index,
 			 N_("attempt to recreate the index")),
+		OPT_STRING(0, "label-ours", &label_ours, N_("label"),
+			   N_("label for the upstream side in conflict markers")),
+		OPT_STRING(0, "label-theirs", &label_theirs, N_("label"),
+			   N_("label for the stashed side in conflict markers")),
+		OPT_STRING(0, "label-base", &label_base, N_("label"),
+			   N_("label for the base in diff3 conflict markers")),
 		OPT_END()
 	};
 
@@ -900,7 +907,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
 		goto cleanup;
 
 	if ((ret = do_apply_stash(prefix, &info, index, quiet,
-				  NULL, NULL, NULL)))
+				  label_ours, label_theirs, label_base)))
 		printf_ln(_("The stash entry is kept in case "
 			    "you need it again."));
 	else
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 721158606f..58a41f4c65 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1841,6 +1841,29 @@ test_expect_success 'pop exits 1 on conflicts and keeps the stash entry' '
 	test_grep pop-stashed list
 '
 
+test_expect_success 'pop with custom conflict labels' '
+	git reset --hard initial &&
+	test_commit pop-label-base conflict-file base-content &&
+	echo stashed >conflict-file &&
+	git stash push -m "stashed" &&
+	test_commit pop-label-upstream conflict-file upstream-content &&
+	test_expect_code 1 git -c merge.conflictStyle=diff3 stash pop --label-ours=UP --label-theirs=STASH &&
+	test_grep "^<<<<<<< UP" conflict-file &&
+	test_grep "^||||||| Stash base" conflict-file &&
+	test_grep "^>>>>>>> STASH" conflict-file
+'
+
+test_expect_success 'pop with empty conflict labels' '
+	git reset --hard initial &&
+	test_commit pop-empty-label-base conflict-file base-content &&
+	echo stashed >conflict-file &&
+	git stash push -m "stashed" &&
+	test_commit pop-empty-label-upstream conflict-file upstream-content &&
+	test_expect_code 1 git stash pop --label-ours= --label-theirs= &&
+	test_grep "^<<<<<<<$" conflict-file &&
+	test_grep "^>>>>>>>$" conflict-file
+'
+
 test_expect_success 'stash branch exits with a non-1 status on errors' '
 	git reset --hard initial &&
 	echo stashed >file &&

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
