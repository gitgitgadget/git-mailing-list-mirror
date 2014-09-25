From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RFC] log-tree: let format-patch not indent notes
Date: Thu, 25 Sep 2014 20:08:32 +0200
Message-ID: <20140925180832.GA31554@pengutronix.de>
References: <1411661409-24562-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <xmqqeguzboka.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 20:08:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXDT7-0007MP-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 20:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbaIYSIi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 14:08:38 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36543 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbaIYSIh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 14:08:37 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1XXDT0-0007Dw-60; Thu, 25 Sep 2014 20:08:34 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1XXDSy-00065c-Gn; Thu, 25 Sep 2014 20:08:32 +0200
Content-Disposition: inline
In-Reply-To: <xmqqeguzboka.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257490>

Hello Junio,

On Thu, Sep 25, 2014 at 10:24:53AM -0700, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:
> > Commit logs as shown by git-log are usually indented by four spaces=
 so
> > here it makes sense to do the same for commit notes.
> >
> > However when using format-patch to create a patch for submission vi=
a
> > e-mail the commit log isn't indented and also the "Notes:" header i=
sn't
> > really useful. So consequently don't indent and skip the header in =
this
> > case. This also removes the empty line between the end-of-commit ma=
rker
> > and the start of the notes.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > This commit changes the output of format-patch (applied on this com=
mit) from:
> >
> > 	...
> > 	case.
> >
> > 	Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > 	---
> >
> > 	Notes:
> > 	    This commit changes the output of format-patch (applied on thi=
s commit) from:
> >
> > to
> >
> > 	...
> > 	case.
> >
> > 	Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > 	---
> > 	This commit changes the output of format-patch (applied on this co=
mmit) from:
> >
> > which I consider to be more useful.
>=20
> I suspect that is fairly subjective, as the current one is in that
> form because those who wrote this feature first, reviewed, applied
> would have considered it more useful, isn't it?
Well, I thought when the feature to dump the notes into a patch was
created there was exactly one way these notes were written. This was wa=
s
designed for git-log and so intended and with "Notes:". For
git-format-patch it was good enough.

> Because I never send out a format-patch output without looking it
> over in an editor, I know I can easily remove it if I find the
> "Notes:" out of place in the output, but if the "Notes:" thing
> weren't there in the first place I may scratch my head trying to
> figure out where to update it if the information there were stale,
> so for that reason I'd find it more useful to have Notes: to remind
> me where that information comes from.
As you must explicitly request notes to be included in patches (--notes=
)
I think it's unusual to not know where the info comes from, doesn't it?

I don't know how many people use git-notes to track their comments, but
the first thing I do when editing patches is to remove the Notes: heade=
r
and s/^    // on the remaining lines. And most of the time this is the
only thing I do and I need to touch every patch only because of
that.

> But that is just my personal preference and I am willing to be
> persuaded either way with a better argument than "to me it looks
> nicer".
>=20
> As to indenting, because the material after three-dashes is meant to
> be fed to "git apply" or "patch", I'd prefer to keep it to avoid
> having to worry about a payload that may look like part of a patch.
> This preference is a bit stronger than the presence/absence of
> "Notes:".
Ok, that's a valid concern. If we want to assert that this doesn't look
like a patch we need to at least parse the notes and quote it somehow.
Hmm.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
