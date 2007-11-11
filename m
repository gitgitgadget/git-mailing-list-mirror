From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Added diff hunk coloring to git-add--interactive
Date: Sun, 11 Nov 2007 02:00:24 -0800
Message-ID: <7vlk95f6fb.fsf@gitster.siamese.dyndns.org>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180344.05a81497@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir9ce-0004rU-9Z
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 11:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbXKKKAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 05:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbXKKKAh
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 05:00:37 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54368 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbXKKKAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 05:00:36 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F10082F2;
	Sun, 11 Nov 2007 05:00:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6151B937CA;
	Sun, 11 Nov 2007 05:00:47 -0500 (EST)
In-Reply-To: <20071110180344.05a81497@paradox.zwell.net> (Dan Zwell's message
	of "Sat, 10 Nov 2007 18:03:44 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64439>

Dan Zwell <dzwell@zwell.net> writes:

> +sub colored_diff_hunk {
> +	my ($text) = @_;
> +	# return the text, so that it can be passed to print()
> +	my @ret;
> +	for (@$text) {
> +		if (!$diff_use_color) {
> +			push @ret, $_;
> +			next;
> +		}

It would be better to do the "if (!$diff_use_color)" part
upfront before entering the loop, wouldn't it?

	sub colored_diff_hunk {
        	my ($text) = @_;
		if (!$diff_use_color) {
	                return @$text;
		}

                my @ret;
                for (@$text) {
                	...
		}
	}
