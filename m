Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3F420188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbdENEB3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:29 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35942 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdENEB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:28 -0400
Received: by mail-pf0-f175.google.com with SMTP id m17so47210689pfg.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wAfyc7snBiPMWPhziMsD4gHuy5Lr1OuJtLyGdxb1yaE=;
        b=Aa3JixJ/IJfYCXn6tj7GIRniT4k7ZT02BzoKT04f8VQHyx3FKhYBTPVjwDqggByC8+
         iJdl/CM0A2UecXi6szlGjvXpbiorgT3NoWK7WuYtpRQVEZlehWsnN8Uf1r0KfIQWSvwQ
         RFGdAI+9La6/aEaNwKp9cmtiSWDjXrseDm3HuhzTqdnGzkQU4e5ijEEThUcUwVZyTiee
         G9OorAhLfdppT5hvIO2bHwMedBaGin8ClxBmtzj8IwdmDy9acp8v1QsltYTo0l2+qHu3
         URrGOnh0zoAdxXn1Nai7Q8FJ6DA9M3F4lenwwwFVEu/NRXdC8/omC6lrIlEYU3t33v4k
         90vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wAfyc7snBiPMWPhziMsD4gHuy5Lr1OuJtLyGdxb1yaE=;
        b=ikJ7t+diStbROsHQzFRJX/K6yVwhBW1s5mlJISpBSS7BN5p3RobK0+jtPbbjLSAve0
         X0UBP8vnulazlP0SfNtcifTnSwG+y6IuLQPyuRj64bgal46D8ZdTlh76IyhTU7vfj7C5
         Q/RNC5IO44QaSjlwA3JhD5GU4BS2Ozk1s5sMdMqwrr7FlUIMgR4v+A3kbDPIF13yplud
         vcjjUlizluO8UCO0a80Y9Uu7tpaioA9X1AywkpVAAo9VnnlXNQnbAoVVF5yMHgWLjza1
         GTzwFULRBrrwWAp3/pV24WXMj9P4noOZHFUmV3tBBkgt2wHPCTYjKKFidk5CL0Feo/fz
         1yyQ==
X-Gm-Message-State: AODbwcBXbD0bK1LVNb2IqqKpv5zVvRrC+HDxUnZOcxiwDJN0QsWK0Fr2
        8jBvlK98j9W8ChFY
X-Received: by 10.99.189.2 with SMTP id a2mr12183123pgf.85.1494734487339;
        Sat, 13 May 2017 21:01:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id 134sm11362144pgh.43.2017.05.13.21.01.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/19] diff: readability fix
Date:   Sat, 13 May 2017 21:00:59 -0700
Message-Id: <20170514040117.25865-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have dereferenced 'p->two' into a local variable 'two'. Use
that.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 74283d9001..3f5bf8b5a4 100644
--- a/diff.c
+++ b/diff.c
@@ -3283,8 +3283,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	const char *other;
 	const char *attr_path;
 
-	name  = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	name  = one->path;
+	other = (strcmp(name, two->path) ? two->path : NULL);
 	attr_path = name;
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
-- 
2.13.0.18.g183880de0a

