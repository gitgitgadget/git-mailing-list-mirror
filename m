From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Thu, 14 Jun 2007 19:48:11 +1200
Message-ID: <4670F2BB.5060909@vilain.net>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site> <20070613184109.GG10941@coredump.intra.peff.net> <Pine.LNX.4.64.0706131953370.4059@racer.site> <20070613200011.GA17360@coredump.intra.peff.net> <Pine.LNX.4.64.0706132317240.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 09:48:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyk4K-0002x7-Rh
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 09:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbXFNHsc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 03:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbXFNHsb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 03:48:31 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57872 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbXFNHsb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 03:48:31 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 1AF4E13A4FA; Thu, 14 Jun 2007 19:48:28 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D1E7B13A4F0;
	Thu, 14 Jun 2007 19:48:21 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <Pine.LNX.4.64.0706132317240.4059@racer.site>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50174>

Johannes Schindelin wrote:
> Actually, that's funny. Yesterday, I repeated my claim that pcre is 
> slow on IRC, and Sam Villain on IRC accused me of trolling. But as you can 
> see from my postings on this list ($gmane/41682), you can see that _I_ had 
> numbers to back up my claim.
>
> So no, I think pcre is just not worth it.
>   

A strange thing to conclude from your figures, which show pcre as the
fastest out of several libraries that you tested.

Your figures show exactly what I was saying on IRC - that a DFA
(external grep) vs NFA engine (most regex libraries) is inherently
faster. The paper I linked to, specially selected as I had previously
read a significant amount of the peer review the paper received,
explained this in detail. The one piece of feedback your numbers got
on-list also mentioned this.

However there is a further flaw in your study. All but one of the
performance tests use an external program, which on a given system may
or may not be faster because of pipeline performance characteristics.
You could improve the quality of the result by using the 'pcregrep'
program as a data point. It might also be worth trying a few more
complex patterns. I suggest reading the paper
(http://swtch.com/~rsc/regexp/regexp1.html) for some background before
repeating the experiment.

Apologies for not reviewing your numbers at the time; it sure is hard to
keep on top of this list. But very interesting that they seem to suggest
pcre would be the best choice from a performance perspective, even
though the figures are very preliminary. Perhaps it is worth pursuing
after all.

Sam.
