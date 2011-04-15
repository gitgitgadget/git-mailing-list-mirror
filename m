From: Jeff King <peff@peff.net>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 23:30:03 -0400
Message-ID: <20110415033003.GB19621@sigill.intra.peff.net>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org>
 <20110414175034.GA23342@sigill.intra.peff.net>
 <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com>
 <20110414214230.GB7709@sigill.intra.peff.net>
 <BANLkTikgZH8135=o5ODcA=780-1D7YFngw@mail.gmail.com>
 <20110414222940.GA19389@sigill.intra.peff.net>
 <BANLkTim0Q+RaExss+U3m-=CHT6Jd1jc56Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 05:30:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAZja-0006TK-GX
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 05:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350Ab1DODaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 23:30:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44357
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab1DODaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 23:30:06 -0400
Received: (qmail 6182 invoked by uid 107); 15 Apr 2011 03:30:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 23:30:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 23:30:04 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim0Q+RaExss+U3m-=CHT6Jd1jc56Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171584>

On Fri, Apr 15, 2011 at 12:43:08AM +0200, Erik Faye-Lund wrote:

> >> That part is surprisingly easy: If it contains a '<', then it's on=
 the form
> >> "Foo Bar Baz <foo@bar.baz>". If not, it's "foo@bar.baz" (assuming =
it's
> >> UTF-8 encoded rfc5322 mailbox'es we assume, which would make the m=
ost
> >> sense to me)
> >
> > What about:
> >
> > =C2=A0"Foo \"The Bar\" Baz" <foo@example.com>
> >
> > or
> >
> > =C2=A0Foo "The Bar" Baz <foo@example.com>
> >
> > or
> >
> > =C2=A0Foo (The Bar) Baz <foo@example.com>
> >
> > I.e., are we taking rfc822-style addresses, or are we taking someth=
ing
> > that looks vaguely like an email address, and just treating everyth=
ing
> > left of "<" as literal?
>=20
> I was just thinking of interpreting everything left of '<' literally
> and encode it (if needed). Currently, we interpret the entire string
> literally, encoding the name would an improvement.

Won't that be a regression for people who already know that we take
things literally and are manually quoting and/or rfc2047-encoding the
contents?

-Peff
