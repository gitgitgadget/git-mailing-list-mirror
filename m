Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BBEC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398832076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="kucQ2WL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHKUvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUvf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:51:35 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07620C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:35 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cs12so52594qvb.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AtctLu256av06ik5IHDWiQKbEbZ8S9fTFgXOJvN+Mvg=;
        b=kucQ2WL3arY0ZauFZIeUpdFyYSylVBWGGuqogIyGbKoxj/D91sd5qHVwHXFiTMLduO
         UcwCU1pjMZJTGc5jXZqrDYVvMpI9DIFgs4ztonEJLmkSiI/LC3HJAK7MWYLGIDmaG+Hr
         wKFqV0TlzzXnHFxa5iw5nr7SYLgMmgZa1d9BALNjfisD398xjXT1+kyCjB864KTp6HBV
         uz8IBgu60hxvHKcXYQF35hKGUwZBTOik90qHmfq6Hf3FgKALhHxCMHo7YN+V+VmP+Klb
         nJO4pcLCy9PY8i7A27vwG4nc0R6fELxH59oxIBZoKML+IKMENETdpDLk46YlJ/GvR661
         zLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtctLu256av06ik5IHDWiQKbEbZ8S9fTFgXOJvN+Mvg=;
        b=Iu/t5/qF8hq8ybWfPIh0g2GvdYtSS8fCxkjKfC/f94TqndCNlRS7uaaALjlgjTMLlU
         /+hfW3z32JYsI+x/Wp4OERk5EJ9XcAWoHxiZIehAO1i1ACSe0MOyt0VZ5v3c5aauEXzq
         0iT7u/YJMKbiNEqj11fsFwpE16RNlsSCqZFgiKk9U1BZNP3cYvxvNTLoKyxFABd8C9sV
         2fnbcdZNr4n+2S8hZCcTUEL2QbzujDxaBC2MJjcXzHTZFcSg4IccCQ4XUNDiGc7onIgY
         4coqxg/iqtPmaT9MwmP3o+uiO8vBQXeLns+euw7/HUcxtgZeqNCXs6PKkV9m/pr80DXW
         /Meg==
X-Gm-Message-State: AOAM531rFgS8Ce7/d3Lihtd89o/Q/ttC1IuU+66SLjb5sm40pwqPLsBv
        pUCrc7j+PUxC6FfmMaw/MEvGrr0zsYWHlQsG
X-Google-Smtp-Source: ABdhPJzaSVVUWcrP4nClizXKtY/E4HPdvVVvgEjDpyf8hbKRjK/nrczZWXg2BW7iVEBW/MMncyfxOw==
X-Received: by 2002:a0c:b791:: with SMTP id l17mr3426646qve.44.1597179093960;
        Tue, 11 Aug 2020 13:51:33 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id x137sm14652qkb.47.2020.08.11.13.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:33 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 04/14] t/helper/test-read-graph.c: prepare repo settings
Message-ID: <f59db1e30dfcf69f6d6ab961b42766c62724324d.1597178915.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read-graph test-tool is used by a number of the commit-graph test to
assert various properties about a commit-graph. Previously, this program
never ran 'prepare_repo_settings()'. There was no need to do so, since
none of the commit-graph machinery is affected by the repo settings.

In the next patch, the commit-graph machinery's behavior will become
dependent on the repo settings, and so loading them before running the
rest of the test tool is critical.

As such, teach the test tool to call 'prepare_repo_settings()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 6d0c962438..5f585a1725 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -12,11 +12,12 @@ int cmd__read_graph(int argc, const char **argv)
 	setup_git_directory();
 	odb = the_repository->objects->odb;
 
+	prepare_repo_settings(the_repository);
+
 	graph = read_commit_graph_one(the_repository, odb);
 	if (!graph)
 		return 1;
 
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
-- 
2.28.0.rc1.13.ge78abce653

