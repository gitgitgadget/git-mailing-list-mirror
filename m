From: Jeff King <peff@peff.net>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Sun, 13 Sep 2015 06:17:27 -0400
Message-ID: <20150913101727.GB26562@sigill.intra.peff.net>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeffrey Walton <noloader@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 12:17:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb4Ln-0004ug-24
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 12:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbbIMKRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 06:17:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:58360 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752223AbbIMKR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 06:17:29 -0400
Received: (qmail 4110 invoked by uid 102); 13 Sep 2015 10:17:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Sep 2015 05:17:30 -0500
Received: (qmail 17511 invoked by uid 107); 13 Sep 2015 10:17:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Sep 2015 06:17:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2015 06:17:27 -0400
Content-Disposition: inline
In-Reply-To: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277773>

On Sun, Aug 30, 2015 at 05:34:59PM -0400, Jeffrey Walton wrote:

> I'm working on an old OS X machine. I needed to perform:
> 
>   AR=libtool
>   ARFLAGS="-static -o"
>   ...
>   make configure
>   ./configure ...
>   make

Hrm. Your "$(AR)" is not really "ar" then, is it? It has been a long
time since I played with libtool, but what is the reason that you are
calling libtool and not "ar" in the first place. Is it that you do not
have "ar" at all, and libtool performs some other procedure? If so, is
there a more ar-compatible wrapper that can be used?

> The Makefile might benefit from the following for users who need to
> tweak things:
> 
>     ARFLAGS ?= rcs
>     ...
> 
>     $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>     ...

Yeah, that does sound reasonable (even if one does not set $(AR) to
something completely different, they might need slightly different
flags).

Care to send a patch?

-Peff
