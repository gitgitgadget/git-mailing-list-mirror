Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DC31FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 17:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbcFWRcd (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:32:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:59191 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751159AbcFWRcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:32:32 -0400
Received: (qmail 29892 invoked by uid 102); 23 Jun 2016 17:32:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:32:32 -0400
Received: (qmail 12777 invoked by uid 107); 23 Jun 2016 17:32:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 13:32:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 13:32:30 -0400
Date:	Thu, 23 Jun 2016 13:32:30 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Simon Courtois <scourtois@cubyx.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] doc: refactor description of color format
Message-ID: <20160623173229.GB15774@sigill.intra.peff.net>
References: <20160623173048.GA19923@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623173048.GA19923@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is a general cleanup of the description of colors in
git-config, mostly to address inaccuracies and confusion
that had grown over time:

  - you can have many attributes, not just one

  - the discussion flip-flopped between colors and
    attributes; now we discuss everything about colors, then
    everything about attributes

  - many concepts were lumped into the first paragraph,
    making it hard to read, and especially to find the
    actual lists of colors and attributes. I stopped short
    of breaking those out into their own lists, as it seemed
    like an excessive use of vertical screen real estate.

  - we introduced negated attributes, but then the next
    paragraph basically explains how each item starts off
    with no attributes. So why would one need negated
    attributes? We now explain.

  - minor typo, language, and typography fixes

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 58673cf..f8460d4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -150,27 +150,32 @@ integer::
        1024", "by 1024x1024", etc.
 
 color::
-       The value for a variables that takes a color is a list of
-       colors (at most two) and attributes (at most one), separated
-       by spaces.  The colors accepted are `normal`, `black`,
-       `red`, `green`, `yellow`, `blue`, `magenta`, `cyan` and
-       `white`; the attributes are `bold`, `dim`, `ul`, `blink` and
-       `reverse`.  The first color given is the foreground; the
-       second is the background.  The position of the attribute, if
-       any, doesn't matter. Attributes may be turned off specifically
-       by prefixing them with `no` (e.g., `noreverse`, `noul`, etc).
-+
-Colors (foreground and background) may also be given as numbers between
-0 and 255; these use ANSI 256-color mode (but note that not all
-terminals may support this).  If your terminal supports it, you may also
-specify 24-bit RGB values as hex, like `#ff0ab3`.
-+
-The attributes are meant to be reset at the beginning of each item
-in the colored output, so setting color.decorate.branch to `black`
-will paint that branch name in a plain `black`, even if the previous
-thing on the same output line (e.g. opening parenthesis before the
-list of branch names in `log --decorate` output) is set to be
-painted with `bold` or some other attribute.
+       The value for a variable that takes a color is a list of
+       colors (at most two, one for foreground and one for background)
+       and attributes (as many as you want), separated by spaces.
++
+The basic colors accepted are `normal`, `black`, `red`, `green`, `yellow`,
+`blue`, `magenta`, `cyan` and `white`.  The first color given is the
+foreground; the second is the background.
++
+Colors may also be given as numbers between 0 and 255; these use ANSI
+256-color mode (but note that not all terminals may support this).  If
+your terminal supports it, you may also specify 24-bit RGB values as
+hex, like `#ff0ab3`.
++
+The accepted attributes are `bold`, `dim`, `ul`, `blink`, and `reverse`.
+The position of any attributes with respect to the colors (before, after,
+or in between), doesn't matter. Specific attributes may be turned off
+by prefixing them with `no` (e.g., `noreverse`, `noul`, etc).
++
+For git's pre-defined color slots, the attributes are meant to be reset
+at the beginning of each item in the colored output. So setting
+`color.decorate.branch` to `black` will paint that branch name in a
+plain `black`, even if the previous thing on the same output line (e.g.
+opening parenthesis before the list of branch names in `log --decorate`
+output) is set to be painted with `bold` or some other attribute.
+However, custom log formats may do more complicated and layered
+coloring, and the negated forms may be useful there.
 
 pathname::
 	A variable that takes a pathname value can be given a
-- 
2.9.0.209.g845fbc1

