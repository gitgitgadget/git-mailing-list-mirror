From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT v1.5.1-rc1
Date: Mon, 19 Mar 2007 18:04:17 -0700
Message-ID: <7vd534d8tq.fsf@assigned-by-dhcp.cox.net>
References: <20070306063501.GA24355@spearce.org>
	<7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
	<20070306071630.GB24004@spearce.org>
	<7vtzwyprr7.fsf_-_@assigned-by-dhcp.cox.net>
	<7v8xdth5c4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703191459440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 20 02:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTSmX-0007Hw-9K
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 02:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbXCTBEU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 21:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030824AbXCTBEU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 21:04:20 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45788 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030822AbXCTBES (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 21:04:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320010418.JOOW28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 21:04:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cp4H1W00F1kojtg0000000; Mon, 19 Mar 2007 21:04:17 -0400
In-Reply-To: <Pine.LNX.4.63.0703191459440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 19 Mar 2007 15:13:31 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42687>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 19 Mar 2007, Junio C Hamano wrote:
>
>>   - "git diff --pretty=format:<string>" to allow more flexible
>>     custom log output.
>
> You mean "git log" there, not "git diff", correct?

Of course you are right.  Any other typos?

I could not parse the --reverse description so I rewrote it
while I was at it, and also I found we did not mention ':/<message>'
so I added it.


diff --git a/Documentation/RelNotes-1.5.1.txt b/Documentation/RelNotes-1.5.1.txt
index f78cf56..215159f 100644
--- a/Documentation/RelNotes-1.5.1.txt
+++ b/Documentation/RelNotes-1.5.1.txt
@@ -10,11 +10,15 @@ Updates since v1.5.0
 
 * New commands and options.
 
-  - "git log" and friends take --reverse.  This makes output
-    that typically goes reverse order in chronological order.
-    "git shortlog" usually lists commits in chronological order,
-    but with "--reverse", they are shown in reverse
-    chronological order.
+  - "git log" and friends take --reverse, which instructs them
+    to give their output in the order opposite from their usual.
+    They typically output from new to old, but with this option
+    their output would read from old to new.  "git shortlog"
+    usually lists older commits first, but with this option,
+    they are shown from new to old.
+
+  - "git log --pretty=format:<string>" to allow more flexible
+    custom log output.
 
   - "git diff" learned --ignore-space-at-eol.  This is a weaker
     form of --ignore-space-change.
@@ -22,9 +26,6 @@ Updates since v1.5.0
   - "git diff --no-index pathA pathB" can be used as diff
     replacement with git specific enhancements.
 
-  - "git diff --pretty=format:<string>" to allow more flexible
-    custom log output.
-
   - "git diff --no-index" can read from '-' (standard input).
 
   - "git diff" also learned --exit-code to exit with non-zero
@@ -61,6 +62,15 @@ Updates since v1.5.0
     symlinks on filesystems that do not support them; they are
     checked out as regular files instead.
 
+  - You can name a commit object with its first line of the
+    message.  The syntax to use is ':/message text'.  E.g. 
+    
+    $ git show ":/object name: introduce ':/<oneline prefix>' notation"
+
+    means the same thing as:
+
+    $ git show 28a4d940443806412effa246ecc7768a21553ec7
+
 
 * Updated behaviour of existing commands.
 
diff --git a/Makefile b/Makefile
