From: Jeff King <peff@peff.net>
Subject: Re: can Git encrypt/decrypt .gpg on push/fetch?
Date: Fri, 9 Sep 2011 15:16:05 -0400
Message-ID: <20110909191605.GG28480@sigill.intra.peff.net>
References: <87lityxbg7.fsf@lifelogs.com>
 <CAGhXAGSw3y=cjAHXtwycDifoBPr13AkYtLHRRXejRKue0vkz7A@mail.gmail.com>
 <4E6A165D.5010703@drmicha.warpmail.net>
 <20110909184229.GE28480@sigill.intra.peff.net>
 <7vvct1tu3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Aneesh Bhasin <contact.aneesh@gmail.com>, tzz@lifelogs.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26Yh-0004KE-9c
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759690Ab1IITQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:16:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59055
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759389Ab1IITQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 15:16:08 -0400
Received: (qmail 979 invoked by uid 107); 9 Sep 2011 19:16:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 15:16:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 15:16:05 -0400
Content-Disposition: inline
In-Reply-To: <7vvct1tu3n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181110>

On Fri, Sep 09, 2011 at 12:05:00PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> B) Keep blobs encrypted, checkout decrypted
> >> - Use Use "*.gpg filter=gpg" in your attributes and
> >> [filter "gpg"]
> >> 	smudge = gpg -d
> >> 	clean = gpg -e -r yourgpgkey
> >>   in your config.
> >> 
> >> I use A on a regular basis. B is untested (but patterned after a similar
> >> gzip filter I use). You may or may not have better results with "gpg -ea".
> >
> > Yeah, I think that would work but have never tried it either.
> 
> Unless "gpg -e" encrypts the same cleartext into the same cyphertext every
> time, the above "clean" filter probably wouldn't be very useful.

Ah, right, I remember now running into that at some point. You could get
around that by using a symmetric cipher in block mode, or with a
non-random IV, but then you're opening yourself up to some cryptanalytic
attacks.

-Peff
