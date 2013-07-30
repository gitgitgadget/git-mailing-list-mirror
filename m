From: John Keeping <john@keeping.me.uk>
Subject: Re: ANNOUNCE: git-integration -- Easily manage integration branches
Date: Tue, 30 Jul 2013 18:57:11 +0100
Message-ID: <20130730175710.GO2337@serenity.lan>
References: <20130730154620.GN2337@serenity.lan>
 <7vli4ovvwi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 19:57:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4EAm-0003Yu-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 19:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658Ab3G3R5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 13:57:21 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49407 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab3G3R5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 13:57:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 803A0CDA5C3;
	Tue, 30 Jul 2013 18:57:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zqsgSWEuv5hG; Tue, 30 Jul 2013 18:57:18 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id AD964CDA587;
	Tue, 30 Jul 2013 18:57:18 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 85CF6161E036;
	Tue, 30 Jul 2013 18:57:18 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uwrg0nUL3t89; Tue, 30 Jul 2013 18:57:16 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 52DD0161E24A;
	Tue, 30 Jul 2013 18:57:12 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vli4ovvwi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231375>

On Tue, Jul 30, 2013 at 09:45:49AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > I wrote this script a few months ago and have been using it pretty much
> > daily since then, so I figure it's time to see if anyone else finds it
> > useful...
> >
> > git-integration [1] is a script to help manage integration branches in
> > Git.  By defining a base point and a set of branches to be merged to
> > form the integration branch, git-integration lets you easily rebuild an
> > integration branch when anything in it changes, as well as showing you
> > the status of all of the branches in the integration branch.
> >
> > For example, the instruction sheet for git-integration's "pu" branch
> > recently looked like this:
> >
> > 	base master
> >
> > 	merge make-clean
> >
> > 	  Add a "clean" target to the makefile.
> >
> > 	merge version
> >
> > 	  Support for "--version" option.
> >
> > 	  N.B. this builds on "make-clean".
> >
> > 	merge skip-option
> >
> > 	  Needs more work to be able to handle "branch not found".
> >
> > This tells git-integration to base the "pu" branch on "master" and merge
> > the "make-clean", "version" and "skip-option" branches in.  The comments
> > following the "merge" instructions are added to the commit message for
> > the corresponding merge commit.  When I want to rebuild the "pu" branch
> > I simply do:
> >
> > 	$ git integration --rebuild pu
> >
> > To change the contents of the branch, I either edit the instruction
> > sheet manually:
> >
> > 	$ git integration --edit pu
> >
> > or quickly add a new branch from the command line:
> >
> > 	$ git integration --add my-new-branch pu
> >
> > In fact, I can combine these to get the benefit of bash-completion on
> > the branch name and the ability to edit the instruction sheet - when
> > multiple commands are specified, git-integration performs each of them
> > in a sensible order, described in the manpage [2].
> >
> >
> > [1] http://johnkeeping.github.io/git-integration/
> > [2] http://johnkeeping.github.io/git-integration/git-integration.html
> 
> Interesting.
> 
> Would it help me to replay "evil merges" I previously made and avoid
> necessity to write merge log messages repeatedly?

Currently it does nothing beyond having the ability to continue
automatically if rerere manages to resolve all conflicts (disabled by
default).  There is no equivalent of your refs/merge-fix/ feature,
although I think I might add one soon ;-).

Since the commit messages for the merge commits come from the
instruction sheet, it does avoid the need to write them repeatedly - if
you want to change the merge message you can simply update the
instruction sheet and rebuild.

> In short, can I replace my Meta/Reintegrate and Meta/cook with this
> (see Documentation/howto/maintain-git.txt)?

It performs the same basic function as those scripts, but it's quite a
lot simpler and hasn't been designed for the git.git workflow, so I
don't think it's suitable for replacing your existing scripts.

If I were starting from scratch and attempting to implement the git.git
workflow on top of git-integration, I think I would make
whats-cooking.txt a build artifact generated from the instruction sheet
for pu.  This would require some new commands to be added to
git-integration's instruction sheet to let it assign sections to
branches, but ought to be possible.  I expect there would be some
subtleties though - certainly git-integration's "--status" output does
not handle all of the cases the Meta/cook does, not least because it
only compares against a single base branch.
