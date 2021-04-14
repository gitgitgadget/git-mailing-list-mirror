Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58B1C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C483613C4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347339AbhDNFiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 01:38:08 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43385 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345172AbhDNFiE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Apr 2021 01:38:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C4C85C00A6;
        Wed, 14 Apr 2021 01:37:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 14 Apr 2021 01:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=m6SPold0HJyIKwHzVTVbRhWR0nt
        rDUvSAInTpf+ic4M=; b=EvSrWBckiwPa78ZBchyK0HAD1KhOdP1mACOeEhNRYRm
        yGmxlU33wCR5kxmPd9jW/RdjrC3nz6ZfVIh/Evyeqqgj1keqjovnnrjwfdQuiCGD
        L8W3whvCWWpTEGAwDR6HM1vAHz9g8T8TaLb15Z9ul0ZpHhKNSvKKu1I3NJzBCCWO
        fIqyPdWkBozylDDBR4Z1IZ1/cQrLW3HGKHp2mFMpPpBimbllf25NfjZZXrOP/igV
        nmFdkLajEwmOeY8D/tPta5uITpxqS5H5lDFNaBiTCLJgS6aoLfqhI3XF+GdXc4d6
        +Nv3PAx+Xl/ZgSWqCJdnuTMqO2JO/VOFJTflBPrCErw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=m6SPol
        d0HJyIKwHzVTVbRhWR0ntrDUvSAInTpf+ic4M=; b=l8ackg3wLt9VvGh6jCIJhp
        fsFs54NuU+RvJMei5iV9cERSRKqsx1gQXievIE8qaMNLz+1arTK8CcEKMdzLT7fM
        objpjHG6hxvQHwmGiB7thNbjI6nF9Bf71t9JGBfV0/VNsc3t017efagGFK8tpuI3
        QjY6ZM7QuUrK8rUI6mAWqkGFgasa+vdHLK8HJw96rHsp1f/cWoxEV2khLM6oxS7X
        ZahSIMINyrVI2QpH+tRWXaLOcnVm+VtmxqikHwhxEE1TMbF80RhEBdcnSQldYvYE
        x6yivnrwfxvpgubbiCwZHU7PT1VKb3GFOH14hZFVWqefW2aIWo7oQVZyQxMa4VuQ
        ==
X-ME-Sender: <xms:p392YNU68i0praSgAmj5UPnOdpeIM26V-XC6ctNrtzS_MYtVxKpsUA>
    <xme:p392YNmGUGssfio2rrZ7qeyI1e43APmCiFSjJKp02MJRe_W-1HUtcQm013eFdpued
    3iMKHjTNqy-19Sk3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeltddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeegrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:p392YJa43H-SPHpwrhAIKwxIjSB-wOAHSxVH5z1GoGgxMiDKGpHvqQ>
    <xmx:p392YAXI_EH5fCRoAx7nRvY0EK3Kw64Az4gdxSV1dbvZZ-6dysB6fg>
    <xmx:p392YHlsNSvqyps-IfvFuB1dYar7ryc6kd5x3syk6-aL_C2NVvnEVg>
    <xmx:p392YMwvilH8LMjq7YDI9PcZdFkcY_RXZOHdr9UD_3w-fTGR6U_7wQ>
Received: from vm-mail.pks.im (dynamic-078-055-034-106.78.55.pool.telefonica.de [78.55.34.106])
        by mail.messagingengine.com (Postfix) with ESMTPA id 498FA1080063;
        Wed, 14 Apr 2021 01:37:42 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 47e953b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 14 Apr 2021 05:37:32 +0000 (UTC)
Date:   Wed, 14 Apr 2021 07:37:31 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/3] config: allow overriding global/system config
Message-ID: <YHZ/m7Kcoc89l/Vn@ncase>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
 <xmqqblaim5vv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sEST0JEx9gU6dM6+"
Content-Disposition: inline
In-Reply-To: <xmqqblaim5vv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sEST0JEx9gU6dM6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 10:49:40AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Compared to v3, I only dropped the special-casing of `/dev/null`. As
> > Junio rightly pointed out, the special-casing was incomplete and would
> > have required more work to do the right thing for all cases. It can
> > still be re-added at a later point if the usecase actually comes up.
> >
> > Patrick
> >
> > Patrick Steinhardt (3):
> >   config: rename `git_etc_config()`
> >   config: unify code paths to get global config paths
> >   config: allow overriding of global and system configuration
> >
> >  Documentation/git-config.txt |  5 +++
> >  Documentation/git.txt        | 10 +++++
> >  builtin/config.c             |  6 +--
> >  config.c                     | 41 +++++++++++++++------
> >  config.h                     |  4 +-
> >  t/t1300-config.sh            | 71 ++++++++++++++++++++++++++++++++++++
> >  6 files changed, 121 insertions(+), 16 deletions(-)
>=20
> This round looks good to me.  Sorry for suggesting the "/dev/null"
> thing in the first place to lead you into wild goose chase during
> the last round.
>=20
> Will queue.  Thanks for working on it.
>=20
> And thanks for reviewing, everybody.

No worries, and thanks a lot for all the feedback!

Patrick

--sEST0JEx9gU6dM6+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB2f5oACgkQVbJhu7ck
PpRGTQ/9GcMDF8nIkGh0ZVXCLMuS9lIamOEYwnV/1LIrWX4ZG3A/Xt5fLkYCbbP3
kyIH0r8jjMWxde2QaUQRUuSc5f+qzcK1rhi+mSkInIqu8A+dD6w0mDn7oANjFDb3
mlMQqZk/c/NU5cvnzFi/AP2Swca/K0ULXTFwhjLYTqxkd+Ie3dMNAOiTXzKioUwL
LjpI4ZfMCso4ClaUHYkLeQn7zdsLNKTbQmWp/saxtQxTEbpengRX3hoxN5noTjZh
4uQw7d4O5lKzARAnOmLyn9203rK/WG2yrUeY3YBeH2uWHeiDBo658ee/STRr7NGV
IHPorl/8cX/MKEz6SdMFU8I3YzZ72EPryRjsKgiK03rFlAjSaOheY71QJ+3kM5Mr
DrRi2KNn81YPN/yf1lsLsvx12YMK8hjYZ15vXAdVcL6mkAq/hKqkF9QOHN7yJmoi
e5+H/YCiQH9xTVHgxhN+BNLLtRCx8MmjZR7cidYkYYddHSDDi2qDVzn/1gu/5cJX
JSQIcdiGtnjCgII69YIZsH7mUG7ehX2fxKnRj7tYci9T/jTi6ixGtfIgAH+v7OSR
G7y4phPs4vU8zcOsVfxzAjvpElXXIsmgpS0Sc8tBTUpx5uWEKeYcQouAQzkBdhyI
X4l6orY1S1blwTpX6lIzpNonb7ICmVoIAive/x3QSDvLmdDZwkg=
=h5CU
-----END PGP SIGNATURE-----

--sEST0JEx9gU6dM6+--
