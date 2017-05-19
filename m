Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0862021E
	for <e@80x24.org>; Fri, 19 May 2017 12:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbdESMwJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:52:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:54820 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752816AbdESMwI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:52:08 -0400
Received: (qmail 2495 invoked by uid 109); 19 May 2017 12:52:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:52:08 +0000
Received: (qmail 27781 invoked by uid 111); 19 May 2017 12:52:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:52:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:52:06 -0400
Date:   Fri, 19 May 2017 08:52:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 06/15] sha1_name: consistently refer to object_context as "oc"
Message-ID: <20170519125206.z4uhvstoij6l2zi4@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An early version of the patch to add object_context used the
name object_resolve_context. This was later shortened to
just object_context, but the "orc" variable name stuck in a
few places.  Let's use "oc", which is used elsewhere in the
code.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 2 +-
 sha1_name.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 188811920..656341b8e 100644
--- a/cache.h
+++ b/cache.h
@@ -1363,7 +1363,7 @@ extern int get_sha1_tree(const char *str, unsigned char *sha1);
 extern int get_sha1_treeish(const char *str, unsigned char *sha1);
 extern int get_sha1_blob(const char *str, unsigned char *sha1);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
-extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc);
+extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *oc);
 
 extern int get_oid(const char *str, struct object_id *oid);
 
diff --git a/sha1_name.c b/sha1_name.c
index 35c1e2a9e..a11d08dd8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1638,9 +1638,9 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 	get_sha1_with_context_1(name, GET_SHA1_ONLY_TO_DIE, prefix, sha1, &oc);
 }
 
-int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
+int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *oc)
 {
 	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
 		die("BUG: incompatible flags for get_sha1_with_context");
-	return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
+	return get_sha1_with_context_1(str, flags, NULL, sha1, oc);
 }
-- 
2.13.0.219.g63f6bc368

