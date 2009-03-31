From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Tue, 31 Mar 2009 02:18:36 +0200 (CEST)
Message-ID: <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 31 02:18:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoRg8-0008BO-GY
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 02:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbZCaAQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 20:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754411AbZCaAQW
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 20:16:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:53762 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753827AbZCaAQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 20:16:21 -0400
Received: (qmail invoked by alias); 31 Mar 2009 00:16:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 31 Mar 2009 02:16:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xfS9hWdSx4fliK3SiGGxHzUGJIRWEDpvPwqYujO
	I8euNPWtQu+I6c
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1238458535u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115202>

Commit 0925ce4(Add map_user() and clear_mailmap() to mailmap) broke the
lower-casing of email addresses.  This mostly did not matter if your
.mailmap has only lower-case email addresses;  However, we did not
require .mailmap to contain lowercase-only email addresses.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 lezzee how that goes
 mailmap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index f12bb45..6be91b6 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -50,6 +50,15 @@ static void add_mapping(struct string_list *map,
 {
 	struct mailmap_entry *me;
 	int index;
+	char *p;
+
+	if (old_email)
+		for (p = old_email; *p; p++)
+			*p = tolower(*p);
+	if (new_email)
+		for (p = new_email; *p; p++)
+			*p = tolower(*p);
+
 	if (old_email == NULL) {
 		old_email = new_email;
 		new_email = NULL;
-- 
1.6.2.1.613.g25746
