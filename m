From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/4] parseopt: make usage optional
Date: Sun, 08 Mar 2009 19:16:58 +0100
Message-ID: <49B40B9A.8080202@lsrfire.ath.cx>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org> <49B2C784.90800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 19:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgNa4-0004Fj-3S
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 19:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbZCHSRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 14:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbZCHSRD
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 14:17:03 -0400
Received: from india601.server4you.de ([85.25.151.105]:36980 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbZCHSRC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 14:17:02 -0400
Received: from [10.0.1.101] (p57B7C244.dip.t-dialin.net [87.183.194.68])
	by india601.server4you.de (Postfix) with ESMTPSA id EABA72F8063;
	Sun,  8 Mar 2009 19:16:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49B2C784.90800@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112627>

Allow usagestr to be NULL and don't display anything a help screen in
this case.  This is useful to implement incremental parsers.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 parse-options.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 8b21dea..51e804b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -364,6 +364,9 @@ int parse_options(int argc, const char **argv, const struct option *options,
 int usage_with_options_internal(const char * const *usagestr,
 				const struct option *opts, int full)
 {
+	if (!usagestr)
+		return PARSE_OPT_HELP;
+
 	fprintf(stderr, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
 		fprintf(stderr, "   or: %s\n", *usagestr++);
-- 
1.6.2
