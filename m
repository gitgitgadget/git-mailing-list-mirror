From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on
 --abbrev[-commit]
Date: Sun, 25 Apr 2010 23:45:21 -0400
Message-ID: <20100426034520.GB16500@coredump.intra.peff.net>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <20100426033147.GB14421@coredump.intra.peff.net>
 <20100426033813.GA30544@progeny.tock>
 <20100426034135.GB30544@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 05:45:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6FGC-0003qp-Vf
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 05:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab0DZDpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 23:45:24 -0400
Received: from peff.net ([208.65.91.99]:60375 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505Ab0DZDpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 23:45:23 -0400
Received: (qmail 3059 invoked by uid 107); 26 Apr 2010 03:45:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Apr 2010 23:45:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Apr 2010 23:45:21 -0400
Content-Disposition: inline
In-Reply-To: <20100426034135.GB30544@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145786>

On Sun, Apr 25, 2010 at 10:41:35PM -0500, Jonathan Nieder wrote:

> Jonathan Nieder wrote:
> > Jeff King wrote:
> >> On Sun, Apr 25, 2010 at 10:11:37PM -0500, Jonathan Nieder wrote:
>=20
> >>> +static void abbreviate_commit_hashes(char *fmt)
> >>> +{
> >>> +	char *p;
> >>> +	for (p =3D fmt; p !=3D NULL; p =3D strchr(p + 1, '%')) {
> >>> +		p++;
> >>> +		switch (*p) {
> >>> +		case 'H':
> >>> +			*p =3D 'h';
> >>> +			break;
> >>> +		case 'P':
> >>> +			*p =3D 'p';
> >>> +			break;
> >>> +		case 'T':
> >>> +		default:
> >>> +			break;
> >>> +		}
> >>> +	}
> >>> +}
> >>
> >> You parse '%%H' incorrectly.
> >
> > I=E2=80=99m pretty sure I don=E2=80=99t.
>=20
> Aggh, I see it now.  The first line should be
>=20
>  for (p =3D strchr(fmt, '%'); ...
>=20
> as I would have noticed with even a little testing.

Actually, we are both failing. You _do_ parse %%H right, but you don't
parse "WHO" correctly. So yours is a different bug than what I thought.
:)

-Peff
