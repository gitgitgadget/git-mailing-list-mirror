From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] setup.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 15:27:02 +0100
Message-ID: <20080208142702.GY25954@genesis.frugalware.org>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 15:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNUCm-0006Ty-Nc
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 15:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbYBHO1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 09:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbYBHO1P
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 09:27:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55923 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756771AbYBHO1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 09:27:15 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JNUC3-0006Ya-By
	from <vmiklos@frugalware.org>; Fri, 08 Feb 2008 15:27:14 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 07F9811901BD; Fri,  8 Feb 2008 15:27:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=BAYES_50 autolearn=no SpamAssassin version=3.2.3
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4020]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73095>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 setup.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index adede16..361825f 100644
--- a/setup.c
+++ b/setup.c
@@ -346,13 +346,13 @@ int git_config_perm(const char *var, const char *value)
 {
 	if (value) {
 		int i;
-		if (!strcmp(value, "umask"))
+		if (value && !strcmp(value, "umask"))
 			return PERM_UMASK;
-		if (!strcmp(value, "group"))
+		if (value && !strcmp(value, "group"))
 			return PERM_GROUP;
-		if (!strcmp(value, "all") ||
+		if (value && (!strcmp(value, "all") ||
 		    !strcmp(value, "world") ||
-		    !strcmp(value, "everybody"))
+		    !strcmp(value, "everybody")))
 			return PERM_EVERYBODY;
 		i = atoi(value);
 		if (i > 1)
-- 
1.5.4
