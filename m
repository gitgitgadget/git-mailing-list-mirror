Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC7C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjDFIHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjDFIHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:07:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EDA93
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:07:20 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5A5AA32009FD;
        Thu,  6 Apr 2023 04:07:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 06 Apr 2023 04:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680768438; x=1680854838; bh=fc
        v/Zh0KSUAPZgLeQDzh++pvHg530IXCb0uK+qWiGb4=; b=MUHS526Ay9HrwPJz1p
        0tF4GRNR/2Rqwio+FaL7v+u37b3cHMY2HtfO/JSl/DhVjc8ZA1ONEzzfDzvJeSIq
        KqvoH6yFefZsRJVm/xvtKrQiw8mr/Nqbw5Q4weJW781fo4xofXIl/Y1P5/J6w/hH
        8/nrpbeEIS3pr3+gIKYc9PsBUdJzHH37q/aj/VzfNRbzmL8kfP42SKRdU5innCyf
        OwDVvEfJUTAevzM/U7m80S6MgRCEw/p0Kwqz70JKssavTIIrwi1eZ8cdRfaBGlKD
        1ayzI4jVW+Z81tjztEnvLEuOBxMOaJqTiqNFEDS1ETxguPiWWCXmUJ1xIoljCGxb
        fnQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680768438; x=1680854838; bh=fcv/Zh0KSUAPZ
        gLeQDzh++pvHg530IXCb0uK+qWiGb4=; b=EVsnjovtlXrQR5gXgs8fHr5/0+4zE
        UqjMbFwAuu37y5luBY2iGUz0Tn+/wpuw2cfCuRDXiuQqS1cs19LKNX4wnCcdOkUd
        Zq11OOZDq9RpIHp3VzZ1T+Bm5ZAorWHdVFetbWWRvm3M/ZNnEQxPCY4PPXBd4mqb
        Vbk7duSxjmvEl4QkUtEGZcidj03CoNl7ENY7k4pZrWtqf0pxBWS9e+n6VW2kRQgJ
        GP0sME6DJxWlQnEtrT87lF9DlMdF60uVF6g351gz9t1BMT/8WGE/+Bwlb8Hq6qsq
        U94jbmf9nEKW9jHrvEcMgPOYoeTE1xtpgC/N9h22PBczUJI1cPzKIZeXg==
X-ME-Sender: <xms:tn0uZPtFQqOHmlpHCwuz7XZNxb5W3CuH1lP8R1sGLcghLP4MGrm76w>
    <xme:tn0uZAdqcYMHZKzWYgulbCdihmu4qu5iRQHXPnk-6E5WdLutSrDdfF9W2Q9goPFeu
    dUZLBN73O0Ekae32Q>
X-ME-Received: <xmr:tn0uZCzHYKTW-1IIhID1gaRTNWStrV3vhSfMTRHnNy3OEvK90QyvF3Db-WfNyILPObfTaSlLvt5-JqeQTVAeMpoIDD031OEovODtyChBsdJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejvddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:tn0uZOPBmfk54J9WVDRtoyvPN5bKfemPjb68sM5-pMMGHdkZvCvnrA>
    <xmx:tn0uZP9DMT6WJ9DTsM6VTxnuWsYmHU9vcsVD4LrVl3pWrcRHUOirlg>
    <xmx:tn0uZOWpCxCc3h6f_9YpyTcxurCnmy0utUgYOaAOF2FcKo8m317LxQ>
    <xmx:tn0uZJkGZMreRRmXRfYLkrywX04ybk3LtNbR6JcATnDKo6z6LvJfNA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 04:07:17 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id df81b206 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 6 Apr 2023 08:07:07 +0000 (UTC)
Date:   Thu, 6 Apr 2023 10:07:13 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <ZC59sbedolRAWF9k@ncase>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com>
 <ZC2LOAwycdaUawxM@ncase>
 <20230405165414.GA497301@coredump.intra.peff.net>
 <ZC2wppC62E7wOcqM@xps>
 <20230405181505.GA517608@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t7adxH+oek4DTVbQ"
Content-Disposition: inline
In-Reply-To: <20230405181505.GA517608@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t7adxH+oek4DTVbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 02:15:05PM -0400, Jeff King wrote:
> On Wed, Apr 05, 2023 at 07:32:22PM +0200, Patrick Steinhardt wrote:
>=20
> > Yeah, agreed, the scripts we install are fine from all I can tell. I
> > should've clarified, but what I care about is our build infra as well as
> > our test scripts. That's neither clear from the commit description nor
> > from the changes that I'm doing.
>=20
> Ah, OK, that makes more sense.
>=20
> > I'd be happy to keep the current state of installed scripts as-is and
> > resend another iteration of this patch that only addresses shebangs used
> > in internal scripts.
>=20
> We generally try to use $PERL_PATH even for building and testing by
> invoking "$PERL_PATH script.pl", and declaring a perl() wrapper within
> the test scripts. But I would not be surprised if there are cases where
> we fail to (and nobody noticed because it usually just works to find one
> at /usr/bin/perl).
>=20
> IMHO we should aim for fixing those inconsistencies, and then letting
> people set PERL_PATH as appropriate (even to something that will find it
> via $PATH if they want to).
>=20
> -Peff

Makes sense to me, I'll send a v2 that goes into this direction. Thanks
all for your input!

Patrick

--t7adxH+oek4DTVbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQufbAACgkQVbJhu7ck
PpS9SxAAhRkagxdqdoKJtsCY4clS/h3g4WU38Gw89kGhMxv/TVCXFcDLrliPsY0X
2ujf5WkqHKKGXodr3rwqExuhOLrFFkf9iMd0ff8CcYGdW7+SBmxyBHuTQ6TAXIFt
Lt7N7r0yWteArRncejrkRzDQ7q9koERWKb+7i2lx49uNs8O1CR0Jp7Uaq6vL1nlT
UG2oTRzDOeGQEYSpmP2VHgcaAHs8+O/TkoFamyZ0Ub6wN7FVv1WUtUzPe+Mdnxet
uniNNVPv79K44bSYdt0XMJHlf1LBZutUafGaVfM3Pz30v0szpaDUM7NMnPkTznJS
/L/6oia+PTZxZTriPoyfO6QP5ZQ2rw6AuoQAIPu3sqQemnnqY0n7RMHIKWcbE2zZ
h9NbMoDC8LEj6LuegxRcmHarPHJT7810/+pT0k6ibly0U2Tpulq6RAb/kPDFps7N
6/u4VviyaLNJrSqAygrbcI+3n8lxVVOTvzEHq9RftBnFep0F/E9xc8oHnBlqHhva
Ek/MujULEQumRMDHCeMkIt4tJmQaTpMl/mt9Qo5JVdnXyQpKuZwTGW2zWSkWiyqm
xf5oFX8+i6skQcYwaLipNadIA6KghHlp3YgA7ou7BvBA3gznPGqqis8uPB16cs/g
1f1ldPdKXameAkP+8hk/Jz0ZOHXIZu9Mdv9ra8Xx3RSV+h4uKEI=
=NPQb
-----END PGP SIGNATURE-----

--t7adxH+oek4DTVbQ--
