From: Jeff King <peff@peff.net>
Subject: [PATCH 0/7] color fixes and configurable diff-highlight
Date: Thu, 20 Nov 2014 10:14:19 -0500
Message-ID: <20141120151418.GA23607@peff.net>
References: <5462907B.1050207@canbytel.com>
 <20141112075609.GA21485@peff.net>
 <5463A007.4090302@canbytel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:14:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrTRE-0003W3-5e
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbaKTPOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:14:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:42759 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757356AbaKTPOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 10:14:21 -0500
Received: (qmail 11617 invoked by uid 102); 20 Nov 2014 15:14:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 09:14:21 -0600
Received: (qmail 12975 invoked by uid 107); 20 Nov 2014 15:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:14:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 10:14:19 -0500
Content-Disposition: inline
In-Reply-To: <5463A007.4090302@canbytel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 09:59:35AM -0800, Scott Baker wrote:

> It's 2014, most terminals are at least 256 colors. I'm fine if the
> defaults are 16 colors (that's safest), but it would be really cool if
> we could have an option for:
> 
> line add color
> line remove color
> word add color
> word remove color
> 
> I would then configure appropriate colors from the 256 color palette. I
> think the Github style diffs which include the lines/words that are
> changed are very readable and make dealing with diffs easier.

I thought I'd just procrastinate for an hour by doing this, but somehow
it turned into a 7-patch series.

The first few are actual fixes I noticed along the way.

Patches 4 and 5 support RGB-mode, which works on XTerm, at least (we
This is probably excessive over 256-color mode (which we already
supported), but I find the resulting color specifications significantly
easier to understand (quick, what's ANSI color 137?).

Patch 6 implements negative attributes (like "nobold"). This is probably
not all that useful for normal git color specs, but is required for
diff-highlight, which wants to leave some attributes untouched.

Patch 7 is the part you actually asked for. :)

  [1/7]: docs: describe ANSI 256-color mode
  [2/7]: config: fix parsing of "git config --get-color some.key -1"
  [3/7]: t4026: test "normal" color
  [4/7]: parse_color: refactor color storage
  [5/7]: parse_color: support 24-bit RGB values
  [6/7]: parse_color: recognize "no$foo" to clear the $foo attribute
  [7/7]: diff-highlight: allow configurable colors

-Peff
