From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] http.c: Use timeout suggested by curl instead of
 fixed 50ms timeout
Date: Fri, 4 Nov 2011 13:51:27 -0400
Message-ID: <20111104175127.GA26118@sigill.intra.peff.net>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-3-git-send-email-mika.fischer@zoopnet.de>
 <7vehxndd4q.fsf@alter.siamese.dyndns.org>
 <CAOs=hRKxc9SdE_HTnfs+WdnxZEY6yF9MBV_K1FX2=7B7xtj7-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	daniel@haxx.se
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Fri Nov 04 18:51:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMNvR-0000kj-S4
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 18:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835Ab1KDRv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 13:51:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33554
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322Ab1KDRv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 13:51:29 -0400
Received: (qmail 3984 invoked by uid 107); 4 Nov 2011 17:51:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Nov 2011 13:51:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2011 13:51:27 -0400
Content-Disposition: inline
In-Reply-To: <CAOs=hRKxc9SdE_HTnfs+WdnxZEY6yF9MBV_K1FX2=7B7xtj7-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184790>

On Fri, Nov 04, 2011 at 06:47:44PM +0100, Mika Fischer wrote:

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (slot->in=
_use && !data_received) {
> > =C2=A0#if LIBCURL_VERSION_NUM >=3D 0x070f04
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 long curl_timeout;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0curl_multi_timeout(curlm, &curl_timeout);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (curl_timeout =3D=3D 0) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
>=20
> Ah yes, that's good. I would have done it this way in C++, but I
> wasn't sure whether C99 is OK for git.

C99 is not OK. But this is not C99, as the conditional opens a new
block.

-Peff
