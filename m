From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/10] builtin/index-pack.c: convert trivial snprintf
 calls to xsnprintf
Date: Fri, 3 Jun 2016 04:53:20 -0400
Message-ID: <20160603085320.GC28401@sigill.intra.peff.net>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603074724.12173-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8krA-0006RX-SQ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 10:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbcFCIxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 04:53:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:48315 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751863AbcFCIxX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 04:53:23 -0400
Received: (qmail 1317 invoked by uid 102); 3 Jun 2016 08:53:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 04:53:23 -0400
Received: (qmail 19177 invoked by uid 107); 3 Jun 2016 08:53:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 04:53:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 04:53:20 -0400
Content-Disposition: inline
In-Reply-To: <20160603074724.12173-2-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296288>

On Fri, Jun 03, 2016 at 07:47:16AM +0000, Elia Pinto wrote:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index e8c71fc..c032fe7 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1443,7 +1443,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  		printf("%s\n", sha1_to_hex(sha1));
>  	} else {
>  		char buf[48];
> -		int len = snprintf(buf, sizeof(buf), "%s\t%s\n",
> +		int len = xsnprintf(buf, sizeof(buf), "%s\t%s\n",
>  				   report, sha1_to_hex(sha1));
>  		write_or_die(1, buf, len);

So it's pretty unclear here whether that 48 is big enough (it is, if you
read the whole function, because "report" is always a 4-char string).
Yuck. At least there should be a comment explaining why 48 is big
enough.

-Peff
