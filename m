From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 13/15] compat: die when unable to set
 core.precomposeunicode
Date: Wed, 17 Feb 2016 11:34:19 +0100
Message-ID: <20160217103419.GA743@pks-xps.fritz.box>
References: <1455627402-752-1-git-send-email-ps@pks.im>
 <1455627402-752-14-git-send-email-ps@pks.im>
 <435511DD-0B0F-437F-974C-65C7265188A8@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 11:34:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVzRD-0002TW-1b
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 11:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934052AbcBQKeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 05:34:22 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45700 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933850AbcBQKeV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2016 05:34:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 372B520A81
	for <git@vger.kernel.org>; Wed, 17 Feb 2016 05:34:21 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 17 Feb 2016 05:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=cRGOB3jfz87fbffgdncmdGUtdYw=; b=dG0OZ
	zMUKONk60VJrFxCzugj7XdyUYyX/r5s1E9adkzOqRmT1z5fmDas7moOG0acAk9w4
	IpOeMWHQdJ7bwgPEI9OI999CU50M1fsH+12iNSudxO5fj8HIP3D3mEhSRbPAr1K4
	QsMInLAg+tANDSRSU5fhGbJ7rStf2B9M7+G74o=
X-Sasl-enc: 0MR/6lhkpzPMotaMI9am6B78zuiqVujGZ5A7GFuruJoN 1455705260
Received: from localhost (p5088a9c6.dip0.t-ipconnect.de [80.136.169.198])
	by mail.messagingengine.com (Postfix) with ESMTPA id AA415C00014;
	Wed, 17 Feb 2016 05:34:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <435511DD-0B0F-437F-974C-65C7265188A8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286491>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2016 at 10:14:57AM +0100, Lars Schneider wrote:
>=20
> On 16 Feb 2016, at 13:56, Patrick Steinhardt <ps@pks.im> wrote:
>=20
> > When calling `git_config_set` to set 'core.precomposeunicode' we
> > ignore the return value of the function, which may indicate that
> > we were unable to write the value back to disk. As the function
> > is only called by init-db we can and should die when an error
> > occurs.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > compat/precompose_utf8.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> > index 079070f..9ff1ebe 100644
> > --- a/compat/precompose_utf8.c
> > +++ b/compat/precompose_utf8.c
> > @@ -50,7 +50,8 @@ void probe_utf8_pathname_composition(void)
> > 		close(output_fd);
> > 		git_path_buf(&path, "%s", auml_nfd);
> > 		precomposed_unicode =3D access(path.buf, R_OK) ? 0 : 1;
> > -		git_config_set("core.precomposeunicode", precomposed_unicode ? "true=
" : "false");
> > +		git_config_set_or_die("core.precomposeunicode",
> > +				      precomposed_unicode ? "true" : "false");
>=20
> I haven't been actively following this topic, so I don't know much about
> it. However, I just noticed that the topic might brake the OS X build?
>=20
> https://travis-ci.org/git/git/jobs/109752716=20

Thanks for the notice. Seems I've forgotten to switch that back
to `git_config_set`. Didn't notice the breakage as the file
is not required on my system.

Patrick

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxEyrAAoJEBF8Z7aeq/EspQ4P/iaCCVEo5fEGv8GGZIbXO2PZ
e+P0a9T5ltGwgqrbpY0FNSavK/9Aobc3c0n0De134fPPapsJJf5dEYHX2OGynYWi
Mggkwy7SKOS4fzkLHZ/NceKQMmegDw4u0XgpkBtUn9ZXGJ1sDJ/rMTtTfFa7VMkP
sdWEKVeOLm99o/+5hjnkvF4A5ZvDBuNktezEsE+UR2BBKazFZcRmyUHtmZE+gvy5
lZwUi0+PeN3O9oOTK3NqhI2pGAbML6NOM3mbqQP6qoprL8oKJjWWEPWMei8aPLID
XHJAITWpBHADUYeqmNRsfhjWsoA6wI4PC56LCvY28YrWf4zo25bOIFgs3HgIFfhG
5k1qB6Az+7TXCGhS4cyjCLo0f7Xso6iqbzDzCIvo1fS/JM0XxTwfwLNaf9d36zon
i3wxolhb1yY8EkUQRD418RDk7P8IZMyDmPyDXYhwhSM50nZdQPCU80NjWR+WMIuz
5qlmwl752FdJSV/Z21n5K3B5v+j+mJ7mYxQ3Lbq0zDukZychs4nTBTIYE/6HnkQX
7KSmjLZSn3ZpQKrggT88fnCtmm6uEAPZNZIpeT5ZnUeDB5Y3GtD27mCc4z1sFTw3
6wbr2tQw1/5Gv+9CpJkWC5QQdpfr0HDsqGXjSuwAyI2jDd1994257gcIhJonMX1H
d0BTKxkvUHFgv6ojBOtr
=TqbX
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
