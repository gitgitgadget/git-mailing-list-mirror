Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53F1F3FF8
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755981395; cv=none; b=IhiAo3wIlUdlDULQWI6QgGtQI7G2xwNQphgrc7n3d/sBUHD6TqlF6q5x58hQVmIMvTGq5Tp7Sg3OWVFbcp3nRcMUGEcE1h2igQLs1+3J0vbdh4xfPGMWnJ/u5N5Ulxh0KCEmL4zZ6CA8Ns2NoD2bRbrMcvCoObt+6okS/Gp0IB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755981395; c=relaxed/simple;
	bh=vpwPWjs+L7sQviJVZSZIaGcloZaTMGDmtVx6RvjhfO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R4as15Ei7RBbpNEK48dAFmyfK1SMSNKgf/e/+XMNFRiGzqYPfMk1jwEnaJ7bmmQLVwNgc/yblZPF0MBStequoH4EVk5F4RhbT1ryEjPB/hB9ZPNELakmlL1XWiFFexFVev85qIp/Mhnitigt7/IlJhbEHMoLT4l19jpqEqgVKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6ACA03409C8;
	Sat, 23 Aug 2025 20:36:30 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Elijah Newren <newren@gmail.com>,  rsbecker@nexbridge.com,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Christian Brabandt <cb@256bit.org>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,
  "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Matthias =?utf-8?Q?A=C3=9Fhauer?=
 <mha1993@live.de>,
  Patrick Steinhardt <ps@pks.im>,  Collin Funk <collin.funk1@gmail.com>,
  Mike Hommey <mh@glandium.org>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>,  Josh Steadmon
 <steadmon@google.com>,  Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <aKoVcVexWi212pAl@fruit.crustytoothpaste.net>
Organization: Gentoo
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
	<03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
	<030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
	<4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
	<031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
	<CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aKoVcVexWi212pAl@fruit.crustytoothpaste.net>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Sat, 23 Aug 2025 21:36:26 +0100
Message-ID: <878qj9bws5.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-08-23 at 18:30:26, Elijah Newren wrote:
>> I don't think that's fair.  A quick reminder on the history: There was
>> lots of excitement about potentially introducing Rust two years ago at
>> our virtual Git contributors conference.  Taylor formally proposed
>> adopting it on the mailing list a year and a half ago.  And at Git
>> Merge last year, among those in attendance, there was broad
>> significant interest in adopting Rust with unanimous support for
>> letting it move forward among those that were present (which, yes, we
>> know wasn't everyone).  And there's the three rounds so far of this
>> patch series.  At every discussion where you weren't present, someone
>> else would always bring up you and NonStop, and point out how you've
>> been a very positive long-term member of the Git community and how
>> Rust adoption would likely negatively affect you, which would be
>> regrettable.  We waited years to adopt Rust precisely (and I believe
>> solely) because of your objections.  Josh and Calvin even went the
>> route of making optional not-even-built-by-default Rust libraries
>> (libgit-rs and libgit-sys) when they wanted to add some Rust bindings.
>> If years of deference by other community members isn't considered
>> taking you seriously, I don't know what is.
>> 
>> I agree that it is disappointing that there isn't a clear way to both
>> gain the compelling advantages of Rust while also retaining the full
>> current extent of our widespread platform support.  It's doubly
>> unfortunate since you're such a positive contributing member of the
>> community.  But not allowing us to ever gain the advantages of Rust is
>> problematic too.  So, a decision has to be made, one way or the other.
>
> I think it's worth saying that I do appreciate your (Randall's) positive
> contributions as well and I would love some way to continue to support
> NonStop as we adopt Rust.  To be clear, I care deeply about portability:
> I have owned PowerPC, UltraSPARC, MIPS, and ARM hardware, and I test
> many of my personal projects on at least Linux, FreeBSD, and NetBSD.
>
> There is an alternative Rust compiler, mrustc[0], which is written in
> C++ and that I have played around with to see if it could meet our
> needs.

As far as I'm aware, mrustc is intended purely for having a bootstrap
path to rustc, not to be a full blown Rust implementation.

We discussed the other options in this area in
https://lore.kernel.org/git/874iv4gqxv.fsf@gentoo.org/ and Patrick's
reply.

I still think it's dubious to move to something where there's only one
implementation (and an implementation that moves very fast) when
currently we go to pains to support even incomplete C compilers! See the
"test balloon" for 'bool'.

> [...]

sam
