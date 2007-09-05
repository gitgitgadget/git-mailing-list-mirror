From: "Govind Salinas" <govindsalinas@gmail.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 11:47:45 -0500
Message-ID: <69b0c0350709050947k5e32ba7fj38924a0968569d9a@mail.gmail.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 18:48:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISy2p-0001BN-4V
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 18:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbXIEQrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 12:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbXIEQrt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 12:47:49 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:8479 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbXIEQrs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 12:47:48 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1313041nze
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 09:47:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UJf9eV7UShOyT0huP28Cl/wPgSmH0CKCqyCX+ENrM/SvAc5CZns8SaeHoNWuLOCJV448Ph9d4AOrqjw/ud85R6AKQFYkuOq1Xzls1kkGodFoa70ZmdJo8XRPZ7zM5Ylf0aVu7trOo6qXK6o+3Ba0U7NnEXKh3Nm3B4bKAI7UQAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VVm6g+15ph2p8xCuBbGLr/Odtd8+ExNVUHndRvXo7FvFF630V2dk7pZCNieaX3ptSF9ltE6W7IOsxC0X+590hTpLRovaCJgO7HoPF0A/Qesv/qIhWdB4coAFWsklxI60sK+mj42EYdcSJJ2vluQ/w1fb2Zgng+YeX6hWrvSY1eo=
Received: by 10.65.186.18 with SMTP id n18mr13295473qbp.1189010865930;
        Wed, 05 Sep 2007 09:47:45 -0700 (PDT)
Received: by 10.65.189.16 with HTTP; Wed, 5 Sep 2007 09:47:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57720>

Hi,

I am very new to git but I have thought about this a bit from a user's
perspective.  I have several thoughts on the matter.

First, I would like to point out that the hg folks like to compare
themselves to git a lot and they list the need for manual gc as a
reason to choose hg over git.  This may not be something that the git
community cares about but I thought I would point it out.

Second, it *is* a hassle.  When trying to figure out what I could
convince my co-workers to use, having to gc was something that I did
not think they would be conscious of or care enough about to do.  It
makes git more of a PITA than it could be.  Similarly, I have no idea
when it is a good time to do a gc.  After every commit?  Before push?
What if I never push a repo?  What if it is a remote repo only used to
sync up with my co-workers, do I have to go there and periodically gc?
 This is one reason why I really think that gc should be *plumbing*
and *not* porcelain.

The user should never have to trigger a gc, they should even be
discouraged from doing so.  That is how other gc systems are.  Can you
imagine if you had a Java app that had a button on it to do a gc?
When should I push it?  Should I wait till the system is getting slow
or just start spamming the button whenever I'm bored?  I know that
Java/c#/py GC are different than git gc, but they fulfill the same
basic purpose as git gc.  IE to clean up unused items and free up
resources.  Git additionally may do some re-optimization, but that is
not relevant to a user.

I know this goes against the general mood here (which seems to be
against auto-gc) but I thought I would give my $.02 as a user of git.

Thanks,
Govind.

On 9/5/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> So we had a git bof at linux.conf.eu yesterday, and I leart something
> new: even people who have been using git for a long time apparently don't
> necessarily realize the importance of repacking.
>
> James Bottomley (the Linux SCSI maintainer) is an old-time BK user, and
> very comfy using git. But when he was demonstrating things on his poor old
> laptop, simple things like "git branch" literally took a long time, and
> James didn't seem to realize that the fact that he had apparently never
> ever repacked his repository was a big deal.
>
> The kernel archive is a 190MB pack for me fully repacked (I just checked -
> I had actually thought that it was somewhat larger than that), but because
> James hadn't repacked, his .git directory was over a gigabyte in size, and
> his laptop wasn't able to cache anything at all effectively as a result.
>
> Repacking it took over an hour, simply because everything was *so*
> unpacked, and James' kernel repository had something like 92 thousand
> loose objects, and several hundred packfiles. Simple operations that
> really take much less than a second for me ("git branch" takes 0.022s on
> my laptop, which has the same 512M that James had on his) took many many
> seconds as a result, and James seemed to think that this was all normal.
>
> And James didn't even want to repack, because it was so expensive (which
> he knew - he claims to have never ever repacked at all, but maybe he had
> started it and just control-C'd it when it was really slow at some point).
>
> Now, it may be that James didn't realize how important the occasional
> garbage collect is exactly *because* he is an old-timer and used BK long
> before he used git, and just continued using git simply as a BK
> replacement, but it did make me wonder whether maybe this lack of
> repacking awareness is fairly common.
>
> I've been against automatic repacking, but that was really based on what
> appears to be potentially a very wrong assumption, namely that people
> would do the manual repack on their own. If it turns out that people don't
> do it, maybe the right thing for git to do really is to at least notify
> people when they have way too many pack-files and/or loose objects.
>
> I personally repack everything way more often than is necessary, and I had
> kind of assumed that people did it that way, but I was apparently wrong.
> Comments?
>
>                 Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
