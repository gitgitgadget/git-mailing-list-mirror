Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8063BC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 07:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjEHHbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjEHHbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 03:31:43 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532241A49F
        for <git@vger.kernel.org>; Mon,  8 May 2023 00:31:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 98DF73200392;
        Mon,  8 May 2023 03:31:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 May 2023 03:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683531098; x=1683617498; bh=A7
        bS8eHKqTJX8F/CAYbII92BSSzPntNtqbeVflSd/Bw=; b=fEPWj4Eaa2JCULoBj2
        YtMIc0qnse6hfocP/YDbmaPrgHtNKqwW1DDbCicsOKWkyPG2SZJHdfLFo+KFO0Jr
        T69yNRTgFH695wAXiClE8OP5y750t+ILhzPlUyW+XqXYrsIyFQADTbfiv/q+Bwwl
        rxm6lO4xrk5eKvTFs74fiEyx/Xm9aH5BpN0iPEGGq0Ut3PR0ipPaK0cfjKZJtTWQ
        zuietsrnvNNJTO6umCBKlq9EfJjIpee3CO67jV5Kn5gdPJUd9x2XCOetmiCMxLn3
        YuawTSHl8Q9glgrxlltcQkS9cyZF8BAwd0Rak2dNW9prmpPQrfm5XivydhygStLJ
        JwTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683531098; x=1683617498; bh=A7bS8eHKqTJX8
        F/CAYbII92BSSzPntNtqbeVflSd/Bw=; b=T9U9t70fKlAwUVyToXkV0H/Omn+p9
        50ggXYSMcdsk7S3hyAPhj0cRpRfX3RkBcRHZjD21phpS1A6/AypIb7efa2QFjhkA
        COw+8HrJY8EGO7yEK+dTWeIP7x/N2TAT8zYE1k7ZmwuhKZOyMbe7rsn32K7I8f+t
        Gnyhrjz4+B4UJmWFyZk5g7K1YK55t8GLFAYRW1PbVjP/W4/h+4eCjmVFMuDVogXb
        vQMVBRgueP1SpNOqLU7R8PGKW0RIQlpl0AK3A5M9SQzNRmnj33o2g/LV3kQ5ISVw
        LM27NZ+8jjGHgsEO2S4IYgKQ8n3E7oa/AMPs3FXus+STXd9NpfMb72VCw==
X-ME-Sender: <xms:WqVYZJ_vj2F767CZ4uulaXLJitiWVp1DPcNU2tvNQprosSqGhSqOlg>
    <xme:WqVYZNv8G-zEAx-FB8D0-_TeJ_a7gq6ZmVCrz09R3RCi1SFN8Mhm7yYAC6LVvSZbn
    DhwmGNA2X9YnwwIeA>
X-ME-Received: <xmr:WqVYZHDDW6hrl35c64TMZ0gvkyG1dCHRm4j7NFySZyPmicD0UpfZZtURP_9Q0Tn4cHTOHSfBMCZ9PurCSnZq3D-3gFkXZsXQiHWWns1RydtKERM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptdeiteevvedukeekheeiueevtdeigf
    fgtefhkeelgeevtdejueelleffteeuieeunecuffhomhgrihhnpehpkhhsrdhimhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:WqVYZNdCzLD1xt8HfsO2-j7xbbuLeWmfpJG-7brnw4Wa7fSE6NRtLg>
    <xmx:WqVYZONjfRdyRedJeLQ-qBms9LnxkoUVCPuFfUDmc6X3V_TnG5E3FQ>
    <xmx:WqVYZPkVTBggXlYtgVHG5ZXdkp7EJxSzqlDYTrlVMRaQ0u4fphXwwQ>
    <xmx:WqVYZIXes6nLnqr0RBsqMT2-blSjiDFZLUJKcQg6fcl9gvxKZqwlqg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 May 2023 03:31:37 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ce0f36cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 8 May 2023 07:31:30 +0000 (UTC)
Date:   Mon, 8 May 2023 09:31:33 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: ps/fetch-output-format (was: What's cooking in git.git (May
 2023, #02; Fri, 5))
Message-ID: <ZFilVVv88qhZhL-d@ncase>
References: <xmqqmt2ibcq2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uq5CC3A7nsklRW16"
Content-Disposition: inline
In-Reply-To: <xmqqmt2ibcq2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Uq5CC3A7nsklRW16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 04:05:57PM -0700, Junio C Hamano wrote:
> * ps/fetch-output-format (2023-05-03) 8 commits
>  - fetch: introduce machine-parseable "porcelain" output format
>  - fetch: move option related variables into main function
>  - fetch: move display format parsing into main function
>  - fetch: introduce `display_format` enum
>  - fetch: fix missing from-reference when fetching HEAD:foo
>  - fetch: add a test to exercise invalid output formats
>  - fetch: split out tests for output format
>  - fetch: fix `--no-recurse-submodules` with multi-remote fetches
>=20
>  "git fetch" learned the "--output-format" option that emits what it
>  did in a machine-parseable format.
>=20
>  Will merge to 'next'?
>  source: <cover.1683113177.git.ps@pks.im>

Note that the description isn't accurate anymore: v3 of the patch series
has changed the new option from `--output-format` to `--porcelain`. With
that change I'd also feel more comfortable if the new iteration had at
least one review before merging to `next`.

Patrick

--Uq5CC3A7nsklRW16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRYpVQACgkQVbJhu7ck
PpRekg/+Iag8AU1M6RsyU08te+HkZGiTFmo+oHqLj0w6HuOlH7pqrc51zZeFrY9p
57j55LaDyuOx35rxZfuaDL3NtghR3DTlDbi2x+7lXaWD3tBFh/U7OZIwq7BOQiHn
pPtNDNjrh2kr6KokWfCDCvuBXHbtpkTmyvR/8HZsv9C1BlGn/MMpm/SuTvxwAfUl
+vWKYYEybYTbNY0FyIp+JlzQtD8w77NPpD1/qu8rixjA26mehsiequNQunuM3Xkb
vJBE2qRMtJrKJrcprvTW0o0o8l1i8t91NDtFGrVZBiQD5KqjobKvgLJ19uiWbs0k
OAlD8X2QBnEkOeJvXNWimjygl1EEPZcpZE28UTeC0a21b87Uka1cTOY0nKiWT8Dl
AHLsfijhGNykEk7wOsEe9NOws0B/dlqINIwn6JuW1qenTgmtYp1SR5bP2Dvlh62d
IWihUzchb0Qu8wD9qz0A1Nfqfw7WOMq58OYP5Y/mUn1WtTkKQndDHk1WTpJLISJa
NgDhredWIpJk8eqxXOKCL07i/RYi8XdiNV5JNS+J8LGXnrv2zZC1AMqrAd3L9+7H
g+cVih6qezVsXiNUoYycF6yT0mpXB2oVxAf++VY6n9obqggsfWnRX9rqX7hGc02K
sblPRmZzHyky2RuqD93EOatZ7x0vPIlpT61WRxg4XQysgz5ICWo=
=Q2Kq
-----END PGP SIGNATURE-----

--Uq5CC3A7nsklRW16--
