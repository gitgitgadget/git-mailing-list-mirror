From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 00:55:36 -0500
Message-ID: <9e4733910702112155m3f5da9abgbeb2b6783005296f@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <20070211225326.GC31488@spearce.org>
	 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
	 <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
	 <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 06:55:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUAB-0000Os-AZ
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 06:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933006AbXBLFzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 00:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933007AbXBLFzk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 00:55:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:5534 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933006AbXBLFzj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 00:55:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so487362uga
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 21:55:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cxJpZHlucpx9TWEA3LcB9dajAejqkyni33OjMrT81tKOJAJAL9lepOGKxi96nOCvH3+9V1oqk/6GM/DHhSU65jCkbzImz/y6it6u9vsDYiKUYeIXqoJgb68DEIV3G+l6KVLppcMgR6fufIJ3hR+nd2sjZeipH4ohy7q1/UW3kSg=
Received: by 10.114.181.1 with SMTP id d1mr6610820waf.1171259736641;
        Sun, 11 Feb 2007 21:55:36 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 21:55:36 -0800 (PST)
In-Reply-To: <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39370>

On 2/12/07, Junio C Hamano <junkio@cox.net> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > On 2/11/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> Same thing with cg clone, it's what is broken.
> >> cg update is broken in the same way.
> >> I'm using the current git version of cogitio.
> >> I'll switch to the git commands, git clone is about 10x faster for the
> >> clone anyway.
> >
> > Don't read anything into the 10x speed diff, my last git clone was
> > really slow. I'm probably fighting other people at kernel.org to keep
> > the tree in RAM.
> >
> > But pack to the original point, can't the server check and see if it
> > has write access so that it can keep the fully packed tree? I've just
> > caused kernel.org to needlessly repack the wireless-dev tree a dozen
> > times playing with this clone command. If it didn't have to keep
> > repacking for the clone, clone would be a lot faster.
>
> You are assuming everybody does initial clone all the time.  I

Why not use an initial clone as a trigger for a repack? Given the
thousands of people playing with trees on kernel.org it must happen
quite a bit. Add a log message to the server and we can find out for
sure.

I am guilty of doing initial clones for different kernel trees from
kernel.org when I could be doing a local clone of linus' tree and then
pulling the deltas from kernel.org. But I'm lazy, I just kick the
clone off in the background and it finishes in three or four minutes.
I also do the clones when I have messed my local trees up so much that
I don't know what is in them anymore.

> do not think that holds true in practice.

git experts can avoid almost all of the clones, but most people don't
learn enough about git to avoid them.

For example, I've been using git for quite a while now and I still
haven't bother to figure out how to do this: start with a local clone
of linus' tree, now I want to pull the wireless-dev tree into the same
local tree as another branch. And maybe pull the wireless-2.6 into yet
another branch. Then can I pull updates from all of my remote
repositories with a single command?

>
> For something like tglx historical tree that will _never_
> change, there is a specific hack the repository owner can take
> advantage of to always feed a prepackaged pack, although its use
> is not advertised well enough (and I do not think it buys much
> in practice).
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
