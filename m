From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 5 Aug 2007 00:13:20 -0400
Message-ID: <20070805041320.GH9527@spearce.org>
References: <873ayymzc1.fsf@catnip.gol.com> <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 06:13:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXUd-00071H-5f
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXHEENY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbXHEENY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:13:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45497 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbXHEENX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:13:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHXUZ-0004YF-0l; Sun, 05 Aug 2007 00:13:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C598020FBAE; Sun,  5 Aug 2007 00:13:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54934>

Miles Bader <miles@gnu.org> wrote:
> I previously wrote
> > One thing I often want to do is git-add all untracked files, and also
> > automatically git-rm all "disappeared" files
> ...
> > One way to do this seems to be just "git add ."
> 
> Oh, also, "git add ." doesn't seem to do the right thing with
> "dissapeared" files:  If I do:
> 
>     mv foo.cc bar.cc
>     git add .

Right.  Who wants "add" to actually mean "add and delete"?
Shouldn't that be then called "git-add-and-rm"?

We recently talked about this on the mailing list and decided that
git-add shouldn't remove files that have disappeared, as doing so
might break most user's expections of what git-add does.

> then git-status will show a new  file "bar.cc", but will list "foo.cc"
> as "deleted " in the "Changed but not updated" section.  Perhaps the
> right thing will happen if I do "git-commit -a" (though I don't know,
> I don't really want to try it),

"git commit -a" will remove disappeared files.  It has for quite
some time.

> this still results in incorrect
> "git-diff --cached" output (it shows bar.cc as a new file, not as a
> rename of foo.cc).
> 
> Am I doing something wrong, or is this just missing functionality?

Try adding the -M option to "git-diff".  That will enable the rename
detection, and show the rename you are looking to see.

-- 
Shawn.
