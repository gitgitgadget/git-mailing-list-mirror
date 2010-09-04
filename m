From: Ted Ts'o <tytso@mit.edu>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 14:14:05 -0400
Message-ID: <20100904181405.GB4887@thunk.org>
References: <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org>
 <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
 <alpine.LFD.2.00.1009040040030.19366@xanadu.home>
 <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
 <AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 20:14:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrxFy-0006tR-V9
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 20:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab0IDSOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 14:14:10 -0400
Received: from THUNK.ORG ([69.25.196.29]:40102 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab0IDSOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 14:14:09 -0400
Received: from root (helo=tytso-glaptop)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OrxFe-0001fP-63; Sat, 04 Sep 2010 14:14:06 -0400
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OrxFd-0006Jn-Hl; Sat, 04 Sep 2010 14:14:05 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155345>

On Sat, Sep 04, 2010 at 03:50:29PM +0100, Luke Kenneth Casson Leighton wrote:
> 
> :)  the legality or illegality isn't interesting - or is a... red
> herring, being one of the unfortunate anarchistic-word-associations
> with the concept of "file sharing".  the robustness and convenience
> aspects - to developers not users - is where it gets reaaally
> interesting.

I ask the question because I think being clear about what goals might
be are critically important.  If in fact the goals is to evade
detection be spreading out responsibility for code which is illegal in
some jurisdictions (even if they are commonly used and approved of by
people who aren't spending millions of dollars purchasing
congresscritters), there are many additional requirements that are
imposed on such a system.

If the goal is speeding up git downloads, then we need to be careful
about exactly what problem we are trying to solve.

>  i do not know of a single free software development tool - not a
> single one - which is peer-to-peer distributed.  just... none.  what
> does that say??  and we have people bitching about how great but
> non-free skype is.  there seems to be a complete lack of understanding
> of the benefits of peer-to-peer infrastructure in the free software
> community as a whole, and a complete lack of interest in the benefits,
> too...

Maybe it's because the benefits don't exist for many people?  At least
where I live, my local ISP (Comcast, which is very common internet
provider in the States) deliberately degrades the transfer of
peer2peer downloads.  As a result, it doesn't make sense for me to use
bittorrent to download the latest Ubuntu or Fedora iso image.  It's in
fact much faster for me to download it from an ftp site or a web site.

And git is *extremely* efficient about its network usage, since it
sends compressed deltas --- especially if you already have a base
responsitory estlablished.  For example, I took a git repository which
I haven't touched since August 4th --- exactly one month ago --- and
did a "git fetch" to bring it up to date by downloading from
git.kernel.org.  How much network traffic was required, after being
one month behind?  2.8MB of bytes received, 133k of bytes transmitted.

That's not a lot.  And it's well within the capabilities of even a
really busy server to handle.  Remember, peer2peer only helps if the
aggregate network bandwidth of the peers is greater than (a) your
download pipe, or (b) a central server's upload pipe.  And if we're
only transmitting 2.8MB, and a git.kernel.org has an aggregate
connection of over a gigabit per second to the internet --- it's not
likely that peer2peer would in fact result in a faster download.  Nor
is it likely that that git updates are likely to be something which
the kernel.org folks would even notice as a sizeable percentage of
their usable network bandwidth.  First of all, ISO image files are
much bigger, and secondly, there are many more users downloading ISO
files than there are developers downloading git updates, and certainly
relatively few developers downloading full git repositories (since
everybody genreally tries really hard to only do this once).

> - perhaps for reasons no more complex than the tools don't exist
> so it's catch-22, and the fact that the word "distributed" is
> _already_ associated with the likes of SMTP, DNS and "git" so
> everybody thinks "we're okay, jack, go play with your nice dreams of
> p2p networking, we're gonna write _real_ code now".

Well, perhaps it's because what we have right now works pretty well.   :-)

Which brings me back to my original question --- what problem exactly
are you trying to solve?  What's the scenario?

If the answer is "peer2peer is cool technology, and we want to play",
that's fine.  Put it would confirm the hypothesis that in this case,
peer2peer is a solution looking for a problem...

					- Ted
