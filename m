From: Jeff King <peff@peff.net>
Subject: Re: Git patch shows tab but files doesn't
Date: Fri, 12 Feb 2016 13:32:38 -0500
Message-ID: <20160212183238.GB19973@sigill.intra.peff.net>
References: <CAD6G_RTJuNsR6qawgco1H+ocKPThk1HsQLvhQigmzUb_c7UdaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Jagan Teki <jteki@openedev.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:32:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIWM-0005Bx-1Q
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbcBLScm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 13:32:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:41125 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752582AbcBLScl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 13:32:41 -0500
Received: (qmail 13006 invoked by uid 102); 12 Feb 2016 18:32:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 13:32:40 -0500
Received: (qmail 18171 invoked by uid 107); 12 Feb 2016 18:32:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 13:32:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 13:32:38 -0500
Content-Disposition: inline
In-Reply-To: <CAD6G_RTJuNsR6qawgco1H+ocKPThk1HsQLvhQigmzUb_c7UdaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286064>

On Fri, Feb 12, 2016 at 09:32:32PM +0530, Jagan Teki wrote:

> Hi,
> 
> I edited a file as one space between #define and macro and tab space
> between macro and BIT value, similar as below.
> 
> #define USE_FSR           BIT(6)
> #define SNOR_WR         BIT(7)
> 
> Once I created the patch looks different as tab space between #define
> and macro and 2 tab spaces between macro and BIT value looks like it's
> added tab spaces while creating a patch as below.
> 
> +#define        USE_FSR                              BIT(6)
> +#define        SNOR_WR                            BIT(7)
> 
> Any help how to fix this, was it an issues with vim or do we have any
> git-config fixes for this?

It's hard to tell from your output, but you can often get tab
realignment on your terminal when viewing a patch, because the tabs are
shifted in by one character (the leading "+"). So if your terminal
is showing (as most do) a tab as "skip to the next tabstop", then:

  1. The size of particular tabs may look quite different if they move
     from an exact tabstop to the next character (or vice versa).

     If the space between your "#define" and the macro name is actually
     a tab, then I'd expect it to exhibit this behavior with a tabstop
     of 8 (because #define is 7 chars).

  2. Spaces don't exhibit this, so two lines which _are_ aligned in the
     source for a specific tabstop may not be in the patch.

Piping the diff (and your file) through "cat -A" can often show more
clearly what's going on.

-Peff
