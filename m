From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase: ignore failures from "gc --auto"
Date: Wed, 13 Jan 2016 15:12:38 -0500
Message-ID: <20160113201238.GA6978@sigill.intra.peff.net>
References: <20160113184718.GA5647@sigill.intra.peff.net>
 <20160113194011.GD20764@sdfg.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:13:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJRnP-0006or-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 21:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548AbcAMUN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 15:13:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:53240 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758386AbcAMUMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 15:12:41 -0500
Received: (qmail 12146 invoked by uid 102); 13 Jan 2016 20:12:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 15:12:41 -0500
Received: (qmail 32443 invoked by uid 107); 13 Jan 2016 20:12:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 15:12:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2016 15:12:38 -0500
Content-Disposition: inline
In-Reply-To: <20160113194011.GD20764@sdfg.com.ar>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283981>

On Wed, Jan 13, 2016 at 04:40:11PM -0300, Rodrigo Campos wrote:

> On Wed, Jan 13, 2016 at 01:47:18PM -0500, Jeff King wrote:
> > After rebasing, we call "gc --auto" to clean up if we
> > created a lot of loose objects. However, we do so inside an
> > &&-chain. If "gc --auto" fails (e.g., because a previous
> > background gc blocked us by leaving "gc.log" in place),
> > then:
> > 
> >   1. We will fail to clean up the state directory, leaving
> >      the user stuck in the rebase forever (even "git am
> >      --abort" doesn't work, because it calls "gc --auto"!).
> 
> Just curious, but do you mean "git rebase --abort" ?

Yeah, sorry, I did mean "git rebase --abort".

-Peff
