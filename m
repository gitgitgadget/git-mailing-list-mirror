From: Peter Osterlund <petero2@telia.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: 03 Jul 2005 14:38:55 +0200
Message-ID: <m3oe9k6p40.fsf@telia.com>
References: <1119994003.9631.6.camel@localhost.localdomain>
	<m3ekagp9mk.fsf@telia.com>
	<1120385280.6845.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 03 14:39:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp3kj-0002BE-Iy
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 14:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVGCMjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 08:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVGCMjL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 08:39:11 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:16060 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261404AbVGCMjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 08:39:04 -0400
Received: from r3000.localdomain (62.20.228.28) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 42B93717001F3934; Sun, 3 Jul 2005 14:39:02 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j63Cct3o015894;
	Sun, 3 Jul 2005 14:38:55 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j63Cct9S015889;
	Sun, 3 Jul 2005 14:38:55 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1120385280.6845.12.camel@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> Hi Peter,
> 
> Thanks for trying this tool.
> 
> On Sun, 2005-07-03 at 10:38 +0200, Peter Osterlund wrote:
> > This is good stuff and the 3-way merge really simplifies things.
> > However, if there is a merge conflict, you will basically be stuck
> > with a 2-way merge when resolving manually. It's usually much easier
> > if you can see all three version, so I think it's better to use -A
> > instead of -E in the diff3 command.
> 
> I know that using -A gives a more detailed output in case of a conflict.
> The problem is that you will get a conflict even if the changes are
> identical, making it impossible to detect when a patch was merged
> upstream.

OK, I see. How about using wiggle instead?

        http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/

That's what patch-utils uses if you run "pushpatch -m". wiggle is also
a lot smarter than diff3, so there will be fewer cases that result in
a conflict. Maybe a parameter to "stg push" could enable wiggle mode.

Another nice thing from patch-utils is that if applying the patch
would have failed, nothing will be done by "pushpatch". You then have
the option to rerun it with -m (merge) or -f (force, create .rej
files), or decide that you don't want to push the patch at all. The
last part is quite useful if you try to reorder a patch series, find
out that you would get a thousand conflicts, and want to reconsider.

Is there a way in StGIT to undo a push that results in a large mess of
conflicts?

> Speaking of detecting upstream merges, the latest StGIT snapshot shows a
> '0' in front of a patch if it is empty, when 'stg series' is invoked.
> When pushing, if all the changes are the same, it notifies you that the
> patch is empty so that it can be safely removed.

That's a useful feature. With patch-utils, I used to drop patches
manually, but that could lose information if the patch applied
upstream is not exactly the same as the one I had locally.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
