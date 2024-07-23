Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF713CF85
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716617; cv=none; b=RzeWEsGdo7hZFViGHkGiatLGDKw7P2NewkhSVffpIBH1Dw2RZTUT9VpNyhUkafM/9veAiCt0xN3ejFUQ/EATWiVpr/MIGqoXlbAdWG8vAP6oComueXWk49Btfv9DxMXerDI7F7Ufn5FyU9BmJjra6LWt6wZtF+FVvoXdZTmFh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716617; c=relaxed/simple;
	bh=Ij17boTiBM+o005ecVdRNAJTCkVIL1lHzVW8ocu9gJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQOgWKmq0KQxKtX87px/gxfcb+vtyyntrGT4lW7s2OuTItuFgyymCD0bTsKGsLIl+NVyvJJbLO92ZkyUyO8Jf+rzB6uH48VHnQ/2oQkQFhwoLNExRoOAuKYc62WER43XE38hwRIE/fF3T2PpDyqDVnNN+e4mcpX+dpT6As1gFZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nJAw4KWU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sck1ljBu; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nJAw4KWU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sck1ljBu"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B957011401CA;
	Tue, 23 Jul 2024 02:36:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 23 Jul 2024 02:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721716611; x=1721803011; bh=/M9Hb9xdFg
	8noCx3JNylIe3UnHRAnF/8t7E8C0dyrns=; b=nJAw4KWURd/iHYShtHmiGtmGLq
	S7dvD1AAmPf3w0TqFS60lOBF113Cby9/NHeegDvJwBgu0ewppBqG1P6+VRLvOIwK
	C9NVwBkjmGrzDYbKz9gkgSrRmFqpLsiOncTPvR0p8duKohDfVfj2lD4h2TYjNvT+
	CUekYZVY6/L7ajWyOZoMsMSD8ZH75n5A/pubpQJJmvGKvuYXK/SxN2+B7EePMxLo
	8bCUkn1E4hcEy3bzgV/d2xh8ItpZYlf1fqBANzP+rX8fmKCk9K318NkB2rcPiqeI
	mWrMeodAnkWYXS5LFCc7IiPgVU5LhFEzlHjwOiupWvcLzBPhkr/9ATXZJvvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721716611; x=1721803011; bh=/M9Hb9xdFg8noCx3JNylIe3UnHRA
	nF/8t7E8C0dyrns=; b=Sck1ljBuA44V7zQ7IsMBKBQHgny0q+rFscGgb5Ohjmcg
	xUMtJqmh8cLOSpCmTUQYfrQ9esvE7Xuf2NCZh1y4bVKGP/l84Z0cqAwBppdoUuum
	tQgZVg9wXkksCJQF6RBLxvZZLpPCfKbvm4uZ2umijpSNfTD1p0QmwhbbiaUUNqOp
	gxctQW3FqU38U0lBXHGqyG1SJbzTofP1C5jtAzqepDCKOePI6oVS/IOoDK3VVtj7
	nwCHbNiZugb2Mfia2K+l6uYNNfvLofbFOPW4TRiCH1/pcAynGMs9VYjMCOjiDLff
	t03caTWSxPr74rU0s9kqIYCgyU1D8U3lv9IyBtMCwg==
X-ME-Sender: <xms:g0-fZoe1Q7Rng39cMoUW6XSWOT0IioHPbBjLHuG0aX_F0UbOwxQBCw>
    <xme:g0-fZqOwVUjPB2TlaqBGNwYqsCz9L3Hhhw6yq02RRT0CWRs0QN_oIqcxgf1tP87x2
    V_Z4zz8J0Isi8KF1g>
X-ME-Received: <xmr:g0-fZpj_0vCmSkPsfNmeKz15uP3SZRGstrAh_ZFjXTdkmGp_DG0hZrBrxAAJ5UXMsyIfwL0_lj2Xl11VUm-W_nRBcoQcQyzvpmFS2WZEA8e8rxbn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheekgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:g0-fZt_PfNAB4KWAHIzbV5vYSsbzjRSNEdZWPjM6q2QNODnUoMRYFg>
    <xmx:g0-fZkugvid4e9Y6K6RAASS4nF8hABpSjbtBx1ob70sdxle-rQg0VA>
    <xmx:g0-fZkE-OIBOLXdmRWbd-Eio0AD2yWk1svgniqtM6YlA8HD1TlIn1g>
    <xmx:g0-fZjN5alQzXen7U0U72LLS9EmD0NQ0M5lXvYrVQsfRtYh24CK48Q>
    <xmx:g0-fZoiKNdnLqseGDYZCZYSwIJJJYDrshJcTo7OgdqGyAzU23jeydVln>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 02:36:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1fff9f87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jul 2024 06:35:33 +0000 (UTC)
Date: Tue, 23 Jul 2024 08:36:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott <spectral@google.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
Message-ID: <Zp9PfdZtWJBp2xgl@tanuki>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uO3WQjuioYZTjmzZ"
Content-Disposition: inline
In-Reply-To: <xmqq1q3lb4me.fsf@gitster.g>


--uO3WQjuioYZTjmzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 12:36:57PM -0700, Junio C Hamano wrote:
> Kyle Lippincott <spectral@google.com> writes:
> >> +#define for_test(...)                                                =
  \
> >> +       for (int for_test_running_ =3D test__run_begin() ?            =
    \
> >> +               (test__run_end(0, TEST_LOCATION(), __VA_ARGS__), 0) : =
1;\
> >> +            for_test_running_;                                       =
  \
> >> +            test__run_end(1, TEST_LOCATION(), __VA_ARGS__),          =
  \
> >> +               for_test_running_ =3D 0)
> >
> > IMHO: this is borderline "too much magic" for my tastes. I think
> > having multiple test functions is generally easier to understand, and
> > the overhead isn't really relevant. It's not _as_ compact in the
> > source file, and requires that we have both the TEST statement and the
> > function (and forgetting the TEST statement means that we won't invoke
> > the function). If that is the main issue we're facing here, I wonder
> > if there's some other way of resolving that (such as unused function
> > detection via some compiler flags; even if it's not detected on all
> > platforms, getting at least one of the CI platforms should be
> > sufficient to prevent the issue [but we should target as many as
> > possible, so it's caught earlier than "I tried to send it to the
> > list"])
>=20
> Interesting.
>=20
> > If others agree that this is a good simplification for the people
> > reading the test code (and hopefully for the test author), I'm fine
> > with this going in (with a different name). I'm not trying to veto the
> > concept.
>=20
> OK.  But what you suggested in the previous paragraph has merit.
> Are there other things that could be improved in the existing unit
> test helpers, that would help those who do not use this new for_test()
> thing?  Let's see how the patches to improve them would look like.

Honestly I'm also not too sure how I feel about these new macros, and
I'm somewhat in the same boat that it starts to feels "magicky".

Taking a step back: what is it that is bugging folks about the current
way of writing one function per test? The boilerplate cannot really be
it, as tests should be self-contained anyway and thus we should have the
same boilerplate regardless of whether we use separate functions or the
new macros. I also doubt that it's the function declaration itself, as
that isn't all that involved. So I guess what people are annoyed with is
that every function needs to be defined, but then also wired up via
`TEST_RUN()`, right? And that I totally get, as it is quite annoying.

So... can we solve this in a different way? I quite liked the system
that we had in libgit2: every function must conform to a specific name
`test_foo_bar`. We then have a Python script that reads all test files,
extracts all files that have the `test_` prefix, and writes those into
an array. Optionally, the `test_foo` test suite can also have a setup
and teardown function that gets called for every test, namely
`test_foo_setup()` and `test_foo_teardown()`.

Altogether, the output would look somewhat like this:


```test.c
static test_foo_setup(void)
{
    ... setup global state ...
}

static test_foo_teardown(void)
{
    ... tear down global state ...
}

static test_foo_one(void)
{
    ... first test ...
}

static test_foo_two(void)
{
    ... second test ...
}
```

```generated.c
static const struct test_func _test_foo_functions[] =3D {
    {
        name: "foo::one",
        test: test_foo_one,
        setup: test_foo_setup,
        teardown: test_foo_teardown,
    },
    {
        name: "foo::two",
        test: test_foo_two,
        setup: test_foo_setup,
        teardown: test_foo_teardown,
    },
};

int main(int argc, const char *argv[])
{
    ... boilerplate to execute all functions ...
}
```

The setup and teardown functions are optional -- if not defined for a
specific test unit, then we simply won't invoke them.

There is of course some magic involved with how we generate the file.
But I think that would be quite manageable, and ultimately all that the
developer would need to care about is writing a `test_foo_something()`
function. Everything else would be handled by our infra.

I'd be happy to implement something along these lines if folks think
that this is a good direction to go into.

Patrick

--uO3WQjuioYZTjmzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmafT3gACgkQVbJhu7ck
PpTF/Q/8CEUUB2jxyvRN8cVckQwFIbSsS28xpv1ReQT0ZaOhB6w92j1JEbBZ4QFx
IxZlFTHq4CBxnL5o/hESIxYkcgSmYRLGNaCM9nOjFbOfPoBK9qOmZbBGRA+Gbg/A
ugi9NDEfArhhmNtUtsPgJrx1aZFi8P9SR32oLmzPu9Qkb7N2nJchLjrEiG49fBhF
B7zNP63BSV/xgJKd9WzG3ZstS+uWuZ38YBoFLnUTeifTKgWLsNlce30CsLDsZaYl
VYVKm7i8ElqOHkxA5msEwoVCOfYx0BXxlvzLy7SdrkzAxYJmXXy6H1hHik1OB2tb
2jbpRqUMDw6UQoJ/jTazarSF7bPWJgSHqDX0nYWsuiTxSk2VAjUnT/o6/5yAwVA7
/sc1jP+eg/eRFB5Lf5+vm3QqSJZ/Qcp6j2AdVthX5zE7qOM9Y7SY7vPi14m/eur3
5AyVGjmC0DiJ1VSLV53ZD6j3vLA4lCFiiz56xhKdiil90a02HaEB0hHDn0a8+ETg
ulPCGAGUm5TLW+UvLD6/KZHzaUR+Y0wHbzIVER+fHbqvKHRD21DilwoWjXM5GiMD
xrMcshy05hhfUIRyYJGVgdeJkMLZBA5yDeRjftDkDr8zmTf73Ebxj3EKyGtwDk+7
F1Dl/gCAMlcLYGGJHCUzzpTyhaHFL935OIc4KUZWZTvVldnjfnw=
=dJM/
-----END PGP SIGNATURE-----

--uO3WQjuioYZTjmzZ--
