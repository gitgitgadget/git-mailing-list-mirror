Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF162C43461
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DB0206EF
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHVZi6Om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIAK6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgIAK6L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC068C061245
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b79so700875wmb.4
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLVtIX3yBCG3bHaRqEUcybh6RsscPvkDjj+OpK0wslg=;
        b=CHVZi6OmdLVuXpx8Py2AQzVH/iETRZA4ebxxq5Mi+vX6ZabK4JGSONKBrv96/CZhmw
         q4QZ0OVBjPYcSIeBQ2um5jbbPCJVHgp7OR3xdIOhy2ydMZERNRQJUpMN49OQrhUw6JYP
         qOqk/+XyeX5xrXmzJ6anWZ/Jnu9X0EcZUDj93f2Tgi/qcFwC7/Qt6z+Zuf5db7HBqcyv
         /2Buu8VkVWr6ZnkJgSPEZeJ7s2MdbaNrGz7nEyvzTCAmLWl0gQiKPWA1yXWhcq+bkYcG
         DW69/61/VGHlkvPiQdr3mfkwXnsguSTSRxBzei676xYcFa8BMm/Ea0Y/mV6fOqBkzfNo
         8UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLVtIX3yBCG3bHaRqEUcybh6RsscPvkDjj+OpK0wslg=;
        b=CLsq2+rTe6AuYV3c1cX2TbK7jyVqyTe3NAncucu7KDZ4pu1hzIpriS5estVtTUV9bk
         CBmo/TZoU9b5U5ECgxNOZi5pMMG48aQdlUyPHT+LVMCegOxwo8SSc+FTvcfS7u6KeMJy
         QzQOVM4PFVkkXcN6s72U31Ss4xfJwjXaQB1edVIbnlY/dvV+GyH/oai9LU0SqVEalqQC
         0y7Oo0VVpeqMGo8KaPiCLybr9HFOkZJF/z/UcHpOcczK2EoSnMCeEzkxmAgMhubpY2Nc
         ewEyzegwWAup8OQy3xus7XRvvisu1lzfsnPoFkxs8/ktfIMP1awzEh0MsM+pMWoKtp5Q
         ds9A==
X-Gm-Message-State: AOAM530uEhjdu2yEXcgUT1F83Voe9XbZxLAzDHMjTIyx286EE6Rsxj6t
        9z8IlVHRXbithDiaM4UdTFbO+k3Y6Gc=
X-Google-Smtp-Source: ABdhPJwfmAIsqmW1tZw/B0IfvfoI1ZXy+P+FInxIpLFc6YwXa7AueFCRoBFUJg+4czb7u3p6LOD80Q==
X-Received: by 2002:a7b:c359:: with SMTP id l25mr1154308wmj.187.1598957889130;
        Tue, 01 Sep 2020 03:58:09 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:08 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 01/11] t6027: modernise tests
Date:   Tue,  1 Sep 2020 12:56:55 +0200
Message-Id: <20200901105705.6059-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901105705.6059-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
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
2.28.0.370.g2c2dc3cc62

