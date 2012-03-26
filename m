From: Jeff King <peff@peff.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Mon, 26 Mar 2012 13:33:01 -0400
Message-ID: <20120326173301.GE7942@sigill.intra.peff.net>
References: <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net>
 <4F6A33C5.2080909@gmx.net>
 <20120321201722.GA15021@sigill.intra.peff.net>
 <4F6E3373.7090500@gmx.net>
 <20120325010609.GB27651@sigill.intra.peff.net>
 <20120325023215.GA13958@sigill.intra.peff.net>
 <4F6F56D5.3000309@gmx.net>
 <4F6F5BCB.9050406@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCDn7-0005TE-Az
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933128Ab2CZRdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:33:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60006
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933093Ab2CZRdD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:33:03 -0400
Received: (qmail 14310 invoked by uid 107); 26 Mar 2012 17:33:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 13:33:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 13:33:01 -0400
Content-Disposition: inline
In-Reply-To: <4F6F5BCB.9050406@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193937>

On Sun, Mar 25, 2012 at 07:54:19PM +0200, Ivan Todoroski wrote:

> >>>That's weird. 405 is "Method Not Allowed". Clone shouldn't be doing
> >>>anything more exotic than GET and POST. And the prior tests pass, so it
> [...]
> It's still failing on CentOS 5.8 with Apache 2.2.3. I will just find
> another machine where the test suite works.

I'm running the tests with apache 2.2.22. So I wonder if there is some
config syntax or behavior that is simply different in the much older
version.

> If you'd still like to debug the problem on CentOS 5.8 I can run any
> commands or test any patches for you.

A few more things to try:

  - check httpd/access.log to confirm that apache really is returning a
    405 (I can't imagine that curl would not be reporting it accurately,
    but it's worth a shot)

  - try running with GIT_CURL_VERBOSE=1 to get debug output from curl

  - try adding these to the apache config:

      RewriteLog "httpd/rewrite.log"
      RewriteLogLevel 9

    which might yield more information.

I have no idea what you're looking for in any of those, but maybe
something useful will be obvious. I don't have a lot of apache
experience, so my next step in your shoes would be just trying to get
more information on what's happening.

-Peff
