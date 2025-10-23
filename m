Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1897F260575
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761255772; cv=none; b=uDlu/ebfQmiCYneePUq96xMiuaNzjXfF/Xp/6rQUBdVDe7eh5YZDG7blgvudsfZnZQuolve91UsYHRh6BWcclTr/vK2amxT8NrMDGKeAHdD0l+YTLT+FC17l5JrLUBAea6wUHh7Hw9Wgkyj03X2XAmNe2jYYH+qiKTbNNKvuG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761255772; c=relaxed/simple;
	bh=8FGqgeSDW36w2HMX6B5nUHuIP4EVaCb4gxNTH+CGVgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rb55lsDc85OHyC1mODbDx7GmOMUTDVWADTucXhU5NZ0NPARfjudYgb/Bqkv/5rUy1Y4STsRIJpYkwHUi4TWz8uOl5f99L+kjjRJnI8fn83MeOyMWTkYbjq7yIQZ/xYztnPNNgQvGWyOYosJ8Joha00YPS68BjIVhOqMKMhQ7gO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hYsvTNYh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u+ZogBIx; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hYsvTNYh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u+ZogBIx"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10A567A009B;
	Thu, 23 Oct 2025 17:42:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 23 Oct 2025 17:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761255765; x=1761342165; bh=lB+Fw0Q8P9
	oDfilizsSV/XCtWdlFJZvmUDtTWDX/FEQ=; b=hYsvTNYhapVSpUG4/KtRGT4SOd
	NB7ReQY5eX0l6/jjd8nU+l1Y1K1XKJSgi5yJj6uoTskd5oTol41NdnVMyjACAPgC
	uS3Q+m7OderWlFyB3tqW4V4BkoOp+uXVNiE07xpHcP02DPfakUSutJoXQ8u2L7RN
	2mXsdoe6MkPMVolRSl79Z96RJIBQSZBt2UE7xkcmdqnTtY+vsX9YCdlWg56O5YBN
	KBZRffCQ4JoLP8fjY2oDf97YsAqL3mVLnolgOesZzKQyM+Wu105DAMM7w6jMq1iG
	c58cwCCyeEM9iZO5KL/kveq6lxXLqvi/V34YqA2y1IexIgLftD8qlzd9xDJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761255765; x=1761342165; bh=lB+Fw0Q8P9oDfilizsSV/XCtWdlFJZvmUDt
	TWDX/FEQ=; b=u+ZogBIxwzSGiONi149YqGxCwZlJZLTNOOskGAy7/mnb2K7TGGs
	5wuQwbmvuwqzQdxLwesJivwdC5aV+sHdwusyYgffUfovazReTCoupmDbkUK8e7rs
	GS3m6dF9F4UZNeWiZdPijU8eVCHPc1HR4KSICCOCEFs4NX68KB2ya3REEy2JH+zo
	A4oJURZry5dIMGu5f/ZrWOB/sYieCqvzPVeJNSrJVm2okr/8IRqGuK/O3swT0JdK
	ICk+1X00StBr2Ww+IPdyyGl6gZHa6XmeFRF+pJkMpy2UB1qhvUzBMRB0d5Dm52bH
	FgHeHEPb50bkG9d7yXvTUxOEmceR7qUiCmg==
X-ME-Sender: <xms:VaH6aPl94gculijCJEo15fIhXRFKlJ0_4G8nRkp-VXIm72RtgQkNBg>
    <xme:VaH6aJs_VgPb1Z_HYdf_ecVRd4RiQwM4tYv4ri7PJsea2xIBDJmaOt7cWu4s93v26
    ag1jQP6iMYbafB15A4jh5sr4G8V_qo-oNHW6d0jhArheEj1Hz-1Xw>
X-ME-Received: <xmr:VaH6aN_p1JhB1NWWTgsBgHg0QJEAXQ2HVeYYlMuFz05VXM4VK1Yr1NexkShk4kaxbkE11dtlLV6GWs2BBymb6aVM_Uf_qls_2nz9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:VaH6aDMY-915iSBQuMcg5dzbzuydO73K_nGAHpKYB3SecPDvQeFz6Q>
    <xmx:VaH6aLHcwNm4UtUPSgdiDIIEzGIDP13TW9raIHs9iGjseEnqznNvsA>
    <xmx:VaH6aBRXjfInX0DkFdWtpJjTMIkuj0aEoo-Q9MTfFJkxGqP8O0LbKQ>
    <xmx:VaH6aItTEzd5vNPhrPs8F7TraZWrdgJAixHy4v8qyp_wXkJCU4dR2w>
    <xmx:VaH6aO-lnOrcp4zO5JvMZT-GlsafZ8SBx0CRmn19cjEEIs-8qdoa35QO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 17:42:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
In-Reply-To: <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im> (Patrick
	Steinhardt's message of "Thu, 23 Oct 2025 09:17:40 +0200")
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
	<20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
Date: Thu, 23 Oct 2025 14:42:43 -0700
Message-ID: <xmqqjz0ls3ak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Set up this infrastructure in both our Makefile and in Meson. To
> demonstrate its use, the generated "c-bindings.h" header is included in
> "varint.c". If we now adapt "varint.rs" to have a different function
> signature than the C code we'll now get a compiler error:
>
>     In file included from ../varint.c:10:
>     ./c-bindings.h:10:10: error: conflicting types for 'decode_varint'
>        10 | uint32_t decode_varint(const uint8_t **bufp);
>           |          ^
>     ../varint.h:5:10: note: previous declaration is here
>         5 | uint64_t decode_varint(const unsigned char **);
>
> An initial version instead included the bindings in "varint.h". But that
> would cause us to recompile all dependents of "varint.h" every time the
> signatures of exported Rust functions change. So instead, we now include
> it in "varint.c" and compile that file unconditionally again.
>
> Adapt our CI to install cbindgen(1) accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

OK.  I am getting this out of "make c-bindings.h", which looks
quite reasonable.

/**
 * Decode the variable-length integer stored in `bufp` and return the decoded value.
 *
 * Returns 0 in case the decoded integer would overflow u64::MAX.
 *
 * # Safety
 *
 * The buffer must be NUL-terminated to ensure safety.
 */
uint64_t decode_varint(const uint8_t **bufp);

/**
 * Encode `value` into `buf` as a variable-length integer unless `buf` is null.
 *
 * Returns the number of bytes written, or, if `buf` is null, the number of bytes that would be
 * written to encode the integer.
 *
 * # Safety
 *
 * `buf` must either be null or point to at least 16 bytes of memory.
 */
uint8_t encode_varint(uint64_t value, uint8_t *buf);
