From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 1/4] var: Don't require to be in a git repository.
Date: Fri, 14 Mar 2008 18:29:27 +0100
Message-ID: <1205515770-3424-2-git-send-email-frank@lichtenheld.de>
References: <1205515770-3424-1-git-send-email-frank@lichtenheld.de>
Cc: Git Mailing List <git@vger.kernel.org>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:31:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDk6-0003Ll-II
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbYCNR3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbYCNR3l
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:29:41 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:55119 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880AbYCNR3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:29:37 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDiu-0003Yh-Sn; Fri, 14 Mar 2008 18:29:42 +0100
Received: from host-82-135-33-74.customer.m-online.net ([82.135.33.74] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDii-000843-T8; Fri, 14 Mar 2008 18:29:28 +0100
Received: from djpig by dirac.djpig.de with local (Exim 4.69)
	(envelope-from <frank@lichtenheld.de>)
	id 1JaDik-00013D-N4; Fri, 14 Mar 2008 18:29:30 +0100
X-Mailer: git-send-email 1.5.4.4.555.g697b7.dirty
In-Reply-To: <1205515770-3424-1-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77261>

git var works fine even when not called in a git repository. So
don't require it.

This will make it possible to remove this pre-condition for some
other git commands as well.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 var.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/var.c b/var.c
index 0de0efa..c20ac91 100644
--- a/var.c
+++ b/var.c
@@ -51,11 +51,12 @@ static int show_config(const char *var, const char *value)
 int main(int argc, char **argv)
 {
 	const char *val;
+	int nongit;
 	if (argc != 2) {
 		usage(var_usage);
 	}
 
-	setup_git_directory();
+	setup_git_directory_gently(&nongit);
 	val = NULL;
 
 	if (strcmp(argv[1], "-l") == 0) {
-- 
1.5.4.4
