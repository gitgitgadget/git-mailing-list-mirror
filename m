Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AEEC4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D1920867
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1SBPJiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgKPKXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgKPKXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:23:09 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37580C0613D1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:09 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so18028897wrf.12
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7NKR8/TOOCNoRIdKvR8AV7cjS9Gl1SgDrV3MY2xgjQI=;
        b=H1SBPJiUTde3ZYbFmig80B4Li86asJChdckzteJFpXQM4dNExs2+TxL3jn+K0gFJhi
         I68P4P/CvRZ5QU6uK9N5UgJ3WODiRLjMyJagIFIgMIFtb5KyBsySFnUlRseYHiWKPxvW
         GAjVVxrkUMo/ahb74H/hsaXfUVnzeB7EL4s6Doy7s2Mv5MIPVLggD0ESlNQ6xAKIEzhX
         URd3kL1pCMk78tQ3MDI8C6VxbINumEGoNBO+FiW9I6WpftPMrLxA8/zNgI1jRBG/oU4T
         hRCNar+/h2i6RpSnqZA0H/6rf13CSnu1Nv+xcNxL0taEpp2qXlCI70Zw+n7cxDkVK1Su
         M/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7NKR8/TOOCNoRIdKvR8AV7cjS9Gl1SgDrV3MY2xgjQI=;
        b=LLN1iEZVfwMkUkk7ybiGXeyZe39cYvM/QxPtIsHxNgRMzgsepsABF9mfvkzg8AL3re
         09sWHAv9pi+/7kb4RFF+A6jMNIh5d+Y6HkaFXXj9XiI9ql1iB3AtwUlkNZlXF3QrY9Wp
         SydL9kWpuethXUxbluh/jPKWVeV1Grn9ht8E1vktcyp4vrUoNW+wqChdORC/zZZB8Ig2
         FLqTFZEqxoehTEnobWsl3g1x8DshpmosMb1jL4la7hUDkyiN7xsR1HfyLO1VnNvO1m0y
         +vLnMnK3ofXJe8j5vUF5DflMTuQrAakl2D2+jmbzPQNqpvvnmW8Ilyx7V86wQilSX/Of
         XgFw==
X-Gm-Message-State: AOAM533bMhC5oxpPdssbaPFyzQkQ4Tm+6d+0bcCHuFlo7fBSjphIkYlf
        z2vSIY6aRIgYa0NE7NL1EOUHSF8uG/0=
X-Google-Smtp-Source: ABdhPJw6FLp8A1a+sGYZ+TYdHDIOruaFwtM9bNbS7VfkkahXrRb54TtJsZ3h/Aa44Sc2y3tGu/iHmA==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr19756809wrn.39.1605522187703;
        Mon, 16 Nov 2020 02:23:07 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id f5sm22884520wrg.32.2020.11.16.02.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:23:07 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 01/12] t6027: modernise tests
Date:   Mon, 16 Nov 2020 11:21:47 +0100
Message-Id: <20201116102158.8365-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116102158.8365-1-alban.gruin@gmail.com>
References: <20201113110428.21265-1-alban.gruin@gmail.com>
 <20201116102158.8365-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in t6027 uses a if/then/else to check if a command failed or
not, but we have the `test_must_fail' function to do it correctly for us
nowadays.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6407-merge-binary.sh | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 4e6c7cb77e..071d3f7343 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -5,7 +5,6 @@ test_description='ask merge-recursive to merge binary files'
 . ./test-lib.sh
 
 test_expect_success setup '
-
 	cat "$TEST_DIRECTORY"/test-binary-1.png >m &&
 	git add m &&
 	git ls-files -s | sed -e "s/ 0	/ 1	/" >E1 &&
@@ -35,33 +34,19 @@ test_expect_success setup '
 '
 
 test_expect_success resolve '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s resolve master
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s resolve master &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_expect_success recursive '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s recursive master
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s recursive master &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_done
-- 
2.20.1

