From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PROBE] cg-commit: show and enable editing of changes with --review
Date: Thu, 1 Dec 2005 14:20:25 +0100
Message-ID: <20051201132025.GA3874@diku.dk>
References: <20051130000131.GC5365@diku.dk> <7vbr03564t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 14:23:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhoN1-0000Cb-1s
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 14:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVLANUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 08:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVLANUc
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 08:20:32 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:30157 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932224AbVLANUb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 08:20:31 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 1D6D76DFFAE; Thu,  1 Dec 2005 14:19:40 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id CED616DFEC6; Thu,  1 Dec 2005 14:19:39 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id D926B614BA; Thu,  1 Dec 2005 14:20:25 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr03564t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13055>

Junio C Hamano <junkio@cox.net> wrote Tue, Nov 29, 2005:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > Show changes being commited as a patch appended to the commit message
> > buffer. If the original patch is different from the patch extracted from
> > the commit message file the original patch will be reverted and the edited
> > patch applied before completing the commit.
> >
> > Due to limitations with cg-patch this can only be used when commiting
> > from the project root directory. The error handling if the either the
> > original patch or the edited patch does not apply is not optimal, since
> > cg-patch will not report errors properly.
> 
> I do not do Porcelains,

I am curious since you have also used this phrase in the past: didn't
you do your own jit porcelain once and are you saying that git does not
ship with it's own porcelain?

> I am not a Cogito user, and I generally
> do not like encouraging people who are playing an individual
> developer role to commit something that has never existed in
> their working tree (hence by definition never been tested),
> but...

I see your point. I mostly intend to use it for fixing small typos in
comments and documentation. It can help to cure some "post-commit
stress".  Also I hope you will agree that it is always a good idea to
review your changes one more time although I agree it might be a little
silly.

> > +		echo "Updating changes to edited patch"
> > +		# FIXME: Can only be run from the top level
> > +		# FIXME: Is very 'fragile' error handling. We should probably
> > +		# save the original patch in a local file for recovery?
> > +		if ! cg-patch -R < $PATCH; then
> > +			backup=$(mktemp commit-backup.XXXXXX)
> > +			cp $PATCH $backup
> > +			error_msg="unable to revert original patch, backup saved to $backup"
> 
> I suspect at least you should be able to use checkout-index for
> the first one instead of cg-patch.

Oh, great, thanks. I guess I should work some more on the git docs to
get to know these kind of things.

-- 
Jonas Fonseca
