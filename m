From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 26 Sep 2007 22:44:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709262159430.28395@racer.site>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
 <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 23:46:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaehm-0006wO-Gf
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 23:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbXIZVpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 17:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755592AbXIZVpz
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 17:45:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:37597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754834AbXIZVpx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 17:45:53 -0400
Received: (qmail invoked by alias); 26 Sep 2007 21:45:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 26 Sep 2007 23:45:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tx0QbemWtl9ziAwTESSg7KIYMX2IkoqhPTZDTun
	GtBEeOogCIHWg8
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59251>

Hi,

On Wed, 26 Sep 2007, Junio C Hamano wrote:

> * mv/unknown (Tue Sep 25 16:38:46 2007 +0200) 1 commit
>  + Don't use "<unknown>" for placeholders and suppress printing of
>    empty user formats.
> 
> Parked in 'next'; I was already burned by it not passing one of the test 
> cases, and I am not absolutely certain what else this subtly breaks.  
> Hopefully minor.

I guess a few scripts could maybe rely on this behaviour.  We should 
advertise it as such.

> * lh/merge (Mon Sep 24 00:51:45 2007 +0200) 6 commits
>  + git-merge: add --ff and --no-ff options
>  + git-merge: add support for --commit and --no-squash
>  + git-merge: add support for branch.<name>.mergeoptions
>  + git-merge: refactor option parsing
>  + git-merge: fix faulty SQUASH_MSG
>  + Add test-script for git-merge porcelain
> 
> Comments?  I personally never felt need for --no-ff but the series is 
> reasonably clean so I do not see strong objection against this series 
> either.

Together with a resubmitted git-merge-rebase.sh (hint, hint), the 
mergeOptions would be quite useful for a workflow where you want to rebase 
on top of an upstream quite often.

> * js/rebase-i (Tue Sep 25 16:43:15 2007 +0100) 1 commit
>  + rebase -i: work on a detached HEAD
> 
> Waiting for autogc change as this textually interacts with it, and the 
> additional convenience can wait.

Sure.  I never used it anyway, but you specifically requested it ;-)  BTW 
thanks for merging the rest; especially the progress meter was a sore 
point for me since long.

> * jc/autogc (Mon Sep 17 00:55:13 2007 -0700) 10 commits
>  + git-gc --auto: run "repack -A -d -l" as necessary.
>  + git-gc --auto: restructure the way "repack" command line is built.
>  + git-gc --auto: protect ourselves from accumulated cruft
>  + git-gc --auto: add documentation.
>  + git-gc --auto: move threshold check to need_to_gc() function.
>  + repack -A -d: use --keep-unreachable when repacking
>  + pack-objects --keep-unreachable
>  + Export matches_pack_name() and fix its return value
>  + Invoke "git gc --auto" from commit, merge, am and rebase.
>  + Implement git gc --auto
> 
> I think the only remaining thing left with this thing is to prevent more 
> than one instances of it from running at the same time.  Any takers?

You mean, just creating a throw-away lock file?

> * ph/strbuf (Tue Sep 25 10:22:44 2007 +0200) 37 commits
>  + Small cache_tree_write refactor.
>  + Make builtin-rerere use of strbuf nicer and more efficient.
>  + Add strbuf_cmp.
>  + strbuf_setlen(): do not barf on setting length of an empty buffer
>    to 0
>  + sq_quote_argv and add_to_string rework with strbuf's.
>  + Full rework of quote_c_style and write_name_quoted.
>  + ...
> 
> I had to make a small fix-up to strbuf_setlen() last night to this 
> series; this should be ready for 'master'.
> 
> And it is better to push this out early, as the series touches 
> everywhere and conflicts with peoples' patches.

Hehe.  Indeed, I had to fix the notes series after rebasing it...

> * db/fetch-pack (Tue Sep 25 00:13:25 2007 -0400) 45 commits
>  + Prevent send-pack from segfaulting when a branch doesn't match
>  + Cleanup unnecessary break in remote.c
>  + Cleanup style nit of 'x == NULL' in remote.c
>  + Fix memory leaks when disconnecting transport instances
>  + Ensure builtin-fetch honors {fetch,transfer}.unpackLimit
>  + ...
> 
> Two issues known to me are:
> 
>  - "rsync" transport is not supported yet;

I promised to do this, and so I will today.

> * jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
>  + rebase: allow starting from a dirty tree.
>  + stash: implement "stash create"
> 
> I think "stash create" is going in a good direction, but I do not think 
> rebase should unstash unconditionally on the resulting work tree.  A 
> good compromise might be not to unstash if the user asked to switch 
> branches first and to unstash if he didn't.

Sounds like a sensible change to me; maybe a little warning after the 
rebase?

I have no idea if I come around to do the same for rebase--interactive any 
time soon, though.

Ciao,
Dscho
