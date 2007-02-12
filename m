From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn on a strangely configured (pathwise) subversion repository
Date: Mon, 12 Feb 2007 10:32:02 -0800
Message-ID: <20070212183202.GB21413@localdomain>
References: <200702121136.06382.blindglobe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: AJ Rossini <blindglobe@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 19:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGg0F-0004PW-Hy
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 19:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbXBLScW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 13:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbXBLScW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 13:32:22 -0500
Received: from hand.yhbt.net ([66.150.188.102]:56528 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965289AbXBLScF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 13:32:05 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D4F9C7DC094;
	Mon, 12 Feb 2007 10:32:02 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 12 Feb 2007 10:32:02 -0800
Content-Disposition: inline
In-Reply-To: <200702121136.06382.blindglobe@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39423>

AJ Rossini <blindglobe@gmail.com> wrote:
> Greetings all -
> 
> (paths and names changed, but basically correct)
> 
> I'm trying to use git-svn as a svn client on a repository which is not
> quite configured in a standard way...  i.e. 

Perfectly standard on some corporate networks, unfortunately :(

> $ git svn fetch
> RA layer request failed: PROPFIND request failed on '/path/to': PROPFIND 
> of '/path/to': 403 Forbidden (https://dummy-host-name.com) 
> at /usr/bin/git-svn line 2861

<snip>

> The problem seems to be that the Repository Root directory is not
> readable, while the URL is (at least for me, using HTTPS).
> 
> This is using
> $ git --version
> git version 1.4.4.4

Known problem.  This is fixed in commit
747fa12cef73b6ca04fffaddaad7326cf546cdea

> Here is what I'm considering: 
> #1 - upgrading to the 1.5.0 RC series

Stop after #1 if you want a sure thing the current 1.5.0 RC series
contains fixes for repositories with only partial read permissions.

> #2 - trying Eric Wong's git-svn branch at
> http://git.bogomips.org/git-svn.git

Read access in your case *should* continue to work here.  More testing
would be good.  This branch may not work well if your write access is
not the same as as your read access; which is something I keep
forgetting to fix...

> #3 - getting a dump of the repository from the owner, loading it into
> a local svn server, and doing a local conversion...
> 
> With respect to #1/#2, I'm a bit cautious with upgrading to something
> not rock solid (let's just say that except for this, git 1.4.4.4 has
> been excellent for my needs...).
> 
> With respect to #3 - I'd prefer not to waste the admin's (personal)
> time if 

#3 is definitely not necessary.

Junio has done a wonderful job of keeping the 1.5.0-rc* series stable
and usable, so #1 is the safest.  I'll try to fix things today so #2
will work better.

-- 
Eric Wong
