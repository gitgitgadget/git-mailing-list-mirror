From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers
	on active trees]
Date: Mon, 30 Mar 2009 08:32:45 -0700
Message-ID: <20090330153245.GD23521@spearce.org>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: P Baker <me@retrodict.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 17:34:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoJVH-0002LI-AV
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 17:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbZC3Pcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 11:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756089AbZC3Pcs
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 11:32:48 -0400
Received: from george.spearce.org ([209.20.77.23]:41094 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157AbZC3Pcr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 11:32:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6202938211; Mon, 30 Mar 2009 15:32:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115164>

Hi!  As someone who has coded around git submodule by creating "repo"
for Android, I'm certainly interested in git submodule improvements,
so this is a great idea for a GSoC project.  I have some comments
below that may help improve your proposal before you submit it.

P Baker <me@retrodict.com> wrote:
> Abstract:
> 	This project focuses on upgrading git-submodule to manage code
> created in external projects in ways that allow users to safely branch
> and merge that code without loss of data or routine merge conflicts.
> This will incorporate some changes made on the ???pu??? branch, but will
> also include making substantial changes to git-submodule underlying
> code.
...
> As opposed to ???remotes,??? which also incorporate external code into a
> project,

I'm not sure what you mean by that.  Typically a "remote" in Git is
thought to be a configuration that says where to download a fork of
this project from.  By default you get one remote, called "origin",
which is where you initially cloned your fork from, but you can add
many more, such as other developers you frequently collaborate with.

This is quite different from the problem that submodule tries
to address, as its dealing with forks of of the *same* project.
But a submodule is trying to point to forks of *other* projects,
whose histories are (possibly) unrelated to this project's history.

> The tentative timeline is:
> 
> End of May ??? Conclusively finish the public discussion regarding where
> git-submodules needs to go
> Beginning of June ??? Produce final specifications (including method stubs)
> Middle of July ??? Finish active code and test development
> End of July ??? Merge code into production release, fix public submitted bugs
> Middle of August ??? Prepare code for final release and finish
> user-facing documentation

IMHO, this is too vague.  *What exactly* are the features you want
to add to git submodule?  Break this down by features, not by phases
of coding.

Further, you spend roughly a month writing method stubs.
My experience with such development practices is that you will
get frustrated by not having the code working, get bored with it,
and walk away.  Or at best, you'll be able to stub it all out,
but will need to redo most of the stubs because you find later on
while writing the implementation code that you need to pass data
through that you didn't initially anticipate.

Also, we very much prefer Git patches to update the documentation
at the same time that the code changes.  Maybe its done in the same
patch, if the code+doc update are relatively small, or maybe its done
in two patches in the same series (code change, then doc update),
but the general guideline is that both code and documentation should
be updated at roughly the same time (e.g. same day for Junio when
he merges the series down to master).  This way the documentation
doesn't stray too far from the code its describing.

> A few specific changes that this project will likely include are:
> 
> *use .git instead of .gitmodules
> *move objects of submodules into .git/ directory
> *git submodule update --init should initialize nested levels of submodules
> *protect changes in local submodules when doing ???git submodule update???

As I said above, I'd like to see this described in the timeline
better, each of these could be done independently, so you could work
on one item try to get it completed, tested, documented, and merged
into Junio's tree, and then start the next item.  At worst at the
end of the summer you'll have a fraction of these done, merged,
and available for users, which is better than trying to do it all
and failing to get none merged.

I'd like to know more about each of these items, and less about
the general reasoning of where you got these feature ideas from.
What exactly are you talking about changing, and why?  I don't need
to see detailed code at this stage, but I'd like a better description
of the user-visible changes that each bullet point might cause,
and why you feel this change is better than what we have today.
 
-- 
Shawn.
