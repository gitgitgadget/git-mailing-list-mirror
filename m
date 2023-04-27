Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D99C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 10:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbjD0K6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243624AbjD0K6m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 06:58:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40834EC4
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:58:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C89F5C0221;
        Thu, 27 Apr 2023 06:58:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Apr 2023 06:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682593112; x=1682679512; bh=4s
        ZE+lc0/djbtzhA7DkNHrcqOyRXsAMmXYD6I4D2fwI=; b=qN3p53+xxYf6VmWr8K
        VkTVBCQvo4TAiS3ewxOt4ASP58IskDQLR34bFsuMEWcHbSVtsHYia7chLDR/4qWY
        3thBM0EV/2wtexlCrP/YsWHEtkC66vOKHEEf+UsfvOhO1Mrf3UhewWK93xT+qBgz
        0H1Fyj/5KRZ2qBeCrHXUAVZDgsH+5gffG8LJosFRGpWiaXoBSWWSu2We+QmdMDe2
        Bl2CCkaJfMXCS7L3KjE5cNx3+LKBIVVs8Z0CzfNaAQqWZ7Wa9pRYr8Hq4BB/VrFz
        DHxHEr1v3YwQei8OS8zXx9tvFPHtwa/pSSPszdIEXsh3YV+xiyBtsy14GXnQpAat
        s0gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682593112; x=1682679512; bh=4sZE+lc0/djbt
        zhA7DkNHrcqOyRXsAMmXYD6I4D2fwI=; b=MKXBlDxEJy13M5SxyVnNvhvp91imZ
        YP7V3pBsH2tqod8h18mFO6pSuYrqy2jXSVuRiYBwIOxwBV/cRCw6oKJCjbZZ6YV6
        tW20bN8HsmXKp3mrgC+e9u1SzKFjGD3YQ6URkDrk6i9Aj5tNHm3Q4Q7dsNeWxx86
        iYvmD6+/uEAN/lq2yXqAjKC6JQ5SumA3/oWyRrqL1CqXIGf/XGJKlUGH5KJssFoY
        ZJiAO1Zmp5e75OpmpLxQ/YpxmYpkRXB7sDeSxH0uj5eMibKyMlGItfC8mOzrJRLR
        nYA9EWSw86hp2oJGm3LzH9NVafqZOuhsPDKOgVlFfwGUKDonSXhW9sVlg==
X-ME-Sender: <xms:WFVKZAyA-SBiFJI_tbU8HOPp1_GRJEYuttR7u0TLo7VY_rRv1PnYHA>
    <xme:WFVKZERpTO4xh2HITO85kMDpU5l_yDTs6CeuCxUpo_mCZqoUZVnoLWJk90GYBT_Pi
    bBwnoSPhMTe4z9QBQ>
X-ME-Received: <xmr:WFVKZCVCLBemmCp3BirIVBGUR8oWdW3Eld8QjGU92OSW0U5Qx-zp2Np_xpRe5YR5s_I04Gc4IolbQRuqOIBbaAASwPxRCLmHNBwOdgb_G7Vl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:WFVKZOjTRPb3MjTp1L1oDvM-6eNXJlb1IYpKPnWmOkZkWBGA8SO1mw>
    <xmx:WFVKZCBu1HdGa3PkuRd87svH9FCpiktX7Hl0WKR5whrTn8mPz6tDYw>
    <xmx:WFVKZPI_yqbW0laq0HtH8nVMzo_Cx07aVNzBvu636BnvHYLtbxAe_A>
    <xmx:WFVKZD50W1InRWmBp3oQga_45j0oQNxlVbQg_GAeow5k5l6L5AtRYA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 06:58:31 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ac3a168c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 10:58:02 +0000 (UTC)
Date:   Thu, 27 Apr 2023 12:58:29 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/8] fetch: fix missing from-reference when fetching
 HEAD:foo
Message-ID: <ZEpVVVgFQyrGzHrl@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <596e12f03a296d753ee6fe8face9522edc9e397e.1681906948.git.ps@pks.im>
 <8e08ac5f-b1cb-554c-dc21-4cbd93c348e8@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WGpwwx+bagOBDnfX"
Content-Disposition: inline
In-Reply-To: <8e08ac5f-b1cb-554c-dc21-4cbd93c348e8@intel.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WGpwwx+bagOBDnfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 12:20:15PM -0700, Jacob Keller wrote:
> On 4/19/2023 5:31 AM, Patrick Steinhardt wrote:
[snip]
> The commit message here has a lot of context, but I found it a bit hard
> to parse through, especially relative to the actual fix in code.
>=20
> One suggestion was to load the paragraphs a bit more with the actual
> problem being solved first, before beginning a lot of the context.
>=20
> We also discussed the block of format changes and felt a bit mixed on
> whether to include it or not. It does match the coding style guidelines,
> but there is no actual functional change made to those lines in this seri=
es.
>=20
> I think its a good improvement, and it does force some extra context
> into the diff which makes reading the resulting change easier.

I initially really struggled to explain to myself why my change actually
works, and that shows in the commit message. I've reworded it a bit and
took some of the suggested changes that Glen posted to hopefully make
this clearer.

Patrick

--WGpwwx+bagOBDnfX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKVVQACgkQVbJhu7ck
PpTeJw/+OjApSTFbWXX8/yhVwn2LPLGBHGObI9bTFmuvLzY6CM4IMzIR3/oepPzB
ralyJdK20JPb37PAwg5oIs73BrDlVfOx5knU4BKPOt48EVinpI5lZ+ssB24kUNcb
MY6T9jgjGaIxlfc0TR+4MXn2yCFi86A/Gh5+KZxSyzpqrXR53n739aQunzl+p5Ze
RJcv9KbJ0VzQecTkR1vsKpGmATK/q2B3JOSwqKOUkBDdF82NIGGEGGe70sIGVWUA
VQbLKJy9ZnmK5Qzr8CNHBnVyYgIshM3GpzAUBaHv+dnehfzRQWGcy+DrMmJSNvlN
M3ktCsBoF6eErit7UJzqePIEq55hCBLC7N/2LP4dNB0/5Z2BEB5YFhn9p9mQDeWB
K0QRda+KYGM13jPB2Ye507qiPrI4RBgplw9k+ns2rkwOoFVh9B0KUtADqF5klFb5
VehyMkju4RnfyfqBUeHBX4faWxkdqO0mS7oMay4E46kWbwRUaP+YUHYYUgB0uH7d
DrGn2pV7EvW0oJYvl/UelOpnakQYWnSzD0kZ1CxXUjB9bq5KiEarGzsPmtmDdk5V
mTFKwbnxv6rkiMjb1ERgsW+t0sjT8dsxS+AHJx2sb5YE4DOjYt/GP0bycLkjlbwx
/ShmRhlGJIVJlLHBFEZb+mW7qt1uNL6j3ewPfgxOeeRMpjwoiIM=
=dF+j
-----END PGP SIGNATURE-----

--WGpwwx+bagOBDnfX--
