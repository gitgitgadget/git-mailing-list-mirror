X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 5/5] git-svn: re-map repository URLs and UUIDs on SVK mirror paths
Date: Thu, 7 Dec 2006 12:02:37 -0800
Message-ID: <20061207200236.GB8179@localdomain>
References: <20061205051738.16552.8987.stgit@localhost> <20061205051738.16552.22494.stgit@localhost> <20061205085804.GB27236@soma> <45775E52.90102@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 20:02:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45775E52.90102@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33626>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPS5-0003B9-Q4 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 21:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163249AbWLGUCj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 15:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163250AbWLGUCj
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 15:02:39 -0500
Received: from hand.yhbt.net ([66.150.188.102]:46147 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1163249AbWLGUCi
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 15:02:38 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 1EE172DC034; Thu,  7 Dec 2006 12:02:37 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 07 Dec 2006
 12:02:37 -0800
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

Sam Vilain <sam@vilain.net> wrote:
> Eric Wong wrote:
> > Also, incremental fetches (or fetching more than 1k sequential
> > revisions) would probably fail.  To fix this, read the offset of last
> > entry in .rev_db instead of git-svn-id: from the last commit to get the
> > last revision.  But since rebuild won't work as expected; losing the
> > .rev_db file means you wouldn't be able to fetch from the SVK repo
> > anymore (but the original upstream one will be fine).
> > 
> > One last thing: feature should be made optional.  I actually work
> > day-to-day on a repository that was created with svm/SVN::Mirror,
> > the original repository no longer exists; but the mirrored one
> > still has these properties (I suppose I could remove the props
> > server-side, but some people may not have the permissions).
> 
> ok, I'll work on that and the other issues you highlighted... possibly
> the overhead of fetching the revprops during mirroring might hurt a
> little for people not doing this, too.  Thanks for reviewing the patch!

For the git-svn in master using the delta fetcher; there's no additional
overhead to fetch properties.  I want to ditch the old non-delta
fetching code (it's only a mild performance benefit when using local
repositories) if I could get do_switch() working correctly.

-- 
