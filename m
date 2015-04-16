From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] log -L: improve error message on malformed argument
Date: Thu, 16 Apr 2015 16:43:07 +0200
Message-ID: <1429195387-20573-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 16 16:43:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yil0r-0002Nx-Ru
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 16:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933623AbbDPOnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 10:43:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49255 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933614AbbDPOnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 10:43:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3GEhBbO017088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2015 16:43:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3GEhDFW000367;
	Thu, 16 Apr 2015 16:43:13 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yil0a-0005PD-T8; Thu, 16 Apr 2015 16:43:12 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Apr 2015 16:43:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3GEhBbO017088
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429800194.19572@YN4BswMr1DtACXfDxta7Zw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267291>

The old message did not mention the :regex:file form.

To avoid overly long lines, split the message into two lines (in case
item->string is long, it will be the only part truncated in a narrow
terminal).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 line-log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index a490efe..e725248 100644
--- a/line-log.c
+++ b/line-log.c
@@ -575,7 +575,8 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 
 		name_part = skip_range_arg(item->string);
 		if (!name_part || *name_part != ':' || !name_part[1])
-			die("-L argument '%s' not of the form start,end:file",
+			die("invalid -L argument '%s'.\n"
+			    "It should be of the form start,end:file or :regex:file.",
 			    item->string);
 		range_part = xstrndup(item->string, name_part - item->string);
 		name_part++;
-- 
2.4.0.rc1.42.g9642cc6
