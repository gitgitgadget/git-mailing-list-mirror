From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 27/86] setup: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:20 +0100
Message-ID: <20131109070720.18178.85578.chriscool@tuxfamily.org>
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
	id 1Vf2fY-00036C-4W
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933302Ab3KIHJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:00 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36328 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933260Ab3KIHIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:32 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 0DB9EA5;
	Sat,  9 Nov 2013 08:08:31 +0100 (CET)
X-git-sha1: 7c3a31d5ae3cd7f142252e144924fef798e766f5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237495>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index f08dd64..6ed292a 100644
--- a/setup.c
+++ b/setup.c
@@ -82,7 +82,7 @@ int check_filename(const char *prefix, const char *arg)
 	const char *name;
 	struct stat st;
 
-	if (!prefixcmp(arg, ":/")) {
+	if (has_prefix(arg, ":/")) {
 		if (arg[2] == '\0') /* ":/" is root dir, always exists */
 			return 1;
 		name = arg + 2;
@@ -307,7 +307,7 @@ const char *read_gitfile(const char *path)
 	if (len != st.st_size)
 		die("Error reading %s", path);
 	buf[len] = '\0';
-	if (prefixcmp(buf, "gitdir: "))
+	if (!has_prefix(buf, "gitdir: "))
 		die("Invalid gitfile format: %s", path);
 	while (buf[len - 1] == '\n' || buf[len - 1] == '\r')
 		len--;
-- 
1.8.4.1.566.geca833c
