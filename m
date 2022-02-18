Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A5DC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 06:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiBRGuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 01:50:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiBRGuU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 01:50:20 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE9BC33
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 22:50:04 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 71B3C5C02A2;
        Fri, 18 Feb 2022 01:50:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 18 Feb 2022 01:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=/7pBwHWE3NWbAyD+yqzrd6akcv8Xcu6HX3k9VF
        ZY4C0=; b=GTYWoWKluJbJCnpur85l254IJsP+ItmGW8O/40mSgf8dMkyorhNW64
        0I4yYUu/lfP0W5lQUVhLaOvH15FMfq9cOvJOQsRRSWuOTBx3xnFvu0HfEZ9L9qJ/
        uVaGx85Tb4hUIjEeCKA05fRFDhhNJ+5oyYTFgXbFWJkKBXFnBQM9/EQvTGbLTr9n
        4oG8OnthyleG+O0+P8j/Zjt71JJjlYJ/ArcBI5bAMUGdl5aOZSN63mFLkzNklnvc
        1RXYWU2Gld/wd7QaU4d0j/buaPe/QsInSRCRSGo90lk75YB9xnHnISh3QF9krHK+
        dwhkU1a6/UAU0rrpH73o5OW8ZgMdd3fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/7pBwHWE3NWbAyD+y
        qzrd6akcv8Xcu6HX3k9VFZY4C0=; b=T8tvrY0WBcexx2ZnnnzwqUAsDmfHhtZFI
        lil3JN7r4R1WmavQyz47qMNNiPJQ4ot5/lmbQECNauLV2CzESmaQw0Nl4jibaXAs
        R+kzLzb+pN3pHD1m+jFF5vK5Rdj24M4OaEgC5uGTDu25PAXXbEGoNfpxHGsESW6K
        h94MgTUuxyW1na1jcOCPLv+vWpB0HIR40cZ2ShJp3jsiaQxCgE2nUheWlOfOMMDd
        g7sFyySxWWrpnoKT10I9CskiyVI24LHIizEUXfbZSztbOo0ZgZWESfP9s5JEsIrQ
        Z4uEq3l4llm3T3ayO/mQ420D0+aTXpIhi1L0Z4IBZFafozFU23O8g==
X-ME-Sender: <xms:mEEPYmBFIP3bfMy2qq92zHeSkVBsgJSZzy43gvhv6HMYvlSqnrxmxA>
    <xme:mEEPYgjmh0HmrphaS-YUwcIbwDlKN8q54OU7dpJy07SyfbrmUfYwe8kPGhycGGcWg
    9HtbOrIILQ9-o9tag>
X-ME-Received: <xmr:mEEPYpl5SPYp2FBUeBiUn6rSrMN_5ynLs8MTC3qUctspK5a3us5l1Zjb3tyxR-uQ7ixNOvLVYghPIljcfUwdcdZ6MM6pUF3OjUFPnQuS02F4J6q6TGnYtXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:mEEPYkyoCgaIvoE7xpZR8us8y9z3k3ymSgUZH1sh3zgYb-7gSnGkfw>
    <xmx:mEEPYrS0EXBOJ0S0GEQ2JPXWBFwcamgfmQssidRB35mDS_2zd-e2sA>
    <xmx:mEEPYvZEus50c3v7UiygdwmNajZrYL8-e-Qa-VzeEzplAipj7umNIA>
    <xmx:mUEPYlcTDv4P3W_4cG0obTpfYjp37xOILT7IpLI2i5jt-U_H64FcTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Feb 2022 01:49:59 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b4546a87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Feb 2022 06:49:56 +0000 (UTC)
Date:   Fri, 18 Feb 2022 07:49:55 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/7] fetch: increase test coverage of fetches
Message-ID: <Yg9Bkyp1EDvOzzOp@ncase>
References: <cover.1645102965.git.ps@pks.im>
 <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
 <xmqqczjl8buq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6FH3h8d8t62uOwAX"
Content-Disposition: inline
In-Reply-To: <xmqqczjl8buq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6FH3h8d8t62uOwAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 17, 2022 at 12:41:33PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > +test_expect_success 'atomic fetch with failing backfill' '
> > +	git init clone3 &&
> > +
> > +	# We want to test whether a failure when backfilling tags correctly
> > +	# aborts the complete transaction when `--atomic` is passed: we should
> > +	# neither create the branch nor should we create the tag when either
> > +	# one of both fails to update correctly.
> > +	#
> > +	# To trigger failure we simply abort when backfilling a tag.
>=20
> What does this paragraph want the phrase `backfilling tags` to mean?
> Just from end-user's perspective, there is only one (i.e. if an
> object that is tagged gets fetched and that tag is not here, fetch
> it too), but at the mechanism level, there are two distinct code
> paths (i.e. if OPT_FOLLOWTAGS gets the job done, there is no need to
> call backfill_tags()).  Which failure does this talk about, or it
> does not matter which code path gave us the tag?

It refers to `backfill_tags()`. Should I update this comment to clarify?

Patrick

--6FH3h8d8t62uOwAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIPQZIACgkQVbJhu7ck
PpQ5jBAAp5+pCoNp4oW8+ojbAzLjfWWXudI5sNwfwLJZxhZOKJMsKaV8KRKkK8Qf
1FvQ1ltctn0UX/kINshxV4nDcip3An6A4GeW5f9+OqtxGkH936CXscP0lul87g6g
TS5p2eGhKQlmJRQQLL1UA/JWrhVGOB3egC44aY+V8rG/eq++EfiiM0tpX+keM8/K
MoF7cINTYC8Ych9NXy86PF41eVX8PRBqKROBfc3gvr+7OA1kpyGM3TeNsgYNz7jk
+6yaWei8MBQgkk1T35LH9nCZ7ReHJDB6Z9c7QoMcQ21IarEytQtMcffueTgFICT5
1gDEkNrRBduAZVfs3h2H2nFmY6YLP8kiJQwn+3FybksdIZ/h+MVlipTIQePeHpDR
eIoC+5saCoCjQ55twYieTDcx4MD2ol7GWDjO41QDCXRAmo4w87f+qmuZm0eMy1Xv
Jj+bcrIAQZ/cSPOu2pczxrL6zHKaPlk5ftl4TlaD00YYebb7WDD3D5zJt7/Q970T
KMeGb28PtUC3sF/hfzfdMmUTWCI+z+5TaElaff9IsTwYy6dkJqUG9BCPWSctEGZg
inb/6Yd9Pve3S6tUJOtYe5tgbbCbuFMDVzkcA0AJ1Oq3URZ2wRHKG9IQk+uzv+HI
RdHM/zKJXh4Qvvsoq2L4kBiXVVIceBZOQ7vqeeYlqLaRonD1Zr4=
=BEzO
-----END PGP SIGNATURE-----

--6FH3h8d8t62uOwAX--
