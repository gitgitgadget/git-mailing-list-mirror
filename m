From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Tue, 28 Feb 2006 22:51:38 -0800
Message-ID: <20060301065138.GC21684@hand.yhbt.net>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227184641.GA21684@hand.yhbt.net> <20060227185557.GA32142@delft.aura.cs.cmu.edu> <20060227192422.GB9518@hand.yhbt.net> <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com> <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 07:52:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FELBe-0007xQ-PS
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 07:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWCAGvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 01:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWCAGvk
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 01:51:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:11717 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932514AbWCAGvj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 01:51:39 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 429F07DC022; Tue, 28 Feb 2006 22:51:38 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16963>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Tue, 28 Feb 2006, Martin Langhoff wrote:
> > 
> > git-svn-HEAD "moves" so it's really a bad idea to have it as a tag.
> > Nothing within core git prevents it from moving, but I think that
> > porcelains will start breaking. Tags and heads are the same thing,
> > except that heads are expected to change (specifically, to move
> > forward), and tags are expected to stand still.
> <snipped>
> Using a "refs/remotes" subdirectory makes tons of sense for something like 
> this. Or something even more specific, like "refs/svn-tracking/". Git 
> shouldn't care - all the tools _should_ work fine with any subdirectory 
> structure.

Git tools only work as long as the 'refs/{remotes,svn-tracking,...}/'
prefix is specified.  git-svn-HEAD (or any $GIT_SVN_ID-HEAD) does get
specified from the command-line quite often:
	
	git checkout -b mine git-svn-HEAD
	git-log git-svn-HEAD..head
	git-svn commit git-svn-HEAD..mine
	git-log mine..git-svn-HEAD

Should rev-parse be taught to be less strict and look for basenames
that can't be found in heads/ and tags/ in other directories?

-- 
Eric Wong
