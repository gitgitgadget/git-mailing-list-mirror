From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diffcore-rename: fall back to -C when -C -C busts
 the rename limit
Date: Wed, 23 Mar 2011 14:17:56 -0400
Message-ID: <20110323181756.GA17415@sigill.intra.peff.net>
References: <7vk4fqkewo.fsf@alter.siamese.dyndns.org>
 <1300830649-22830-1-git-send-email-gitster@pobox.com>
 <1300830649-22830-3-git-send-email-gitster@pobox.com>
 <20110323155854.GB30337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:18:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2SdD-0004b5-EC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 19:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458Ab1CWSSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 14:18:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39343
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756439Ab1CWSSA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 14:18:00 -0400
Received: (qmail 8273 invoked by uid 107); 23 Mar 2011 18:18:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 14:18:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 14:17:56 -0400
Content-Disposition: inline
In-Reply-To: <20110323155854.GB30337@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169863>

On Wed, Mar 23, 2011 at 11:58:54AM -0400, Jeff King wrote:

> Also, on a somewhat related note: which commands should have rename
> progress reporting turned on? It makes sense for "git diff" to do it to
> me. And probably even "git show". Probably not for "git log", though.
> I think we'd also have to look at how that interacts with the
> stderr-to-stdout pager thing. We obviously don't want progress going to
> the pager.

This quick-and-dirty series makes rename progress work properly for "git
show". Patch 1/3 would also be the building block for having "git log"
show per-commit warnings when stderr and stdout are mixed, but a single
warning otherwise. I built it on top of your patches, but I think there
is no reason it could not be done in parallel.

  [1/3]: pager: save the original stderr when redirecting to pager
  [2/3]: progress: use pager's original_stderr if available
  [3/3]: show: turn on rename progress

-Peff
