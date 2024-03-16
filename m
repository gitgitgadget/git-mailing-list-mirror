Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B631C69E
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710623799; cv=none; b=bx6wUlGaUFNpeIUEG67/jhCKk9/sxU9zkEWGnYF2Wg5v6cnY9N8/pMSiRO4Br2+RnyrVqDxc2aHK3CTqUXYLTVGKfBTzaMXiK+D4Rd1YQlNMtZVBZgFvtFeseVE92PbrH4IQ2TEAsyXn+5/0ioUg+RKuEpUtzDQvOflTS+8+av0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710623799; c=relaxed/simple;
	bh=yq0VCYZHxi8vM50UfQC+dkwwL8SPFAeRZSHThK/Z89M=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DBK6Xb1OF5BWZyjJrR7d6b4HbUDGCsPZ36hH8gA1bcAtkvTPXWjt5mUyS863tKENyKqbG2Nn1vkuqLnUrNiX+L9ml8M40Hqojg0ulnjg99J/M6Cd2vwdjwfdHsSOxqzjobGbntay194+lYpU0i/BLqXZy5uRm2wTFZtfvDIKYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsgsOvhQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsgsOvhQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41409c8edf2so3236485e9.0
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710623795; x=1711228595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSaxwWPbegG1UWeGb32SQFu32RYaO43W7U98YmwYbdQ=;
        b=TsgsOvhQfiqTLOCpw7E3E0bYbZlcTiafm404+x3xGRtECd2FLnbY1USVqb+Gl2IW9d
         syuI0KLDuM6/Y+R/brmmJDCnejlerJvV4Ip6PQ4nzLPZTxiAdWB3NVE+chyqm4JsE6gx
         69B6z6W3WFSq/QDmERNMFf5SpZxegDXlykhpRN9LbeusOqdr343ZGc9dAq8DbLaxJMUK
         ySV/QwwK7mWLWkKx8vpvt2rx8hDLbopHkS9XqlpzTNP+/ltwtdBbscJDSRPZbB9psOve
         9Vbxql7YRkCuTWJprw/taRWgbdX4w3zAaXwIumiUDA1M+5zXYdSVGs/veYn4YFFUpRUW
         UlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710623795; x=1711228595;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSaxwWPbegG1UWeGb32SQFu32RYaO43W7U98YmwYbdQ=;
        b=qNfxUbLPUMB/97LzoQDVcFXaeObBhgaQaEspywSpgBQotAJJoFswTOKqlbZ8QZzoFj
         2aSKH/ZcIyJpGlzsT4jc/tc0iTgLLqvgL4BlD159R8FsgIP/RqlN5Sb3yQqfT30bdji6
         XzMy+KokkUDHNZPd09P6I+9UuZkytAbu6UD79HdM0Ps1DR55pQ9g1cx78v+hLnnC1uQQ
         SL2UHXATN2bcVUkkBRxgpnJ7qOVTZlfjNJicsZM52W8p7QhYXfu8gdkU2Xh1AKISdkVS
         zbofPPE93iwxxoFrh1tsjTjs2gijLsK6mZ4/wfh+MI1ajtJmlduyv6dtIN35Jqci4kTr
         9HAw==
X-Gm-Message-State: AOJu0Yy3GnrVyJQ7bp4hjS1PHk/z5iWzSt0cfdiOxHSJQ5Ep7pqrGv0U
	IJAZlAiO+QR90UuXKhRR+DsNVuF+kkBKRuF3bEIgK8S5RhGinpwtmEaCcet8
X-Google-Smtp-Source: AGHT+IGQYhpFLLqMi2Afm6nLrqAWKiUTye7BC5KJTPSfAKzp6RyV4MQWAgHfcdaK9BziD8eAOdZ7Qg==
X-Received: by 2002:a05:600c:4711:b0:413:f263:5eaa with SMTP id v17-20020a05600c471100b00413f2635eaamr6190136wmo.40.1710623795151;
        Sat, 16 Mar 2024 14:16:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c1c9b00b0041339453775sm12986309wms.48.2024.03.16.14.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 14:16:33 -0700 (PDT)
Message-ID: <73d07c8b6a7fc56510798e7e146cb8b14ad558f7.1710623790.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>
References: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
	<pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 21:16:30 +0000
Subject: [PATCH v3 2/2] builtin/am: allow disabling conflict advice
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
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
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
Note that we are not testing that this advice is shown in 'git rebase'
for the apply backend since 2ac0d6273f (rebase: change the default
backend from "am" to "merge", 2020-02-15).

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/am.c          | 14 +++++++++-----
 t/t4150-am.sh         |  8 ++++----
 t/t4254-am-corrupt.sh |  2 +-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d1990d7edcb..d87847205c7 100644
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
+		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\".\n"), cmdline);
+		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead.\n"), cmdline);
 
 		if (advice_enabled(ADVICE_AM_WORK_DIR) &&
 		    is_empty_or_missing_file(am_path(state, "patch")) &&
 		    !repo_index_has_changes(the_repository, NULL, NULL))
-			printf_ln(_("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
+			strbuf_addf(&sb, _("To record the empty patch as an empty commit, run \"%s --allow-empty\".\n"), cmdline);
 
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
