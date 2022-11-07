Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83855C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiKGShx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiKGShG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:06 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E380B28E10
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso8774382wmb.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhqGG6rTY4nfyJbezE3fGZeGPuo2cVOoiqKaawOGS4k=;
        b=T8shosNnH3/2A8/8JPZrGeqLyR9JB4fjOtk3KainKdWoVHIb1u8Z7da5U5OFkW3CQS
         IZFO0pCf3euktiMXTVFt/qgNVn4kgHclB9tZFKz4maF1nvGh6IeWbj0vicKp1oH7SCh8
         NwAPVhbhGZz9b9pP8cbsEPdTUokAzqSywl+vVh5vzRlZb1hssAa58iF/TRdGInYOpQWx
         S5+p/jrnysnJag6EaH/iuHnb9ppPs30h/o1LhxjghvdXjicJotwZQL4ZkvBs6tgqOmRY
         dTIKOJgPglN1vR/13KH5p80M2isDRUPMx5XAShu6P3UGLy9/OjCHdslL0VW1IvK7Sbhl
         xhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhqGG6rTY4nfyJbezE3fGZeGPuo2cVOoiqKaawOGS4k=;
        b=Edg04jl1wFGSH1kaWhx4iWCeoGM0eBsIHkkXkrtBZsaM8x6sbVH6n4kaGGhed6IRuW
         HmLpSEry+VebG+4HmWDmQ/IBcSkwfu6RRQ3UqSaCeVyK64elAtI156MOoQsxuxS8ag5o
         eTrjJAWs1gKvp8mY8alLAJ34F+0SHx8AHcoglqQbbeIPQzf+LUx3v8SC/W8oAb8HObXK
         zUw1OETbppm/kVafZZWsGR4JIhUivVDr/BzWzVmcBUopSjLPi7ca6YK45vLkHX44TbcU
         x0dxlW66nvhen029xJEk1HPkTBvp7oqlolgTwjVqnacA+OMeUxsC7OjSVbGNVctpEcWt
         XqKg==
X-Gm-Message-State: ACrzQf0vfRYMF0ljgo32IoEQYoD4SB9K5L6U3rDIa50hg+uoHoDOZzDx
        6QXE9ADopKpijaEf6oLEvwYW6Arxapo=
X-Google-Smtp-Source: AMsMyM4ZZ2lAkjrcGeza2O1EjFiTjxmTE9udUZJBZ1KxoCO71e4HSdr8b3J0nyLUl3CKp+hk3zEBTw==
X-Received: by 2002:a1c:730e:0:b0:3b4:b0c0:d616 with SMTP id d14-20020a1c730e000000b003b4b0c0d616mr34473794wmb.72.1667846191317;
        Mon, 07 Nov 2022 10:36:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b00236545edc91sm7856335wrf.76.2022.11.07.10.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:30 -0800 (PST)
Message-Id: <f8b9f355f0fd11857928de90e79eb8fc284fb009.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:59 +0000
Subject: [PATCH 25/30] t5502: add PACKED_REFS_V1 prerequisite
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The last test in t5502-quickfetch.sh exploits the packed-refs v1 file
format by appending 1000 lines to the packed-refs file. If the
packed-refs file is in the v2 format, this corrupts the file as
unreadable.

Instead of making the test slower, let's ignore it when
GIT_TEST_PACKED_REFS_VERSION=2. The test is really about 'git fetch',
not the packed-refs format. Create a prerequisite in case we want to use
this technique again in the future.

An alternative would be to write those 1000 refs using a different
mechanism, but let's opt for the simpler case for now.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5502-quickfetch.sh | 2 +-
 t/test-lib.sh         | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index b160f8b7fb7..0c4aadebae6 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -122,7 +122,7 @@ test_expect_success 'quickfetch should not copy from alternate' '
 
 '
 
-test_expect_success 'quickfetch should handle ~1000 refs (on Windows)' '
+test_expect_success PACKED_REFS_V1 'quickfetch should handle ~1000 refs (on Windows)' '
 
 	git gc &&
 	head=$(git rev-parse HEAD) &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6db377f68b8..a244cd75c06 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1954,3 +1954,7 @@ test_lazy_prereq FSMONITOR_DAEMON '
 	git version --build-options >output &&
 	grep "feature: fsmonitor--daemon" output
 '
+
+test_lazy_prereq PACKED_REFS_V1 '
+	test "$GIT_TEST_PACKED_REFS_VERSION" -ne "2"
+'
\ No newline at end of file
-- 
gitgitgadget

