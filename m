Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FC3C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 15:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbjEIPPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbjEIPPC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 11:15:02 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A094340C2
        for <git@vger.kernel.org>; Tue,  9 May 2023 08:15:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BC745C0170;
        Tue,  9 May 2023 11:15:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 11:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683645301; x=1683731701; bh=kl
        eZded+yYVdT1leiY0fGmBrq4ZWGSNblKPruqlncTQ=; b=ELIuOPzNsvn1aH8gn2
        VcWwEbODTVq2M5lum9RLt6/MGrZ8Vset4L2p7kmaZlhbPGlr42d8yUs1smYipuc1
        VrJ/6oSpxIqxWMeMWoUF9OC3XAsTtUEzMiX3QU4ZOc7K31LxCtiQ2qbCYacIZ1Ba
        sbGjXk6OrjsKLqNZf3N2HVbmsX5y0Fe2Hk3Z7ap/mA/+H4aDaMH/8kOGy/Iwhf8B
        ouapaiL0wjcoZsWkmBGQppHK8hiVgMWsPEVEyamTjqlIickuytMijCAEptgCjmxW
        wVyaDI/aimTXZpBwmhfq2/0G7PSvbYOP8DBAR55s30s0K78PvZ5Gu/vKl+ZncN4j
        ST7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683645301; x=1683731701; bh=kleZded+yYVdT
        1leiY0fGmBrq4ZWGSNblKPruqlncTQ=; b=JPFFXYHmktKDZTColypPtsdbcHKUv
        Bx5QjZp6GLts5gKy6+uRbgpR+OBcejugzBXxDGe79mFjb74ilHilrgXHUkklzvbV
        1XbjNDZU+ZKf8Vr8S0A68uR9MniJ3QpdPgYA4IV8QfhJRSckJXSUj+7MkVO6bA1n
        ELyLnF5nTltzQlxN5+1ofH637APnn+Oll4dBlxsiKUzJE+AldtIE+ylHzxfnAgLT
        31rpUhXteemFxWmAw4K0WD/adebY1yvKZI1dtvFSgyybTWu7fM8TrDq1N/hZzPcg
        S0sOqTubMt/SR/+Jt6HgLw/3ir+jqFXKDsGf0npVBu25dHOx1gRoQgDmQ==
X-ME-Sender: <xms:dGNaZLHE55eOngu7DOvfnfHub8YR3mzhhaKG-nmW_xwg4dSKW_Anag>
    <xme:dGNaZIXhhwE9iKBTum4Qe4FsmSLKuSqlP1zneRHFqzXoLFB8D4c6PcWF8jn7l9v-f
    j-WyO7HAeb0IqrdpQ>
X-ME-Received: <xmr:dGNaZNLbdO8mjLuLaE5nszKoht19Zfwlr1x2Ac50fh4JN0WdlRSsac4JyurwQ7b6RgV974EQ7eakepNF-6zCBbM453sUPfuEFWQrrgQ1aM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeguddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:dGNaZJGwu_i4af0W9t5ZDg2-1yo85O4tEgNw9RvS_-JjCNVLIeXv3g>
    <xmx:dGNaZBU4fEhOZVJYebogywegSGBTeYTZe472leD3hjSKt5kjxWvg5w>
    <xmx:dGNaZENbieFT3niBXFJFYg__dB88KFtF8VKLCS9YWl1YbSoulTDOHw>
    <xmx:dWNaZETGuhVQMXocbuDdf3ghm1IoFJ4dZX10GpZS5pkTQ24nbw4ouw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 11:14:59 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f0f8dfb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 15:14:52 +0000 (UTC)
Date:   Tue, 9 May 2023 17:14:58 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/15] refs: plumb `exclude_patterns` argument throughout
Message-ID: <ZFpjcoylGSj7Palo@ncase>
References: <cover.1683581621.git.me@ttaylorr.com>
 <f437cd83e2d2177b1526673821b950f47814abc6.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8zvsuONZqO1E5Zle"
Content-Disposition: inline
In-Reply-To: <f437cd83e2d2177b1526673821b950f47814abc6.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8zvsuONZqO1E5Zle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 06:00:01PM -0400, Taylor Blau wrote:
> The subsequent patch will want to access an optional `excluded_patterns`
> array within refs/packed-backend.c. To do so, the refs subsystem needs
> to be updated to pass this value across a number of different locations.
>=20
> Prepare for a future patch by introducing this plumbing now, passing
> NULLs at top-level APIs in order to make that patch less noisy and more
> easily readable.

It might be worth mentioning in the commit message that the exclude
patterns are supposed to be best-effort. In other words, any caller
would still need to do manual filtering if I understand correctly. And
while this is indeed documented via `refs_for_each_fullref_in_prefixes`
it is quite easy to miss this important little detail.

Patrick

--8zvsuONZqO1E5Zle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaY3EACgkQVbJhu7ck
PpQ19A/+IpVjmox64+3rMhG+gA8xSfl98Zt0EakIXDD72OArJ/+BS6D3gjtoVIbz
rNiaPI91IyObOKQw1zCZzpdc6pjs9oWEvgAEPFLo64e3P7m2h4i0a6uDBqa2VNwE
TedT2ehv8b0KqMe9frDVzC7dQRrXwArDl1eTy1KeApQwKYi877Mpibhcw5TCUqsn
45aqy7LJ9iP1GaQDhOCzQaIo/J+CVmzwffa06h/g49/tRhWF2jqZbq0zaLT4d/7t
jat8lZSghfIJ3EvaKXL+YRIQrjOCLcOG6npkfC1dWaYNGiHKOwJ3oodGJ7DZ0X0H
MOP2qmhDMdS3GOBNXe6sY6mkvOns22bihQ+8nFnty3tIP9NZZtG8IJ/YtSgqRQpc
mOJJdbvMkR4Jq1TvKE6uI0+ACE2CRlhSM/mWbjNMsmrh5a7dW4/ImLe7Ex8GW8ig
e0TDh4dJ9ahmXBZnLiQy/OIhHpw46UFe4SNZHKtC6OaorUou4jROqdiBOlP75YwN
jJNBgjKpHSwjSxt8x72/s/BwxB4y7+0y9wYxUFaJREjtvUrWXbe1GdYvgS7ieX4z
bwtEOz/JT4pcW0OF/GB7oLQpQzWM1B3hzJnq/j5uC65izdqUS2Q8q0SFojVDNeIp
qBIqpDasXqO1Pmx1bBGiky9HafMLqb4DT+9O5bSgKzSaJr65EF0=
=R0Um
-----END PGP SIGNATURE-----

--8zvsuONZqO1E5Zle--
