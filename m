From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/10] t4209: use helper functions to test --grep
Date: Mon, 24 Mar 2014 17:14:12 -0400
Message-ID: <20140324211412.GB13728@sigill.intra.peff.net>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
 <1395508560-19893-5-git-send-email-l.s.r@web.de>
 <xmqq38i7qwvx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCCI-0007Vk-Uw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbaCXVOP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 17:14:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:46019 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbaCXVOO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:14:14 -0400
Received: (qmail 7605 invoked by uid 102); 24 Mar 2014 21:14:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 16:14:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 17:14:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38i7qwvx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244868>

On Mon, Mar 24, 2014 at 11:22:58AM -0700, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > -test_expect_success 'log --grep -i' '
> > -	git log -i --grep=3DInItial --format=3D%H >actual &&
> > -	test_cmp expect_initial actual
> > -'
> > +test_log	expect_initial	--grep initial
> > +test_log	expect_nomatch	--grep InItial
>=20
> This, and the next --author one, assumes that we will never break
> "--grep=3Dfoo" without breaking "--grep foo".  That should be OK, but
> we might want to add separate tests e.g.
>=20
> 	test_log expect_initial --grep=3Dinitial
>=20
> perhaps?  I dunno.

Yeah, I I'd prefer "--grep=3D" here (and in all scripts).  In general, =
I
think our attitude should be that "--foo=3Dbar" is guaranteed to work
forever, but "--foo bar" is not. The latter only works if the argument
is non-optional, so that leaves us room to "break" compatibility to mak=
e
an argument optional in a future version.

Now, whether the rest of the world and its script-writers are aware of
this fact, I don't know. So it may be too late already (but it does loo=
k
like we mention it in gitcli(7)).

-Peff
