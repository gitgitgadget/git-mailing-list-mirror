From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH 2/3] Let git-add--interactive read colors from .gitconfig
Date: Mon, 12 Nov 2007 18:32:58 -0800
Message-ID: <7v4pfq27tx.fsf@gitster.siamese.dyndns.org>
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
	<20071110202351.7b4544aa@paradox.zwell.net>
	<7vve89f6qy.fsf@gitster.siamese.dyndns.org>
	<47390050.1020907@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 03:33:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irlan-0007m8-HJ
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 03:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbXKMCdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 21:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbXKMCdQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 21:33:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59130 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbXKMCdP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 21:33:15 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4C6552F9;
	Mon, 12 Nov 2007 21:33:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7028D9521E;
	Mon, 12 Nov 2007 21:33:25 -0500 (EST)
In-Reply-To: <47390050.1020907@zwell.net> (Dan Zwell's message of "Mon, 12 Nov
	2007 19:39:28 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64742>

Dan Zwell <dzwell@gmail.com> writes:

> Junio C Hamano wrote:
>>> +			$fg_done = "true";
>>> +		}
>>> +		elsif ($word =~ /black|red|green|yellow/ ||
>>> +			   $word =~ /blue|magenta|cyan|white/) {
>>
>> 	exists $color_name{$word}
>>
>> with
>>
>> 	my %color_name = map { $_ => 1 } qw(black red ... white);
>>
>> at the beginning?
>>
> I don't see the advantage of doing it that way. After all, we're
> pattern matching. Does using a hash, an array, and a call to map()
> gain us something? I think a regular expression is clearer. Of course,
> as Jeff pointed out, I should have used a whitespace-agnostic regular
> expression.

I suggested the hash approach only because (1) it is easier to
read than two regexp matches that are split only to keep the
line less than 80-chars long, and (2) a misconfiguration like
"color.foo = fred" can be caught more easily.

I do not quite understand the "after all, we're pattern
matching" part, though.  Are you talking about "split(/\s+/, $str)" 
your for-loop iterates over?
