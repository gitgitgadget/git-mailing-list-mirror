From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git screwup with reset
Date: Mon, 18 May 2009 08:08:40 -0700
Message-ID: <20090518150840.GJ30527@spearce.org>
References: <9D569322-6A7B-4447-962C-0C740945E227@orgsync.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jake varghese <jake@orgsync.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:08:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M64SP-00046i-8K
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 17:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbZERPIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 11:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbZERPIk
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 11:08:40 -0400
Received: from george.spearce.org ([209.20.77.23]:34855 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbZERPIj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 11:08:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C1508381FD; Mon, 18 May 2009 15:08:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9D569322-6A7B-4447-962C-0C740945E227@orgsync.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119447>

jake varghese <jake@orgsync.com> wrote:
> When I run git fsck --lost-found i get a whole bunch of dangling  
> objects.  If I run git show on those objects it shows me the code that 
> was lost.  Anyone know of a way to get this stuff back.  I tried  
> rebasing and merging and neither worked.

For each of those dangling blobs:

  git cat-file blob $sha1 >$path

where you need to manually figure out the relationship between
$sha1 and the local $path within your project.  Git doesn't have
that relationship data, because you never made a commit.

Oh, and next time, commit like every hour, or more frequently than
that.  At worst, you'll need to do a "git merge --squash" near the
end to flatten out your silly "save my work" checkpoints and draft
a more useful commit message for your coworkers.  But at least you
lose less when you have a "git reset --hard" fat finger accident.

-- 
Shawn.
