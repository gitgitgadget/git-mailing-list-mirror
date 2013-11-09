From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 31/86] send-pack: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:24 +0100
Message-ID: <20131109070720.18178.73574.chriscool@tuxfamily.org>
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
	id 1Vf2fZ-00036C-7m
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306Ab3KIHJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:03 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65433 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933264Ab3KIHId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:33 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id B5C354A;
	Sat,  9 Nov 2013 08:08:32 +0100 (CET)
X-git-sha1: 8fed7c474b916021cd0951b326b48585211dce2b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237492>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 send-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index b228d65..c90049a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -109,7 +109,7 @@ static int receive_status(int in, struct ref *refs)
 	struct ref *hint;
 	int ret = 0;
 	char *line = packet_read_line(in, NULL);
-	if (prefixcmp(line, "unpack "))
+	if (!has_prefix(line, "unpack "))
 		return error("did not receive remote status");
 	if (strcmp(line, "unpack ok")) {
 		error("unpack failed: %s", line + 7);
@@ -122,7 +122,7 @@ static int receive_status(int in, struct ref *refs)
 		line = packet_read_line(in, NULL);
 		if (!line)
 			break;
-		if (prefixcmp(line, "ok ") && prefixcmp(line, "ng ")) {
+		if (!has_prefix(line, "ok ") && !has_prefix(line, "ng ")) {
 			error("invalid ref status from remote: %s", line);
 			ret = -1;
 			break;
-- 
1.8.4.1.566.geca833c
