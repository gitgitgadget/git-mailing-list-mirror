Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE0E9272A
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 14:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjJEOnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbjJEOi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:57 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521164F6F3
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 07:02:53 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id F30073200A26;
        Thu,  5 Oct 2023 07:14:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 05 Oct 2023 07:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696504466; x=1696590866; bh=1h
        V1msyUqkCxDerZNF+HO0sEMUNJ0VB2+bqhYyhneZs=; b=dYvgS+cbwpQ5PljtgT
        6RATVs+IalGFfE1ETQo1I0faIA0gn6fmszpSRV6Y0zhcamGuWfD45fUdAmVVKSdf
        TkMIA0L0HkpGO1qBVv5FF3DNQmvgpw4TjQCbqKucLrAaSZgjwz1dcmHvqthRVsHH
        nCOmJ1dYMRwbQS33EkqOLdl/oUN0AkAEsZUer0d71CWnb0TC+lETZGZAy2xHubep
        aub4SRUJfktnEjTWyJ5DimGSFdn0RmgGkVcidiuxNtQOq7i4MmBUe0b89/30l+bz
        aISO6H2t8JKChUF+rZotLpYbWxzs6hb0Cn6Y352Disjc5pe0sR4UWwUkbRkM763h
        EOuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696504466; x=1696590866; bh=1hV1msyUqkCxD
        erZNF+HO0sEMUNJ0VB2+bqhYyhneZs=; b=bOPw/BjxE7RRc4WLGQDCwR++JFXGJ
        Sg8HrR6wvnb32GQqEWLE0XMqR78mAApIcuW4/iRHFJxZEcXQvmdWj0iLs0Lo1FOw
        9h70ElrBJeTbTynZ/53xLJPPVCyyCtVLYvlJjevLV4SLVBD4Bjl2Impd/IyFO1JJ
        Jky9maH0zKOEVQSQvgNfQanCSbHCxTKCBQ29hMuvGiwqEVJNOEWoXQ54VrtZPshc
        Y/QznrxYiQiYin5VuoAKL28VgLogXunBzHiUL8QgZ7YwjKLprKNX5p2+RbZNz0IV
        M8Kv5nfmtmUFuYIpPt8YDIvCjk5EyKUur7Vc2LEMTPwFMsy1hmAEvHniA==
X-ME-Sender: <xms:kpoeZfgeLgmXmlhvOsHi4csytFXHupo1VAC4PTP6erBWcI5LvE08tg>
    <xme:kpoeZcAbDD0g8bQjE91kIIq1tpuWga51ndMnJ5G-GXbNaNSnK1g_fNwDjJMSIHe-1
    xuhz1tay24lwzllMA>
X-ME-Received: <xmr:kpoeZfGoduu1cLMdKV1qWfXUT7Ozyf3k1_vRXsgvHLuK9-SSgXT4ksIyasAq9f8Z1GnoqZyKIz_G_CcRd-qC3jZoXCpFCSFl7_vxkWLZjnHlsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeggdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kpoeZcTgXd7AdbJJDvHn5Dvg2Q6a9aiCDR_B4rHlr6UCYBBUTu2DRQ>
    <xmx:kpoeZcyP3G6T_wtlU2SYVHzMaIqm8ImfOpKDJyd1nF5aHbZprjwvMA>
    <xmx:kpoeZS4eEVY75jh-5Ix8uFEZ0Qm5oWQenFT_PIcNAz8HW3TcjfYfNA>
    <xmx:kpoeZX9KBYG3AWqAkVqu7jDvgJmpTGnXxJDn2Oip1FeQFpu1ZFc6OQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Oct 2023 07:14:25 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 6bec3f58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Oct 2023 11:14:22 +0000 (UTC)
Date:   Thu, 5 Oct 2023 13:14:21 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/repack.c: avoid making cruft packs preferred
Message-ID: <ZR6ajQa8bh5HKsnr@tanuki>
References: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
 <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GkzOwBwOc0AWNnR7"
Content-Disposition: inline
In-Reply-To: <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GkzOwBwOc0AWNnR7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 03, 2023 at 05:54:19PM -0400, Taylor Blau wrote:
[snip]
> @@ -801,6 +814,38 @@ static int write_midx_included_packs(struct string_list *include,
>  	if (preferred)
>  		strvec_pushf(&cmd.args, "--preferred-pack=%s",
>  			     pack_basename(preferred));
> +	else if (names->nr) {
> +		/* The largest pack was repacked, meaning that either
> +		 * one or two packs exist depending on whether the
> +		 * repository has a cruft pack or not.

Nit: this comment will grow stale soonish once your patch series lands
that introduces a maximum packfile size for cruft packs as there can be
arbitrarily many cruft packs from thereon.

> +		 * Select the non-cruft one as preferred to encourage
> +		 * pack-reuse among packs containing reachable objects
> +		 * over unreachable ones.
> +		 *
> +		 * (Note we could write multiple packs here if
> +		 * `--max-pack-size` was given, but any one of them
> +		 * will suffice, so pick the first one.)
> +		 */

Well, okay, you kind of acknowledge this here.

The rest of this patch series looks good to me and makes sense. I don't
really think that this comment here is worth a reroll.

Patrick

--GkzOwBwOc0AWNnR7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUemogACgkQVbJhu7ck
PpSttw/7B3VlAlShjdXOw24H0FQjjqUNUVBH5GmoOjb/vek+/uZ+QUANhVHGIgVV
QsKJcehtT8Wvefy2w60kxlpIwM6AKwMq8hd4zeUta6rp3IeO+P6XNms7oSx5+qTM
6Y9LPy41eGRBAvRNpB6LJpvdPEFdSVwIKH0si9tW3dh6qHFkRe4s7vMO7gKcAQQQ
kSMwyTFk2puVdiuGtRprFfJhc7mzkXmIjH20qDjSTNKiIznaOn1XIFVlK+sayJ4F
EUDNTqqhoFIkz6qr+0MU0hfVSuRd+n1ty8mqFAC6SXLF4dcrjFVqwYXwVj/BnotC
RteJqsuKIr8WQ4g0haz1f1NlWpHgbF8HVFLGCkrXozWhaC8FRI58ueqDutM/QUQh
S08Xd46b0nAdbEUuwQnFaKGC8712ptQ+0SkRGMS101QTWDM3nQ3UxplLXyq8B9d6
gV0jEg/skjUjQWPd/cK5XkJE1r/n/veNJIjfIUYOmyT47aOOa7EaLuYEXCWk4g01
5KWunBaWXlNNLQtw7BBjnXp+A1RC9Cla0rkMGU/Aab5g4LQ0U81VAuF1la8Vr8DT
nlWcISCJSD1zKEMUFlRhXg8dBmJPEUsPSIsuQClVS3YPz4XtGMuvxs+BLhK35tMY
WkPhJzp4+sruEVfvEeuDQT4tv7obTXB7aZGQDNSrreKFs0xX3Dc=
=eIlF
-----END PGP SIGNATURE-----

--GkzOwBwOc0AWNnR7--
