Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76204C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbiBWScf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE52CE0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so1653965wmb.1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uIdsWVdx8T+F33SXZg5tzNTHSBrgc/ivVi2E8wz2vjM=;
        b=V3dJJpC42CWp6zP7c6YulT3EqdZ6WAS7KXk4Hbv//yeMuyFmPF6Fhg499kYvUrz6+Y
         XWDQ+76Xb3aJ2YJTrlO8YR+J0tkfm8BjnZ3Es9Gnoj7dRL+1naSVnN/hnSZb0g4Qnlk2
         hElOJR1VCSB/R73O6lPK8GtimoBfhY0kW2LElAoWWMW6v+DrAnsuurYnvj1v5at6S77k
         /x9WKeBfzoQEYPZI5f+rB20FPOab5lmJbECLn6f0QY+suLoaHJDK62/qkroKIHYr/ROw
         TngDx6zmD8/Knh7FanduQy7YhuYfw63TVDUsjgreFzIXGOq9EsKnixEoJZZl9vLk8A+r
         ABqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uIdsWVdx8T+F33SXZg5tzNTHSBrgc/ivVi2E8wz2vjM=;
        b=4KWWyrwoWc8b/jcOT2k9SajWgPrICUIWvuE4cnIcEQbZJBKOku+GCLyFkwuqcSuiGm
         BX3FzjC1cKNMbh+MDfXQzLWLDo7lBnKd/74ttA7bHauxxuIvuEfXUbEvOx5K4eWch9z1
         EFFoRYbuj7eu2uGDbueQYM1dgNg3WmIRt5Mru3vBKEsXzvQWopc12P1MPFeffsWB5vTr
         jCXCeZ3BEwnl2lNcwVCtGCsZbRHhK/h/A2kVH3N6nJHVmsCMtjknMlyqDy38fdzFO2LQ
         PI46hj9QQOaoPi8W6KNOJ+q3qCeyjZFsZpPYXlMQnHGGT1bIYVkQubhpZ3dK7GXtog01
         r7jA==
X-Gm-Message-State: AOAM531C1n6XyQrtt8ldySomDGAxJPrDnvB9gi4kz3CiAL+7UqyZEsYX
        tyT2v98sr0nVAQiCSBcr6s6PH8UfqBA=
X-Google-Smtp-Source: ABdhPJxTkP5K+5u2wEnnMQAZ1hxziYHdEy3rNA/5JkFhujjfTyVgHxLC20fk1aWuge1Kp2C2lrqJwQ==
X-Received: by 2002:a05:600c:4982:b0:380:e458:dbd9 with SMTP id h2-20020a05600c498200b00380e458dbd9mr760802wmp.49.1645641090120;
        Wed, 23 Feb 2022 10:31:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3-20020a7bc1c3000000b00380e493660esm418812wmj.42.2022.02.23.10.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:29 -0800 (PST)
Message-Id: <883e17d0d21277e0ec8538da3e3b20f90b19128f.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:31:02 +0000
Subject: [PATCH 24/25] clone: use server-recommended bundle URI
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

After the ref advertisement initializes the connection between the
client and the remote, use the 'features' capability (if available) to
get a list of recommended features from the server.

In this change, we only update the bundle URI setting. The bundles are
downloaded immediately afterwards if the bundle URI becomes non-null.

RFC-TODO: don't overwrite a given --bundle-uri option.
RFC-TODO: implement the other capabilities.
RFC-TODO: guard this entire request behind opt-in config.
RFC-TODO: prevent using an HTTP(S) URI when in an SSH clone.
RFC-TODO: prevent using a local path for the bundle URI.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index cfe3d96047a..92b8727fc9d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -876,6 +876,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
+	struct string_list *feature_list = NULL;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1194,11 +1195,23 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 
-	/*
-	 * NOTE: The bundle URI download takes place after transport_get_remote_refs()
-	 * because a later change will introduce a check for recommended features,
-	 * which might include a recommended bundle URI.
-	 */
+	feature_list = transport_remote_features(transport);
+
+	if (feature_list) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, feature_list) {
+			char *value;
+			char *equals = strchr(item->string, '=');
+
+			if (!equals)
+				continue;
+			*equals = '\0';
+			value = equals + 1;
+
+			if (!strcmp(item->string, "bundleuri"))
+				bundle_uri = value;
+		}
+	}
 
 	/*
 	 * Before fetching from the remote, download and install bundle
@@ -1218,7 +1231,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (filter)
 			git_config_set("fetch.bundlefilter", filter);
 
-		if (!fetch_bundle_uri(bundle_uri, filter))
+		if (fetch_bundle_uri(bundle_uri, filter))
 			warning(_("failed to fetch objects from bundle URI '%s'"),
 				bundle_uri);
 	}
-- 
gitgitgadget

