Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3403BC2D0D6
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A96820643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxqFovx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfLWSuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33978 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfLWSuK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id l8so16132935edw.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7qSgvBDr3bMQDIoamanHRnPiS//NFnkIhKydL2T43TE=;
        b=pxqFovx8n1yIOLwELNqQ0JrwOWptj//KRSnQssWG/FL7uWbIUxXo+SlUYqqln+7Rvh
         PmminSjwwfXm94WO6QCCagywJ5T/gxW512RJXriQOtbuZ7LDLSkFYbCIbXkPSa4wKkoL
         0fHpxYpbbzUdVmVvH+afkCBnU/9dJvD4WQ4IGscW1Ifc6Gu85vEetWyyR/UJDYq8Ba+a
         iUGJmqRtZaSSxl9yAECHBQQQEL/n9+YBCVIKPNwiEi8RtOB/npge4yBteSIhOsfXFdli
         go+MIcUowQ4eFcPN2xVCdQFFpQONfOOSqlNT8VNigLbqMOitZI8lSA3Cz63aY6D4VKhl
         LREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7qSgvBDr3bMQDIoamanHRnPiS//NFnkIhKydL2T43TE=;
        b=MivV+I6qB/15SfAwy2XfAd3Z0wSE+JG9w6dWvG05LGtY9YrKlHtqRJ6IyZoFeMuVZr
         ng1C4SOnhoj3vFlE1tW7o1nluK5FIRPYWTr+Mzl3EE/AlKktKpUIEgVuDhDwEKCO4cYS
         CKTn3KTHkktOmbZI1JJi5hXZjz0BQFY9h+2WdKXPo1LeJokF1R9XMKa+Ljzlgr5tprcu
         7+3Fx7RhJ87OzjLwNEqZStW/ilnO22BdYstYUv1MOP2QkDgwumMMl0z0kl4iVLEeot/Q
         IxLxmfMfJ47INvol5Bfwh3fsm1qLsgHykGleOttOwHaVMa+FCiCKn+cnz2PCfe8ylZh7
         yV1Q==
X-Gm-Message-State: APjAAAVaPsfZBOzkoo98n8JAuE4K5D4ENbHAjQ94bLouIaEYIlUHjCLV
        PzeA0qJnP3J4X7dW6hhYPuiu/FVO
X-Google-Smtp-Source: APXvYqyVENf8GTKR5LU6iTI9ijZZ4vtWrtMUGMS09p2n3T1668JUADLyk0kWAUseIuKW0Bk3CDqaeg==
X-Received: by 2002:a17:906:90d6:: with SMTP id v22mr33211768ejw.294.1577127009098;
        Mon, 23 Dec 2019 10:50:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id br7sm2416239ejb.13.2019.12.23.10.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:08 -0800 (PST)
Message-Id: <94b5a3051d743e8f54c21bc4cd0413f3c0dd05fa.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:55 +0000
Subject: [PATCH v2 11/15] contrib: change the prompt for interactive-based
 rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
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
 contrib/completion/git-prompt.sh | 4 ++--
 t/t9903-bash-prompt.sh           | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1d510cd47b..8f8a22ba60 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -430,9 +430,9 @@ __git_ps1 ()
 		__git_eread "$g/rebase-merge/msgnum" step
 		__git_eread "$g/rebase-merge/end" total
 		if [ -f "$g/rebase-merge/interactive" ]; then
-			r="|REBASE-i"
+			r="|REBASE"
 		else
-			r="|REBASE-m"
+			r="|REBASE"
 		fi
 	else
 		if [ -d "$g/rebase-apply" ]; then
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

