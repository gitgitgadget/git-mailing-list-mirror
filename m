From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] rev-parse: fix --parse-opt --keep-dashdash
 --stop-at-non-option
Date: Thu, 8 Jul 2010 12:18:48 +0200
Message-ID: <20100708101848.GA12789@madism.org>
References: <1278427565-11057-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <7vr5jfrmuq.fsf@alter.siamese.dyndns.org>
 <20100708072623.GC21565@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Luotao Fu <l.fu@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Jul 08 12:18:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWoC2-0000pV-3J
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 12:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab0GHKSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 06:18:52 -0400
Received: from pan.madism.org ([88.191.52.104]:41794 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480Ab0GHKSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 06:18:51 -0400
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7FCCA4EFE9;
	Thu,  8 Jul 2010 12:18:49 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 98B0D2B0B88; Thu,  8 Jul 2010 12:18:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100708072623.GC21565@pengutronix.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150555>

On Thu, Jul 08, 2010 at 09:26:23AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Jul 07, 2010 at 02:41:33PM -0700, Junio C Hamano wrote:
> > Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:
> >=20
> > > The ?: operator has a lower priority than |, so the implicit asso=
ciativity
> > > made the 6th argument of parse_options be PARSE_OPT_KEEP_DASHDASH=
 if
> > > keep_dashdash was true discarding PARSE_OPT_STOP_AT_NON_OPTION an=
d
> > > PARSE_OPT_SHELL_EVAL.
> >=20
> > Wow, this is an age-old breakage dating back to 6e0800e (parse-opt:=
 make
> > PARSE_OPT_STOP_AT_NON_OPTION available to git rev-parse, 2009-06-14=
) that
> > dates back to the very original --stop-at-non-option patch, isn't i=
t?
> I made a quick C-quiz at my company asking what's wrong with 6e0800e.
>=20
> Apart from the bug fixed in my patch a colleague wondered about
> stop_at_non_option being static.  I think it doesn't do any harm, sti=
ll
> I think being an automatic variable would be more common.  Is the sta=
tic
> intended here?  This was introduced in
> 21d4783538662143ef52ed6967c948ab27586232, so I cc:d Pierre.

Well, the sole difference is that it makes &stop_at_non_option been
computed at compile time instead of runtime, which is pretty much the
same. cmd_parseopt isn't meant to be reentrant so it's not important.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
