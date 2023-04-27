Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7F4C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 10:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbjD0K6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243680AbjD0K6q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 06:58:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D95155AD
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:58:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 90B4B5C0227;
        Thu, 27 Apr 2023 06:58:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 27 Apr 2023 06:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682593121; x=1682679521; bh=fk
        CO4uWnvKXGk2atA/Mlc4eHigGMaknVABNpJ1lGlEY=; b=Qsry6ofwUCTbk/WGY3
        Ayz8NkJoDzlKAqX68jVl+pKMgfchceewwXTaSJHecOuIXkLi+ZuRFykZYXe7VdCd
        2o9GthO6nFu8YUPldxmHC0jBwAkktmgfagi+Y4uotMkR5Dalzq9It0JSzZB4aLiD
        wF5E3BWqePyxItBanYJQyE4MJujVMau9bxOuS4GVmu1OjCEcxy1NXqiuNMqfzMrP
        qf8WCt1f6wr2Mig5wNxHmspmqRlNmAQjm+ol4nDP3R2GkUmorXbzQJSp8aHeINi/
        9hNnJ++NUoDHu6Mr+VuGX6gPdWogPhW3P8MVBlel0ves1zSpTsfWHhqTizjuJqvY
        GQKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682593121; x=1682679521; bh=fkCO4uWnvKXGk
        2atA/Mlc4eHigGMaknVABNpJ1lGlEY=; b=R8eOOjF2gDZM8J5Bpvz0GpgTCl/43
        zj6GT9sCLa6hhCV/wVfy41gfrIGRnK381N2Vl2iwmpkQcPkh6xdiFEPgUidkEAGC
        h1H0TkgjAUtkyBK6q2F13nXGQKmAHNR/pznCB9qu1yFN/qYjb52Byx3sHLNDMQp5
        uYzilj6nFX1/nCjtiK3jadA2TGS53+twF72BrJfAVJEXRZRXkIAOAPeGeBcyuBTD
        O5lB5yt669HCCJ24JI3TGA/9K2sTmntv0iwTqC2EnLeF6QYA9NWNBATEC9r/Igyx
        E3nnyQ/1XsT/ydnmAJSR4MX5ugrfA+//7aSJYH1CSmFSEdkopsWjIf1Ig==
X-ME-Sender: <xms:YVVKZMuF3RaJ8XCAbk45yr98Gom-vSqfC3OEw19RWlbEY7HBDKAoXQ>
    <xme:YVVKZJd1oGupN_zqJSajyFx_v4lU4ajqPEJQR85oqjeYmFNIFmGTNO-5VmW4T0S8R
    slUenbukbi3Wc3Y9g>
X-ME-Received: <xmr:YVVKZHwTjE38qavUFRfbEnhtLv36wsa4cjWQ3PslZJ-vykGRq4RiAr1FUwb2vy_Fiuq9v4pTlxY6nXBgI89oRcfFbrj1n_cQ2T3c3vG6mvRH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YVVKZPMfWaFLq57AAdmcKPJ1T-z2QCWrnppgR-3BO5KTaRU3TCqB1Q>
    <xmx:YVVKZM-w7i_78w05OxC5WtlDzfshcjDR9dFx0I_koRUFvCDl6IHIrw>
    <xmx:YVVKZHXeNd2zckvxQ32TsvkPBdLfyQPSnZhqsn8Q5F2wtXtO9S0wGA>
    <xmx:YVVKZKkWy8337iPu8nBF9CM01g35aLTxgZoYT2GIU80_Kh-d4dKK9g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 06:58:40 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 1b579598 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 10:58:11 +0000 (UTC)
Date:   Thu, 27 Apr 2023 12:58:38 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/8] fetch: fix missing from-reference when fetching
 HEAD:foo
Message-ID: <ZEpVXmzf3h5w99nZ@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <596e12f03a296d753ee6fe8face9522edc9e397e.1681906948.git.ps@pks.im>
 <36931566-1258-c5de-2efb-63541a2ce96c@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YYMFdi9BDYN5HhOL"
Content-Disposition: inline
In-Reply-To: <36931566-1258-c5de-2efb-63541a2ce96c@intel.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YYMFdi9BDYN5HhOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 12:21:40PM -0700, Jacob Keller wrote:
>=20
>=20
> On 4/19/2023 5:31 AM, Patrick Steinhardt wrote:
> > =20
> > +test_expect_success 'fetch output with HEAD and --dry-run' '
> > +	test_when_finished "rm -rf head" &&
> > +	git clone . head &&
> > +
> > +	git -C head fetch --dry-run origin HEAD >actual 2>&1 &&
> > +	cat >expect <<-EOF &&
> > +	From $(test-tool path-utils real_path .)/.
> > +	 * branch            HEAD       -> FETCH_HEAD
> > +	EOF
> > +	test_cmp expect actual &&
> > +
> > +	git -C head fetch --dry-run origin HEAD:foo >actual 2>&1 &&
> > +	cat >expect <<-EOF &&
> > +	From $(test-tool path-utils real_path .)/.
> > +	 * [new ref]         HEAD       -> foo
> > +	EOF
> > +	test_cmp expect actual
> > +'
> > +
>=20
> The test mentions HEAD and --dry-run, but the bug seems to exist
> regardless of whether --dry-run is used. I understand the use of
> --dry-run for testing fetch output so that you can repeatably run git
> fetch and get the same results.
>=20
> The tests here should probably also have a test that covers fetch
> without --dry-run though.

Makes sense, will amend!

Patrick

--YYMFdi9BDYN5HhOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKVV0ACgkQVbJhu7ck
PpQ3kw/9GqRo0f+RqgYmJvqRpSR9PpwF6DqnJQXK3n+E1M6MTGd2VfPE1MDMsi/l
nlCrqfzZuUke9baF4d8QQjI7uydM1ypOJ0vMrG1V4z+syfnsgLpKdUjNjDftSgG6
GWgGcA46YVhUhQVK38hgLqK026N8Ughyw1/pqaAXK/wpWA1S9IzMUpPz8sqBJ10k
GSyFB/dkVU2b5tBNAC0YlIaGvznATXd5BxzhSN5hYDD1hSn/MwlV6SQAFnkU7PLM
p4iyHsk1+kJEDTEeRsiBlJlDH7uOic0hNHqBDLxN3k4gEhP57JNcZ3WMWNFW2IA8
waA/UJ7WXyVupw+PmUWCVEXGJz0ujfaXTWLwWhDNHgfFNEBj6vhljl7vedFwzvNl
ZFmCT7yEyOaCBndW3+03KHy1tln7r8cimF4u2VSuHaREd3GtL5qIlI9eovJ917Ec
3KL7WclZVQCVJF0Uq8yCVrZg3DWSrTUTlsAu85eCpugDINo5b+Vic0Xwpo56v/SO
x7KzNaw3qP9DESj50+K+J0t7aYKklsWqT2h0R9GIoJQK9xe4XNe0Ws9RelEV17NC
92deVaL75DYnNUs4LrAPEVDMQG+Bm1C/5Zxfyw/Lsj8ozuJYIbiCCptsiptQ2xLL
2JiYo2Tp/XDlem8lmg8SP/Ak7KqgxQA054SzgNmn8Cov3OXH6BY=
=M4xn
-----END PGP SIGNATURE-----

--YYMFdi9BDYN5HhOL--
