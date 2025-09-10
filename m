Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FD306488
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492532; cv=none; b=ESPGC9WT2fHajHBzvH76WpytUgKLFCaTWbcXEo82ivFld2GU31gJE6ByMygPjCTMPzuYz+OQppsNS2Wh4BvvU7Yr1lKmIBZgc6A4umOxo5jtVFSO3mJfMbJfP/Lc0+lTKd/bXH5/GTDFX2nxPRfI9YNXk7homB4AsCTOykODQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492532; c=relaxed/simple;
	bh=tB2U+z6fXftWLp3WCv6bOW56c0PoL8eO2Nl6sN8aJaA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewmv84geEb6e121wChSvmu5plr6LeYlwcdid8hQO2WBZDqOVxmZTrjNePGwoXUL7Crl6LdHeQYbj1gG7Y2j+/dRGmxS+FFjS6rcXnbz1biri+geYtozSY0gR2OvCes87F306LFQazdb16ILRxANaaWbFqMFrU1YbTfxZTKiTWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sw5LNTDH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hemx//ma; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sw5LNTDH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hemx//ma"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 704AE7A017E;
	Wed, 10 Sep 2025 04:22:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Sep 2025 04:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757492529;
	 x=1757578929; bh=4FSzixgegFjZ9rUATit0QzC3qsm2EYKq/lNaquxpSTU=; b=
	sw5LNTDHjYIbHEzeB0aRiupAcWlNvqyUjGgblnwFvt9xSrzYYNVrZ+lXRqYTjB0+
	6qRha/+PDsv+QAdRlN+zNEiCeTob7yfuaPsTA65b9nCPC0Fsu3+mBR9RI2m1oZV2
	0q2MOmYCNMaVHw7cQ4NoIlQCApnSWDhscQebmBjmUGGigrQ3cvIAqfyxKbs7RnO7
	mj+vwRAgilr+kmkzCixzXFIQo1jCNZpLirovtyxyp1W/5kq0eRHT+DUGGet1NlQg
	gUpg1VIj4za5MqYEhJVx71DBQVTv47Jglu4qVmAjvM45I8n1ueZs3NRHwgLO/OkD
	Q+AYdl/97ooGrF1xsgBheQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757492529; x=1757578929; bh=4
	FSzixgegFjZ9rUATit0QzC3qsm2EYKq/lNaquxpSTU=; b=Hemx//maUdVBhmCc7
	K4LKqwGTzespFbnqc1XtBpKxXvmqHDOBCn7JB8gV6RcKYBrn+sDZT8su0j6ds7/K
	8UIi5vQjN6si5SgPdSiYHXrNiTqIn1Zj5Tgm033ZIm5y3WwaA0ODCQ+yU+gckLtM
	3wi6GcHp1F1DK/UMXRFZw2Rok8rpceAR+EOAHkSEu7IEvh8ycAme8PCTIUFmqtfa
	F1FZPf87uUAyGFx5HTKgErKbMaNNxO4GnMlVVOod2Kfd153TOzNxKlUpVn6aCgmn
	7Zr7WEwkYhhlS0rh+Cpo6sVAdqJ9ZU8Icv0RpwTMOT7ZroL6iehoLTKlFWqSpGeX
	eeoiw==
X-ME-Sender: <xms:MTXBaC87RAHzNznrQE8TgTjYKhu1CI0yrRsuVs6iwkjD2Nm3v7yudw>
    <xme:MTXBaC3-SGuq1RdW6-DcZElq6MrK2P9Al-fZ-BiizngE8VxDIOteN-atH4sKEDXWC
    053_M6ZptOm1Uq5kA>
X-ME-Received: <xmr:MTXBaPe7ISGJV7K0pBHZrDibVwQugbrcN8bfn23N_NR-kp1CzoD48vjXBDZIwjOVyOLRybYeWdG13QCEYefVgm6hRHHAFniBcZmxH02VAM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    duhfefvdehtefgkefhtdfhudfgfeettedtffeifefglefgjedvhfefvdeuffelfeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgs
    vggtohhsmhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohhnthgrtghtse
    hhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MTXBaBCSt5C0WBep8f335VYCG4poaMXwb16gW092NTYL3pylVTv8iQ>
    <xmx:MTXBaO-0ii1ybwIMb2HIYWe7yBQcKt5qWNWsxz7LMCKKoBm28gizdQ>
    <xmx:MTXBaNrIHKXAGmJkY9Q8EUvusjwqT5PRSei1IA8RJfbd1ly7OHrp5w>
    <xmx:MTXBaAHUV5IcsGj-xmEc3W29XSMl6avkmdOCbmMdq82ZIEqfWEMg9A>
    <xmx:MTXBaOgEiFLkbvhUk2qKDC4MqG5Zte53pZz9Runi_tW0xZJuwJP8Ks2G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 04:22:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 396d5567 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 08:22:06 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:22:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v3 5/8] rust: implement a test balloon via the
 "varint" subsystem
Message-ID: <aME1KgygXon5jOQC@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
 <20250908-b4-pks-rust-breaking-change-v3-5-1cd7189fed3b@pks.im>
 <CAH=ZcbA_8JM1hdUAfFe3ho0ShuniguEpV1308S0nCkCHOCsmmg@mail.gmail.com>
 <aL9XOj1sVmHGjDRn@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aL9XOj1sVmHGjDRn@fruit.crustytoothpaste.net>

On Mon, Sep 08, 2025 at 10:22:50PM +0000, brian m. carlson wrote:
> On 2025-09-08 at 17:19:20, Ezekiel Newren wrote:
> > On Mon, Sep 8, 2025 at 8:13 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > +use std::os::raw::c_int;
> > > +use std::os::raw::c_uchar;
> > 
> > I'd really rather avoid using C types in Rust, in favor of using Rust
> > types in C. I have written a commit that talks about why C should use
> > Rust primitive types and why Rust should avoid using C types, here:
> > https://lore.kernel.org/git/2a7d5b05c18d4a96f1905b7043d47c62d367cd2a.1757274320.git.gitgitgadget@gmail.com/.
> > In my opinion, the type c_void is the only appropriate C type that
> > should be used on the Rust side, and should be used sparingly.
> > 
> > The std::os::raw::c_* directly inherits the problems of core::ffi,
> > which changes over time and seems to make a best guess at the correct
> > definition for a given platform/target. This probably isn't a problem
> > for all platforms that Rust supports currently, but can anyone say
> > that Rust got it right for all C compilers of all platforms/targets?
> 
> It also poses problems because if we use `c_ulong` and it's 64 bit, then
> trying to do a `.into()` to convert it to a `u64` will cause the
> compiler and linters to complain, even if it does compile successfully.
> But on 32-bit systems or Windows, `c_ulong` will be `u32` and it will be
> required to convert, since Rust doesn't allow automatic conversion
> between types.  I have some personal Rust code which works with
> `mode_t`, which on some Unix systems is 16 bits and on some systems is
> 32 bits and it has made me want to scream quite a bit.  It gets even
> worse if the types differ in signedness.
> 
> It would be better to do `usize` and `u8` on the Rust side here and
> `size_t` and `uint8_t` on the C side.  I think `unsigned char` and `u8`
> is also fine, since we are not targeting systems where `unsigned char`
> is not 8 bits in size.
> 
> I don't know how you plan to deal with the fact that Rust doesn't expose
> `uintmax_t`, but I think that's 64-bit on all known systems (because
> making it 128-bit would break ABI and nobody wants to bump libc's
> SONAME), so you could try `u64` and `uint64_t` for the value instead.

Fair. I think for now I'll add a preparatory patch to make the width of
integers explicit in the C part. But if we agree on the approach picked
by Ezekiel I think it does make sense to unify this towards Rust types
eventually.

Patrick
