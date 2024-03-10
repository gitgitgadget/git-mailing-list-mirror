Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B039FFB
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710100268; cv=none; b=pzuRXVBf7tZu++L/IKkWnStMfsP6behb0cz/j61H/X/0zJrRLygeiYI2UEUCLAEWgEctQTJZl2i3+4T83fu2Jms4nqX6gDiLeoDCVekt9yhfk1/dqv0RwjV3H7RSWOshpmRX07qslW4BEaghZF+/GU3INJ3N0EaG/F+Wwr8I6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710100268; c=relaxed/simple;
	bh=HwfZG9+f+f8xWFjKofMvu7W5eBzLvusj6BzCqq606Hk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LaLE5s8bt4TpRvkYCmkxpTAgCw2qfr4ptBqQcLJdeJIouGKgCOn2jaAdw9eTCJ1IdNzdDCk9LjvZZ8Jn+JOipxEUyMKbdlm3feWLO7A9cWGvqOnsmRHL+diTfYH2n55Y3r2u6vogYXM0LLr13qwEdO6qMyi13Q5G6FG8pWBD2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmtu/jeW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmtu/jeW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-413183f5e11so12230575e9.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710100265; x=1710705065; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMMhZXEN7/UeGlAG6QJrSY2gv7WD9Gwue3qCSxGVX7c=;
        b=Pmtu/jeWnesmUnp51syUoTi0Z0YYnkWZhx93VFlvtA6YPWImRg9I3UdaKEaXRyuP6a
         bmrhvkXENOLFm+xz/ojHmwSvsoJAoDJmTBMBcZ+8i05cRq9Q+9VZzp1CGTHs2oEt1YSj
         Z8j77yxhgi7/eeNxpHDanLB8rmNZ7pKy70BY09bNrCgcP5qqQTg57kK7zUc5WxZSLqOI
         obWftmRVzsvcoVWy/r6BkG0vBo52tPD393/CBO261ZlSmYEcJCSFhz9ZolQN/Hbw+DXU
         pSPdJpQ5WCMpbJ4l+VPGCdCzkN4xw+ZBlQSOl1g5hxu5x5IFzNRIaQA+TDAeYJnR6yLI
         3cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710100265; x=1710705065;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMMhZXEN7/UeGlAG6QJrSY2gv7WD9Gwue3qCSxGVX7c=;
        b=HjoTEzsxdjeeSdhlCPGeTohpUNH3hvtgPJKpxHjMsmeIJty3+tiOMCq9gj7BMd0Q9H
         f2CpstfOuZZZARq9zQh34UYjfrPI6NuVGElm3Y/XTLEvOKy6WeaY8xqlfJ6kxLimFKUm
         9xPZNRi/PoichK7iO+6WZNOM+RPxW73offoqOadwfn9WpbEcOBrgJvP3pIk6MMHPuemr
         LYLwcrQgiQh7t5V233e1XMdD+6rEyuHiKvu4CVEfSiVupDEJxI2l73jqD1JkhnRgQ+zF
         YyDmD2ZXCLib6QVFizhyTFSFS5QqagUKrRqd4W4QBjp3WCuTY4G/cjrAUOvDIl/m9rLb
         Zo1w==
X-Gm-Message-State: AOJu0YzbckidrRUD4LV4piT8ZPilq+5ubtmUuBBz51u6MmmehsNBsCb4
	6px/b/t82zBChiGLyBhBFUDnXgmegKuqQIAAGT0uNbHUvEErDfFgsq1vnSVz
X-Google-Smtp-Source: AGHT+IFKz25ObLA5Y8Rt20NgtF4sUMuroNl0PTV7bApqRcAkKf4coLkQ7ytanmGVM6x7BMxeqO9weQ==
X-Received: by 2002:a05:600c:4f04:b0:412:eeb6:b27 with SMTP id l4-20020a05600c4f0400b00412eeb60b27mr3741592wmq.17.1710100264756;
        Sun, 10 Mar 2024 12:51:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b004131d2307e7sm6631961wmq.12.2024.03.10.12.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:51:03 -0700 (PDT)
Message-ID: <3235542cc6f77779cca1aeff65236e16b0a15d76.1710100261.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
	<pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:51:01 +0000
Subject: [PATCH v2 2/2] builtin/am: allow disabling conflict advice
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    ZheNing Hu <adlternative@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

When 'git am' or 'git rebase --apply' encounter a conflict, they show a
message instructing the user how to continue the operation. This message
can't be disabled.

Use ADVICE_MERGE_CONFLICT introduced in the previous commit to allow
disabling it. Update the tests accordingly, as the advice output is now
on stderr instead of stdout. In t4150, redirect stdout to 'out' and
stderr to 'err', since this is less confusing. In t4254, as we are
testing a specific failure mode of 'git am', simply disable the advice.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/am.c          | 14 +++++++++-----
 t/t4150-am.sh         |  8 ++++----
 t/t4254-am-corrupt.sh |  2 +-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d1990d7edcb..0e97b827e4b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1150,19 +1150,23 @@ static const char *msgnum(const struct am_state *state)
 static void NORETURN die_user_resolve(const struct am_state *state)
 {
 	if (state->resolvemsg) {
-		printf_ln("%s", state->resolvemsg);
+		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", state->resolvemsg);
 	} else {
 		const char *cmdline = state->interactive ? "git am -i" : "git am";
+		struct strbuf sb = STRBUF_INIT;
 
-		printf_ln(_("When you have resolved this problem, run \"%s --continue\"."), cmdline);
-		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
+		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\"."), cmdline);
+		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
 
 		if (advice_enabled(ADVICE_AM_WORK_DIR) &&
 		    is_empty_or_missing_file(am_path(state, "patch")) &&
 		    !repo_index_has_changes(the_repository, NULL, NULL))
-			printf_ln(_("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
+			strbuf_addf(&sb, _("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
 
-		printf_ln(_("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
+		strbuf_addf(&sb, _("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
+
+		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", sb.buf);
+		strbuf_release(&sb);
 	}
 
 	exit(128);
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 3b125762694..5e2b6c80eae 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1224,8 +1224,8 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
 
 test_expect_success 'skip an empty patch in the middle of an am session' '
 	git checkout empty-commit^ &&
-	test_must_fail git am empty-commit.patch >err &&
-	grep "Patch is empty." err &&
+	test_must_fail git am empty-commit.patch >out 2>err &&
+	grep "Patch is empty." out &&
 	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
 	git am --skip &&
 	test_path_is_missing .git/rebase-apply &&
@@ -1236,8 +1236,8 @@ test_expect_success 'skip an empty patch in the middle of an am session' '
 
 test_expect_success 'record an empty patch as an empty commit in the middle of an am session' '
 	git checkout empty-commit^ &&
-	test_must_fail git am empty-commit.patch >err &&
-	grep "Patch is empty." err &&
+	test_must_fail git am empty-commit.patch >out 2>err &&
+	grep "Patch is empty." out &&
 	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
 	git am --allow-empty >output &&
 	grep "No changes - recorded it as an empty commit." output &&
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 45f1d4f95e5..661feb60709 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -59,7 +59,7 @@ test_expect_success setup '
 # Also, it had the unwanted side-effect of deleting f.
 test_expect_success 'try to apply corrupted patch' '
 	test_when_finished "git am --abort" &&
-	test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual &&
+	test_must_fail git -c advice.amWorkDir=false -c advice.mergeConflict=false am bad-patch.diff 2>actual &&
 	echo "error: git diff header lacks filename information (line 4)" >expected &&
 	test_path_is_file f &&
 	test_cmp expected actual
-- 
gitgitgadget
