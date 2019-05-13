Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8F61F461
	for <e@80x24.org>; Mon, 13 May 2019 16:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfEMQre (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 12:47:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41879 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEMQrd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 12:47:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so7053848pgp.8
        for <git@vger.kernel.org>; Mon, 13 May 2019 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wn+lc8tHsmTK2wG2I9rFUkJ6AjgbbtPM4/r0xyGG8l0=;
        b=VfY0loiZUl0nj0Yc8AkxK+vCGneQRqdN6Cjnjzb0QyuHZbAoEe7G4WAplQMkp6a7Zu
         sktDde0H9CNhU+gmXIoeTfNVcIuktSefGqvukdELtb85m6QOyoNf53LhiQ/ZDWLdIKz5
         z9km6XKOS01N7vrDwwxq1tsSuFwHa2pDt6//TDsuROvo1bOlQ/8H63n4XnV+9/+C6h8W
         0Gc3yglpxOnDDqFjNvcRrBvmguz0uACFRWRc5RPqSK8q8UPziuGAwTIAfwIlmWnEd5iQ
         Eo1mSJDB+Cj/qhbkCSU1hD21/w+BdftQVoh3Cd9U3NGawnhPiEwb0zo9vE6nToLVcQIv
         Y7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wn+lc8tHsmTK2wG2I9rFUkJ6AjgbbtPM4/r0xyGG8l0=;
        b=AlFUycFMfRjlsc9s/yYCE6jlUJubEcn+7WdeCv7j3ogaTTGJht9t+nw/MkSMy6nSx1
         pW64qx8I22nEXfFSaQE74fcjaT23Qp5Yu1hJ2JlXnZWVRKEo38UBu+LI3yxUHNqeD4rp
         ot64STYssgTzNVFIs2qJy7I7FXPProRfWb0ub6g4Wp3wRc6wDSuRfolFd4fZaZeaE8mQ
         aSkn3TfFRRF3SGtHNfw4StSw6KdH40kRffKnUn4iO+E5a+ME4lVUY9oJBkcmvyId+M58
         slWvAbIIQczUVCsSpWqLYRQQ3PTFotfg1Nbzy4zehOD1vkbWr9cMf1qudBl1SkMxQrz3
         xODA==
X-Gm-Message-State: APjAAAXKHrsLsrmW5Wp7t46EeO41dkOvP3ohwNoP8CJnFMKYmqlEbg45
        O7Zo7GMUY0Uo3iW/maD/bKs=
X-Google-Smtp-Source: APXvYqw1Yzc9f30GiI0bFsqwxD7rTbHYukqI1JeeNEg7vRnP00sT2msYr6OzXeWqUR9G1+2NgwCfug==
X-Received: by 2002:a63:36c6:: with SMTP id d189mr18903901pga.8.1557766052697;
        Mon, 13 May 2019 09:47:32 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n35sm2851206pgl.44.2019.05.13.09.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 09:47:32 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 1/5] t9350: fix encoding test to actually test reencoding
Date:   Mon, 13 May 2019 09:47:18 -0700
Message-Id: <20190513164722.31534-2-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g571613a09e
In-Reply-To: <20190513164722.31534-1-newren@gmail.com>
References: <20190510205335.19968-1-newren@gmail.com>
 <20190513164722.31534-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test used an author with non-ascii characters in the name, but
no special commit message.  It then grep'ed for those non-ascii
characters, but those are guaranteed to exist regardless of the
reencoding process since the reencoding only affects the commit message,
not the author or committer names.  As such, the test would work even if
the re-encoding process simply stripped the commit message entirely.
Modify the test to actually check that the reencoding in utf-8 worked.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t9350-fast-export.sh                       | 27 ++++++++++++--------
 t/t9350/simple-iso-8859-7-commit-message.txt |  1 +
 2 files changed, 18 insertions(+), 10 deletions(-)
 create mode 100644 t/t9350/simple-iso-8859-7-commit-message.txt

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5690fe2810..c721026260 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -94,22 +94,30 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
 	test $MUSS = $(git rev-parse --verify refs/tags/muss)
 '
 
-test_expect_success 'iso-8859-1' '
+test_expect_success 'iso-8859-7' '
 
-	git config i18n.commitencoding ISO8859-1 &&
-	# use author and committer name in ISO-8859-1 to match it.
-	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_config i18n.commitencoding iso-8859-7 &&
 	test_tick &&
 	echo rosten >file &&
-	git commit -s -m den file &&
-	git fast-export wer^..wer >iso8859-1.fi &&
-	sed "s/wer/i18n/" iso8859-1.fi |
+	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
+	git fast-export wer^..wer >iso-8859-7.fi &&
+	sed "s/wer/i18n/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
+		 # The commit object, if not re-encoded, would be 240 bytes.
+		 # Removing the "encoding iso-8859-7\n" header drops 20 bytes.
+		 # Re-encoding the Pi character from \xF0 (\360) in iso-8859-7
+		 # to \xCF\x80 (\317\200) in utf-8 adds a byte.  Check for
+		 # the expected size.
+		 test 221 -eq "$(git cat-file -s i18n)" &&
+		 # ...and for the expected translation of bytes.
 		 git cat-file commit i18n >actual &&
-		 grep "Áéí óú" actual)
-
+		 grep $(printf "\317\200") actual &&
+		 # Also make sure the commit does not have the "encoding" header
+		 ! grep ^encoding actual)
 '
+
 test_expect_success 'import/export-marks' '
 
 	git checkout -b marks master &&
@@ -224,7 +232,6 @@ GIT_COMMITTER_NAME='C O Mitter'; export GIT_COMMITTER_NAME
 
 test_expect_success 'setup copies' '
 
-	git config --unset i18n.commitencoding &&
 	git checkout -b copy rein &&
 	git mv file file3 &&
 	git commit -m move1 &&
diff --git a/t/t9350/simple-iso-8859-7-commit-message.txt b/t/t9350/simple-iso-8859-7-commit-message.txt
new file mode 100644
index 0000000000..8b3f0c3dba
--- /dev/null
+++ b/t/t9350/simple-iso-8859-7-commit-message.txt
@@ -0,0 +1 @@
+Pi: �
\ No newline at end of file
-- 
2.21.0.782.g571613a09e

