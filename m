From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 09:31:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
References: <428E49DD.406@zytor.com> <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>
 <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188>
 <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com>
 <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com>
 <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 18:47:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DacW8-0004h0-Us
	for gcvg-git@gmane.org; Tue, 24 May 2005 18:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVEXQkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 12:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVEXQg1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 12:36:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:19130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262135AbVEXQaT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 12:30:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OGTjjA002578
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 09:29:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OGTilA004328;
	Tue, 24 May 2005 09:29:44 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Thomas Glanzmann wrote:
> 
> And your script does that:
> 
> 	export GIT_COMMITTER_NAME=roessler
> 	export GIT_COMMITTER_EMAIL=roessler
> 	export GIT_AUTHOR_NAME=roessler
> 	export GIT_AUTHOR_EMAIL=roessler
> 	export GIT_AUTHOR_DATE='1998/06/20 03:53:44'
> 	ln -sf refs/heads/'master' .git/HEAD
> 	git-read-tree -m HEAD
> 	git-checkout-cache -f -u -a
> 	mkdir -p doc
> 	co -p -r1.2.2.1 '/home/cip/adm/sithglan/work/mutt/cvsrepository/doc/Attic/manual.sgml,v' > 'doc/manual.sgml'
> 	git-update-cache --add -- 'doc/manual.sgml'
> 	tree=$(git-write-tree)
> 	cat > .cmitmsg <<EOFMSG
> 	documenting alias-path
> 	EOFMSG
> 	commit=$(cat .cmitmsg | git-commit-tree $tree -p HEAD)
> 	echo $commit > .git/HEAD
> 
> The problem might be that this is the first commit in the branch. But I thought
> it should end up in refs/heads/mutt-0-93.

Yes, you're using the cvs2git from yesterday, which didn't write the new
commit to the right branch. This is part of the branch fixing I've done.

Wait another few minutes and I'll commit my fix the problem with cvsps
branch handling (and I need to escape '$' in <<EOFMSG handling).

		Linus
