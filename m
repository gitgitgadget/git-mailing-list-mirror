From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-recursive: include heapq?
Date: Fri, 11 Nov 2005 11:26:39 -0800
Message-ID: <7viruzm1e8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511111520260.7575@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051111185246.GB13524@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 20:27:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaeYG-0004ZA-KO
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 20:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVKKT0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 14:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVKKT0m
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 14:26:42 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:55019 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751099AbVKKT0k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 14:26:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111192543.QZFO11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 14:25:43 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051111185246.GB13524@steel.home> (Alex Riesen's message of
	"Fri, 11 Nov 2005 19:52:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11630>

Alex Riesen <raa.lkml@gmail.com> writes:

> Johannes Schindelin, Fri, Nov 11, 2005 15:23:04 +0100:
>> I get this when pulling:
>>... 
>> Okay, my python is *old*:
>> 
>> $ python -V
>> Python 2.2.1
>> 
>> Is it worthwhile to include heapq as we did with subprocess? Or should I 
>> upgrade...
>
> Trying really trivial in-index merge...
> fatal: Merge requires file-level merging
> Nope.
> Traceback (most recent call last):
>   File "/home/raa/bin/git-merge-recursive", line 8, in ?
>     from gitMergeCommon import *
>   File "/home/raa/share/git-core/python/gitMergeCommon.py", line 14, in ?
>     import subprocess
> ImportError: No module named subprocess
> Automatic merge failed/prevented; fix up by hand
>
> That said, I thought an upgrade was worth it and upgraded my 2.3 to 2.4 :)

Something like this is needed, I suppose...

-- >8 -- cut here -- >8 --
INSTALL: duplicate python requirements from Makefile

and refer the reader to Makefile for other things that can be
tweaked.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
git diff
diff --git a/INSTALL b/INSTALL
index 06b11e1..63ccf62 100644
--- a/INSTALL
+++ b/INSTALL
@@ -75,3 +75,15 @@ Issues of note:
           history graphically
 
 	- "ssh" is used to push and pull over the net
+
+	- "perl" and POSIX-compliant shells are needed to use most of
+	  the barebone Porcelainish scripts.
+
+	- "python" 2.3 or more recent; if you have 2.3, you may need
+          to build with "make WITH_OWN_SUBPROCESS_PY=YesPlease".
+
+ - Some platform specific issues are dealt with Makefile rules,
+   but depending on your specific installation, you may not
+   have all the libraries/tools needed, or you may have
+   necessary libraries at unusual locations.  Please look at the
+   top of the Makefile to see what can be adjusted for your needs.

Compilation finished at Fri Nov 11 11:24:14
