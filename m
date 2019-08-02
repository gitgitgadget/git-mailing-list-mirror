Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA81D1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 09:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406603AbfHBJ6l (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 05:58:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43655 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406933AbfHBJ5h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 05:57:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so47708688ljk.10
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWWx71o67XTI0PBPUgG3FzPmjhvDdfA99bgmG9NcGZc=;
        b=e999KSoLZtsaSXN3ooH7a3l9CivmP/ZdQ/rTKzaU5IHmPvgDqVritYyjY3dtSZIL0f
         h98B+9nfE32NPAaJ5OuEUA+PC50qTXm/dDOvkcu+LEp3QkQiRaluNVfAebXXYKV98MtP
         rQl9Z4Kno5jeIZ5DnTL6ETwab8Hxwb/4BT5BWYe/2rZ2XVO4bdJP1VGgzCioa3RG4x/d
         YgeYqQ17TmMXXcmCyzjxOY5a9UcRBoSQmT7hNZc4Afx4ANVT07LRZWv+lJffzlegkNWF
         GmiQdBq53B8CvZg2nHDSBIE7klB3j6VtXmVdYhDXhcZpInnlBBtXC3QaZUZtZzdW9kyG
         UU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWWx71o67XTI0PBPUgG3FzPmjhvDdfA99bgmG9NcGZc=;
        b=dI+b8/wsAVH43XHAXmFmOgPcNHVKgb2DoDfXV5FES8/GEDqjN2vvwgIaVQTnWTR/aL
         lDZjesvHu3F0X1RZ4GbKUJebspc8UMh1k1mskMaP9GIAbTYQch0d3BxbhncoN5SQ3aLj
         hmauFz4pNoMkYp/mVX1yLho1sghK9rut8f+isP4GjQJdgcK8p4BjeVKMalu8Fr877DZi
         CEryx7C7S0Ev8VfhsL2MsnmtJU8STlArhs6vEj5elYn7jxFUS1bGEHfK+DF4/e1tQoE0
         Sw9Axj/mzx27mS3j2R2Fu/w6NEowf5B7Bqb+fxYl0PvcglE+pYuWhlOcRIcQHo+2JzqO
         GAfQ==
X-Gm-Message-State: APjAAAUakDi3IbBYYBt7dM2SUVe8PTbSahMB08QzESmnZw5acF4UPB+5
        9wj9NhextjYRIFO3jrosfaw=
X-Google-Smtp-Source: APXvYqzEJOmMbmtS7PtyWaJ8OFKJbMmdBhpzjeiU+wwiFJeu8/O63VKFsWdxfVIKdh1CuMg4q4XD/w==
X-Received: by 2002:a2e:854d:: with SMTP id u13mr72650580ljj.236.1564739855345;
        Fri, 02 Aug 2019 02:57:35 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id y12sm14237344lfy.36.2019.08.02.02.57.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:57:34 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 4/5] t7503: don't create "actual_hooks" for later appending
Date:   Fri,  2 Aug 2019 11:56:38 +0200
Message-Id: <4901b00e7c96452c030354e4e582f55f5d6b1de1.1564737003.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0.30.g51cf315870
In-Reply-To: <cover.1564737003.git.martin.agren@gmail.com>
References: <cover.1564695892.git.steadmon@google.com> <cover.1564737003.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we fail to call the hook, we won't append to "actual_hooks".
"test_cmp" is able to handle a missing file just fine, so these
"pre-creations" are mostly confusing. Let's drop them.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
--
 This "pre-creation" does protect against the file already
 existing, i.e., it could be seen as a "clearing". But since
 we use "test_when_finished" in this script... Also, these
 were "touch" before another of my suggestions, so these
 really were "pre-creating" these files if needed.

 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index 477207cb5c..f0c73fd58d 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -76,7 +76,6 @@ test_expect_success '--no-verify with no hook (merge)' '
 test_expect_success 'with succeeding hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "success.sample" "$PRECOMMIT" &&
-	>actual_hooks &&
 	echo "$PRECOMMIT" >expected_hooks &&
 	echo "more" >>file &&
 	git add file &&
@@ -87,7 +86,6 @@ test_expect_success 'with succeeding hook' '
 test_expect_success 'with succeeding hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	ln -s "success.sample" "$PREMERGE" &&
-	>actual_hooks &&
 	echo "$PREMERGE" >expected_hooks &&
 	git checkout side &&
 	git merge -m "merge master" master &&
@@ -116,7 +114,6 @@ test_expect_success '--no-verify with succeeding hook (merge)' '
 test_expect_success 'with failing hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
-	>actual_hooks &&
 	echo "$PRECOMMIT" >expected_hooks &&
 	echo "another" >>file &&
 	git add file &&
@@ -136,7 +133,6 @@ test_expect_success '--no-verify with failing hook' '
 test_expect_success 'with failing hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	ln -s "fail.sample" "$PREMERGE" &&
-	>actual_hooks &&
 	echo "$PREMERGE" >expected_hooks &&
 	git checkout side &&
 	test_must_fail git merge -m "merge master" master &&
-- 
2.23.0.rc0.30.g51cf315870

