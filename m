From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Disown ssh+git and git+ssh
Date: Fri, 12 Feb 2016 13:40:24 -0500
Message-ID: <20160212184023.GD19973@sigill.intra.peff.net>
References: <1455289777-186690-1-git-send-email-cmn@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:40:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIdt-0002nF-RQ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbcBLSk1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 13:40:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:41140 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751242AbcBLSk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 13:40:26 -0500
Received: (qmail 13360 invoked by uid 102); 12 Feb 2016 18:40:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 13:40:26 -0500
Received: (qmail 18257 invoked by uid 107); 12 Feb 2016 18:40:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 13:40:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 13:40:24 -0500
Content-Disposition: inline
In-Reply-To: <1455289777-186690-1-git-send-email-cmn@dwim.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286067>

On Fri, Feb 12, 2016 at 04:09:37PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> These were silly from the beginning, but we have to support them for
> compatibility. That doesn't mean we have to show them in the
> documentation. These were already left out of the main list, but a
> reference in the main manpage was left, so remove that.

Yeah, that reference was added by me to try to be thorough, but I think
mentioning ssh:// (as you do here) accomplishes the same goal in a
better way.

> Also add a note to discourage their use if anybody goes looking for t=
hem
> in the source code.

Sounds like a good plan.

> diff --git a/transport.c b/transport.c
> index 9ae7184..f5ae707 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1002,6 +1002,10 @@ struct transport *transport_get(struct remote =
*remote, const char *url)
>  		|| starts_with(url, "file://")
>  		|| starts_with(url, "git://")
>  		|| starts_with(url, "ssh://")
> +		/*
> +		 * These ssh schemes remain supported for compat but are
> +		 * undocumented and their use is discouraged
> +		 */
>  		|| starts_with(url, "git+ssh://")
>  		|| starts_with(url, "ssh+git://")) {
>  		/*

Breaking apart an ||-chain with a comment like this is a little odd, bu=
t
I think the result is reasonably readable, so it's probably OK.

The rest of the patch is obviously correct. Thanks for following up on
the earlier discussion.

-Peff
