From: Jeff King <peff@peff.net>
Subject: Re: git 2.1.0: make fails
Date: Tue, 9 Sep 2014 18:42:01 -0400
Message-ID: <20140909224201.GE14029@peff.net>
References: <540F643A.60207@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gerry Reno <greno@verizon.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRU72-00018X-2Z
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbaIIWmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:42:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:46259 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752679AbaIIWmE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:42:04 -0400
Received: (qmail 20522 invoked by uid 102); 9 Sep 2014 22:42:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 17:42:04 -0500
Received: (qmail 11683 invoked by uid 107); 9 Sep 2014 22:42:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 18:42:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2014 18:42:01 -0400
Content-Disposition: inline
In-Reply-To: <540F643A.60207@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256723>

On Tue, Sep 09, 2014 at 04:34:02PM -0400, Gerry Reno wrote:

> Downloaded the git-2.1.0.tar.gz  tarball.
> 
> Cannot build git 2.1.0:

Weird. It works fine for me on Debian unstable. What platform are you on?

>     cc  -g -O2 -Wall -I. -DHAVE_ALLOCA_H  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME
>     -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS -DSHELL_PATH='"/bin/sh"' -o git-credential-store  
>     credential-store.o libgit.a xdiff/lib.a  -lz  -lcrypto -lpthread -lrt
>     collect2: ld returned 1 exit status
>     make: *** [git-credential-store] Error 1

So the linker failed, but it didn't actually tell us why. That's not
much to go on. Are you sure there was no other output on stderr?

I assume the reason it broke on git-credential-store is just because it
is the first thing we try to link. What does:

  make V=1 prefix=/usr/local git

output? Does it successfully link "git"?

-Peff
