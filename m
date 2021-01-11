Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB441C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 10:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A1522515
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 10:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbhAKK10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 05:27:26 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:33231 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729000AbhAKK10 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 05:27:26 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 46BB027FE;
        Mon, 11 Jan 2021 05:26:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 05:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nFZqK7nM4Yy/EJ4RuDaXdArZLYa
        PLPvcUMMiMPB3TH0=; b=eobsdy61Kyv+3hDPom0tzSMA1t3umGDWj10/whes+Tv
        B4Ki14yzVUf8EBFldQHXNXA7D2gg3eCpZooNi28/hbCXMW6A0VJqJv1ZDBxndDbo
        KoX37IB7pS/LzLrdIUBpdouowjOoIvragqIbci1xceE12lhMWSnTzGbNPZs+7plW
        LP2D+0XmpAr9Ni9qgclQjCIQasCtCQzfSnckI9CBfF2sVLXy5SHNDnSzwwMoXe4M
        IymcXuK19QsnIvSRbSEtvrFMsH+vL/0Gk/G0/GZL+GF9EldXxMKJllZNQvFCg1PB
        dvdoveNg2ih5+nUtp+EDE/w1jzhRhDwqBfJyAzk4W2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nFZqK7
        nM4Yy/EJ4RuDaXdArZLYaPLPvcUMMiMPB3TH0=; b=ke+WY8hpMtxUPcZUf+0Vp9
        o2Yecd9cIkaJQOkal7oHXJGtIbffkUzywYv8qnv0cqOeXXWJRNbJ/pT5LhmIK2m9
        ctJMZ758Knr5BcK7VW/8Ia8V7AIotqnVauqZ3cuX++G8cqRSShwzc7YJgzsy75Gx
        ArGSxAdJV+J2yp8ZU8QV3Y9EPmgsYPxdZ57+5tCjKxVdfisgY37lop1afcPWxCc5
        pCVsIr7fjVQeolO576ON4TroTUeh9dfDr28QjuBSkFlz+LVs6qofGFFQ5tvvVWQI
        My3pq3y6bZi6XtE5f5lcU0/L/m5hOEs6pzCF+x9EsbIQ4cE539kbfV/ZCLnUZlbw
        ==
X-ME-Sender: <xms:yyf8X3-INBkbTLPX-NcSnjrSXsU_ms_aE0Nj2UBzb_90kTdj_DbwZA>
    <xme:yyf8XztUCi2A-FHZJW0iOhW3k5-c32mgXXK4vt15-LdoprEsK9QPjgDB6x91ef9Ly
    eEjDxA13N5xJFTzbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yyf8X1A31zzIZ3RALd15bDsDRBwefiwzedy5h00dyQ9BzMsGSUZ3bg>
    <xmx:yyf8XzfZ9-XxUPSlv7otA2fZjOgdjkWyKryzO-0QNqJb3JOzilpM5Q>
    <xmx:yyf8X8OqpsQ-uxoDHmOcxQaoS7rzIRUaCv4lE26-320_goIznDUD2Q>
    <xmx:yyf8X2Xu9Vkg2F7OwprIp_9Z_KpzIxkuHzjAPL0f5ShiAfkosn32ag>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id D66C0108005B;
        Mon, 11 Jan 2021 05:26:18 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d3aeaaae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 10:26:14 +0000 (UTC)
Date:   Mon, 11 Jan 2021 11:26:13 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/4] fetch: extract writing to FETCH_HEAD
Message-ID: <X/wnxSn4KjQF0/T+@ncase>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610107599.git.ps@pks.im>
 <d80dbc5a9c9520621651541e418ee5216d164053.1610107599.git.ps@pks.im>
 <xmqqmtxjgfq6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FTPPftraJXbuTxCk"
Content-Disposition: inline
In-Reply-To: <xmqqmtxjgfq6.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FTPPftraJXbuTxCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 03:40:17PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +static void append_fetch_head(struct fetch_head *fetch_head, const cha=
r *old_oid,
>=20
> It is clear from the type these days but variable names like
> "old_oid" hint the readers that they are not a hexadecimal object
> name string but either an array of uchar[40] or a struct object_id;
> perhaps "old_oid_hex" would be less misleading.
>=20
> If the caller does have struct object_id, then it would be even
> better to take it as-is as a parameter and use oid_to_hex_r() on it in
> this function when it is given to fprintf().  [Nit #1]

Agreed.

[snip]
> > +	fprintf(fetch_head->fp, "%s\t%s\t%s",
> > +		old_oid, merge_status_marker, note);
> > +	for (i =3D 0; i < url_len; ++i)
> > +		if ('\n' =3D=3D url[i])
> > +			fputs("\\n", fetch_head->fp);
> > +		else
> > +			fputc(url[i], fetch_head->fp);
> > +	fputc('\n', fetch_head->fp);
> > +}
>=20
> OK.  This is the "case FETCH_HEAD_NOT_FOR_MERGE" and "case
> FETCH_HEAD_MERGE" parts in the original.
>=20
> As an abstraction, it may be better to make the caller pass a
> boolean "is this for merge?" and keep the knowledge of what exact
> string is used for merge_status_marker to this function, instead of
> letting the caller passing it as a parameter in the string form.
> After all, we never allow anything other than an empty string or a
> fixed "not-for-merge" string in that place in the file format.
> [Nit #2]

I think it's even nicer to just pass in `rm->fetch_head_status`
directly, which allows us to move below switch into `append_fetch_head`.

[snip]
> > +	fclose(fetch_head->fp);
> > +}
>=20
> > @@ -909,22 +959,19 @@ N_("It took %.2f seconds to check forced updates.=
 You can use\n"
> >  static int store_updated_refs(const char *raw_url, const char *remote_=
name,
> >  			      int connectivity_checked, struct ref *ref_map)
> >  {
> > -	FILE *fp;
> > +	struct fetch_head fetch_head;
>=20
> And that is why this variable is left uninitialised on stack and it
> is OK.  An alternative design would be to initialize fetch_head.fp
> to NULL, and return early with "if (!fetch_head->fp)" in the two
> functions that take fetch_head struct.  That way, we have less
> reliance on the global variable write_fetch_head.

I like your proposal more. I wasn't quite happy with leaving `fp`
uninitialized, and using it as a sentinel for whether to write something
or not feels natural to me.

[snip]
> > @@ -1016,16 +1063,10 @@ static int store_updated_refs(const char *raw_u=
rl, const char *remote_name,
> >  				merge_status_marker =3D "not-for-merge";
> >  				/* fall-through */
> >  			case FETCH_HEAD_MERGE:
> > -				fprintf(fp, "%s\t%s\t%s",
> > -					oid_to_hex(&rm->old_oid),
> > -					merge_status_marker,
> > -					note.buf);
> > -				for (i =3D 0; i < url_len; ++i)
> > -					if ('\n' =3D=3D url[i])
> > -						fputs("\\n", fp);
> > -					else
> > -						fputc(url[i], fp);
> > -				fputc('\n', fp);
> > +				append_fetch_head(&fetch_head,
> > +						  oid_to_hex(&rm->old_oid),
> > +						  merge_status_marker,
> > +						  note.buf, url, url_len);
>=20
> Here, we can lose merge_status_marker variable from this caller, and
> then this caller becomes:
>=20
> 		switch (rm->fetch_head_status) {
> 		case FETCH_HEAD_NOT_FOR_MERGE:
> 		case FETCH_HEAD_MERGE:
> 			append_fetch_head(&fetch_head, &rm->old_oid,
> 				rm->fetch_head_status =3D=3D FETCH_HEAD_MERGE,
>                                 note.buf, url, url_len);
>=20
> Note that I am passing "is this a ref to be merged?" boolean to keep
> the exact string of "not-for-merge" in the callee.

As said above, I'm just moving this complete switch into
`append_fetch_head` and pass `rm->fetch_head_status`.

Patrick

--FTPPftraJXbuTxCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8J8QACgkQVbJhu7ck
PpSNRg//a9FgMTkuf6J2hqNFBxlGiADe5s2LBNMbn3l8wAbdhygp0BbLQRH5jE0E
VmJaDyX8JoaplXezHgTZfkWwAeUtst1cTOVONRJ0mWoZzsJcIR93mXUrGnuiwLwR
D+fFFQYpzIYvXX/stZR+T9uq4JTOKxYn/A1QiRj11ieZy/WmtO8sOZLOUU2QAJy4
i9gLoy7Za1e2qIOnP2mz6FSc/7EylG1O4aRNK5d413U0L3qTzPP07LcAkdkywpoy
qNeAu+h6TSNitXvxpMNSX5sWkjST5VOeS6W3xtXlTm08Top66RVcyTnRmAdmlkeH
9VNe2zBpKLfzEV59s3CmjxB4mm1ZxuGyqb5kCvw/1gtRqkVVPn/S2A4/tYKTadnu
DmPxOYxUO+YoPvQWiR5Vg8+kl+UQ5AsEY+vd69emBl5e4zdOPGsjdBysZ4MX85QB
5gaTwlNuFqSL1c1HNfC+097PfiaKp/rxjabjXgZVH5gIvNynGxp8pYbvaz0BfYNK
lJIozFU2/HFGmK9WlYGLDwa47K3ihzSou2x8TwA6j8v96bLmYaBaaMq62P7apSex
fFX/CGna9OdHqhanzyOZ2sj0LfmqU4GqxaG6/Xug1iylnk62GVO0w+sZ2qcXfeFI
Kk7FWu20k6UsKdrWlR/kJYbF1yKmSpIpBHWPBi12uOHlckupZY8=
=Exyz
-----END PGP SIGNATURE-----

--FTPPftraJXbuTxCk--
