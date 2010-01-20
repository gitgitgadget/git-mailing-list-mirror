From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/4] msvc: Fix a compiler warning due to an incorrect pointer
 cast
Date: Wed, 20 Jan 2010 19:34:14 +0000
Message-ID: <4B575AB6.4060502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:35:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhGn-0001cs-7L
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab0ATUfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532Ab0ATUfJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:35:09 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:42677 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753662Ab0ATUfG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 15:35:06 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1NXhGb-00020X-dg; Wed, 20 Jan 2010 20:35:05 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137571>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

The warning in question being:

    .../regex.c(2811) : warning C4047: '=' : 'regoff_t *' differs in levels \
of indirection from 'int'

Note also that the final line of context in the diff below contains an ^L
character, which will hopefully find it's way to the list...

ATB,
Ramsay Jones

 compat/regex/regex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 67d5c37..556d8ab 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -2808,7 +2808,7 @@ re_set_registers (bufp, regs, num_regs, starts, ends)
     {
       bufp->regs_allocated = REGS_UNALLOCATED;
       regs->num_regs = 0;
-      regs->start = regs->end = (regoff_t) 0;
+      regs->start = regs->end = (regoff_t *) 0;
     }
 }
 
-- 
1.6.6
