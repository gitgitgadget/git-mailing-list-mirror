From: Jean Sacren <sakiwit@gmail.com>
Subject: Re: Pull From Mirrored Repository
Date: Sun, 18 Sep 2011 14:06:33 -0600
Message-ID: <20110918200633.GN15295@mail.gmail.com>
References: <20110918144514.GL15295@mail.gmail.com>
 <CAH5451m1WJ0H9G8uHbCqZ5acO-xEynGKjMk=6g75buJy1S7iSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 22:07:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Ndk-0007OD-7q
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 22:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447Ab1IRUGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 16:06:55 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:43529 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273Ab1IRUGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 16:06:54 -0400
Received: by pzk1 with SMTP id 1so8756233pzk.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=ODgO24wDFZRpfceelV3F3+T3ZuWJEshBMuO9bcerkpM=;
        b=wuBb253EhkDvnSNvQBeueTnX2WSYczpi+S6EZ3E41fh0qmvuTE3+YLQEYuAADA2xk/
         oaZS1VFy9mUMaIsqGDGOB/MZtM9NKuR7WACiJXJD8oRnEglXGzs4Fsm0po2LRX0WRkxh
         aneptPpy4xNzyYPR4freWTMPHB7Mo6PmSV5a4=
Received: by 10.68.33.225 with SMTP id u1mr2853856pbi.498.1316376413890;
        Sun, 18 Sep 2011 13:06:53 -0700 (PDT)
Received: from localhost ([67.214.237.222])
        by mx.google.com with ESMTPS id u10sm59261441pbr.12.2011.09.18.13.06.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 13:06:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAH5451m1WJ0H9G8uHbCqZ5acO-xEynGKjMk=6g75buJy1S7iSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181633>

From: Andrew Ardill <andrew.ardill@gmail.com>
Date: Mon, 19 Sep 2011 01:15:47 +1000
>
> Am I correct in thinking that you have done the following:
> 
> $ git clone original-server/repo.git
> $ cd repo
> $ git pull mirror-server/repo.git

Essentially that's what I did.

> and now you want the remote ref 'origin/master' to point to the same
> thing as 'mirror/master' (assuming that you create the ref for the
> mirror)?

The idea is to update the local tree from multiple sites so long as one
of them is still running. And the update shall make no difference
whether it is from the master site or not.

> This can be done (by editing the file .git/refs/remotes/origin/master
> and specifying the correct sha1) however this is probably not the best
> idea. It is best for git to know the actual state of the remote the
> last time you synced with it so that it can act intelligently the next
> time you sync with it.

It turns out to be more of a bug with git. After a successful pull from
a master or mirror site, the SHA1 shall be updated among all the master
files in .git/refs/remotes/origin or .git/refs/remotes/[WHATEVER_MIRROR]
as the tip of the local tree is updated.

> If you intend to sync with the mirror, you might as well set it as the
> upstream ref of you master branch. That way you will not get the 'Your
> branch is ahead' message when you pull new updates (unless you have
> local changes, of course).
> This can be done by:
> $ git checkout master
> $ git branch --set-upstream mirror

This is a nice hack, but we want all the changes stay with the master
branch. It's easier to use one master branch for tracking all updates
from the upstream.

Thank you for all your help!

-- 
Jean Sacren
