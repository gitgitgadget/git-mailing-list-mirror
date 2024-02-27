Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E11DFE1
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052603; cv=none; b=agId4dxK2QZq0A1hFij6Of/5puYnKsoM8R/EUdsvwOpF3ETwWmovWWIFqHnzJowNM3ycF0ngYoDVoxrG8Hm94fuos9rzxlqKZ/0TenZhmlL197LezlVJDorxknYdT+cHkE71ITEYdOgiuo5FUxVDrvyt3GelMAe69xSuHbbaOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052603; c=relaxed/simple;
	bh=7GEKDy6uzN23m3HRhMf0pdDzrQZgICsEW9eyxzDO4NE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUEwhU9s03EYPwqmSFZ963kjsOQYQRg6yNRhf9zDkWTkfKzXiB6wi+1zNaUp5f+tZ3VzhSWkpdMncKFePj65OSSgBRjQqMkI+UaDXAm5I4eA64+PHzGcDhYwrvH4jg2S2Q53zpb0Vb8eZFuR0QG1w0KTqnJ8aG3W3vRfQ3+UiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YaA55PoD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hAiVUDFI; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YaA55PoD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAiVUDFI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 741D0180007A
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 11:49:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Feb 2024 11:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709052598; x=1709138998; bh=C2cAFeAzxk
	07MN77Qevav7XrXIXya1tdp1ajWvBghjg=; b=YaA55PoDjYTwSHIgTSHP7CemYH
	Qs7G7MiAT7YNUZDcrttLkhX+dRx6J+waG1f2UwwEH7SB+KPY4aEHxxuWvP1Cj1CQ
	Jo/XmjyUmxPHLeDl6y2JLwl7KnW/q44f/Lu3SpO5UU2GpK3kItfVbPbBV0/gTrAH
	GyFKOvvvhd1p5cxA7FUGK7Qoy/qPn/xTq8cBNdUF1qf/+Nulod9zjLG+zAQVn8n6
	eb4Jo8o3KJ3tYvG+YAt+vrjQptFuingoVzWy8+Ikzk1yY+ggRBlDD5kj9iqEJuY3
	BuzYy1fieSek4HDP25Fn7LCGu949Z/+KMF07T0pYlhhbJLr3hb0GbOUxwY8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709052598; x=1709138998; bh=C2cAFeAzxk07MN77Qevav7XrXIXy
	a1tdp1ajWvBghjg=; b=hAiVUDFInYhCPaf0Xr7kpulFAl+sP/ZSD9iwKrIfj/Nc
	YtoJ8W3PVQEHypCifJqAWfV7KSbZ6Z6SJEtpWUOPw5D6qd1zR55L0xkhIh0vr3WO
	2RJfwVdAbrInbAerNLBXrTIoAoi8MBJQ4Wp0b+wzPZ45Y7av5EbXi6STAT5RgaXg
	/VBDIsBdVKQ6XiTEhlja7H8aT+h+wtglCFLrEsk3h23wHJlLzVIbrmHNuqXTmgBW
	ijkji1OOciPd/E2sqsHnX/u35CGgPZq4lC+eYHSbXUPXXH8YoPKJMu/CiOSziyFl
	/c5oef1Dd0rfNrYO4GjAOlDNkFuAPocuRlfY6lb8iA==
X-ME-Sender: <xms:thLeZbFZUdgy3e3kQUCG5H2Ez2fgwYt0TYaUMym_Nl8VkNDeH6_1ug>
    <xme:thLeZYVSWqYM-0frtjvXbWCY0vsYkSa2sb5v4aYRLk9P6rVVRiqdpyFS-ADqwCHtm
    QLfZkNLaQudL2nT3A>
X-ME-Received: <xmr:thLeZdL4lFqjVVtwhzPpidsERu-OvYOU5OSgqR6J6LuaG1_jJXcDj9Hyku9BgFEx1nCYrRu5m_SwFyaU93qNRW5DNKGDpcWvsiRh8VHi9tTIbQcB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:thLeZZEJditxJOao3RNycT3P0oDKoeuETnhjqbOWJV5BiWeNep7o1Q>
    <xmx:thLeZRUdyll_u-Cy7cbRaZBQuDA86UV31hFuvpYeAvcl1Qk5WPF5Lg>
    <xmx:thLeZUPccVf-fBGz_fW1xg03fnGaOmZ9ZRCa0XrKu_hwhIoDdzZNhA>
    <xmx:thLeZQdWdHb5L_SG1Iih-kohizydOiT3hyDt6HdMjT8dxBumBJgNJlLBwSU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Feb 2024 11:49:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 35a3197f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Feb 2024 16:45:40 +0000 (UTC)
Date: Tue, 27 Feb 2024 17:49:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 02/12] reftable/merged: make `merged_iter` structure
 private
Message-ID: <Zd4Ss37Yl4d-oEzE@ncase>
References: <cover.1707895758.git.ps@pks.im>
 <be807e7650e2b11e5d6f7dd84ca1c549408f678a.1707895758.git.ps@pks.im>
 <qprofop624nevbicid4rplfqlanfrujyxiilfqwchrppnmw7u4@3dvw5udjtrah>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxuWcdz2JYj4J/54"
Content-Disposition: inline
In-Reply-To: <qprofop624nevbicid4rplfqlanfrujyxiilfqwchrppnmw7u4@3dvw5udjtrah>
X-TUID: GFeAQibNQ3o4


--lxuWcdz2JYj4J/54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:15:23PM -0600, Justin Tobler wrote:
> On 24/02/14 08:45AM, Patrick Steinhardt wrote:
> > The `merged_iter` structure is not used anywhere outside of "merged.c",
> > but is declared in its header. Move it into the code file so that it is
> > clear that its implementation details are never exposed to anything.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/merged.c | 9 +++++++++
> >  reftable/merged.h | 9 ---------
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/reftable/merged.c b/reftable/merged.c
> > index 1aa6cd31b7..12ebd732e8 100644
> > --- a/reftable/merged.c
> > +++ b/reftable/merged.c
> > @@ -17,6 +17,15 @@ license that can be found in the LICENSE file or at
> >  #include "reftable-error.h"
> >  #include "system.h"
> > =20
>=20
> suggestion: I think it would be nice to document a little about the
> merge iterator here at a high-level. Maybe just to explain that this
> allows iteration over multiple tables as if it were a single table.

Agreed. I have planned to invest more time into documenting the reftable
library overall, but would rather want to push this out to another patch
series.

> > +struct merged_iter {
> > +	struct reftable_iterator *stack;
> > +	uint32_t hash_id;
> > +	size_t stack_len;
> > +	uint8_t typ;
> > +	int suppress_deletions;
> > +	struct merged_iter_pqueue pq;
> > +};
> > +
> >  static int merged_iter_init(struct merged_iter *mi)
> >  {
> >  	for (size_t i =3D 0; i < mi->stack_len; i++) {
> > diff --git a/reftable/merged.h b/reftable/merged.h
> > index 7d9f95d27e..288ad66656 100644
> > --- a/reftable/merged.h
> > +++ b/reftable/merged.h
> > @@ -24,15 +24,6 @@ struct reftable_merged_table {
> >  	uint64_t max;
> >  };
> > =20
>=20
> Since we are removing `merge_iter` from the header here, I think we can
> also remove the `#include "pg.h"`.

Good catch! We can replace it with "system.h", which makes sure to
include <git-compat-util.h>.

Patrick

--lxuWcdz2JYj4J/54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXeErMACgkQVbJhu7ck
PpQzEBAAp/vLSVZywMBccIsqRRbQ2zHLSYyvV5AwwbUDPX8tOsHGLFZ1z2iGwenX
O/+ZQJKalYOxEc8wXsE55V0V0olHtV7NVsooOCWAohfnH3PM1EBu8083dgFDbPwi
2z2aiy+IUwsi3ni+kpLuTPi4s+vDQzc124cFqRbV+jqWsrQWKyCN+QzgJseG60/z
bHZWdUfBX3JO5Y+CVnzFClRKPtQkDB1AEy/5EEMJoeHC/rZqP7wnj2hI4nyjfzSa
Z1R955pq/fwMUtQ/g3ACSJZmfvSL7LwosqneNCae1mMK6CuelW3WkiTBYi9JK/kL
R6AkKDuOROaQ2ZGywr84ooJupVV1Zzy2t5DXAhkHKCMLjtrfW4rwn7V+t3d44brd
lZ1c3EEmOsKaqAcyL+34YxeukcsyhEw4j02gSMbTZ1qbvbEKBpClGPFADy1TQ4AF
bUwoRV1xYZhgD7OGi26i5gDkTXnEsT8Dl3dXv61DChF4aTMrsMkOEo4xOXMe98mp
/109x5RGOfEV7MfUsc1TS6JMp92uZ0hOYrS1q1Hf1TXHiRxW51B9gn66Vm5Xs6S2
1+cNUBXtbmf7AtXqn+Z+lin6VGiTOxiy584sOwNiv3UWK79EVPoOv50L1fMjZBhx
URUBaCuCU6QoCFcsCQ3+dlBNSSeUsilsh4/YYbe0XpxpBDndRWk=
=R7V5
-----END PGP SIGNATURE-----

--lxuWcdz2JYj4J/54--
