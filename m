Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32376C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbjEJMfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbjEJMet (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6457AB9
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A1F7E3200915;
        Wed, 10 May 2023 08:34:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 May 2023 08:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722087; x=1683808487; bh=jy
        cccpQOMPD6j7hakqW6b+1765pkk9WgWoHSGrPucKA=; b=f7VZiyQX01SW71zy+g
        vbaHswaQIgcEavFdBD8k+65vB66Cyw12GsQh31mIrUV3wTdxvwssoiB67Xb1pH4a
        ohzN24lGJOHn5kxHM/7j/rqGDNQr0UpG38d7EDSwnAiTAlvT02pKpnHQwobuHVHV
        HQq1tkS9jakbngnNjt7c7TJCwYRPGM6NXDx7ACGro1aWQhEql8G7rNNDZnj7q1gt
        YoUp8DytC9NnfRmcCJ+vZ/pkgfp6WLHOynZu1CgNJefcNt6JjpheqBq0p+3us38+
        0/wIvc3qzuwTwZtScBSeDv4UKjCK8x4UD2eblpRTd76zyAkcvhWuJKossFNk4Wbj
        vtMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722087; x=1683808487; bh=jycccpQOMPD6j
        7hakqW6b+1765pkk9WgWoHSGrPucKA=; b=aE8QbDdskYdXhkPR6vCK7U6vJJRYV
        /nho4214UJEeF5d0XYt+gtBrnDEmKDVdYoltTBOHsu8biHcCyqLmp7IBz0q00LbH
        Gb04UtQldUQin9EyBLFmtEefuBmwpkG8DVFGf9iW4s0Pz/F/5AMGqseYEVWF4UKp
        GiV1i/7nXk97TmZAJSIFOXQzBDV5bc78eleMUBPDQWyuLP78y/yZZ6t3FIraIXkM
        KWwIrgHF7PDB45o/GqciREYhYRk7jyM2nYyv0RQeBsArXhdmrquAMvPaSIgnCrbt
        /Ab2Q12Ym3TwFTdUBQyKRxOT6L6rcV+/TacwQKfikGlWtqLfcqqqxf4QQ==
X-ME-Sender: <xms:Z49bZNMuJE45FqcZ9NDxj1Xd4yIojPyqBuNrU0oaMtZag8CrsH88LQ>
    <xme:Z49bZP-d8zPWe808rv1AQVidBQOzrlO6TmpeyivxDW0cGB0CD0YLLSnqkN5g3e6WN
    ilx_2r4JQWp5gAjuQ>
X-ME-Received: <xmr:Z49bZMS3Ib91TAuHHkXQ-udxp967JnYS2C-13AjxNYbBJCKdDLlpN_L5HlCOJKvs_hG-yZSU1tsHeI_gzWdXp-tZJ1_rcWpQ7rTjeR2jevfR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Z49bZJvCCFJkGGg2OCW1io4FURK1wL50Kx3Is1w9xkZkICQtAAp22A>
    <xmx:Z49bZFfiudnPPHHSSr0TGmE-5w_W2mKx3wNOgy8Iqhu3mT8khj9IGA>
    <xmx:Z49bZF0lmlCbzYgdJSnY_56lJulhX63erd0YFexrHLiFky5Lmn54yQ>
    <xmx:Z49bZM7bpeVFwELCqUh3TEVH_QTAA2ZuPPHT2oLXHOigx_D406DQBg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:45 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id bb114e6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:36 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:44 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 1/8] fetch: fix `--no-recurse-submodules` with
 multi-remote fetches
Message-ID: <ZFuPZMK-xtygmZ7J@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
 <d82b42ed345ac7b482bf5dd96456f131ecb8c746.1683636885.git.ps@pks.im>
 <xmqq1qjpz96s.fsf@gitster.g>
 <kl6l5y911ht4.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HQ0p01HmA0Yi1nww"
Content-Disposition: inline
In-Reply-To: <kl6l5y911ht4.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HQ0p01HmA0Yi1nww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 11:27:35AM -0700, Glen Choo wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> >> +		git config fetch.parallel 0 &&
> >
> > Is this necessary for the purpose of the test, though?  It should
> > not hurt, but we do not require the end-users to set it in real life
> > for the parallel fetching to work, either, right?
>=20
> IIUC it would make the test output deterministic if we fetched from both
> remotes. That doesn't happen here though, so I guess it's not doing
> anything right now.

Right, will drop.

> >> +		git fetch --all --no-recurse-submodules 2>../actual
> >> +	) &&
> >> +
> >> +	cat >expect <<-EOF &&
> >> +	From ../src
> >> +	 * [new branch]      master     -> secondary/master
> >> +	EOF
> >> +	test_cmp expect actual
> >> +'
> >
> > In the context of a series that attempts to introduce a new stable
> > output format for machine consumption, which implies the traditional
> > output can change to match human users' preference, this test feels
> > a bit brittle, but let's wait until the end of the series to judge
> > that.
>=20
> I also find it a bit brittle to assert on the whole output when this
> test is about checking that we do not fetch the superproject.
>=20
> Is there a reason you didn't go with the "grep for submodule lines"
> approach in the previous tests? If it's about catching regressions, IMO
> your PATCH 2/8 does a good enough job of doing that.
>=20
> Wondering out loud, I wonder if it makes sense for us to make a bigger
> distinction between "tests whose purpose is to guard against unexpected
> changes in output" (i.e. snapshot tests) vs "tests that happen to use
> output as a way to assert behavior" (i.e. 'regular' behavioral tests).
> Many GUI app codebases have such a distinction and have different best
> practices around them.

Fair enough, will switch to `! grep "Fetching submodule"`.

Patrick

--HQ0p01HmA0Yi1nww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj2MACgkQVbJhu7ck
PpTuHhAAnV08aLs11z4oo1/53VQRPELLpi/r7SL1N1gQfxN492HDNZx1WK4jh9qM
6+Yxus9LuaRIy9QUYnHCwWFJLi/xSzlhwLda8PEru/QPqplNAEx9UIYq4TI/g0wC
Acvt3MkClDsWHjPndiGAXFhgExbgYeEWQkVF3AhTQhIvvr4eJSI3Ddd4ATrbSSAe
rKsyH2fUWUNc+u2wykzncwuDzkl0tPbiwO8IzPg5bcML5GKat9sCAfR6pPMhF6/2
+ZMS2w+fk2NJ6xjFh3R13m4Vf9YfB0APAMMRz0Jxvc8XGFl1DbP/IMySPONNzUy6
WaDLs+HqtVPc3DUCBNgq5IlpQRIiBme/tgb97z/0pRaEBtnW35YlXuad2FbfcMNu
b6NJB4Tvj0kW3id9kxS9YyfCuWTndVhhlVClhJe714kboxob2W1wULGaSR6sOYDK
yY07DIp3Mm73n3aeD2xG/bgH785LynGAZ080mI/+Hm1GOwcV05yb5KyQFiD3LPdy
W6UOTGPmTXdWJTzuWVOXT0s3qr1dVhh1u0wJLUqM6xMcMlKFK5tS41gUsIsXyHpG
tbqvTH4DLuKvEtwGspFJ47iEGYzd0XgIus3q3Fe+f5/zzuMfO1uhiXYIDNJdTCQb
jwbQKn7Sfr+HDrU+HU7IQMI/aRdoxIOBOP+ju3gm4BVrHG+0+yQ=
=y2SI
-----END PGP SIGNATURE-----

--HQ0p01HmA0Yi1nww--
