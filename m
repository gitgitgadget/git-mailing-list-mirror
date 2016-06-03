From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] builtin/tag.c: convert trivial snprintf calls to
 xsnprintf
Date: Fri, 3 Jun 2016 04:52:32 -0400
Message-ID: <20160603085231.GB28401@sigill.intra.peff.net>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603074724.12173-3-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:52:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8kqT-0005o9-JD
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 10:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbcFCIwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 04:52:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:48311 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751538AbcFCIwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 04:52:35 -0400
Received: (qmail 1261 invoked by uid 102); 3 Jun 2016 08:52:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 04:52:35 -0400
Received: (qmail 19159 invoked by uid 107); 3 Jun 2016 08:52:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 04:52:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 04:52:32 -0400
Content-Disposition: inline
In-Reply-To: <20160603074724.12173-3-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296287>

On Fri, Jun 03, 2016 at 07:47:17AM +0000, Elia Pinto wrote:

>  builtin/tag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 50e4ae5..0345ca3 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -225,7 +225,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>  	if (type <= OBJ_NONE)
>  	    die(_("bad object type."));
>  
> -	header_len = snprintf(header_buf, sizeof(header_buf),
> +	header_len = xsnprintf(header_buf, sizeof(header_buf),
>  			  "object %s\n"
>  			  "type %s\n"
>  			  "tag %s\n"

This is another of my "type 2" cases. I'd argue it should be using a
heap buffer to handle tag and tagger names of arbitrary size.

-Peff
