From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [1/2 PATCH] git-svn: make multi-init less confusing
Date: Mon, 08 Jan 2007 13:56:07 +0100
Message-ID: <87lkkdr82g.fsf@morpheus.local>
References: <87fyaqvgoz.fsf@morpheus.local> <20070105020158.GA21925@localdomain> <871wmaugh6.fsf@morpheus.local> <m2ejq9trf1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jan 08 13:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3u34-0003xb-7D
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 13:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbXAHM4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 8 Jan 2007 07:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161280AbXAHM4S
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 07:56:18 -0500
Received: from main.gmane.org ([80.91.229.2]:56442 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161279AbXAHM4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 07:56:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H3u2x-0005HL-SQ
	for git@vger.kernel.org; Mon, 08 Jan 2007 13:56:16 +0100
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 13:56:15 +0100
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 13:56:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:iWXKkjIGVV/SHZwrGBhUOBP4G74=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36249>

Seth Falcon <sethfalcon@gmail.com> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>> Now if you could only clarify the documentation of dcommit to explai=
n
>> whether it creates one svn revision per commit in your branch, or if
>> it creates a single svn revision with the full diff, and the
>> documentation would be perfect :-)
>
> dcommit creates one svn rev for each commit listed by:
>
>    git log remotes/git-svn..HEAD
>
> + seth

Ok, so I tried rewriting the documentation.  But I'm still not sure I
understand fully how it works.

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f5f57e8..8c91e78 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -57,15 +57,18 @@ See '<<fetch-args,Additional Fetch Arguments>>' if =
you are interested in
 manually joining branches on commit.
=20
 'dcommit'::
-	Commit all diffs from a specified head directly to the SVN
-	repository, and then rebase or reset (depending on whether or
-	not there is a diff between SVN and head).  It is recommended
-	that you run git-svn fetch and rebase (not pull) your commits
-	against the latest changes in the SVN repository.
-	An optional command-line argument may be specified as an
-	alternative to HEAD.
-	This is advantageous over 'set-tree' (below) because it produces
-	cleaner, more linear history.
+	Commit to the Subversion repository all commits in a branch
+	that are not yet in Subversion.  If no branch name is given,
+	HEAD is used.
+=09
+	After committing, the branch is rebased or reset (depending on
+	whether or not there is a diff between SVN and the branch).
+	It is recommended that you run git-svn fetch and rebase (not
+	pull) your commits against the latest changes in the SVN
+	repository.
+
+	This is advantageous over 'set-tree' (below) because it
+	produces cleaner, more linear history.
=20
 'log'::
 	This should make it easy to look up svn log messages when svn

=46irst of all, I would like to see the 'dcommit' header show that a
branch name can be given, and what else you might want to write there.

Secondly, the second paragraph is not very clear.  What does it mean
that the branch is "rebased or reset"? Against what? And why does it
matter if I have a diff? And does it still work if I'm dcommitting
another branch than HEAD?

I can probably guess the answer to some of these questions, but I
would like to improve the documentation so nobody has to guess.

--=20
David K=C3=A5gedal
