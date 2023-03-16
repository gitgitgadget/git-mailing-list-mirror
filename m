Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432B5C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 15:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCPPGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjCPPGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 11:06:09 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61559B8630
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 08:06:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3129132003AC;
        Thu, 16 Mar 2023 11:06:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 16 Mar 2023 11:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678979160; x=1679065560; bh=xT
        4eMb5ochqdkZsm5TY6BY+0XOZhz5fFJ0qs8SInOZ8=; b=HdrE4QLw1jHF/pungW
        j4K6XqZgEh4YN7nK+lmMbTdWZZ4z6b1wFB90EYLXz8VJXojKmjoOi3/Nmp+M15/G
        z/ddzXuCFlt8c6SL5CVlu+WflS78mIamhTuXjMvJZhB+pYopcE4Q3jFsmTZs9rm9
        tXl8awORJZlkL5mHEY5jhT787PZ3XDKtHWIwOZJ7lZJb0tjD9HdET0CRMJ6E9M/1
        NnN7vviptsDDgLWV9r7PLcTxaKC+y8wpJ2PVRtC+RYpYzReK3HdWKHy7RgmAREv3
        AROtXyxPuW01EFuZLnMuXZQNXwqm5gxPiht71tixReJrAuw9zDX1ApWcTFPvkFCr
        8F6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678979160; x=1679065560; bh=xT4eMb5ochqdk
        Zsm5TY6BY+0XOZhz5fFJ0qs8SInOZ8=; b=pbwmDgXVp0qP4Fp0NV+ZbCvnNdR9U
        /30OkcGFFIUM4NPdzH1WLrwZ87S4bZLr5sxlGbe4lnWvg3i5N86LIfWGfLQJomDU
        tZPC2A/hWMwwDOzraijfBKYCA+AlPJhr6g6B8nw9i/Gv+kWiM9n5k9UCX91pNbAS
        GYs+aS633zGolP4MGk5I1uRkzeEjANT5EBqwu9fM/+0nNl2oYUQitzv3ym+bryvj
        WDglHkps49lDUaf/5eChr/LtI1a7XVX8j4C280l0QBQV4wwKuWk6YusaTopFl2J7
        +c4tekpmvRTn4A4+lgUmcEtywBE8NAjLPUcowKp4FkNyppGV8j4e+hqdA==
X-ME-Sender: <xms:WDATZIcUmG_B9WXynaGmhSx8ukSv5RecR7r6xVHYNpT3qbNkEcp9QA>
    <xme:WDATZKMjnGyHwP-oEsuruTLV5UFn-VU1hVMEzuw0k6_HGd6vW_ImDr8Wa6QXUzQvE
    qAsbzgqD9si-_KUsA>
X-ME-Received: <xmr:WDATZJj2I7KveTNRz6bPXknbj2ED1Pz1FGXscteTPSRnDP4RSp7kriwFy3mPhB1NPZ8-k0fM_yL52Ti2770X1j-Jr1KDIRJL5OJKi3qwM9uWyThL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WDATZN_635HIhhizqiiSrNzQ8_hdADzWXgCdQuMplPxh5GRxNHBHHA>
    <xmx:WDATZEvvmTvYpZMRSeQh32kVY4ePRiKV1RWdAAAoxU8WrIRExU2NCg>
    <xmx:WDATZEHhktFb3VgAybqeZHR1TKziUlVIZthicn5x3IqHV_9P8xqhaw>
    <xmx:WDATZK1OEIEM5aVdITj3OG-m6JLjG1nhrie7C4XrOxHWTY02W_tu9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 11:05:59 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f25bfd91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 16 Mar 2023 15:05:32 +0000 (UTC)
Date:   Thu, 16 Mar 2023 16:05:54 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] fetch: move reference width calculation into
 `display_state`
Message-ID: <ZBMwUmBhqEd74YAx@ncase>
References: <cover.1678878623.git.ps@pks.im>
 <aa792b12a468263d05e8615d4b3691ed8fe823ff.1678878623.git.ps@pks.im>
 <xmqqedppohno.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GuzH2qXNw6aJCllN"
Content-Disposition: inline
In-Reply-To: <xmqqedppohno.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GuzH2qXNw6aJCllN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 01:59:07PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In order to print references in proper columns we need to calculate the
> > width of the reference column before starting to print the references.
> > This is done with the help of a global variable `refcol_width`.
> >
> > Refactor the code to instead use a new structure `display_state` that
> > contains the computed width and plumb it through the stack as required.
> > This is only the first step towards de-globalizing the state required to
> > print references.
>=20
> Nice.
>=20
> Given that in the previous step, what used to be called display got
> renamed to display_buffer (I think "buffer" ought to be sufficient
> in this context, though), the variable of "struct display_state"
> type should NOT be named "display", as it would be confusing when
> two things are related to "display" and only one of them is called
> as such.  Either "display_state" or "state" would be fine.

Fair enough. In that case I may just as well drop the first patch.

Patrick

--GuzH2qXNw6aJCllN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQTMFEACgkQVbJhu7ck
PpQ1vQ//e8GznJkCVmuIWC1A4qr8rgXNtZ4B16c8wFpLs2IK81CeF9VyqWMU/jfK
4ql1ARYjYQzrCzqD8cPqYQyCOlbKVrVKS4WVzW9hPWLwA9fgwcOnefDvYfemwThv
RnFYG7YVjROU2dgziGjweLeeynb6EW2Allc77wLFNQXv+tTL+lOI0SYJM1nSj5g5
ymnF9XpB7EjzI0Qlp9eH6A4lFAV06L9nlSmRAJ4flZdDM7zPh7FX76cqsFyHP8hu
85ceny32vmnQcAFOXzqZQltIfDynbDVIOQtS2H7PX0bPApM+cpySeJsBRFgfU07b
O8zXM+85twst3kTXG0Z0BTqHS5QtCv2/sk1Hb55nx7c20dqk/S3W1z8sLmt1L0rF
WiPAZGNt5YCX3uAOB/2LcaeB0+aJBO7SHlizWNwnrn4F7u3UnxzPgzurjO3b93ZX
ZcPsBvaMDpZuef5I2oxAuqVRXqhYUjzYHCSDLaNC5jj+XIH3EmyGYZMbYRbLnTi3
ZazKTBqiM4QiN8wVoTo/KThV72AO1r9tZ00ddMwNtDpypSH7t+EI9NqNhX8iX6P5
BhTmhqDjLx4ugq4zmRh5dCQNtUgkfl0rvpgBNEehJG6cUPRcM/MlUZrEX9PkEny4
86OaaEIuVX1kzeANJuoFXH0OBmA6InI/466mMQ0ZBm2EZAwVf9w=
=kQTp
-----END PGP SIGNATURE-----

--GuzH2qXNw6aJCllN--
