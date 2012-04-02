From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in
 prepare_revision_walk()
Date: Mon, 2 Apr 2012 16:51:12 -0400
Message-ID: <20120402205112.GA28824@sigill.intra.peff.net>
References: <201203291818.49933.mfick@codeaurora.org>
 <201204021024.49706.mfick@codeaurora.org>
 <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
 <201204021049.04901.mfick@codeaurora.org>
 <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
 <20120402203728.GB26503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 22:51:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEoDe-0004S2-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 22:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab2DBUvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 16:51:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43541
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861Ab2DBUvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 16:51:14 -0400
Received: (qmail 21318 invoked by uid 107); 2 Apr 2012 20:51:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Apr 2012 16:51:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2012 16:51:12 -0400
Content-Disposition: inline
In-Reply-To: <20120402203728.GB26503@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194560>

On Mon, Apr 02, 2012 at 04:37:28PM -0400, Jeff King wrote:

> Has anyone looked seriously at a new index format that stores the
> redundant information in a more easily accessible way? It would increase
> our disk usage, but for something like linux-2.6, only by 10MB per
> 32-bit word. On most of my systems I would gladly spare some extra RAM
> for the disk cache if it meant I could avoid inflating a bunch of
> objects.

Actually, that is an over-statement of the size. That would be a
per-object piece of metadata. A per-commit piece like timestamp would be
only 1M per 32-bit word in linux-2.6 (about 1/4 million commits). Or put
another way, we could store timestamps and 20-byte parent sha1s in about
11M.

-Peff
