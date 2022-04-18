Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EF8C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiDRR2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347085AbiDRR1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43CA33E24
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y21so7628849wmi.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoV246/1PGHewPN6wt14WplBIDHHlt+glqAO1B1LvWE=;
        b=kht9xIiZzumXh1U79Lljbtg9gn0rs+pBr9Aviv1ybHnjtfEpzSN7mFKq3bGOt7npZJ
         HeE12fhr2z1fpAUwmjPO4Pj8e1a5tTM66Jdmy/B10Kin3xhCfWh+OaMVuSv25CEOmEUk
         w1t+UIROVvw8IErNreEgZ86gUAmFD5ivNqDHdaopwXqvtjYJQLf81fbLHP/xHgMVjdlO
         GYciVGl85Gmll2YMavbR35D8VbhcjphwZ/kOShxTX07P8Sf9MSBKVxmpt8m9ERTiskFc
         NwAVBnzNMtigZcTApIswRVzuZUDT5h00UUx84swM6Tu7NueYu+Un4x/IPqerh2acrGE0
         uzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoV246/1PGHewPN6wt14WplBIDHHlt+glqAO1B1LvWE=;
        b=QNlidt0tHhfyeh6LLu5PW+SdDk7rp43gt/LqWpEOshB70f3uT6fMS0wkY7n0bT3d1m
         5GOTAB2l2K1juRvnAkszfJ87bCujq4QWLCpcnxhoQZMownSMKxzGmnm6n4t/LAbkLJUq
         tbSUGjP6f7kwyyIIZ8W3qMuFB2lQqOlqufOQwOTNmuYi7o9GjGjsZMZVRAfgt0MjYD7D
         AkIZyujY36md+xBhnh6StF1+u7EjjGZNUoJS4JuZt4AIXJQscFogbaW0WMa4gIoDOUUH
         KsTXL6qSulXa3gHKQtiusVfo4giDxkQ/vzx+7p/CDOGvTlQUSXZFgNRXUFOFhdPWiMqA
         QQ0A==
X-Gm-Message-State: AOAM5307odIeN9pvCQs+dV0cWKlECY3UhEU/247VwqkPriGnaVzwbyhr
        caXxcBXJ+1lyiwQUvbwtPycBiYNKCkrZsQ==
X-Google-Smtp-Source: ABdhPJxKzP/95U9a8IVeMxNTwKIb/ccF1AUp7dUa3Z5bdbADqOsaawpL05oQIKtUS1jcGh8dl+D9Yw==
X-Received: by 2002:a05:600c:3b29:b0:38e:bc90:16c with SMTP id m41-20020a05600c3b2900b0038ebc90016cmr16030070wms.143.1650302667064;
        Mon, 18 Apr 2022 10:24:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 26/36] fetch: fetch bundles before fetching original data
Date:   Mon, 18 Apr 2022 19:23:43 +0200
Message-Id: <RFC-patch-v2-26.36-0a238641247-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

If a user cloned using a bundle URI, then they might want to re-use it
to download new bundles during 'git fetch' before fetching the remaining
objects from the origin server. Use the 'fetch.bundleURI' config as the
indicator for whether this extra step should happen.

Do not fetch bundles if --dry-run is specified.

RFC-TODO: add tests.

RFC-TODO: update Documentation/git-fetch.txt

RFC-TODO: update Documentation/config/

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fetch.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed5..ac684bdf252 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,7 @@
 #include "commit-graph.h"
 #include "shallow.h"
 #include "worktree.h"
+#include "bundle.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -2180,6 +2181,22 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	/* FETCH_HEAD never gets updated in --dry-run mode */
 	if (dry_run)
 		write_fetch_head = 0;
+	else {
+		/*
+		 * --dry-run mode skips bundle downloads, which might
+		 * update some refs.
+		 */
+		char *bundle_uri = NULL;
+		git_config_get_string("fetch.bundleuri", &bundle_uri);
+
+		if (bundle_uri) {
+			char *filter = NULL;
+			git_config_get_string("fetch.bundlefilter", &filter);
+			fetch_bundle_uri(bundle_uri, filter);
+			free(bundle_uri);
+			free(filter);
+		}
+	}
 
 	if (all) {
 		if (argc == 1)
-- 
2.36.0.rc2.902.g60576bbc845

