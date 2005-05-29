From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problem with cg-merge
Date: Sun, 29 May 2005 21:48:41 +0200
Message-ID: <1117396121.7072.106.camel@pegasus>
References: <1117379092.7072.90.camel@pegasus>
	 <20050529180742.GA31388@diku.dk> <1117390650.7072.100.camel@pegasus>
	 <20050529184830.GM1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <fonseca@diku.dk>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 21:50:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcTjv-0006Ft-Da
	for gcvg-git@gmane.org; Sun, 29 May 2005 21:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVE2Tso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 15:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVE2Tso
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 15:48:44 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:29114 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261416AbVE2Tsl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 15:48:41 -0400
Received: from pegasus (p5487DF90.dip.t-dialin.net [84.135.223.144])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4TJoPSs022373
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 29 May 2005 21:50:26 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050529184830.GM1036@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > > > I saw that earlier, but I don't have any idea what's wrong here. If I do
> > > > a simple cg-update, I see something like this:
> > > > 
> > > > Tree change: cf1f29d97210d0594dcf5b2a734bdb714de6bf24:89a14a5bd2c880095d5c618a102319bb3dc03da9
> > > > :100755 100755 ceda2c50fc2c2941daa34a57722df251bf892c38 fea239b99d351502d1acb098abd725557f0af202 M      cg-diff
> > > > :100755 100755 cc0c17beef75db41da3ad4ef8983bd7e222ac739 5f0bff77eb2110d52892793e5bef104acde7be32 M      cg-help
> > > > 
> > > > Applying changes...
> > > > Fast-forwarding cf1f29d97210d0594dcf5b2a734bdb714de6bf24 -> 89a14a5bd2c880095d5c618a102319bb3dc03da9
> > > >         on top of cf1f29d97210d0594dcf5b2a734bdb714de6bf24...
> > > > patching file cg-diff
> > > > patching file cg-help
> > > > cg-diff: needs update
> > > > cg-help: needs update
> > > > 
> > > > This is a little bit odd, because if I call "git-diff-cache HEAD" after
> > > > it, I will see that cg-diff and cg-help are modified. After calling
> > > > cg-cancel everything looks fine again.
> > > 
> > > The following change fixes cg-update for me. This is in tree_timewarp().
> > > 
> > > --- 0ca4ae56fa7bbd8d10e2c2791e389bc19977e460/cg-Xlib  (mode:100755)
> > > +++ uncommitted/cg-Xlib  (mode:100755)
> > > @@ -66,7 +66,7 @@
> > >  		# XXX: This may be suboptimal, but it is also non-trivial to keep
> > >  		# the adds/removes properly.  So this is just a quick hack to get it
> > >  		# working without much fuss.
> > > -		cg-diff -r $branch >$patchfile
> > > +		cg-diff >$patchfile
> > >  	fi
> > >  
> > >  	git-read-tree -m "$branch" || die "$branch: bad commit"
> > 
> > this looks better now. Petr, please apply this patch.
> 
> Bah. Well if your imaginary friend in your head told you this is
> obviously just a no-go workaround, (s)he was right for once. You just
> broke cg-admin-uncommit with this one, the real fix is to tell
> tree_timewarp to rollback the tree (or rather rollforth here ;-). This
> way the right branch of this if will be invoked.

I had no idea if the patch was correct or not, but it was working for
me. I also tested your fix for it and it works for me and I am happy
again.

Regards

Marcel


