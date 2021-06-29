Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD7DC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF7C61DC4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhF2G2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 02:28:39 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:52269 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231958AbhF2G2g (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jun 2021 02:28:36 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id A1162320031A;
        Tue, 29 Jun 2021 02:26:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 29 Jun 2021 02:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=NqJsZlTgpO653omzvJ1RX+Eav5G
        qRYsjYXj7NDggjvQ=; b=bFHn2vaOfe8inNMq/WR2e9hAMjT6NaxkcWO2sdel36v
        aRcOE4uXEAvwLC8iiQN6//ois6+IN4EyCqczsPA4maTAk43PmnkKGATec+KDNIG4
        c4pn93eMT/Qb/T4udXIt+0JTdNp+hZ20lKrcVlnvK55fr3TMqpRd1FORBr6l10EJ
        08qum+M4fu1bI+/hURHx68TcRQBwY40V4aM2nF039+h/Ir9r3tWlndfe4qOHCYtk
        SC16FUKIsr8B9h8DwoIGJXVqUtE2xVnlty4ViktJqif7H57ifq1go/0JUXobmZPI
        Hai0h8B6Dye5gR0ilBXNGVZgOS9yuMiUHco0cLc11eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NqJsZl
        TgpO653omzvJ1RX+Eav5GqRYsjYXj7NDggjvQ=; b=s5NksI/JZvOwW7/hQJYGEm
        9jh0O0w4tA/9cU/ozNaLDdTivs+fqW6YC5a9v+pALeInTqYvAFpMrtOb3m40PCBI
        o+8IRZJw0N9CbMbIc756Wx/Dv/6DBW2kbdmQ3huHDunw0LR33BUmU/OqpMfb3YRX
        X2TTcZgik4bCIESznv2OumegDKhNiCxrDw832NeENRxahgLRvZ8s21RxyGRKlCtE
        rVkyvbDVWHs1vet4FQ5ilm21fxGmdtpBZ8Qqvj9YoHAy2aTho5UNqCbkwK3ilYQ/
        oyldh/LNbk7XbhDK0CU3cy9AgifOlzmrLcJWC00z0XEpOLLoYdL5BUHFauR5rdQA
        ==
X-ME-Sender: <xms:AL3aYMJ_uNX1oOWJkkPmVqv_eg_bjGIrktjFR6b1IXq9TDKCI7_hmw>
    <xme:AL3aYMLNJA35bamlXMoM0NpS6HTJyZVMIoatneIWxW-1gdDgmfugewnKZidrXHC7N
    nxED_GhqFwuaj8mfg>
X-ME-Received: <xmr:AL3aYMs_wIuV6ZAU54vlhboC7L_vTA8n5kI6x5nRIBxhINc2D8cTucSVeDdKiYDv7hQx3yqvu27ZphD0nvMQKUjJpb5JrsXaZLjyDMFoMt-lnp-xi-0sew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehhedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdffjeeiudduleehvdfgteeifeelheejtedvteduiedttedvtdffffefhfdvgffg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:AL3aYJb3Mlg3Ni5aZ_-vLVyBx7d_glZa19buKHjp_9Kz1DAyYUl9Ew>
    <xmx:AL3aYDbzr-ZKT8IXoL35kJsXrk7th_7tljLiZ-bfoUHFUtFPdbLLyQ>
    <xmx:AL3aYFCuG9gxhNYl4necBjmIfG9UICsOxMnlrnjNmmKcZd0crtjmyA>
    <xmx:Ab3aYOy0Uj32Rjg9LQY2YplvEQTiAfW_uxIFP7NK-ugpplLXO57AbQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jun 2021 02:26:07 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6af6bedf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 29 Jun 2021 06:26:01 +0000 (UTC)
Date:   Tue, 29 Jun 2021 08:26:00 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] receive-pack: skip connectivity checks on
 delete-only commands
Message-ID: <YNq8+Jlsu1UfDKav@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <b3272f499e51cfc53345f9f09f8762db1a4cf0a6.1624858240.git.ps@pks.im>
 <87y2auwh1d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WFa6mwadoNVUOXR/"
Content-Disposition: inline
In-Reply-To: <87y2auwh1d.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WFa6mwadoNVUOXR/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 28, 2021 at 10:00:26AM +0200, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Mon, Jun 28 2021, Patrick Steinhardt wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > In the case where git-receive-pack(1) receives only commands which
> > delete references, then per technical specification the client MUST NOT
> > send a packfile. As a result, we know that no new objects have been
> > received, which makes it a moot point to check whether all received
> > objects are fully connected.
>=20
> Is it just per specification, or do we also have assertions/tests for
> what happens in that case?

I'm not sure whether we have any tests for this, but I've seen several
hangs already in case the server did expect a packfile or errors in case
the client sent one. In any case, the technical specification in
Documentation/technical/pack-protocol.txt is quite clear on this:

    The packfile MUST NOT be sent if the only command used is 'delete'.

> > [...]
> > The following tests were executed on linux.git and back up above
> > expectation:
> >
> > Test                                                  origin/master    =
       HEAD
> > -----------------------------------------------------------------------=
----------------------------------
> > 5400.4: empty receive-pack updated:new                178.36(428.22+164=
=2E36)   177.62(421.33+164.48) -0.4%
> > 5400.7: clone receive-pack updated:new                0.10(0.08+0.02)  =
       0.10(0.08+0.02) +0.0%
> > 5400.9: clone receive-pack updated:main               0.10(0.08+0.02)  =
       0.11(0.08+0.02) +10.0%
> > 5400.11: clone receive-pack main~10:main              0.15(0.11+0.04)  =
       0.15(0.10+0.05) +0.0%
> > 5400.13: clone receive-pack :main                     0.01(0.00+0.01)  =
       0.01(0.01+0.00) +0.0%
> > 5400.16: clone_bitmap receive-pack updated:new        0.10(0.07+0.02)  =
       0.09(0.06+0.02) -10.0%
> > 5400.18: clone_bitmap receive-pack updated:main       0.10(0.07+0.02)  =
       0.10(0.08+0.02) +0.0%
> > 5400.20: clone_bitmap receive-pack main~10:main       0.15(0.11+0.03)  =
       0.15(0.12+0.03) +0.0%
> > 5400.22: clone_bitmap receive-pack :main              0.02(0.01+0.01)  =
       0.01(0.00+0.00) -50.0%
> > 5400.25: extrarefs receive-pack updated:new           32.34(20.72+11.86=
)      32.56(20.82+11.95) +0.7%
> > 5400.27: extrarefs receive-pack updated:main          32.42(21.02+11.61=
)      32.52(20.64+12.10) +0.3%
> > 5400.29: extrarefs receive-pack main~10:main          32.53(20.74+12.01=
)      32.39(20.63+11.97) -0.4%
> > 5400.31: extrarefs receive-pack :main                 7.13(3.53+3.59)  =
       7.15(3.80+3.34) +0.3%
> > 5400.34: extrarefs_bitmap receive-pack updated:new    32.55(20.72+12.04=
)      32.65(20.68+12.18) +0.3%
> > 5400.36: extrarefs_bitmap receive-pack updated:main   32.50(20.90+11.86=
)      32.67(20.93+11.94) +0.5%
> > 5400.38: extrarefs_bitmap receive-pack main~10:main   32.43(20.88+11.75=
)      32.35(20.68+11.89) -0.2%
> > 5400.40: extrarefs_bitmap receive-pack :main          7.21(3.58+3.63)  =
       7.18(3.61+3.57) -0.4%
>=20
> We're doing less work so I'd expect to te be faster, but do these tests
> really back that up? From eyeballing these I can't find a line where the
> confidence intervals don't overlap, e.g. the +10% regresison is a
> .10->.11 "regression" with a [+-] 0.02 (so within the error bars) etc,
> ditto for the -50% improvement.
>=20
> Perhaps the error bars will reduce with a high GIT_PERF_REPEAT_COUNT, or
> the re-arrangement for keeping things hotter in cache that I suggested
> in 1/3.

As I've layed out in the commit message, all we save now is spawning
git-rev-list(1). The command list iterator which is used to feed data
into git-rev-list(1) wouldn't provide any references given that it
skips over all queued updates whose new OID is the null OID. So
git-rev-list(1) doesn't receive any input except `--not --all` and thus
can exit without doing a graph walk.

Above numbers simply show that this saving is not significant and gets
lost in the noise, at least on Linux. Windows may show slightly
different numbers given that spawning of processes is slower there, but
I don't expect it to matter much there, either.

Patrick

--WFa6mwadoNVUOXR/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDavPcACgkQVbJhu7ck
PpQfzg/9Fpp/VtVCZatU+LNo2Kj+dPMeE/QcrNu4mGkxK6BjxZgYNh8lNcRwQm6T
aNsXbcZJDcXcESixxA4QxpDWNjOYaJ5VqRucnGZ7X1huOiqSY2esFhdWY3J6sOsU
xh4SHD3P7KV5jVfvS9iMZuGH4EmvTDvO2JI3okDfwv37lgvB/4SM7nT9nzANcd5I
hQsqcqq4ODwMPXJHbdj61yHMpwErU9WC5idvkPesVNZwFvzA6Ck6T/doZbO7rcyi
HeOK4AHCL//UNlN06JUrfGaaxKPFrJj2+mmwteDuPy2GnYxEdxxrv+r3/a2Y9ZoH
yRK+vayud/nN+jTaKxUC/9DeH0icHOY7XL20ekg6ZYxImFfUv2AkfwoovRL06olS
p8vQrkwvcTDujE3u47QKCE3lXchRE/noABraxiC+wCb+VonZ1CYPFbTIqOo9Kido
9eZgv4KDYwB5Evn+4Cm0X4EQak3pC6UXLMVvCvXOgZctoqxn8gtafuSBhCjhcof2
6ExQFKA4XoCr7JpX/MarA3IW3GKkIt1WkCD5fGNJ/MMM6PCeB3jko6gtnVZR1qoD
RyWpkGj9pRX++s0/rrLljuY3VCRlTbqjPqJJzFqr/4B0Hx2V77X3lVBMjeFqmxCm
XKXTr62VW+fBi2+BZ3NS/+fcgAtSmmGmZMTOtDlR8PVdcxyo1lM=
=ggaI
-----END PGP SIGNATURE-----

--WFa6mwadoNVUOXR/--
