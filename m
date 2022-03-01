Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73DAC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiCAIoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCAIoG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 03:44:06 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E2F7C789
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 00:43:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A84865C0272;
        Tue,  1 Mar 2022 03:43:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 01 Mar 2022 03:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=olEVLD67JA1E3ETnDXtOhZJka7EX2kT55NGvuF
        EdTtg=; b=T6KwLi4fHD1xye5JvuDjnfntG1W6f1XSQmRQyR/PB40WuD/wUxGU5o
        dWdp+dqa6hwHP9BCEYDfahug9ZgP5QxP3flHr34aFezraKV7q1TowR92tsGN5eac
        3HBtenps/laS34MYxTw+dclhBVDZui26bXu6PEVQTQo287dbEl6tPw00iccWxdbC
        9IGUGHb/fL6CyGt2+ZB09hrLUea7e0Cxr2qDvp9bQv2K8rNmJ18e5NrcOhbltRvM
        imrBXwWouuP4VjMQjY4XKPqTC10cYRN+bjEx1azzFFPFeDovYAHiS2x6hCD2q2fW
        XEecPbPcqPozrKsXZRxxd7Kj0Xac6aNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=olEVLD67JA1E3ETnD
        XtOhZJka7EX2kT55NGvuFEdTtg=; b=K76WV13c9FY4y4U6tFbb563NVsJYyMZSN
        4+qiaVrVvO29F+KU8RbSW37nDUDj4yDqyvK8v3pS+y1qVj81BcjPBK5PvS315+v7
        UP5PM5CZiVgRQZ8q0xWriYo4yYfciKNOydozovrI9MGU/UAMRsICFzXU95i2zZvs
        Mqd9gb/7J22kXP+oTyQ0ongTsCWrZuhs83n7QdFSB+rvCxby26lad6uwI4FewfKa
        bpxNWef/qUqHTspNpyNjn1xU1MUIiNh5xjyJrj/X/eV35qLOvid8A8h9WuXTeJ4d
        Mn4463n3mZexB+W4t1srzPU8x6Cs51dShPL9e+vJZLtmc+XGyD11Q==
X-ME-Sender: <xms:qtwdYoaBa5GbDzN2HbxzUTrmAuBIb92ZMKEA87qNyqIAelED0vJ7Jg>
    <xme:qtwdYjamomQrdrGg0nrvgQXxBBq8UCZSyUtqKrMVOqeJAGC6qVvufAU7C044Ig9U4
    lOuHoQyw7rgOlVCUg>
X-ME-Received: <xmr:qtwdYi-hvf_eIVUiziah5uflDgygl2PFXI_Nh1o-Li7K_-NqwHr7NZ15eZatg8njBrL746YGs_I9ebPiHvMkuU9dEFhA5MPVKEiZEuHLlfm1deIzHCuioGdR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qtwdYipHxeBp-UjBXT1pghfzIdyeJcUcC0aQt3X6vJxYf4jlH44IzA>
    <xmx:qtwdYjrN6jRFryv--VEfTBRs21f29kGm-GE0x1Mxfb5jO4kMgWx07A>
    <xmx:qtwdYgQaunrrQUwMdGersUUNxdMFBX4DgkrZ7MGDqmfTHshAA3WN_Q>
    <xmx:qtwdYiQVpmOVPkvJb5NpoPgQpSY5rYHQnNGW3DsAujVB8JVlp5xaEA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 03:43:21 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ba8286d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 08:43:19 +0000 (UTC)
Date:   Tue, 1 Mar 2022 09:43:18 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] upload-pack: look up "want" lines via commit-graph
Message-ID: <Yh3cprbfc/UQ01fo@ncase>
References: <cover.1645619224.git.ps@pks.im>
 <ca5e136cca495c7d927e99f5ae8a672d93823eea.1645619224.git.ps@pks.im>
 <ddb91a1d-6ddf-ba25-f1af-ba3f4c18726e@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sd60Utzb9Q+gqMUV"
Content-Disposition: inline
In-Reply-To: <ddb91a1d-6ddf-ba25-f1af-ba3f4c18726e@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sd60Utzb9Q+gqMUV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2022 at 09:13:53AM -0500, Derrick Stolee wrote:
> On 2/23/2022 7:35 AM, Patrick Steinhardt wrote:
>=20
> > The following benchmark is executed in a repository with a huge number
> > of references. It uses cached request from git-fetch(1) as input and
> > contains about 876,000 "want" lines:
> >=20
> >     Benchmark 1: git-upload-pack (HEAD~)
> >       Time (mean =C2=B1 =CF=83):      7.113 s =C2=B1  0.028 s    [User:=
 6.900 s, System: 0.662 s]
> >       Range (min =E2=80=A6 max):    7.072 s =E2=80=A6  7.168 s    10 ru=
ns
> >=20
> >     Benchmark 2: git-upload-pack (HEAD)
> >       Time (mean =C2=B1 =CF=83):      6.622 s =C2=B1  0.061 s    [User:=
 6.452 s, System: 0.650 s]
> >       Range (min =E2=80=A6 max):    6.535 s =E2=80=A6  6.727 s    10 ru=
ns
> >=20
> >     Summary
> >       'git-upload-pack (HEAD)' ran
> >         1.07 =C2=B1 0.01 times faster than 'git-upload-pack (HEAD~)'
>=20
> Nice!
>=20
> > -		o =3D parse_object(the_repository, &oid);
> > +		commit =3D lookup_commit_in_graph(the_repository, &oid);
> > +		if (commit)
> > +			o =3D &commit->object;
> > +		else
> > +			o =3D parse_object(the_repository, &oid);
> > +
>=20
> This is a neat trick. I see that we've also done this trick in
> revision.c:get_reference(). Perhaps it is worth creating a helper,
> maybe named parse_probably_commit()?

That might be a good idea, thanks. I'll have a look at what the end
result would look like.

Patrick

> >  		if (!o) {
> >  			packet_writer_error(writer,
> >  					    "upload-pack: not our ref %s",
> > @@ -1434,7 +1440,7 @@ static int parse_want_ref(struct packet_writer *w=
riter, const char *line,
> >  	if (skip_prefix(line, "want-ref ", &refname_nons)) {
> >  		struct object_id oid;
> >  		struct string_list_item *item;
> > -		struct object *o;
> > +		struct object *o =3D NULL;
> >  		struct strbuf refname =3D STRBUF_INIT;
> > =20
> >  		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
> > @@ -1448,7 +1454,15 @@ static int parse_want_ref(struct packet_writer *=
writer, const char *line,
> >  		item =3D string_list_append(wanted_refs, refname_nons);
> >  		item->util =3D oiddup(&oid);
> > =20
> > -		o =3D parse_object_or_die(&oid, refname_nons);
> > +		if (!starts_with(refname_nons, "refs/tags/")) {
> > +			struct commit *commit =3D lookup_commit_in_graph(the_repository, &o=
id);
> > +			if (commit)
> > +				o =3D &commit->object;
> > +		}
> > +
> > +		if (!o)
> > +			o =3D parse_object_or_die(&oid, refname_nons);
> > +
>=20
> Even here, we _could_ use a parse_probably_commit() helper
> inside the if (!starts_with(...)) block, even though we would
> still need the if (!o) check later.
>=20
> Thanks,
> -Stolee

--sd60Utzb9Q+gqMUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId3KUACgkQVbJhu7ck
PpQojw//QScXwkBJrN/ERAB75uI2wo42pV66P2s+ARJ8YT4uPRlJ5js3Fo1wC1oe
4XrYAyFWSI01SfLTxQGRl3wSX3o/54NKmQ32LPMVuwXaQJF6BQh5e7oUWrVBD+su
uTK+AypijvxqIphGYv6iItDtqmQ9Sci3LmjFkIVKCEgjR7PKEupiiLbXXia7ntrJ
DXWdmn2+AoYPEuoHa+j+IVBuo/N9eU9rFwYWO9eEkL+FvjZB0VykFT/AC5QI8Bxm
6fFW8/viKjCBiZMG35AFqndQviz1/awlkH5fnJV/UEtDL6Pp+R9E/DfYhimw0UEt
+zjjdd1Pdkdka5kvGCoTaxp7QRjy4i+p5OWrKJjDKeiKVqxYrU6tESyaC6cJx4e2
OGeFwb+Hei4YVvWni875t4fZyCfGSehL3+8jLyiNFbbKUAVkUPwlvSmiurEBUcmw
9JG3P2UEaTuz84fRyiHultKug3g2/niyhKMQOd5BurskVJHLKI/JvmGi40QBJK8b
5i/nMqMQN0owZzHY6dFDWMfFAIcb1+6eFu08uKexumPfJqu72X/gFkxhVjGqHb8A
z11MWRENMPu8l7XIr+WhogFEG6QcK9JMoaIk7IIGa8mvKJJBkX80CiS06ttKhOi+
cP94i/XugGXJPH5Tu/ii7GXNNKmcQ6xZIHqM3/dQa3+3207lb4Y=
=n1kD
-----END PGP SIGNATURE-----

--sd60Utzb9Q+gqMUV--
