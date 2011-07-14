From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] implement generic key/value map
Date: Thu, 14 Jul 2011 15:14:16 -0400
Message-ID: <20110714191416.GC26918@sigill.intra.peff.net>
References: <20110714173454.GA21657@sigill.intra.peff.net>
 <20110714175105.GA21771@sigill.intra.peff.net>
 <CAKPyHN0-VbzjMaMJFZeGGrGX6HuGNEBHNVNf0cexB2vu21_13g@mail.gmail.com>
 <CAKPyHN3G41iMGmGgp6jTcWN=Rxt=RTUS7ktgVDhZEXPBRXvTDQ@mail.gmail.com>
 <20110714185539.GA27141@sigill.intra.peff.net>
 <CAKPyHN3VV4bmy2CF9vPsRG82EapFtUOCXNYO=mVAJs54QG===g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:14:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRMd-0007P2-FT
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065Ab1GNTOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 15:14:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59387
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804Ab1GNTOS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 15:14:18 -0400
Received: (qmail 10413 invoked by uid 107); 14 Jul 2011 19:14:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 15:14:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 15:14:16 -0400
Content-Disposition: inline
In-Reply-To: <CAKPyHN3VV4bmy2CF9vPsRG82EapFtUOCXNYO=mVAJs54QG===g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177162>

On Thu, Jul 14, 2011 at 09:07:54PM +0200, Bert Wesarg wrote:

> > Yeah, you could treat this like a C++ template and assume random bits of
> > code will instantiate a map of whatever types they need. But this is C,
> > and we only want to instantiate once. So I just figured to keep the
> > static list of whatever maps git needs in the map.[ch] files.
> 
> When I wrote such macros in the past, the 'generated' functions where
> all static. So one could instantiate a map multiple times in different
> compilation units where one need to access this type of map.

Yeah, that would work. It can bloat the code more, but in practice, not
much. It would also work better if we were providing the map API as a
library to arbitrary code. But we have the luxury of knowing all of the
types that will be used with it at compile time. :)

-Peff
