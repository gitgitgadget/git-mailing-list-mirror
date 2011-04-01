From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2011, #06; Thu, 31)
Date: Fri, 1 Apr 2011 11:26:23 -0400
Message-ID: <20110401152623.GA4553@sigill.intra.peff.net>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 17:26:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5gF6-0001kv-1w
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 17:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757853Ab1DAP00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 11:26:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54828
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757795Ab1DAP0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 11:26:25 -0400
Received: (qmail 11332 invoked by uid 107); 1 Apr 2011 15:27:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 11:27:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 11:26:23 -0400
Content-Disposition: inline
In-Reply-To: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170594>

On Thu, Mar 31, 2011 at 03:26:31PM -0700, Junio C Hamano wrote:

> * jk/maint-remote-mirror-safer (2011-03-30) 3 commits
>  - remote: deprecate --mirror
>  - remote: separate the concept of push and fetch mirrors
>  - remote: disallow some nonsensical option combinations
> 
> * jk/notes-ui-updates (2011-03-30) 7 commits
>  - log/pretty-options: Document --[no-]notes and deprecate old notes options
>  - revision.c: make --no-notes reset --notes list
>  - revision.c: support --notes command-line option
>  - notes: refactor display notes default handling
>  - notes: refactor display notes extra refs field
>  - revision.c: refactor notes ref expansion
>  - notes: make expand_notes_ref globally accessible

Both probably post-1.7.5 material. I am of course tempted to get new
options in place ASAP (since the sooner they are in, the sooner script
writers can say "they are in long enough" and start using them).  But I
don't think either is critical.

> * jk/edit-notes-in-commit-log (2011-03-07) 2 commits
>  - [wip] commit: allow editing notes in commit message editor
>  - notes: make expand_notes_ref globally accessible

You may want to drop this for now. The bottom one is in
jk/notes-ui-updates, which hopefully will go to master soon after 1.7.5,
and the top one is going to be rewritten.

> * jk/maint-merge-rename-create (2011-03-25) 3 commits
>   (merged to 'next' on 2011-03-31 at b9bc9f1)
>  + merge: turn on rewrite detection
>  + merge: handle renames with replacement content
>  + t3030: fix accidental success in symlink rename
> 
> May merge before rc1, but it is Ok to wait.

I would hold off on this. I _think_ it's fine, but I would really prefer
for it to get more exposure in 'next' to shake out any bugs.

> * jk/pull-into-empty (2011-03-25) 2 commits
>   (merged to 'next' on 2011-03-31 at d4dd598)
>  + pull: do not clobber untracked files on initial pull
>  + merge: merge unborn index before setting ref
> 
> This is low impact, isolated, and has no risk of major regression. Will
> merge before rc1.

Agreed.

> * jc/add-u-migration (2011-03-22) 3 commits
>  - add: make "add -u/-A" update full tree without pathspec (step 3)
>  - add: make "add -u/-A" update full tree without pathspec (step 2)
>   (merged to 'next' on 2011-03-31 at 962e058)
>  + add: make "add -u/-A" update full tree without pathspec
> 
> The bottom one is a necessary first step toward the UI clean-up planned
> for 1.8.0 which we discussed in length in the earlier part of the cycle;
> the change is low impact, isolated, and has no risk of breaking the system
> as a whole, but I would wait until the ":/" magic pathspec materializes,
> as the advice message would have to become different, and the way to get
> more stable semantics will become more direct.

I have been meaning to look closer at this. Were you wanting to get the
first stage of the transition into 1.7.5?

> * jk/progress-with-pager (2011-03-24) 4 commits
>  - diff: turn on rename detection progress reporting
>  - show: turn on rename detection progress reporting
>  - progress: use pager's original_stderr if available
>  - pager: save the original stderr when redirecting to pager
> 
> Will cook until 1.7.5 final.

I'm not sure if this whole thing should be scrapped. There are potential
problems with starting a pager that wants to grab the whole screen
(i.e., not less). Maybe it would be enough to have a pager.noprogress
option for people who use such a pager.

-Peff
