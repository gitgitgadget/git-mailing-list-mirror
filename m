From: "Zorba" <cr@altmore.co.uk>
Subject: Re: getting started, happy with cmd line on windows [Scanned]
Date: Fri, 26 Dec 2008 23:13:20 -0000
Message-ID: <gj3of4$pr3$3@ger.gmane.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D07@ALTMORE-SVR.altmore.local> <495508B9.7070103@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 00:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGLth-0003b3-W6
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 00:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbYLZXNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 18:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbYLZXNu
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 18:13:50 -0500
Received: from main.gmane.org ([80.91.229.2]:45336 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbYLZXNt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 18:13:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LGLsJ-00042O-St
	for git@vger.kernel.org; Fri, 26 Dec 2008 23:13:48 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 23:13:47 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 23:13:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103960>

> I then deleted all files from the working directory, so I can pull out
> ONLY the ones in version A.
> I tried both fetch and checkout - but nothing was copied into working
> dir How do I do this ?

git treats deleted files just like edited files: as having been changed
in preparation for the next commit.  You can get back all of the tracked
files using this command:

$ git reset --hard

It undoes _all_ changes: tracked edited files will be reverted to their
in-repository state, deleted files created again.  You can also check
out individual files like this:

$ git checkout ABC.txt

If you just want to get rid of untracked files, you'd use the command
"git clean".

In general, if you switch your work tree from one revision to another
(git checkout), git tries to minimize the I/O needed.  Files that are
the same in both aren't touched.

>>>>>>>>>>>>>>>>>>>

Hi Rene,

Thanks for taking the time.

My workflow is such that I inherit projects that are hard to debug and I 
need to hack around a lot changing a lot of files to output tracking msgs 
just to learn the code's functionality (e,g, PHP on a webserver), but these 
changes I never intend to keep. After learning the code, I want to go back 
to a "last known good". I.e. a previous stable version and start making 
proper changes.

In other SCMs, there was a way to "discard" all local changes, after the 
hacking phase, without EVER having had to commit.

For a while it seemed like you were telling me I had to COMMIT my hacked 
code (against all my instincts :-), and THEN rollback ($ git reset --hard).

Now, I went back and read the manual pages for git-checkout and think I see 
how to do it....

$ <import code>
$ git init
$ git commit
$ git tag versionA <commitID>
$ hack hack hack
...
now ready to start coding, want "last known good"
$ rm *.*
$ git checkout versionA .

This worked fine when versionA had only files and no dirs - but will it work 
ok still if versionA is a proper tree ?
(more of a unix question I suppose - will "." suffice as the path ?) 
