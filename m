From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 19/86] commit: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:12 +0100
Message-ID: <20131109070720.18178.67112.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hC-0004uI-Cf
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933362Ab3KIHK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:58 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54159 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab3KIHId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:33 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 9300252;
	Sat,  9 Nov 2013 08:08:27 +0100 (CET)
X-git-sha1: 26731ec5275260b117ada35eed6a852a8144716e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237527>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 commit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index de16a3c..35b276d 100644
--- a/commit.c
+++ b/commit.c
@@ -559,7 +559,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	     buf;
 	     buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
-		if (prefixcmp(buf, "author ")) {
+		if (!has_prefix(buf, "author ")) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
@@ -1106,7 +1106,7 @@ int parse_signed_commit(const unsigned char *sha1,
 		next = next ? next + 1 : tail;
 		if (in_signature && line[0] == ' ')
 			sig = line + 1;
-		else if (!prefixcmp(line, gpg_sig_header) &&
+		else if (has_prefix(line, gpg_sig_header) &&
 			 line[gpg_sig_header_len] == ' ')
 			sig = line + gpg_sig_header_len + 1;
 		if (sig) {
@@ -1186,7 +1186,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 		const char *found, *next;
 
-		if (!prefixcmp(buf, sigcheck_gpg_status[i].check + 1)) {
+		if (has_prefix(buf, sigcheck_gpg_status[i].check + 1)) {
 			/* At the very beginning of the buffer */
 			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
 		} else {
-- 
1.8.4.1.566.geca833c
