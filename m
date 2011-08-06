From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/5] macro-based key/value maps
Date: Sat, 6 Aug 2011 00:30:53 -0600
Message-ID: <20110806063052.GA3583@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713065700.GA18566@sigill.intra.peff.net>
 <20110713175250.GA1448@elie>
 <20110713200814.GD31965@sigill.intra.peff.net>
 <20110714173454.GA21657@sigill.intra.peff.net>
 <7vipr4373f.fsf@alter.siamese.dyndns.org>
 <20110804224354.GA27476@sigill.intra.peff.net>
 <20110805110302.GA23619@sigill.intra.peff.net>
 <4E3C0CD9.4020902@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Aug 06 08:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpaQ4-0004jg-0D
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 08:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab1HFGa5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 02:30:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43421
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab1HFGa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 02:30:56 -0400
Received: (qmail 2701 invoked by uid 107); 6 Aug 2011 06:31:30 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Aug 2011 02:31:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Aug 2011 00:30:53 -0600
Content-Disposition: inline
In-Reply-To: <4E3C0CD9.4020902@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178829>

On Fri, Aug 05, 2011 at 05:31:37PM +0200, Ren=C3=A9 Scharfe wrote:

> Am 05.08.2011 13:03, schrieb Jeff King:
> >   Commits 1, 4, and 5 introduce infrastructure in the form of stati=
c
> >   functions and macros that contain functions that call the statics=
=2E But
> >   they don't actually instantiate the macro functions themselves, s=
o
> >   they won't compile with -Werror (due to the "unused static" warni=
ng)
> >   until there is some calling code.
> >=20
> >   That hurts bisectability a little if you compile with -Werror (yo=
u
> >   need to add -Wno-error=3Dunused-function). I don't know how much =
we
> >   care.
>=20
> I don't know either, but you could avoid the issue by adding a test-m=
aps
> command in the first patch and exercising the new functionality a bit=
=2E

Yes, but then the final git executable carries around dead code for the
test map and cache types. There are ways to split the macros versus
their instantiation so that the test instantiations only live in the
test-map program, but then that would bring back the "static is not
used" error.

Maybe carrying the dead code isn't that big a deal. It's not that much
extra code.

-Peff
