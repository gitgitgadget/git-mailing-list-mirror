From: Jeff King <peff@peff.net>
Subject: Re: Bug: t5813 failing on Cygwin
Date: Sat, 7 Nov 2015 13:45:27 -0500
Message-ID: <20151107184527.GA4483@sigill.intra.peff.net>
References: <563DEA71.1080808@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Sat Nov 07 19:46:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zv8V2-00055I-3A
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 19:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbbKGSpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 13:45:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:54570 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753528AbbKGSpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2015 13:45:30 -0500
Received: (qmail 1937 invoked by uid 102); 7 Nov 2015 18:45:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Nov 2015 12:45:30 -0600
Received: (qmail 4899 invoked by uid 107); 7 Nov 2015 18:45:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Nov 2015 13:45:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Nov 2015 13:45:27 -0500
Content-Disposition: inline
In-Reply-To: <563DEA71.1080808@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281021>

On Sat, Nov 07, 2015 at 12:11:29PM +0000, Adam Dinwoodie wrote:

> Specifically, I'm seeing t5813 subtests 9-13 and 15-19 failing. This happens
> with a clean build straight from the Git source tree (git clean -dfx && make
> configure && ./configure && make && cd t && ./t5813-proto-disable-ssh.sh) as
> well as builds using the Cygwin packaging paraphernalia.

What does the output of "./t5813-proto-disable-ssh.sh -v -i" show?

It seems strange that it would fail only on Cygwin; this code doesn't
really use any platform-dependent features. It's also weird that it
fails _only_ for ssh, and _only_ on the tests that are using "ssh://"
URLs are not "host:path" syntax.

I tried building on Linux with the Cygwin build knobs found in
config.mak.uname, but I couldn't get it to fail. I also wondered if the
test was doing something with the shell that might not be portable, but
I don't see anything interesting.

-Peff
