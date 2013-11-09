From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 61/86] builtin/index-pack: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:06:54 +0100
Message-ID: <20131109070720.18178.94111.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2lX-0001ea-MO
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883Ab3KIHOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:18 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:55645 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017Ab3KIHOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:16 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 591EF40;
	Sat,  9 Nov 2013 08:14:14 +0100 (CET)
X-git-sha1: 095d48dbabd12538624e8338fe2d2e1362ee9c65 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237559>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/index-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9e9eb4b..183cf1f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1534,9 +1534,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				stat_only = 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg = "";
-			} else if (!prefixcmp(arg, "--keep=")) {
+			} else if (has_prefix(arg, "--keep=")) {
 				keep_msg = arg + 7;
-			} else if (!prefixcmp(arg, "--threads=")) {
+			} else if (has_prefix(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
 				if (!arg[10] || *end || nr_threads < 0)
@@ -1547,7 +1547,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 						  "ignoring %s"), arg);
 				nr_threads = 1;
 #endif
-			} else if (!prefixcmp(arg, "--pack_header=")) {
+			} else if (has_prefix(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
 
@@ -1566,7 +1566,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				if (index_name || (i+1) >= argc)
 					usage(index_pack_usage);
 				index_name = argv[++i];
-			} else if (!prefixcmp(arg, "--index-version=")) {
+			} else if (has_prefix(arg, "--index-version=")) {
 				char *c;
 				opts.version = strtoul(arg + 16, &c, 10);
 				if (opts.version > 2)
-- 
1.8.4.1.566.geca833c
