Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16941C47247
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82C020752
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="nH6jEIeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgEFAHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEFAHv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:07:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E303C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:07:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so65942pjh.2
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RgpVrKtDEr5YGNcOHEq41/OIKzHF7MuIh5xDh9Eusw0=;
        b=nH6jEIeYf4yEnmJJpL9NB9wA1r76zGd69yy5BjApThJzxiCUI2S1iPeMtICulQXpjr
         VKCrrcPbRtyi3QRukh2m0o9B1tRqcwjax4WQS34uHdaHxGaPinQR+l/Hi2eY8Svvdn37
         FZzxvFyegQErjap18cbBadHe2fA4mlt8Wb9lBv1Jbpo4F5HuDbag7MhIBBObz2yG05AN
         T5lEO1aVSyD2RpqRBpFxH5gfFCa1boLwEgTnnRxXuUHLCE2Iqb0ZG/aI3rHIIVXUkEO2
         DMFZbGWeaT0VQhBz3nWhCm5BAR5PMtF/fv2dIJtUBJpaXlhh7ZlWZo8OgdR6lGS21BO7
         7Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RgpVrKtDEr5YGNcOHEq41/OIKzHF7MuIh5xDh9Eusw0=;
        b=gGDLLmiaiQdII4fwWV+x7D+fbfGotnwWFfLYer7HOsG0VPVtHcTmX3XDT/IZLOdTRV
         Pcr+drTuD6ivUJizBmLKZ4GSW2n1d73lMgTH5H8S3aVC8xoP7PZKQlSBhks5CGf97+0P
         xgTRn6Vp263nY+MAzu6QqiJOO5CT8rwpGDP1Hr14Bn1t6TotTSdGDJqFWNvoUg8sxTqw
         5EaX6IQKPD0CjW2nF7BYDa6zLDLunXVNQIbTbdXwPx3ADNCpoK+UBRd2zePOMaB66fmC
         mXi9z6TO4IajApTf4SJo0dB231hqWBy4N3mroOYfIRWuGBKnqHLiIk9GbRZNYWQ4sy/j
         GFdg==
X-Gm-Message-State: AGi0PuZdri2J2GIgTZt4Nvwwy9zY0zdl1BHMJ02qiwYb4k0Vu9CVR7xW
        iAsQOBrQmm1LFAeKHz2G/1fahjfya1k=
X-Google-Smtp-Source: APiQypL23PvnkAl/Kg6+Yr94oiTaXqqgYfAGOfQoQigR35Mlkva+runVn8H+6NU793vSxVk83xEtWw==
X-Received: by 2002:a17:902:b40b:: with SMTP id x11mr5549306plr.174.1588723669476;
        Tue, 05 May 2020 17:07:49 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id gz14sm3029122pjb.42.2020.05.05.17.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:07:48 -0700 (PDT)
Date:   Tue, 5 May 2020 18:07:47 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 5/8] builtin/commit-graph.c: dereference tags in builtin
Message-ID: <d449d83ce2efd4f8f3b15c0cfda8217ffa710116.1588723544.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1588723543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588723543.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When given a list of commits, the commit-graph machinery calls
'lookup_commit_reference_gently()' on each element in the set and treats
the resulting set of OIDs as the base over which to close for
reachability.

In an earlier collection of commits, the 'git commit-graph write
--reachable' case made the inner-most call to
'lookup_commit_reference_gently()' by peeling references before they
were passed over to the commit-graph internals.

Do the analog for 'git commit-graph write --stdin-commits' by calling
'lookup_commit_reference_gently()' outside of the commit-graph
machinery, making the inner-most call a noop.

Since this may incur additional processing time, surround
'read_one_commit' with a progress meter to provide output to the caller.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f550d8489a..6537e9acef 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -6,6 +6,7 @@
 #include "repository.h"
 #include "commit-graph.h"
 #include "object-store.h"
+#include "progress.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
@@ -138,8 +139,10 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int read_one_commit(struct oidset *commits, char *hash)
+static int read_one_commit(struct oidset *commits, struct progress *progress,
+			   char *hash)
 {
+	struct commit *result;
 	struct object_id oid;
 	const char *end;
 
@@ -148,7 +151,15 @@ static int read_one_commit(struct oidset *commits, char *hash)
 		return 1;
 	}
 
-	oidset_insert(commits, &oid);
+	display_progress(progress, oidset_size(commits) + 1);
+
+	result = lookup_commit_reference_gently(the_repository, &oid, 1);
+	if (result)
+		oidset_insert(commits, &result->object.oid);
+	else {
+		error(_("invalid commit object id: %s"), hash);
+		return 1;
+	}
 	return 0;
 }
 
@@ -159,6 +170,7 @@ static int graph_write(int argc, const char **argv)
 	struct object_directory *odb = NULL;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
+	struct progress *progress = NULL;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -228,18 +240,25 @@ static int graph_write(int argc, const char **argv)
 		if (opts.stdin_commits) {
 			oidset_init(&commits, 0);
 			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
+			if (opts.progress)
+				progress = start_delayed_progress(
+					_("Collecting commits from input"), 0);
 		}
 
 		while (strbuf_getline(&buf, stdin) != EOF) {
 			char *line = strbuf_detach(&buf, NULL);
 			if (opts.stdin_commits) {
-				int result = read_one_commit(&commits, line);
+				int result = read_one_commit(&commits, progress,
+							     line);
 				if (result)
 					return result;
 			} else
 				string_list_append(&pack_indexes, line);
 		}
 
+		if (progress)
+			stop_progress(&progress);
+
 		UNLEAK(buf);
 	}
 
-- 
2.26.0.113.ge9739cdccc

