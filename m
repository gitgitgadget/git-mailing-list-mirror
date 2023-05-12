Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A04C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbjELHRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbjELHRX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:17:23 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40021AC
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:16:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C09C5C0543;
        Fri, 12 May 2023 03:16:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 12 May 2023 03:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1683875808; x=1683962208; bh=1Q
        otznxeMtNnRKachU6FuUtrRvB81VKMnFrMZ+er9co=; b=bXpyZTvbc15yzMrTss
        MttKY8eNhzx2QWCqFLaC1LnhSSe0wC7+tg+u+ijpvUDoInaGJ4y+tJ7Jkb9RXIkQ
        uukW/LlctWvnHtY2l45I5Cg+IIf+n41oXvXFZXRjs/g5T5Gx0rwyWiNIK+PMLpYU
        D4qyrbB5NxVDdL2wuy2GC+tM/vjKi5D4sDIJZqRJKoU/fXzdpcC4giXjPVKvXoAO
        oe9bxUIrUxIH4VxJ7zC3o2A5jOCjnzcDb0p/6W1woxGYEs2pKa7uG5ijCLmm8Gz6
        3dmHKWOUV0wwiRionlKFa92vUd8XDD5wMZyje+kJP8d6TbvQc1Trcnd6q+waG1Co
        Jhqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1683875808; x=1683962208; bh=1QotznxeMtNnR
        KachU6FuUtrRvB81VKMnFrMZ+er9co=; b=J4magNT4bLQq5nRHL406Rb7nK4Vko
        6zN8vRt5LeuTAar/TOSLYTIDkSFgByoAdgEG0PQYzQj8js+5i0fQuo26vJ82EFNK
        8FnjBnzQwKuBBVy6u5G/ZnZZTDkgUNkWUqIYNGqKsLCQkDK54wsvWgwgQVkOsSBY
        H2BnBLfqA0DPQaK4kU2ZzNrWgsYAkpKnqIxSdaAum3+r36EjFtG59Na5vnbJF8AY
        ufWVI1o5WnT1sVVg/P8dpJLF/IYj8aOE8Z1DeL7Yzsrl7bLadhM1/X9PtDkmSVdz
        WBYwiydNWAaw2HP27t6pHTjnr8gOcPU0nejwsa2aDgxwbyBu6sS5Cn2VA==
X-ME-Sender: <xms:3-ddZOpJm9dvQOcZ7W1ltMxXMKWErQyh4TZYJDFkZRZI2Eld9FRbiQ>
    <xme:3-ddZMrQNKkRYW4Skotd_fJv-Uxz45VWVFQzaOh77le-G8r5QJJiQRkjsrhuYY3a4
    BUQuamfPoNACfmTBg>
X-ME-Received: <xmr:3-ddZDO6qhz39imOOzBy-GzO-iqzdYHIb1ZolsNZGi_ysPhyTiwxv7OT02tWod1mQYqKl1KmA2KcOFDZoHPE5MlWs0mwNk4mQCbC_P4Ek5VqPHM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegledgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:3-ddZN6F4r1_twbvXWlE0Fr8kzSz214hexnJCwCHPCiX0ls_6XkdXw>
    <xmx:3-ddZN43pIatCUONnnP1Wr46XJIWtZLrWKq6QJZ5sK1W3Ufv82I00Q>
    <xmx:3-ddZNjZq2PQ1tRj8HauMyxgV9qVoWqTEy5ca6OcQlo1XOZ8ZoxnAg>
    <xmx:4OddZA2DIe-Yde4YQstqVbe280hqUmx28a6eTA9bSQikcR50BPrLIg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 May 2023 03:16:46 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 359ce77f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 12 May 2023 07:16:33 +0000 (UTC)
Date:   Fri, 12 May 2023 09:16:43 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 0/9] fetch: introduce machine-parseable output
Message-ID: <ZF3n2yzfFKROBTza@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
 <kl6lcz36z780.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OWM9VPlELb7tRWXv"
Content-Disposition: inline
In-Reply-To: <kl6lcz36z780.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OWM9VPlELb7tRWXv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 06:09:03PM -0700, Glen Choo wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Changes compared to v4:
> >
> >     - Patch 1/9: Simplified the test as proposed by Junio and Glen.
> >
> >     - Patch 3/9: Added a test to verify that `git fetch -c fetch.output`
> >       without a value set fails as expected. Also dropped the tests that
> >       checked whether stdout was empty.
> >
> >     - Patch 4/9: Reformulated the commit message to treat the missing
> >       left-hand side of displayed references as an inconsistency instead
> >       of a bug. I've also added a testcase to verify that direct OID
> >       fetches continue to work as expected.
> >
> >     - Patch 5/9: New patch that makes calculation of the table width for
> >       displayed reference updates self-contained in `refcol_width()`.
> >       This is a preparatory refactoring that should make patch 6/9
> >       easier to review.
> >
> >     - Patch 7/9: Refactored the code to parse the "fetch.output" config
> >       variable inside of `git_fetch_config()` before we parse command
> >       line options. Also fixed that the commit message was still
> >       referring to `--output-format=3Dporcelain` instead of the new
> >       `--porcelain` switch.
> >
> >     - Patch 9/9: The `--porcelain` option is now a simple `OPT_BOOL()`
> >       that can be negated. Added a test that `--no-porcelain` works as
> >       expected.
>=20
> I didn't spot any blocking issues in this version, and the various
> improvements (especially 6-7/9) are really welcome. I also read through
> Junio's comments, but I didn't spot anything that I thought should block
> the series, so I'm happy to leave
>=20
>   Reviewed-by: Glen Choo <chooglen@google.com>

Thanks a lot for your reviews!

Patrick

--OWM9VPlELb7tRWXv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRd59oACgkQVbJhu7ck
PpS3nQ/9GyDQQWDSqyZx//VQcuo+DCsk3UGdPLwQ5fFAV/UrwJMeWhwXoEviE0+4
P9AKOS1HE1NvR+diNUkZ6tSWb1yA6vTnVcgdFi7PJ8Et3wEBrqxGe6WjkhqcKEuA
1GrrpHAY2q2c1OBD38Vi8kj0EFVI3pV8pcsuUYi0jJzHfSWw3W1CyWnl8PTO2o8m
YX2W7e4jd2OO7i7dRHeMtgKkZ2Vg5xYNFd0fCeYXZ3nVbBNfz6YLdPAAUhpuNYLL
gU1R81w5lx1BDkkE2L6mAnSSSnVPXm3pS+e74iXZp1vkC4OWb52YgumyBsP1mbwS
NznfGbAlCr2raxXQTQMA4m/IwhRkAAmAFkVgWELO3R43Oq8hf3/0veb4rKDdW3+M
KymFw5CDQLhh5zWj2UNUas8LDe79oNnPBnwVybJDdG1hpBlTm7laEZc5At6R4GXN
HhV7M66/oayBmEt0iaBVDazxFlPSRGhGIEd8t813QA/hQFRlYLb9PIri04wxULHg
ymrPLTxYiAMGVd6oLSjgY0CmGIhjSSF+0sEd8p5E8B8OfD3Wnizzj13v/x3ShGyT
Q7rVO0xXn9J3Kmtn/mbfyzZEvhc3t+vmtl53n2THzY9KqBBQa8YFWQn7TEktqqMq
/jfTjiIFbY7lQsLTAuG6DN7X6DdeIYgR/cEbtaKsNYJHvhFf4LY=
=W6oQ
-----END PGP SIGNATURE-----

--OWM9VPlELb7tRWXv--
