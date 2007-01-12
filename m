From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Add contrib/stg-gitk: helper script to run gitk
Date: Fri, 12 Jan 2007 23:47:33 +0100
Message-ID: <20070112224733.GA9761@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth> <b0943d9e0701090202v7951076cg7c86c0f5499c7d60@mail.gmail.com> <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701101547v5e18bdf8xcc34cf78ea5f1f9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 12 23:47:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5VBU-0006ti-L9
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 23:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbXALWrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 17:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbXALWrh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 17:47:37 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:54304 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161130AbXALWrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 17:47:36 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id BFF1227A94;
	Fri, 12 Jan 2007 23:47:34 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 02B7A2015; Fri, 12 Jan 2007 23:47:33 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701101547v5e18bdf8xcc34cf78ea5f1f9f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36721>

On Wed, Jan 10, 2007 at 11:47:33PM +0000, Catalin Marinas wrote:
> On 09/01/07, Yann Dirson <ydirson@altern.org> wrote:
> >On Tue, Jan 09, 2007 at 10:02:06AM +0000, Catalin Marinas wrote:
> >> There is 'stg series --graphical' that invokes gitk.
> >
> >For some reason I did not look for this functionality in that place :)
> >
> >But it is a bit different, in that unapplied patches appear detached
> >from the whole history.  Possibly out of personal taste, I do not find
> >this very useful, and prefer to see them as "gitk --all" shows them.
> 
> I've never tried 'gitk --all' but I'm OK with changing the way
> --graphical option displays the patches.

Indeed "stg series -g" may differ too much from "stg-gitk" to plug the
functionnality at this place: "stg series" is a command acting on one
stack, whereas stg-gitk is a repository-wide command, allowing to draw
several stacks, and also includes anything below stack base, which
looks also out of the scope of "stg series -g".  Maybe a new command
is called for - possibly as something like
"stg repo graph [<branch>...]" ?


> >That makes me think that such command names like "show" are a bit too
> >general: stgit uses "show" for patches, but nothing says it is for a
> >patch and not a series.
> 
> This was initially a re-implementation of 'git show' that was able to
> understand patch names (you can also give any commit id as argument).
> I later extended it to accept patch ranges.
> 
> >Also, when presenting GIT/StGIT to co-workers, I found them to be
> >confused by eg. "stg push" and "stg commit" having different semantics
> >than "git push" and "git commit".
> 
> As I said in a different e-mail, push/pop were the command names used
> by quilt. I agree that they are confusing. Maybe we could change
> commit/uncommit to store/unstore or something else (but I would like
> to keep push/pop).

OK, the command names were borrowed from tools which provide a
fraction of the functionnality stgit (not exactly so in the case of
GIT, OK ;).  That makes it easy for people used to those commands that
served as inspiration to the stgit ones, I know that (I used quilt
before stgit).  But I do feel that having a more consistent command
set would help - remember quilt has no idea of branches, multiple
repositories and history, stgit is in many ways a very different beast :)

> You can use the bash aliases if you want (i.e.  'alias
> stg-ppush="stg push"').

The argument is not about *me*, I can happily use "stg push".  It is
about smoothing the learning curve by providing a command set that
would be easier to dive in.  One where, for example, the user wanting
to do some action on a patch, but not remembering the exact command,
could confidently use bash completion with "stg patch <TAB>" and get
the list of patch commands.  That would be easier than having to "stg
--help" and find the command in the full list.

And then, legacy commands like "stg push" would be better implemented
as stgit aliases, since an "stg-push" shell alias as replacement would
break scripts.


> I don't like the idea of command aliases that much, it looks like
> unneeded complexity.

There are already aliases in GIT itself, they are quite simple to
understand, and would probably require very little code in python.
I'll have a look at that, unless you would veto integration of such a
patch.

Best regards,
-- 
Yann.
