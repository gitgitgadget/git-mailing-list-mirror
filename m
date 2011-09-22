From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] patch-id.c: use strbuf instead of a fixed buffer
Date: Thu, 22 Sep 2011 13:17:06 -0400
Message-ID: <20110922171706.GB2934@sigill.intra.peff.net>
References: <1316541771-sup-9996@pimlott.net>
 <7vehzb5602.fsf@alter.siamese.dyndns.org>
 <4E79DBAE.5090505@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 19:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6mte-0006vV-SK
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 19:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab1IVRRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 13:17:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40922
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab1IVRRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 13:17:08 -0400
Received: (qmail 9404 invoked by uid 107); 22 Sep 2011 17:22:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Sep 2011 13:22:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2011 13:17:06 -0400
Content-Disposition: inline
In-Reply-To: <4E79DBAE.5090505@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181902>

On Wed, Sep 21, 2011 at 02:42:22PM +0200, Michael Schubert wrote:

> get_one_patchid() uses a rather dumb heuristic to determine if the
> passed buffer is part of the next commit. Whenever the first 40 bytes
> are a valid hexadecimal sha1 representation, get_one_patchid() returns
> next_sha1.
> Once the current line is longer than the fixed buffer, this will break
> (provided the additional bytes make a valid hexadecimal sha1). As a result
> patch-id returns incorrect results. Instead, user strbuf and read one
> line at a time.

A minor nit, but I think this is probably broken even if the additional
bytes don't look like a valid sha1. It would look like cruft after the
diff (since the lien doesn't start with plus, minus, or space), which
means it would not be stirred into the sha1 mix.

>  builtin/patch-id.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)

The patch itself looks good to me, though. Thanks.

-Peff
