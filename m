From: Jeff King <peff@peff.net>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Wed, 1 Jun 2011 18:53:50 -0400
Message-ID: <20110601225350.GC16820@sigill.intra.peff.net>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
 <20110601220518.GA32681@sigill.intra.peff.net>
 <7vipspfazy.fsf@alter.siamese.dyndns.org>
 <20110601224754.GA16820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:53:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRuIY-00048W-3s
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758811Ab1FAWxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:53:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60178
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855Ab1FAWxw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:53:52 -0400
Received: (qmail 18850 invoked by uid 107); 1 Jun 2011 22:53:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 18:53:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 18:53:50 -0400
Content-Disposition: inline
In-Reply-To: <20110601224754.GA16820@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174916>

On Wed, Jun 01, 2011 at 06:47:54PM -0400, Jeff King wrote:

> > Probably. As HEAD is usually visible via ls-remote exchange, the usual
> > security concern would not come into the picture even if we do (1), even
> > though it feels somewhat wrong to do.
> 
> Yeah, one can always just do:
> 
>   git fetch origin HEAD && git checkout FETCH_HEAD
> 
> immediately afterwards. But I think given that we make some effort to
> propagate detached-ness across a clone in cases where we can, we should
> just do the fetch.

Re-reading what I wrote, it's horribly unclear. What I meant was:

  We already make some effort to propagate detached-ness across a clone
  in cases where the detached commit is found in referenced history. To
  not do so for the case where the detached commit is not an ancestor of
  any ref seems unnecessarily inconsistent. Therefore we should solve
  the problem not by refusing to handle the detached HEAD, but by
  correctly fetching the objects.

-Peff
