Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC22C7EE23
	for <git@archiver.kernel.org>; Tue,  9 May 2023 15:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbjEIPQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 11:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjEIPPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 11:15:55 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81449D5
        for <git@vger.kernel.org>; Tue,  9 May 2023 08:15:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BC89D5C0120;
        Tue,  9 May 2023 11:15:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 09 May 2023 11:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683645353; x=1683731753; bh=Gk
        6l7yJ0cZv+uj/R3Gh7pwaU3lKyrapn1ro6xxI/trg=; b=f39m3R19ZxLJSuwIZm
        Ljv0BmLU2q0MrSWvyoV1H1dVO8fxTXxZZ+JdTK0pF7qmNMmN/apop14Hk2PyWRod
        QXkH1CiU1IsuaAk0b8LTSZJ5LGq3oY95ithr4iPiQ1+rD4N8lYbELhn7HekfwPrm
        GNwFGDajB/NSsKKtVtUxkDTxG0Vk5QiCWiw+oS85Pg/GKguiwbgvteAthqH7bqfj
        NqMEvFyCMO2irrKpwoz8HWZHmHkKOxQnKxolWlxtbPm9ZZEUUfcpRVxfoe2KwzP9
        JZiLBFE1Gn7OQ97II0hcHR50bzzcZlDv/mcErXUGpno1t240lpkYaOrFWjox1Khg
        jcxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683645353; x=1683731753; bh=Gk6l7yJ0cZv+u
        j/R3Gh7pwaU3lKyrapn1ro6xxI/trg=; b=ZT63bxY2lWqbKyosZKOMeFQh5Fh7A
        eFEBpG45/cK5T79g7dgIq4BW7PRqA5jPpz2JpLBkNDv7sJ74+Kx9w+1E3yPUQXq6
        qj6Pm8zxsblVJOd51wVpJn2fXuU+erwEhqOPxkUxlF4U/iL5z91c3MNzJ4ydomwH
        pog2K2l8fXa5SScMl96mGJPHOmOzdt+jFLfkoNF3IC28dTaYU4Bvgs0IKjidH8Iz
        HT7meKkKo61ovWpD2eUwMEJeJwAoEkKdoG7Jq7Ph03lZOQxii9INd64TzI3z8DKi
        hPIkjdRS3zcQCNPjHD5hF04KjPMgdD1yb4RNINockFkPTBlnAO2HVWyeg==
X-ME-Sender: <xms:qWNaZDR5HeEbOXX319vOyrr01l1setaQs8KbVoLHQWUk-lkBV3TD-A>
    <xme:qWNaZExvV3AbWbggm_MhVDQVf6FDCYkh5-2uoxoc_7ksKRPPt8ZKwWEP4w5jSYS74
    Rhrbd8uogiXZZRUnQ>
X-ME-Received: <xmr:qWNaZI0DqdzCxpf9nz6CDGjeq7zI1fEaLTSMeFhO3qo9Cvx6J2VHQMPDZmX87RzXSwZ2YLcOzIOiUTkcpbDue3Q0q0EmCj-SVK8ZsZGA3Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeguddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qWNaZDCdBp6KcfOOY9ClBccJKaEBaf75huAKDB099QcmhMXIsTyIuw>
    <xmx:qWNaZMjRjf4we-gM9DOnMrbGGHqqLJuFCOo9Xjtiie6FiaxtLYQysA>
    <xmx:qWNaZHqeIiIcgukNrEc_1uRHrrIwfyQvaHpQKqPL_7o8icz66Wv7NQ>
    <xmx:qWNaZFuZLnrhHS2D7ICr3zG4-evM8TDDlONSUOZ3RLWrkm-HjrhTsg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 11:15:52 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 9a517530 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 15:15:44 +0000 (UTC)
Date:   Tue, 9 May 2023 17:15:50 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/15] upload-pack.c: avoid enumerating hidden refs where
 possible
Message-ID: <ZFpjpsmCxDTUG-z3@ncase>
References: <cover.1683581621.git.me@ttaylorr.com>
 <44bbf85e73676b2c89a82c09f7d355122ce6e805.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vXXXO7uzJAmdMghU"
Content-Disposition: inline
In-Reply-To: <44bbf85e73676b2c89a82c09f7d355122ce6e805.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vXXXO7uzJAmdMghU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 06:00:26PM -0400, Taylor Blau wrote:
[snip]
> diff --git a/upload-pack.c b/upload-pack.c
> index 7c646ea5bd..0162fffce0 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -601,11 +601,32 @@ static int get_common_commits(struct upload_pack_da=
ta *data,
>  	}
>  }
> =20
> +static int allow_hidden_refs(enum allow_uor allow_uor)
> +{
> +	return allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1);
> +}
> +
> +static void for_each_namespaced_ref_1(each_ref_fn fn,
> +				      struct upload_pack_data *data)

I know it's common practice in the Git project, but personally I tend to
fight with functions that have a `_1` suffix. You simply cannot tell
what the difference is to the non-suffixed variant without checking its
declaration.

`for_each_namespaced_ref_with_optional_hidden_refs()` is definitely a
mouthful though, and I can't really think of something better either.

> +{
> +	/*
> +	 * If `data->allow_uor` allows updating hidden refs, we need to
> +	 * mark all references (including hidden ones), to check in
> +	 * `is_our_ref()` below.

Doesn't this influence whether somebody can _fetch_ objects pointed to
by the hidden refs instead of _updating_ them?

Patrick

--vXXXO7uzJAmdMghU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaY6UACgkQVbJhu7ck
PpTRdA/9H36dvL4tQSSvGJBE/tamXaB/MmmkoRu7YXZNZiT6y99ingeHNYhYPBxO
GS064afsIzQrg+59yChpOjH+GLpF/L+0VfUHpInL+Od+I9Ph8YRu5OQFjA5lGrbo
VMKoMEipkalLN+uRD7tZ17FWS5StUHVx/RAX5p0C3D1vbZrPH5vg48hUzVYsnISw
jwWEZYYzNMlP2frtiNXphxLSo5Rba7wicf3wA2WK+wrQm52UrOepgAQdQL+F+8eq
URMvgCZ3N2sRbzqgTXrTr6+Wnw/9RCu5ZxvR80o6Oh9qK/Mnet1aAGNrvQTcs3Xc
lkxo2cO4pmTMJe/3tnu2Q3wpnPeB+ygH5bpVt51J5/UjcRI2PM6iNB84vYfSorcw
R2G+DnL3j87GGSQ13T4feqX1U6IEI/Yxj2iTUD9FkZ4zCKwp9UgBL0DAYLuhZjYG
vjHkd5eTqb0ayvyY4KXpUJb/7Hzgkzlo1l7dGatnIvuogdBIE80iGF8BX6yYkFDO
0gMvwJ3yEDti8Og6F+gfK7jOlxfdT98oQrCMjs/F/RZF9NOG9CuO1H0ABTpcfbzx
l+t+TUrY3KH+yrnFM3V5yrMaOZialrlF9NKDYuWqp5uXpR6blGf9uViRHp2Ee8Yr
uNfGNzvc0pcMdFDHKokLOpZxXyRoWAIxS4FZq/1lrfUy6rpwjM0=
=wL43
-----END PGP SIGNATURE-----

--vXXXO7uzJAmdMghU--
