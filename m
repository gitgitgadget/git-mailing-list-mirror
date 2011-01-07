From: Jeff King <peff@peff.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Fri, 7 Jan 2011 00:31:19 -0500
Message-ID: <20110107053119.GA23177@sigill.intra.peff.net>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
 <20110107052207.GA23128@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 06:31:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb4vD-0002yY-1P
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 06:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab1AGFbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 00:31:23 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38250 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510Ab1AGFbW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 00:31:22 -0500
Received: (qmail 11924 invoked by uid 111); 7 Jan 2011 05:31:22 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 07 Jan 2011 05:31:22 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jan 2011 00:31:19 -0500
Content-Disposition: inline
In-Reply-To: <20110107052207.GA23128@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164701>

On Fri, Jan 07, 2011 at 12:22:07AM -0500, Jeff King wrote:

>   refs/mirrors/bundle/torrent
>   refs/mirrors/bundle/http
>   refs/mirrors/fetch/git
>   refs/mirrors/fetch/http
> 
> and the client can decide its preferred way of getting data: a bundle by
> http or by torrent, or connecting directly to some other git repository
> by git protocol or http. It would fetch the appropriate ref, which would
> contain a blob in some method-specific format. For torrent, it would be
> a torrent file. For the others, probably a newline-delimited set of
> URLs. You could also provide a torrent-magnet ref if you didn't even
> want to distribute the torrent file.
> 
> And no matter what the method used, at the end you have some set of refs
> and objects, and you can re-try your (now much smaller fetch).

And I think it is probably obvious to you, Nicolas, since these are
problems you have been thinking about for some time, but the reason I am
interested in this expanded definition of mirroring is for a few
features people have been asking for:

  1. restartable clone; any bundle format is easily restartable using
     standard protocols

  2. avoid too-big clones; I remember the gentoo folks wanting to
     disallow full clones from their actual dev machines and push people
     off to some more static method of pulling. I think not just because
     of restartability, but because of the load on the dev machines

  3. people on low-bandwidth servers who fork major projects; if I write
     three kernel patches and host a git server, I would really like
     people to only fetch my patches from me and get the rest of it from
     kernel.org

-Peff
