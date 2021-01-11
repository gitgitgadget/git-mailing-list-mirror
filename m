Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDF3C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 10:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5CE224DE
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 10:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbhAKK3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 05:29:36 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37275 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728664AbhAKK3g (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 05:29:36 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3A33C257B;
        Mon, 11 Jan 2021 05:28:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 05:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=pWUSXUVmKtcvyq6TGGBr71CWLxL
        lY50Q9w2IC/V7oRw=; b=yxP2eOjNv4Yptl95hm2nmd9VY0Ak+VDv2Rw8YkefueX
        4y3BR3iIFsbNkEJrmR/iG1NJY0lAKBhaggwfwdCW0TV+VwLjfSIIvItVcPXKGoST
        tQKe7vzcFel2sn9UGHIEWBrGQ69CVy3zOcVUfWVsKEYWfKr7aAViU7m3w4aUwD9L
        HbFGU+KudnKEKprXYlgJrYFz3B0a/EQsI9CDqpjhh6I72hd7nRn6LFsQyCEfL/C8
        jrXXsj1wPd/XsKEdM1TH/BMmglMbdstYOvXBNZHCCU0gOFO+1Cmi19W/7Zi5PZZ0
        KVYJLKROOG3doqOOifBbre+R8BFSOqudqcMXfFPqvcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pWUSXU
        VmKtcvyq6TGGBr71CWLxLlY50Q9w2IC/V7oRw=; b=qkRC6AdYVXhprF5z3s+ICd
        L2MeeyVl4+fu1HhYJx/EDaQh79UHKCiaHbkZnDmya+LZsWkbLqfPXXCQOR/DqFE7
        5qQT1J/w0UjD+P7XPuwnxrYMYNTHtdZrZIgo6Pmv6MllkS/J++mwIkgZJXNR54MQ
        BMCBxxdPa/b5Jr0cr3/HH7kAQj/XfRWj3tGRcwOGtotWfAuUYsS7nx1sI3wT5/Eo
        FsvN2gNV9dR22e0WpoIM5B2/LR8JrzxlPa0tNXBVHpJenygEaVUEV3dkJMP0FbCO
        3tJupHaw1B+giesBpwVoI1DgtQJUnAipuUEQ4jedruVhrNDZSurP/mFx5ujc3jkg
        ==
X-ME-Sender: <xms:YSj8X7mgmGJg0I-xUtRR1bN8i-FGld95-BXb9RdCwb-DI2R5iUDdQg>
    <xme:YSj8X-3A5Ps34RjYugO7YS_PNBSAVATyzXaU3gDqvHWUSEfAynSuAJo-xjz5s0MIW
    HLUL4TA-uNRYVYw3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:YSj8Xxprlx3W-dExWnvH-zm1tdD5dhv27NrvaSJYEoXZpJp-5DK7mA>
    <xmx:YSj8XzlijTB_ZOgcbpn2EwTqGm-6roRpGqJFcQk7zFqKljiQlU8-Vw>
    <xmx:YSj8X53MQemukrdeB39FfqTa26z88nXkOetP7VV0dZQZ_lWibcqL4g>
    <xmx:YSj8X28RGaXiJNgXn3M4ZI5le4ZaPDk6wN333Y6Msg-P1_Lgq4C0hA>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id C935A24005B;
        Mon, 11 Jan 2021 05:28:48 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3db2bb14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 10:28:48 +0000 (UTC)
Date:   Mon, 11 Jan 2021 11:28:46 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 2/4] fetch: refactor `s_update_ref` to use common exit
 path
Message-ID: <X/woXrxFqctcX2NB@ncase>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610107599.git.ps@pks.im>
 <718a8bf5d7a0ed92c3004991a42419279ff38253.1610107599.git.ps@pks.im>
 <xmqqim87gf9z.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9OYkIK2MmprROAMi"
Content-Disposition: inline
In-Reply-To: <xmqqim87gf9z.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9OYkIK2MmprROAMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 03:50:00PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> >  	ret =3D ref_transaction_commit(transaction, &err);
> >  	if (ret) {
> > -		df_conflict =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT);
> > -		goto fail;
> > +		ret =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF_=
CONFLICT
> > +							 : STORE_REF_ERROR_OTHER;
> > +		goto out;
> >  	}
> >=20
> > +out:
> >  	ref_transaction_free(transaction);
>=20
> It is a bit funny to see a goto that jumps to the label without
> having anything else in between, but we know we will be adding more
> code just before the "out:" label, so it is a good preliminary
> preparation.
>=20
> I think a variant that is much easier to follow would be to write
> like this instead:
>=20
> 	switch (ref_transaction_commit(transaction, &err)) {
>         case 0: /* happy */
> 		break;
> 	case TRANSACTION_NAME_CONFLICT:
> 		ret =3D STORE_REF_ERROR_DF_CONFLICT;
> 		goto out;
> 	default:
> 		ret =3D STORE_REF_ERROR_OTHER;
> 		goto out;
> 	}

Agreed, that is easier to read. Thanks!

Patrick

--9OYkIK2MmprROAMi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8KF0ACgkQVbJhu7ck
PpQCRBAAn0mozjzzxxbjyZA3n/gylGszp+zV/z9436PtO3emaaUrV2B3ioTJptut
I4fI8Ay3nmR3gL9eoSPvcP0TfYcbcrBoiNhPysn+Y/McFhW8RUIo3D4Gd2bFpYcu
pYQ5nXBdncxBA1soR5EIp2eEDuAhjNa+wDeR0GUPn4HUDpuNX1iIkWvxmJNsEAOa
siHWKxtRzMfjitsetbtVWS2BWns9LQh0unk8WWEH73EOhrvFQB9kB7ttgpOqb5VB
lWSfEjJvcg52o4ZV/ZNOMGKHRWK/c8mEXWpRp6nKmEZ1jvS/Aopgm9P86cVmoVBB
h6/B+8cR2qPBcwlar7g8Wxj25MmUOlcROZeU3WAXYeSz6NL902s8sMyX09nNL3I1
J02HStqDlYoK8mZ6XCmeGHFuDNXSLpwBp21+lWEfk3Kq1z8lcRbz8m0ydDaVL/+F
/+ONP/So2LhnozZPVqJ0mZMpTmMkFaRbXZIH3KegeBFOYVSYqdSpkxUPrTyAgB6o
ufWdzBqD4/Y/udcfPm0b1jWXs52kEuAo+FuSLUtHzAlksrLExw8BTA4L2tPj8pEW
JUEMyRq34f+tjb+14UQRyqXVRbKXns9bfO6za0Xnx07cP+fo4dWL3l4iqrRtDVBt
aM9fK/lRlYdKmY8pcKbhpRXjI6rO8a64loqW2WtFTB20cG3fB/M=
=nBz7
-----END PGP SIGNATURE-----

--9OYkIK2MmprROAMi--
