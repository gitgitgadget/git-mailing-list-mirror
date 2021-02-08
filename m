Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70165C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6C664E8F
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbhBHTb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbhBHT3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:29:46 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811BDC0617AA
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:29:16 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 18so8209426pfz.3
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poqkHYKETcQo3c8/ggBmkuKdOiHi4TFlTegDySG33fA=;
        b=qyYa/B8OMwgpi073/rJ4jxSy/aRRUFV7HX6bdarom+6iFUj2MyTOJ1uL7paCUlVyWq
         r+EydoxBdSplSPgsqtQVN2ZXKvh44H5Y2ylPlvfxPy6YXIgEHEumXwnVOj5D8RuQEDoe
         57XpLkPLbt9pM1+w03nmfR3Jmqq0QwFvN5ToQXBfh/l5pFYbOh/pQzx0do3b5HticvKl
         TqPfJGBDvZ3+S3WYGWqmuKRWCVCYqKfh3KNbg2cKs8CDH1t8IM34+LAhqNuvOltcW9cH
         0aNlfncdWm0uU3lH3vxrkqYJahP4nZMVINAKSwX7ptKEsFQrKctm4aIeaehnHe7bvSAY
         tUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poqkHYKETcQo3c8/ggBmkuKdOiHi4TFlTegDySG33fA=;
        b=UZhIiuw8fazKMK1OOEIQt7jx2Dbm/I+WfwcexP2J7zUm9Yf9DVxhmNSXHH4xPDegTQ
         2VdI0zvcs4sKco2UB9OJ0nH98GAyLjm6Tj9z771bkW06sPsTxwY9o4TGR5LsdgaI9nW9
         lCSdTEnlTE4KPBVVl+EPf3O0l1s54cR6814jklhTVty4TT9DkX75hfsTVnxd59qrCG2T
         5EEpw3ND2VScj2p0mSiPPLUi6dey7E7UtkNSFPq9shNzYppl6GrbW1nHXZimgqf9ncMp
         QaSbej3F3RFnCiET8jdPYjwf8yOg/ozwuSlMJrI9rNoFP5xWNDjG5xqozIzWTrrsvmLF
         D2ww==
X-Gm-Message-State: AOAM533QM0UebW/aTleeZSdmQuQIa1NN+mGfBbuewKXiFnvQxTTnsUJe
        E6ikdnjS7KlLplisbz75+RNTa+3qIW8maw==
X-Google-Smtp-Source: ABdhPJxTvrOQw/On5SAYX52+WsopOpkF6qPUHl6oYZA0ElMxljUF79ZtAsOYtbW8c9BMqiuA1Q/rAQ==
X-Received: by 2002:aa7:8485:0:b029:1dd:bf6a:a9ec with SMTP id u5-20020aa784850000b02901ddbf6aa9ecmr5640717pfn.47.1612812555911;
        Mon, 08 Feb 2021 11:29:15 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:29:15 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 10/11] t/t3437: fixup the test 'multiple fixup -c opens editor once'
Date:   Tue,  9 Feb 2021 00:55:30 +0530
Message-Id: <20210208192528.21399-11-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the test, FAKE_COMMIT_MESSAGE replaces the commit message each
time it is invoked so there will be only one instance of "Modified-A3"
no matter how many times we invoke the editor. Let's fix this and use
FAKE_COMMIT_AMEND instead so that it adds "Modified-A3" once for each
time the editor is invoked.

This patch also removes the check for counting the number of
"Modified-A3" lines and instead compares the whole message to check
that the commenting code works correctly for 'fixup -c' as well as
'fixup -C'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index d651fb8901..6899d25393 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -197,14 +197,16 @@ test_expect_success 'first fixup -C commented out in sequence fixup fixup -C fix
 test_expect_success 'multiple fixup -c opens editor once' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A3 &&
-	FAKE_COMMIT_MESSAGE="Modified-A3" \
+	git log -1 --pretty=format:%B >expected-message &&
+	test_write_lines "" "Modified-A3" >>expected-message &&
+	FAKE_COMMIT_AMEND="Modified-A3" \
 		FAKE_LINES="1 fixup-C 2 fixup-c 3 fixup-c 4" \
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
 	get_author HEAD >actual-author &&
 	test_cmp expected-author actual-author &&
-	test 1 = $(git show | grep Modified-A3 | wc -l)
+	test_commit_message HEAD expected-message
 '
 
 test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
-- 
2.29.0.rc1

