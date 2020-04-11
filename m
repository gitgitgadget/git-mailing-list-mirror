Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16ECC2BA2B
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7A320753
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q74v+CeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDKNk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 09:40:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42109 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgDKNk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 09:40:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id cw6so5734539edb.9
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=op5GSnlhL/YoXZI1LyY8dq//pbXY0OgtyDh+VHc0oa8=;
        b=Q74v+CeC5JGu+JOrMwwiz0vewDLcbwK1XkuLp6su6spdN90Jvzd9Kkrw/AF94oELvu
         VVRq/9apASB+yW9dA6X9aoZ2QJSil4TEBw6u7/PxjKA2Hl7xVCG0Ftjmjg9DAlRwBL4C
         PLnXzW56wIIuW1OB61q2QLlQGCCwCmC06yZuvfYHhgltTuHHE4trAyVmE96ve6lr2uG/
         r00oTKAEwxKD3RCUUy8wx+6suPZl2sGwsb6qb9m7py7NzYloQf9sgvcqXcemSNo4vhlB
         AtjkKYSD/ivud6anbrURZuR/CFAWQuIPGuqZXrroXn61dtO5mABHMPnkA89j4aB8ukxx
         RhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=op5GSnlhL/YoXZI1LyY8dq//pbXY0OgtyDh+VHc0oa8=;
        b=n79ZfRnPAOoK/ePNwLwMV8oMSvl9STPYfJMnadJFr34T4g9XvNbqPLlsX6r2ObrF9q
         XF8RJjNdVy/ln5LwMsP2Cpp6HhC3CfH3QjxPnzoTnu8zn0aij1IRJksLlw9zeakejrJg
         ul6vi8ulmK+6UjJACYNq1G03juRGS+i8VSq6Ggy/kUBaI6AQRz03f6+NIwXTmrLHe8la
         QSPqy1ilhG4+Agna4UDPitoggxJe5cjuNQVYE340u7pLq9myLNbwD2Zj3NJbPAhwKHui
         lfFulRQ3IkH305pJKPtnfBxt/chTxYHLlHURttAmWUbGCrvYLCZIxij09nbfq92zTqBT
         OJCg==
X-Gm-Message-State: AGi0PuYONufQ0jd17Xcvn69Sfblw670A0u17cvM6A18tAMwWz1Gptsv+
        YRHjW/v425q2DGtccQ7Ma2bPP4mv
X-Google-Smtp-Source: APiQypJZfC1I7uxzid+E9Rv4ycn4BorrLSMFrpuKox8qlqn/OKTlBPLrYksGDbvdH4OWMN6rIPO0kA==
X-Received: by 2002:a50:ef10:: with SMTP id m16mr9277094eds.128.1586612427142;
        Sat, 11 Apr 2020 06:40:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm548983edb.90.2020.04.11.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 06:40:26 -0700 (PDT)
Message-Id: <b26044599172b72d920f2d2ea6854daefcd16bc1.1586612423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.603.v3.git.1586612422.gitgitgadget@gmail.com>
References: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
        <pull.603.v3.git.1586612422.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 13:40:22 +0000
Subject: [PATCH v3 3/3] t: restrict `is_hidden` to be called only on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The function won't work anywhere else, so let's mark it as an explicit
bug if it is called on a non-Windows platform.

Let's also rename the function to avoid cluttering the global namespace
with an overly-generic function name.

While at it, we also fix the code comment above that function: the
lower-case `windows` refers to something different than `Windows`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh         | 2 +-
 t/t5611-clone-config.sh | 6 +++---
 t/test-lib-functions.sh | 7 +++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9cc919d8d1a..1edd5aeb8f0 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -399,7 +399,7 @@ test_expect_success MINGW '.git hidden' '
 		mkdir newdir &&
 		cd newdir &&
 		git init &&
-		is_hidden .git
+		test_path_is_hidden .git
 	) &&
 	check_config newdir/.git false unset
 '
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index c861e12ea44..8e0fd398236 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -96,13 +96,13 @@ test_expect_success MINGW 'clone -c core.hideDotFiles' '
 	test_commit attributes .gitattributes "" &&
 	rm -rf child &&
 	git clone -c core.hideDotFiles=false . child &&
-	! is_hidden child/.gitattributes &&
+	! test_path_is_hidden child/.gitattributes &&
 	rm -rf child &&
 	git clone -c core.hideDotFiles=dotGitOnly . child &&
-	! is_hidden child/.gitattributes &&
+	! test_path_is_hidden child/.gitattributes &&
 	rm -rf child &&
 	git clone -c core.hideDotFiles=true . child &&
-	is_hidden child/.gitattributes
+	test_path_is_hidden child/.gitattributes
 '
 
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f81463a240..139647a6341 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1544,8 +1544,11 @@ test_bitmap_traversal () {
 	rm -f "$1.normalized" "$2.normalized"
 }
 
-# Tests for the hidden file attribute on windows
-is_hidden () {
+# Tests for the hidden file attribute on Windows
+test_path_is_hidden () {
+	test_have_prereq MINGW ||
+	BUG "test_path_is_hidden can only be used on Windows"
+
 	# Use the output of `attrib`, ignore the absolute path
 	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
 	return 1
-- 
gitgitgadget
