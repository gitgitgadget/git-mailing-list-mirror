From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] Added diff hunk coloring to git-add--interactive
Date: Thu, 22 Nov 2007 14:35:31 -0800
Message-ID: <7v1wah3o3w.fsf@gitster.siamese.dyndns.org>
References: <20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180109.34febc3f@paradox.zwell.net>
	<20071122045624.405e2b2b@paradox.zwell.net>
	<20071122122540.GH12913@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 23:36:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvKeQ-0007LR-Vg
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 23:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbXKVWfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 17:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbXKVWfp
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 17:35:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40202 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbXKVWfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 17:35:44 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 10D1C2F0;
	Thu, 22 Nov 2007 17:36:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FD5598A93;
	Thu, 22 Nov 2007 17:35:55 -0500 (EST)
In-Reply-To: <20071122122540.GH12913@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 22 Nov 2007 07:25:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65856>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 22, 2007 at 04:56:24AM -0600, Dan Zwell wrote:
>
>> -		else { # set up colors
>> -			# Grab the 3 main colors in git color string format, with sane
>> -			# (visible) defaults:
>> -			$prompt_color = Git::color_to_ansi_code(
>> -				scalar $repo->config_default('color.interactive.prompt',
>> -					'bold blue'));
>
> These were just added in the last patch. I know sometimes it is worth
> showing the progression of work as the patches go, but in this case, I
> think it is simpler for the reviewers if the first patch which adds a
> chunk of code does it in the final way (even if you need to just say "I
> did it this way because there will be reasons later on.").

If you are suggesting to reorganize the series like this:

 1/5 Fix to Git.pm for list context;

 2/5 Enhance Git.pm to allow config() methods to take default values;

 3/5 Enhance Git.pm with get_color() method;

 4/5 Teach git-add--interactive to read color settings from the
     config;

 5/5 Paint output from git-add--interactive in colors, including
     prompt, help and diff hunks.

I think that makes a very good sense.  The earlier part of the
series would be independent from colorization of "add -i" and
can go in before everything else to allow other potential users,
e.g. "git remote --color" ;-).  I do not see a strong reason to
have the separate "Basic color support with hardcoded color" at
the beginning, either.

I think it is a matter of taste to either:

 (1) Squash 4 and 5 in the above list into one; or

 (2) Split 5 into separate commits to color different parts.

Perhaps the former would be simpler and more appropriate for
this series.
