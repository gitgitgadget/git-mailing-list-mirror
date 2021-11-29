Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C0FC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 15:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbhK2Po0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 10:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348034AbhK2PmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 10:42:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBD2C061379
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 05:47:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so36946490wrr.8
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FDwMLmFMT85aajD5fwHHbuhbdQ/BdAJ2YlYsk4jlxQk=;
        b=StGeCvKo4pCeTAf9VShG9EUSfTUizB/JaU43PwPq/iJxKh5up/0bCJsA0t0GQT4Ppd
         4zkb1cjH1J/bhlPTmIeYd5VV3QW7DpOZonzmUJTUCLhephzw/lgk6Suex69vvXaqfSCd
         M0rMOQClyJTaAteHEFNZCv7M0TYGCQEofu/C4tD+5USe9nJPrv+RdH1kqSFA+elVBwLZ
         yatdhx3rF26TUacuSNlFhHTP7eMM7SUQ09IrAe+vTzpQOLRg0XfeJ+1WGyYmDzOAV0WE
         +cCDZE7ES3VRvEifcbEMPYBVvH2eH2jpUVHtSVDXV67kJwgH1wH8REg8oSNYfKCmiZsL
         6SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FDwMLmFMT85aajD5fwHHbuhbdQ/BdAJ2YlYsk4jlxQk=;
        b=cpA7pVJEwhxdUp8lvye4YtzRmN6hQe+RcQCy699FcTO1lgPdHELc6k/Kh1vq+G/RCe
         ajRjZl6DwqP9b19v/J/lL2oCIikMeD+B/A7U0VEKPd9wVh+YYQBWD/FGYooz3Ef+UwnH
         vTcJfMIgkwgmfiOQA7Aay6rvq31wLm1jrjHnzHfRuwSH4VXaoMRE9fq858uPXgIdFbOH
         yvXpNJhiuU6CnajTZvv9dl4O9ybPibdZH2M9Avlc70+t6vCNyHnzVbEmmVxU510w/sc9
         /4XCt4N1zzu3vseg0Lor5ktarq/nspkP2xRrt/KkpeCnN7Xup7WAQqMNFwzhdPXyxyel
         3dzQ==
X-Gm-Message-State: AOAM5323yYas4FDoYNcf67+lBzWXI/SxSSgalOIqRHXW7ARSU+rmJWd9
        FrklpXFr1aAIh+cdSDqUgZbseAviQzc=
X-Google-Smtp-Source: ABdhPJyxHZD+h3ar2FXPHqAiM2OYcnrAySoNOEog8ZrHa+GorhckNVwd8kUEsORbbJvlGSD3x9C+zw==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr35089745wrn.247.1638193669049;
        Mon, 29 Nov 2021 05:47:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm14924378wme.39.2021.11.29.05.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:47:48 -0800 (PST)
Message-Id: <3d1bbc91aa3a465ecec2de130456b9ccc08f3032.1638193666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 13:47:45 +0000
Subject: [PATCH 1/2] test-lib.sh: set GIT_TRACE2_EVENT_NESTING
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com,
        me@ttaylorr.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The GIT_TRACE2_EVENT feed has a limited nesting depth to avoid
overloading the feed when recursing into deep paths while adding more
nested regions.

Some tests use the GIT_TRACE2_EVENT feed to look for internal events,
ensuring that intended behavior is happening.

One such example is in t4216-log-bloom.sh which looks for a statistic
given as a trace2_data_intmax() call. This test started failing under
'-x' with 2ca245f8be5 (csum-file.h: increase hashfile buffer size,
2021-05-18) because the change in stderr triggered the progress API to
create an extra trace2 region, ejecting the statistic.

This change increases the value of GIT_TRACE2_EVENT_NESTING across the
entire test suite to avoid errors like this. Future changes will remove
custom assignments of GIT_TRACE2_EVENT_NESTING from some test scripts
that were aware of this limitation.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/test-lib.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2679a7596a6..2e815c41c8f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -476,6 +476,13 @@ export GIT_TEST_MERGE_ALGORITHM
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE
 
+# Some tests scan the GIT_TRACE2_EVENT feed for events, but the
+# default depth is 2, which frequently causes issues when the
+# events are wrapped in new regions. Set it to a sufficiently
+# large depth to avoid custom changes in the test suite.
+GIT_TRACE2_EVENT_NESTING=100
+export GIT_TRACE2_EVENT_NESTING
+
 # Use specific version of the index file format
 if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
 then
-- 
gitgitgadget

