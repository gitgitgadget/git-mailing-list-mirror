From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] gitattributes: Clarify discussion of attribute macros
Date: Wed, 3 Aug 2011 13:46:32 -0600
Message-ID: <20110803194632.GB23848@sigill.intra.peff.net>
References: <1312378890-31703-1-git-send-email-mhagger@alum.mit.edu>
 <1312378890-31703-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 03 21:46:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QohOr-00050o-9l
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 21:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab1HCTqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 15:46:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52228
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487Ab1HCTqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 15:46:35 -0400
Received: (qmail 9839 invoked by uid 107); 3 Aug 2011 19:47:09 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 15:47:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 13:46:32 -0600
Content-Disposition: inline
In-Reply-To: <1312378890-31703-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178616>

On Wed, Aug 03, 2011 at 03:41:29PM +0200, Michael Haggerty wrote:

> -which is equivalent to the above.  Note that the attribute macros can only
> -be "Set" (see the above example that sets "binary" macro as if it were an
> -ordinary attribute --- setting it in turn unsets "text" and "diff").
> +Setting the "binary" attribute also unsets the "text" and "diff"
> +attributes as above.  Note that attribute macros can only be "Set",
> +though setting one might have the effect of setting or unsetting other
> +attributes or even returning other attributes to the "Unspecified"
> +state.

This is slightly confusing. You can "unset" an attribute macro, and it
will be reported as "unset". Which seems to contradict what is written
above (although the error comes from the previous text). I think there
are two possibilities for what a user might expect unsetting a macro to
do for the sub-attributes:

  1. Leave them unspecified.

  2. Negate them (i.e., "-binary" means "text diff".

and we do (1).

I don't know if that was intentional, or if the behavior is simply
accidental and the original code was simply never meant to have
"-binary" called at all.

-Peff
