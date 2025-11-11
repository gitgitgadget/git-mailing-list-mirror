Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D422DFB8
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894363; cv=none; b=JPyJkxImMUBPWDKWmrt0c5ic24/L0w1C2gxpF4q44pm3uY7wdX2wVEepRnwoE1VQElBzhJ09HiPy/+18xfxUxGJXSQN6YczEG1Q2ysa3hOdsVagFUDrNSRuRsAYBRSp4BTRQEYYzC3HhCQZLdFmcz2KlKWu3hKYd7jg0gEJNCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894363; c=relaxed/simple;
	bh=1im9TiSoOg7iRzoL713ipNQnX+wTDwaZO4P9cvV9a1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1MoKCWQAKP8BZQP6qp9Gg574Rpc62MipChe9SYZLhZ+EQpBep6L2iTaAfnCzcLKw45Ec+Pz2Zv2Dd70NGghT1qbWF3aPWrTEm/Ky5tPFVKlZYCZrZdAnQHZ2SrIUzu33LoCHIHJKNIkk3KeqNC8UORwGfYt4FW5LxQSqfNhFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NYi1vzkL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I+hI0kS4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NYi1vzkL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I+hI0kS4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 954547A0130;
	Tue, 11 Nov 2025 15:52:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 15:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762894360; x=1762980760; bh=ZMuC8Rdj9y
	NO7J/p1oUSCUkSHiu8AGPusKSyg8yci2c=; b=NYi1vzkLP4e4CO9WxEYpHle5VA
	NWUoCyXgi3/uS74jNiQymL01BUtwtwMYfR8vil3u/v0+wyafJ1xM47H77F+Zw0Vu
	kfs3kxolU29B+WCjBmIdWMnw+DGXEnglRkwTEf62cQEg9trz65kZWfOpdzUrnObK
	27uns5nDgYAx+7eXDxNCKX1xyPl9b4pwBS5/ja+NtCt1gPTHRPtmS3vRbOaVDyQ/
	l3UYZ4D5WVsv9iMSTga7hARi9+Srh02BTg5w1hAugM/BrYmiUt1vhTPuz+ZgsCp1
	Ie5LYzzBaFrK8yYm/4e/Gnqh9D3gHvzacYMqaN9GeK40iIrXZsfFt1Pbuz2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762894360; x=1762980760; bh=ZMuC8Rdj9yNO7J/p1oUSCUkSHiu8AGPusKS
	yg8yci2c=; b=I+hI0kS4m4NYoOhuslthV4jzXAySG2OZq+DFJ9tyATsX8WkcAKX
	u5xttLSyCLKHq0/Lctqz7N+1LZtf/zw8noz7aDpoQLNyJOowiXAZkYjYHUThrRRr
	VyzrQ+zdlhWdOAXadt6ksJ8G9emXxMqv4rN7/T4Nk7ZsNtZzmzi3HSnSGK4XRn6F
	cssJVX7gAOYorEDwiIw5ItO5q73YloqLtspUi++4uQoHNbbHe4LERGyjXrhsJ2I4
	kf3CHhdyarxgnoWtGcsA5Cf2M4125k56KhpBjNFbDM/jixxSbhroTGbM2q3DNmDY
	PRSPYJgQdK7ZWy1PqvTwelN26yGbwgcC8sg==
X-ME-Sender: <xms:GKITabFGwfaEOjROOOYzqp-Moz9Q379iRXabOjtaJWFEoFeTp8LrJQ>
    <xme:GKITaXYaY-32OmpGRg1uMP4FChSeP0VMAtvYunu-FYh3WuA0ZXyho9BTu4lGnTXw_
    6vwN3tyWTUFAwmx4uXWe4Zd3WtfvfXz--5AHA10qbIYM7AtP5NgTA>
X-ME-Received: <xmr:GKITaTUGTWm4hNyzZhbF8tgdcvSOQo8ZxHOtITVO3Wa103pG9kh3h-KatPPGJeQr1ecsobAeUlZvoebgJQT3oJWoe7bihPqfDf3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GKITaVlgJC2ONetDRE_mO3yLT4iGTeRyH0deRwXdbafs1dRYk0iZXA>
    <xmx:GKITaWCKVw8QMMV7x2I2Hk2bFQ8a-UWbc0LVpoixLVFKPleKrmJkEA>
    <xmx:GKITacgo0N_KamGY124Vh4NCF8l5w4L-wMvimj_n1yoKzw1NwijWDg>
    <xmx:GKITabxdaNtb4H-Wo2chMLmUKsl4Kw_IaWrgLxgsPoQOYx7QsH5LVw>
    <xmx:GKITaTlH3MAOwSMsnDl_FfNNsES-LcabAZrPvMfMjdsdKBEXvfkS0Nsk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 15:52:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 01/10] doc: define unambiguous type mappings across C
 and Rust
In-Reply-To: <e5d084d340e874be52e7c3b056ada15ab5557877.1762890152.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Tue, 11 Nov 2025
	19:42:23 +0000")
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<e5d084d340e874be52e7c3b056ada15ab5557877.1762890152.git.gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 12:52:38 -0800
Message-ID: <xmqq7bvwwauh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +== Character types
> +
> +This is where C and Rust don't have a clean one-to-one mapping.
> +
> +C comparison problem: While the sign of `char` is implementation defined, it's
> +also signless (neither signed nor unsigned). When building with
> +`make DEVELOPER=1` it will complain about a "differ in signedness" when `char`
> +is compared with `uint8_t` or `int8_t`.
> +
> +Rust's `char` type is an unsigned 32-bit integer that is used to describe
> +Unicode code points. Even though a C `char` is the same width as `u8`, `char`
> +should be converted to u8 where it is describing bytes in memory. If a C
> +`char` is not describing bytes, then it should be converted to a more accurate
> +unambiguous type. The reason for mentioning Unicode here is because of how &str
> +is defined in Rust and how to create a &str from &[u8]. Rust assumes that &str
> +is a correctly encoded utf-8 string, i.e. text in memory. Where as a C `char`
> +makes no assumption about the bytes that it is representing.

Even though you write excuses for bringing up Unicode here, I am
afraid that most of the above is irrelevant tangent that makes the
point of this documentation muddier.  Anybody who is involved in
this effort would at least know that C's char is not about
representing Unicode codepoints (it is way too narrow for that),
while Rust's char type exactly is, and I do not see much point in
making such an apples-and-oranges comparison to spend extra words
here.

Another thing I found confusing is your mention of &[u8] vs &str.
Surely, Rust will have trouble if an array of u8 we FFI an array of
bytes we have on the C side, if the byte sequence were a broken
UTF-8.  But that would not be fixed if you only rewrote C code to
use `uint8_t[]` where it originally used `char[]`, would it?  If we
have on C-side char[] that has iso8859-1 in it, we still would want
to use uint8_t[] when we smuggle the result of passing it to iconv()
to translate that into UTF-8 into Rust.  Or we may pass such an
iso8859-1 encoded string directly as an uint8_t[] byte array to Rust
and let Rust side run an equivalent of iconv() to obtain char array.

The point is that "your byte sequence has to be valid UTF-8" does
not fit well in the narrative here.  If we want to move/interface
the handling of "encoding" header in commit objects with code
written in Rust, this starts to matter.

So even if it is technically correct, it is another irrelevant
tangent when we discuss why we want to use uint8_t on the C side to
help cbindgen/bindgen to map it to u8 on Rust side.

Wouldn't just directly going into

    If a piece of C code uses `char` to represent a byte, it makes
    it easier to interface with Rust to rewrite it to use uint8_t
    and let cbindgen/bindgen map it to u8 on the Rust side.

be clearer, would it?  We never deal with a single Unicode codepoint
or an array of them (we do deal with utf8 encoded array of bytes,
though) on the C side, and I do not think it is likely to change, so
there is nothing lost if we did not talk about how `char` in Rust
behaves at all.

And of course, not talking about `char` in Rust does not mean that
we need a rule like "if you want to interface with C, never use
`char` on the Rust side".  `char` may have its uses on Rust side,
just like `char` may have its uses on C side.

Also I do not quite get your precondition "If a C `char` is not
describing bytes".  What `char` in C on modern platforms would
describe something _other_ _than_ bytes?  Even the way things like
varint use `char` is exactly for accessing individual bytes.  Even
when it is used as a space-saver in a structure member whose value
would never exceed 100, i.e., a small integer, we would know and be
implicitly relying on the fact that the member is a byte-wide.

Thanks.
