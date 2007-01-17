From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Wed, 17 Jan 2007 22:30:04 +0100
Message-ID: <20070117213004.GI9761@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 17 22:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7IMc-0000lM-Ld
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 22:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXAQVaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 16:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbXAQVaV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 16:30:21 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:41506 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbXAQVaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 16:30:20 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id CD5647DAF;
	Wed, 17 Jan 2007 22:30:18 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 7B1BC1F073; Wed, 17 Jan 2007 22:30:04 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37041>

On Tue, Jan 16, 2007 at 12:39:58AM +0100, Yann Dirson wrote:
> > >I would be of the opinion to stop calling "git pull" entirely, and use
> > >"git fetch and the git.move_branch show above.  Unless I hear about
> > >better ideas, my next patch set will be along those lines.
> > 
> > Or replace the 'git pull' in the config file with 'git fetch && git
> > reset --hard MERGE_HEAD'? I might be wrong though as I almost never
> > use git directly :-).
> 
> Hm.  Probably rather FETCH_HEAD.  Will have to look at that - but see
> above.
[...]
> Note that I did not think of using FETCH_HEAD, I was rather thinking
> of using information about the parent branch (which I had worked on
> recently), with the idea that this info probably belongs to
> branch.<name>.merge - which would complement Pavel's 87c69539 about
> branch.<name>.remote.

Unfortunately, using "reset('FETCH_HEAD')" or similar would not work.
Eg, in the case we have cloned an stgit branch as "origin", and the
revspec does not have a "+", git-fetch after a patch refresh in the
remote repo still updates FETCH_HEAD even if it notices it cannot then
fast-forward.  With this we would end up with the "origin" branch not
being changed, and our stack still being rebased as if we had a "+"
refspec, which would be quite inconsistent.

Best regards,
-- 
Yann.
