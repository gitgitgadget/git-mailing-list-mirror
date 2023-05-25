Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD6C77B73
	for <git@archiver.kernel.org>; Thu, 25 May 2023 05:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjEYFtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 01:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjEYFtU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 01:49:20 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED6A9
        for <git@vger.kernel.org>; Wed, 24 May 2023 22:49:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 80FDF320030E;
        Thu, 25 May 2023 01:49:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 25 May 2023 01:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684993755; x=1685080155; bh=5w
        bwzkHwFVEsmHTEKcYRKRvVta/7Xw8qEoIj9XIoUXA=; b=q5Q5d6KGJXnCotFHSj
        87HbOwltp6cT5Pj8CUiGPUejmWwqf7gAuOR5EXnEbNcA6KJARZNsiFYRHnzlIF6z
        2yrn71Yfz1ilO5FC5FOoNc06u3DZ5+oDPpWeH1Mn14FdPcJ5ojlI4Xjwnh3X0AlD
        /U2fVbLtG1H+i//5KbsGUrKW4n4AhqZWMNDns1L/cZ+tS3coELhuTQGGfOQfNRth
        QiyPlY9ciRHoCPcXneQRjTUJGH7BzJR7N9IELnATwelGvVEy/yhtX2ZrK3ifqoSd
        RRgWWLlX+2u4a8pES8aDKQrie6OX/iHkfh8KDnjvW0BufNZ5x70rd47OnTX5vVCM
        4xNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684993755; x=1685080155; bh=5wbwzkHwFVEsm
        HTEKcYRKRvVta/7Xw8qEoIj9XIoUXA=; b=IK50ukpy0+zcAwADmuATXTDnliYYn
        21Gj7KE+Q2tZ6PktMSkAHq3i9u8P1JEhOEijEUyexGo7LBHQsLOBq3NitBPnNFMo
        mgT3tT0GAasfGn4l2Oh2WN2SZEMad084i5ndU13Yhq0wPbnn536/wIEJOSqWyAo0
        HkP/agM+eHzGR7ElL7KG7t1bfVBxLhFyMbdvyCoVnka3jNuQoyKZBUH3VegZhV2T
        tH7hIUN85L+8oNJZ6AnRQrqrZZ+uooIcqDrUyVxB3eGDzi9E06yWheCharIaIz5x
        sMdS3ConD1MMtNc3m94YO8PblErNFmqAl3GE1Vf+exP0MLJNjrkLiEn3Q==
X-ME-Sender: <xms:2vZuZCWf40bq9rDlBn0yDEjBE73S88djr-4cKY20G1KoKMBptnofQQ>
    <xme:2vZuZOkc-MNwFOuBki56IYMHautm2EbA_FyPhy3QA0pPepHANl1eHbcTZLNr1McMx
    u0DYXdzIITEBQJP9g>
X-ME-Received: <xmr:2vZuZGb9yQYRh_I7-QeMk9e8In_3XSIvkpWjFIvxFqxJhEK4Wu1pLiLZr5HUGJprHqY1q_XkYLm5J4XPIOs4eZANKQbZw8UB7JYN4YHpTSKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejiedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtieetveevudekkeehieeuvedtiefggf
    ethfekleegvedtjeeuleelffetueeiueenucffohhmrghinhepphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:2vZuZJX0lbCJHPtV7y_XTARt5gnngtXZscabwVd5S3AbUOge-hgi8g>
    <xmx:2vZuZMnFNtUhxgaBvxoDgTwEZJh3l8ocDZUQsj5kVE6Pae8btaUtZQ>
    <xmx:2vZuZOdoNyJsqFjrWIldnfaXVaLZeHvoDEUo5KgLyj1jtqshaqeJyw>
    <xmx:2_ZuZDshd3blOwKyV0x02Zn4WAcfArzD4yG2AKCpyw8AXqb_A13b7g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 01:49:14 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e4a8ddd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 25 May 2023 05:48:32 +0000 (UTC)
Date:   Thu, 25 May 2023 07:49:09 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: ps/fetch-cleanups (was: What's cooking in git.git (May 2023,
 #08; Thu, 25))
Message-ID: <ZG721XuLAXalYqoL@ncase>
References: <xmqqzg5te4bt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WgjiYwSBvLxvErcp"
Content-Disposition: inline
In-Reply-To: <xmqqzg5te4bt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WgjiYwSBvLxvErcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 07:45:42AM +0900, Junio C Hamano wrote:
[snip]
> * ps/fetch-cleanups (2023-05-17) 9 commits
>  - fetch: use `fetch_config` to store "submodule.fetchJobs" value
>  - fetch: use `fetch_config` to store "fetch.parallel" value
>  - fetch: use `fetch_config` to store "fetch.recurseSubmodules" value
>  - fetch: use `fetch_config` to store "fetch.showForcedUpdates" value
>  - fetch: use `fetch_config` to store "fetch.pruneTags" value
>  - fetch: use `fetch_config` to store "fetch.prune" value
>  - fetch: pass through `fetch_config` directly
>  - fetch: drop unneeded NULL-check for `remote_ref`
>  - fetch: drop unused DISPLAY_FORMAT_UNKNOWN enum value
>=20
>  Code clean-up.
>=20
>  Needs review.
>  source: <cover.1684324059.git.ps@pks.im>

Please note that this series got a Reviewed-by from Peff. Might be that
you consider a single review to be insufficient though.

Patrick

--WgjiYwSBvLxvErcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRu9tUACgkQVbJhu7ck
PpTDDRAAoF3i+aKZ8ydjfj3Rhge+e717/xjMSmi1iVnGaZUnBUfuNl6jPHwIU20N
EiY4zN+Mw0H5FXG0m7tJvXdWdtd5akrH5akkPWIjE9eal6lKWqrPgbNtvn6Y+MTl
kkLAEQMUVDRMHl67RqVk8O3gaTtAVCyN06iWVgAW3ASlitfp+Bc9oieW2WuWKatg
xi9+yZ9Honzidv6E2BUTRqcRAb3Z2ux4gVeisQRll6RUaxcm7KxzanIeNqI1wIXQ
MJ/jpwD6soRgRlhjBel6UkdQmw3n1nrBBsUfIs19TmFrMYLj8NOmfIUCawN0PnL2
s9+VBZy7MF5SlscDg9rT9WxdBjLHK3JMTltMMhTQec50VTpKRFZurXzDaAFHziQT
PTIHnJW2ytrZTzSiFy+Q/aiULjQ+TobcYbmcgGgvxkAu60yqOM55Ct65kz42p0KV
LkygZ/OUJdXuPVWGWi6Rpzr3b1BZN+J8xwKwV/MlRunMKyziijzrUJkvi6CE9ITK
GQZQ72J0pI1uFKQWMHHCQY5G/CjYA7duukHxZhH2/7ty0TO+UvOzTdO+PoONvFi9
yENpZ6yfjP7vnvdKbbZT6qczOcjHkgTJVXPQJecoahHJ9sLLvapwuuhVTdPl8Xor
rPxk2oyP91tv5YKv3zEkK39YsO3gXEPNxqJZgLkbSMpdY3kwrvI=
=DMzY
-----END PGP SIGNATURE-----

--WgjiYwSBvLxvErcp--
