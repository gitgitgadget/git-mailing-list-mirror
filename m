Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7766CC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 12:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578F261359
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 12:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhFPMP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:15:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40597 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhFPMP4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Jun 2021 08:15:56 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B6DB55C00CE;
        Wed, 16 Jun 2021 08:13:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 16 Jun 2021 08:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=kNAmaCGeOrJ8u1EbtVDHZOHmDBX
        uaCqMb3Hf/MQZULk=; b=qJXnZZ6hPFCUEWfZq300TBuS8Z7sGH2K23EQnkjAKYz
        Fs6u+Es8WjRwupnORRkPzxgvl9Urc0kVQB7ipKqxQCisnzRSbu40YyZeCNC0Vf/S
        ffRlI3bp+P6qlR5AB2qbYj+U4+CH3IfAwtzxSf7dinIG72EgwFs/vrTggBryw7Gr
        UGbOQbJ9yhbUgFUZnCXVEI05YZbkAcOPsOQAHOhX0mW0ioucslDQcABW3TTQbrsc
        4GSd7Rnyog15YBT7K58/0R21saH5ezi7mKm8bRgYjreZSiSl4binL198iJKahxtY
        68Dzo9gxl0mx8Hw70ZOGYylsjJ9E0hqhCVfoQFiV3Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kNAmaC
        GeOrJ8u1EbtVDHZOHmDBXuaCqMb3Hf/MQZULk=; b=Wqu1Hqnc7rfza+qJPsCddb
        Q3C6x9OJHWiR/riFTdijfYBlPjNQUCgXL+QWcGEnCKXAJenEkzvpXFwS9Uzcbebu
        8pZMnf8lHbJCrrVC/2EhSaDQ2f6usAZh3+yRFclfijPsPGfXpxt17IdT6t7ptNjq
        CITwbX0QUyG/nf2W8/hjd+KFXOqDqgdcbvbV40n3MU9jxKbJsZy9YFdW2rd1UV1o
        q4bq835GjGRqqBtc+pwCFm5xN57fnweqsGkxM48sdN73iHFHU1/M82gajvhsOWLT
        NOxCr+bDEPZzpniTx1v85ePb5NUeQlV3+1Daqy3vr2XpWJCxvhSPypgangQk1Z5g
        ==
X-ME-Sender: <xms:_urJYDehiFtLg-qrXmO1dl8-1oxKSAbF-5qePIWw9gBweANRga2hgA>
    <xme:_urJYJMqrlLZhoKumS44onKi3DQouWHVJV-TIV9ehHHHRWjr2XC3tmrmLlRhZbq2J
    HQsTgzU_LID0fxB_w>
X-ME-Received: <xmr:_urJYMiKTF-5oczb_dfcKRGmT-o_g1ofwjMMkubF949Eu4N_JfbJ20zk0JzWMCIiRATmBvR8rilekXyyZfNaCZAFMGmEOeHFfNqAAEVrAhNuw5HxQbYJc4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepkefhheetfedutdfgvdfhheevgeekfffhve
    dtvdevteevgeetvdfgtdefvdehgeffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    phhusghlihgtqdhinhgsohigrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_urJYE8ziv1xB1uxkOmWKpMwmFyxnxSjNARFV4NVfse5ZulwbXkUDg>
    <xmx:_urJYPuWCCmR6yPA3wfNPEozYfQqMZXQ3H_JUnLGiK8t0GmALlTAnQ>
    <xmx:_urJYDFnmIon_okXOphypuoaiz2xTh-6TmK72OcSD1arvF2RWh3pFQ>
    <xmx:_urJYN04RULuxYttx0l6mzgiAHqQdj3ysjTTvMTi_1yXTbTgCSQefw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jun 2021 08:13:49 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 910fff56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Jun 2021 12:13:43 +0000 (UTC)
Date:   Wed, 16 Jun 2021 14:13:42 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] perf: fix when running with TEST_OUTPUT_DIRECTORY
Message-ID: <YMnq9uPnmjotC5w7@ncase>
References: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
 <87mtrqxcq1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EXJOu2byE+g7e2Pg"
Content-Disposition: inline
In-Reply-To: <87mtrqxcq1.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EXJOu2byE+g7e2Pg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 01:33:32PM +0200, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Wed, Jun 16 2021, Patrick Steinhardt wrote:
>=20
> > When the TEST_OUTPUT_DIRECTORY is defined, then all test data will be
> > written in that directory instead of the default directory located in
>=20
> Is the timing of this patch a coincidence, or did you run into this
> related to the other patches related to this variable now,
> i.e. https://lore.kernel.org/git/20210609170520.67014-1-felipe.contreras@=
gmail.com/
> and related.

Coincidence. In fact, I already sent this patch a few weeks ago as part
of [1]. But given that this patch set turned out to not be an easy sell
and that I didn't yet find the time to work on it again, I decided to
split out this patch and upstream it standalone.

Your remarks all make sense to me, will address them in v2. Thanks!

Patrick

[1]: http://public-inbox.org/git/cover.1621451532.git.ps@pks.im/

--EXJOu2byE+g7e2Pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDJ6vUACgkQVbJhu7ck
PpQW7A//SzRShh6pYPb5NnbbaInH/Y66odZu/xp4rdwe8204f9ja1EFkFPw3Mw/0
2bufK3x7TR9iMSd7NRRKH2IyzaltiUsgBm5OzYwHQ4S+2B2qhP4GCZv+QE5XQhDe
LsncsYndbU6qLX7jC5dN7NKL986JV/C4IKpHFpWuw+3BzGM2wgAlfb2Zoa7lB9UL
69PSiMv6aIMvr3IF0PFO74TPKTpW/N86NuicA+eT1j+mfmIpbaXkBaBha5C1lI7D
MWzEC9u4A3wuD2LM5WBUqwbBzC5RS9qA76lqz2xDswsZWPArly0Sx9trvATT3X6D
TDooCCZhy4u5yQ7laguC4EQVZYVboTTPdRB6N0eA4ApyKQctjgxcN4B3CBebiH9/
xfvqijoDL84goEEvUaLbGHzPIwL2VIgaFLnGmnfMiwVYjohZBfDIvAVxmAUUTZ8i
CRcAjteQEeZooV6RHOoQtUja74PdMcOXvci1xoYRhv2QWaN0NGriQcmJ0U/2a4uN
9Ra7ti5l+JSBRVeJW2sh6KVnWV1MJ8Q63V1Nq4+92Ek47uKl/zK32fpIxcS1Yty7
uwZyLdvi3Vo+S4cqj+S+norsqzauxfRYQsatBjqKmyL0zg364QBnXZqukmXuyevI
zCpDE/l5IehqFMl/k+q6ODan/zqShnO0DD7jwcT8UVrZTsdc1is=
=F3cR
-----END PGP SIGNATURE-----

--EXJOu2byE+g7e2Pg--
