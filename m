Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12502C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiCAJZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiCAJZL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:25:11 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FAB2B271
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:24:28 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 78D315C020F;
        Tue,  1 Mar 2022 04:24:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 01 Mar 2022 04:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=MKWE6Nto5UDtUQwzNJH32ifrqjLDQbddmURz6G
        PvTEs=; b=v83JjGkhZ9zNuBVLLkz98z5Muk1gQyJhORZZdWWTaVHxNzFOFqaNyK
        ydxaMt63ozkaMu25K1EE1yz0DPzSl6Ovd9Va6TP+y2P+ZxCvIpnZB519gbT3pzl2
        V+BJVoRLn4lXkkd1OwXrh5ARIbqQz1wOJlSxwcXHXsiOcl5hmGEYyKc5QTSiIhHY
        xMyechmpmyBNSmpv1DYk+uGjfoOM5X4kosSTus+RcW7U5TegZA5oGa1jWYjk99QU
        AXVGJ6mngCswu/yBs5MAimfwvuP5dKb4vrgeZ6KCsGHzB62le2hZOALzjkicqVBc
        aybfJfbrovL/xzZtiwT91Gb6Uh9hattg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MKWE6Nto5UDtUQwzN
        JH32ifrqjLDQbddmURz6GPvTEs=; b=nP6XBIifD1PYqbWi0foth9IInct5Q3XLh
        UV4yNpwEZJtcKm7OETiA4ahFRl3tAWYjk/WZU82TBr/l7cK/NFjeWJ0PpDkBqD8Q
        R+nsQH25a4yUQ7FjnRjHcSoYxqYIJpeRvGOG6xG153VX+YU5zt0VuLOQYQynoGG6
        Hannqq2l0j7lQxtkAmvDb3HHUuuIDcYtLTLHAj5vtS6/7ZoZesy0ro5p2Fk3OxBx
        0FO0k9eFM1qIa07+kos1+HV7x+giiSoBLfiLcg/kZG9tscRpGEE9vmIvyahGKtYN
        Dxq59fqZPbDKSCVcaZ0pu+tB/v6NSpaNd4zeMCetH+SNzbKNj/EjA==
X-ME-Sender: <xms:S-YdYuowVswiYiD7VYrMWHlH06SzmDxks5Ry0V3KwBXjYQmRG6DcHQ>
    <xme:S-YdYsorU7wwlDGRvD5Mpd2K2_U6R1t_vKbnx-9rpu8r-Gl26f5uA8kNOWfjxMVnb
    owZzQIPm6WkFFCcDg>
X-ME-Received: <xmr:S-YdYjN5WWqa8vEqysy1H76WEQyCjl5eGi8S3Hif8PC1xb0jDp_CMHXo2rR6WNPeabkR1Xl62Cc3dio0DA-hS_dabw1XZzS1yRFZr8duN16awziima0DFkVN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:S-YdYt7Y4-T7eux0QnOeVWVCKBqRIv-GoTIocnLbPlEW96VWQLR4Og>
    <xmx:S-YdYt6OxtYekMgArWfiH-PjidYqZS6PKaizrM6jVTazh6Ge6Au5iA>
    <xmx:S-YdYtjkdJDcispxfepAApKZ-ziFAQpkehLfjXV0TDd70xN9xa4M0g>
    <xmx:S-YdYqhpe6FRJ4IUhYMBD47_TVc2OzkWOuJ5NpdvVrwnm2OIE5iC_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 04:24:26 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f8933489 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 09:24:24 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:24:23 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] upload-pack: look up "want" lines via commit-graph
Message-ID: <Yh3mR3/h/+nFyF6V@ncase>
References: <cover.1645619224.git.ps@pks.im>
 <ca5e136cca495c7d927e99f5ae8a672d93823eea.1645619224.git.ps@pks.im>
 <ddb91a1d-6ddf-ba25-f1af-ba3f4c18726e@github.com>
 <Yh3cprbfc/UQ01fo@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlQw5LdNN5zNwRoY"
Content-Disposition: inline
In-Reply-To: <Yh3cprbfc/UQ01fo@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UlQw5LdNN5zNwRoY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 09:43:19AM +0100, Patrick Steinhardt wrote:
> On Wed, Feb 23, 2022 at 09:13:53AM -0500, Derrick Stolee wrote:
> > On 2/23/2022 7:35 AM, Patrick Steinhardt wrote:
> >=20
> > > The following benchmark is executed in a repository with a huge number
> > > of references. It uses cached request from git-fetch(1) as input and
> > > contains about 876,000 "want" lines:
> > >=20
> > >     Benchmark 1: git-upload-pack (HEAD~)
> > >       Time (mean =C2=B1 =CF=83):      7.113 s =C2=B1  0.028 s    [Use=
r: 6.900 s, System: 0.662 s]
> > >       Range (min =E2=80=A6 max):    7.072 s =E2=80=A6  7.168 s    10 =
runs
> > >=20
> > >     Benchmark 2: git-upload-pack (HEAD)
> > >       Time (mean =C2=B1 =CF=83):      6.622 s =C2=B1  0.061 s    [Use=
r: 6.452 s, System: 0.650 s]
> > >       Range (min =E2=80=A6 max):    6.535 s =E2=80=A6  6.727 s    10 =
runs
> > >=20
> > >     Summary
> > >       'git-upload-pack (HEAD)' ran
> > >         1.07 =C2=B1 0.01 times faster than 'git-upload-pack (HEAD~)'
> >=20
> > Nice!
> >=20
> > > -		o =3D parse_object(the_repository, &oid);
> > > +		commit =3D lookup_commit_in_graph(the_repository, &oid);
> > > +		if (commit)
> > > +			o =3D &commit->object;
> > > +		else
> > > +			o =3D parse_object(the_repository, &oid);
> > > +
> >=20
> > This is a neat trick. I see that we've also done this trick in
> > revision.c:get_reference(). Perhaps it is worth creating a helper,
> > maybe named parse_probably_commit()?
>=20
> That might be a good idea, thanks. I'll have a look at what the end
> result would look like.
>=20
> Patrick

I had a look at existing callsites which use `lookup_commit_in_graph()`,
but I found that it wasn't easily possible to convert them all to use a
new helper like you propose. Most of them have some custom logic like
skipping `parse_object()` if it's part of a promisor pack, so I really
only found two locations where such a new helper could be used without
also adding and supporting flags. I don't really think that's worth it
for now.

Patrick

> > >  		if (!o) {
> > >  			packet_writer_error(writer,
> > >  					    "upload-pack: not our ref %s",
> > > @@ -1434,7 +1440,7 @@ static int parse_want_ref(struct packet_writer =
*writer, const char *line,
> > >  	if (skip_prefix(line, "want-ref ", &refname_nons)) {
> > >  		struct object_id oid;
> > >  		struct string_list_item *item;
> > > -		struct object *o;
> > > +		struct object *o =3D NULL;
> > >  		struct strbuf refname =3D STRBUF_INIT;
> > > =20
> > >  		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
> > > @@ -1448,7 +1454,15 @@ static int parse_want_ref(struct packet_writer=
 *writer, const char *line,
> > >  		item =3D string_list_append(wanted_refs, refname_nons);
> > >  		item->util =3D oiddup(&oid);
> > > =20
> > > -		o =3D parse_object_or_die(&oid, refname_nons);
> > > +		if (!starts_with(refname_nons, "refs/tags/")) {
> > > +			struct commit *commit =3D lookup_commit_in_graph(the_repository, =
&oid);
> > > +			if (commit)
> > > +				o =3D &commit->object;
> > > +		}
> > > +
> > > +		if (!o)
> > > +			o =3D parse_object_or_die(&oid, refname_nons);
> > > +
> >=20
> > Even here, we _could_ use a parse_probably_commit() helper
> > inside the if (!starts_with(...)) block, even though we would
> > still need the if (!o) check later.
> >=20
> > Thanks,
> > -Stolee



--UlQw5LdNN5zNwRoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId5kYACgkQVbJhu7ck
PpSKUBAAmYQ2v0Qcc2zryYpQAO6pCtj7tt+ZMZR+zgXLqZfibz+LHEMMZ/8U3+Ke
CVvJR35iK0iw4kXUio3N78aXN0ed86U5wvQmspOMMrKRVsPd2iTUTawspbMihX8P
RKotrEk7jRX/gcSFNXFQUk+qe+TGQQzcs1gikFNzXEFzwDhz37qNWAG0MZqIMaGn
YR8hcLIAdUBJAMvjJZkrNzPoyN5jNPZTpU42f90y+rNAYqhBR0S7Og5QHjusfwW3
WIdPMhCbfu0mb/8gQl6Ivyz7Ez9OLn78I/t40Gnyxr/zDeLzB0rj0p4EWbrw03dX
QFRPpXOvlevRptiK3NfGrgc9GKryz/EMHVGhA82S8dSxQnYELbvim5Kn0Y331b/Y
AHYWBPDRbjIHeoYjBlqDYf1FsOFw7ZFlQjatcvRZqNA7aEhSSuQhOumn7JwKJxfe
RzJXDRu06lEDaJWZoYvb5ZF+R0rIx8ooOigeaG+hMILTp5UfkoHng5N4aSXxPZy7
xSobQQW34yui2Y8pCP/bxti9w4ce6SYcXX4LfmFhFgEdnWWu/gnV57ZDC8Y+mTV0
wzrmL8gorg2s1vXMdMQH4tr1yAOZ/Q1CMJRyR7WgwLaEoDjswwcF2CZzNJoEtWLH
2fjKlJKd6m6QUMUf0tEpFvbrpCxSN1p3fEz6xH55/0fnwJtoKkI=
=B0zG
-----END PGP SIGNATURE-----

--UlQw5LdNN5zNwRoY--
