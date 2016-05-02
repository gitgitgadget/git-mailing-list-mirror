From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv5 1/2] http.c: implement the GIT_TRACE_CURL environment
 variable
Date: Mon, 2 May 2016 14:15:33 -0400
Message-ID: <20160502181533.GC8439@sigill.intra.peff.net>
References: <20160502142813.50868-1-gitter.spiros@gmail.com>
 <20160502142813.50868-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:15:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axINg-0007ym-RF
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbcEBSPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:15:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:60451 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754680AbcEBSPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:15:36 -0400
Received: (qmail 7460 invoked by uid 102); 2 May 2016 18:15:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 14:15:35 -0400
Received: (qmail 17112 invoked by uid 107); 2 May 2016 18:15:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 14:15:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 May 2016 14:15:33 -0400
Content-Disposition: inline
In-Reply-To: <20160502142813.50868-2-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293259>

On Mon, May 02, 2016 at 02:28:12PM +0000, Elia Pinto wrote:

> +		if (nopriv &&
> +			(skip_prefix(out.buf + prefix_len, "Authorization:", &header)
> +			|| skip_prefix(out.buf + prefix_len, "Proxy-Authorization:", &header))) {
> +			/* The first token is the type, which is OK to log */
> +			while (isspace(*header))
> +				header++;
> +			/* Everything else is opaque and possibly sensitive */

The first comment there is now misleading, as we _don't_ keep the first
token (though as mentioned elsewhere, I think we should).

> +void setup_curl_trace(CURL *handle)
> +{
> +	if (!trace_want(&trace_curl)) return;

Style: we always put conditional bodies on a new line, even when they
are trivial like this.

-Peff
