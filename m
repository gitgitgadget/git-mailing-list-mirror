Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F6C77B71
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 06:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDMGlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjDMGll (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:41 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675CF83EE
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 23:41:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C25565C00EF;
        Thu, 13 Apr 2023 02:41:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 13 Apr 2023 02:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681368090; x=1681454490; bh=Sz
        iBCZgllM4Ilf2uxyN+MKZZR6pz08dbknwuVyrKYIQ=; b=GZpTQGvYzcivGW4+/D
        b7bBxxsHQihmNZ0TwFczWRJUmUOHtgZKojUvTxHIDjkO/tUoZg2IHBYOBlTlfczB
        pK+2sSm1Eps3iowcDqsvQ1kFMGxiWkWDg8/cWSJ4ff/4ZcYPHGC1wisKZI3U4Hzj
        kthTSUWYKmtx8MKqA7TmEpoi4FiksM/u6wLs5lIrcIbzroqrXJO9tTpBAHWBzf3G
        qdPlrLXOuCK2xqPYzSAgjZrAJtGLzEcojqWNPWhJ0WAE4yJB8f3eNiHNy+eu3rb+
        tG8yzqb0Zv1ah8IhnU8UMQ3ajmRJmq2R7/kTh2fWTjkymbab7mTozjmrnI8RGrkN
        AeOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681368090; x=1681454490; bh=SziBCZgllM4Il
        f2uxyN+MKZZR6pz08dbknwuVyrKYIQ=; b=TL8GxK4i8NclS3PI1g5lryfh99ZgE
        iiOnDo/5T+mx1r8nx/NMbH2GCTmX72gSrJLfWK5T+HeICuf5ybzwgw2wVrolyhf0
        c4wRXHk/EEt5VJtZFHHucFv8TVIc1i+nsK+BAckyc49OvucZy4AY3tmxmC4RdECl
        5buqXmmZOYJfPZH3VnIgp4R7tpa+blKdC9GZWiT2x4JiUAWERgWmfzY+k1E2DkT4
        6uDUYepti/JbpMX5YYubGsnxrndOlfClqMuJWvkguiAb+HqnpjKk6AjP/N+WX4m5
        se9sP2P/jJkWGGkhA7/rq7tokE84Ft/Ydsa8aQs1HaEx5ADd7ikGhX08A==
X-ME-Sender: <xms:GqQ3ZAOdw54R9Je3DdevTVbP1xhuj5D3A7o_QWQC6rLZ1t2_fTa2jg>
    <xme:GqQ3ZG-oFPlhHIUHzzvRZy_Bib8CtDa-YtRv1hDvlHwTywLZJ8Ui9qLITs-H1AqKU
    k_eh3Pq1zcdkKPuvQ>
X-ME-Received: <xmr:GqQ3ZHTJ0xzYrPemHyQL4Lq83_Y-druq823s1dNAkbwwuo_u8ZOJQv7gGKjhQSunRl3oudevni5_wr3qi07DMPDTf4RTFWlmmEZe6Uu3BnNvKkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekjedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleejteffveehgeegteekteeiudeiie
    eigeeigedtffehgeekhfejheefkefhveelnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:GqQ3ZItq_iDeeyYBpYNxkhhrMNVu6v-r5WsQ8MBkA4k49SnNA_mIcw>
    <xmx:GqQ3ZIcDdJ4XKYS04_PUrEiKqUVBn5Omh3JdPw8AsdSlO3zcniLdSw>
    <xmx:GqQ3ZM1m64W_TKKOx2zpK2dra2MOS132lQVPVYdN2eg8-tDqPfYyMw>
    <xmx:GqQ3ZA75eoweZpAon1TAIFO7hbDUSrcG32a6jGtpkXRV3Mgb63aILQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 02:41:29 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 04a8a197 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 06:41:04 +0000 (UTC)
Date:   Thu, 13 Apr 2023 08:41:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH v2 7/8] repack: honor `-l` when calculating pack geometry
Message-ID: <ZDekFNg8eXr66BHl@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <608dde4ad52c28ef42845b6bfdcb168e252bd29b.1681294715.git.ps@pks.im>
 <xmqqr0sozmc2.fsf@gitster.g>
 <xmqqmt3cz7rp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GetrKgvy0rkuGbQ0"
Content-Disposition: inline
In-Reply-To: <xmqqmt3cz7rp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GetrKgvy0rkuGbQ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 10:11:06PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Worse yet, even when stat(1) is available, when running
> >
> >     $ cd t && sh t7703-repack-geometric.sh --root=3D/dev/shm/testpen -i=
 -v
> >
> > in my environment (based on Debian), the lists fail to match at
> > subseconds.
> > ...
>=20
> A CI run of 'seen' with this topic fails on macOS:
>=20
>   https://github.com/git/git/actions/runs/4683726291/jobs/8299125722#step=
:4:2090
>=20
> Almost the same 'seen' without this topic is CI clean:
>=20
>   https://github.com/git/git/actions/runs/4683470969
>=20

Thanks, I'll come up with an alternative in v3 of this patch series.

Patrick

--GetrKgvy0rkuGbQ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ3pBMACgkQVbJhu7ck
PpQ9xhAAkdz23JT/hcLYyxo+YXl0Ga9VltylYHMI/hU3RsPZbXABaJeSsWgM5/et
HZz1jlzLF632HAhRl8pxO/c71vsamm5eWDJcAhh06ewGDc4eWFtF3U+1Q3L06lGT
FHx1tw5sZ0oXx11a/0PZevpAUU2sPhDtcF+24Ul/ASEmdBPoLWt1N3fqpsYd3ljF
nmwqoi26fFviTIPz6NCpPL5Q51TOE5YiFmIvPcY/Wbm9pmWNO6was2aF0N3qWPoW
rnDz74aGd8rK0CAQf9wuQ5gj+kXrwu4a3/9Rlk/enUV4P6rVkPBM7HN/gXinkWkR
fVtTxYHwPWbnzzvbBZmUNKe+V7obImgUWml5617J1oCnArIGw15rWNNoZUDShBLT
bEA9mWK9hQ2+xURHr6RCPzSwM2V5n7bwmovkH3/Vficv4MR8xVwpH+JHAgLkM3qN
/AbQozC/9hwnEEB6MpmUP4gQrBWFljb2BUp55FO3h5vye9q+t+ALrCo1TJ+1HpTe
dw1v8LkMJaGgzl4ulhBdxbfSJl3VqJPWC9i/z3sfwRpnBmmAsd/dfZZHxa+NC2LR
oeUkB7cYtDzdxgvKD7awOqOZU76vtvF8vDNwv2ttv/QdHrVEiFz8t5+/oGvppo+k
2TZ/PlOGzRpAPjmPsejAZ8U5ZYTv1tpFB1OPa6SdXQiEKMH/7n8=
=2lfH
-----END PGP SIGNATURE-----

--GetrKgvy0rkuGbQ0--
