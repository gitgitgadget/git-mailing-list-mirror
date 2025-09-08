Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573220D4FC
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313704; cv=none; b=dQV6Pf2NBxfQiUxVXoTquOCkCjGak0O4UGx9HEuUvT0UlaAeEStaCNlGej3VbxlWgIrAs7D6YBOa4+fMIcgquu3lW2d2qXQsFuFXowMLsd4pwCFxFVT/moajrKcuMhJpapKufrrWqvi4j4LRRPylcxdKC+429yLIeWkVzdTAhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313704; c=relaxed/simple;
	bh=p6vdiphujsMrDdA/scVgFVc6IwWJJe3bOfHUm//p7Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFpxXmDQRdN3sJTW/y1fUtHs9ZT5W7gHQynO5VII8oO+g61mn7T2IDJSIwvqn/lrfolDoxWl1olX8C9pXQYau7WHhtrknet/JAFODpQ25IMYF7l3e23sEG1wJRFU3XfVDCObDgvTrms7nSzfI5PmEm0rAc9bsSvaJt+x8VyGAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LnjHKzZi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GyUSEkoD; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LnjHKzZi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GyUSEkoD"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D6BE11D00123;
	Mon,  8 Sep 2025 02:41:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 08 Sep 2025 02:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757313701;
	 x=1757400101; bh=WuDdlMkNyUKzvGCQhPHfc9pQ7mlUXol8ZdV8xYsmiA0=; b=
	LnjHKzZi35JPRGDLJyb68Y9ojGyIxsuAouWHPg9STCFB1vRXyCwX4RXyjQ2mLxcN
	yL1VuC32VzHMVJqhNfrUMr0ID06cu/sB/4MlUFDPORwjPZknNviMb8zsBkP71Fpz
	n/T/pEL9qFwqqNhMoFpz5Q3+r81pLECpmlmGvGUA14NDNveYBZJWUMOvl8rbkI3N
	VN5jZ1Bj9xJ7CaZwjPKdLAf4MVdrHwpc0JbiRGWRGyS9bLowpMOyhtqf5muIf8aP
	TAXYRpWwzGmdTdEjxvRHTyiMfFVTo57d6/U1SPGh2Gv/jAemq18Ki97YV+1v6Tge
	1S6R4uXxOHMt4kesOJEM6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757313701; x=
	1757400101; bh=WuDdlMkNyUKzvGCQhPHfc9pQ7mlUXol8ZdV8xYsmiA0=; b=G
	yUSEkoDUx0ih0X139B9X5OnRlp4IC36NGHd733+Y4IHN/HE45IhvpceUfs7YOhJA
	+E2CuR5c4VdaFQsS4fT/YpwPlNdtvMsRVvMOBhbVrpwqk5OheKyK03bYLxxN8SLj
	rU7G3V4KUvs9u3Wq1MhHcg5yjZaNAtL+jThaYdhsVCZcx+XS5jKkqUVR/NrFu+PY
	g0DSNxfFWpZQ3YztgsUDqafp8i4O4BtDSQGL95XqmZwQBA10WjfG4G9PzZkWydAW
	gZ4bGRzG2BgiUpxZMDAZVyyMU01KMUAbO2SpQIpy73QvbvX7WGUsm0KFVuJ8PBZQ
	rELG99V8cwS1D4YbfDm2w==
X-ME-Sender: <xms:pXq-aNFUIzhqZd8WGJB6_P6RIDQ7y5TdzOY_B8K4csLH-cw_wOnIeg>
    <xme:pXq-aCd0plbDX7dOn28JCVU1eVXzRC_DPxML0r2Ix84fGzOH71P1ANkWTb-UO95Z7
    BRsgshEDM1fpTMBbg>
X-ME-Received: <xmr:pXq-aGmTY97aKBebnSdD9LhwHRg8H6wNm4VJ_ISy9sGd-uc-fL71UzjUbh3BTThDjYQkWSAaKeX7w8hagnWrZ0-GcQ0xqSiSAxu4esdzuDWNQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptggssedvheeisghi
    thdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhivghrrhgvqdgvmhhm
    rghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pXq-aJq5aManvU10-dZ8chg03FT46raANajHjZnpUc4UB3cxlxrHyg>
    <xmx:pXq-aLGGtlKy2mTeR_dMEjOpeQ6vYk2sn4e9riNpOiIShs5rZCXTGA>
    <xmx:pXq-aHRkEXJsZEILe0mkT9-xRDAn0pppR0W16ZK0dyWyVjzfnoGTIA>
    <xmx:pXq-aJNwQpg0Exg7tVybucXDBtsk8y9xUJVo5flvid-EbeAYkt2CCQ>
    <xmx:pXq-aDI7kVHgsN8YkhAfRkLXdhlnJ7zD72fSnDMjtAbcOlEVGsJasUwN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:41:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7bb7863f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:41:38 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:41:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 2/7] Makefile: introduce infrastructure to build
 internal Rust library
Message-ID: <aL56niL8LW-NbxDI@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>
 <CABPp-BEWS2=uHAjEf5YdahC3gxbjJ5L3NpYEgSSmsUa1dK=aeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEWS2=uHAjEf5YdahC3gxbjJ5L3NpYEgSSmsUa1dK=aeQ@mail.gmail.com>

On Sat, Sep 06, 2025 at 09:58:44PM -0700, Elijah Newren wrote:
> On Fri, Sep 5, 2025 at 4:51 AM Patrick Steinhardt <ps@pks.im> wrote:
> > @@ -3768,6 +3808,7 @@ clean: profile-clean coverage-clean cocciclean
> >         $(RM) $(FUZZ_PROGRAMS)
> >         $(RM) $(SP_OBJ)
> >         $(RM) $(HCC)
> > +       $(RM) -r target/ Cargo.lock
> >         $(RM) version-def.h
> >         $(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
> >         $(RM) $(test_bindir_programs)
> >
> > --
> > 2.51.0.417.g1ba7204a04.dirty
> 
> Johannes provided some additional tooling (an extra library to
> download from git-for-windows) that was needed for building and
> linking against Rust on Windows, which Ezekiel incorporated into his
> series.  Is that not needed here for some reason, or are we just not
> discovering that it's needed since you haven't created a test balloon
> yet?

As Rust is opt-in initially we can take it slow and first land a minimum
viable change with limited platform support. So I intentionally limited
the scope for now, but once this series lands we (or I) should iterate
and also bring up other platforms.

Patrick
