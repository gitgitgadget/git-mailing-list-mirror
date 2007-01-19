From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation/git.txt: command re-classification
Date: Fri, 19 Jan 2007 15:36:42 -0800
Message-ID: <7vps9aeghh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701181713200.2577@xanadu.home>
	<7v1wlrle61.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701191437450.3011@xanadu.home>
	<7vbqkufyhy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701191729060.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 00:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H83Hs-0008NK-Vh
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 00:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbXASXgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 18:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbXASXgp
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 18:36:45 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43685 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbXASXgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 18:36:44 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119233643.ZYBA29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 18:36:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DBd01W01B1kojtg0000000; Fri, 19 Jan 2007 18:37:01 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0701191729060.3011@xanadu.home> (Nicolas Pitre's
	message of "Fri, 19 Jan 2007 17:44:58 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37219>

Nicolas Pitre <nico@cam.org> writes:

> I don't think fsck-objects is really plumbing though.  I'd tag it as 
> ancillaryinterrogators.
>
> Also, having:
>
>    git-am(1)
>           Apply a series of patches from a mailbox.
>
>    git-applymbox(1)
>           Apply a series of patches in a mailbox.
>
> looks a bit weird.

I thought about that issue (also annotate vs blame).  I'm fine
with demoting applymbox to ancillary, perhaps with potential
future deprecation in mind (but that would be a separate topic).

annotate is already ancillary and blame also is.  Do you want to
promote one of them to mainporcelain?

> Is git-show-branch really a primary command?

Ah, I didn't notice that you wanted to move it out of
mainporcelain in your patch.

I personally use it quite often while juggling topics,
especially since I do not usually work inside X, but I'm fine
either way -- ancillaryinterrogators?

> I'd just drop the "to put it another way" entirely.

Ok, then how about this on top of what you saw on the list.


diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 9443ab3..4b76d19 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -62,7 +62,7 @@ __DATA__
 git-add                                 mainporcelain
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
-git-applymbox                           mainporcelain
+git-applymbox                           ancillaryinterrogators
 git-applypatch                          purehelpers
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
@@ -159,7 +159,7 @@ git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
 git-show                                mainporcelain
-git-show-branch                         mainporcelain
+git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-setup                            purehelpers
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ded48b5..9761de3 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -115,9 +115,9 @@ gitlink:git-read-tree[1].
 The interface (input, output, set of options and the semantics)
 to these low-level commands are meant to be a lot more stable
 than Porcelain level commands, because these commands are
-primarily for scripted use.  To put it another way, the
-interface to Plumbing commands are subject to change in order to
-improve the end user experience.
+primarily for scripted use.  The interface to Porcelain commands
+on the other hand are subject to change in order to improve the
+end user experience.
 
 The following description divides
 the low-level commands into commands that manipulate objects (in
