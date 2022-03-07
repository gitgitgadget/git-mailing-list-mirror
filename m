Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97943C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbiCGVwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbiCGVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE32675C23
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so260241wms.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=banR2/YPRedUlMEFqceTdv5AzXLOH8Pv1nIbKygHUss=;
        b=BCw08Rql53XrgnNwec5WBXP2NMKNyDFsc6nHD2iJt8C3cFimqDmCUtuTxeR+tKGlF+
         l6Sadom1bo8Vlc8BNoy1HwJO7iSVgHH1PLXfhp8pZ4Uxxx9kQmodKc/qZdtCG+WVUQQq
         y+ScfwwWw4p7c6qybD10VS66F4Rq5SWrZL7FtZwwWn3mH99w0C+6WTadaYMcDrLA4ton
         6JRMy7xJ9bHwqfaJo9n+UlS06PV9L0lzJT+soQqIeqzQ90atsK50R2pZqVdgm6dlsVKg
         zID7L8V65DPaNVt3lOQeoBW4rijKsyF2opNlgM8H8Vz7YSYGT0mf4ycPAwfnBKYL8bGF
         Mxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=banR2/YPRedUlMEFqceTdv5AzXLOH8Pv1nIbKygHUss=;
        b=uXtCeP1eO9inrP2MsW2ue60jc3bkzbbFHoQJz5H/MQXY2NZxCncyVeWsTJEOSjNVD9
         TBLYbsbOL6efHe2G0uB5eSU0K+h6k0ug8RmODC+mef3TxGDnb0C+Tlo1MzertOmFoRLQ
         7PNWFYVc0V8hfCrzJZmh4deOG++5Q85CTPrP3UPUBtH91g7TuSCGK1P95reg5fgKdMDn
         lc36SG8obSFbeD2VIPGSi5BgYrWhSon/Nox4ps9hdtN8EHwEzuIt19+iPf9NeqVivuY8
         XbJpvLPlzBj2Bm4Tn03nUuAJLOl4wPudrBfR603uCpWMXfs4uk+sPgYvHTC4J3PscpRC
         C8fQ==
X-Gm-Message-State: AOAM532oUngOmDiXzToYrB8RfkK/zt5H4pYuyti0q1PFAp/9jXDVA2nz
        30oEWnHm14yOMCXHVzCOjIbxI8z4VVE=
X-Google-Smtp-Source: ABdhPJzOVg5Jc9U7ui/RWSdivEQCgYFFPSKq90pNSKS1wWPFT8mNlRdE/JjIkg0tSYG9Hpaik7XGug==
X-Received: by 2002:a1c:cc06:0:b0:389:79c7:aee6 with SMTP id h6-20020a1ccc06000000b0038979c7aee6mr823396wmb.47.1646689850215;
        Mon, 07 Mar 2022 13:50:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020adff382000000b001f022ef0375sm11954607wro.102.2022.03.07.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:49 -0800 (PST)
Message-Id: <aaa15d7d5122924665ada22531f65f4c26513b50.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:37 +0000
Subject: [PATCH v2 09/12] rev-list: move --filter parsing into revision.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Now that 'struct rev_info' has a 'filter' member and most consumers of
object filtering are using that member instead of an external struct,
move the parsing of the '--filter' option out of builtin/rev-list.c and
into revision.c.

This use within handle_revision_pseudo_opt() allows us to find the
option within setup_revisions() if the arguments are passed directly. In
the case of a command such as 'git blame', the arguments are first
scanned and checked with parse_revision_opt(), which complains about the
option, so 'git blame --filter=blob:none <file>' does not become valid
with this change.

Some commands, such as 'git diff' gain this option without having it
make an effect. And 'git diff --objects' was already possible, but does
not actually make sense in that builtin.

The key addition that is coming is 'git bundle create --filter=<X>' so
we can create bundles containing promisor packs. More work is required
to make them fully functional, but that will follow.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/rev-list.c | 15 ---------------
 revision.c         | 11 +++++++++++
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3ab727817fd..640828149c5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -591,21 +591,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
-
-		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
-			if (!revs.filter)
-				CALLOC_ARRAY(revs.filter, 1);
-			parse_list_objects_filter(revs.filter, arg);
-			if (revs.filter->choice && !revs.blob_objects)
-				die(_("object filtering requires --objects"));
-			continue;
-		}
-		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
-			if (!revs.filter)
-				CALLOC_ARRAY(revs.filter, 1);
-			list_objects_filter_set_no_filter(revs.filter);
-			continue;
-		}
 		if (!strcmp(arg, "--filter-provided-objects")) {
 			filter_provided_objects = 1;
 			continue;
diff --git a/revision.c b/revision.c
index ad4286fbdde..1d612c1c102 100644
--- a/revision.c
+++ b/revision.c
@@ -32,6 +32,7 @@
 #include "utf8.h"
 #include "bloom.h"
 #include "json-writer.h"
+#include "list-objects-filter-options.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2669,6 +2670,14 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 		revs->no_walk = 0;
 	} else if (!strcmp(arg, "--single-worktree")) {
 		revs->single_worktree = 1;
+	} else if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+		if (!revs->filter)
+			CALLOC_ARRAY(revs->filter, 1);
+		parse_list_objects_filter(revs->filter, arg);
+	} else if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
+		if (!revs->filter)
+			CALLOC_ARRAY(revs->filter, 1);
+		list_objects_filter_set_no_filter(revs->filter);
 	} else {
 		return 0;
 	}
@@ -2872,6 +2881,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die("cannot combine --walk-reflogs with history-limiting options");
 	if (revs->rewrite_parents && revs->children.name)
 		die(_("options '%s' and '%s' cannot be used together"), "--parents", "--children");
+	if (revs->filter && revs->filter->choice && !revs->blob_objects)
+		die(_("object filtering requires --objects"));
 
 	/*
 	 * Limitations on the graph functionality
-- 
gitgitgadget

