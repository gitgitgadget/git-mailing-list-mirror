From: Jeff King <peff@peff.net>
Subject: Re: How to stop sharing objects between repositories
Date: Mon, 17 Aug 2009 02:32:25 -0400
Message-ID: <20090817063225.GA31533@coredump.intra.peff.net>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
 <20090816135703.GA31638@coredump.intra.peff.net>
 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
 <20090817061916.GA27530@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 08:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcvlh-0001UK-3X
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 08:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308AbZHQGcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 02:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbZHQGcY
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 02:32:24 -0400
Received: from peff.net ([208.65.91.99]:44023 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbZHQGcY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 02:32:24 -0400
Received: (qmail 28735 invoked by uid 107); 17 Aug 2009 06:32:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 17 Aug 2009 02:32:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Aug 2009 02:32:25 -0400
Content-Disposition: inline
In-Reply-To: <20090817061916.GA27530@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126127>

On Mon, Aug 17, 2009 at 02:19:16AM -0400, Jeff King wrote:

>   1. "git repack -a" is sufficient to break dependency, as it copies
>      both packed and loose objects
> 
>   2. "git repack" _may_ break the dependency, if there are no packs, as
>      it copies only loose objects. It _may_ introduce inefficiency, but
>      only if there are loose objects.
> 
>   3. "git repack -l" always keeps the dependency and current efficiency.
> 
>      As an aside, making this list makes me realize there is no easy
>      "keep the dependency and increase efficiency". In other words, pack
>      everything that is not available otherwise, and then prune the
>      remaining packs.

OK, I take it back. "git repack -d -l -A" will get rid of any packs that
are redundant with your alternate.

-Peff
