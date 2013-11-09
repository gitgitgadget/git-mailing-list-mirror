From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 79/86] builtin/show-ref: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:12 +0100
Message-ID: <20131109070720.18178.83028.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2l1-00014x-AB
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933474Ab3KIHOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:36 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:55716 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933462Ab3KIHOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:23 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 23DF26A;
	Sat,  9 Nov 2013 08:14:22 +0100 (CET)
X-git-sha1: 6856256a2d4f442dbe2ef8f3e3cbc3d801dd7bde 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237546>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/show-ref.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 9f3f5e3..5e978aa 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -37,8 +37,8 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (tags_only || heads_only) {
 		int match;
 
-		match = heads_only && !prefixcmp(refname, "refs/heads/");
-		match |= tags_only && !prefixcmp(refname, "refs/tags/");
+		match = heads_only && has_prefix(refname, "refs/heads/");
+		match |= tags_only && has_prefix(refname, "refs/tags/");
 		if (!match)
 			return 0;
 	}
@@ -210,7 +210,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 		while (*pattern) {
 			unsigned char sha1[20];
 
-			if (!prefixcmp(*pattern, "refs/") &&
+			if (has_prefix(*pattern, "refs/") &&
 			    !read_ref(*pattern, sha1)) {
 				if (!quiet)
 					show_one(*pattern, sha1);
-- 
1.8.4.1.566.geca833c
