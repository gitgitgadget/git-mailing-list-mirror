From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] rev-parse: fix --parse-opt --keep-dashdash
	--stop-at-non-option
Date: Thu, 8 Jul 2010 14:44:35 +0200
Message-ID: <20100708124435.GA26404@pengutronix.de>
References: <1278427565-11057-1-git-send-email-u.kleine-koenig@pengutronix.de> <7vr5jfrmuq.fsf@alter.siamese.dyndns.org> <20100708072623.GC21565@pengutronix.de> <20100708101848.GA12789@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Luotao Fu <l.fu@pengutronix.de>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 14:44:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWqTH-0000zw-9d
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 14:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab0GHMot convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 08:44:49 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48775 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215Ab0GHMos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 08:44:48 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1OWqT1-00028G-W9; Thu, 08 Jul 2010 14:44:40 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1OWqSx-00056t-Jt; Thu, 08 Jul 2010 14:44:35 +0200
Content-Disposition: inline
In-Reply-To: <20100708101848.GA12789@madism.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150570>

Hi Pierre,

On Thu, Jul 08, 2010 at 12:18:48PM +0200, Pierre Habouzit wrote:
> On Thu, Jul 08, 2010 at 09:26:23AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jul 07, 2010 at 02:41:33PM -0700, Junio C Hamano wrote:
> > > Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:
> > >=20
> > > > The ?: operator has a lower priority than |, so the implicit as=
sociativity
> > > > made the 6th argument of parse_options be PARSE_OPT_KEEP_DASHDA=
SH if
> > > > keep_dashdash was true discarding PARSE_OPT_STOP_AT_NON_OPTION =
and
> > > > PARSE_OPT_SHELL_EVAL.
> > >=20
> > > Wow, this is an age-old breakage dating back to 6e0800e (parse-op=
t: make
> > > PARSE_OPT_STOP_AT_NON_OPTION available to git rev-parse, 2009-06-=
14) that
> > > dates back to the very original --stop-at-non-option patch, isn't=
 it?
> > I made a quick C-quiz at my company asking what's wrong with 6e0800=
e.
> >=20
> > Apart from the bug fixed in my patch a colleague wondered about
> > stop_at_non_option being static.  I think it doesn't do any harm, s=
till
> > I think being an automatic variable would be more common.  Is the s=
tatic
> > intended here?  This was introduced in
> > 21d4783538662143ef52ed6967c948ab27586232, so I cc:d Pierre.
>=20
> Well, the sole difference is that it makes &stop_at_non_option been
> computed at compile time instead of runtime, which is pretty much the
> same. cmd_parseopt isn't meant to be reentrant so it's not important.
I don't know about x86, but I think on arm computing at compile time
isn't cheaper than at runtime, it's just pc-relative instead of
sp-relative.  But having the variable automatic saves a bit of heap.
Probably not worth to discuss about these two ints though.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
