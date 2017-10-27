Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2083620560
	for <e@80x24.org>; Fri, 27 Oct 2017 22:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbdJ0W3D (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 18:29:03 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:53826 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbdJ0W27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 18:28:59 -0400
Received: by mail-pg0-f67.google.com with SMTP id s2so6267002pge.10
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z4nNurhPwUrG+M9V80mphR6se1XPrwjz0nt/S0+qjIU=;
        b=eLkI1pWwMhgb+n0fFhGiJ64APcw/6BBWferpepCVNlEe1m5UjIQCN/eXtlFxljq0wG
         MHkhLOZ3UujoiZqlnME4yt4UHiPQRAZWbhchYF/KZeCGulEN6BO1hLykfAM7qXq6i/Pi
         Msww9cHoZATaqQFnM301vC6DBwaEFnlaM7pcLICMrQP5UOlhMHGFwjy2Q4MNJSh04gTS
         Pc4kyRX5zS0WUhzpQDRFGl4oyhw6anqYsWK5E3DFayt2F865nXts8bYQN4rm04ftUma1
         3Nkem07CqP8VB9SRDe8vQDPi1nXX6e8sAdnzWJUvTHfKa0j+Sp3Hyvlq5ZDKvZtLcoza
         b5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z4nNurhPwUrG+M9V80mphR6se1XPrwjz0nt/S0+qjIU=;
        b=l8EjXSNjDJcX+ByAk8p+EmmmVFKVFrZEdp4/fGUBvTOPbvlUtYcQnJJcfp0weMdpjg
         KxA9RxKi+337ccfpCy8np+cpu8o9rdm8vW08uXVkmBIXH58YEUdcL46DkIPlkFLKflgo
         B6FBrW1ZoOfZwEMONHUgDCiAIrq/gyKr4UIw6OuvGnXIx3f9aiuPpAjN0UJNVj0sefTB
         /vHV+pCsCqaioZ2xV4YvywlUidlqbskSMNgQIyDh66VGwvlKKTA3M8/eM9guqQlsQhoz
         a3VDIV9MNDGdjyUvANKGrkTPsQacJjTx70jmF6rYHCWxz8mXbXYowxMp1MM2CdeOjXcR
         DiqQ==
X-Gm-Message-State: AMCzsaX+D/DfTv2owfkVVCk0JuTof1q3nV+Yk/Sa8rqFadspXUjobB1V
        uz5ZvWRRDFgljOhmoHEm/GeV0KM7azg=
X-Google-Smtp-Source: ABhQp+TuThbrrgftKKPWyTHa1Vf6Y/jiyJQ3JijZCZDTySsl8PSsLImaiM4tLwvEMaxsj0A/a4Sr8w==
X-Received: by 10.84.241.15 with SMTP id a15mr1429142pll.199.1509143338552;
        Fri, 27 Oct 2017 15:28:58 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id c127sm16486842pga.34.2017.10.27.15.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 15:28:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/3] add: use DIFF_OPT_SET macro to set a diff flag
Date:   Fri, 27 Oct 2017 15:28:51 -0700
Message-Id: <20171027222853.180981-2-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc2.357.g7e34df9404-goog
In-Reply-To: <20171027222853.180981-1-bmwill@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of explicitly setting the 'DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG'
flag, use the 'DIFF_OPT_SET' macro.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index a648cf4c5..b70e8a779 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -116,7 +116,7 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
-	rev.diffopt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
-- 
2.15.0.rc2.357.g7e34df9404-goog

