Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41AEC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 07:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346973AbiA1HlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 02:41:20 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57173 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346954AbiA1Hki (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jan 2022 02:40:38 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 200F432009BB;
        Fri, 28 Jan 2022 02:40:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 28 Jan 2022 02:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=2rL6eotTz6aoAVJMV7R7Xc562qa/2hW5KaYLUA
        aWddg=; b=SyglhLMofY5Tae3n594y/wQu1RArW3uqRMeofr8e+jEDJvXq9HcrPq
        TkB2V21JilZz17ZeV7j3GftoF4M4aDC/abyY2YYzJKtnqt9oT+6gO5HjD6P4nRD1
        P7xb7yQG70eUWiNiddiLA0wDGU8OX0kitL7VNjgPbAzxwbp53LxX179QG2dqOVGc
        XDEPxtKeyuT9SCJhCnOon0V0RWKM4ef6e/OxeYYmWG6CzfWTl6jziuldIyCulamO
        SQUK5crK1CkD6MxRn8l6KF4LYcWnxlZPewTAuiBN2mXG4HKjL7M0aEVfxTiLywaF
        E8CjxPmXBZJqKU9EZvwqspg6mRutRpKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2rL6eotTz6aoAVJMV
        7R7Xc562qa/2hW5KaYLUAaWddg=; b=RQxEJKBCcJfgHR1riJknutY3sGQ5Olsu+
        T4uZQCTE0W8i7D5N7swCsQvB11ITip0GI181rZkKT9O/nqJ/f1+2UYJruDjyGMRP
        wzQigAEulSOjpr0I8lgFFl+ypcUdlzCnaLivg9nryN7XdBvw7hzbAicd7xrV8ha/
        M5/khOyHou6IpmOgTk2Akk6vIV4uLsg1b+Z8OBZ9pTPVOJqqKOxZZHstLU+HyJmh
        6c6J5FHQCIceDzgDgySU1mqEs/hOtadqnX73fUHsVQB1QJbjtAKbgfS5MFWb1s6t
        goWGccFYqIrYmE3kQNbA5YQGBro6YRjU/42kR9hIYh807+9Y/20lg==
X-ME-Sender: <xms:8p3zYdE--RxAEGWWzvFN8NDhrfTUJ9izjxm1l_JxQGqwGa6l5nghXw>
    <xme:8p3zYSWhMbMIAIad1NKWr0z4uKJZz681CFc16XW3YVpWFZ5n0M4cQUFqxIDN10tDI
    adXCXsPSPCb2l5K0Q>
X-ME-Received: <xmr:8p3zYfIyZX4x_GEakC95J3_uGHXfzsNnceQmrhf_d_0mhiBUTNLmAXqjrgzbAxZRX2X0nHZa_X5wYxwTNKQWLhkw8v088mVBFMnrtSExpxnVHv0b-0YuoaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeeggddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedviedvfffggeevudfhjedvvdegkefhffdtueevtdelvdekgfehiefgtdekgeekfeen
    ucffohhmrghinhepphhkshdrihhmpdhpuhgslhhitgdqihhnsghogidrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhm
X-ME-Proxy: <xmx:8p3zYTGJ19ShOzRWSTTFXFKNPMMXPZAgYhc6_Yc0MQ2X9RohHFBaAA>
    <xmx:8p3zYTU0d3hJJoZbTXkJHvM9F6-T8nCaRsWptcrfdd4oJX0z0eT77g>
    <xmx:8p3zYeN0a_s8PlUkf4YU8ndCeC0WM3HP2iT1uV-AA655vIkFBH8i-A>
    <xmx:8p3zYacpaqxhKk02qlDKcFpx9k-w__YEuvoHXAl-x6Wkf5wOZn7PLA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jan 2022 02:40:33 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b7e937b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 28 Jan 2022 07:40:30 +0000 (UTC)
Date:   Fri, 28 Jan 2022 08:40:29 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: ps/avoid-unnecessary-hook-invocation-with-packed-refs (Was: Re:
 What's cooking in git.git (Jan 2022, #07; Mon, 24))
Message-ID: <YfOd7QRK4zjLwJci@ncase>
References: <xmqq35lc53e9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a5cIikUWFsBY76OF"
Content-Disposition: inline
In-Reply-To: <xmqq35lc53e9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a5cIikUWFsBY76OF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 24, 2022 at 11:39:58AM -0800, Junio C Hamano wrote:
> * ps/avoid-unnecessary-hook-invocation-with-packed-refs (2022-01-17) 6 co=
mmits
>  - refs: skip hooks when deleting uncovered packed refs
>  - refs: do not execute reference-transaction hook on packing refs
>  - refs: demonstrate excessive execution of the reference-transaction hook
>  - refs: allow skipping the reference-transaction hook
>  - refs: allow passing flags when beginning transactions
>  - refs: extract packed_refs_delete_refs() to allow control of transaction
>=20
>  Because a deletion of ref would need to remove it from both the
>  loose ref store and the packed ref store, a delete-ref operation
>  that logically removes one ref may end up invoking ref-transaction
>  hook twice, which has been corrected.
>=20
>  Introduces new leaks when merged to 'seen'.
>  source: <cover.1642406989.git.ps@pks.im>

This leak was fixed in v4 of my series [1], so to the best of my
knowledge there shouldn't be any more issues my series. The only
question that remains open is Han-Wen's [2], but as I replied I'm not
sure we actually need to adjust documentation of the flags given that we
already do explicitly say how we pass through flags in all cases.

Patrick

[1]: https://public-inbox.org/git/cover.1642406989.git.ps@pks.im/
[2]: https://public-inbox.org/git/CAFQ2z_M+2D-5qPXN=3D0FEveZ36Yq0rps3HxRkgC=
miupq1DD7Kig@mail.gmail.com/

--a5cIikUWFsBY76OF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHznewACgkQVbJhu7ck
PpTQaRAAoziyVIkhguAsBs8x6qUUAUU1X3wDPeBvniL398G/jVgyeOHrm21WnYLl
wpfeiUE+n0spix04lrkAaGo4JB8iNGP5kY97cchndzu0b7k7paOtYvzlGEksWzNv
F1MGEvnHcm25D1ic79s/jvJewfLXjmHysCZmMNoeBRZwcUr6cjvNJJ0pgqaK3B9p
FdmjupSsekiOza5inQe9g14HYjTh3MsYp3by6Stow0clSbqsmizJ4EKIuJNJ59ib
onEz2RtAUsWM3Tg8TLIHkDNRt1jtpgZoRdCGYdcLIxw9X0HltxYTWqjFBLf5yzP8
RRwFILRxUYJnEkstNeu4GjXFj7eNcos0YSumv+i21SY6PRWT6aZrncfUx0LUoWPX
cNW+PfUemNj/dv9S+dglog8CydNiIweSAREANgnrJTtJnzJUfZSinQM+KwB7z3cQ
afg6IpGp88o63qfDBXcnUjhrvUpSrA82HhY3uigAR+tJIcVa7cCD2Sbhd1Rb8QTY
WVlubQ0ettTJ6lfa3ALCzrNbb3OjCfisLzwTMisKPxP43jGXLil2sfEpjCfBFNgC
tL5s3IZRD30pBx4a2bMYKO+eXUkGsp7jVNnkIKA4mZwLqC9vf+0w5Ie//ove61jQ
ENJ1WyCSJX6kYPY5B9ZIBVaPEX0QzfVLqfvRLAudlJYB5mLkU0Y=
=AIgb
-----END PGP SIGNATURE-----

--a5cIikUWFsBY76OF--
