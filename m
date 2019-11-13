Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEFC1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 19:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfKMTjV (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 14:39:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34393 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfKMTjU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 14:39:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id 139so3945903ljf.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 11:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpRNJ952/+8rN/3rJEBc+5APlw5D8qYuxEoCrn7SYEk=;
        b=I72U1RhRVH3pjowhfc/8tiQ0zpvYyPGV0oxUU88glOsrJLQhHVHC8viMinN9x1LP/d
         9EaJRS3XBV1Ku80uKlj7pJaPEEdyYVG++l1R/v162ulbH2EN3Co5BB8VHg2jZoMf9M3V
         OjSOLPbq79oYEdDcBWnkk4HAJcIVWSwUiqqxI+bcxoWaOy8XwjV9ye1wuDXwVX+TavRZ
         RfVZCkKLbbtnw2PzzfQXB72rx27hFN2F4uvdsxR2TzILl8vzoXxNn34aARTgfbbH4JV+
         6EoL08nFzPDno3iI8mBvujOM5nGekVGXiBFoGAAOCdEzjT4qkhSS2ehF8QXWOaF9iOaT
         PEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpRNJ952/+8rN/3rJEBc+5APlw5D8qYuxEoCrn7SYEk=;
        b=Q4MdzfN7BWH1xb+6FevWvHqvdMpz9AS4+/dSjhsmBPecCYRFHwJqQ8Sf5A3/TT9KbX
         5rrJFHLU8pDktWz4uxHq+eXhVHnSPm9Gjp2lmfjJyHgjMguYJfUMzNlaw1o1/DhzAzDr
         ufCZ69uDzzc9SkivNPitghsl18n6+Yk4D6chFt6unX1dNhnsfLBqb5PS+TD/gDrFY1cN
         DOrKo0ZytfJw0eUQ+rLIGWLocNG2xBi1Z14tprsxPOJTG9aR5SqgCUtStBpbsBTDVcF+
         Fx3ijE/mjwIVq07RKaw7c+Vsy2iMDY2sJobG5CETiAKucCmJBJCe1mN7q6sIz5/r011u
         kYCQ==
X-Gm-Message-State: APjAAAVL2ff0cxEU27GcsFoK+4X0gFhCsWyblyrVsFT1/2kZWImJ9Dx/
        KrdA990eLbSML+A9QzX0Mf5C8OUW
X-Google-Smtp-Source: APXvYqwGbG5AHh1IZjgEIl6GJnu15a2Ggr+lD4ry0UkyKEbuKPeSZJi+FEFkUoeNMtViNzNdecEn9g==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr1356446ljj.56.1573673958850;
        Wed, 13 Nov 2019 11:39:18 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id y7sm822330lfb.75.2019.11.13.11.39.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 11:39:18 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] t7004: check existence of correct tag
Date:   Wed, 13 Nov 2019 20:39:02 +0100
Message-Id: <20191113193902.29263-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We try to delete the non-existing tag "anothertag", but for the
verifications, we check that the tag "myhead" doesn't exist. "myhead"
isn't used in this test except for this checking. Comparing to the test
two tests earlier, it looks like a copy-paste mistake.

Perhaps it's overkill to check that `git tag -d` didn't decide to
*create* a tag. But since we're trying to be this careful, let's
actually check the correct tag. While we're doing this, let's use a more
descriptive tag name instead -- "nonexistingtag" should be obvious.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 This is a resend of
 https://public-inbox.org/git/20190808125330.3104954-1-martin.agren@gmail.com/

 t/t7004-tag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 80eb13d94e..e4cf605907 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -227,10 +227,10 @@ test_expect_success \
 test_expect_success \
 	'trying to delete two tags, existing and not, should fail in the 2nd' '
 	tag_exists mytag &&
-	! tag_exists myhead &&
-	test_must_fail git tag -d mytag anothertag &&
+	! tag_exists nonexistingtag &&
+	test_must_fail git tag -d mytag nonexistingtag &&
 	! tag_exists mytag &&
-	! tag_exists myhead
+	! tag_exists nonexistingtag
 '
 
 test_expect_success 'trying to delete an already deleted tag should fail' \
-- 
2.24.0

