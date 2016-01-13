From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 13 Jan 2016 15:23:29 -0500
Message-ID: <20160113202329.GA7678@sigill.intra.peff.net>
References: <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
 <CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
 <xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
 <CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
 <20151104200249.GC16101@sigill.intra.peff.net>
 <CAEtYS8S_ys3jT5ziWd7_u6Dn8b3LwnZYO7Pz6EegsmWpUM5riw@mail.gmail.com>
 <20151230073759.GA785@sigill.intra.peff.net>
 <CAEtYS8Qs2B3rP1PDGhoWGAgcj2c_pOTpt=s8qj9tWMjkLLFyhQ@mail.gmail.com>
 <xmqqvb6xmedw.fsf@gitster.mtv.corp.google.com>
 <CAEtYS8RA2HONEARQ03EiT8Ch+F2am+YJuRz2hNiSGO25N8Lf4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:23:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJRxA-0003sq-QH
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 21:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933363AbcAMUXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 15:23:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:53257 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933310AbcAMUXb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 15:23:31 -0500
Received: (qmail 12632 invoked by uid 102); 13 Jan 2016 20:23:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 15:23:31 -0500
Received: (qmail 32639 invoked by uid 107); 13 Jan 2016 20:23:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 15:23:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2016 15:23:29 -0500
Content-Disposition: inline
In-Reply-To: <CAEtYS8RA2HONEARQ03EiT8Ch+F2am+YJuRz2hNiSGO25N8Lf4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283983>

On Wed, Jan 13, 2016 at 02:19:05PM -0600, Doug Kelly wrote:

> However, back to the point: should the wait value be hard coded? Configurable
> as a new option?  What should our default wait be?

I'd think it would make sense to match the expiration time we feed to
prune. That's overly conservative, but I think that's OK (and the user
can tweak it down).

-Peff
