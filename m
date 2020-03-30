Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D4DC2D0E9
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 08:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB36920732
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 08:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HAZxgWPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cufJjRKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgC3ILo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:11:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33491 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgC3ILo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 04:11:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B345C5C0818;
        Mon, 30 Mar 2020 04:11:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 04:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qbSG9ZAZO0kL+EOjHvQqNZtHcdv
        /g+xMEYuD7TW+FOE=; b=HAZxgWPzSrwCP8mnhBC2Kh2YdwL4fBrdAHJmlrmN1yA
        Stfo6NhWd6HznQtpwU+6mIyay9Vu8BTuBYALFMociyfXjMK09A/H85fhGTMURYJd
        FEKfEC8zotI7+J4sf6s29esNOO8skJyPgZtE9bjjgX1e+Yk5rFkBc+tOMvXikVWa
        xtD4yYa8Vbx9o93RQqkfxAYLleysNQG2kC27HpSnJ7fwaLhcbH1rQbxxijrYm2WQ
        G6nwifW1TZmDmslTQqKtS9z9MkNxNzaxh+cM3WHpLqJ9ZdX6lfgq8tnirAfqjCG4
        vzDVeSfze2davDWFQ+wQeQuVfx0w3jYBfjYkXTX0BLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qbSG9Z
        AZO0kL+EOjHvQqNZtHcdv/g+xMEYuD7TW+FOE=; b=cufJjRKJ8bOhGjJuG6LQd6
        AJAN7ZdAJDuBekUXLVZaMWsT+NHArdAZDCNa5VGxmojZUfHTcNhvKkP1F6yJD9qH
        /8oJCKzRUJWJEiAe6r20ZZhmZcdcqlkJOB+nQULXQuVg3irqD7ICkUO6jK25AUoK
        ChBn/FNluFb6nR3zCq2/t5hExGZCvPzuUwLzL+7PQS9+BMb1CXXX4TttvzsU9JK3
        rMTElbkA2FjmKAKcBWFf5J64/SHdrwERWc0qqKJ244Hh8KUijJ9P5RgBps0Z3Lfb
        X3eEeGpgh0kbjfo94iQRyKxb3UmedBOpRFjOGTY4gxue5LeR5CQrxSXhZZBartQQ
        ==
X-ME-Sender: <xms:v6mBXjYdXxnwDiYuYsH-HTG77J9LVByr470D1ES3Qx8t-f9kKeF_1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:v6mBXtQPgnkS0IJZEiPzfO-k8YvlTtVugZX457l2KdEMlWAFurLSYg>
    <xmx:v6mBXgKBb9emctzbyCFZkyylYqlDFhwycxRDB9nZnoj9jPFYg7Awwg>
    <xmx:v6mBXrX3OGIeoUzMno9bI-H7UCauSzevwbKbt4EqJPA9eYpgYtaw5g>
    <xmx:v6mBXtFtOymqtCvoMTBzfGvQoMC0I0neRH-1_XMO9s2T4NB1nqoVJw>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id D105B306C97D;
        Mon, 30 Mar 2020 04:11:42 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d10be555 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 08:11:40 +0000 (UTC)
Date:   Mon, 30 Mar 2020 10:11:44 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 8/9] update-ref: read commands in a line-wise fashion
Message-ID: <20200330081144.GB186019@ncase.pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <1db63f97ec78fad794cec51c5d96b093f7cd2440.1585129843.git.ps@pks.im>
 <xmqqo8she9yp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <xmqqo8she9yp.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2020 at 02:58:38PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >  static const struct parse_cmd {
> >  	const char *prefix;
> > -	const char *(*fn)(struct ref_transaction *, const char *, const char =
*);
> > +	void (*fn)(struct ref_transaction *, const char *, const char *);
> > +	unsigned extra_lines;
>=20
> Define and explain the meaning of extra_lines in a comment.  Without
> it, the most natural way to infer what the variable means by readers
> would be that "update" command sometimes receives up to two more
> lines but it also is perfectly normal if there is no extra line.
>=20
> But I am not sure if that is what is going on.
>=20
> "update" _always_ needs exactly two more input "lines" when the
> input is NUL delimited, perhaps, and it is an _error_ if there are
> not these two lines, no?

That's extactly right. I pondered on a good name, but I wasn't yet able
to come up with any one that brings across its meaning. I originally had
`extra_args` but changed it after some internal discussion with Chris.

> The name of the field should make such details clear.
>=20
> >  } commands[] =3D {
> > -	{ "update", parse_cmd_update },
> > -	{ "create", parse_cmd_create },
> > -	{ "delete", parse_cmd_delete },
> > -	{ "verify", parse_cmd_verify },
> > -	{ "option", parse_cmd_option },
> > +	{ "update", parse_cmd_update, 2 },
> > +	{ "create", parse_cmd_create, 1 },
> > +	{ "delete", parse_cmd_delete, 1 },
> > +	{ "verify", parse_cmd_verify, 1 },
> > +	{ "option", parse_cmd_option, 0 },
> >  };
> > +		/* Read extra lines if NUL-terminated */
> > +		for (j =3D 0; line_termination =3D=3D '\0' && j < cmd->extra_lines; =
j++)
> > +			if (strbuf_appendwholeline(&input, stdin, line_termination))
> > +				break;
>=20
> And this code does not barf if you get a premature EOF and let the
> call to cmd->fn() go through, which sounds buggy.

This is in fact by design, but I only change the comment in a later
commit. The reasoning is that by passing even incomplete buffers to a
command, the command is going to be able to print a much better error
message than printing a generic one here.

I'll make sure to move over the comment.

Patrick

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Bqb4ACgkQVbJhu7ck
PpSYZQ//csakYLjPIAWnXsUHBdj6nD186Iz09jcA5Go5nqXuLenA7ozDuR0OI69b
ILxBu2vcw8md/3Lcni8JaxSRWe7v5/8RmiWMm4LFLC9gn6WtCI5i56tr1/vkV34F
hdGaB30WLCibGqC9Jx2HDEXlCDAtZgyerNxxzoA7hZLDQGo+hbCKEm5Mk6DZqAHy
xotz3aRonMUoghuxloQ7jbwOygoUsj5Pcd0xQW38fOYzXdbl7zzwfwjeQIazx2wP
w+J1wHvHgFTLr+3hkDIb82mgD6tiZPeyTh9ySy9qHPr3zItFfqZfcSuzDpc2mSCB
m1rOvwGyojBRInUV5xj9zSFJqseGJmG64R6J6YjboDQ5RCq8OVDQqaAg9PefFvAQ
iB+q3YrhwruYKpq9I09ccuyZ0aQ02lhuVyt3TDHPyRKUXbDJ2TbxacQMuzOU40T1
r5PqFqn9cjpGY8TC1UN5GStnnWrEz8NuJQ3kKspSWtFymPUwJ5+PaBnzSjaPgIjM
GIfsnvDex14H5nzp7IJpACg3YPSfwXyuCoznro4Iysf2LAVK6/+Z+R1V3IexGD58
dnkyp2O9KJnijG5hp5TLLuPlxbUhmjTGHlY+avIbQXZ3nzC/PfwHruO3ukMu1zkf
/r458kzbhFWpfbNlebEIon8yEEgdZDErKKbtgD+X/rOsqmIUKaM=
=Cy/O
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
