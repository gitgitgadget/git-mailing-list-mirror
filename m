Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D928643B
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108784; cv=none; b=XZbfVpgT/tXgGoh0hPVgtVvrXBM4Q3Si0hayaOXNzl9DapxM2qtldlCXPkXKlVny3BB5x2hgzWAN3LSU172/5nGBOJZ+hHFZRhCtqwYqf9kjNfw5NPr81L+gweu8iIANB+8q9re83ZBz0uZJIqhjNdsAmIwZILTf4c7SzCBaJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108784; c=relaxed/simple;
	bh=afs2reMGYKLJXIm+7FQ+76nhAbpqFuyPFwwi+SqXeeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g1KBZVWPQlvdKa9wbHZTg7erHOuMTTH2LLU5ufy45bLnZPgNY61U5OtctDc9AErdJxoAAJjsVibXz6SxIbKhmaFy5PlPisERuv/CYohR2iVvazGIBJhVDcIhNA3pQbgEMkgOJ9RTprEpJRw8EyWlT8VeqL2anwdVvKimj69fimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zXtQy58g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ORh2W5Lb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zXtQy58g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ORh2W5Lb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 794C0EC032B;
	Fri,  5 Sep 2025 17:46:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 17:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757108781; x=1757195181; bh=qW9nSAbXNu
	W+x6lFwkMKHqo6TFMlLPkO0sP8yIH+Fe8=; b=zXtQy58g5QfYng4IEctqnvQx4e
	lz6FM8yhdD3VEvSqqpobwbBKo5vrtbYkfuhwDiKcNBZkA5XAURfWnNpCmI832A5/
	Ppg8o1dMKxh7AoCeH4bhBId+XjNuteUFRtXjI7JaTRZxte3g6jN7BER0HTX237XC
	TWjFOGWUhYT4qAtrXuE7tY6m7zegFQp53mv2Pfclo3JbyYmPlcb3Ge91mxcvzQzc
	Irqw0MocA3GMBaZJ0QweYJYwheKzkOPY8ZJA3QFs4XCA/m4sdWdlaMAOf/pkEEbS
	m3MxJd7wGSQoUt027JUHPCKKEj8YIuuQUt9yLQOfRoJF7wsD7VTsTG5QpH/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757108781; x=1757195181; bh=qW9nSAbXNuW+x6lFwkMKHqo6TFMlLPkO0sP
	8yIH+Fe8=; b=ORh2W5Lbg+7v9UMmTeCx8EjxT/senRdhs7UP2CQ1ZjpUpgIeBn0
	sStyxIijpPc1zDdqR+GomJWmB4My20ns+5942a1P9lK1MIYDC27hNWX8fXTdohVC
	GZSdDD/YYCAVMAImCFUwWRN/HTvfvy/M+KCxBu6Vup9GXq7gbOlT622X1EVFqJ7W
	v4ZZmshvaGWJas2TmzaIkZX1HNJpxTu/E8TjKNOW55OAnq1P05UQGAvr3519ihm9
	Ss5N4JeuOkOwE/qOCS/m3VOwNvLRj2YB/7fXHjksIQOKwq+SkfenTk+vu+Psp5wu
	EQP9Ftkf4OioALXbxcrQz02j+9AOpBHNm3g==
X-ME-Sender: <xms:LFq7aKLIdQw523vPAgsL6AU0r5BCMcC3Qk3BtMOnMVCtdh8k3TxsOg>
    <xme:LFq7aCxpo_KmZnjEMevnU2CX_Y98DBWZEUvvQlVvvlZqrjmd_Rkz11oL2-u0dX8O-
    9x-2UynnLOgl3i8sA>
X-ME-Received: <xmr:LFq7aF0fM5O_9Mcx5OTie4-WvN76R4YcJFY85IXRfosANiCjRF-p0r411Wed8w6C1Ycbc0SRRMO5kTlh_SjW7bleeQCv9ZEi8MGXpiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghk
    thhivhhishdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllh
    hinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:LFq7aD_zWEUJD-7RHlhEhbJYQq23sf3YUn8xQa-2oZMkl65K4yg--Q>
    <xmx:LFq7aFSLMQVYXtkps656y9s1QiPvDKlxwhLCmeeQ08oKY1oMQanVqA>
    <xmx:LFq7aKlSBxdN9UU-50gZKRRy_Ll37nMucoa5Pzz7pQGTiVstGwmPRg>
    <xmx:LFq7aAVGtAOXsgoJqlWKV_sWY-h-memB8uMeOvmuKlyuyF1C8zF0EA>
    <xmx:LVq7aB4HsSWFEztP86QXDUsILdsOlyCnR7bsZaHWKTonS-pKXDxZdADv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 17:46:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 4/7] rust: implement a test balloon via the
 "varint" subsystem
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-4-6939cbf4a0b8@pks.im>
	(Patrick Steinhardt's message of "Fri, 05 Sep 2025 13:51:00 +0200")
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
	<20250905-b4-pks-rust-breaking-change-v2-4-6939cbf4a0b8@pks.im>
Date: Fri, 05 Sep 2025 14:46:18 -0700
Message-ID: <xmqqy0qs1sk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/src/varint.rs b/src/varint.rs
> new file mode 100644
> index 00000000000..3d41760a555
> --- /dev/null
> +++ b/src/varint.rs
> @@ -0,0 +1,92 @@
> +use std::os::raw::c_int;
> +use std::os::raw::c_uchar;
> +
> +#[no_mangle]
> +pub unsafe extern "C" fn decode_varint(bufp: *mut *const c_uchar) -> usize {
> +    let mut buf = *bufp;
> +    let mut c = *buf;
> +    let mut val = usize::from(c & 127);
> +
> +    buf = buf.add(1);
> +
> +    while (c & 128) != 0 {
> +        val += 1;
> +        if val == 0 || val.leading_zeros() < 7 {
> +            return 0; // overflow
> +        }
> +
> +        c = *buf;
> +        buf = buf.add(1);
> +
> +        val = (val << 7) + usize::from(c & 127);
> +    }
> +
> +    *bufp = buf;
> +    val
> +}

This (and the encoding side) looks quite faithful translation of the
original in C.  Interestingly, disassembly I saw looked a lot more
optimized than the C variant compiled with clang-19 -O2.  The
difference probably is largely due to its omitting frame pointer.

The comparison to detect overflow compiled to direct comparison with
0x1ffffffffffffff (both in C and rustc/LLVM), which was amusing,
too.
