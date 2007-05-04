From: Yann Dirson <ydirson@altern.org>
Subject: Re: using stgit/guilt for public branches
Date: Sat, 5 May 2007 01:12:26 +0200
Message-ID: <20070504231225.GD19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070425122048.GD1624@mellanox.co.il> <20070425191838.GA6267@filer.fsl.cs.sunysb.edu> <200704252337.05851.robin.rosenberg.lists@dewire.com> <20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat May 05 01:13:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk6xa-0004i4-VG
	for gcvg-git@gmane.org; Sat, 05 May 2007 01:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161489AbXEDXNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 19:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S376130AbXEDXNH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 19:13:07 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60844 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161489AbXEDXNG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 19:13:06 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2CD6A5DFCA;
	Sat,  5 May 2007 01:13:05 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1ABF13004; Sat,  5 May 2007 01:12:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46227>

On Thu, May 03, 2007 at 10:58:36PM +0200, Yann Dirson wrote:
> As for publishing, I use the following config entries to publish my
> own stack of patches to stgit.  You can see at
> http://repo.or.cz/w/stgit/ydirson.git that gitweb shows pretty clearly
> the structure of the stack (even though things could surely be made
> better).

Let's make things even more fun: I have now moved a couple of patches
(testsuite cases to demonstrate bugs still to be fixed) to a new stack
so they don't get pulled by error.  This stack itself is forked off my
master stack, and I just have to "stg pull" to get it rebased to the
new master head (requires stgit head, not in 0.12*):

[branch "bugs.stgit"]
        pull-policy = rebase
        parentbranch = master

> I use "git push -f" to publish - maybe the "+" refspec syntax would
> work with push, I'll try it next time :)

It indeed works as expected, so the final syntax is as follows, so
"git push orcz" is now sufficient to publish everything, and you can
now fork your own stack off my remote "bugs" stack, which itself
forked off my "master" stack - enjoy :)

[remote "orcz"]
        url = git+ssh://ydirson@repo.or.cz/srv/git/stgit/ydirson.git
        fetch = +refs/heads/*:refs/remotes/orcz/*

        push = +refs/heads/master:refs/heads/master
        push = +refs/patches/master/*:refs/patches/master/*

        push = +refs/heads/bugs:refs/heads/bugs
        push = +refs/patches/bugs/*:refs/patches/bugs/*

Best regards,
-- 
Yann.
