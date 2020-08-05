Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983F9C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743CD20842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3IMRZPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHEBVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgHEBVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:21:04 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD03C061756
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:21:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j37so6469217pgi.16
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n4nIRHuMkjqaAXrUTuDya0OQZtOswcfUy1h/GasPJvE=;
        b=p3IMRZPkyTkwmQ9TrVx+rG5k3QiEpbg78b1d7diKVJqr5WWwd1M3WKNFhve5w7U8MN
         BO5se129/0oiyirziJWoks0MkZAKRO6qmVLdIc6WljCrZZOND9jLprfvmizqDxtcnazu
         8Z7AiqhdhC41AiXZ9H1af4utX807SYS7+PBI4XVjkGOaEXk8rlTNW9w0n5T7qkBeCkfd
         I3m3Z18J23oLlWf9cCjkv8LfHj0yZpGMj+YS17Cc3RVpZVQoyYwQF1QaAF0lDKPGeoTM
         ECPJgmpC4kT99tEZlCm9yct6P1DpQmZuPGwQu991HhzvZqaj8/0rMQVZg/hdtZ8KLtH0
         ajhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n4nIRHuMkjqaAXrUTuDya0OQZtOswcfUy1h/GasPJvE=;
        b=GHXzPsE4/wPe4eLXeC+zc0lYRWuq4HwkaOa/uQVzryuzI1qkQvwDHnTHIDxz++8DH1
         sif128jpkayb6MwSSB/+uY/hPJy0CCWvTA84kMTb5tjPRKkLjLPcDeLVWPGkXM+7P2+/
         /oHP3zWCmIgpGIZwlCzYWkt/NpXSsiZYNLuGWYCnoPS1pfqh00ZWMmA3DVND3KBQORPK
         wxTOd5M1/ljTXpKBroBwEdZJXz+7mQmDOhj9dyewq0FTy1BCYR3ce6lUQg+xtB3/T+me
         /aoSN7oU4D2adTRqccF+77XEpvt+Gg1s1oCVWn9eNfDOVdm/6rbY18TFcDr6r0iX/nrb
         1IIQ==
X-Gm-Message-State: AOAM533gyVc31Hxy5Be3GP28evDXkv4Qc/laT90watYKX/blkRjpEkQ3
        DhVxCa4WDCRk2MWSVqrRCVuypVZup5KLTnIGML0RSRZ/ymkwkliftNVeLqmQkKKEdVBGH36zuBO
        YH9/Goh6W6cziXac9c8onk/I3eln5aE+eCrwjT3GtuRCUda7d2AByIuQDl/W5ybGrku49ysLdUz
        gq
X-Google-Smtp-Source: ABdhPJxsXQS12egxDRbTlMzKeFC76yl3SxHxA4kOxjqMqGeSiZTINEvM3E/CPq05qu9/MSyuPd90ceZOYltQFEAt+UlA
X-Received: by 2002:a63:b18:: with SMTP id 24mr996160pgl.406.1596590464200;
 Tue, 04 Aug 2020 18:21:04 -0700 (PDT)
Date:   Tue,  4 Aug 2020 18:20:48 -0700
In-Reply-To: <cover.1596590295.git.jonathantanmy@google.com>
Message-Id: <c4cb657ae0452397f97c2b01dbc2e6c9b0cc5ee7.1596590295.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1596590295.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH 5/7] fetch: submodule config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c    | 10 ++++++++--
 submodule-config.c |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a5498646bf..29db219c68 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1786,12 +1786,18 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		free(anon);
 	}
 
-	fetch_config_from_gitmodules(&submodule_fetch_jobs_config,
-				     &recurse_submodules);
 	git_config(git_fetch_config, NULL);
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
+	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
+		int *sfjc = submodule_fetch_jobs_config == -1
+			    ? &submodule_fetch_jobs_config : NULL;
+		int *rs = recurse_submodules == RECURSE_SUBMODULES_DEFAULT
+			  ? &recurse_submodules : NULL;
+
+		fetch_config_from_gitmodules(sfjc, rs);
+	}
 
 	if (deepen_relative) {
 		if (deepen_relative < 0)
diff --git a/submodule-config.c b/submodule-config.c
index e175dfbc38..8d65273ed2 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -776,10 +776,11 @@ struct fetch_config {
 static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
 {
 	struct fetch_config *config = cb;
-	if (!strcmp(var, "submodule.fetchjobs")) {
+	if (!strcmp(var, "submodule.fetchjobs") && config->max_children) {
 		*(config->max_children) = parse_submodule_fetchjobs(var, value);
 		return 0;
-	} else if (!strcmp(var, "fetch.recursesubmodules")) {
+	} else if (!strcmp(var, "fetch.recursesubmodules") &&
+		   config->recurse_submodules) {
 		*(config->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
 		return 0;
 	}
-- 
2.28.0.163.g6104cc2f0b6-goog

