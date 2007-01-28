From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Sun, 28 Jan 2007 11:25:52 +0100
Message-ID: <20070128102552.GF4036@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com> <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net> <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com> <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com> <20070128043312.GG9897@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 28 11:27:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB7G9-0006Q2-D3
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 11:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbXA1K1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 05:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbXA1K1O
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 05:27:14 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:51715 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932522AbXA1K1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 05:27:13 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 46FFD543B;
	Sun, 28 Jan 2007 11:27:12 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 4DFC01F08A; Sun, 28 Jan 2007 11:25:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070128043312.GG9897@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38031>

On Sat, Jan 27, 2007 at 11:33:12PM -0500, Theodore Tso wrote:
> On Mon, Jan 22, 2007 at 10:58:41PM +0000, Catalin Marinas wrote:
> > StGIT stacks are a series of volatile commits (commits) at the top of
> > a branch. The idea when I started writing this tool was that a series
> > of applied patches would lead to the head of the current branch. The
> > branch and stack are tightly coupled and you cannot simply change the
> > parent branch the stack is based on (not from a technical point but
> > rather from conception one).
> 
> Well, a typical use case for me is:
> 
> 	stg branch master
> 	git pull .
> 	stg branch 2.6.20-rc5
> 	stg export -d /tmp/temp-stack
> 	stg branch master
> 	stg branch -C 2.6.20-rc6

You mean lowercase "-c", right ?

> 	stg import -s /tmp/temp-stack/series 
> 
> That's because I want to keep the original patch series for
> 2.6.20-rc5, but I also want rebase the patch set to 2.6.20-rc6.  Is
> there a better way of doing this?  

Yes.  First, you can clone your stack:

stgit$ stg branch --clone copy
Cloning current branch to "copy"... done
stgit$ stg branch -l
Available branches:
> s     copy    | clone of "master"
  s     master  | 
        origin  | 

And then you can rebase the clone, either with "stg rebase" (in stg
HEAD only), or use the small tip described at
http://git.or.cz/gitwiki/GitTips#head-8e71c3bdda0c372b79e33f5a3fedaf22c4c6f944

Best regards,
-- 
Yann.
