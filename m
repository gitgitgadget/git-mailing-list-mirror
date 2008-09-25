From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: having to pull twice
Date: Wed, 24 Sep 2008 18:01:50 -0700
Message-ID: <20080925010150.GI3669@spearce.org>
References: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Michael P. Soulier" <msoulier@digitaltorque.ca>
X-From: git-owner@vger.kernel.org Thu Sep 25 03:03:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KifG0-0000lu-Pa
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 03:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbYIYBBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 21:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbYIYBBw
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 21:01:52 -0400
Received: from george.spearce.org ([209.20.77.23]:39061 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYIYBBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 21:01:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E6A873835F; Thu, 25 Sep 2008 01:01:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96722>

"Michael P. Soulier" <msoulier@digitaltorque.ca> wrote:
> I'm finding this happening from time to time.
> 
> soulierm@espresso:~/work/mitel-msl-tug$ git pull
...
> error: Entry 'mitel-msl-tug.spec' not uptodate. Cannot merge.
> soulierm@espresso:~/work/mitel-msl-tug$ git status
> # On branch master
> # Your branch is behind 'origin/master' by 4 commits, and can be fast-forwarded.
> #
> nothing to commit (working directory clean)
...
> That directory is mounted via NFS, and I'm curious as to
> whether some kind of time skew could be the problem. But
> then, if it is, why did it go away after the first pull?

Time or dev/ino skew in the index file vs. what we read from stat.

Running git-status rematched the index file to the working directory,
and during that rematch it noticed the file wasn't actually modified.

So it prints "nothing to commit" and the next pull works fine,
now that the stat data in the index matches the working directory.

-- 
Shawn.
