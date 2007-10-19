From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Documentation/git-gc: improve description of --auto
Date: Thu, 18 Oct 2007 22:29:09 -0400
Message-ID: <20071019022909.GZ14735@spearce.org>
References: <20071019020510.GB7711@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Steven Grimm <koreth@midwinter.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:29:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iihc7-0001CI-PZ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760000AbXJSC3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760614AbXJSC3R
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:29:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43369 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758959AbXJSC3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:29:16 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iihbb-0008SJ-Ez; Thu, 18 Oct 2007 22:28:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3A1FF20FBAE; Thu, 18 Oct 2007 22:29:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071019020510.GB7711@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61608>

Jeff King <peff@peff.net> wrote:
> It is a little bit odd that there is so much low-level detail in the
> '--auto' description versus the rest of the page. But I think it reads
> OK. Also note that the previous incarnation (and my changes) use the
> `foo` form to monospace arguments, while the rest of the page uses 'foo'
> (which actually means emphasis). I think the former is more correct, but
> asciidoc renders the latter much more pleasantly in manpages. I will see
> if I can tweak asciidoc to make this look better.

I like this a lot better than what was there before.  Nice work.
I have no real opinion on the asciidoc syntax.

I personally prefer to read commands in the source as `foo` and
feel that asciidoc should just format it correctly for the backend.
If it isn't then we should try to work with the asciidoc folks to
get it right...

>  --auto::
> -	With this option, `git gc` checks if there are too many
> -	loose objects in the repository and runs
> -	gitlink:git-repack[1] with `-d -l` option to pack them.
> -	The threshold for loose objects is set with `gc.auto` configuration
> -	variable, and can be disabled by setting it to 0.  Some
> -	Porcelain commands use this after they perform operation
> -	that could create many loose objects automatically.
> -	Additionally, when there are too many packs are present,
> -	they are consolidated into one larger pack by running
> -	the `git-repack` command with `-A` option.  The
> -	threshold for number of packs is set with
> -	`gc.autopacklimit` configuration variable.
> +	With this option, `git gc` checks whether any housekeeping is
> +	required; if not, it exits without performing any work.
> +	Some git commands run `git gc --auto` after performing
> +	operations that could create many loose objects.
> ++
> +Housekeeping is required if there are too many loose objects or
> +too many packs in the repository. If the number of loose objects
> +exceeds the value of the `gc.auto` configuration variable, then
> +all loose objects are combined into a single pack using
> +`git-repack -d -l`.  Setting the value of `gc.auto` to 0
> +disables automatic packing of loose objects.
> ++
> +If the number of packs exceeds the value of `gc.autopacklimit`,
> +then existing packs (except those marked with a `.keep` file)
> +are consolidated into a single pack by using the `-A` option of
> +`git-repack`. Setting `gc.autopacklimit` to 0 disables
> +automatic consolidation of packs.

-- 
Shawn.
