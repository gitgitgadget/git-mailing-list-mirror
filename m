From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 2/4] git-rebase: add keep_empty flag
Date: Sat, 31 Mar 2012 08:59:49 -0400
Message-ID: <20120331125949.GB2409@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-3-git-send-email-nhorman@tuxdriver.com>
 <7vhax5lt05.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 15:00:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDxuS-0007Vi-8l
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 15:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab2CaM74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 08:59:56 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:42792 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab2CaM7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 08:59:55 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SDxuI-0005ii-SZ; Sat, 31 Mar 2012 08:59:53 -0400
Content-Disposition: inline
In-Reply-To: <7vhax5lt05.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194450>

On Fri, Mar 30, 2012 at 01:43:22PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Add a command line switch to git-rebase to allow a user the ability to specify
> > that they want to keep any commits in a series that are empty.
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > CC: Jeff King <peff@peff.net>
> > CC: Phil Hord <phil.hord@gmail.com>
> > CC: Junio C Hamano <gitster@pobox.com>
> 
> The same comments on Cc: apply to all of your patches.
> 
Roger that.

> >  Documentation/git-rebase.txt |    6 ++++++
> >  git-rebase.sh                |    5 +++++
> >  2 files changed, 11 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 504945c..9717d3e 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -238,6 +238,12 @@ leave out at most one of A and B, in which case it defaults to HEAD.
> >  	will be reset to where it was when the rebase operation was
> >  	started.
> >  
> > +--keep-empty::
> > +	Informs git-rebase that comits which are empty should not be
> > +	automatically removed.  This is at times useful when empty commits
> > +	are used to hold developer information and notes, but contain no real
> > +	code changes
> > +
> 
> Unlike "cherry-pick", I think "--keep-empty" is a better name for the
> option than "--allow-empty" in this context.  The difference is that from
> the end-user's point of view, cherry-pick _replays_ commits that exist
> elsewhere, and you are allowing the command to replay empty ones as well,
> while rebase _rebuilds_ commits on the same branch, and you are telling
> the command to keep empty ones.
> 
> "... which are empty should not be removed" is a bit of double-negation,
> though.  Perhaps
> 
> 	--keep-empty::
> 		Keep the commits that do not change anything from its
> 		parents in the result.  This is at times useful when empty
> 		commits are used to hold developer information and notes
> 		without having any real changes.
> 
> But as I rephrased the first part, the last line may have become redundant
> and could safely be removed.
> 
Ack, I can make the above changes.

> The patch does not seem to do anything other than accepting and silently
> ignoring the option, though.
> 
It does, as the use of the option is pushed into the type specific rebase
scripts.  I probably should have rolled this patch in with one of those. I'll
squash it in when I repost.
