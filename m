From: Jeff King <peff@peff.net>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 04:14:40 -0400
Message-ID: <20070730081439.GA907@coredump.intra.peff.net>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com> <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org> <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net> <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de> <20070730074937.GT20052@spearce.org> <577C7529-4C3C-40D4-B86A-8B3CE888C997@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFQOv-0001es-6f
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 10:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbXG3IOp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 04:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756215AbXG3IOo
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 04:14:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3702 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbXG3IOn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 04:14:43 -0400
Received: (qmail 10760 invoked from network); 30 Jul 2007 08:14:43 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Jul 2007 08:14:43 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2007 04:14:40 -0400
Content-Disposition: inline
In-Reply-To: <577C7529-4C3C-40D4-B86A-8B3CE888C997@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54202>

On Mon, Jul 30, 2007 at 10:09:16AM +0200, Steffen Prohaska wrote:

> I needed to slightly modify it
>
>     git config --global alias.force-commit \
>     '! git update-ref HEAD $(echo MARK | git commit-tree $(git cat-file 
> commit HEAD | grep ^tree | cut -b 6-) -p HEAD)'

How about "git commit-tree HEAD^{tree} -p HEAD"?

But I think making a "fake" commit to force non-fast-forward is the
wrong thing. You really want to make your "extra" commit be the merge
that wouldn't have happened (which unfortunately is not as simple as
just creating a commit by hand, since you have to actually _do_ the
merge to get the tree).

-Peff
