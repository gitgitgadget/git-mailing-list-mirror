From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] cache.h: eliminate SHA-1 deprecation warnings on OS X
 10.8
Date: Sat, 11 May 2013 11:50:36 +0200
Message-ID: <20130511095035.GA17326@sigill.intra.peff.net>
References: <1368240282-89581-1-git-send-email-davvid@gmail.com>
 <20130511062336.GD3394@elie>
 <CAJDDKr6QkeSk32kNhU_QuvrZSGUEokcEbN7Aq3PcOhvaA_hFgg@mail.gmail.com>
 <20130511082203.GA953@sigill.intra.peff.net>
 <CAJDDKr7-sMrX=2Aek1LY8knM2jFPs933eLj3iZdTa68YYv-6Og@mail.gmail.com>
 <20130511084543.GA1905@sigill.intra.peff.net>
 <CAJDDKr4DoEUw=4O_m-91Hsg4SRZzkn6yJPf_nBsPsEv0Weibrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 11:50:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub6S2-0006HS-VA
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 11:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab3EKJur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 05:50:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:56167 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753177Ab3EKJuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 05:50:46 -0400
Received: (qmail 20881 invoked by uid 102); 11 May 2013 09:51:10 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 11 May 2013 04:51:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 11:50:36 +0200
Content-Disposition: inline
In-Reply-To: <CAJDDKr4DoEUw=4O_m-91Hsg4SRZzkn6yJPf_nBsPsEv0Weibrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223951>

On Sat, May 11, 2013 at 02:17:10AM -0700, David Aguilar wrote:

> Good catch.  I had a config.mak without any -O flags in CFLAGS.
> Here are the timings with -O3.  We're back to parity.
> 
> $ time git rev-list --all --objects --verify-objects >/dev/null
> 
> # CommonCrypto 28.95s user 4.62s system 99% cpu 33.630 total
> # master       29.81s user 4.70s system 99% cpu 34.760 total
> # BLK_SHA1     29.80s user 4.62s system 99% cpu 34.505 total
> 
> If BLK_SHA1 were the default on all platforms then I wouldn't have
> bothered with the SHA-1 patch.  With this patch it makes it like Linux
> in that Git can choose between the built-in functions and the external
> library.

With those numbers above, it seems like CommonCrypto is still a
reasonable choice. I don't know anything about availability or other OS
X specific issues, but assuming there are no issues there, your patch
makes sense to me. Thanks for double-checking the timings.

-Peff
