From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] builtin-apply: use warning() instead of
	fprintf(stderr, "warning: ")
Date: Thu, 19 Feb 2009 22:02:45 -0500
Message-ID: <20090220030245.GC22419@coredump.intra.peff.net>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net> <4f61642d10063adbff86094e91b1b6e90efabe8e.1235047192.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 04:04:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaLgZ-0001GU-UM
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 04:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbZBTDCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 22:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbZBTDCs
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 22:02:48 -0500
Received: from peff.net ([208.65.91.99]:59565 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbZBTDCs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 22:02:48 -0500
Received: (qmail 31101 invoked by uid 107); 20 Feb 2009 03:03:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 22:03:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 22:02:45 -0500
Content-Disposition: inline
In-Reply-To: <4f61642d10063adbff86094e91b1b6e90efabe8e.1235047192.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110783>

On Thu, Feb 19, 2009 at 01:53:10PM +0100, Miklos Vajna wrote:

> @@ -2932,8 +2932,7 @@ static int write_out_one_reject(struct patch *patch)
>  	cnt = strlen(patch->new_name);
>  	if (ARRAY_SIZE(namebuf) <= cnt + 5) {
>  		cnt = ARRAY_SIZE(namebuf) - 5;
> -		fprintf(stderr,
> -			"warning: truncating .rej filename to %.*s.rej",
> +		warning("truncating .rej filename to %.*s.rej",
>  			cnt - 1, patch->new_name);
>  	}

Hmm. This hunk is actually changing behavior, as the original didn't
have a newline. It looks like a bug in the original, though.

Other than that, these all look pretty straightforward. Probably the
shell scripts should be switched to match, too. But it would be nice to
hear from Junio first that this cleanup is even desired (so you don't
waste time).

-Peff
