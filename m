Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D4FC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C090206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oW+Yz4nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404760AbgFYMs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404756AbgFYMs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:48:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEB8C061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:48:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so5804728wmo.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DjiSFN9cempB7IuLRuXJRcuFRVaXGfWq9j9duwvjoM=;
        b=oW+Yz4nXDRryB16JB5VxPnmcw+gzKPcFvPhO0qwHkejzPRU8b/xiLmgo2qgf0OVTTb
         N3l2nlGJjEy+a1RBcQOkBXcQLtGxNLhnBUGw7cFR2kFOskRx2oAqVGyzdjjDl75pJIMR
         +RMDqVtmSCNiJwE+LlQda26KhmaYeJQc62GXM4XURU/HfZwzx+rIucAO8CfwioAaftB+
         ITIQ5RQ0dujCp0zEmm39K10rmiHOII4RLWMychEPIzLsXJyUBqO1dkmzcRl2vR679hsN
         eF0cQIRlxiArQDPHkI8M84na9R7kWx9W9GkY7m1NnjzaNIEGYTR/8SJfOiyNnpkrMWZl
         YWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DjiSFN9cempB7IuLRuXJRcuFRVaXGfWq9j9duwvjoM=;
        b=GddhgCVlLZ/YKLXaDu5IljfJUay+G4r/k/kFBXPippe14NReV92jgcj95no37Op/RP
         i9K7UIQr8e0Ah2J4xsUvuO1SZNq964YDWz2/YNmClsNO300rMKzXFtLHysyklpAQXz2O
         Qx4J6St5DTJ2tukHAa4VY7eZkX6WynRbXHUxryOXzYU34KqrvUM6cZlBwdhvBO1da86w
         FlSvxogds5Chpt2eECGxA2SQMSxG//P+S8fvPcN+2wglsyiMX+ISmZQ04GjiPvu6+RjB
         aXTpf6pgEaj7Np+yd/jZWNfxva8UktaBNNEkZENnC7mWfi6nJXztukPN0Bj57mIeR64I
         6vJw==
X-Gm-Message-State: AOAM53050liuScGKAff8tC5UEzRUb2tVefFxFIwrGB2X0p7kDrEw9Eoj
        1g4lqQXOwuwHD2Idm8rh7pOYIbDi
X-Google-Smtp-Source: ABdhPJx32UYwB+YBd2iG5g0cX07XOSR2hvFGXU//aOmxfnNODYwWycRqnpCwHgAMAG6fSvsChQmuvQ==
X-Received: by 2002:a1c:29c3:: with SMTP id p186mr3210381wmp.122.1593089334256;
        Thu, 25 Jun 2020 05:48:54 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:48:53 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 01/17] t6027: modernise tests
Date:   Thu, 25 Jun 2020 14:19:37 +0200
Message-Id: <20200625121953.16991-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in t6027 uses a if/then/else to check if a command failed or
not, but we have the `test_must_fail' function to do it correctly for us
nowadays.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6027-merge-binary.sh | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/t/t6027-merge-binary.sh b/t/t6027-merge-binary.sh
index 4e6c7cb77e..071d3f7343 100755
--- a/t/t6027-merge-binary.sh
+++ b/t/t6027-merge-binary.sh
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
2.27.0.139.gc9c318d6bf

