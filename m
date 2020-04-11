Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D19C2BB1D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D80E2082D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUPGtamK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgDKBDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:03:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37423 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgDKBDF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 21:03:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so4431625wml.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 18:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n9H+QB8KuHnRsLIRt9BMEAx4Qb1lorUYoAIXmhyVuFI=;
        b=GUPGtamKV+qwaPzBNthVgxditRpCa0Vd3jn7nyy9/2whQGBERSImMuDMzpvDHn4V2t
         GWpCWLS8LbAx41aTGKrE7a+AL75yWtOBH3/zFgkACjTKbqtsuW7vWMY8zxmqx++N3JTm
         R118Ny7UBqPy1VTzHv2e/CoqDAlaK+cK4CXKE+pwNiPcaIIDO0/4MXLk1Ro2z/2Yu5uf
         hlv7BST667GsRojGBrzDLN+A1dml55SLPm9v4+aeLKRsFpxxfZAglGDLPgd7tXy++zGx
         D9F02TGmSVXOG4bG5DGByR/WqbMO06cVUYglkiJwLG8LFKvqaSHkZm/ym+H8Uexz30IE
         rt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n9H+QB8KuHnRsLIRt9BMEAx4Qb1lorUYoAIXmhyVuFI=;
        b=f3mSl45pm5/nZC6+Kg5t7DPKNpyvzDc5iQDkrkKXkbIkZ+++RZ1NnWPLu/wiFZ8Y6Q
         X8NjY4WGSljuvBSuxOjjjdfMQAB+9trJlKsSULtVgHSfQhda3e2E7KFKRPIJa/5yOB6I
         Pa+QAREO9MhoMVHvXUhfNdTryGMd/J8Btdhb40E3fswmZLJdf1QL/eKep+a4Iz5Fxxm8
         DPsJro5syi3V4ubD+jBWeygjkXfUUPsIHQQ6Orue25AbPjafClOCBIzt8nZUy8WhyA28
         eJzu3blAucuwV/japShdHGj3Z1tnPp/bDHytyHULd1pnSOevV3fTIZFpuMUNg6HSHJRx
         Rw4A==
X-Gm-Message-State: AGi0PuZvLQKCiX5L6aFRx4GMox+DSuh3mNeCwfHbu+SWhmdQTEHp4MDV
        U3j1qrwOO2Otl4oQCq71v14QP0vv
X-Google-Smtp-Source: APiQypJjkEHO/VCncBrmcD0fQ9adjOaWRxvZChYf4fYBWtVJN3Xl2lGVQ9a5K+acvx9ZInXhisMpyQ==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr7640112wmr.16.1586566984206;
        Fri, 10 Apr 2020 18:03:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm5407883wru.15.2020.04.10.18.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:03:02 -0700 (PDT)
Message-Id: <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.git.1586566981.gitgitgadget@gmail.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 01:02:59 +0000
Subject: [PATCH 1/3] revision: complicated pathspecs disable filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The changed-path Bloom filters work only when we can compute an
explicit Bloom filter key in advance. When a pathspec is given
that allows case-insensitive checks or wildcard matching, we
must disable the Bloom filter performance checks.

By checking the pathspec in prepare_to_use_bloom_filters(), we
avoid setting up the Bloom filter data and thus revert to the
usual logic.

Before this change, the following tests would fail*:

	t6004-rev-list-path-optim.sh (Tests 6-7)
	t6130-pathspec-noglob.sh (Tests 3-6)
	t6131-pathspec-icase.sh (Tests 3-5)

*These tests would fail when using GIT_TEST_COMMIT_GRAPH and
GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS except that the latter
environment variable was not set up correctly to write the changed-
path Bloom filters in the test suite. That will be fixed in the
next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/revision.c b/revision.c
index 2b06ee739c8..e37b5b06108 100644
--- a/revision.c
+++ b/revision.c
@@ -661,6 +661,15 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->commits)
 	    return;
 
+	if (revs->prune_data.has_wildcard)
+		return;
+	if (revs->prune_data.nr > 1)
+		return;
+	if (revs->prune_data.magic ||
+	    (revs->prune_data.nr &&
+	     revs->prune_data.items[0].magic))
+		return;
+
 	repo_parse_commit(revs->repo, revs->commits->item);
 
 	if (!revs->repo->objects->commit_graph)
-- 
gitgitgadget

