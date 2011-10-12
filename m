From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http_init: accept separate URL parameter
Date: Wed, 12 Oct 2011 17:46:10 -0400
Message-ID: <20111012214610.GA4578@sigill.intra.peff.net>
References: <4E95FDC8.5030009@drmicha.warpmail.net>
 <20111012214316.GA4393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE6d0-0004h5-3j
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 23:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab1JLVqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 17:46:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58921
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753490Ab1JLVqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 17:46:12 -0400
Received: (qmail 18546 invoked by uid 107); 12 Oct 2011 21:46:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 17:46:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 17:46:10 -0400
Content-Disposition: inline
In-Reply-To: <20111012214316.GA4393@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183420>

On Wed, Oct 12, 2011 at 05:43:16PM -0400, Jeff King wrote:

> The http_init function takes a "struct remote". Part of its
> initialization procedure is to look at the remote's url and
> grab some auth-related parameters. However, using the url
> included in the remote is:
> 
>   - wrong; the remote-curl helper may have a separate,
>     unrelated URL (e.g., from remote.*.pushurl). Looking at
>     the remote's configured url is incorrect.
> 
>   - incomplete; http-fetch doesn't have a remote, so passes
>     NULL. So http_init never gets to see the URL we are
>     actually going to use.
> 
>   - cumbersome; http-push has a similar problem to
>     http-fetch, but actually builds a fake remote just to
>     pass in the URL.
> 
> Instead, let's just add a separate URL parameter to
> http_init, and all three callsites can pass in the
> appropriate information.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Sorry, I forgot to mention: this is meant to go on top of the
http-auth-keyring topic.

-Peff
