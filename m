Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B15DC433E1
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489B22078C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DuqsjAYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgEMV7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730473AbgEMV7d (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:59:33 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DC6C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so11671409pjh.2
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQNjWXDcmdmmvlLsOQoH51OuqOA+rAiLBr5p07EW9vI=;
        b=DuqsjAYtFa3r/jzuMG7R6+/xRXzKu1slRWCSNvlJlfG/OgkXq0iPFx6TC5JWUZ/GAH
         dwDqqt6aCgdppWg2KJIcDtvqhcmcMnBZRF7yVWbyKhtUDYpwVUmEfmhjHu9SSuD5n988
         sKRqoUbhMP9LQQgl6SHNGdkUYfvog3ykPuHlvYiHQUxwf6YFglHfG5erGo0jHzlhtC3/
         q76nNnVMLJLDfXkAvhdo3m0oXKlj5vJFkw0nPMBAIvczJOpSbeB9qo5y1rEYpHIEny2b
         bNswJxW/cqeX0EjKitc4nl/9DLXLlRp52K67b2yb7BVHxFY+NE4x6hluKB+rhVDGim2w
         M8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQNjWXDcmdmmvlLsOQoH51OuqOA+rAiLBr5p07EW9vI=;
        b=fNzEF/dCTj34AdDWoQ/LeGyLKeixyn/XTBJh9gF5VK4pu/RDUpJmCcufAnxwPN4cwQ
         R5RwvmWaOWoUgBxbojM5easJjV1HUkW4hexhKWJGMOkEnTvYy2M3tkfjYQhubZKbpBwn
         0my4b+xpedqViETlkADtONqS1ZXrv2yZyvO9Pt7+Ip0dreC8meILvdTofF6Hf9xOP825
         2y1I+Sr1YMr+rxDddUkTFqzbTXA0Yi5h0R1+KTbyCmbhSZoEHtMgFIi+2VE0dWcawIj0
         QwlpBgDeaVKvPsuH9ZFVPQ28vBzP2NNBRgBw9JYmFrRkfFbR3U3FxZaE8Dg1mIpO6+7q
         qE5A==
X-Gm-Message-State: AGi0PuarZSXGpZ9jxsFalWxq6kaLz4pp3MgX8B/Jrh9JiAk/ZoHlxshL
        cW3/op69H6sDOjtetmQx6D4++/lCXgQ=
X-Google-Smtp-Source: APiQypJiuIwAZAr8o2AEYtTX+hwrZ8WFe6/jldC275RFGGtRWIuWexmpj8Wv49TGE5KWAn5hCQxAqw==
X-Received: by 2002:a17:90a:fc89:: with SMTP id ci9mr36299330pjb.140.1589407172109;
        Wed, 13 May 2020 14:59:32 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t7sm5924982pjf.30.2020.05.13.14.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:31 -0700 (PDT)
Date:   Wed, 13 May 2020 15:59:30 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 1/8] commit-graph.c: extract 'refs_cb_data'
Message-ID: <0efbcfcf3af36d1a3dbef3762d6fee604c20f538.1589407014.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589407014.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent patches, we are going to update a progress meter when
'add_ref_to_set()' is called, and need a convenient way to pass a
'struct progress *' in from the caller.

Introduce 'refs_cb_data' as a catch-all for parameters that
'add_ref_to_set' may need, and wrap the existing single parameter in
that struct.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e3420ddcbf..9693112063 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1319,13 +1319,17 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	stop_progress(&progress);
 }
 
+struct refs_cb_data {
+	struct oidset *commits;
+};
+
 static int add_ref_to_set(const char *refname,
 			  const struct object_id *oid,
 			  int flags, void *cb_data)
 {
-	struct oidset *commits = (struct oidset *)cb_data;
+	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
-	oidset_insert(commits, oid);
+	oidset_insert(data->commits, oid);
 	return 0;
 }
 
@@ -1334,9 +1338,13 @@ int write_commit_graph_reachable(struct object_directory *odb,
 				 const struct split_commit_graph_opts *split_opts)
 {
 	struct oidset commits = OIDSET_INIT;
+	struct refs_cb_data data;
 	int result;
 
-	for_each_ref(add_ref_to_set, &commits);
+	memset(&data, 0, sizeof(data));
+	data.commits = &commits;
+
+	for_each_ref(add_ref_to_set, &data);
 	result = write_commit_graph(odb, NULL, &commits,
 				    flags, split_opts);
 
-- 
2.26.0.113.ge9739cdccc

