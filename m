From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-highlight: Fix broken multibyte string
Date: Fri, 3 Apr 2015 17:47:29 -0400
Message-ID: <20150403214729.GA11220@peff.net>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
 <20150330221635.GB25212@peff.net>
 <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c>
 <20150403012430.GA16173@peff.net>
 <1D1557A9-737A-4BF6-A3DE-BF4C0465BD36@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yi EungJun <semtlenori@gmail.com>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:47:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9RA-0006bU-Tb
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbbDCVrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 17:47:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:42197 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751469AbbDCVrb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 17:47:31 -0400
Received: (qmail 12141 invoked by uid 102); 3 Apr 2015 21:47:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 16:47:31 -0500
Received: (qmail 25957 invoked by uid 107); 3 Apr 2015 21:47:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 17:47:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2015 17:47:29 -0400
Content-Disposition: inline
In-Reply-To: <1D1557A9-737A-4BF6-A3DE-BF4C0465BD36@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266735>

On Thu, Apr 02, 2015 at 06:59:50PM -0700, Kyle J. McKay wrote:

> It should work as well as the original did for any 1-byte encoding.  That
> is, if it's not valid UTF-8 it should pass through unchanged and any single
> byte encoding should just work.  But, as you point out, multibyte encodings
> other than UTF-8 won't work, but they should behave the same as they did
> before.

Yeah, sorry, I should have been more clear that I meant multibyte
encodings. UTF-8 is the only common multibyte encoding I run across, but
that's because Latin1 served most of my pre-UTF-8 needs.  I suspect
things are very different for people in Asia. I don't know how
badly they would want support for other encodings. I'm happy to go with
a UTF-8 solution for now, and see if anybody wants to expand it further
later.

> >I timed this one versus the existing diff-highlight. It's about 7%
> >slower.
> 
> I'd expect that, we're doing extra work we weren't doing before.

I was worried would be 200% or something. :)

> >Makes sense. I'm happy enough listing perl 5.8 as a dependency.
> 
> Maybe that should be added.  The rest of Git's perl code seems to have a
> 'use 5.008;' already, so I figured that was a reasonable dependency.  :)

I shouldn't have said "listing". I just meant "have" as a dependency. I
am also happy with adding "use 5.008", but I agree it's probably not
necessary at this point. It was released in 2002 (wow, has it really
been that long?).

-Peff
