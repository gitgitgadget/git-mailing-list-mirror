From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Documentation (mostly user manual) patches
Date: Wed, 07 Mar 2007 20:19:49 +0000
Message-ID: <45EF1E65.6000208@ramsay1.demon.co.uk>
References: <1173045556191-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Wed Mar 07 21:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP2iB-0005ve-5k
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 21:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965624AbXCGUZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 15:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965626AbXCGUZ7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 15:25:59 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:1695 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965624AbXCGUZ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2007 15:25:57 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-34.mail.demon.net with esmtp (Exim 4.42)
	id 1HP2hv-000GkY-FR; Wed, 07 Mar 2007 20:25:56 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1173045556191-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41689>

J. Bruce Fields wrote:
> Sorry for the long silence.  You can also get these by pulling from
> 
> 	git://linux-nfs.org/~bfields/git.git
> 
> if you'd prefer.
> 
> --b.

I've just been reading the user manual (from the 1.5.0 tarball) for the
first time and noticed a few things which might need fixing up.
(Great work on the manual, BTW!)

Unfortunately, I don't have asciidoc or xmlto installed (I'm on Cygwin), so
I can't re-build the documentation to test any changes; and I don't know
how to use asciidoc markup anyway. ;-)

First, most history diagrams appear to be broken; this is due to the "\<lf>"
combination in the diagrams being interpreted as a line continuation! I don't
know what the asciidoc markup should be - \\ perhaps? The following indicates
that there are nine diagrams needing fixup:

    $ grep '\\$' Documentation/user-manual.txt | wc
          9      12     118
    $

In the "Fetching branches from other repositories" section, the content of the
configuration file displayed did not appear correct, given the text above.
In fact, both the url and fetch keys seem to be wrong; I'm assuming something
like the following was intended:

--->8---
@@ -596,8 +596,8 @@ a new stanza:
  $ cat .git/config
  ...
  [remote "linux-nfs"]
-        url = git://linux-nfs.org/~bfields/git.git
-	fetch = +refs/heads/*:refs/remotes/linux-nfs-read/*
+        url = git://linux-nfs.org/pub/nfs-2.6.git
+	fetch = +refs/heads/*:refs/remotes/linux-nfs/*
  ...
  -------------------------------------------------
---8<---

In chapter 4, "How to merge" section, a git pull invocation is demonstrated; I
suspect that a git merge was intended, thus:

--->8---
@@ -1128,7 +1128,7 @@ modified in two different ways in the remote branch and the local
  branch--then you are warned; the output may look something like this:

  -------------------------------------------------
-$ git pull . next
+$ git merge next
  Trying really trivial in-index merge...
  fatal: Merge requires file-level merging
  Nope.
---8<---

Having said that, does the command output need changing also?

In "Checking out an old version of a file", a git show invocation seems
to be missing a ":" between the <commit-ish> and the path, thus:

--->8---
@@ -1376,7 +1376,7 @@ modifying the working directory, you can do that with
  gitlink:git-show[1]:

  -------------------------------------------------
-$ git show HEAD^ path/to/file
+$ git show HEAD^:path/to/file
  -------------------------------------------------

  which will display the given version of the file.
---8<---

I haven't been following all the user-manual patches, so if you have already
fixed these up, sorry for the noise. ;-)

All the best,

Ramsay Jones
