From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: cg-update with local uncommitted changes
Date: Mon, 30 May 2005 21:19:56 +0200
Message-ID: <1117480796.7072.204.camel@pegasus>
References: <1117463114.7072.185.camel@pegasus>
	 <20050530183932.GB10439@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 21:18:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcplU-000246-0o
	for gcvg-git@gmane.org; Mon, 30 May 2005 21:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVE3TT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 15:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVE3TT7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 15:19:59 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:5563 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261712AbVE3TTy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 15:19:54 -0400
Received: from pegasus (p5487D5D5.dip.t-dialin.net [84.135.213.213])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4UJLfSs002827
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 30 May 2005 21:21:42 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050530183932.GB10439@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.85.1/899/Mon May 30 08:57:01 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > when doing a cg-update and I have local uncommitted changes it fails
> > with the "... needs update" message. From some previous posts on the
> > mailing list I got the impression that it is possible to pull updates
> > into the local repository with changed files. At the moment I am using
> > the following sequence:
> > 
> > 	cg-diff > patch
> > 	cg-cancel
> > 	cg-update origin
> > 	cat patch | patch -p1
> > 	rm patch
> > 
> > The problem with this sequence is when I have added or removed files
> > from my repository. This needs a lot of manual fixing.
> > 
> > With Bitkeeper it was possible to pull changes as long as they don't
> > affect local uncommitted files.
> > 
> > Any ideas on how to implement or if it exists on how to use it?
> 
> does it really fail? "... needs update" is not an error but something
> between informative and warning message. (I've just committed a change
> which silences it in this case.)
> 
> If the update did indeed fail, could you show the complete output,
> please?

I used the latest cg-update on a test repository and now it works, but I
found odd cases when I have files added/deleted that are not committed
yet. For the added case I saw this:

Warning: uncommitted local changes, trying to bring them forward
The next patch would create the file test.c,
which already exists!  Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file test.c.rej
Adding file test.c

I also think that it would be great if we cancel the merge if the local
changes conflict with the files in the merge. This is how Bitkeeper does
it and I think it is the only safe way, because if something fails or
rejects we may destroy the local changes.

Regards

Marcel


