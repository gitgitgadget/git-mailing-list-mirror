From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap
 format
Date: Wed, 26 Jun 2013 22:45:22 -0400
Message-ID: <20130627024521.GA6936@sigill.intra.peff.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com>
 <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
 <7vtxkl28m7.fsf@alter.siamese.dyndns.org>
 <CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
 <CAJo=hJtJoizQUubriTPvs2bsjvw+N82MCPvw263fUB8vv8_VVA@mail.gmail.com>
 <CAFFjANSr2QRLE8DSPP2zZ_baEZUqR8dzkPzMwqyEqgFX=8cnog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Colby Ranger <cranger@google.com>, git <git@vger.kernel.org>
To: Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 04:45:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us2DB-0008Nq-7M
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 04:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab3F0CpZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 22:45:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:34679 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab3F0CpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 22:45:25 -0400
Received: (qmail 1269 invoked by uid 102); 27 Jun 2013 02:46:29 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Jun 2013 21:46:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jun 2013 22:45:22 -0400
Content-Disposition: inline
In-Reply-To: <CAFFjANSr2QRLE8DSPP2zZ_baEZUqR8dzkPzMwqyEqgFX=8cnog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229084>

On Thu, Jun 27, 2013 at 04:36:54AM +0200, Vicent Mart=C3=AD wrote:

> That was a very rude reply. :(
>=20
> Please refrain from interacting with me in the ML in the future. I'l
> do accordingly.

I agree that the pointer arithmetic thing may have been a little much,
but I think there are some points we need to address in Shawn's email.

In particular, it seems like the slowness we saw with the v1 bitmap
format is not what Shawn and Colby have experienced. So it's possible
that our test setup is bad or different. Or maybe the C v1 reading
implementation had some problems that are fixable. It's hard to say
because we haven't shown any code that can be timed and compared.

And the pack-order versus idx-order for the bitmaps is still up in the
air. Do we have numbers on the on-disk sizes of the resulting EWAHs? Th=
e
pack-order ones should be more amenable to run-length encoding,
especially as you get further down into history (the tip ones would
mostly be 1's, no matter how you order them).

-Peff
