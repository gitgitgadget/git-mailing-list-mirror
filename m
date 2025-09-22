Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31D2D5427
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574747; cv=none; b=iPsh7CIcsJzSb92ggZOG288sqtYyQxLpE1H0D22mFaAdQ069PywKUot0kCCmUBXgleC+NdSvZON6Tb50AgX++1nW+ytYrttJUvp9GMvYm5uaTZ8cU7M/pRtRp3/EiNDVKVs+UmfYnTS8qVpZ4MWeB/Rv3NNWwDGiCPR+dSK7lao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574747; c=relaxed/simple;
	bh=O0fQJCv1uHJZxqWEybnbnRGaxXRh+d0gibBCQcXqNaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1sHIs54tZ/qIB6ggW3rCB9vYnNFBFBER/wea7AuRWqjMgU3cjJavA2N7Hh2aKrJ5S2X7o9/fs6lolL5JLDuS9VK1Bec9krJPirBoj1mfrZk1yhyTErVMVmCoJRJG3HKzrFrtv291eo8r0onRsWyDoi95cbMXrvdOXu0nzzXSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nLS817aZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+9r2JyT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nLS817aZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+9r2JyT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 199F27A0268;
	Mon, 22 Sep 2025 16:59:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 22 Sep 2025 16:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758574742;
	 x=1758661142; bh=eT6abeEvW6il6RWPFRYHM7UNgeLELqYqOD52vUCRK2E=; b=
	nLS817aZSIgH4KsBQ2VGDoYLHR3YWoOelUQRgdWEDXbboVdyRytUREUgkj7SO9Rw
	5E+K8LRP1EQms4zC6pWlao9LAQfrK/NOJTTchS8jPnDvp4ON4uIk3Pr63nh2PrSE
	Kq30pc4zxV3kVj1sdtxMUb6LA3Aowsr4zSqfKr/beRcxFdl6SdlNNzQ6p50RsnJY
	vrxEDyPAJrdSIWNg31LzzDnAs4GoMtR9AdI081y5qQGoPqPaFxRd0LTo5j6I/YVx
	zUpyLhqu/Ck/NQLPVKsvx4E6RsQ8IO9pykbHvFDmanNCc4EwcA8y0eRpZpKiNWiG
	3T0MRivmLA5l1YsSAzi76g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758574742; x=
	1758661142; bh=eT6abeEvW6il6RWPFRYHM7UNgeLELqYqOD52vUCRK2E=; b=T
	+9r2JyTrnPhm3uC9AU0P878PIMw/etxtXjElaNYAHfCjvzz45yx++C0oooMDrs7o
	E147d60vSiOkOO80OJhTsJNdDlBIF2PytBkyVmWnpw9xXQXEZcXyArCwCBRLpx6P
	sZlvx1Qf3Oi6MkAUgwqc/pNdv7uWwkA2zD831j262+vSUgXwtilaCfGoNq3dbdXU
	7V00Xp8AVHn831LhXCZCWdSyeLz357ZQPXwCQ4v6HlFoNP8rzojZ3ViiehLRXDK8
	LApq7phu6GAGnRMkPwc6Q3yIdsecKKc7Vn4gfeWmPKyDoaWLec01Bs/I0V2N0UQN
	YcZ27SIlqzT0CFL9TP0lw==
X-ME-Sender: <xms:lrjRaECzOrziSaVFP8yfWgqYHlkFu87Zdqj0Z0pj1eH7RF2UxjEtCA>
    <xme:lrjRaC2ci04DOxFX8xRemcPunbrRXWgbnMPJNj7d4EF_XMzSHJCqwStke5t1cgWia
    tfwWkqBKp85jzLJVuXwrUz3hVJNoJH-C_T5ax9J5q8fBBpg7evP>
X-ME-Received: <xmr:lrjRaJOPM5lEh98-iQyNNr935N6wvWKA6iYZ0LOkLSeGq9JPw2xcj0w02EsaVZOARd_Zf2PSp0bfvPqkvl3fvpJbI2QI-dgGNZm->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhs
    rdhmvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhn
    khdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtoh
    hordhorhhg
X-ME-Proxy: <xmx:lrjRaH7yuqxxKFET7Xmkw43-YHfhvin5dnK-1BsL4Ul2Kk6rN7oOsw>
    <xmx:lrjRaOYPgBQcYJNH2tZr-3hLYLRLxqcGJZcaYbg5WsuerL-ALDnqZQ>
    <xmx:lrjRaMFBfQfKxqqnJoa0mJg_QiEAghTB1DMlPJguB35KSNe7pfm90g>
    <xmx:lrjRaPkXFMKAdTmx0kvawkrUfnRyoHwqvqxQ-2pA9--liDZreYUJVA>
    <xmx:lrjRaFs8NEql9zcR_ftGW8pw-W98fg5_uX0qSo9AW41flP8uLgWItFA5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 16:59:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  Ben Knoble <ben.knoble@gmail.com>,  Christian
 Brabandt <cb@256bit.org>,  Collin Funk <collin.funk1@gmail.com>,  Eli
 Schwartz <eschwartz@gentoo.org>,  Elijah Newren <newren@gmail.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,  Sam James
 <sam@gentoo.org>,  Taylor Blau <me@ttaylorr.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
In-Reply-To: <aNGkt/DdnbjNu3s8@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Mon,
	22 Sep 2025 21:34:15 +0200")
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
	<20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
	<aMsxhp6ZO2Cdz7+k@szeder.dev>
	<aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>
	<aNGkt/DdnbjNu3s8@szeder.dev>
Date: Mon, 22 Sep 2025 13:59:00 -0700
Message-ID: <xmqq348etd9n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Thu, Sep 18, 2025 at 01:19:19AM +0000, brian m. carlson wrote:
>> On 2025-09-17 at 22:09:10, SZEDER Gábor wrote:
>> > Providing an LTS release for those platforms that can't jump on the
>> > Rust bandwagon is great, but...
>> > 
>> > Git 3.0 will switch the default hash algorithm for newly initialized
>> > repositories to SHA-256, which, presumably, will also encourage SHA-1
>> > -> SHA-256 migrations in existing repositories.  Alas, it appears that
>> > the SHA-1/SHA-256 interop feature will only be available in Rust.
>> > 
>> > How will this affect those platforms without Rust?  What will and
>> > won't work on such platforms?
>> 
>> On Git 3.0, nothing will work without Rust because it will be mandatory.
>
> Well, "What will and won't work with respect to hash transition" was
> what I meant but, alas, didn't convey.

But "here is a topic to consolidate everything we talked about
starting to use Rust" Ezekiel works on incorporates the "dip our
toes in water rewrite of varint.c into Rust" Patrick started and
"Rust will become mandatory" policy document written by brian [*].
At 3.0, the WITH_BREAKING_CHANGES conditional compilation option is
removed and the conditional code paths protected by that macro
becomes unconditional.  When that happens, you won't have a git
binary from the source for that version of Git at all, unless you
can turn varint.rs into varint.o (which typically is done by
compiling the source with Rust toolchain).

So I would think "nothing will work" is a very fair assessment of
the consequence of that policy.  And the answer would be the same
for "with respect to hash transition" question, I would think.

The version of the document in this thread talks about 2.52 (opt-in)
and 2.53 (opt-out) before jumping to 3.0 (no way to opt-out) but it
does not say anything about how far out that big version bump is.
But the numbers I remember hearing was in the orders of 18 monts or
so if I am not mistaken?

As I already said a few times (e.g. <xmqq8qipzhg3.fsf@gitster.g>), I
feel that the timeline hinted by any of these documents that were
proposed is way too aggressive for affected people to practically
prepare for.

By the way, I was hoping that the hash compatibility work can be
done as an opt-in item available only for those with Rust, while
Rustless folks are forever stuck in a single hash algorithm world,
and be released well before Git 3.0 that makes Rust mandatory.  That
does not change the fact that nothing will work wrt hash transition
for Rustless folks, though ;-).


[Footnote]

* By the way, I _think_ I never saw that policy document until
  Ezekiel started his topic and sent it out as one of the component
  patches; how did it get there from brian to Ezekiel's topic?
