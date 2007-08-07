From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Tue, 07 Aug 2007 08:47:52 +0200
Message-ID: <vpqfy2vu9gn.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 08:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIIsc-0001xy-Lu
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 08:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbXHGGtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 02:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbXHGGtT
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 02:49:19 -0400
Received: from imag.imag.fr ([129.88.30.1]:43292 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbXHGGtS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 02:49:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l776lrkP027175
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 7 Aug 2007 08:47:53 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IIIrA-0002ML-TG; Tue, 07 Aug 2007 08:47:52 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IIIrA-0003tu-Pb; Tue, 07 Aug 2007 08:47:52 +0200
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>, Steven Grimm <koreth@midwinter.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>, Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
In-Reply-To: <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 6 Aug 2007 21\:22\:26 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 07 Aug 2007 08:47:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55228>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It's not that the old output is "useful" in itself, but it's important for 
> people to know that the index is clean. So I'd suggest just setting a flag 
> when the header isn't printed, and then printing out a single line at the 
> end about "git index not up-to-date" or something.

Yes. Junio's patch has this as a comment, it's probably good to
uncomment it, and perhaps print it directly on stdout so that you see
it even with a pager.

> Doing a "git diff" cannot actually update the index (since it very much 
> has to work on a read-only setup too),

Err, what's the relationship between the two parts of your sentence?
You can't be sure that git-diff will update the index (because you may
be working on a read-only setup, yes), but git-diff can at least _try_
to, and fall-back to the read-only behavior if updating the index
fails.

That's not a highly original idea since this is what git already does
with "status".

Once more, I'm willing to write the code for that if it has a chance
to be accepted.

-- 
Matthieu
