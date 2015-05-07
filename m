From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: skip dav http-push tests under NO_EXPAT=NoThanks
Date: Thu, 7 May 2015 12:13:11 -0400
Message-ID: <20150507161311.GA26219@peff.net>
References: <xmqq6185d4o1.fsf@gitster.dls.corp.google.com>
 <20150506173200.GA7985@peff.net>
 <xmqqvbg5tubj.fsf@gitster.dls.corp.google.com>
 <xmqqzj5gqsnd.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:13:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOQP-0007Af-F4
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbbEGQNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:13:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:55250 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750933AbbEGQNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:13:15 -0400
Received: (qmail 32564 invoked by uid 102); 7 May 2015 16:13:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 May 2015 11:13:14 -0500
Received: (qmail 10679 invoked by uid 107); 7 May 2015 16:13:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 May 2015 12:13:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 May 2015 12:13:11 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzj5gqsnd.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268540>

On Thu, May 07, 2015 at 09:06:14AM -0700, Junio C Hamano wrote:

> When built with NO_EXPAT=NoThanks, we will not have a working http-push
> over webdav.

Hmph, I used to build with NO_EXPAT long ago and don't remember running
into this, but it is clearly broken now. I wonder what bizarre
combination of leftover build products made it work. ;)

> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 872a252..d823664 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -36,6 +36,12 @@ then
>  	test_done
>  fi
>  
> +if test -n "$NO_EXPAT" && test -n "$LIB_HTTPD_DAV"
> +then
> +	skip_all='skipping test, git built without expat support'
> +	test_done
> +fi

I was confused at first why this is in lib-httpd.sh and not 5540, but I
see LIB_HTTPD_DAV is provided by t5540 as a feature flag to
lib-httpd.sh. I learn something new every day about our test
infrastructure.

-Peff
