From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH] bring description of git diff --cc up to date
Date: Tue, 22 Jul 2008 22:55:06 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807222210540.3408@harper.uchicago.edu>
References: <20080722111947.BIW29914@m4500-01.uchicago.edu>
 <7v63qxn8w2.fsf@gitster.siamese.dyndns.org> <7vd4l5lio1.fsf@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0807221812470.25746@harper.uchicago.edu>
 <7vfxq1igh0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, David Greaves <david@dgreaves.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 05:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLVSY-0006TA-1m
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 05:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYGWDzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 23:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbYGWDzN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 23:55:13 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:44504 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbYGWDzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 23:55:12 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6N3t9xB032387;
	Tue, 22 Jul 2008 22:55:09 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6N3t6ha005099;
	Tue, 22 Jul 2008 22:55:06 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <7vfxq1igh0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89600>

On Tue, 22 Jul 2008, Junio C Hamano wrote:

>> +	This flag implies the '-c' option and makes the patch output
>> +	even more compact by omitting uninteresting hunks.  A hunk is
>> +	considered uninteresting if the person merging had two versions
>> +	to choose between among all of the parents and the result shows
>
> the above makes me confused into
> thinking that even if there are 47 parent versions, it is Ok if I looked
> at only two versions and picked from one of them

Here's another attempt.  I grimace at the sound of it, but it might be
more clear.

--- snipsnip ---
Subject: document diff --cc's long-ago-changed semantics

In February 2006 [1], the definition of "interesting hunk" for
git's compact-combined diff format changed without a
corresponding change in documentation.  This patch brings the
documentation up to date.

[1] commit bf1c32bdec8223785c779779d0a660a099f69a63
    combine-diff: update --cc "uninteresting hunks" logic

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-diff-tree.txt    |   12 +++++++-----
 Documentation/rev-list-options.txt |    9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 0e45b58..7f8dc5b 100644
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
+	considered uninteresting if it shows no changes from at least
+	one of the parents and shows the same changes from each of the
+	parents from which it shows changes.
+	When this optimization makes all
 	hunks disappear, the commit itself and the commit log
-	message is not shown, just like in any other "empty diff" case.
+	message are not shown, just like in any other "empty diff" case.
 
 --always::
 	Show the commit itself and the commit log message even
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b6f5d87..d75de78 100644
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
+	considered uninteresting if it shows no changes from at least
+	one of the parents and shows the same changes from each of the
+	parents from which it shows changes.
 
 -r::
 
-- 
1.5.6.3.549.g8ca11
