Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF588C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74CE60E98
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344264AbhIAMux (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:50:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50633 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346177AbhIAMtc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 08:49:32 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 19CD75C0139;
        Wed,  1 Sep 2021 08:48:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Sep 2021 08:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8ykhov+gAy01jM4ZS9mJigquTvI
        bQ3U8apYCPfmZ2JY=; b=Zm0tjfoaldykmstXHZZYOlvMAFY6soNHnW6puWRybVV
        HsA3UsEfJw5EXU+CdbDbZukuK3ZaoDUJdxtr7do/VfB6guDGAwxEbdidTv/zZvye
        snbzC8pSC/AADLSx6fLkrAmbOabGFawc168ZUOQ4bSlzpOXrgWdCUgI4r+tm2gX2
        D6TBHvNOxWaJLhXeDfvob4yo1CXp4aPE1Qo8obHMW4g2A1lR00c2BuwnNgQiroIW
        1Pa2CR6ILQhoDP+SOCYTorvHQGykyPlayZLdORTE362qr+54aOSPb8ZRfEhNLHF8
        PYJJzI+Mh5W0uIAgNBOqrtA1i7n6I7t11S1D/tBhENA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8ykhov
        +gAy01jM4ZS9mJigquTvIbQ3U8apYCPfmZ2JY=; b=socm3TjSgkBEMPHCkEEziW
        07Xcpe3waTUEb7yyHLg2xIZUi84kgSqb0I1BUhHykVSCPmLrxeiHvmq5B5xxFuwy
        Q+7xux2tL+vMH0fwbzu2p4BigsllHUDHOdyCOO8C1U2bMPQXz2HjdxCQ14yEx+KY
        bvvNq0IEDxUTele+zQvCO4RibGSBtFcYVBFzdaBoEQuu9JG6cOYOaumyC59WXTO3
        3qFgkodY/JK58FqyZGyOA3ehfslcWMdpfanLQFyMkIRHUlYBousu20uMW0mDq1nl
        Zr9ZFLior8IOv3eLrm53Mqdpm0rAiw7TWPtvEaAqcwhEquXJVbzDOJbhtSK1TqMQ
        ==
X-ME-Sender: <xms:oXYvYWq05JNgjOs0nSi4Shjc4D2d9jx9jjyLaCy3KLVvrXMvfmTnig>
    <xme:oXYvYUopJvhNQsxKa2KTdeIGRIBFts3082_Hn-aTf07A5ruz_2I4cXxfud558OQ3P
    a5mdrWQxsRNVpfRYg>
X-ME-Received: <xmr:oXYvYbNo8CSlX_rZN3S85HBM1hsgdH9L7sihAPa8oL6xVZOumSLhImNBKzUtfdFpM2IEIQi6hbfY-L_4hmuTJ-_r_OM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:oXYvYV7SVLxvsD0wFFnBbo3GzIMqErPBNn0aDCo8-K0UZJUNuAN7dw>
    <xmx:oXYvYV7KCRSb9GVc3UOuULxo7ygnPKKHqQVx_wx8sF-ab9Bcp6oyow>
    <xmx:oXYvYVg6iudZFDA0n0os1VfCbWj0w1mB0rEeVWLlFwmneVmbGkWgBQ>
    <xmx:onYvYY3pP04wloVRh2oRAfdt2_lL8vx6N-7WfA3bTgRPDRpwIktm0g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 08:48:32 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f1c575f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 1 Sep 2021 12:48:26 +0000 (UTC)
Date:   Wed, 1 Sep 2021 14:48:25 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 5/7] fetch: refactor fetch refs to be more extendable
Message-ID: <YS92mY5WMIEuXvG/@ncase>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
 <56a9158ac331f9911a4347d7d4afc2bbd2cf4d33.1629800774.git.ps@pks.im>
 <0481bb7d-2799-740c-a3de-e16ae05b8f45@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YoJ/oqBf6VDNfaeZ"
Content-Disposition: inline
In-Reply-To: <0481bb7d-2799-740c-a3de-e16ae05b8f45@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YoJ/oqBf6VDNfaeZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 10:19:27AM -0400, Derrick Stolee wrote:
> On 8/24/2021 6:37 AM, Patrick Steinhardt wrote:
> > Refactor `fetch_refs()` code to make it more extendable by explicitly
> > handling error cases. The refactored code should behave the same.
[snip]
> > -	if (!ret)
> > -		/*
> > -		 * Keep the new pack's ".keep" file around to allow the caller
> > -		 * time to update refs to reference the new objects.
> > -		 */
> > -		return 0;
> > -	transport_unlock_pack(transport);
> > -	return ret;
> > +
> > +	/*
> > +	 * Keep the new pack's ".keep" file around to allow the caller
> > +	 * time to update refs to reference the new objects.
> > +	 */
> > +	return 0;
>=20
> And it happens that 'ret' is zero here. Should we keep returning 'ret'
> or perhaps add an "assert(!ret);" before the return? The assert()
> doesn't do much, but at minimum would serve as an extra indicator to
> anyone working in this method in the future.

The assert isn't really needed: in the subsequent patch, we always
unlock the packfile on exit.

Patrick

--YoJ/oqBf6VDNfaeZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEvdpgACgkQVbJhu7ck
PpRj4w/6AjgPSbA6NE031N8BOZO9JONSknKConOIpldFXPD8U/x9nMHCBOwbrCJn
fmTbCu/i4eGUN1WqkQmrAUynDjNMdpYKmfpDS41cPwayxjhypdh10UEoTwFxr8L6
UuqN2SEuBzlyEy16vPZIqVctUZsVI8zkJD/22S/cyIri0Y6FOsg7C+XooW3KrxLF
2JT7uKJ3YVAFlSmuG0xL3SZRJCOMW1G9tNEj7yKFH6jgqgk1bZHtxncJmnFX0zNV
6n1x7wrM8vVw8N+0kwk3O4vuu0ra6QP8fOjTAvKZ3YEn/DDMI48BlVpejhsDbziq
DEE9KxHf51lF3Pe+eCHnvr288jX7f2AmwoOGPQ0wJQPFeWkhYJEcug3gMcppCzt1
GP/EVj6khybT8NANOtQFfT0zDRARdm816IAmA4YgiP7OLW0FjVRMPjhtkHGyLF4C
31jevZndqB29RV6kaa7XQzc/2cUEFVfpLDLaKvZI+FQTmH0eNLaamcor0yEQH8T9
r2tcLERVAAklmgPSmDcoBWs4ifsxQOcQfGkqlnOCdemXvp5mJd/Rl+95jYv9ysov
KBV4XdZDWNXP0WnWA14xKa9JjYgd4hasKiCaMXX1gvPKtFFktn8Ni1/ufNU0oBgN
kGR2lXlKnRWEN552F4I6xithHUWVqKTzDy2LasdGdyO5RAttVq0=
=H5zp
-----END PGP SIGNATURE-----

--YoJ/oqBf6VDNfaeZ--
