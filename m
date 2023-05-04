Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C2C7EE21
	for <git@archiver.kernel.org>; Thu,  4 May 2023 07:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjEDH5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDH5U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 03:57:20 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE183AAB
        for <git@vger.kernel.org>; Thu,  4 May 2023 00:57:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B0D75C0197;
        Thu,  4 May 2023 03:57:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 04 May 2023 03:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683187039; x=1683273439; bh=7j
        VghL1kCvF3MtAwOP1lzkBk2iFg4uZJMw5ijRp4jBE=; b=QOm5DpHdzeZ1rolm2d
        L7rjNIBa/+8RpJODyc3A1aVqyxn37Prufiys7wGv2Zg82wet0oHSPm2AKw9jxTCV
        7o63BR6qSe/pV5pIsvNlybi1RlBlOVSe/cO3GnJjq7Ozv/Nj2t9Gp1U9KpXw15Du
        SzsXmNwZKVUmLYiRzl9yRKrZ7Ew1UsqT15+I4Vwtx/+LznjfHLpCTntAR7P2jntB
        /EWXlkbZoBN3QzxBL0+qNXBXH/VxmP4KZ+H45gcJCiCHL0US/KMP9nBIcaZhZfQb
        pY80AiloEUwtxHLRMqkgoxoUa6Wb65Bu7UfPX5b9ELEQq+cgqnDD9v+qLvmhJTlj
        8JgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683187039; x=1683273439; bh=7jVghL1kCvF3M
        tAwOP1lzkBk2iFg4uZJMw5ijRp4jBE=; b=jL88VOM4GJQQFFwnmR8tGzhPJt2aG
        Dkj/wviaf2rkrFYGCXYSpwn5y4ZmgsLEiJCwSTIxxVAhVpvy+ujUuKmTfesybcCM
        dWc0lY8kGVnsHu8f6hyVOFBoY0copawr71/g9LJqJMwyhWj0idrootH8vqUggE1d
        2jArLNiGMzApxSYxnYJLQBURp1AVahUQACqg2iNkDt/RDz5QrmeKncljDYP7yoWL
        xO15oXZ7PITYBHBuHYnTHf1hvAPnzaqhUGBpdEO9474b+OlDBPloaRWncKH+drOL
        QE6K1c6vQ7oFe9TFd0ULvr3w7F964qicWLFefgJL5Ies8Y+HGSEjlxyeg==
X-ME-Sender: <xms:XmVTZG8gicqtcJq-XK7gLg26wU2QZsiYkQOohADFAnYCY1FppBwyEw>
    <xme:XmVTZGul0N8lYWgtWkC6Rt6bKdKlH9lndDcnQsaEYPOxivPreSXfoJfj_nT7PHyOB
    51ZLiGfmMW7uWiw-A>
X-ME-Received: <xmr:XmVTZMDoeACvC3DV7h2HIRl9F6p90xBraSD7t1w5uTt7Q94gFe1Opc8nvD_Ijkvv0OuVIWs38SSXBX1Ix7LSYjrIoNVz3O-OXoaBeHn0kcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvledguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:XmVTZOcFeyqvNOCBiq99LyP5Flg-BiRvYo3lw13DLsd2R64c7NTAKQ>
    <xmx:XmVTZLPR5px7iZJ7ffXUDUFyfG4pP2IcaIL3U6emK3nK0Nbm9PqDTg>
    <xmx:XmVTZIm3mDqDmQw_2xza5XQtLZk8M7_jMDJ8koGtIl5c6YbqdDMKyw>
    <xmx:X2VTZAr8QhYzen9496_yA83SPNFo3ByEj-nVDMgUrOtbUj_C5DFu2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 03:57:17 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 5d06a0bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 4 May 2023 07:56:32 +0000 (UTC)
Date:   Thu, 4 May 2023 09:57:13 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 0/8] fetch: introduce machine-parseable output
Message-ID: <ZFNlWSo3rSp1WzhW@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
 <xmqq1qjxuzrc.fsf@gitster.g>
 <xmqqwn1ptkzz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+IzDT6DT7HEN+hTU"
Content-Disposition: inline
In-Reply-To: <xmqqwn1ptkzz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+IzDT6DT7HEN+hTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2023 at 09:53:04AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> this is the third version of my patch series to introduce a
> >> machine-parseable output for git-fetch(1).
> >
> > Which base did you pick to build these 8 patches?  It seems that 6/8
> > is not happy when the series is attempted to be applied on top of
> > many recent tips of 'master' that I tried (including 667fcf4e15 that
> > the previous iteration was queued on top of in my tree).
>=20
> OK, I found e9dffbc7 (Merge branch 'ps/fetch-ref-update-reporting',
> 2023-04-06).  I can manage from here.
>=20
> Thanks.

Yeah, that's where I based it off from. Sorry for not explicitly
mentioning this fact.

Patrick

--+IzDT6DT7HEN+hTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRTZVgACgkQVbJhu7ck
PpQz6w/+Nds7icK9u6VzTxCODDa79henEThVzrVC2hyMbX9Ye5s3ljStiDuc7hDT
jDuwQbd/UWLCwFZi6ZJmWj9QqSKPFz38njTBe7n5ms2rp2rr1ZKk9NIVwsTLplSt
AUeoZoYhqpyIErZeV+dvl7nH7F0gMIaI1k5CVkojq8zC5CGt5f4lh6WgXg2dJPFl
KqEYZGIBH1ItLTcTPX36wm2TB+ZShtAsG7Kn+gF9xydXihu42cY6B9D3Eq9ao8HJ
fcJfJki8vICt0CaXziY7xFtO6OKEaE4AB3UJZkHzhPDlijGgJmMibQJystyFEthk
woVnS03R1FZPLTYSQFk4EEBVVBnqaOjnPxb9enEbxBYsCE9ETCdsshcNA80LLZ6f
Sp38bIAAzgKbxuLae8OgOkDCPSxiPayBCLVstSCxGDZGnGtJfMwR0IS7Y9uE2da1
7cViz+uAUZaBof2Av1CiyCGFYhyMOsgCnpV9r1wrFP9f4ZSpqZCc156E7qg9V2i9
AwIdaLbiW8oDxQUd/hA6yj/pEDXBDkgjkwzfbnmrSSBgeltrR/Ej158PLUAbRsZq
XDfSvsA035B2JppL0utH4pcTbsPqhnuuOeuUTv8zY9BlQwerxnhU2JsXREJlrwIq
Rn+uzjYkCU20NrJkIC1xAZMVYLUJ3UbpZ1/BXPgX2iBs3GHevcY=
=EbW5
-----END PGP SIGNATURE-----

--+IzDT6DT7HEN+hTU--
