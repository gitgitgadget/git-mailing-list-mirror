From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] update_unicode.sh: Make the output structure visible
Date: Fri, 19 Dec 2014 10:22:11 -0500
Message-ID: <20141219152211.GA16967@peff.net>
References: <1418999971-21548-1-git-send-email-dev+git@drbeat.li>
 <1418999971-21548-4-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, tboegi@web.de
To: dev+git@drbeat.li
X-From: git-owner@vger.kernel.org Fri Dec 19 16:22:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1zNi-0000Jp-RD
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 16:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbaLSPWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 10:22:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:55268 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751281AbaLSPWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 10:22:14 -0500
Received: (qmail 9456 invoked by uid 102); 19 Dec 2014 15:22:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Dec 2014 09:22:14 -0600
Received: (qmail 24124 invoked by uid 107); 19 Dec 2014 15:22:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Dec 2014 10:22:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Dec 2014 10:22:11 -0500
Content-Disposition: inline
In-Reply-To: <1418999971-21548-4-git-send-email-dev+git@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261563>

On Fri, Dec 19, 2014 at 03:39:30PM +0100, dev+git@drbeat.li wrote:

> By using printf instead of the echo/uniset sequence, the final structure
> of the generated file becomes obvious.

This whole series looks pretty sane to me, and the result is easier to
read.

I did wonder if a here-doc would be even easier than a PDF, like:

  cat >$UNICODEWIDTH_H <<-EOF
  static const struct interval zero_width[] = {
    $(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD | grep -v plane)
  };
  static const struct interval double_width[] = {
    $(uniset/uniset --32 eaw:F,W)
  };
  EOF

The nice thing is that <<- will strip leading tabs, which means you can
indent properly to match the surrounding code. I don't know if you find
the in-line $() more readable or not, though.

I think either way it is an improvement over the current state.

-Peff
