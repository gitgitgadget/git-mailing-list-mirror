From: Ryan Anderson <ryan@michonline.com>
Subject: Re: sending changesets from the middle of a git tree
Date: Sun, 14 Aug 2005 00:02:33 -0400
Message-ID: <20050814040233.GC6844@mythryan2.michonline.com>
References: <42FEBC16.9050309@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 06:03:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E49i0-0007Zt-3V
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 06:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVHNECp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 00:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVHNECp
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 00:02:45 -0400
Received: from mail.autoweb.net ([198.172.237.26]:8131 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932439AbVHNECo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 00:02:44 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E49hi-0006DR-EZ; Sun, 14 Aug 2005 00:02:34 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E49hh-0008RV-00; Sun, 14 Aug 2005 00:02:33 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E49hh-0008Ql-H1; Sun, 14 Aug 2005 00:02:33 -0400
To: Steve French <smfrench@austin.rr.com>
Content-Disposition: inline
In-Reply-To: <42FEBC16.9050309@austin.rr.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 13, 2005 at 10:35:50PM -0500, Steve French wrote:
> Just to confirm a recent answer to questions on lkml ...
> 
> 1) There is no way to send a particular changeset from the "middle" of a 
> set from one tree to another, without exporting it as a patch or 
> rebuilding a new git tree.   I have two changesets that, after testing 
> last week, I now consider more important to send upstream than the few 
> earlier and later changesets.   If I export those two changesets as 
> patches, and send them on. presumably I lose the changset comments etc. 
> and then when the upstream tree is merged back, it might look a little 
> odd in the changeset history.

You can keep most of the metadata you want with "git format-patch".

Extract the changes you need, mail them off.

When you later merge things back together, it should be a trivial merge,
hopefully.

> 2) There is no way to update the comment field of a changeset after it 
> goes in (e.g. to add a bugzilla bug number for a bug that was opened 
> just after the fix went in).

No, a commit is immutable.  You can use "git format-patch" to rebase things if
you need.  I prefer to use "git format-patch --mbox", edit what I need
to, then use git-applymbox to rebase it all against a clean tree.

> 3) There is no way to do a test commit of an individual changeset 
> against a specified tree (to make sure it would still merge cleanly, 
> automatically).

Not sure on this one - in this case, it almost sounds like you want the
feature set of StGit, and/or quilt.  (If "quilt push" succeeds, clearly
it still merges cleanly.)


-- 

Ryan Anderson
  sometimes Pug Majere
