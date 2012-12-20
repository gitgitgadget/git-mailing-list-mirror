From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Thu, 20 Dec 2012 14:50:10 -0500
Message-ID: <20121220195010.GA21785@sigill.intra.peff.net>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
 <7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
 <20121220153411.GA1497@sigill.intra.peff.net>
 <CAOkDyE9y6JvNKTCBoJqu47Hn-3axfjZPUdBhf4bOEfSP-9Q84A@mail.gmail.com>
 <20121220161110.GA10605@sigill.intra.peff.net>
 <7vy5gs4jiy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 20:50:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlm8V-0006mi-T2
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 20:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972Ab2LTTuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 14:50:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60006 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab2LTTuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 14:50:12 -0500
Received: (qmail 14217 invoked by uid 107); 20 Dec 2012 19:51:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 14:51:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 14:50:10 -0500
Content-Disposition: inline
In-Reply-To: <7vy5gs4jiy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211920>

On Thu, Dec 20, 2012 at 11:21:09AM -0800, Junio C Hamano wrote:

> The "expected_failure" cases painted in "warn" are all long-known
> failures; I do not think reminding about them in "bold" over and
> over will help encouraging the developers take a look at them.
> 
> The "skipped" cases fall into two categories.  Either you already
> know you choose to not to care (e.g. I do not expect to use git-p4
> and decided not to install p4 anywhere, so I may have t98?? on
> GIT_SKIP_TESTS environment) or you haven't reached that point on a
> new system and haven't realized that you didn't install a package
> needed to run tests you care about (e.g. cvsserver tests would not
> run without Perl interface to SQLite).  For the former, the bold
> output is merely distracting; for the latter, bold _might_ help in
> this case.
> 
> At least, I think
> 
> 	GIT_SKIP_TESTS=t98?? sh t9800-git-p4-basic.sh -v
> 
> should paint "skipping test t9800 altogether" (emitted with "-v) and
> the last line "1..0 # SKIP skip all tests in t9800" both in the same
> "info" color.
> 
> How about going further to reduce "bold" a bit more, like this?

Yeah, I think it is a little easier on the eyes while maintaining the
intended color scheme.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index aaf013e..2bbb81d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -182,13 +182,13 @@ then
>  		error)
>  			tput bold; tput setaf 1;; # bold red
>  		skip)
> -			tput bold; tput setaf 4;; # bold blue
> +			tput setaf 4;; # bold blue

On my xterm, at least, this is actually the difference between light
blue" and dark blue, not bold and not-bold. I think it is OK, though to
be honest, having seen the "skip all" messages in cyan (e.g., running
t9800), I think just printing skip messages in cyan looks best. But it
is not that big a deal to me, and we are well into bikeshed territory, I
think, so that will be my last word on the subject.

-Peff
