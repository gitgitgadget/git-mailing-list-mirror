From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] api-credential.txt: document that helpers field is
 filled-in automatically
Date: Mon, 11 Jun 2012 15:08:11 -0400
Message-ID: <20120611190811.GB20889@sigill.intra.peff.net>
References: <7vzk897rqi.fsf@alter.siamese.dyndns.org>
 <1339437107-25909-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:08:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9yM-00050Y-Sx
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905Ab2FKTIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 15:08:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50285
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab2FKTIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:08:14 -0400
Received: (qmail 7983 invoked by uid 107); 11 Jun 2012 19:08:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 15:08:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 15:08:11 -0400
Content-Disposition: inline
In-Reply-To: <1339437107-25909-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199706>

On Mon, Jun 11, 2012 at 07:51:47PM +0200, Matthieu Moy wrote:

> It was unclear whether the field was to be specified by the user of the
> API.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> > It is correct that the C API asks helpers that the user configured,
> > but I think it is common across three API functions, not limited to
> > credential_fill().  credential_apply_config() is called from approve
> > and reject, too.
> 
> Ah, right, so compared to v1, we can move the sentence to the
> description of the "helpers" field, like this:

I think this is OK. Technically it loads other matching config, as well
(filling in default username fields and respecting useHttpPath). I don't
know if it is worth mentioning them, too.

> diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
> index 21ca6a2..48f51ed 100644
> --- a/Documentation/technical/api-credentials.txt
> +++ b/Documentation/technical/api-credentials.txt
> @@ -21,7 +21,9 @@ Data Structures
>  The `helpers` member of the struct is a `string_list` of helpers.  Each
>  string specifies an external helper which will be run, in order, to
>  either acquire or store credentials. See the section on credential
> -helpers below.
> +helpers below. This list is filled-in by the API functions
> +according to the corresponding configuration variables before
> +consulting helpers.

You might want to say something like "...and therefore there is usually
no need for a caller to modify the helpers field at all".

-Peff
