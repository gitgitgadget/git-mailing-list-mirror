Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98842ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 13:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiJaNK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJaNKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 09:10:25 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C05F57
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:10:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E0E883200976;
        Mon, 31 Oct 2022 09:10:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 31 Oct 2022 09:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667221821; x=1667308221; bh=f//lcxkU91
        jaRYY2B6zXrpSVPWNhkQvT1MOO/CuHLu4=; b=v2L+taAXWsEkzm8W+18l4Z/bCK
        bFq5r4t5ItJB/MWFHRcV4we2K0e9nCHiKqid2vxv6ekduhmuOOCW/wuoQTzD5tg9
        jbWTH+ckAGiAfG6TyGHETKu0NnAEChboWJpZvGJLhuSsQ2gInTxLo8Q87kdqkErX
        y6/2eOwBSFB3J0eM4XDcH+ChubANU3TFeB3hyhk0chO9pVZFtWkDIM0fYc8XOi9P
        r/MCmbI0/iszJejE/ibIL9CskBoxSAEY07v229WjdZk4DE3lM+KcjAipsskv9pc9
        uEBBoCHF1Di8nM4ZsNF8slmbQPySY0ejTi1+vXBXYdmOBqMAZsVifW75ssPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667221821; x=1667308221; bh=f//lcxkU91jaRYY2B6zXrpSVPWNh
        kQvT1MOO/CuHLu4=; b=Wj73K6K9X6x5r1DoNoepbWqWa7tft2QncZK+HGs6B3TV
        J/Y6ZWR4hrToeSu7Bkl2bKdFYXexbv6oCjgBpgGZZrXd3HeYCFWQ0lXb2WdA34s4
        05GSNGYf6nwZY5Yd14BuMY0JRI3WZYNybP4oCdUi+ygQUi9mL0zQM0Naucf35Gc7
        OM78Wzzmy8W9KN/pGsocQhL3u4I7v7bwtfpqZrXOdmaK9b/aV8bXvj49biPii86a
        iYwaGHcIyjtInkSEIKcx24Ip/eYDIbdmYvXiijM2ZcLIP210D8i2l+/2LReBoJxu
        QYuhOD0vpLrBUy+xbqnLD5saDHObjuobxUUWSpwJVA==
X-ME-Sender: <xms:PclfY4Q796uCSSB88Lb92MZNssmHpnWuGTGS48vudzwmSLWTwinT_w>
    <xme:PclfY1wLY_WYMj4Qh8uUJyYXisfWayHwoMKtdSjie318vcK8Z9SsaZkCxdnBBQ3Tl
    AB1Y3LG6LSCaXn0rQ>
X-ME-Received: <xmr:PclfY13WkK-Ralfwva8M7Ew2AZx-A7EQ_EvPP5jdLCd6iORhYffFfg_7J-IeNqVYbcdw-l1bAGhYcIGGNhQeTyta0SovQriUtva0nZwdAckLNJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:PclfY8A_4mmg6B8ZsnMPf4BNdsavJk10qWWxNRdtjR-o3wv7BtCcfA>
    <xmx:PclfYxhp39ubAFgnGpNkJ-me6jsHJwjCT3K1u1_G8mRAasVXNqptBA>
    <xmx:PclfY4rrkYlJ9PcGRuqkogsv6JrcwwmPDM0FZwnIepizn8h28p3XqA>
    <xmx:PclfYxKCjX3FAC7boxW7anBY6r4-IKeQXjDPqCbguyJYpcrFMQ-TGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Oct 2022 09:10:20 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 49f252ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 31 Oct 2022 13:10:05 +0000 (UTC)
Date:   Mon, 31 Oct 2022 14:10:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] connected: allow supplying different view of
 reachable objects
Message-ID: <Y1/JOGihHtMWv240@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <a32e3d6146dd41af36f525a744d6cc099b42d6fb.1666967670.git.ps@pks.im>
 <xmqqr0yrizqm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="61DDh/MT6dB6DHV6"
Content-Disposition: inline
In-Reply-To: <xmqqr0yrizqm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--61DDh/MT6dB6DHV6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 11:12:33AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > diff --git a/connected.c b/connected.c
> > index 74a20cb32e..2a4c4e0025 100644
> > --- a/connected.c
> > +++ b/connected.c
> > @@ -98,7 +98,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
> >  	strvec_push(&rev_list.args, "--stdin");
> >  	if (has_promisor_remote())
> >  		strvec_push(&rev_list.args, "--exclude-promisor-objects");
> > -	if (!opt->is_deepening_fetch) {
> > +	if (!opt->is_deepening_fetch && !opt->reachable_oids_fn) {
> >  		strvec_push(&rev_list.args, "--not");
> >  		strvec_push(&rev_list.args, "--all");
> >  	}
> > @@ -125,6 +125,13 @@ int check_connected(oid_iterate_fn fn, void *cb_da=
ta,
> > =20
> >  	rev_list_in =3D xfdopen(rev_list.in, "w");
> > =20
> > +	if (opt->reachable_oids_fn) {
> > +		const struct object_id *reachable_oid;
> > +		while ((reachable_oid =3D opt->reachable_oids_fn(opt->reachable_oids=
_data)) !=3D NULL)
> > +			if (fprintf(rev_list_in, "^%s\n", oid_to_hex(reachable_oid)) < 0)
> > +				break;
> > +	}
>=20
> It is good that these individual negative references are fed from
> the standard input, not on the command line, as they can be many.
>=20
> In the original code without the reachable_oids_fn, we refrain from
> excluding when the is_deepening_fetch bit is set, but here we do not
> pay attention to the bit at all.  Is that sensible, and if so why?

Hm, good point. On a deepening fetch the commits that were the previous
boundary will likely get replaced by new commits that are at a deeper
point in history, so they cannot be used as a well-defined boundary.
Instead, we do a complete graph-walk that doesn't stop at any previously
known commits at all. At least that's how I understand the code, the
explanation is likely a bit fuzzy.

I guess we should thus also pay attention to `is_deepening_fetch` here.
As this means that `is_deepening_fetch` and `reachable_oids_fn` are
mutually exclusive I'm inclined to go even further and `die()` if both
are set at the same time. We only adapt git-receive-pack(1) anyway, so
we should never run into this situation for now.

Patrick

--61DDh/MT6dB6DHV6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNfyTcACgkQVbJhu7ck
PpS7mA/+LsXUVtm01zmBpZTPd6FTUS1pPO7B6dO8riL8n/E6K4Ih9LkmorcmXQ5x
BoHAnxuiqr0gEfjGjT8O93gEvj9lnIKvq7oLtQFeO/NkqkdA2dERONgjTydUOxtA
YjM2emcV0LbUXgq6pVdoRiFJabCTPMzQHf9GlEmG1On2ll4xN1EAMCqwgE4zoW9h
LnnaW7D3fkgVPVd8SJt8UxUbj3f8r5zeOtqAhyCMosSNzMrcoP99SukZxGw2yv1p
eQ2F/SF2754zu3diLjk3ZbLGYjdaFVflJndpue2h8aRJArO1+L5qxzjQOHiceLmw
hJVRZiqWQ9ovPA/DSa6igd/MWewzFZpnlAW43GsHvK/L6XEYrov0G5NUqdE8m0oo
MEmq/8GX0CM6YvmXOSAu9TUfGQFKM2D8xKWimZumoAmTwch4uvdyW2jDNAHvD2Ep
hvQM+Nj9/ggL+7ha71iYGIS/A8GfeqFaOIM5xw8yq+i0Fm1TwmZeXfPR/53Fu1gX
5H8rVCKDRxulJEfRdBJpQC4URxbaSnHYOsXr55Ep5BjadNOW+CKx1S0Cz1RwmOgs
He//bg0xKvXCCC5Tj0Y3m45Z7DSmizFPyUbDpGU88b3IUa+JI0oSDMmdNpvESS3L
LOpcBZ1OrDHIxYOo6rTP9hm9N3QSlecC7ToNJWCs2lr/lWjO3EA=
=Gx5Y
-----END PGP SIGNATURE-----

--61DDh/MT6dB6DHV6--
