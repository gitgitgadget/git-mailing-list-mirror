Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED9AC2D0E5
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9C820733
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uvIRSD4P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="csTNKMyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgC3NZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:25:11 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59231 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbgC3NZL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:25:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 791026CF;
        Mon, 30 Mar 2020 09:25:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Ke9hZUC9SvDwIBawShPI0elVXK+
        ncOdKj1TihvW6gyA=; b=uvIRSD4PoU8AT/8LivTTFTG0oxWdMVA3DnCL2k9mMXh
        qpTQWS1I0IUIgFWdA5twaik7taujBs5hMKlpeigQE8TKXDKUw/gh6CBOMESyUxiD
        HC8+nKaV8EcDNqTTLYLwvMT4PG2KWlnUNLRQ5zXdTvtaprme1Obc2C5mKwBo/YZ3
        0AZ3DsZv10tAC/12LLVkCBDDEfCNYic2vx+ul5Qi8eYog9NoTNtcIQjyk7KDXcNt
        RtLnIbHYCy066j4t1MYfiLCzjEimljwEkss24D5xVFT006CSKhxPfhfPmslKZ1+1
        +9vyBCASV5e8rTOXCZ7nzowYjFFjiijzxjFFj87PT5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Ke9hZU
        C9SvDwIBawShPI0elVXK+ncOdKj1TihvW6gyA=; b=csTNKMygKSF4eXEwJfWjyW
        bfCUUDzViRvFplSWGkeNK3JNsWfROxF7X2vb4vmVxb2YsIzlMVCVBzB28gF4SBDM
        bOP+x2SMq7FD+wG1PRwbAOqLEMwP6EUfkCnjnorkspREs629BAlv8peEmxlG/HIZ
        rh9Awbcry65cFAr8am8czaNtztEoINTBS+JcpCAh1lWfT801wH07Q9f/N8dcHrst
        HJ2Xf1aduGMrYKQU6oZlKkD8EhwkpdwmbPa3VyDsz6HUaVtXCWpYg4PCYVXSfm30
        idXlf2TgtLziki9SYeASc9WzOQDL3S2gDzTnUXE/b3FugKf/HMx2sII++OGIkykQ
        ==
X-ME-Sender: <xms:NfOBXqJjtMRNwPPbdWP8IzXB8DxSrfwyBcbOXr9BG5HU4zdfYwqnQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NfOBXjxXuWunRJx4yQ-Ue5oT3TV0sJLw1XVOj9LYzknuObZbBoF5rg>
    <xmx:NfOBXpa2i3krM0Nz1lCS3Hkl06qka1G_qaWkDwzRDa28BEdoimfKJg>
    <xmx:NfOBXn7ZxmTLwAZlI4dMgubvnN9d-DPnTp8SGyj6AUx46EEeKL4KfA>
    <xmx:NvOBXnkdmDo8kOTje-YzTeCkFr4RBHIM1MVPHBckUpkLFZL4pPk33w>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 429DC3280069;
        Mon, 30 Mar 2020 09:25:09 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 581c5774 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:25:05 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:25:09 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/9] strbuf: provide function to append whole lines
Message-ID: <20200330132509.GA1344694@ncase.pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <4b0a963ea5c47a951b95aa0a03966315b3e8299d.1585129842.git.ps@pks.im>
 <xmqqpncxfr1p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <xmqqpncxfr1p.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2020 at 02:04:18PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > While the strbuf interface already provides functions to read a line
> > into it that completely replaces its current contents, we do not have an
> > interface that allows for appending lines without discarding current
> > contents.
> >
> > Add a new function `strbuf_appendwholeline` that reads a line including
> > its terminating character into a strbuf non-destructively. This is a
> > preparatory step for git-update-ref(1) reading standard input line-wise
> > instead of as a block.
>=20
> Hmph.  If we were to gain more uses of this function over time, the
> necessity for an extra strbuf_addbuf() becomes annoying.  I wonder
> if we should be doing this patch the other way around, i.e. move the
> whole implementation, except for the early
>=20
> 	if (feof(fp))
> 		return EOF;
> 	strbuf_reset(sb);
>=20
> part, and call it strbuf_addwholeline(), and strbuf_getwholeline()
> becomes a thin wrapper around it that resets the incoming buffer
> before calling strbuf_addwholeline().  The logic to determine EOF
> would need to be updated if we go that route (i.e. instead of
> checking sb->len is zero in the !HAVE_GETDELIM side of the
> implementation, we need to see if the number is the same as before)
> but it should be minor.

Unfortunately it's not that easy for the HAVE_GETDELIM case, though, as
we cannot call getdelim(3P) to append to an already populated buffer. So
we'd have to call getdelim(3P) either on a NULL line and append manually
or on an empty line in case the strbuf doesn't have any contents. While
doable, I wanted to keep out this additional complexity for now.

Patrick

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B8zMACgkQVbJhu7ck
PpQY/g//Y5sFKVS6/jexpf/q2lXapkY+8pQh8J7mlsoim/3CESOPSrAoDnkluHw4
v8w0HMq9tMRxFopQewHOKJQR9oGx2Zo6xeOjgHW0CKvWTE4yTiwzCEqisDca4T2b
BNSUDdJ9HaBocpviSl2BBcPBf/xUGznlNc3SBUJVLj4jUIX07ZRtXymqGvMbeYrE
ZL4ANF1N6wq/OaRxxKxKLcvTDuOnMEaG3OIsFQ3gLVByXTSw3xZaRY/OKekbRcte
OQNphk9rAAoWxwhszG4mGQW4e0oWSJrtJm0XhkXdIqgN2FEegX1BNrt/WNR3iCOR
GH9b189KxM1hamMDwzOWjXYpRZucWZji0uUa2sqiK1NSWmKbyFCzQ2GSI6e/2ksc
VHG309QlFNJ5/zUf17zUdXqcYZK0ZZOtrZ29v+FnqwdkBMdYXUKAMVy5+fxkxNP6
dLGoEou6osPYGGmJLtoGpsdxIurxJTaPD6uY1WVNd9S8gWV3Vl+qJcu5cgdStUfS
GU9YVFLGUrW/DLeMWxjekt5SqIrHm20zdZEw9HciL+oaY/WYvh9fx/IHrbJf75YB
o8++HrhGQ2Bu1A4REPAOb8r4bIe5b0ZuHrWBi7rjA9C+ogns999+SIer+2BtgVc6
MlwRuAe+UxmJaXnyjbPZOwDY5OYTj8maw58q8EizQX2VVKxizZk=
=qaui
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
