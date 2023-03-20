Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00EC7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 12:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjCTM0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCTM0q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 08:26:46 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD4CC16
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:26:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B9A7E5C0118;
        Mon, 20 Mar 2023 08:26:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Mar 2023 08:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679315204; x=1679401604; bh=Bv
        F39l7z24ToF66vA7uA7tsGFk8RKMTguo6BI3vwXdY=; b=ozi9u0KVIZWOjoqjfT
        Es/vRMv0p48//gmijY3Q2cwcGHMpB5DQ4xPypzaV2VQxqkOcXCX6zTsdCUrVfVFE
        QbvJgSKNdLVNVlbxtr+OEz5CHM0E4vN+MN2OQu2Wt4kBmlCFynbtdao/5P+SU0Eo
        BcVQNy23iONmdIhA2955D/6uDVXIUiH8ki2zTQJgVMSlWnt0sy8PqKVFfCeGiyCG
        UuvuJvC1iSuIEPihdYoSiVtT6qIvTfFxLSv/mX0LeHhHpI1LbUkIFTpXz99PoZf4
        3Ij3TpUonep+N2rZ88+GoejaX1SwYXEqRVdJe35bLZeYpx/mVIlQ1nd+yFD9pDP3
        6ZUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679315204; x=1679401604; bh=BvF39l7z24ToF
        66vA7uA7tsGFk8RKMTguo6BI3vwXdY=; b=l2VSsTyCb6d22/K2kzy5oJZecP1KT
        6/S58Wl9F1s9UpfGE1klvzfIKJjvn3oDDQMMcpcJSEMUxI5Gb21LaT55urFvMxjj
        SFzDo/AHE9n/JZniB4o9wJgilBt9Lo0aMeDO3P0jjNYBou05owA4nJpQpyav0Gd+
        G3QE5y7VfVt0EH4323F6ERJ276jb0FymK4Txck9zgyhp2vbEwhddpnXwcjrTHztt
        Id7MAzA3BWvRBv28hlqFVRFEtYNbryg6BNFJgGiP5zH81xeOSsnFyvJXfTMeEvuV
        pV6ejuk9FlGCUUDCzIqHv5bOBatiJrrEcT+3eWTn6ze0qpWdqQJU2I/Qw==
X-ME-Sender: <xms:BFEYZIEWh9oDxZIcf-9DiJflHdspFKSWTelr7mPA29VSVgDxtJkUaQ>
    <xme:BFEYZBWXnk4A--k-YJpYyMPp4NGi-EDESmdQZf1cWuGhRe-_WXVsKtqTFuQ5CPid5
    1YWlfzTu9ZQgkoX3A>
X-ME-Received: <xmr:BFEYZCKK_2mmH5GqQbD5gNNRrqe6f2KYnkVqLIAacEzvYNdyhBcLrEua4A98G2fohC-7uD7M7SlPnv-TWecdznKpeYUElgCe1y5IT6DsHpYcJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:BFEYZKHII9DI7XMs_jdOH2wrP55_ZfJkBUPo0jKUmvW9l99vAraPiQ>
    <xmx:BFEYZOXWLJRV9i8Jg8qQjq12B6Zv9vigf-m8MeUEsjwRdArvCAgRdw>
    <xmx:BFEYZNPZK5I1vjR4xAPfD_lkr4n9eTY2wSpxB-R8NVuY7mlqSUR0_Q>
    <xmx:BFEYZHcJ852ymmRWCzWMgS7WMfxtpXEX2T1FFny4FdhciXYjhMwitQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:26:43 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 8b80dab8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Mar 2023 12:26:08 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:26:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] fetch: refactor code that prints reference updates
Message-ID: <ZBhQ/z7mUxa/ly95@ncase>
References: <cover.1678878623.git.ps@pks.im>
 <20230317202449.1083635-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3sXjUeqGEmBFHfU9"
Content-Disposition: inline
In-Reply-To: <20230317202449.1083635-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3sXjUeqGEmBFHfU9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2023 at 01:24:49PM -0700, Jonathan Tan wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> >   fetch: deduplicate logic to print remote URL
>=20
> Makes sense, although I would need to consider only storing the
> raw URL in the struct display_state and processing it when it needs
> to be emitted (haven't checked if this is feasible, though).

We likely could, but right now the benefit isn't all that high. If the
URL was only used in `display_ref_update()` then this would be easy
enough to do. But we also access the sanitized URL when the connectivity
check fails or when printing to FETCH_HEAD.

If we provided an accessor function thet returns the URL it would be
trivial to do, but what do we really gain here? In the best case we save
an allocation for the URL and two loops ranging over it. That doesn't
quite feel worth it to me.

Patrick

--3sXjUeqGEmBFHfU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQYUP4ACgkQVbJhu7ck
PpT6bg/+KvFWYcE0uYwgTbyyDMH/LdVIqIMjGIXMZ7C9ySkbscsuwKdKxH711h4F
lO252bdOJe6dNm7+fNBfVnAW+zM2NfFnjcOaISxynZM8MnNLex4uIYDWAp7mDm0B
O0Gdler/ivc5uZLFchHUTYgdI7c+MVV5oZM/ay0qYl6zEh6eYWSbrmFQtzoguLFA
EooTMcgcmnib+/aAstqW8EBwxnFo7FSXICzAMmTqQAxJPbS+7SPqK0o21OWQqsmj
z5SDpQ+xLfdu/4WZqFk+Huqvzal5AFt+8ekEZ/2Z0jvo+3xwsDfDYLPQblHSKo4X
RIjFPTqIdSbqnB0ZD74OVd7kPVzUppHOWAiW0CmpMFcVaxxXGIKG1sngYpR8gk9R
jQra0PQzolYitDo6jy+nLQpiROYaShz3M1q2TF9m8RcjVpxqvzJnsGhOu5qM848B
WiVcerZxKY/L1TV4Q36uaxELdMfLetv90wzEPFTI5ajoT+EcpRAQ2Z8uCMYVr+Wu
1E2AsB7eiLRk5NzkOyIwU3z6gECiE+k0pBYZ8g8i7GrSGwo02nIV+iYK+D9GxHTG
nJjbSp2cu0Sp/TsEbmQgTpYE8hvgtc094ShKkEtNnvkXaVxlI1CnDi0oGu8n4Baz
qnEjH3AotmgaLILO/a01cD6hsUTUBSw7/vc0jSLbgvjfM9hFOOw=
=6Ge1
-----END PGP SIGNATURE-----

--3sXjUeqGEmBFHfU9--
