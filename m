Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C70EC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D774206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdwPXwCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390828AbgEMUBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733135AbgEMUA7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:00:59 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1249EC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:00:58 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z5so854449qtz.16
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xhsB0228uItu25Nwvfd5rZqyLi2pb4NT6RIzLYL1nP4=;
        b=IdwPXwCmWHHzciNJ6aw5x7mHN02HAzJtSUFzAECGZSubRvNcnB/PuVIeM3pxJiKY8B
         5DtuFB465ZaQ/4xPqj6Yd7QKq/1BoPvWpYNU8E8h7+JqADBHffUwswpWQ8mwVA2owrww
         HnqFaaVSDTqJGgEUS7yhxCveve+W+kf8FkhSJD5v1Kwbb3EyMbqL5149zylZL1j9f76J
         aDbniobmfLDvc1G4pWzULexg6SkY0gNPw5ccl9tEvnfPbV8VDpqahfEc/lMTtKHBXD2U
         XdKfPJ95c4ydu8aYXDkaXL4iGsai8EIkiogl3diYZ3oDsqWdhw1GJG3cDmUom9/IlIuz
         558A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xhsB0228uItu25Nwvfd5rZqyLi2pb4NT6RIzLYL1nP4=;
        b=mkxVm57sDQnNbtyMGKp7u71Bt9tVq+WEd+XZLpy9IvS+W9EFO3ZdhEeLcOoxG/0p10
         2eXoFNd3YrpznQLbbFwdor9y2Dr2UChCYjHi+F/R2ashHSPySmMabT0uByJix7ktfokm
         LeNpgHyfvXXUXT9+J17FRgZgxWfERJYNWDGUkANNNeAp0sE0uwsVTQTqaSrV2vzP/lfJ
         +pEnVMsNxx0ZZLKR3ltiDBTmh79EdUWFZnG90y8fjZqVhZsur3juheo2EEuhkWNioHGQ
         fQOdeSskxb3a1mQ1gWlYcWamzLBjkyqhLHZq84SU0qMsFU2xV3NpMcrTJffLrHmW/sJm
         gZcw==
X-Gm-Message-State: AOAM532kuPPQRp05/eauVJBHaAQJHJAIbEKJl4LvQrD97mgaiSbDSMcl
        WLdEokQI55DhGeDUeFBQFr/6QxgW1/6/hWWP/1tKZZd0kOENW9/3kemOyxRgtRBs2liTX9raLW6
        URcclKjVgTv6fNEKZDdAtSUbcIgiIHaPkKg+XCba6LYKyr9rAoF7xYcHqYupa
X-Google-Smtp-Source: ABdhPJw2ve/qCtBFlW9OnU1w6+vHPOZX35oPvK8Fld9Ck8Yxo5FiXkIQmzScJ2Quoygw0msDPkoLbOFGO/0S
X-Received: by 2002:a25:8808:: with SMTP id c8mr1226389ybl.159.1589400057099;
 Wed, 13 May 2020 13:00:57 -0700 (PDT)
Date:   Wed, 13 May 2020 13:00:40 -0700
Message-Id: <20200513200040.68968-1-delphij@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] fetch: allow adding a filter after initial clone.
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Xin Li <delphij@google.com>
---
 builtin/fetch.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3ae52c015d..e5faa17ecd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1790,8 +1790,16 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (filter_options.choice && !has_promisor_remote())
-		die("--filter can only be used when extensions.partialClone is set");
+	if (filter_options.choice && !has_promisor_remote()) {
+		char repo_version_string[10];
+
+		xsnprintf(repo_version_string, sizeof(repo_version_string),
+			  "%d", (int)GIT_REPO_VERSION);
+		git_config_set("core.repositoryformatversion",
+			repo_version_string);
+		git_config_set("extensions.partialclone", "origin");
+		promisor_remote_reinit();
+	}
 
 	if (all) {
 		if (argc == 1)
-- 
2.26.2.645.ge9eca65c58-goog

