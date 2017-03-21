Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C77D20958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755783AbdCUBWC (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:22:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:48307 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755006AbdCUBWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:22:00 -0400
Received: (qmail 10198 invoked by uid 109); 21 Mar 2017 01:21:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:21:32 +0000
Received: (qmail 9837 invoked by uid 111); 21 Mar 2017 01:21:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:21:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:21:27 -0400
Date:   Mon, 20 Mar 2017 21:21:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] prefix_filename: move docstring to header file
Message-ID: <20170321012127.qp4lp4zcc3icprzw@sigill.intra.peff.net>
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a public function, so we should make its
documentation available near the declaration.

While we're at it, we can give a few details about how it
works.

Signed-off-by: Jeff King <peff@peff.net>
---
 abspath.c |  5 -----
 cache.h   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/abspath.c b/abspath.c
index b02e068aa..fd30aff08 100644
--- a/abspath.c
+++ b/abspath.c
@@ -246,11 +246,6 @@ char *absolute_pathdup(const char *path)
 	return strbuf_detach(&sb, NULL);
 }
 
-/*
- * Unlike prefix_path, this should be used if the named file does
- * not have to interact with index entry; i.e. name of a random file
- * on the filesystem.
- */
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static struct strbuf path = STRBUF_INIT;
diff --git a/cache.h b/cache.h
index 9b2157f59..a01668fc4 100644
--- a/cache.h
+++ b/cache.h
@@ -529,7 +529,19 @@ extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path);
 extern char *prefix_path_gently(const char *prefix, int len, int *remaining, const char *path);
+
+/*
+ * Concatenate "prefix" (if len is non-zero) and "path", with no
+ * connecting characters (so "prefix" should end with a "/").
+ * Unlike prefix_path, this should be used if the named file does
+ * not have to interact with index entry; i.e. name of a random file
+ * on the filesystem.
+ *
+ * The return value may point to static storage which will be overwritten by
+ * further calls.
+ */
 extern const char *prefix_filename(const char *prefix, int len, const char *path);
+
 extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix,
 			    const char *name,
-- 
2.12.1.683.gcd02edfec

