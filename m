Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEEAC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A6961432
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 13:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhF3N5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 09:57:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57471 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235534AbhF3Ny5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jun 2021 09:54:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F28F5C0110;
        Wed, 30 Jun 2021 09:52:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 30 Jun 2021 09:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=b/BoLA4gsnt3b1IoMc7ing6ja5k
        PqRNoyDDkV78C+IQ=; b=nWT3ZKN+xW/DNXQ1iXrFXEjY5tygGyjwCTGPNaEPQkF
        wDzvUJA9l8aWVitThPLU5GQARbnD3b7/oFQYM1WUioPdKBO3zSqt5HEIsW5FZk21
        WYbgrE1YB351cayB/EVPRZHdfzYKAFCBcdEso7W7eE74djbhNikdstX8onIafgGC
        /LdCfbWVJanAg8GqRbFx8ZpVWS9wRbCO/LDXyKqwo0zFFAekbt5LSyO8PK8GK+hg
        KhAcKRmCfyeSkvoSZcMNzsBFUzKsYTspqaO/Tw8WOoHhF5GzCWaMydVJ0YFXKOEh
        a+AxG9zubluYwFoiCRkcsvoKvrwQ2IDW0cQXhT0t9rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=b/BoLA
        4gsnt3b1IoMc7ing6ja5kPqRNoyDDkV78C+IQ=; b=fsip4pdFr4e0s6hChTCPDD
        6sSVYItg5oTqTQY2t/UkG4ShCzXf5Fp0V6g+pDtL0Cuyq0vI/QF+3SKm2MetXZur
        OMWiCJqHtxBZZXa99wnaKanoreZolkcbcAByBYQ3uLYNXwulmRwtRjS3HeTED+45
        zS20PYsMWemY6JHtv4KuNsiq54kykS4zh2bfiTMULAZ+QrDb7fEzgCee7MKaHTcE
        Eoarfk2qZw9e6ewsh0v84mBbJUGbd15yl3i/qPKTNNRYKuJaH7Xf4lntLo6UYWTR
        Z0NKSnfyF+k5o8LW21rD8Y1gbSgttLJPb7+GfH3QQrfgh27ihR3ee16WlTB/NKEQ
        ==
X-ME-Sender: <xms:G3fcYMaLbSa72sF2m5mWGedXdxlQXWTImUKZda6sOEGd3ktIRECAkQ>
    <xme:G3fcYHaDtp6Ap63WGI9E8-xIdurMTmLOhwwbxR543Lz6SoMtaDN2Q5WuhQMMDvddi
    RRYljaqIyMT3nO4wA>
X-ME-Received: <xmr:G3fcYG9V-gnrMUg8N8nWJ70w0h_YYtqt-y4W0ZV2Y4oiLA8alTWLxRKbH8WXxjx_u3Dp3qXeHIvfmjpbI2ye7JYC5cFYRNCLqUTfZ3ixsgHbH92mtvY2N7rJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeivddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:G3fcYGqGj3GK45f9bszPjD_-aKbMTeriFG5gkfVtweotYPfJ9EbG2A>
    <xmx:G3fcYHo7214KYk1LqNsC8tlIFGT3lKMQ3iEOe9FOk8VeFhXk2ZWH8w>
    <xmx:G3fcYESLJnyvjANzvDMBx9f5r_tBlihMwS1P1JFni9VH51hgsEarMQ>
    <xmx:HHfcYIBLdupOP3t6kQBEEX-pAy0Bd3ag0JPB4lrq4NQhP2k2cxKhGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jun 2021 09:52:26 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e1480471 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Jun 2021 13:52:21 +0000 (UTC)
Date:   Wed, 30 Jun 2021 15:52:13 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] receive-pack: skip connectivity checks on
 delete-only commands
Message-ID: <YNx3DYLLmRlGLjBU@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <b3272f499e51cfc53345f9f09f8762db1a4cf0a6.1624858240.git.ps@pks.im>
 <YNvJj42ALg4/t+0l@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vt2zYbGKnXU4vEXq"
Content-Disposition: inline
In-Reply-To: <YNvJj42ALg4/t+0l@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Vt2zYbGKnXU4vEXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2021 at 09:31:59PM -0400, Jeff King wrote:
> On Mon, Jun 28, 2021 at 07:33:11AM +0200, Patrick Steinhardt wrote:
>=20
> > Fix this by not doing a connectivity check in case there were no pushed
> > objects. Given that git-rev-walk(1) with only negative references will
> > not do any graph walk, no performance improvements are to be expected.
> > Conceptionally, it is still the right thing to do though.
>=20
> Even though it's not producing any exciting results, I agree this is
> still a reasonable thing to do.
>=20
> I'm actually surprised it didn't help in your many-ref cases, just
> because I think the traversal machinery is pretty eager to parse tags
> and commits which are fed as tips.
>=20
> If I run "git rev-list --not --all --stdin </dev/null" in linux.git, it
> takes about 35ms. But if I make a ton of refs, like:
>=20
>   git rev-list HEAD |
>   perl -lpe 's{.*}{update refs/foo/commit$. $&}' |
>   git update-ref --stdin
>   git pack-refs --all --prune
>=20
> then it takes about 2000ms (if you don't pack it's even worse, as you
> might expect).
>=20
> So how come we don't see that improvement in your "extrarefs" cases?
> Looking at patch 1, they also seem to make one ref for every commit.
>=20
> I think the answer may be below...
>=20
> > +	/*
> > +	 * If received commands only consist of deletions, then the client MU=
ST
> > +	 * NOT send a packfile because there cannot be any new objects in the
> > +	 * first place. As a result, we do not set up a quarantine environment
> > +	 * because we know no new objects will be received. And that in turn
> > +	 * means that we can skip connectivity checks here.
> > +	 */
> > +	if (tmp_objdir) {
>=20
> I think this will work, but we're now making assumptions about how
> tmp_objdir will be initialized by the rest of the code.
>=20
> Could we make a more direct check of: skip calling rev-list if we have
> no positive tips to feed? If we call iterate_receive_command() and it
> returns end-of-list on the first call, then we know there is nothing to
> feed (and as a bonus, this catches some more noop cases around shallow
> repos; see iterate_receive_command).
>=20
> But that made me think that check_connected() could be doing this
> itself. And indeed, it seems to already. At the top of that function is:
>=20
>           if (fn(cb_data, &oid)) {
>                   if (opt->err_fd)
>                           close(opt->err_fd);
>                   return err;
>           }
>=20
> So before we even spawn rev-list, if there's nothing to feed it, we'll
> return right away ("err" will be "0" at this point). And I think that
> has been there since the beginning of the function (it is even in the
> old versions in builtin/fetch.c before it was factored out).
>=20
> And that explains why you didn't see any performance improvement. We're
> already doing this optimization. :)
>=20
> -Peff

Hah, thanks for solving this riddle. I always kind of wondered what this
was supposed to do, where my assumption simply was "It's in case the
callback returns an error". But your explanation is obviously correct
and neatly explains what's going on. So yes, I'll drop this patch.

Patrick

--Vt2zYbGKnXU4vEXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDcdwwACgkQVbJhu7ck
PpSgAA/8DO15tkijulJmWs3QBjAh6Muq/QBy3ApkbFZ3iwI7sErLMY3K63Gvuo6D
gMrNhSACYvnC5kGhUGBRDP3UEG3Sbzcs3hTxI3ulaW6uik2SjZcyxwohr9DNB3lC
wg2fpfHamqfrJ0X/+a2N1PQtCCYT7HhsPeHdMXUEfqSttlkjPWFhWUeO+YWYLjnV
gI7l0ypm4EsBeS3If/zHGJA/pXoNUKvhPIFO1fC/R5ERqRQYY+/rT3Y7ePnoSht7
rswiDpE8Ax9+ekcM1j7SGR0YeI+GjreW39iyKcuQtPio21U4xYsDylIe1LZd+5sU
FByuLFbjalbiwSKCFjZSohlntVGlR9o+uEpDA8kjiCEvaJzaNMZW0E8HcBI0PPZ+
fhzpvKV8gRjLoYMge8oSWNc/u5Y/4cKZjVHLDFW49MLXC942XEFVU6kRzlXx9LBP
D3OgIL0zB6D3OCddDs1USeDqgUQMK1/7+40i7Jd5XmSSqw2yM8W80/DXgPHhoadT
jXnbjFagTGmBAN9MpcHf/Mjw5pNvxb90mXvxbmvECo71dp1cybczGZe3JlXhwf5O
J6M8EnrQH0OVwLUiUOfXBSogE0Bx/JyDKdSlPQu4jk9BgS+kcgy9YwVsugwcDXtl
zisw8koogl+BRzrAgDxEGMru9+maVFDlr42gOR2tBE14O6lmRGE=
=0WU8
-----END PGP SIGNATURE-----

--Vt2zYbGKnXU4vEXq--
