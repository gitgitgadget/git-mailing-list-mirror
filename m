From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --stat: ensure at least one '-' for deletions, and one
 '+' for additions
Date: Fri, 29 Sep 2006 06:07:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609290551510.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609281735040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wpvvrww.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609281942360.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd59fquc5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 06:07:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT9eu-0004xj-W5
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 06:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWI2EHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 00:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWI2EH3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 00:07:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:62137 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932535AbWI2EH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 00:07:28 -0400
Received: (qmail invoked by alias); 29 Sep 2006 04:07:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 29 Sep 2006 06:07:27 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd59fquc5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28087>

Hi,

On Thu, 28 Sep 2006, Junio C Hamano wrote:

> Another way is what I suggested earlier -- if the width is odd, drop one 
> to avoid this problem altogether.  That would also be acceptable and 
> probably be more consistent.

I see that you care deeply about the 7 column example. In that case, yes, 
I would rather have columns be rounded down to the next even number.

I care more about the consistency: if there are changes, I want to see 
them, and it should be linear: the more changes, the more plusses or 
minusses.

Ciao,
Dscho

P.S.: here's a patch on top of my last one:
-- snip --
[PATCH] force even diffstat width

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 diff.c |    3 ++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 53c30bd..2a898e6 100644
--- a/diff.c
+++ b/diff.c
@@ -729,6 +729,9 @@ static void show_stats(struct diffstat_t
 	else
 		width = max_change;
 
+	/* force width to be even */
+	width &= ~1;
+
 	for (i = 0; i < data->nr; i++) {
 		const char *prefix = "";
 		char *name = data->files[i]->name;
-- 
1.4.2.1.g1a99e1-dirty
