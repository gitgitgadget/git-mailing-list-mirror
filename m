X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix dcommit losing changes when out-of-date from svn
Date: Thu, 9 Nov 2006 11:22:00 -0800
Message-ID: <20061109192200.GA3604@localdomain>
References: <455277A6.2000404@midwinter.com> <20061109091937.GA22853@localdomain> <7vfyctkki5.fsf@assigned-by-dhcp.cox.net> <m2r6wcy0t0.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 19:22:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <m2r6wcy0t0.fsf@ziti.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31200>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiFTW-0002uc-0q for gcvg-git@gmane.org; Thu, 09 Nov
 2006 20:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754830AbWKITWG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 14:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbWKITWG
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 14:22:06 -0500
Received: from hand.yhbt.net ([66.150.188.102]:7106 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1754830AbWKITWE (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 14:22:04 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 796987DC098; Thu,  9 Nov 2006 11:22:00 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 09 Nov 2006
 11:22:00 -0800
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > Eric Wong <normalperson@yhbt.net> writes:
> >
> >> There was a bug in dcommit (and commit-diff) which caused deltas
> >> to be generated against the latest version of the changed file
> >> in a repository, and not the revision we are diffing (the tree)
> >> against locally.
> >>
> >> This bug can cause recent changes to the svn repository to be
> >> silently clobbered by git-svn if our repository is out-of-date.
> 
> Eric, with this patch, is a dcommit operation as safe as a regular svn
> commit from an svn working copy?  That is, the commit will abort if
> the svn repository has changes that your git-svn/git repo hasn't yet
> seen?  I'm pretty sure the answer is yes, but I'd like to be sure :-)

Yes, this is as safe as a regular svn commit from a working copy.
Transactions will abort if there are conflicts in the files being
committed.

-- 
