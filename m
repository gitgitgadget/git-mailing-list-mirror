From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] remote.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 15:26:40 +0100
Message-ID: <20080208142640.GX25954@genesis.frugalware.org>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 15:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNUCZ-0006PQ-49
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 15:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784AbYBHO1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 09:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756771AbYBHO1F
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 09:27:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36976 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756694AbYBHO1C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 09:27:02 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JNUBh-0006U5-2B
	from <vmiklos@frugalware.org>; Fri, 08 Feb 2008 15:27:01 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4011211901BD; Fri,  8 Feb 2008 15:26:40 +0100 (CET)
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
	[score: 0.4021]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73094>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 0e00680..4765815 100644
--- a/remote.c
+++ b/remote.c
@@ -276,7 +276,7 @@ static int handle_config(const char *key, const char *value)
 		else
 			error("more than one uploadpack given, using the first");
 	} else if (!strcmp(subkey, ".tagopt")) {
-		if (!strcmp(value, "--no-tags"))
+		if (value && !strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
 	} else if (!strcmp(subkey, ".proxy")) {
 		remote->http_proxy = xstrdup(value);
-- 
1.5.4
