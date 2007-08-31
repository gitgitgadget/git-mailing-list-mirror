From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn dcommit not checking if up-to-date?
Date: Fri, 31 Aug 2007 15:18:14 -0700
Message-ID: <20070831221814.GB31033@untitled>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 01 00:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IREpK-0006zT-0D
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 00:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbXHaWSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 18:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXHaWSu
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 18:18:50 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38583 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbXHaWSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 18:18:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7AA1F2DC08D;
	Fri, 31 Aug 2007 15:18:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708312200480.28586@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57228>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Eric,
> 
> harningt just asked about known issues of git-svn on IRC, and I remembered 
> that I had an issue: Accidentally, I forgot to "git svn fetch" before "git 
> svn dcommit"ing, and unfortunately, a colleague had just checked in a 
> change, which got undone by my dcommit.
> 
> Is this a known issue, has it been fixed, am I a bad pilot?
> 
> Ciao,
> Dscho
> 
> P.S.: harningt promised to get his hands dirty, but I just realised that 
> the issue could be fixed since long ago...

I believe this was fixed a while back in commit
45bf473a7bc2c40c8aea3d34a0eab7a41e77a8ff
(Thu Nov 9 01:19:37 2006 -0800).

I just tested this on a live server, and it seems to be correctly
erroring out if the local files are not up-to-date.


The only currently known issues that could break commits is from using
merge or pull from another svn branch and trying to dcommit the result
(see CAVEATS section in the manpage).  I hope to fix this soon (hoping
somebody beats me to it, of course)


Otherwise there's still open bugs on svn:// fetch connections dying and
permissions issues with some DAV repos, neither of which can cause data
corruption on either side.

-- 
Eric Wong
