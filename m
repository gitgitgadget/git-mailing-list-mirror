From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] git.1: Clarify the behavior of the --paginate
 option
Date: Sun, 14 Feb 2010 23:55:35 -0500
Message-ID: <20100215045535.GD3336@coredump.intra.peff.net>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214120235.GC3499@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 05:55:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngszg-0006TE-IX
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 05:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab0BOEzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 23:55:31 -0500
Received: from peff.net ([208.65.91.99]:42712 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218Ab0BOEzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 23:55:31 -0500
Received: (qmail 13201 invoked by uid 107); 15 Feb 2010 04:55:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Feb 2010 23:55:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2010 23:55:35 -0500
Content-Disposition: inline
In-Reply-To: <20100214120235.GC3499@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139971>

On Sun, Feb 14, 2010 at 06:02:35AM -0600, Jonathan Nieder wrote:

> The --paginate option is meant to negate the effect of an explicit or
> implicit pager.<cmd> = false setting.  Thus it turns the pager on if
> output is going to a terminal rather than unconditionally.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Noticed while testing.  (It might be nice to have an --always-paginate
> facility to allow debugging by writing output from a pager into
> something that is not a terminal.)

Hmm. I would have expected --pager to have the "always" effect, though I
will admit I never actually use it (--no-pager, on the other hand...).
But if nobody is complaining, I certainly don't want to change the
behavior haphazardly, and documenting it makes sense. Thanks.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 01c4631..f26641a 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -229,7 +229,10 @@ help ...`.
>  
>  -p::
>  --paginate::
> -	Pipe all output into 'less' (or if set, $PAGER).
> +	Pipe all output into 'less' (or if set, $PAGER) if standard
> +	output is a terminal.  This overrides the `pager.<cmd>`
> +	configuration options (see the "Configuration Mechanism" section
> +	below).

The "Configuration Mechanism" section doesn't actually contain anything
related. I guess you were going for "point to that section, and then it
will point to the list of config", which explains this:

> @@ -401,7 +404,8 @@ people.  Here is an example:
>  ------------
>  
>  Various commands read from the configuration file and adjust
> -their operation accordingly.
> +their operation accordingly.  See linkgit:git-config[1] for a
> +list.

which seemed at first to be unrelated (but I think is a good change
regardless).

It seems like a long jump for somebody who doesn't know what pager.*
does to follow, but I guess it doesn't hurt to try to provide pointers.
I have long since forgotten what it is like to not know that
"git-config" contains the list of options. :)

-Peff
