From: Jeff King <peff@peff.net>
Subject: Re: make install fails because GNU tar needed
Date: Thu, 28 Aug 2014 10:50:56 -0400
Message-ID: <20140828145056.GA26855@peff.net>
References: <267282067.24350.1409235408562.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: dev <dev@cor0.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:51:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN12V-0002HM-VL
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 16:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbaH1Ou7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 10:50:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:60802 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750812AbaH1Ou7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 10:50:59 -0400
Received: (qmail 9340 invoked by uid 102); 28 Aug 2014 14:50:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Aug 2014 09:50:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2014 10:50:56 -0400
Content-Disposition: inline
In-Reply-To: <267282067.24350.1409235408562.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256091>

On Thu, Aug 28, 2014 at 10:16:48AM -0400, dev wrote:

> # gmake CFLAGS="$CFLAGS" LDFLAGS="$LD_OPTIONS" NEEDS_LIBICONV=Yes \
> > SHELL_PATH=/usr/local/bin/bash \
> > SANE_TOOL_PATH=/usr/local/bin \
> > USE_LIBPCRE=1 LIBPCREDIR=/usr/local CURLDIR=/usr/local \
> > EXPATDIR=/usr/local NEEDS_LIBINTL_BEFORE_LIBICONV=1 \
> > NEEDS_SOCKET=1 NEEDS_RESOLV=1 USE_NSEC=1 \

As an aside, you may be able to drop some of these defines. For example,
we set NEEDS_SOCKET automatically on Solaris. See the "SunOS" section of
config.mak.uname for the complete set of defaults.

> Is there some magic somewhere to use ordinary POSIX tar ?

gmake TAR=tar ?

The default of gtar for Solaris dates back to 2005. There may have been
a reason then that is no longer valid now, or there may be something
besides "make install" which uses a more advanced feature.

> /bin/sh: gtar: /bin/shnot found
> : gtar: not found
> gmake[1]: *** [install] Error 1
> gmake: *** [install] Error 2
>
> [...]
>
> Also, what is shnot ?

Two messages stepping on each other's toes?

-Peff
