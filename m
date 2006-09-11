From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 02:08:20 -0400
Message-ID: <20060911060820.GB29368@spearce.org>
References: <20060908184215.31789.qmail@science.horizon.com> <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com> <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com> <17668.2019.732961.855446@cargo.ozlabs.ibm.com> <20060911000306.GA28927@spearce.org> <7vfyezqlny.fsf@assigned-by-dhcp.cox.net> <ee2cms$o18$1@sea.gmane.org> <20060911024434.GA29368@spearce.org> <7vac57nfb5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 11 08:08:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMeyC-0004CX-Tv
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 08:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWIKGIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 02:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWIKGIa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 02:08:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:16350 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964908AbWIKGI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 02:08:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GMexy-0002el-PS; Mon, 11 Sep 2006 02:08:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 81B0E208A62; Mon, 11 Sep 2006 02:08:20 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac57nfb5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26839>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> > This is probably something that is easily solved by a simple fixed
> > record format holding a 20 byte SHA1 (binary) and a fixed width null
> > terminated string holding the ref name, with the records sorted
> > by ref name.  Its yet another file format with yet another set of
> > utilities needed but we pretty much have those (update-ref).
> 
> Yup.  That is one reasonable implementation of "single simple
> databasy file" I suggested.  Or we could just borrow .git/info/refs
> format.

I think Linus was suggesting the same thing, just not nearly as
obvious.  He also was looking for ways to not update it frequently.
But I can't say I'm a fan of negative entries. :-)

I'd probably rather code this as a fixed width binary heap file.
It should scale reasonable well to larger sets of refs.  I know
someone on the list wanted to store Perforce change identifiers
as tags in Git but it was taking up more disk in ref files than
in pack-*.pack.  That could be a very larger number of refs and
having O(log N) access there might be good.


But at this point I have more on my plate than I have time for.  :-)

I've got to get that map window code merged against master or next
(preference Junio?  next touches code I'm touching too but those
aren't in master yet) for 32 bit offset.  Should be slightly easier
to do but the pack verification change really threw a wrench into
my merge.  Other things have also kept me from really working on it.
I probably won't be able to look at it again until Wednesday.

I also want to spend more time on the dictionary packing prototype to
see if its worth spending even more time on.  My amd64 box is happily
installing itself as write this (finally!) so I now have some more
reasonable hardware to deal with transforming the Mozilla pack.  :)

-- 
Shawn.
