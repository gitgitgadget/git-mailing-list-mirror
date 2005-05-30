From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: cg-update with local uncommitted changes
Date: Mon, 30 May 2005 21:27:24 +0200
Message-ID: <1117481244.7072.209.camel@pegasus>
References: <1117463114.7072.185.camel@pegasus>
	 <20050530183932.GB10439@pasky.ji.cz>  <1117480796.7072.204.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 21:30:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcpss-0003KP-13
	for gcvg-git@gmane.org; Mon, 30 May 2005 21:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVE3T1j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 15:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVE3T1j
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 15:27:39 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:6331 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261647AbVE3T1X
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 15:27:23 -0400
Received: from pegasus (p5487D5D5.dip.t-dialin.net [84.135.213.213])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4UJTASs002854
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 30 May 2005 21:29:11 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <1117480796.7072.204.camel@pegasus>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.85.1/899/Mon May 30 08:57:01 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > > when doing a cg-update and I have local uncommitted changes it fails
> > > with the "... needs update" message. From some previous posts on the
> > > mailing list I got the impression that it is possible to pull updates
> > > into the local repository with changed files. At the moment I am using
> > > the following sequence:
> > > 
> > > 	cg-diff > patch
> > > 	cg-cancel
> > > 	cg-update origin
> > > 	cat patch | patch -p1
> > > 	rm patch
> > > 
> > > The problem with this sequence is when I have added or removed files
> > > from my repository. This needs a lot of manual fixing.
> > > 
> > > With Bitkeeper it was possible to pull changes as long as they don't
> > > affect local uncommitted files.
> > > 
> > > Any ideas on how to implement or if it exists on how to use it?
> > 
> > does it really fail? "... needs update" is not an error but something
> > between informative and warning message. (I've just committed a change
> > which silences it in this case.)
> > 
> > If the update did indeed fail, could you show the complete output,
> > please?
> 
> I used the latest cg-update on a test repository and now it works

let me be more specific. It only works in the fast forward case. If we
actually must merge the trees, because I have local committed changes
and not committed changes, I see this:

link 74966c42ddd874192c318acfc5f013e56c50606a
link b27ddcd47e293557e0605b98b2a1e8429035cdc5
link 568ad7814e266f84b4ac28c15a0cadfb2fdb6c80
Tree change: f345b0a066572206aac4a4f9a57d746e213b6bff:74966c42ddd874192c318acfc5f013e56c50606a
:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 568ad7814e266f84b4ac28c15a0cadfb2fdb6c80 M      README

Applying changes...
usage.c: needs update
cg-merge: merge blocked: local changes

I changed the README in test1 repository and committed it. Then I
changed Makefile in test2 repository and committed it. After that I
modified usage.c and left it uncommitted. Then I pulled in the README
change from test1 repository.

Regards

Marcel


