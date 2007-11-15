From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 15 Nov 2007 00:49:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711150038020.4362@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:50:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsSvh-0007RR-7l
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 01:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbXKOAtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 19:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbXKOAtp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 19:49:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:45441 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755155AbXKOAto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 19:49:44 -0500
Received: (qmail invoked by alias); 15 Nov 2007 00:49:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 15 Nov 2007 01:49:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Q1Ohr8gQQVAdRelPbgVJWF0U/l06Fj4CBiJ/+Cl
	mTLjADwNICezmC
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65035>

Hi,

On Wed, 14 Nov 2007, Junio C Hamano wrote:

> ----------------------------------------------------------------
> [Approaching 'next']
> 
> * kh/commit (Wed Nov 14 10:31:53 2007 -0500) 13 commits
>  - builtin-commit: Clean up an unused variable and a debug fprintf().
>  - Call refresh_cache() when updating the user index for --only
>    commits.
>  - builtin-commit: Add newline when showing which commit was created
>  - builtin-commit: resurrect behavior for multiple -m options
>  - builtin-commit --s: add a newline if the last line was not a S-o-b
>  - builtin-commit: fix --signoff
>  - git status: show relative paths when run in a subdirectory
>  - builtin-commit: Refresh cache after adding files.
>  - builtin-commit: fix reflog message generation
>  - launch_editor(): read the file, even when EDITOR=:
>  - Port git commit to C.
>  - Export launch_editor() and make it accept ':' as a no-op editor.
>  - Add testcase for amending and fixing author in git commit.
> 
> Dscho fixed a few obvious glitches, but indicated he has a
> handful more issues with the series.  I have been hoping that
> this series should be in "testable" shape now.  Will need to
> look at it again.

Well, it _is_ in testable shape.  My working setup is using builtin-commit 
since a week.  One glitch is serious: "git add a1 && git commit b1" will 
commit a1, too.

Another glitch is only mildly annoying to me (but I have not investigated 
in detail yet): when you commit new files in a subsubdirectory, no summary 
"created file" is printed for them.

Other than that, I am pretty happy with it, and the other issues I listed 
should be easily fixable.

> ----------------------------------------------------------------
> [Stalled]
> 
> * mh/rebase-skip-hard (Thu Nov 8 08:03:06 2007 +0100) 1 commit
>  - Do git reset --hard HEAD when using git rebase --skip
> 
> Some people on the list may find this debatable.  Opinions?

I run with it, and like it.  Sometimes when I rebase to 'next', a patch 
has subtle differences compared to the patch which was applied, and then I 
see in the conflict handling that it was applied already.  So I do the 
obvious: I --skip, and it Just Works.

But you _can_ mistakenly say "--skip".  That's why I pushed for the 
detached HEAD when rebasing.

> * cr/tag-options (Fri Nov 9 14:42:56 2007 +0100) 1 commit
>  - Make builtin-tag.c use parse_options.
> 
> This changes the handling of multiple -m options without much good 
> reason.  It should be a simple fix, once we know what we want.  I think 
> the existing behaviour of refusing multiple -m is probably the most sane 
> at this point.

Agree.

> * nd/maint-work-tree-fix (Sat Nov 3 20:18:06 2007 +0700) 1 commit
>  + Add missing inside_work_tree setting in setup_git_directory_gently
> 
> There was an additional patch, which still had issues Dscho pointed out.  
> Waiting for refinements.

This might be something pretty painful, though, speaking from my own 
experience with the work-tree stuff.

> ----------------------------------------------------------------
> [Others]
> 
> * jc/branch-contains (Wed Nov 7 14:58:09 2007 -0800) 1 commit
>  - git-branch --with=commit
> 
> I did this just for my own fun.  --contains might be more
> consistent with git-describe but --with is shorter to type ;-)

--with might confuse people who know that you can use "git branch" to 
create branches, but do not quite know how.

Besides, "--con" would be enough, and you can always add '-c'.  Or use 
completions.

Ciao,
Dscho
