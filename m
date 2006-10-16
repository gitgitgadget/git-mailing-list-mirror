From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: git-svn and u-boot broken.
Date: Mon, 16 Oct 2006 12:06:26 +0200
Message-ID: <453359A2.5090704@transmode.se>
References: <012b01c6f0a6$a1a636e0$1267a8c0@Jocke> <20061016034736.GA8782@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 12:07:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZPN9-0005T0-O9
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 12:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWJPKG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 06:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWJPKG6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 06:06:58 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:7129
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1030340AbWJPKG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 06:06:57 -0400
Received: from [192.168.1.15] ([192.168.1.15]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 16 Oct 2006 12:06:26 +0200
User-Agent: Thunderbird 1.5.0.4 (X11/20060611)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20061016034736.GA8782@localdomain>
X-OriginalArrivalTime: 16 Oct 2006 10:06:26.0078 (UTC) FILETIME=[BDAC23E0:01C6F10A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28955>

Eric Wong wrote:
[SNIP]
> 
> Using -q suppresses potentially useful information.  I wouldn't use
> it if you're not sure about what you're doing.

OK.

> 
> I would do something like this:
> 
> ... (same stuff as above before with svn setup...)
> git clone $ORG_REPO $GIT_REPO
> cd $GIT_REPO
> git-svn init "$REPO"/trunk
> git-svn fetch
> 
> # sync the SVN repo with initial-uboot
> # this will just commit a snapshot, without history, which I assume
> # is what you want.
> git-branch initial-uboot f5e0d03970409feb3c77ab0107d5dece6b7d45c9
> git-svn commit initial-uboot
> git checkout -b svn-branch remotes/git-svn
> git-pull . tmcu2
> 
> # this should work assuming the path from initial-uboot..tmcu2 is linear
> # use gitk initial-uboot..tmcu2 to check
> git-svn dcommit

Great! This was exactly what I wanted, thanks. I never realized that one should
do git-svn commit initial-uboot to get that single commit.
I also replaced git-svn dcommit with git-svn commit remotes/git-svn..svn-branch
as I don't have that version yet.

You should add this as an example I think.

Can I ask for an example that used multi-init and multi-fetch? I tried, but
could not make it work.

> 
> Also, git-svn is really designed for individual developers who prefer to
> use git, but need to interact with project that already uses SVN.
> u-boot already uses git, so I don't see why you'd need git-svn :)

Yes, but the thing is that the rest of our product is svn based including
the build env. So I have to supply a SVN tree for build purposes and if someone
else has to do a minor fix I can't ask him to learn git first :(

 jcoke
