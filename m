Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42E0C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B329611EF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhHWGrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 02:47:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52683 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231715AbhHWGrQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Aug 2021 02:47:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D49CA5C013E;
        Mon, 23 Aug 2021 02:46:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 23 Aug 2021 02:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZVXWlGu8WZrS2ohcu+bR2MYWczr
        gMNl3Ed5xZtNwl5g=; b=XhYVqRWRrZFPgJX1rhKPRHwLenIEN0fE6EHH1qAw/7X
        1RR68F5efQAtc+bUFdK7Y7+se1Vg427ocEWq97BjwoBPzbE502Jvbm2Lxk83+1EC
        lk0A2QSq/DKUsBNOJ2mk5lVWpCE7m7gN6B+jDr1T3RQRQPmPmJv9xGCeo3pghIav
        A2FAjqjVgiY4Bqr2mdZPfrXW5i6+kSZcJCahGMiJYVmEQE+ZfWcf/ZpfZX86iMns
        hFN470LUFFO0x7lt9q7k7BCgDhk6Jrc1dvbtYZZ+iLSQAe99fwG4sTPRkE9kvfz4
        bayK8ulYr/W+7361Y3IxAYkLPwUSPIHFvNkkctmEyUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZVXWlG
        u8WZrS2ohcu+bR2MYWczrgMNl3Ed5xZtNwl5g=; b=NkoDCyAO/JxobC6ZszeCoX
        C/MVW6Jcc+hNEWIhJDSEi6wGp5XR6yDzXmMJNa6SEJ0+N+xpgM+7grJdw43eYuxw
        umndmxziPd/M+7z3Wv/V4gRsu49zOSyLaUs3ciRaCyaVQ8Fy7s/LU/JkJdRz1c5r
        2eGJ9xpapW65R9DXpRH+i7Y8wQ5+rGmbSauzQvgI4+SuhY6uIV26Vna8Bd2Zl15Z
        2CuwqMsij8/SFbjtPCQ0iJk2ilrf1s9/tTmJokPRSZF9qBQNT1+l0qEMh5CSF3Kg
        m3jnUmj86eY6q07Ba54N5B4XgRsByfZ76yelZ/sOJPGN0KHqv9N1GeBDfONS2NBw
        ==
X-ME-Sender: <xms:SUQjYYBMXsGWkEeEedD0X5btjaOZHNmIKjN5lZ7InoYaxg9Fmd4W3A>
    <xme:SUQjYaiu19vsc7tybZNZLd3jBhFYLhOLKYZJ5Wluf-oFMFDrA4Z3actz3FKroTPnk
    ZkUgs6hFbNTsPp_mg>
X-ME-Received: <xmr:SUQjYbmlAAxffemiWt0LSNL7FsoxwzUHoe5dB4NsGy6UJyeB8L77M0brrQUHOwfV-xgFmcga83sVlCU321lmzMaE8FXprEKVPPP_k9alALsrU2bxW3g4A_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtgedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtggertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepudettedugfevtdehkedttedtteduvefgveeluefhudejieefueetueegueeffefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:SUQjYewxmioIX_XEORfCa1A10uvBLiG_FK9-5PTWddbI7JNIgNYaPA>
    <xmx:SUQjYdQNVZZvP_6Amm9rGLYageCAmUNaWXtPkoMV20JP5fu3BnLWvg>
    <xmx:SUQjYZb3-YRlBXhzPnMAaBbHK_gohIJ4Q81ysusIZJW1MX4MhowCmQ>
    <xmx:SUQjYfd5VT1FT2RPyh_BjHrlo-IFL3kIG9RDL4sRW2ul3qVhdGEr9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 02:46:32 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 067c8ef7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 23 Aug 2021 06:46:28 +0000 (UTC)
Date:   Mon, 23 Aug 2021 08:46:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/6] fetch: speed up lookup of want refs via commit-graph
Message-ID: <YSNEQ9R0TDUNPZPM@ncase>
References: <cover.1629452412.git.ps@pks.im>
 <6872979c4557204821d788dc3f5e1c8bef0a773c.1629452412.git.ps@pks.im>
 <fce98460-eed6-c874-8c42-bf3a6f5f93a8@gmail.com>
 <xmqq7dggvxup.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RbDWKrgXzmEV0mkL"
Content-Disposition: inline
In-Reply-To: <xmqq7dggvxup.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RbDWKrgXzmEV0mkL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2021 at 10:18:22AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>=20
> > I do worry about the case where annotated tags greatly outnumber
> > branches, so this binary search is extra overhead and the performance
> > may degrade. Would it be worth checking the ref to see if it lies
> > within "refs/heads/" (or even _not_ in "refs/tags/") before doing
> > this commit-graph check?
>=20
> Ah, clever.

Good idea. Benchmarks for my test repository (which definitely isn't
representative, but it's at least some numbers) show that restricting to
"refs/heads/" diminishes almost all the gains, while restricting to
everything but "refs/tags/" performs almost the same (it's a tiny bit
slower, probably because of the added string comparisons):

    Benchmark #1: all refs: git-fetch
      Time (mean =C2=B1 =CF=83):     32.959 s =C2=B1  0.282 s    [User: 29.=
801 s, System: 5.137 s]
      Range (min =E2=80=A6 max):   32.760 s =E2=80=A6 33.158 s    2 runs

    Benchmark #2: refs/heads: git-fetch
      Time (mean =C2=B1 =CF=83):     56.955 s =C2=B1  0.002 s    [User: 53.=
447 s, System: 5.362 s]
      Range (min =E2=80=A6 max):   56.953 s =E2=80=A6 56.957 s    2 runs

    Benchmark #3: !refs/tags: git-fetch
      Time (mean =C2=B1 =CF=83):     33.447 s =C2=B1  0.003 s    [User: 30.=
160 s, System: 5.027 s]
      Range (min =E2=80=A6 max):   33.444 s =E2=80=A6 33.449 s    2 runs

    Summary
      'all refs: git-fetch' ran
        1.01 =C2=B1 0.01 times faster than '!refs/tags: git-fetch'
        1.73 =C2=B1 0.01 times faster than 'refs/heads: git-fetch'

This is easily explained by the fact that the test repo has most of its
refs neither in "refs/tags/" nor in "refs/heads/", but rather in special
namespaces like "refs/merge-requests/", "refs/environments/" or
"refs/keep-around/".

I like the idea of excluding "refs/tags/" though: as you point out,
chances are high that these don't point to commits but to annotated tags
instead. So I'll go with that, thanks!

Patrick

--RbDWKrgXzmEV0mkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEjREIACgkQVbJhu7ck
PpTmIQ/9HqL53x4mZPSVnjVEL3xVQukbrFcfLroPwVc9DeTfZmOFIQaT/V+9+y+M
ZcPsnYCUsdMUXcoAcipoJ3LHanM61dYf3wuQi1hUFV1JDA8fmx4p37+RYUuRXU2/
72Te9pZzsH9p8Fl11AZnZ9njidntYyJnghhI1uR/7Sfoqy83QHRjBMx9LzpzCxwt
TmVOT0NQAE4pwIeT/EJwww6sjt+9mh+GyvbQzD7KSfVakOOy9WcdzgqRDu5XXhbN
kuR4Hvj7u6GAXrKsgE7/vuShfBw0d1o44kqu6k76q499v5ANx9gNMMLK6CZ3Vi8s
c4EKMlAEmlRdJeYau5O0k6lF3CcKAjdJgrOVsgIkAiUdM8RzXYuSoomcO/mDa4PZ
2FDg+l33FVWfMXMcDRrd7gycGYgBeAsNEgWXyMZucqi+2hzkZ3TLaPrBwJoscaaQ
Kz9m/L1WnJnWhZ2MQFcsmVwGEl3qG0zGk9hbrJOiXF60gbXtdbkUZUyNo9DoYqtI
YCY4qtuRhAfblPmwBcRd157dwlBO51zPeZwNxJyygguug+JetHl6CbRv6GJlzU40
ezWAD7f5izU9BipJIhQA4rxPy5fV050jlUMZMX9Kg7rO6AX5BMoSxXhedKQMzYlz
tp+3g9kvgrPS+25xR24tWeBv5SZoyalRcXDZBWRpk2o+0veKuWA=
=+6zZ
-----END PGP SIGNATURE-----

--RbDWKrgXzmEV0mkL--
