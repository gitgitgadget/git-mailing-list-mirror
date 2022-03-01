Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B671C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 14:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiCAO7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiCAO7e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 09:59:34 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E4715A37
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 06:58:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A2C75C00B5;
        Tue,  1 Mar 2022 09:58:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 01 Mar 2022 09:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=MqHm0KyQ64sP6rYGJW4vQBPqwkNkyWe1GFITrR
        Aksgw=; b=YD+/efQmEzbeR8P8Fo8mJnjGNpYg4vmPJp/BEMvuNSlabqxD2fSKFC
        g3uCWLNvo1VjgCyb1SJcmRgXm94swRY1x4KK54VUxhS11qDVgN/ggAh2CPxo9MBo
        Ep1KoKLEHeFG/txKdM/JUyINAJBxhFEmLzk5Iy2zUx9viK8iqPljgkhXO2k8fOrm
        KOGU6HPbYP7ZBCo8YMMWKyQYr96iUiTF+hHTnH7eJthn8Pyb9z2rFxV3Hy7ukrM3
        l5pBGeYaua519fyQ0oV+vZs1xD9aaqpl7mKyPLHXIh5mkvwFxmN02TJK9gjWBOUX
        ZvPNWsFSReKfB5vvwVje2P8zsdJV7etA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MqHm0KyQ64sP6rYGJ
        W4vQBPqwkNkyWe1GFITrRAksgw=; b=bOMFVMvsUyJmNTJ3V/fQtVuTz543XfDmx
        1ylJrMO61NvRc+hMVO8CX6M5Qa6gNHnIcrWU+BnePSRjm0XmjvxymF59QdHvt4MJ
        5j+Quum0tyB0WRLCTipQFFA1iGemZaxmWtxoHOS/jZx4KGyoIpqXVGWwt+hT2T+B
        zuvKzeIpK8S5A460HeN5sKzmi/5GICGoSD15tNxDMIgA6ubz/VTWToLyKv1aRlpj
        bMwR4ttMxndHPSQzd9UTxTIfiHaaRiMIrv94gEnxvI9tI7lTz/bVKMb+CN9yY/aV
        TwVWwmJurDCKoD7Dg4f8ad9sCT2/M8VFbgQn9rVsjBkXENcIXMeLA==
X-ME-Sender: <xms:qDQeYut5UQ0gzTwrlXaVuop5f0cRqIgMngOuqNViqeHN9X64Cy2qyQ>
    <xme:qDQeYjcn1FXcSCM8E2f_Tv4ALPLinEAZBybPRZFqJsXoSWnKA9vwrYTAoYOwV6LmF
    bi7nyhn9OOv0D8LKQ>
X-ME-Received: <xmr:qDQeYpx0pPZLqhj93XSB5iodYJ1bcZR1aQFgofst56XllPeRySXBv-7VPSEeKMwW1iXj0WhjHT8vPo8BfZoMs8zY40PBzxVXQTuStjfbLzzlkmg9QzKs65wH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefiefhtdfhffelgeefffdtleeffedujeefgeekieeitdfhudekieekjeehleevvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qDQeYpM6fdFOKPe8zcvYFwjFzrwVAIPuDoGNAgnqY2zDiVARDyr1QQ>
    <xmx:qDQeYu_GuWr7VSHBEg5XJJJBOvV8XL-fWRSUGbH5k4u2w1W3bDi-sQ>
    <xmx:qDQeYhUKD4GLaBwaTZuqm2m0UN39y2qJZO0FJlUP_vuGI490dJBCMw>
    <xmx:qDQeYgIj1xJN5n_RlIKl_B8wLTaz11ABAGRZrpr6eABeykzzqnOboQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 09:58:47 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0f397538 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 14:58:45 +0000 (UTC)
Date:   Tue, 1 Mar 2022 15:58:44 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: ds/commit-graph-gen-v2-fixes (was Re: What's cooking in git.git
 (Feb 2022, #08; Mon, 28))
Message-ID: <Yh40pJ1o0JHG5Op2@ncase>
References: <xmqqmti9ssah.fsf@gitster.g>
 <a296c8fc-9701-15bd-4459-e49f157adb56@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FvRjXCWo5lNWhyf1"
Content-Disposition: inline
In-Reply-To: <a296c8fc-9701-15bd-4459-e49f157adb56@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FvRjXCWo5lNWhyf1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 09:26:51AM -0500, Derrick Stolee wrote:
> On 3/1/2022 8:42 AM, Junio C Hamano wrote:
>=20
> > * ds/commit-graph-gen-v2-fixes (2022-02-28) 4 commits
> >  - commit-graph: fix generation number v2 overflow values
> >  - commit-graph: start parsing generation v2 (again)
> >  - commit-graph: fix ordering bug in generation numbers
> >  - test-read-graph: include extra post-parse info
> >=20
> >  Fixes to the way generation number v2 in the commit-graph files are
> >  (not) handled.
> >=20
> >  Will merge to 'next'.
> >  source: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
>=20
> Please hold for a re-roll on this one. =C6var has some feedback
> on these patches that merit a new version. His comments are
> mainly about test structure, but they will help get extra
> coverage in the 32-bit case.
>=20
> Patrick also had some concerns about upgrading from older,
> buggy versions of Git. I think this isn't an issue [1] because of
> how those older versions would ignore existing corrected
> commit dates, but it would be good to get a common understanding
> of the scenario before merging this.
>=20
> [1] https://lore.kernel.org/git/f50e74f0-9ffa-f4f2-4663-269801495ed3@gith=
ub.com/
>=20
> Thanks,
> -Stolee

Indeed, I think my concern is not an issue. The failures I was seeing
were my own fault because I had been running an intermediate version of
Git, which created those faulty graphs, and they carried over into later
testing.

Patrick

--FvRjXCWo5lNWhyf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIeNKMACgkQVbJhu7ck
PpR3Vg/+MZL2y5SFG2URMTnz7o2XkZRBU+xoUUBZANbEWUlNDYnRli2ZR4CSAe9Z
tCLoe4A1jSVesbim3oVAGaDtqoMTp2lVHRpeY2qXwJdl46vcnuj3ziwFOV35FNgP
1+3L9LzoAlCZrb6yxYUcH16BQzmjL2djpioNbs1fVXzvwG8AyqESB0pY6qLqMFVX
+c9EUFgYT9Nu0pmEmJAU8n/zCuP6iPFuy4yp6zxh14lfjiIy705UH3lDo0582qyR
zn95NfFzO+ppRQGRnG4BbKcfIauB8gG/wi7LGXNSeoMJRMwAvrOCyJazujsAp1IU
E3Mi0jSZph9juIHSHK7PuR7SqChKg00yN00NDmvzy9qXGmnV40pQuOYxcKtfCycp
2Xiszr4Ap+h9CASIsgo8keY0SLM4PSipXK8yZpz1IRM0BT/9/HIG3lmlWEx2+8W+
uj4jCzcjTHYauNwXBRcH86EpVErZWC5saXTJWj4uvDlooIDE4STj8nrNtp2kM/v/
hEaJVT2OnFfOSTengz5NEtP0TB+300QHs60eA1HfL1OeFRQFhRxPjo1aCDmb6Cu4
KuuOf8mLQlBviyaNnCORygLavKvHCMBPT2zWMzDlruLfUmeaxy7AJLsB1mVvPPdB
1LMiFIXHU2JdlBOEMsVV7PohsIN8VFkQdIGTFajWxpM7/uA3Lrw=
=DMdY
-----END PGP SIGNATURE-----

--FvRjXCWo5lNWhyf1--
