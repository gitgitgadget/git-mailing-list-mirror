From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 68/86] builtin/name-rev: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:01 +0100
Message-ID: <20131109070720.18178.68234.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2lh-0001o9-PC
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984Ab3KIHPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:37 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33926 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758677Ab3KIHOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:18 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 64AF65D;
	Sat,  9 Nov 2013 08:14:17 +0100 (CET)
X-git-sha1: 308059a0d7b041c21f2aafd815ebf6b880ef6536 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237563>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/name-rev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 20fcf8c..2b74220 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -101,9 +101,9 @@ static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
 {
 	if (shorten_unambiguous)
 		refname = shorten_unambiguous_ref(refname, 0);
-	else if (!prefixcmp(refname, "refs/heads/"))
+	else if (has_prefix(refname, "refs/heads/"))
 		refname = refname + 11;
-	else if (!prefixcmp(refname, "refs/"))
+	else if (has_prefix(refname, "refs/"))
 		refname = refname + 5;
 	return refname;
 }
@@ -149,7 +149,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
 
-	if (data->tags_only && prefixcmp(path, "refs/tags/"))
+	if (data->tags_only && !has_prefix(path, "refs/tags/"))
 		return 0;
 
 	if (data->ref_filter) {
-- 
1.8.4.1.566.geca833c
