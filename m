From: Jeff King <peff@peff.net>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Fri, 24 Feb 2012 04:52:53 -0500
Message-ID: <20120224095253.GC11846@sigill.intra.peff.net>
References: <4F46036F.3040406@gmail.com>
 <20120223102426.GB2912@sigill.intra.peff.net>
 <4F462E61.4020203@gmail.com>
 <m34nuhelnf.fsf@localhost.localdomain>
 <4F4643BB.8090001@gmail.com>
 <20120223193451.GB30132@sigill.intra.peff.net>
 <7vy5rt2u0c.fsf@alter.siamese.dyndns.org>
 <4F475689.4040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nikolaj Shurkaev <snnicky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 10:53:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0rpl-0002fF-PU
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 10:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab2BXJw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 04:52:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55485
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2BXJw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 04:52:56 -0500
Received: (qmail 22480 invoked by uid 107); 24 Feb 2012 09:52:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 04:52:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 04:52:53 -0500
Content-Disposition: inline
In-Reply-To: <4F475689.4040203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191422>

On Fri, Feb 24, 2012 at 12:21:13PM +0300, Nikolaj Shurkaev wrote:

> I'll propose to put something like this into git documentation
> --------------------------------------------------------------------------------------------
> diff --git a/Documentation/git-format-patch.txt
> b/Documentation/git-format-patch.txt
> index 6ea9be7..63267c6 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -23,6 +23,7 @@ SYNOPSIS
> [--cover-letter] [--quiet]
> [<common diff options>]
> [ <since> | <revision range> ]
> + [[\--] <path>...]
> 
> DESCRIPTION
> -----------
> @@ -219,6 +220,12 @@ you can use `--suffix=-patch` to get
> `0001-description-of-my-change-patch`.
> range are always formatted as creation patches, independently
> of this flag.
> 
> +[\--] <path>...::
> + Put in patches only those modifications that affect specified files
> + and folders. It's important to understand that log message of the
> + commit may become inappropriate because some parts of patch may be
> + cut off.
> +

I think that text looks OK. But to my mind, it is not that format-patch
accepts a path parameter, but rather that it takes arbitrary log-like
arguments. So you could do "git format-patch --grep=whatever", or even
something like "git format-patch --cherry".

I don't know how well tested every option is, though, so maybe it's not
a good idea to encourage the use of random options.

-Peff
