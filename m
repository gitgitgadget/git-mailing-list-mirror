Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3833208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 00:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbdHWACT (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 20:02:19 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36197 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbdHWACS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 20:02:18 -0400
Received: by mail-pf0-f193.google.com with SMTP id c15so181428pfm.3
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g4zfNUWu3R5SJjEZfpMWzyJ8YfWOVZssbFqwT2W/Lr8=;
        b=ts0CwkVXH7VwLisIFPYf56r3WfVkUBjQ5FjB7CVDaZ+RGB2qgKiFzAkFrgxzUKDsxS
         0qy5EtchHoM9rTi4f11+mwbApBDh4BbY+niIr7Bsh3cn9BPHVY8qhTL0mJ75mP+DgPZJ
         EgJGhMtYOPGFV4iOr9jf61ijOg/wLmKPrOizaVaaIxX0JTqQLjcZX+LNShTyoCBDCoAj
         Jvu7WswtnZspOpOQDq1dX1cj+N1/6jCm0vNBhMs4aY7bvWSNar3O6Ex50HNMOqIPNnMt
         ugeLUZ9Z01/o7PwGrLcxiVZe1i7pVvGLII6mpD8KGmtLTAgpo5pN4LleeGKZCF+aSxFs
         xbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g4zfNUWu3R5SJjEZfpMWzyJ8YfWOVZssbFqwT2W/Lr8=;
        b=IYSWoy3FHuFDJ516UfrWJKnGy3T22glggGWq3cDgmUWcGwTrVjvAWveP9RMO/SCp5i
         t+M2aCFfanL/uywKGDcRplFPrBq3QXrCU9jBOzN3FGLmKLCU42NBJK515VsvJG/ZE5Zz
         cfQphy/V9pecdhWsfQd9T1OMon2O4s3+qUFgptIj8+HvMgKqshEW49b9btdEmQBIXUXl
         yAmVvNGCjHmqturTkDtntWlNPYrgV539Wm2Uh3BphmnAO4NKDeFqy3WynvyGjwvOI4WU
         5g1XmMwuMAWQ9cyt7Mhs2OgsqCogsXSWfhFc60AqrRX3zLNr3hmVOdkRsLEnL8cPkkYn
         AiWw==
X-Gm-Message-State: AHYfb5hjLWsQ1StkZ6NrbxO/wRUtfuhZRSzBDURrcuCQ3f3W063Xvp6i
        AgAN26aLySZLy0HJYdA=
X-Received: by 10.84.231.197 with SMTP id g5mr947311pln.152.1503446537796;
        Tue, 22 Aug 2017 17:02:17 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id a21sm206585pfg.18.2017.08.22.17.02.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 17:02:17 -0700 (PDT)
Date:   Tue, 22 Aug 2017 17:02:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] vcs-svn: remove repo_delete wrapper function
Message-ID: <20170823000215.GG13924@aiede.mtv.corp.google.com>
References: <20170822233732.GX13924@aiede.mtv.corp.google.com>
 <20170823000007.GD13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823000007.GD13924@aiede.mtv.corp.google.com>
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
Unchanged.

 vcs-svn/repo_tree.c | 5 -----
 vcs-svn/repo_tree.h | 1 -
 vcs-svn/svndump.c   | 4 ++--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 1a6f32d7cb..5bd4977cb6 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -41,8 +41,3 @@ void svn_repo_copy(uint32_t revision, const char *src, const char *dst)
 	}
 	fast_export_modify(dst, mode, data.buf);
 }
-
-void svn_repo_delete(const char *path)
-{
-	fast_export_delete(path);
-}
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index c840bc9bae..0cd2761183 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -3,6 +3,5 @@
 
 void svn_repo_copy(uint32_t revision, const char *src, const char *dst);
 const char *svn_repo_read_path(const char *path, uint32_t *mode_out);
-void svn_repo_delete(const char *path);
 
 #endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index c0fa4eb723..41113119bd 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -225,11 +225,11 @@ static void handle_node(void)
 		if (have_text || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
-		svn_repo_delete(node_ctx.dst.buf);
+		fast_export_delete(node_ctx.dst.buf);
 		return;
 	}
 	if (node_ctx.action == NODEACT_REPLACE) {
-		svn_repo_delete(node_ctx.dst.buf);
+		fast_export_delete(node_ctx.dst.buf);
 		node_ctx.action = NODEACT_ADD;
 	}
 	if (node_ctx.srcRev) {
-- 
2.14.1.342.g6490525c54

