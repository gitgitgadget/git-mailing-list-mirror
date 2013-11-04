From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rename suffixcmp() to has_suffix()
Date: Mon, 4 Nov 2013 14:06:50 -0800
Message-ID: <20131104220650.GA26636@sigill.intra.peff.net>
References: <20131104214512.19757.74215.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 04 23:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdSIT-0000nB-QA
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 23:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab3KDWGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 17:06:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:33345 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751155Ab3KDWGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 17:06:53 -0500
Received: (qmail 32041 invoked by uid 102); 4 Nov 2013 22:06:52 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Nov 2013 16:06:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Nov 2013 14:06:50 -0800
Content-Disposition: inline
In-Reply-To: <20131104214512.19757.74215.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237308>

On Mon, Nov 04, 2013 at 10:45:11PM +0100, Christian Couder wrote:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 874e0fd..4b8308e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -510,7 +510,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
>  	for (ref = refs; ref; ref = ref->next) {
>  		if (prefixcmp(ref->name, "refs/tags/"))
>  			continue;
> -		if (!suffixcmp(ref->name, "^{}"))
> +		if (!has_suffix(ref->name, "^{}"))

I think the intent of your patch is reasonable, but doesn't it flip the
logic of the return value? That is, shouldn't this become:

  if (has_suffix(...))

?

-Peff
