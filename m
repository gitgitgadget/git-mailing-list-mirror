From: Eric Wong <normalperson@yhbt.net>
Subject: [RFH] git-svn documentation [was Re: git-svn and u-boot broken]
Date: Mon, 16 Oct 2006 11:31:02 -0700
Message-ID: <20061016183101.GL27128@hand.yhbt.net>
References: <012b01c6f0a6$a1a636e0$1267a8c0@Jocke> <20061016034736.GA8782@localdomain> <453359A2.5090704@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 20:31:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZXF1-000149-Uq
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 20:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422790AbWJPSbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWJPSbG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 14:31:06 -0400
Received: from hand.yhbt.net ([66.150.188.102]:27549 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422790AbWJPSbE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 14:31:04 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 381407DC08D; Mon, 16 Oct 2006 11:31:02 -0700 (PDT)
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Content-Disposition: inline
In-Reply-To: <453359A2.5090704@transmode.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28982>

Joakim Tjernlund <Joakim.Tjernlund@transmode.se> wrote:
> Eric Wong wrote:
> > I would do something like this:
> > 
> > ... (same stuff as above before with svn setup...)
> > git clone $ORG_REPO $GIT_REPO
> > cd $GIT_REPO
> > git-svn init "$REPO"/trunk
> > git-svn fetch
> > 
> > # sync the SVN repo with initial-uboot
> > # this will just commit a snapshot, without history, which I assume
> > # is what you want.
> > git-branch initial-uboot f5e0d03970409feb3c77ab0107d5dece6b7d45c9
> > git-svn commit initial-uboot
> > git checkout -b svn-branch remotes/git-svn
> > git-pull . tmcu2
> > 
> > # this should work assuming the path from initial-uboot..tmcu2 is linear
> > # use gitk initial-uboot..tmcu2 to check
> > git-svn dcommit
> 
> Great! This was exactly what I wanted, thanks. I never realized that one should
> do git-svn commit initial-uboot to get that single commit.
> I also replaced git-svn dcommit with git-svn commit remotes/git-svn..svn-branch
> as I don't have that version yet.
> 
> You should add this as an example I think.
> 
> Can I ask for an example that used multi-init and multi-fetch? I tried, but
> could not make it work.

git-svn multi-init https://svn.musicpd.org/mpd -T trunk -t tags -b branches
git-svn multi-fetch

In the latest git-svn (should be in 1.4.3), you can re-run 'git-svn
multi-init' with no arguments to discover new tags+branches.

Anybody willing to supply patches for better documentation?  I'll be
quite busy with other projects the next two weeks, asciidoc is quite
slow for me; but I'd like to have better docs for git-svn in 1.4.3.

-- 
Eric Wong
