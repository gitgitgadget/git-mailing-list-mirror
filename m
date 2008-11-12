From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] define empty tree sha1 as a macro
Date: Wed, 12 Nov 2008 03:17:52 -0500
Message-ID: <20081112081752.GA3751@coredump.intra.peff.net>
References: <20081112081609.GA3720@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0AwQ-000790-N6
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbYKLIR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbYKLIRz
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:17:55 -0500
Received: from peff.net ([208.65.91.99]:3162 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbYKLIRz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:17:55 -0500
Received: (qmail 17622 invoked by uid 111); 12 Nov 2008 08:17:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:17:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:17:52 -0500
Content-Disposition: inline
In-Reply-To: <20081112081609.GA3720@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100722>

This can potentially be used in a few places, so let's make
it available to all parts of the code.

Signed-off-by: Jeff King <peff@peff.net>
---
I use the _HEX version in further patches, but since it is such a magic
number, I thought it made sense to keep all definitions in the same
place.

 cache.h     |    6 ++++++
 sha1_file.c |    4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index bcc57ba..46eb2af 100644
--- a/cache.h
+++ b/cache.h
@@ -528,6 +528,12 @@ static inline void hashclr(unsigned char *hash)
 }
 extern int is_empty_blob_sha1(const unsigned char *sha1);
 
+#define EMPTY_TREE_SHA1_HEX \
+	"4b825dc642cb6eb9a060e54bf8d69288fbee4904"
+#define EMPTY_TREE_SHA1_BIN \
+	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
+	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+
 int git_mkstemp(char *path, size_t n, const char *template);
 
 /*
diff --git a/sha1_file.c b/sha1_file.c
index 654d039..037e439 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2056,9 +2056,7 @@ static struct cached_object {
 static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
-	/* empty tree sha1: 4b825dc642cb6eb9a060e54bf8d69288fbee4904 */
-	"\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60"
-	"\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04",
+	EMPTY_TREE_SHA1_BIN,
 	OBJ_TREE,
 	"",
 	0
-- 
1.6.0.4.883.g4593ee.dirty
