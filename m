From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Add a --dry-run option to git-svn rebase
Date: Sun, 1 Jun 2008 03:13:04 -0700
Message-ID: <20080601101304.GC16064@hand.yhbt.net>
References: <87hcctygah.fsf@nav-akl-pcn-343.mitacad.com> <1211254157-41316-1-git-send-email-seth@userprimary.net> <20080530171831.GB76080@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Seth Falcon <seth@userprimary.net>
X-From: git-owner@vger.kernel.org Sun Jun 01 12:14:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2kZu-0002ZD-Nz
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 12:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbYFAKNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 06:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbYFAKNI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 06:13:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56252 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbYFAKNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 06:13:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7E91B2DC08B;
	Sun,  1 Jun 2008 03:13:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080530171831.GB76080@ziti.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83444>

Seth Falcon <seth@userprimary.net> wrote:
> Hi Eric,
> 
> I think this may have slipped by without your notice as I gather
> things have been busy for you.
> 
> Could you take a look at this patch and let me know if you like
> it/hate it/have a suggestion?
> 
> My motivation was wanting to automate some commit rewritting and
> wanting a script to be able to determine what the local upstream
> branch is...

This patch looks reasonable to me.
Acked-by: Eric Wong <normalperson@yhbt.net>

> * On 2008-05-19 at 20:29 -0700 Seth Falcon wrote:
> > @@ -553,6 +554,11 @@ sub cmd_rebase {
> >  		die "Unable to determine upstream SVN information from ",
> >  		    "working tree history\n";
> >  	}
> > +	if ($_dry_run) {
> > +		print "remote-branch: " . $gs->refname . "\n";
> > +		print "svn-url: " . $url . "\n";
> > +		return;
> > +	}
> >  	if (command(qw/diff-index HEAD --/)) {
> >  		print STDERR "Cannot rebase with uncommited changes:\n";
> >  		command_noisy('status');

One minor nit is 'url' not being capitalized in the output.  Perhaps:

	Remote Branch: foo
	SVN URL: http://asdf/foo/trunk


Which would make it consistent with 'git svn info' using spaces:

RFC822-style headers would be alright, too.

	Remote-Branch: foo
	SVN-URL: http://asdf/foo/trunk

I do however harbor a deep dislike of camel-case
(used by 'git log --pretty=fuller' and .git/config).

	RemoteBranch: foo
	SvnUrl: http://asdf/foo/trunk


Hmm, I don't think I've even _noticed_ a real bike shed in decades.
Perhaps they should be painted purple with yellow polkadots and have the
words "BIKE SHED" on a flashing neon sign.

-- 
Eric Wong
