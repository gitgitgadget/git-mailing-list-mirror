X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: follow parent after the fact?
Date: Mon, 18 Dec 2006 23:47:45 -0800
Message-ID: <20061219074745.GA31338@localdomain>
References: <45873D0A.1040804@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 07:48:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45873D0A.1040804@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34793>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwZhX-0005NS-5I for gcvg-git@gmane.org; Tue, 19 Dec
 2006 08:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932622AbWLSHrs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 02:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWLSHrs
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 02:47:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33138 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932622AbWLSHrr
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 02:47:47 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id E26927DC02A; Mon, 18 Dec 2006 23:47:45 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 18 Dec 2006
 23:47:45 -0800
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> wrote:
> One of the other git users here just noticed that his git-svn clone of a 
> particular svn repo has an inconsistent set of files compared to the svn 
> client. Turns out the repo has had its trunk moved around in the past. A 
> fresh clone with --follow-parent (which he didn't use) produces the 
> correct results.

The final set of files at the latest (svn) revision was inconsistent?
That should never happen...  If so, I'd very much like to look into this.

> Obviously he can blow away his current repo and make a new one, but it'd 
> be nicer if he could preserve his local change history. Is there any way 
> to retroactively apply the additional changes --follow-parent would have 
> applied if it had been used on the initial fetch?

git-svn graft-branches can probably work (if he imported the parent
separately).

> It would be better, IMO, if you didn't have to figure out whether or not 
> a given remote svn repository has had branch renames in the past in 
> order to figure out if you need to provide an extra option to git-svn 
> fetch. Maybe --follow-parent should be the default behavior and there 
> should be an option to turn it off? Or is there a good reason to not 
> want that behavior most of the time? My assumption is that it's not the 
> default simply because it's a recent addition.

It may behave unpredictably on some poorly organized repositories.  I
haven't quite debugged this problem fully as the current code to handle
multiple repositories is a hacked-on mess.

I'm currently refactoring git-svn to work better on multi-remote
operations and --follow-parent should be easier to debug as a result.

> By the way, I'm completely in favor of renaming commit to set-tree. +1 
> for that change.

Noted, thanks for the input.

-- 
