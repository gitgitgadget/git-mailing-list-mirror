From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/6] pretty: free the gpg status buf
Date: Fri, 13 Jun 2014 07:39:57 -0400
Message-ID: <20140613113957.GD14066@sigill.intra.peff.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
 <3211097b9e6eb07b98d3cefdaf4eabd0d2eb55b0.1402655839.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:40:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvPq2-00051F-NT
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 13:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbaFMLkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 07:40:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:43401 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751140AbaFMLkA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 07:40:00 -0400
Received: (qmail 22811 invoked by uid 102); 13 Jun 2014 11:40:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 06:40:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 07:39:57 -0400
Content-Disposition: inline
In-Reply-To: <3211097b9e6eb07b98d3cefdaf4eabd0d2eb55b0.1402655839.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251548>

On Fri, Jun 13, 2014 at 12:42:43PM +0200, Michael J Gruber wrote:

> 4a868fd (pretty: parse the gpg status lines rather than the output, 2013-02-14)
> made the gpg status lines available to callers and made sure they freed
> the used space, but missed one spot.
> 
> Free the status line buffer also in the remaining spot.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  pretty.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/pretty.c b/pretty.c
> index 4f51287..f1e8a70 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1538,6 +1538,7 @@ void format_commit_message(const struct commit *commit,
>  	free(context.commit_encoding);
>  	logmsg_free(context.message, commit);
>  	free(context.signature_check.gpg_output);
> +	free(context.signature_check.gpg_status);
>  	free(context.signature_check.signer);

What about .key?

I would have expected your patch 6 to come first, which would fix this,
and then save you from making similar mistakes in patch 3. :)

-Peff
