Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB911F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933788AbeFFRDd (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:33 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33421 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933029AbeFFRDP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so10256300lfy.0
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0gdi6i0R0T08fGIPsfdfl9j6X+3iB2iU12EMVC7RCI=;
        b=s2uAh9sZKNxIpyesjLyTuohnR6UPduMlJovymuzih/8/WszqcBxb0hYflqWO0K8Tfm
         /XtcWAM+5FMlVK6n4usr6IanyoJ9aWXF6IkSw2V3mFIuX9vqJJ26hpjk2C5OWF4DG0e4
         R43QMA2LvkyvQhvX8hwMb+AOjQnifye9K5S8kOQkzHKq1x3G8oyYrYDXtqm6FLbIEEPv
         gd4EOc/zDBfS3GTl4g/2sjEbkym3JJPWSGJlTABEKL/CD6CYTnrFXsVe149sX5+h0uSO
         acLu/ABcaEJ8FqLAMr+uu8AQgOXGwFKhT2noEHhsJYzH9efKYgwvr+g04ef0tVgTzQcw
         RhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0gdi6i0R0T08fGIPsfdfl9j6X+3iB2iU12EMVC7RCI=;
        b=N31pzkq2n4v78bL9Vtsg3rF9oPSvyHC41BdhXb1lH2YWW2tyaxFbAnkDSszL9E00Fg
         uJ+M931GevyzZxICTjFE//ncs2awEKjC655gqzkf3FMV2vMbADOgudSO+UmnHkZPJ2lu
         Xssaw8hBP3kH+gBLXMAR1v3i0PeHtz3o6uiIwQ/CKy1tTLRjos1+J6w56RTQWzHYwgJZ
         bzC/ZRZcwKydW/BaQocFSX4Drcbvxmi/E5ax8tqEQNTqsJeQugIZiHIBlmmmUbMcetFC
         kTnjdRLiyvVcdevR12fWfLNANaSPN2X3w8/vVG6rwbojB/1FS3MpVk1+n9Wan2uTqwUb
         175g==
X-Gm-Message-State: APt69E01n3ZP42RDsBUqZvsPFsQ+VO6XpZ7v0Pnr9SbmRS3iY4HDcqs+
        ZebYDctWer6PgrF4AkZbX6I=
X-Google-Smtp-Source: ADUXVKLXXpeuL+g6imA3SuuZkljESMlwmfPtFm+JrNkhGUSeXO6ZarxhSfXwP0LsfswYeNbdSscEnQ==
X-Received: by 2002:a19:9c4b:: with SMTP id f72-v6mr2477796lfe.119.1528304593748;
        Wed, 06 Jun 2018 10:03:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 19/23] difftool: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 19:02:39 +0200
Message-Id: <20180606170243.4169-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/difftool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index fb2ccfe6f0..c7d6296762 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -321,7 +321,7 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_index_entry(&the_index, mode, oid->hash, path, 0, 0);
+	ce = make_index_entry(state->istate, mode, oid->hash, path, 0, 0);
 	ret = checkout_entry(ce, state, NULL);
 
 	free(ce);
@@ -488,7 +488,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				 * index.
 				 */
 				struct cache_entry *ce2 =
-					make_index_entry(&the_index, rmode, roid.hash,
+					make_index_entry(&wtindex, rmode, roid.hash,
 							 dst_path, 0, 0);
 
 				add_index_entry(&wtindex, ce2,
-- 
2.18.0.rc0.333.g22e6ee6cdf

