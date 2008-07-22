From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH] bring description of git diff --cc up to date
Date: Tue, 22 Jul 2008 18:27:18 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807221812470.25746@harper.uchicago.edu>
References: <20080722111947.BIW29914@m4500-01.uchicago.edu>
 <7v63qxn8w2.fsf@gitster.siamese.dyndns.org> <7vd4l5lio1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, David Greaves <david@dgreaves.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRHn-0001tl-29
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758877AbYGVX1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756866AbYGVX1b
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:27:31 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:36503 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758241AbYGVX13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:27:29 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6MNRJp6004690;
	Tue, 22 Jul 2008 18:27:19 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6MNRIxC026214;
	Tue, 22 Jul 2008 18:27:18 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <7vd4l5lio1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89565>

Junio C Hamano wrote:

> Actually Linus talks about "when you have two versions to
> choose from, and if the result matches one of them, then it is not
> interesting".

That is much better - thanks.  (The description by Linus I was referring
to was from
<http://thread.gmane.org/gmane.comp.version-control.git/89415>:
"So "--cc" only shows output if: the merge itself actually changed
something from _all_ parents" - which is not too misleading since the
two-parent case is the usual one.)

How about this, then?
--- %< ---
Subject: document diff --cc's long-ago-changed semantics

In February 2006 [1], the definition of "interesting hunk" for
git's "compact combined diff" format changed, without any
corresponding change in documentation.  This patch brings the
documentation up to date.

[1] commit bf1c32bdec8223785c779779d0a660a099f69a63
    combine-diff: update --cc "uninteresting hunks" logic
---
 Documentation/git-diff-tree.txt    |   12 +++++++-----
 Documentation/rev-list-options.txt |    9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 0e45b58..14dc70d 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -92,12 +92,14 @@ include::pretty-options.txt[]
 --cc::
 	This flag changes the way a merge commit patch is displayed,
 	in a similar way to the '-c' option. It implies the '-c'
-	and '-p' options and further compresses the patch output
-	by omitting hunks that show differences from only one
-	parent, or show the same change from all but one parent
-	for an Octopus merge.  When this optimization makes all
+	and '-p' options and makes the patch output
+	even more compact by omitting uninteresting hunks.  A hunk is
+	considered uninteresting if the person merging had two versions
+	to choose between among all of the parents and the result shows
+	no changes from one of those versions.
+	When this optimization makes all
 	hunks disappear, the commit itself and the commit log
-	message is not shown, just like in any other "empty diff" case.
+	message are not shown, just like in any other "empty diff" case.
 
 --always::
 	Show the commit itself and the commit log message even
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b6f5d87..c61d05d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -111,10 +111,11 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 
 --cc::
 
-	This flag implies the '-c' options and further compresses the
-	patch output by omitting hunks that show differences from only
-	one parent, or show the same change from all but one parent for
-	an Octopus merge.
+	This flag implies the '-c' option and makes the patch output
+	even more compact by omitting uninteresting hunks.  A hunk is
+	considered uninteresting if the person merging had two versions
+	to choose between among all of the parents and the result shows
+	no changes from one of those versions.
 
 -r::
 
-- 
1.5.6.3.549.g8ca11
