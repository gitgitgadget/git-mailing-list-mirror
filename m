From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] credential-cache, send_request: close fd when done
Date: Tue, 29 Mar 2016 21:20:00 -0400
Message-ID: <20160330011959.GE2237@sigill.intra.peff.net>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
 <1459298333-21899-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:20:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4nq-0001m3-45
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758352AbcC3BUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:20:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:40490 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753595AbcC3BUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:20:03 -0400
Received: (qmail 23188 invoked by uid 102); 30 Mar 2016 01:20:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:20:02 -0400
Received: (qmail 30365 invoked by uid 107); 30 Mar 2016 01:20:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:20:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 21:20:00 -0400
Content-Disposition: inline
In-Reply-To: <1459298333-21899-7-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290250>

On Tue, Mar 29, 2016 at 05:38:53PM -0700, Stefan Beller wrote:

> No need to keep it open any further.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  credential-cache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/credential-cache.c b/credential-cache.c
> index f4afdc6..86e21de 100644
> --- a/credential-cache.c
> +++ b/credential-cache.c
> @@ -32,6 +32,7 @@ static int send_request(const char *socket, const struct strbuf *out)
>  		write_or_die(1, in, r);
>  		got_data = 1;
>  	}
> +	close(fd);
>  	return got_data;
>  }

Looks good. I think nobody ever noticed because credential-cache
basically sends off the request and then exits.

-Peff
