From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/7] revert: rename subject related variables in get_message()
Date: Thu, 22 Jul 2010 15:18:31 +0200
Message-ID: <20100722131836.2148.57917.chriscool@tuxfamily.org>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 15:34:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObvvB-0005JP-Ib
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 15:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759379Ab0GVNeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:34:18 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:58154 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759370Ab0GVNeP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:34:15 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 4AFA480009AD;
	Thu, 22 Jul 2010 15:34:14 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 3CD1280027DC;
	Thu, 22 Jul 2010 15:34:14 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 21E1580009AD;
	Thu, 22 Jul 2010 15:34:09 +0200 (CEST)
X-ME-UUID: 20100722133410138.21E1580009AD@mwinf2f18.orange.fr
X-git-sha1: 6633d42b367eb00a32dc6ce0af4626a62803d22d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151451>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ed89bba..44149b5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -122,9 +122,9 @@ static int find_commit_subject(const char *commit_buffer, const char **subject)
 static int get_message(const char *raw_message, struct commit_message *out)
 {
 	const char *encoding;
-	const char *p, *abbrev;
+	const char *abbrev, *subject;
+	int abbrev_len, subject_len;
 	char *q;
-	int abbrev_len, oneline_len;
 
 	if (!raw_message)
 		return -1;
@@ -145,17 +145,17 @@ static int get_message(const char *raw_message, struct commit_message *out)
 	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	abbrev_len = strlen(abbrev);
 
-	oneline_len = find_commit_subject(out->message, &p);
+	subject_len = find_commit_subject(out->message, &subject);
 
 	out->parent_label = xmalloc(strlen("parent of ") + abbrev_len +
-			      strlen("... ") + oneline_len + 1);
+			      strlen("... ") + subject_len + 1);
 	q = out->parent_label;
 	q = mempcpy(q, "parent of ", strlen("parent of "));
 	out->label = q;
 	q = mempcpy(q, abbrev, abbrev_len);
 	q = mempcpy(q, "... ", strlen("... "));
 	out->subject = q;
-	q = mempcpy(q, p, oneline_len);
+	q = mempcpy(q, subject, subject_len);
 	*q = '\0';
 	return 0;
 }
-- 
1.7.2.rc3.267.g400b3
