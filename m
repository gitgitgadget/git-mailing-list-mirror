From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum
 member
Date: Mon, 7 Nov 2011 13:55:36 -0500
Message-ID: <20111107185536.GA5450@sigill.intra.peff.net>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-4-git-send-email-avarab@gmail.com>
 <m2pqh5nvic.fsf@igel.home>
 <CACBZZX6CRm1W5i43=LeXPJFdcWFgVTkD8cGntHoKsPoWGx_hNg@mail.gmail.com>
 <m3pqh4krer.fsf@hase.home>
 <20111107163823.GB27055@sigill.intra.peff.net>
 <m2k47b4wqi.fsf@igel.home>
 <20111107183402.GA5118@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 19:55:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNUMB-0005Te-Aa
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 19:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab1KGSzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 13:55:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35877
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab1KGSzi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 13:55:38 -0500
Received: (qmail 28929 invoked by uid 107); 7 Nov 2011 18:55:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 13:55:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 13:55:36 -0500
Content-Disposition: inline
In-Reply-To: <20111107183402.GA5118@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185014>

On Mon, Nov 07, 2011 at 01:34:02PM -0500, Jeff King wrote:

> > The whole point of the statement is a sanity check to uncover bugs.  If
> > you remove the first condition you completely ruin its point.
> [...]
> Yes, static analysis can miss some bugs (like passing the address of the
> enum through a void pointer (e.g., when memset'ing a struct)). But
> couldn't it just as easily be out of range in the other direction?

Oops, I just looked at the actual conditional, and it is indeed
range-checking the whole enum. So if you are going to do that at all,
then yes, checking both sides is sensible, and that is what the original
conditional does. Sorry for my confusion.

I do still question the value of the check at all, though, given that
static analysis can find those bugs.

-Peff
