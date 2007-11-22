From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] Added diff hunk coloring to git-add--interactive
Date: Thu, 22 Nov 2007 13:37:55 -0800
Message-ID: <7v1wai3qrw.fsf@gitster.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Thu Nov 22 22:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvJkm-0004NT-SF
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 22:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbXKVViK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 16:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbXKVViJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 16:38:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40058 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbXKVViI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 16:38:08 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 519DC2F0;
	Thu, 22 Nov 2007 16:38:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 85DBE98A2D;
	Thu, 22 Nov 2007 16:38:19 -0500 (EST)
In-Reply-To: <20071122122540.GH12913@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 22 Nov 2007 07:25:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65850>

Jeff King <peff@peff.net> writes:

>> +	if ($diff_use_color) {
>> +		$new_color = get_color('color.diff.new', 'green');
>> +		$old_color = get_color('color.diff.old', 'red');
>> +		$fraginfo_color = get_color('color.diff.frag', 'cyan');
>> +		$metainfo_color = get_color('color.diff.meta', 'bold');
>> +		$normal_color = Git::color_to_ansi_code('normal');
>> +		# Not implemented:
>> +		#$whitespace_color = get_color('color.diff.whitespace',
>> +			#'normal red');
>
> Unfortunately, there is a historical wart that probably still needs
> supporting, which is that the original names were diff.color.*. Or have
> we officially removed support for that yet?

Neither officially or unofficially yet, but we can start the
process of making it official with an early announcement.  I do
not think we would hurt people as long as a long enough advance
notice is given.

I however am wondering if we need to have so many "enable color
support" switches.  color.status, color.diff, and now yet
another color.interactive?  Who sets color.status and/or
color.interactive to auto without setting color.diff to auto as
well?

It may be good that they _can_ be individually controlled, but I
strongly suspect that most people would just want to set a
single variable color.ui to "auto", and have it give the default
value for all the color.$cmd configuration variable that are not
explicitly defined.
