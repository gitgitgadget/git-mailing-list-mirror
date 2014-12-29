From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refs: release strbuf after use in
 check_refname_component()
Date: Mon, 29 Dec 2014 16:13:13 -0500
Message-ID: <20141229211312.GA26793@peff.net>
References: <549A0665.6080207@web.de>
 <xmqq387y1hnc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 22:13:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hcu-0000a3-D8
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbaL2VNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2014 16:13:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:57660 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752412AbaL2VNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:13:15 -0500
Received: (qmail 18868 invoked by uid 102); 29 Dec 2014 21:13:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Dec 2014 15:13:15 -0600
Received: (qmail 598 invoked by uid 107); 29 Dec 2014 21:13:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Dec 2014 16:13:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Dec 2014 16:13:13 -0500
Content-Disposition: inline
In-Reply-To: <xmqq387y1hnc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261878>

On Mon, Dec 29, 2014 at 09:37:43AM -0800, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > Signed-off-by: Rene Scharfe <l.s.r@web.de>
> > ---
> >  refs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/refs.c b/refs.c
> > index 5fcacc6..ed3b2cb 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2334,7 +2334,7 @@ static struct ref_lock *lock_ref_sha1_basic(c=
onst char *refname,
> >  			struct strbuf err =3D STRBUF_INIT;
> >  			unable_to_lock_message(ref_file, errno, &err);
> >  			error("%s", err.buf);
> > -			strbuf_reset(&err);
> > +			strbuf_release(&err);
> >  			goto error_return;
> >  		}
> >  	}
>=20
> The subject does not seem to match what the patch is doing, but the
> patch is obviously correct ;-)

The worst part of this is that I got it right in my hacked-up version:

  http://article.gmane.org/gmane.comp.version-control.git/259853

but then after much discussion, we dropped all of the lead-in patches,
and I sent Ronnie's unedited:

  http://article.gmane.org/gmane.comp.version-control.git/259911

All that looking and I didn't notice the release/reset difference
between our two versions. Sheesh.

Which is all a roundabout way of saying "yes, Ren=C3=A9's patch is obvi=
ously
correct". :)

-Peff
