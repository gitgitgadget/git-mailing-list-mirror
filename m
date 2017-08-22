Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271941F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbdHVXkV (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:40:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34511 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdHVXkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:40:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id m6so155573pfm.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=52Dyg5krAoxMn/xjyzBYUpHcbjXNR2JocX/O3K1eApk=;
        b=ihx0j/TqWyVdVXEjt6wZFA2LuuZTTbW9kDsD18/dsD3bw7ndwNPgdw/VYG6n/GCEkW
         M6xnJG1UxmoRBJdHEoFXaVCHQNrMfn3Pc8fgUL9nLXYmP0G4xEbXOg2rM4cq7B1Xu/xV
         GpNTDFoQIbzc/buF++tHXzC7JSfdT20O2AavRYzB8o49droDMNW0fP4FZgZRHj0a1IoP
         xM65bbXhQ838uhQLveQEGxNnKf7cJkIFRzHr/Q+iZKNYcHFgyPAHmYownnxterkzkT7M
         5iewgn36Tr1tUlYCvrxsu5B43jia18Q/QsmDuyU35LCJgdsZzuldYdO/sERiwVjfs+Nk
         hcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=52Dyg5krAoxMn/xjyzBYUpHcbjXNR2JocX/O3K1eApk=;
        b=qcAwGsSrPpHn7rXtyRIMMzV/iDFEk4hwX20AgCS1NB9ZLgCIO88H+iJwDPCiVVRSOj
         5BLeA0oEjtSX2KXsJxq0S9wkUFXYm9TE5tdiIe0PfK1y40ulhkH73WKAHlIHBJ/8Ftzn
         9wOr5cyCeQRiWK21OV3cbZpY1CXA2gkigM9iRwbdq+1L4RoeYli827jl07a+QbcBrPu3
         ns2b2ox7I5jVF+SbuLRN/TGjU0c4fX6j63MOyCqwfKfBpWgk3j5qkYW8aGbpviscdAJX
         k+mdKLF1e/N5ZbQpgJCp2clMk09UAAsoe/LMlf1i+cciP47qvzxTKk9hU74uo387u274
         oU0w==
X-Gm-Message-State: AHYfb5isfGaXHmUyVphV2CPc8+WBXx5KXol6UqSbd0Q82IrokhwsXajZ
        BFImrkn8q1YoZXUdpYI=
X-Received: by 10.84.198.129 with SMTP id p1mr905092pld.120.1503445219910;
        Tue, 22 Aug 2017 16:40:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id z8sm126239pgc.93.2017.08.22.16.40.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 16:40:19 -0700 (PDT)
Date:   Tue, 22 Aug 2017 16:40:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] vcs-svn: remove repo_delete wrapper function
Message-ID: <20170822234017.GA13924@aiede.mtv.corp.google.com>
References: <20170822233732.GX13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822233732.GX13924@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v1.7.10-rc0~118^2~4^2~4^2~3 (vcs-svn: pass paths through to
fast-import, 2010-12-13) this is an alias for fast_export_delete.
Remove the unnecessary layer of indirection.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.c | 5 -----
 vcs-svn/repo_tree.h | 1 -
 vcs-svn/svndump.c   | 4 ++--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 9107f9663d..99747e373a 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -41,8 +41,3 @@ void repo_copy(uint32_t revision, const char *src, const char *dst)
 	}
 	fast_export_modify(dst, mode, data.buf);
 }
-
-void repo_delete(const char *path)
-{
-	fast_export_delete(path);
-}
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 7f59fd9148..56a3209d01 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -3,6 +3,5 @@
 
 void repo_copy(uint32_t revision, const char *src, const char *dst);
 const char *repo_read_path(const char *path, uint32_t *mode_out);
-void repo_delete(const char *path);
 
 #endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index dc42ae3316..d51136fac5 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -225,11 +225,11 @@ static void handle_node(void)
 		if (have_text || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
-		repo_delete(node_ctx.dst.buf);
+		fast_export_delete(node_ctx.dst.buf);
 		return;
 	}
 	if (node_ctx.action == NODEACT_REPLACE) {
-		repo_delete(node_ctx.dst.buf);
+		fast_export_delete(node_ctx.dst.buf);
 		node_ctx.action = NODEACT_ADD;
 	}
 	if (node_ctx.srcRev) {
-- 
2.14.1.342.g6490525c54

