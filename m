From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC PATCH 0/2] Allow detached forms (--option arg) for git
 log options.
Date: Thu, 29 Jul 2010 20:33:10 +0200
Message-ID: <20100729183310.GA3891@madism.org>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
 <m37hkhklll.fsf@localhost.localdomain>
 <20100728130610.GG6895@madism.org>
 <201007291116.44859.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 20:33:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeXuz-0007KD-UP
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 20:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476Ab0G2SdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 14:33:14 -0400
Received: from pan.madism.org ([88.191.52.104]:46439 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756399Ab0G2SdN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 14:33:13 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B598E4FCE1;
	Thu, 29 Jul 2010 20:33:11 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A633668A; Thu, 29 Jul 2010 20:33:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201007291116.44859.jnareb@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152193>

On Thu, Jul 29, 2010 at 11:16:42AM +0200, Jakub Narebski wrote:
> On Wed, 28 Jul 2010, Pierre Habouzit wrote:
>=20
> > you cannot take the address of a bit portably in C, so you can't le=
t
> > parseopt set/clear bits through bitfields (as in unsigned field : 1=
 in a
> > struct in C I mean).
> >=20
> > So to use parseopt OPTION_BIT feature, you have to convert them to =
C
> > flags as in "unsigned flags" and explicit masks defines/enums.
> >=20
> > IOW:
> >=20
> >     struct foo {
> >        unsigned bar : 1,
> > 		...
> > 		  baz : 1;
> >     };
> >=20
> > Must be converted into:
> >=20
> >     struct foo {
> >     #define FOO_FLAG_BAR (1U <<  1)
> >     ...
> >     #define FOO_FLAG_BAZ (1U << 18)
> >       unsigned flags;
> >     }
> >=20
> > so that you can use parseopt.  that's what I meant.
> >=20
> >=20
> > This was done for the rev-list parsing stuff e.g.
>=20
> e.g. what?

err no, not rev-list, diff options: struct diff_options::flags and the
DIFF_OPT_* defines

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
