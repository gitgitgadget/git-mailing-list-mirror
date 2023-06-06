Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F328C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 07:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjFFHBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 03:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjFFHBK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 03:01:10 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6630E4B
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 00:01:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0A462320095E;
        Tue,  6 Jun 2023 03:01:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Jun 2023 03:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686034868; x=1686121268; bh=hB
        C72uuI9xR1HyrDKQDlxfGCPPF+P/+jLxQ66Tl+o4g=; b=qbB8aur7ts5qDfe4G5
        cZQ3AyaqdDvyX8eGosZyPdlYAYFGva6T2vJs3hzRTKBNS/+KiZ4yOqcEEhXsUYGj
        NYeVMSykxYgYRFVO4khxDrFSd4EGjlSUhFHVEVZhYWnDopSpnWz58aJkksEUd1qS
        KQbGnVlSvMEk3HykRfHakL3kWp4a57LIrMoEnKkwC3XA+mVVFVC4646RP0KW0n/4
        PSsOIYKXi8J/B4R2yyZXKZ0GE49RSFS0ZDaEdEP7RJ4Qu3Wy2a2FoJCC38RUdsun
        XzXtgPM1TZDTZmn5uUsp/sbRCVRdDsVA+u1T6yz/+zp3gkj5WZhtQACO9zPs+HcP
        7efA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686034868; x=1686121268; bh=hBC72uuI9xR1H
        yrDKQDlxfGCPPF+P/+jLxQ66Tl+o4g=; b=IsfNv9qC9SzxGPdRK0Xf0mhZ2Mwy3
        eRijuYf8ZxdtbGkW9nOZ8LuVy8230zTdZJm38XV2KtB60IMaBYgIlVYx81hBsGi+
        3Yo1o/Ir9ZbI7KEc34RHXimQx2BvS4GvdvtMMMWDUrHC+5caRmXWUgZnDXxduhoB
        phKkFwFSprXQc99heNlgydnAivWnFAeGXDB0FAzJ38xMFPWqFLU+7or3X2WIBFyX
        nWd6BZdGTw7esD0sflBfUtdXEXKTYpVBHWvROZPe+jBU3/b+oFo5umzGaiVgNq4A
        6rO1zNA/62WFcvM4p7YSx6MZkbR3il6gF01CpoK4mWY4fgyYPCO5FcbEA==
X-ME-Sender: <xms:tNl-ZFoI7-z5RGMvNw4AHmB819qFirxv_WMX8SG_CgMp_2ruXY_qrA>
    <xme:tNl-ZHqGNaqNcxB55qp1V3k_P6CI9NRqEaSPRLUTVytr-v0MvdCtT02Z4thoLkFqL
    ZbybVBkQCh2UlrJEA>
X-ME-Received: <xmr:tNl-ZCM2dEtPTPoqO5I26jwljt4yQCcCxhT4NXOqFAzhcIQHQtji1Y8d2eL0esJ5pOJLI1HDVpbeCG__UV636tNgcLr7K0x052aY3nopvec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:tNl-ZA7rRRB5sRK53AVZwixGipWuFx9NW_eW2Zlgj6imACRQmSbeRw>
    <xmx:tNl-ZE5tH9CZ5dqF1JuT4hf1icyP_sDxkdaccrzf8GYX8-ItqkNfbQ>
    <xmx:tNl-ZIg6ZMJhWKvLfZ8VmZyOanky6cWGIipBu3LVDa7Xh2XSqR6M5g>
    <xmx:tNl-ZP075TRqOo6Gw9KKW_4stEmspvkWqTNVt0r0MkXguuRP70ZvgA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 03:01:06 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id c471b0db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 07:00:02 +0000 (UTC)
Date:   Tue, 6 Jun 2023 09:01:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/16] refs.h: let `for_each_namespaced_ref()` take
 excluded patterns
Message-ID: <ZH7ZsIq5vQIstjAG@ncase>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
 <50e7df7dc0932a53682664a6334791d8f1ff31bb.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2QP/XREJs40fJ0hR"
Content-Disposition: inline
In-Reply-To: <50e7df7dc0932a53682664a6334791d8f1ff31bb.1684178576.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2QP/XREJs40fJ0hR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 03:23:45PM -0400, Taylor Blau wrote:
> The following commit will want to call `for_each_namespaced_ref()` with
> a list of excluded patterns.

This statement isn't quite true as the following commit touches
git-receive-pack(1), which doesn't use `for_each_namespaced_ref_()`.

Patrick

--2QP/XREJs40fJ0hR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+2a8ACgkQVbJhu7ck
PpRGCRAAnSkUIOyCM+8a7mPVutyR14eGgdS81Fm3NXPTBSr3TtsN8LsBvMoJVmI3
oJJDoLveKonT5Fzu3WRP6VyPuA4OK6dxEBWccfbznD1YZYN9QknKboz0dTwM2qTh
PbT8a3w0Tk79+/QzQZa17KccNitiN3BhTyOJ5R2zDI5/EzP52eHmkOLKjtGzJn/p
q1RQsE7LOqgNw4e8qowd6ddLae2B0L8mxzYK9jDtm5BMAudX861Re9pxt+FLuaze
VfsmvsoUkfEPF4O+gahDMOm6/y5OxwEEclXDk8o2FzLzn0mKfV5EmyAjHk0k+Q8V
9i+F4YQravavRgj5jGIX11/9W1L5nMzdICV7J93zIPWOm1ZfxAUvBdaUehRwbuWh
bQ6djbrMGS+6LCEjXECAM/Cxg51zGfpvrXmRxAigEUwbAO6ODiqWyx90WNhh2Spv
REKhRRH45qdmdpc2myoexvIH0FiHs/qzmD1MPhjY8q0s7yMzo0Ag4QT+2I99xTmF
MkarDEsdXvWcQsJWtjRsBxtVCl03vV4jMKd2Nh6S2qSPJrXinOdvHPH1bi3eoqL5
AvnFVM7rBYk7Pe87q625Jl4dWdmCaRFq5/jfJylGQaUgV1mI3ZhApBXjx/YQ8XYK
4rFgNTr0rVPpP1YQp4pGu8ca0JUQKaOfSS8BObK3COJTeylLfOg=
=3lUn
-----END PGP SIGNATURE-----

--2QP/XREJs40fJ0hR--
