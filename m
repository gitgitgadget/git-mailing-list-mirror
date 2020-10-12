Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85025C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E454920838
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Of/sFQ3M";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nd2cEL1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403848AbgJLREJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 13:04:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44147 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390355AbgJLREI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Oct 2020 13:04:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2134B5C0066;
        Mon, 12 Oct 2020 13:04:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 12 Oct 2020 13:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=o6zeLE8qPddm7rrPhbHEwbWhkU3
        4HNJCKMF6Es7zK3Q=; b=Of/sFQ3MsCkvc54yd5iXT1K6RKUN30VD7XHmf8DnW3H
        7GB1dbmlY1WmuumuS8HoEkOSj690AzuCN+cAB6P8j19dRehf/XxaanLqHqf9LWp+
        1BX+lRjlmLaCGKPDJtTSzLAu+ZLVvQh1Clo6G3egW9kbyQQ6p+EyofLUOJF/A0jm
        flRdtSxSeuYKb7U4xr7L0uy2L7XVkiesDIzVr26xWXxEtd5ePnJS1hGSPs4auzVI
        r3r5GoYjHD6RmCfnDJzvkzFYB9JnD4AA1FEbnnqg4/EBALGg+tt5lPJhxxICT041
        bEBLgi0URdbJ5PTHqwgnOkKkPOZ3eeyduX0MR9AEXZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=o6zeLE
        8qPddm7rrPhbHEwbWhkU34HNJCKMF6Es7zK3Q=; b=nd2cEL1d695Z6YEjEpW4sJ
        LH13loyMDOGTkPCSHA6Fi3huW97X7W574eIB+dMjJ8dEBc9Auy9J8aHpUVIf8Xyf
        /Y/CAju13djZgG2bc8B0EOWv2+5nR1PBp+8wowmhBPJQ9TYlSrW7dwBmA3ABK7La
        L4hZV8nmtWE2vDcga86jK0VZlot36INVEEVpuMcoq+koAo5IrXaCO/nWJQPzTaq5
        19dDVenLDEJFYaU7PEZ1P9ZGTVP8VAibQlTrRBNE6cYLbI5Vvr8AHKxNh421LvUo
        F2AwmP+qbEpPjmfUNFK/MhCxWDK4B5MdEI8iCm6+vZ3RG/gmcsoTXOW58na8sajA
        ==
X-ME-Sender: <xms:hoyEX_2CdX_dY81OCzwSuhWOYbMdM9kMdbNBJkvGwW-s51yn7xlbwQ>
    <xme:hoyEX-Ev6kd0QFU1PgoKaRdnxDgXrB3V0UORDu1zCuStBQZlvgC-PnxSrzq1-Sniy
    bM7gz2jpraDfjuHCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheejgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddufedrgedtrddvuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hoyEX_7ghj4QAMiN9lI8gpANhF-yPtVEbazy823HTAeJPSYGOwE3KQ>
    <xmx:hoyEX01sncD8a1Pny3IoS2Q58I8xkFdFiAze3vBY-UoCu5PsH2CMYw>
    <xmx:hoyEXyEPlEs0FBS1uw7uxxzOyBIIo8ZDe9s_WoS8AUGqeW5knM12rw>
    <xmx:h4yEX-CFVrL-m6SxUK1Ea2hmPwTiLKIMa8YClgjTO0RfggedEJy6MA>
Received: from vm-mail.pks.im (dynamic-077-013-040-210.77.13.pool.telefonica.de [77.13.40.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id DD6363064684;
        Mon, 12 Oct 2020 13:04:05 -0400 (EDT)
Received: from localhost (xps [10.192.0.12])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 42fdbcb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Oct 2020 17:04:04 +0000 (UTC)
Date:   Mon, 12 Oct 2020 19:05:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
Message-ID: <20201012170527.GA21606@xps>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
 <20201002041214.GE3252492@google.com>
 <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com>
 <20201012152505.GB3740546@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20201012152505.GB3740546@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 08:25:05AM -0700, Jonathan Nieder wrote:
> (+cc: Patrick Steinhardt from libgit2)
> Hi,
>=20
> Han-Wen Nienhuys wrote[1]:
> > On Fri, Oct 2, 2020 at 6:12 AM Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> >> Han-Wen Nienhuys wrote:
>=20
> >>> +     reftable_free(a);
> >>> +}
> >>
> >> Are there other callers that need custom free?
> >
> > The libgit2 folks requested the ability to set memory allocation
> > routines, hence reftable_free().
>=20
> Thanks.  Patrick or Han-Wen, can you say a little more about this use
> case?  That would help with making sure we are making an API that
> meets its needs.
>=20
> For example, is a custom allocator something that would be set
> globally or something attached to a handle?  If the former, would code
> that uses xmalloc and free and gets #define-d away when used in
> libgit2 work?  If the latter, what does the handle look like?

We have global pluggable allocators in libgit2 which can be set up
before calling `git_libgit2_init()`. The user of libgit2 can fill a
`git_allocator` structure with a set of funtcion pointers, most
importantly with implementations of `free` and `malloc`. Those then get
used across all of libgit2 for all subsequent allocations.

In order to be as thorough as possible, we thus also need to replace
these function pointers for libgit2's dependencies. As registration of
the allocator happens at runtime, we need to also be able to replace
function pointers of dependencies at runtime. E.g. for OpenSSL, it
provides an API `CRYPTO_set_mem_functions(malloc, realloc, free)` which
we call on global initialization of the libgit2 library.

So, to answer your questions:

    - The allocator is global and cannot be changed after initialization
      of libgit2.

    - It is pluggable, users can set up their own allocators by filling
      a structure with function pointers for `free`, `malloc`, `realloc`
      etc.

    - Due to the pluggable nature, we need to be able to set up those
      pointers at runtime. We can provide a set of static wrappers
      though which then call into the pluggable functions, so defines
      would probably work for us, too.

I hope that answers all of your questions.

Patrick

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+EjNYACgkQVbJhu7ck
PpRQrw/+OwX/XK8vSLB9MRG2G2iPnfp1iLqSD/oQDV+/VBk9Wx9CjwBuZxkVZI78
EQGFsBqDQcRDhtcGGuAlt8JEo7CFvgUizuWhnpYzIO6wveJUWrn0ni0KM9+srWk4
HQAv7CeOO/jyEep0wf4kt6/NnzuJdxFHtfp06CLFrRVNpqxg3EQXqYosMywp8aW1
Enssljz1Hrbk8HlMrbKDqdonZyJIdIYQrD0yoNJ4ugKqGzpBWYd7p5t5UEzyNVcm
g43a/CBQIlgL5auYTmXiY8VINIVjI0DjUnTj1f211qKaRLU+bZQbrpqk7R177r6d
isqA9rgDL6Li+kUigvriwruh44AlSukkbsdNY4kS+J5CNjNjR0TavY0ZWcmpOWfL
vRS/Jp4QgWJvaAf+5GBeVqdEC+pcX309zN0VU9ZTrqmJ6w9fLKZ2AKA9xoOMgMwA
VaIqdyDpaWlsGIPKvH+IlcFV3DProWTWrBcz75PKa3nmV28jvEup+p0efyl2Qb4j
4EEX1wyXLWJ25YDUS8XVT15jLPf4iVWGffy/0b7vNDXyUfuWmb8fupPBqz7+Hol3
s9jOqMkPUTbF5r2W1VN9PkE5JplGwb2RPWXrVcBYFvr26qJIr6hH14SDzc5HCjtC
3widFq2d7odrQ/gRhftbOzKNvysf37CTF+y+ACe55kM3DNOHAno=
=TWto
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
