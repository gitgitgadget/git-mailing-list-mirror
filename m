From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 23/86] log-tree: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:16 +0100
Message-ID: <20131109070720.18178.15709.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fW-00036C-Uv
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933258Ab3KIHI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:57 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65404 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933257Ab3KIHIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:30 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 4C96169;
	Sat,  9 Nov 2013 08:08:29 +0100 (CET)
X-git-sha1: fed525b71944bf1a1142faecadd8047eca5f719c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237494>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 log-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 8534d91..25b46a9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -98,7 +98,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	struct object *obj;
 	enum decoration_type type = DECORATION_NONE;
 
-	if (!prefixcmp(refname, "refs/replace/")) {
+	if (has_prefix(refname, "refs/replace/")) {
 		unsigned char original_sha1[20];
 		if (!read_replace_refs)
 			return 0;
@@ -116,11 +116,11 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	if (!obj)
 		return 0;
 
-	if (!prefixcmp(refname, "refs/heads/"))
+	if (has_prefix(refname, "refs/heads/"))
 		type = DECORATION_REF_LOCAL;
-	else if (!prefixcmp(refname, "refs/remotes/"))
+	else if (has_prefix(refname, "refs/remotes/"))
 		type = DECORATION_REF_REMOTE;
-	else if (!prefixcmp(refname, "refs/tags/"))
+	else if (has_prefix(refname, "refs/tags/"))
 		type = DECORATION_REF_TAG;
 	else if (!strcmp(refname, "refs/stash"))
 		type = DECORATION_REF_STASH;
-- 
1.8.4.1.566.geca833c
