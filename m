Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BBCC33CBA
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09514207E0
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0q3QVVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgAPGOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39397 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbgAPGOs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so2445071wmj.4
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GIfeYd8rHefjwmUR6xdd2aWhIeIwROqlPqBkSmCLbuI=;
        b=Z0q3QVVtmfSPdkS9tPwa5UoEm1E+J5X1dqc0XpXTLQnyRio8ASq0f5bXRbbLeOE6+7
         gQ7k+1D3wyx3aKerGklaM8SRK/Ry/xodsYH1JhSaOw41LJt7o2R3mMAPZRCIUtLndB8o
         4zvFo2s+hovYdmLRfRwGuTK4c+YTWngCoSUQ9HLiW7avmxroIFYKTp+1a3RrolEVKvM2
         g0v3T6wqVK1hX0RvAWpeizBjUJszOUnW+8/8OiUL5FDY/xgqbcg3fK3N/xLr3dsh3Q4t
         jrgm6YkEcY1upxUSyy+L3zVkgogz0CJBWRLhY5Fp/STK3ejXhN+BkfHAn0S4ZCauhCu0
         iyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GIfeYd8rHefjwmUR6xdd2aWhIeIwROqlPqBkSmCLbuI=;
        b=argPkrTwSjDhBUHTbq437Ypse5Awb6Ql1n6EvywEWNdPIxcKCIbFm28wTY08n76WUJ
         e3TEdGNF5ZXTxzHk5OL+/wXudijwR4J235w2ibo+JPq+VloL3eiUVtk8XvTXBuQUCdvg
         EwTP14bFawAcFYxnvWO3UsXkvmAKBviunrLdgr2hwLvKtMJEKeERlp/hvvTe+T9/x3GD
         iHRXUaMcrKGQfpLDWSJaaB8SQb8kizv55B0DkId8irJqAwKg2GN3AiNcKNb6MYh4s47l
         JFYcRGqC+WHTjuT1nHahGSIDuQaLxL1iHyt6KKKxHtvH8g/hR30DWd/WSeWHXDK2YaFy
         JboQ==
X-Gm-Message-State: APjAAAU+V1I2wJ5JGy0S8oGZFvb1JlWo2/KjtR/PM9IMQunslb0jPY1o
        w9y3rjl7bf14NbDy+kxUrrbCwice
X-Google-Smtp-Source: APXvYqxb6IpQT+pduow4njOxM0YS9q8EPnBuw0CqOqp7Qywallj1MzFm1mTTQRfkUIt3UEqhJWbBlQ==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr4452292wmb.43.1579155286104;
        Wed, 15 Jan 2020 22:14:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm25174976wrt.29.2020.01.15.22.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:45 -0800 (PST)
Message-Id: <db5e29bd818c57d88c2c317a3b3d81ff81c5c594.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:28 +0000
Subject: [PATCH v4 14/19] git-prompt: change the prompt for interactive-based
 rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the past, we had different prompts for different types of rebases:
   REBASE: for am-based rebases
   REBASE-m: for merge-based rebases
   REBASE-i: for interactive-based rebases

It's not clear why this distinction was necessary or helpful; when the
prompt was added in commit e75201963f67 ("Improve bash prompt to detect
various states like an unfinished merge", 2007-09-30), it simply added
these three different types.  Perhaps there was a useful purpose back
then, but there have been some changes:

  * The merge backend was deleted after being implemented on top of the
    interactive backend, causing the prompt for merge-based rebases to
    change from REBASE-m to REBASE-i.
  * The interactive backend is used for multiple different types of
    non-interactive rebases, so the "-i" part of the prompt doesn't
    really mean what it used to.
  * Rebase backends have gained more abilities and have a great deal of
    overlap, sometimes making it hard to distinguish them.
  * Behavioral differences between the backends have also been ironed
    out.
  * We want to change the default backend from am to interactive, which
    means people would get "REBASE-i" by default if we didn't change
    the prompt, and only if they specified --am or --whitespace or -C
    would they get the "REBASE" prompt.
  * In the future, we plan to have "--whitespace", "-C", and even "--am"
    run the interactive backend once it can handle everything the
    am-backend can.

For all these reasons, make the prompt for any type of rebase just be
"REBASE".

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-prompt.sh | 6 +-----
 t/t9903-bash-prompt.sh           | 8 ++++----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1d510cd47b..014cd7c3cf 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -429,11 +429,7 @@ __git_ps1 ()
 		__git_eread "$g/rebase-merge/head-name" b
 		__git_eread "$g/rebase-merge/msgnum" step
 		__git_eread "$g/rebase-merge/end" total
-		if [ -f "$g/rebase-merge/interactive" ]; then
-			r="|REBASE-i"
-		else
-			r="|REBASE-m"
-		fi
+		r="|REBASE"
 	else
 		if [ -d "$g/rebase-apply" ]; then
 			__git_eread "$g/rebase-apply/next" step
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 88bc733ad6..7ca35d358d 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -163,7 +163,7 @@ test_expect_success 'prompt - inside bare repository' '
 '
 
 test_expect_success 'prompt - interactive rebase' '
-	printf " (b1|REBASE-i 2/3)" >expected &&
+	printf " (b1|REBASE 2/3)" >expected &&
 	write_script fake_editor.sh <<-\EOF &&
 		echo "exec echo" >"$1"
 		echo "edit $(git log -1 --format="%h")" >>"$1"
@@ -180,7 +180,7 @@ test_expect_success 'prompt - interactive rebase' '
 '
 
 test_expect_success 'prompt - rebase merge' '
-	printf " (b2|REBASE-i 1/3)" >expected &&
+	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase --merge b1 b2 &&
@@ -189,11 +189,11 @@ test_expect_success 'prompt - rebase merge' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - rebase' '
+test_expect_success 'prompt - rebase am' '
 	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
-	test_must_fail git rebase b1 b2 &&
+	test_must_fail git rebase --am b1 b2 &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
-- 
gitgitgadget

