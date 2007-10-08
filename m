From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/2] Have a filter_start/filter_end API.
Date: Mon, 08 Oct 2007 09:29:47 +0200
Message-ID: <20071008072947.GB22552@artemis.corp>
References: <1191615571-15946-1-git-send-email-madcoder@debian.org> <1191615571-15946-2-git-send-email-madcoder@debian.org> <20071006090621.GB2711@steel.home> <20071007145355.GC10024@artemis.corp> <20071007160707.GA3270@steel.home> <20071007165218.GE10024@artemis.corp> <20071007215041.GB2765@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/WwmFnJnmDyWGHa4";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 09:30:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ien3v-0006K0-CU
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 09:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbXJHH3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 03:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbXJHH3t
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 03:29:49 -0400
Received: from pan.madism.org ([88.191.52.104]:52215 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbXJHH3t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 03:29:49 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BD5AE17A45;
	Mon,  8 Oct 2007 09:29:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 429B54B5C; Mon,  8 Oct 2007 09:29:47 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071007215041.GB2765@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60298>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2007 at 09:50:41PM +0000, Alex Riesen wrote:
> Pierre Habouzit, Sun, Oct 07, 2007 18:52:18 +0200:
> > Though, those are both things that I find ugly to "know" in convert.c.
> > How things are allocated in strbufs is one of the few things we don't
> > want to assume anywhere outside of the strbuf module.
>
> src is outside of strbuf scope. It is not internal to struct strbuf.
> The caller must already know if it is inside of the given strbuf
> instance.
>
> need_realloc is covered by make_room, isn't it?

  Internally yes, but make_room may move the buffer, if that happens,
there is nothing we can do, in the case where we point inside (or at the
begining of - fwiw it's the same here) the buffer

> I'd suggest just fix the caller, it is simple in convert.c: just use
> ret, which contains exactly this information. If you insist on editing
> in-place, which makes your routines really need the in-placeability
> informaion. Just give it to them, better explicitely. All of this
> makes the routines very convert.c specific, which is the reason why I
> argument to have them just there and nowhere else.
>=20
> Alternatively, one can memdup ->buf (as it is the input for next
> filter) every time a filter modifies it (which is safe, but simple,
> slow, requires memory, and may fragment heap):

  This is exactly what we are trying to avoid with the current form.
Given how you try to micro-optimize strbuf_cmp I'm a bit lost here=E2=80=A6

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHCdxrvGr7W6HudhwRArhdAKCqK1UltJqB/WcuuZzHivYdSk+FMgCgkTjY
uz66CInEr9Yk7YjvDmJm6s0=
=UuIX
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
