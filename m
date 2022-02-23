Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555FEC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiBWScO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbiBWSbs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:48 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F244B435
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m13-20020a7bca4d000000b00380e379bae2so2132854wml.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l2bOQQhpVQaDo7qkyj8KpnTRnvE1PVFH7xRfiYKu/jw=;
        b=Gitky/1GmIcKsDHzhIV2ugfJyvU7ByhlgRM1puNmE40i00miLiLzAZWic0ckeIuZNC
         cKIit31MSpZYM8snURHdpknVuXjxKpBULBLTBDS0x503K8qsIXdMfFSUldYV/zu09+q3
         Xs100Bh4j54LAOQzpb2DsXrVAC5ikF/gO0gDYv1Vd64ocjgyXKXkvNKE+IwdJz1hG1gy
         ULYsGRXXoKPczELgOACOGUea9Jk3JBzdMlZoalrYlvWSWqz5qndDZYj9gsc/wtMtDKBt
         ut494rSEnmjmxziglN9C8S5XoBFbGkr+ngpMk5+vM03gNdTQOczZENuZ0DDIywpJcU+n
         1KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l2bOQQhpVQaDo7qkyj8KpnTRnvE1PVFH7xRfiYKu/jw=;
        b=chpmqh4RcYhxlmdRWZcM7WZLjoNBK6Oerz1yQcWKMOjLYyk11Iwf/KS9aFglts35mu
         dbcgY4c4CV0K3AzkN4Yo6ccOUCM39P0JqJejdZZ/yTT2SN0BwM5wshyqEnaihz4bXcza
         vLynn8jC8CfzMZwXBtPWSln+tHD9ZCiTxXe76/7JoyXAo7H5iQQ88e5GTksNlxa/J8dU
         r3iWmJy2Kk+GjxnmhCxYngS1b7I9vnOHgRplI1jeJgicg1lf+mSto7jEI7eWcK2el9lB
         BtMt3Rug5WJPE8Sv5IxjQcWU8HpD//3V3XeKyvpuD3w9Z0RAcVEsk1Uj7x+gQxSoco8I
         DlZA==
X-Gm-Message-State: AOAM53318FZy3/ifJA3YazbEyAO2CaPNXG+ajiiUPUGcgOaza5ofRmS5
        b27r5AI2+xffUD9PimO0mdDiNCaYtjE=
X-Google-Smtp-Source: ABdhPJwUyGeX9pZhWHBmP57IfAkt+wQ+QbhPJbulNWO2Cle+sMrP92iw/6tHxR/VaakGzbCBi+CSYQ==
X-Received: by 2002:a05:600c:1c25:b0:380:d306:1058 with SMTP id j37-20020a05600c1c2500b00380d3061058mr786664wms.150.1645641078180;
        Wed, 23 Feb 2022 10:31:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm252367wmq.38.2022.02.23.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:17 -0800 (PST)
Message-Id: <050725d90ef019ca2684ec0afbfd701efea7f88a.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:51 +0000
Subject: [PATCH 13/25] clone: add --bundle-uri option
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

Cloning a remote repository is one of the most expensive operations in
Git. The server can spend a lot of CPU time generating a pack-file for
the client's request. The amount of data can clog the network for a long
time, and the Git protocol is not resumable. For users with poor network
connections or are located far away from the origin server, this can be
especially painful.

The 'git bundle fetch' command allows users to bootstrap a repository
using a set of bundles. However, this would require them to use 'git
init' first, followed by the 'git bundle fetch', and finally add a
remote, fetch, and checkout the branch they want.

Instead, integrate this workflow directly into 'git clone' with the
--bundle-uri' option. If the user is aware of a bundle server, then they
can tell Git to bootstrap the new repository with these bundles before
fetching the remaining objects from the origin server.

RFC-TODO: Document this option in git-clone.txt.

RFC-TODO: I added a comment about the location of this code being
necessary for the later step of auto-discovering the bundle URI from the
origin server. This is probably not actually a requirement, but rather a
pain point around how I implemented the feature. If a --bundle-uri
option is specified, but SSH is used for the clone, then the SSH
connection is left open while Git downloads bundles from another server.
This is sub-optimal and should be reconsidered when fully reviewed.

RFC-TODO: create tests for this option with a variety of URI types.

RFC-TODO: a simple end-to-end test is available at the end of the
series.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9c29093b352..6df3d513dc4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -33,6 +33,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "hook.h"
+#include "bundle.h"
 
 /*
  * Overall FIXMEs:
@@ -74,6 +75,7 @@ static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
+static const char *bundle_uri;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -155,6 +157,8 @@ static struct option builtin_clone_options[] = {
 		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
 		    N_("initialize sparse-checkout file to include only files at root")),
+	OPT_STRING(0, "bundle-uri", &bundle_uri,
+		   N_("uri"), N_("A URI for downloading bundles before fetching from origin remote")),
 	OPT_END()
 };
 
@@ -1185,6 +1189,35 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 
+	/*
+	 * NOTE: The bundle URI download takes place after transport_get_remote_refs()
+	 * because a later change will introduce a check for recommended features,
+	 * which might include a recommended bundle URI.
+	 */
+
+	/*
+	 * Before fetching from the remote, download and install bundle
+	 * data from the --bundle-uri option.
+	 */
+	if (bundle_uri) {
+		const char *filter = NULL;
+
+		if (filter_options.filter_spec.nr)
+			filter = expand_list_objects_filter_spec(&filter_options);
+		/*
+		 * Set the config for fetching from this bundle URI in the
+		 * future, but do it before fetch_bundle_uri() which might
+		 * un-set it (for instance, if there is no table of contents).
+		 */
+		git_config_set("fetch.bundleuri", bundle_uri);
+		if (filter)
+			git_config_set("fetch.bundlefilter", filter);
+
+		if (!fetch_bundle_uri(bundle_uri, filter))
+			warning(_("failed to fetch objects from bundle URI '%s'"),
+				bundle_uri);
+	}
+
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
-- 
gitgitgadget

