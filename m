From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Hint at "checkout -p" in the "reset --patch <type>"
 error message
Date: Tue, 23 Nov 2010 09:59:21 -0500
Message-ID: <20101123145921.GB3145@sigill.intra.peff.net>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
 <AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
 <AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
 <AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>
 <AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>
 <AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>
 <87mxp086k5.fsf_-_@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeenu V <jeenuv@gmail.com>, knittl <knittl89@googlemail.com>,
	git@vger.kernel.org
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 15:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKuLH-0005S8-9c
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 15:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab0KWO7Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 09:59:24 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47778 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755025Ab0KWO7X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 09:59:23 -0500
Received: (qmail 28369 invoked by uid 111); 23 Nov 2010 14:59:23 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 23 Nov 2010 14:59:23 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Nov 2010 09:59:21 -0500
Content-Disposition: inline
In-Reply-To: <87mxp086k5.fsf_-_@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161969>

On Tue, Nov 23, 2010 at 03:20:58PM +0100, =C5=A0t=C4=9Bp=C3=A1n N=C4=9B=
mec wrote:

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 0037be4..fc530d2 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -309,7 +309,8 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
> =20
>  	if (patch_mode) {
>  		if (reset_type !=3D NONE)
> -			die("--patch is incompatible with --{hard,mixed,soft}");
> +			die("--patch is incompatible with --{hard,mixed,soft}\n"
> +			    "(use \"git checkout -p\" to selectively discard changes in w=
orking directory)");
>  		return interactive_reset(rev, argv + i, prefix);
>  	}

Should this actually print something different for --hard versus --mixe=
d
versus --soft?

=46or --soft, "-p" simply makes no sense as you are not changing the in=
dex
or the working directory.

=46or --mixed, shouldn't we support "-p" already, as that is the defaul=
t
mode?

=46or --hard, suggesting "checkout -p" does make sense.

Also, what about "--merge" and "--keep" modes?

-Peff
