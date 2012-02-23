From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] strbuf: improve strbuf_get*line documentation
Date: Thu, 23 Feb 2012 05:08:00 -0500
Message-ID: <20120223100800.GA2912@sigill.intra.peff.net>
References: <cover.1329988335.git.trast@student.ethz.ch>
 <d5522f8d1154321804cb60fb4f53d538242ead88.1329988335.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 23 11:08:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Var-0002dQ-LH
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 11:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab2BWKIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 05:08:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48640
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab2BWKID (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 05:08:03 -0500
Received: (qmail 8431 invoked by uid 107); 23 Feb 2012 10:08:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Feb 2012 05:08:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2012 05:08:00 -0500
Content-Disposition: inline
In-Reply-To: <d5522f8d1154321804cb60fb4f53d538242ead88.1329988335.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191346>

On Thu, Feb 23, 2012 at 10:42:21AM +0100, Thomas Rast wrote:

> strbuf_getline() was not documented very clearly, though a reader
> familiar with getline() would not have had any questions about it.
> strbuf_getwholeline() was not documented at all.

Thanks for improving the existing docs. One suggestion:

>  `strbuf_getline`::
>  
> -	Read a line from a FILE* pointer. The second argument specifies the line
> -	terminator character, typically `'\n'`.
> +	Read a line from a FILE*. The second argument specifies the
> +	line terminator character, typically `'\n'`.  Reading stops
> +	after the terminator or at EOF.  The terminator is removed
> +	from the buffer before returning.  Returns 0 unless there was
> +	nothing left before EOF, in which case it returns `EOF`.

The get*line functions are unlike the rest of the strbuf API in that
they overwrite, rather than append to, the strbuf argument. Maybe:

  s/from a FILE\*/&, overwriting the existing contents of the strbuf/

?

-Peff
