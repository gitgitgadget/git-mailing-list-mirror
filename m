Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A7FC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 01:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C6920767
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 01:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S29MirXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCSB6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:58:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53306 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSB6j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 21:58:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id 25so322521wmk.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 18:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cbgsqqljpK2Wc136cd4jqB2iQLNfDjdENjl0d7Z66GY=;
        b=S29MirXqbNlYLYlprKsSUb9JbRgFFsoxWUJEmk2Z0e5CD0aiCY9XFOmw5PXVcun75V
         nUPSB4EF+jwmBJEuKWoMJakOvkcNBuKHNyt5guB6/Ae3hUw4PnrhubW4j0U3ScPp5eh3
         dy9N9rCwE1OH52tsQ43AXOonGpZ9XQcuwZilDM78XvFyPjbgjmuprEXs5+s9onEVM0LT
         9zQRE3Z9KBvsiPRD6TWTu37bFXQOA/XW2lhtvrNqgifiKbk1o6tea4IB3TX6fEIxNLJI
         Jd4D8/3CETm5Po2ba+UPLPqX4eeCHuJGEr0LYqoridfsBwUdNFVesWfcOCpFm10OGnZA
         37hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cbgsqqljpK2Wc136cd4jqB2iQLNfDjdENjl0d7Z66GY=;
        b=lGfGIZDjx8otFZIC6+x6aTb6MUzl6xbvkc/jYzgJNSV6RTqjvVin0kL94UqhBSO5PM
         JmEh9du2KoBiE73i7yCk1na5ZqusdBhBxjD1Fr6ChD8WW1NYEkwuj9/J7ImGtFWdyFUH
         avB9RRk/SCJCkpPjGdpruw9CXxsUQ1GRXHNYoHmshJwNhsfULhuHM0TLEjQMvXljPJIV
         B2T1BkhSAqlgIhI9+tWYfQn68gnSMKBV/UXFpbzD5ngvuTbVqUgX7i7OQb4UdT4CEDDW
         KQBIrleezOnqTCnbo+W1PA3gqSmjzy+X6F0ijeUMlGcQdvx9TaoqHmebeJH5oIE4qsKI
         S7yg==
X-Gm-Message-State: ANhLgQ3UrZarAzhXbkCDGnB0QypKatj2azdtY9tRnam080htTCIs+jkr
        ZUv0mY/QoKHyptVlKnPUogcBK3OI
X-Google-Smtp-Source: ADFU+vuxuhYAMLiPwH6s/FvJvSRzjE6zs0cxyjxHwtghkD16GMyE/yDwOVHc6HrKFLlC2XxE6+gXHw==
X-Received: by 2002:a1c:208a:: with SMTP id g132mr695723wmg.44.1584583112190;
        Wed, 18 Mar 2020 18:58:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y200sm964191wmc.20.2020.03.18.18.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 18:58:31 -0700 (PDT)
Message-Id: <pull.585.git.1584583110914.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Mar 2020 01:58:30 +0000
Subject: [PATCH] config: set pack.useSparse=true by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The pack.useSparse config option was introduced by 3d036eb0
(pack-objects: create pack.useSparse setting, 2019-01-19) and was
first available in v2.21.0. When enabled, the pack-objects process
during 'git push' will use a sparse tree walk when deciding which
trees and blobs to send to the remote. The algorithm was introduced
by d5d2e93 (revision: implement sparse algorithm, 2019-01-16) and
has been in production use by VFS for Git since around that time.
The features.experimental config option also enabled pack.useSparse,
so hopefully that has also increased exposure.

It is worth noting that pack.useSparse has a possibility of
sending more objects across a push, but requires a special
arrangement of exact _copies_ across directories. There is a test
in t5322-pack-objects-sparse.sh that demonstrates this possibility.

Since the downside is unlikely but the upside is significant, set
the default value of pack.useSparse to true. Remove it from the
set of options implied by features.experimental.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    config: set pack.useSparse=true by default
    
    Here is a small patch to convert pack.useSparse to true by default. It's
    been released for over a year, so the feature is quite stable. I'm
    submitting this now to allow it to cook for a while during the next
    release cycle.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-585%2Fderrickstolee%2Fpack-use-sparse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-585/derrickstolee/pack-use-sparse-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/585

 Documentation/config/feature.txt | 3 ---
 Documentation/config/pack.txt    | 4 ++--
 repo-settings.c                  | 3 ++-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 875f8c8a66f..4e3a5c0cebc 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -12,9 +12,6 @@ feature.experimental::
 	setting if you are interested in providing feedback on experimental
 	features. The new default values are:
 +
-* `pack.useSparse=true` uses a new algorithm when constructing a pack-file
-which can improve `git push` performance in repos with many files.
-+
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
 +
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 0dac5805816..837f1b16792 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -119,8 +119,8 @@ pack.useSparse::
 	objects. This can have significant performance benefits when
 	computing a pack to send a small change. However, it is possible
 	that extra objects are added to the pack-file if the included
-	commits contain certain types of direct renames. Default is `false`
-	unless `feature.experimental` is enabled.
+	commits contain certain types of direct renames. Default is
+	`true`.
 
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
diff --git a/repo-settings.c b/repo-settings.c
index a703e407a3f..dc6817daa95 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -45,6 +45,8 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
 		r->settings.pack_use_sparse = value;
+	UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
+
 	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
@@ -52,7 +54,6 @@ void prepare_repo_settings(struct repository *r)
 	if (!repo_config_get_bool(r, "fetch.writecommitgraph", &value))
 		r->settings.fetch_write_commit_graph = value;
 	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
-		UPDATE_DEFAULT_BOOL(r->settings.pack_use_sparse, 1);
 		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
 		UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);
 	}

base-commit: 6c85aac65fb455af85745130ce35ddae4678db84
-- 
gitgitgadget
