From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] gpg: add support for gpgsm
Date: Thu, 31 Mar 2016 13:30:25 -0400
Message-ID: <20160331173025.GA1809@sigill.intra.peff.net>
References: <1459432304-35779-1-git-send-email-cmn@dwim.me>
 <xmqqa8ler6pu.fsf@gitster.mtv.corp.google.com>
 <1459440486.2124.18.camel@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:30:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algQg-0003N1-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbcCaRa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 13:30:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:41740 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756222AbcCaRa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:30:28 -0400
Received: (qmail 31707 invoked by uid 102); 31 Mar 2016 17:30:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 13:30:27 -0400
Received: (qmail 15304 invoked by uid 107); 31 Mar 2016 17:30:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 13:30:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 13:30:25 -0400
Content-Disposition: inline
In-Reply-To: <1459440486.2124.18.camel@dwim.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290428>

On Thu, Mar 31, 2016 at 06:08:06PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> > I notice that you had to add GPGSM_MESSAGE string constant; does th=
e
> > current code without any change really work correctly if you set
> > 'gpg.program' to gpgsm and do nothing else?
>=20
> It does work for verify-commit which is what I've been playing around
> with since it just sends the contents of the 'gpgsig' header field to
> the verification function.
>=20
> I don't recall testing with verify-tag but there we might indeed have
> issues, since we parse the contents to see if we have the signature.

Ah, right, I think I had it backwards in my earlier posting. The
"gpgsig" headers are what trigger us for signed commits, not the "BEGIN
PGP" line, and verify-tag does indeed parse the signature out.

I think we'd also fail to pick up signatures from merges of signed tags=
=2E

-Peff
