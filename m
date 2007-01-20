From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --walk-reflogs: disallow uninteresting commits
Date: Fri, 19 Jan 2007 23:21:01 -0800
Message-ID: <7v64b29naa.fsf@assigned-by-dhcp.cox.net>
References: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200135500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6tqbjt8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200218290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pqmbhzg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200325380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 08:21:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8AXM-0005Wp-6z
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 08:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbXATHVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 02:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbXATHVE
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 02:21:04 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38571 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965158AbXATHVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 02:21:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120072101.MOAJ26900.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 20 Jan 2007 02:21:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DKMK1W00F1kojtg0000000; Sat, 20 Jan 2007 02:21:19 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200325380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 03:28:19 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37258>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	> I think people may also appreciate timestamps on Reflog headers 
> 	> you add to the output.
>
> 	At the moment, if you ask for @{1} (or leave it out), you will see 
> 	them enumerated by number. If you ask for @{now}, you will see 
> 	them identified by date...

Thanks.  This certainly needs a better documentation -- the attached is
my try.

By the way, I haven't looked into it, but does this ring a bell?

    $ git-log --walk-reflogs -1 --pretty=s master@{1.day}
    commit 72fe6a59890870ed9c3e9e1e6381fc0d7ba75fe4
    Reflog: master@{Thu, 1 Jan 1970 00:00:00 +0000} ((null))
    Reflog message: (null)Author: Junio C Hamano <junkio@cox.net>

        Documentation: Generate command lists.


---

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 86c94e7..fcc540b 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -190,6 +190,21 @@ limiting may be applied.
 	In addition to the '<commit>' listed on the command
 	line, read them from the standard input.
 
+--walk-reflogs::
+
+	Instead of walking the commit ancestry chain, walk
+	reflog entries from the most recent one to older ones.
+	When this option is used you cannot specify commits to
+	exclude (that is, '{caret}commit', 'commit1..commit2',
+	nor 'commit1...commit2' notations cannot be used).
++
+With '\--pretty' format other than oneline (for obvious reasons),
+this causes the output to have two extra lines of information
+taken from the reflog.  By default, 'commit@{Nth}' notation is
+used in the output.  When the starting commit is specified as
+'commit@{now}', output also uses 'commit@{timestamp}' notation
+instead.
+
 --merge::
 
 	After a failed merge, show refs that touch files having a
