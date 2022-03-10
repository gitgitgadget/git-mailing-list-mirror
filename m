Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BFC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 12:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbiCJMeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbiCJMeR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 07:34:17 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC441723EC
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 04:33:15 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C6965C0114;
        Thu, 10 Mar 2022 07:33:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 10 Mar 2022 07:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=10jcVH5lsvD3aMySLxXRsG0+nWskwxQSFWAlsT
        lhB8E=; b=XQOHAasi+/PDe6b4dui9md+BQ39087nqTniOV4yUOMyUBK+xUg2uPx
        e404gKZyDn0svyTDAxqiZJGRsykuQl46fcS+KHM/CVyMdbN3Lfc5Fouhku2mHK8x
        k6Zk28mhVL0UROM0tOKyAx55e4dxU13ref8rrOKB/+c9sts9HmoztkywjFNRrxoE
        +/6KNK6t6JJqnHusHt87bmfpw2l4i7dHz3PH8RFIk1FeelsLFH2OKzznZpmw1RaP
        Ds10FJVe/ct+v0lh2YvPbw2DC6JMdLrPcpEg98Zb9M/k8SgLoCkfvFBrUG3fpiKd
        WYIOSVSiaUWAX1LaRBnLFBwrez9uNfIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=10jcVH5lsvD3aMySL
        xXRsG0+nWskwxQSFWAlsTlhB8E=; b=mA+R9xnkWcCDC0h2hmb4YsbHW8fTfPFiN
        f2FOAx2aTJl53r4I0s3xI6ngnG/zYO5s9vKRR68AxnLF5l5l8dpdeEAw/bMF/Knn
        LIrvZVw1JAhMrDVB4HPRdPjTOLZeiuzvHZn2dv5rvbwJlwz+m4rjBKDdGEKjs0bl
        6WO6NVLwI1aRGNBiiy93HNu5Agysamh9SqVs3c+g2MSfJYcPVogmBZuo84kHLbJs
        xKcigBJXhLIRtICi/BVugVhYqjsspYoFfdCDWq24U6cXoar+epQvlVRjYDczK+ne
        OFWAQPLtd4V7K76QtdN8ONjUsfS9NsVAgZeZOYzqfNQpDiCdq0g8w==
X-ME-Sender: <xms:CfApYpELNQwWJy-LJnRhRJ3QWx1oTNKKBVg0nJdTsisqTjxzop8mNA>
    <xme:CfApYuVOnIo7gFwUuN56jjpsaw0eNPDeg4xqg3aMTOgL2gzTg6gDQKrh534nrfFz0
    -tKWDxdQxaTPCfsuw>
X-ME-Received: <xmr:CfApYrKt67tbtB9jS1NSPo0fz9o4RAsqXkyLUkBNSEiLKOofHFrsflZjc7VrNULnIsryZfoCp2nPU_lti21XYVaiE1WD8bujogLuu2aMfbASxDAprG5yG4MHyxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvtddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:CfApYvFMYoKbCXiept9TfNL6ftX49PD415ClMBllfzqPcjPksV0wHQ>
    <xmx:CfApYvUMa_02AXGjcA6fZU1iRNKNHCO-lKZTqPr5AwvwDtefnS4NHQ>
    <xmx:CfApYqM--_xmUBFC3deDLRPmrDi3kYQyy2byQ3xvBAGAPqjTuPhtwA>
    <xmx:CfApYmFce_zirPBhU79GHdZxhMnfwfe47nw42_3mp-oW7Betfaqq3w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 07:33:11 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b298b8ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Mar 2022 12:33:06 +0000 (UTC)
Date:   Thu, 10 Mar 2022 13:33:04 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
Message-ID: <YinwACkic3X1DKdr@ncase>
References: <xmqqr18m8514.fsf@gitster.g>
 <xmqqy22u6o3d.fsf@gitster.g>
 <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
 <xmqqczjt9hbz.fsf@gitster.g>
 <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
 <xmqq35kp806v.fsf@gitster.g>
 <Ygn/GvLEjbCxN3Cc@ncase>
 <xmqqh7914bbo.fsf@gitster.g>
 <YiiuqK/tCnQOXrSV@ncase>
 <xmqqpmmuki68.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8hKijMTJ6+iJRZ2z"
Content-Disposition: inline
In-Reply-To: <xmqqpmmuki68.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8hKijMTJ6+iJRZ2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2022 at 12:03:11PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> If the user cares about fsynching loose object files in the right
> >> way, we shouldn't leave loose ref files not following the safe
> >> safety level, regardless of how this new core.fsync knobs would look
> >> like.
> >>=20
> >> I think we three are in agreement on that.
> >
> > Is there anything I can specifically do to help out with this topic? We
> > have again hit data loss in production because we don't sync loose refs
> > to disk before renaming them into place, so I'd really love to sort out
> > this issue somehow so that I can revive my patch series which fixes the
> > known repository corruption [1].
>=20
> How about doing a series to unconditionally sync loose ref creation
> and modification?
>=20
> Alternatively, we could link it to the existing configuration to
> control synching of object files.
>=20
> I do not think core.fsyncObjectFiles having "object" in its name is
> a good reason not to think those who set it to true only care about
> the loose object files and nothing else.  It is more sensible to
> consider that those who set it to true cares about the repository
> integrity more than those who set it to false, I would think.
>=20
> But that (i.e. doing it conditionally and choose which knob to use)
> is one extra thing that needs justification, so starting from
> unconditional fsync_or_die() may be the best way to ease it in.

I'd be happy to revive my old patch series, but this kind of depends on
where we're standing with the other patch series by Neeraj. If you say
that we'll likely not land his patch series for the upcoming release,
but a small patch series which only starts to sync loose refs may have a
chance, then I'd like to go down that path as a stop-gap solution.
Otherwise it probably wouldn't make a lot of sense.

Patrick

--8hKijMTJ6+iJRZ2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIp7/8ACgkQVbJhu7ck
PpQI6BAAgUcJb/5V5cE9VT0JPaqKCSmZRxu+5FCgwus6VG4Ay7sbanu5bhywFL/g
jXNqk7A2X1i7Wl3aXsntQyqkbqwUpjnX7lida25DX2InTKd/vZmypo9EvWjiJCyJ
+cffK2kZLeH4HNqZCpYf+u9WaURfX7aDnoNcD6Fpzgai6VKhFgCj4EKyLmlk0cPX
kX8h7RHLcOb6iyXeqyPrHJI/zupespgI4LhzYOQ4zSohvzbRNQszVkocxaocEBg+
bQgTB8yWCG9vclbRMxzXz+X+K0OxgOf+Rh6XBgAUtycwpYV4XHApuMU5UsJtPCwY
VxLscCvjrKUV6KPJ+K53ULD056DeM9wUSh4RAfSN83M14KS94uMUWADqyYbh4kcf
SxkP3BiGIA3jQyNCMEMiIaqAsxvdNbcy/tVRhuGpd4arKAFZc6X/1jAIiIccocJD
lWglEMIYYto2F3xo4azB3G2rPQUjGR7dLPau0jz/KqvI8nHgSEwfp1YQLIf8huuT
w4I4zvSaaZB3czQ/M6/1XJSYNFCUqbqZDKLRMqMFtZIkChXcsAltjVSaOK4TlPQ1
ebSYvoqBNIhBCu9LV6Z+FedSW8tMagIJ6yXoi4OZe3aL+RIjNOd7BTyK/P6WIe0x
YWsnD9gWYlY1b4PMnmnDUsRpUY8VnhjnlFiwTgKjFDtNArn59og=
=sPDh
-----END PGP SIGNATURE-----

--8hKijMTJ6+iJRZ2z--
