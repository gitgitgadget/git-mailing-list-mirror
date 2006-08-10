From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 01:19:05 -0700
Message-ID: <7vk65hvw92.fsf@assigned-by-dhcp.cox.net>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608100957050.13885@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 10:19:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5l8-00032G-4p
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 10:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWHJITJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 04:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWHJITI
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 04:19:08 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:26082 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751463AbWHJITH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 04:19:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810081906.ZVM12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 04:19:06 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608100957050.13885@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 10 Aug 2006 10:05:54 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25168>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Besides, I really use it often -- you should try it! Call me blind, but 
> very often I cannot spot the differences (in the unified diff) when they 
> are minor, especially when there was just a typo in the documentation. You 
> could now say that I should not care about it, then, but if _I_ made the 
> mistake, I want to learn from it.

I tried it on this:

diff --git a/builtin-apply.c b/builtin-apply.c
index c159873..be2c715 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1700,10 +1700,8 @@ static int apply_data(struct patch *patc
 		return -1;
 
 	/* NUL terminate the result */
-	if (desc.alloc <= desc.size) {
+	if (desc.alloc <= desc.size)
 		desc.buffer = xrealloc(desc.buffer, desc.size + 1);
-		desc.alloc++;
-	}
 	desc.buffer[desc.size] = 0;
 
 	patch->result = desc.buffer;

which shows something like:

diff --git a/builtin-apply.c b/builtin-apply.c
index c159873..be2c715 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1700,10 +1700,8 @@ static int apply_data(struct patch *patc
                return -1;

        /* NUL terminate the result */
        if (desc.alloc <= desc.size)
{
                desc.buffer = xrealloc(desc.buffer, desc.size + 1);
                desc.alloc++;
        }
        desc.buffer[desc.size] = 0;

        patch->result = desc.buffer;

where "desc.alloc++;" and next lines and the opening brace after
if() are red.  Why does that red opening brace have to come at
the beginning of line, I wonder...
