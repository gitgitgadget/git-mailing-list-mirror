From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 0/6] Bunch of new features for cg-log and cg-diff
Date: Thu, 9 Jun 2005 16:22:43 +0200
Message-ID: <20050609142243.GA26524@diku.dk>
References: <42A82211.9060305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 16:29:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgNrp-0007wa-Q6
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 16:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVFIOWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 10:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVFIOWu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 10:22:50 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:5834 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261539AbVFIOWo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 10:22:44 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 3B8026E1973; Thu,  9 Jun 2005 16:21:56 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id ED98E6E1A77; Thu,  9 Jun 2005 16:21:55 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 82B5C61FE0; Thu,  9 Jun 2005 16:22:43 +0200 (CEST)
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
In-Reply-To: <42A82211.9060305@gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dan Holmsand <holmsand@gmail.com> wrote Thu, Jun 09, 2005:
> This series adds optget-style option parsing, support for almost all
> git-diff-* features, git-apply --stat support, common colorization code, 
> better performance for cg-log and some other stuff.

I tried out your patchset and have a few comments ...

cg-diff:

 - The pager is only used when passing -c. Is that intentional?

 - Nice with the diffstat option.

cg-log:

 - In the non-verbose summary you use the author date. One motivation
   for using the commit date is that the summary output makes it easy to
   track 'activity' and see if/when your patch made it in. Maybe I've
   just become too used to CVS changelogs.

 - Even though the more dense time format in the summary output is a
   nice idea the new date information is unfortunately also makes the
   summary output less useful, IMO. It can even make the by-date
   scanning harder because you have to jump between two significantly
   different date formats. With the new verbose distinction there should
   be no need for making the date so dense.

I don't much like the inverted colors caused by the searching. Although
the quick goto next entry thing is nice the colors can be very
intrusive, and having to search for some nonsense string to remove them
is terrible.

What about a COGITO_COLORS environment variable for configuring what
string setup_colors() will work on. It could maybe take the place of the
COGITO_AUTO_COLOR environment variable although this is two different
things.

With the long help output of cg-log maybe we should consider also
displaying it in a pager.

A minor note about the option parsing. cg-log -sh will give the error

	cg-log: unrecoginized option `-h'

-- 
Jonas Fonseca
