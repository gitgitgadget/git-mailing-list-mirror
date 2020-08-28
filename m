Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98D9C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 20:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B12720872
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 20:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mYSnZeo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgH1UWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1UWU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 16:22:20 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E167C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 13:22:20 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id d30so242190qvc.9
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s+wuUyALhybNL6jJL3gfAXdty+d7yhSHdRtOTOeJWpE=;
        b=mYSnZeo8Rg5b7vdMJmyc+LLjJTxsYUptcZgJDr/X2QxQGeZByJHeSgGLcW1IoUmdVc
         639eGK+qkH2Zk4XDok8jB8s/YMXxfPqFlEgNK2VBWITLbU9Xad7fOs6sWfsxySO2pYSx
         6LvtJtmGO7fIxEn+deFeV7LQWDX5k0aCuYAcsJ7NylKn81RyDB6vAStQRhcN+m8B2pD0
         TwiDaDIIonUIpJXUBLtfyIeUh/xB/V5ExYTyoHuUZcdC3ZMKEiodbvnR5xT7z49uQcA+
         xkr79qcOk48P45w+OLL/NVRMM5ifeuhagRoEtIY7fnvURusuNw2PNvxoEqNUCewTGxTq
         fgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s+wuUyALhybNL6jJL3gfAXdty+d7yhSHdRtOTOeJWpE=;
        b=gzCNsn/pnOlT4bY54v8KoO5374w+mhkf/i+1kJSnkpP9SXtWmxZPzINeDNN/r180JM
         p1vCP4SsDYikAnBE6PVrDDw9vDEWm07oagjG1HPnSWs41YMlynl+ai4hQAzd9ViEDD2j
         RQ5tIlZMoXhaTMY2bs14KIZ9KhRoqhJPqoEWriYNMv6EOr6Fgo3m+v/cflNRZ83tgijq
         ZH59j+5uNi5QvduuGyAA6NNJtHZOWB7aF6cOs9p6sK3MGC1E6dCOeFc3TWc0h35xKAFM
         OUxTAjBYh3XCu/wVrP7V2kojstNtBHMC3yOuTN8iFeB45K8HAh7YO3Gs02k7zZoeAJ4G
         pFRQ==
X-Gm-Message-State: AOAM530OEiuIFxtuMbO6rpwV2WwUPVhEHjCiPV5CnIj9cQ5SXsTLxj5E
        C5q9hhNk+W+Nfu1leh2vkpQ/XSncvB0dFfbw
X-Google-Smtp-Source: ABdhPJxMJZMFbEOyifh7ULLjyaxBdF9Sm5b0B35WMc7JAW/Rc77sESLpO/BU7QmaJFkBLovODPX/WQ==
X-Received: by 2002:a05:6214:954:: with SMTP id dn20mr302044qvb.122.1598646138823;
        Fri, 28 Aug 2020 13:22:18 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f08e:2c2d:3ae3:2fac])
        by smtp.gmail.com with ESMTPSA id i14sm211782qkn.53.2020.08.28.13.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:22:17 -0700 (PDT)
Date:   Fri, 28 Aug 2020 16:22:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v2] midx: traverse the local MIDX first
Message-ID: <20200828202213.GA24009@nand.local>
References: <20200828180621.GA9036@nand.nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828180621.GA9036@nand.nand.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a repository has an alternate object directory configured, callers
can traverse through each alternate's MIDX by walking the '->next'
pointer.

But, when 'prepare_multi_pack_index_one()' loads multiple MIDXs, it
places the new ones at the front of this pointer chain, not at the end.
This can be confusing for callers such as 'git repack -ad', causing test
failures like in t7700.6 with 'GIT_TEST_MULTI_PACK_INDEX=1'.

The occurs when dropping a pack known to the local MIDX with alternates
configured that have their own MIDX. Since the alternate's MIDX is
returned via 'get_multi_pack_index()', 'midx_contains_pack()' returns
true (which is correct, since it traverses through the '->next' pointer
to find the MIDX in the chain that does contain the requested object).
But, we call 'clear_midx_file()' on 'the_repository', which drops the
MIDX at the path of the first MIDX in the chain, which (in the case of
t7700.6 is the one in the alternate).

This patch addresses that by:

  - placing the local MIDX first in the chain when calling
    'prepare_multi_pack_index_one()', and

  - introducing a new 'get_local_multi_pack_index()', which explicitly
    returns the repository-local MIDX, if any.

Don't impose an additional order on the MIDX's '->next' pointer beyond
that the first item in the chain must be local if one exists so that we
avoid a quadratic insertion.

Likewise, use 'get_local_multi_pack_index()' in
'remove_redundant_pack()' to fix the formerly broken t7700.6 when run
with 'GIT_TEST_MULTI_PACK_INDEX=1'.

Finally, note that the MIDX ordering invariant is only preserved by the
insertion order in 'prepare_packed_git()', which traverses through the
ODB's '->next' pointer, meaning we visit the local object store first.
This fragility makes this an undesirable long-term solution if more
callers are added, but it is acceptable for now since this is the only
caller.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c |  2 +-
 midx.c           |  8 ++++++--
 packfile.c       | 11 +++++++++++
 packfile.h       |  1 +
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 98fac03946..01e7767c79 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -133,7 +133,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct multi_pack_index *m = get_multi_pack_index(the_repository);
+	struct multi_pack_index *m = get_local_multi_pack_index(the_repository);
 	strbuf_addf(&buf, "%s.pack", base_name);
 	if (m && midx_contains_pack(m, buf.buf))
 		clear_midx_file(the_repository);
diff --git a/midx.c b/midx.c
index e9b2e1253a..cc19b66152 100644
--- a/midx.c
+++ b/midx.c
@@ -416,8 +416,12 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 	m = load_multi_pack_index(object_dir, local);
 
 	if (m) {
-		m->next = r->objects->multi_pack_index;
-		r->objects->multi_pack_index = m;
+		struct multi_pack_index *mp = r->objects->multi_pack_index;
+		if (mp) {
+			m->next = mp->next;
+			mp->next = m;
+		} else
+			r->objects->multi_pack_index = m;
 		return 1;
 	}
 
diff --git a/packfile.c b/packfile.c
index 6ab5233613..9ef27508f2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,6 +1027,17 @@ struct multi_pack_index *get_multi_pack_index(struct repository *r)
 	return r->objects->multi_pack_index;
 }
 
+struct multi_pack_index *get_local_multi_pack_index(struct repository *r)
+{
+	struct multi_pack_index *m = get_multi_pack_index(r);
+
+	/* no need to iterate; we always put the local one first (if any) */
+	if (m && m->local)
+		return m;
+
+	return NULL;
+}
+
 struct packed_git *get_all_packs(struct repository *r)
 {
 	struct multi_pack_index *m;
diff --git a/packfile.h b/packfile.h
index 240aa73b95..a58fc738e0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -57,6 +57,7 @@ void install_packed_git(struct repository *r, struct packed_git *pack);
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct multi_pack_index *get_multi_pack_index(struct repository *r);
+struct multi_pack_index *get_local_multi_pack_index(struct repository *r);
 struct packed_git *get_all_packs(struct repository *r);
 
 /*
-- 
2.28.0.338.g87a3b7a5a2.dirty
