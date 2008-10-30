From: Sam Vilain <sam@vilain.net>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 11:00:26 -0700
Message-ID: <1225389626.19891.35.camel@maia.lan>
References: <18696.32778.842933.486171@lisa.zopyra.com>
	 <1225343538.10803.9.camel@maia.lan>
	 <18697.41702.241183.408377@lisa.zopyra.com>
	 <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se>
	 <2008-10-30-14-52-52+trackit+sam@rfc1149.net> <4909BF58.9010500@op5.se>
	 <2008-10-30-15-23-16+trackit+sam@rfc1149.net>
	 <20081030144107.GE24098@artemis.corp>
	 <2008-10-30-15-56-34+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:02:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvbqD-0008MV-8s
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 19:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbYJ3SAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 14:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbYJ3SAj
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 14:00:39 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:56093 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbYJ3SAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 14:00:39 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id E677A21D1EE; Fri, 31 Oct 2008 07:00:37 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 7286921C610;
	Fri, 31 Oct 2008 07:00:28 +1300 (NZDT)
In-Reply-To: <2008-10-30-15-56-34+trackit+sam@rfc1149.net>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99513>

On Thu, 2008-10-30 at 15:56 +0100, Samuel Tardieu wrote:
> * Pierre Habouzit <madcoder@debian.org> [2008-10-30 15:41:07 +0100]
> 
> | On Thu, Oct 30, 2008 at 02:23:16PM +0000, Samuel Tardieu wrote:
> | > I think it would be better to have :
> | > 
> | >   git push                <= push the current branch
> | >   git push --all          <= push all matching refs
> | >   git push --all --create <= push all matching refs, create if needed
> | > 
> | > The latest command is probably used so rarely (compared to the others)
> | > that it wouldn't be a problem to make it longer. Of course, if a
> | > refspec is given explicitely, it should be honored and remote refs
> | > created if needed.
> | 
> | Fwiw I'm in favor of that, and it was what I advocated at the time.
> | 
> | Though I think than as soon as you add an explicit remote name, like:
> | git push origin, pushing all matched references makes sense. Which is
> | also what I advocated at the time.
> 
> Indeed, it makes sense. We could then have:
> 
>   git push                 <= push the current branch on default remote
>                               (which is, at least in my case, the most
>                                frequent use I want to make of "git push",
>                                on all the projects [work or volunteer]
>                                I work on)


>   git push remote          <= push all matching refs on named remote

I think that 'git push origin' should be the same as 'git push'; so,
'git push remote' would then just push the current head to the tracking
branch of that remote.  This exposes another issue with the current
method of configuring the tracking branch, which is that only one remote
and branch may be configured for each local branch.  In reality, someone
might be pushing and pulling from multiple remotes; expecting them to
keep naming the current branch all the time seems arduous. 

I think if you want matching refs to be pushed, say so:

  git push remote --matching

>   git push --all [remote]  <= push and create all refs on remote (or default)
