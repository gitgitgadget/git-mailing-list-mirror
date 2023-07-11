Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589F8EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 09:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGKJim (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 05:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGKJi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 05:38:28 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601BE172C
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 02:38:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 50C7C5C0121;
        Tue, 11 Jul 2023 05:38:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 11 Jul 2023 05:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689068282; x=1689154682; bh=1U
        bOIE5rKExQgLLOwxjTThe0loPWYEx3Z7IP3/KB0mE=; b=F21j/jrJbGc7Mcx6ue
        IoZFBRbtC8Jh/CTKbMM44pKfoyelSZbDTwxX63yzJFbnqK7VgiR4Gmxc13k3XivY
        ao9tP5JUQvZCxOyqyjOVMbZpAXfxhDhKrdOgZUXVqUAdndZHkqrlGXEcV0ivCu8X
        ayuBeBOhJc1SJOMFt+E6vJB4i1y1pJa80yzIQWgOSBYM68xnpNtlsp/0D6MSrP2l
        RLDy0FKdY5MnfNiWsqKOEfa5SBFp4k5tqMKRlK/6Tb2ST8SKWEiqdYvhEI7rA2Ow
        /m/1jS+XKDMSqYA1YmI+V6o8pLNc/2/xrHUJEyrZ8NjST8HUXaeHiGmjxsUI3n9L
        av7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689068282; x=1689154682; bh=1UbOIE5rKExQg
        LLOwxjTThe0loPWYEx3Z7IP3/KB0mE=; b=kGYiFkoy5YX2s5dHnSNq/6Woyh5pO
        T1ZxN3vkAG8/Kr1UBiinVl8YxBt7NYqFhOlnp0bHSwUmwoxnOy6keYkDlTwbmXlk
        GmOIqjIcDKH8tkQ7xstR4CwP5AkqKbK6yrgAe0HJKcrTx8HDIB5jgyZuqNm/C6j3
        8J/8xP2fQvDAhMOHnpHKszVE+jfbOzZ9+DNGL7287qWa+wsysKpiXkc4m3jselmU
        BposqHuAacMF5ef3CZ2QWNa/3RM6pU1vfZYaK85p1CAnsCQKNEEk8vbz67VkUl7z
        mLwY8dDWx5RTpVYdSYrb6xW4qUrApSAhoTfydRSm7irWz0So5qLlPgNiw==
X-ME-Sender: <xms:-iKtZN6EndaNkJF0QvAtlRp7AUhHt5LcmbIG02IpJCbiZDBqkDNOMg>
    <xme:-iKtZK4iDy9G_JjNXEW56BeSEcWW-3c2awZ24hGPtKE8XHUxLzkIMAXXo_1xRDFnp
    hIY_YNpUWwrOiGe6Q>
X-ME-Received: <xmr:-iKtZEdwYnafRb-1r9PpVY348EP7btwwOkZVDnQykagA3lUXzs6v8OQZmyNn0x8BPrywXOkK9UUulvuNjXQ5qnOPjzCMYbWKXd8UhUl5Dc3N7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehfeehhfejheeftdetgfefjeeuueefgeefledtkefgiedtueejheefgfelleekheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:-iKtZGIEITFaPltsKq2rlTj-VvG8s6ohmUYB0iljql1cxS2p1AzFDQ>
    <xmx:-iKtZBKumtfqS3uBtEpHe3gShXy1cNzrT3RJja09r7FOmo5UHImBhw>
    <xmx:-iKtZPzlvlq2enXIULoAvW-7ZmC_bgADKJGF4o4KCEr7AweGatpyGg>
    <xmx:-iKtZOGcm5OoSCOlv95Gw_kD4YfAPNPkdSKOwgzBRbMXBRLPthdcdA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jul 2023 05:38:01 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 1a2f9998 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Jul 2023 09:36:59 +0000 (UTC)
Date:   Tue, 11 Jul 2023 11:37:56 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 00/16] refs: implement jump lists for packed backend
Message-ID: <eddehgbfqnmkhvhkacbvnqiiripbn6jvjawpy76ysfnpohsygt@a43fbutqg64z>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
 <xmqq5y6r4con.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="llxfqxn25yahlmlg"
Content-Disposition: inline
In-Reply-To: <xmqq5y6r4con.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--llxfqxn25yahlmlg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 03:35:52PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>=20
> > Here is another reroll of my series to implement jump (n=E9e skip) lists
> > for the packed refs backend, based on top of the current 'master'.
>=20
> I've skimmed the whole set again and nothing jumped at me as an
> unexpected change.  Let's wait for a few days to see if we have
> others comment on the patches and then merge it down to 'next'
> unless there is something spotted in there.
>=20
> Thanks.

The patch series looks good to me, too, so please feel free to add my
Reviewed-by. Thanks for these exciting changes!

Patrick

--llxfqxn25yahlmlg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmStIu4ACgkQVbJhu7ck
PpSLAhAAo54lQgnRsoKoRvF8Vekq/7L4FBgp94D7Xzdc4UwXu2RCqCRmpBlF/8pg
LPi9dEq93DQAE4XulmaR+rOCd8OmCy6LOQ13AhK3RFTDmivAm+R1Yo2IVrRrZKus
gUIj6JKQKA0MhNNQmZl3DZC3ShmRgqrd5k1o6eKZn/cFsABn9rIrcNpOZjvAl+70
c3Dsdu65Tt00gyJFYxXG09riL/rOY2EWW9zNCxaNnaLfGc9Bituenjb72EquVG3O
MowqmEirlYa6ijCoOBt7JJl3G9v7KLmy5XNPuwpj6M2FljzsDn5JhZQebQ50P78w
1pQYzr496SEyXSz7CB4lI2eU9FxsoebNkASEQfUC3Rt4duz2lmQ4DS1glTYDbMV4
Fm1DOLtQYBeIwUWLkyCszr67MEbIwn9+q7elqvjuX9R9L6XhzK9XH0DH9xGywi78
5CmOTmT948o9cVoOzM4xD1gN2ek/4+CIC9t1uz1zCCqm5xrocbzqRphPv9gOrBNM
tUiT+xfFFm7SyWblVRLPWMXsT2GKJADcA3SDzeNb3oL9LVQ2aNIeUfaV3AOxY+WU
JuwL4OrECcDKXN4WO1aAVylwAmtsfshhgfolvVuDlLYb30RzL5Nq9R8VuD1iAlU1
6ViSZTeJUxknYAvWYrmkOD+n/kIE0RQkoY+knoGBIKgXNx9urIk=
=EsSc
-----END PGP SIGNATURE-----

--llxfqxn25yahlmlg--
