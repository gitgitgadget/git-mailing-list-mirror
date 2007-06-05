From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] $EMAIL is a last resort fallback, as it's system-wide.
Date: Wed,  6 Jun 2007 00:25:35 +0200
Message-ID: <11810823351883-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <pierre.habouzit@m4x.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 00:25:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvhTJ-0008H8-5T
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 00:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762672AbXFEWZi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759344AbXFEWZi
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 18:25:38 -0400
Received: from pan.madism.org ([88.191.52.104]:38240 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762672AbXFEWZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 18:25:37 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 158A0B838;
	Wed,  6 Jun 2007 00:25:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7222E7A1D; Wed,  6 Jun 2007 00:25:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49231>

From: Pierre Habouzit <pierre.habouzit@m4x.org>

  Rationale: $EMAIL is a system-wide setup that is used for many many many
applications. If the git user chose a specific user.email setup, then _this_
should be honoured rather than $EMAIL.

Signed-off-by: Pierre Habouzit <pierre.habouzit@m4x.org>
---
 ident.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 69a04b8..3d49608 100644
--- a/ident.c
+++ b/ident.c
@@ -196,9 +196,9 @@ const char *fmt_ident(const char *name, const char *email,
 	if (!name)
 		name = git_default_name;
 	if (!email)
-		email = getenv("EMAIL");
-	if (!email)
 		email = git_default_email;
+	if (!email)
+		email = getenv("EMAIL");
 
 	if (!*name) {
 		struct passwd *pw;
-- 
1.5.2.1
