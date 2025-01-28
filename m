Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26E7485
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040218; cv=none; b=YR3F6Hg//ksOJhZqBmoyeSIaxk24Mky/5VxC7uJXebEiSebU+Kagas/DLRjn03JjSgRJ1GON61lU6A6ozAahBmwDAKBK44YiBlSxzP9VZNjG+F0BqbtXuLM3Q+YBnebijCC1YpkuAXL2LOMuzjxvzZnG72Y+QcHgPtHOVxkv0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040218; c=relaxed/simple;
	bh=ZKE0ub3QVL2RiuoJzUaagkQ/yVBYetdXOlT7eNhtVYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dLMUsI7dIeiVdiaa1sbKevF6I+W7UpMgJEP/XjBYVphMeix4YPTmOCbbV4VENfYjjVK5/GjVHI4QUmrZcQFvPtkQ5ZxiWSgb99RlPfJVk+SFmdd9zAJ5QsrJfng4kRmmpK46jQJljruDlKjj1em6b9Rn7Iz+ZWryH5e3QDK1Qug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dyP3F7Ds; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRUQivqD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dyP3F7Ds";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRUQivqD"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E742D1380AE3;
	Mon, 27 Jan 2025 23:56:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 27 Jan 2025 23:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738040214; x=1738126614; bh=T/5iP41Uta
	WekOz+Q64pprtIeYK1DhHLejBiln1ZXgA=; b=dyP3F7DsbnfAISdfzVGyWNS6rV
	GBSu7r3XSEnJfzWvgyxd4qUqpeSw7n0lNgj/bcoXms1uZU0wmPDw1+qr1EqCpofx
	kmlLNiulKaYC5NbtQjXLdYCg2Zymvc2Q3Rj+GEVsET2kmIKiFNBiqTNEWDoTzg6C
	LfqtBJ8MWrPhWHl/HIOaGcUPBfm2Oni+XsUhDyptFdoZip+sL/q0RWCon7fWKqkS
	12V5W5unj7ipCYJWgTA9sU84k6WWl1oj6RXXvYA9EDQvJa+zeipdWlePJXoxzBI1
	jRRyYe0wHHvnqEr3SIsUzloymK+4ki2K63+LwutzEnchBRynBeRGlIOJlFbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738040214; x=1738126614; bh=T/5iP41UtaWekOz+Q64pprtIeYK1DhHLejB
	iln1ZXgA=; b=aRUQivqDYAkOvTHD3GuHfFcF0frW0mdjvy7pBBKZD5auKhkEys7
	7QnQzwQPkdcO++lPDTNGL6hsnxZAUcvlTBAAEpvcM0p7hLAAGwUDt9H0IqfG+B/W
	I9rRrCTY3YuwGVmfRHsrZAMcqQte8snaI8QlptJb1a+ZFQqwe/Dhkcpv61NQzyF4
	nzNsVYSroZ18FzfSbUZmwyxBkJF2SaPtbFu+LbCIZgEiUuZFq2MjFh7AKHJFQATL
	Xcty1cLSdBQAoBU4pf40DiZp0iSqQGDxeiolQfUra8MUvvev8wUB+7o77m+fX0Eu
	LbT+1v4yo5VLC567XgtHLPbM4umaXjPsGXg==
X-ME-Sender: <xms:lmOYZ784ZH5zve0QUH1V_dTb1xE7rKzIDOYzXFuKozeoALiY_DZ6XA>
    <xme:lmOYZ3vfsRV_zQ3_LiZYwT0VIUHpdOEbIU8QFnSn_qmcIQ5BnSVbBGAYnUEc3jY8O
    UmOXJ5jzi9XEjIuMw>
X-ME-Received: <xmr:lmOYZ5ABSbI2oBXymEKq5jvs996Fkb7re2rZL7XOeYwkl0c-M68b3oNVV6CdCUj681iaXJXJEQ0aE6a0EUBldJSZ6k-pjxBwqdWC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmoh
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegv
    mhhrrghsshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lmOYZ3d2IBaRFQddSr8z4XUKRkDnQYnAUvJrthTDaCrJVTVnkP4wow>
    <xmx:lmOYZwMfOTp0T0gyK2Ue3jfFnmsfJ5c-AublSjd7Ix3qyzVSTyyWCg>
    <xmx:lmOYZ5mC2c12XFHXuymwKZNFwB2NN_k5T2YC2gOu2Nisc2dEeIrb3A>
    <xmx:lmOYZ6uim5bngP91dPccRQ8QPdxL8tFejYXw-PGJd7rzPdGEqeup3g>
    <xmx:lmOYZxhue8PSf1jSEBFBLZbZ9BI9vJTnrc31m-ILuhIzlH2Pb_y4G2TU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 23:56:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  nasamuffin@google.com,
  emrass@google.com,  sandals@crustytoothpaste.net,  ps@pks.im
Subject: Re: [PATCH v7 4/4] libgit: add higher-level libgit crate
In-Reply-To: <88425bb0b1b90cf6b3d2d5a1af57e46c7a03ad39.1738023208.git.steadmon@google.com>
	(Josh Steadmon's message of "Mon, 27 Jan 2025 16:19:05 -0800")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1738023208.git.steadmon@google.com>
	<88425bb0b1b90cf6b3d2d5a1af57e46c7a03ad39.1738023208.git.steadmon@google.com>
Date: Mon, 27 Jan 2025 20:56:52 -0800
Message-ID: <xmqqzfjbo7sb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> -.PHONY: libgit-sys
> +.PHONY: libgit-sys libgit-rs
>  libgit-sys:
>  	$(QUIET)(\
>  		cd contrib/libgit-sys && \
>  		cargo build \
>  	)
> +libgit-rs:
> +	$(QUIET)(\
> +		cd contrib/libgit-rs && \
> +		cargo build \
> +	)
>  ifdef INCLUDE_LIBGIT_RS
> -all:: libgit-sys
> +all:: libgit-sys libgit-rs
>  endif

I somehow would have expected this part of the patch to do

	libgit-sys libgit-rs:
		$(QUIET)( \
			cd contrib/$@ && cargo build \
		)

but the above longhand is fine.

> +    /// Load the value for the given key and attempt to parse it as an i32. Dies with a fatal error
> +    /// if the value cannot be parsed. Returns None if the key is not present.
> +    pub fn get_int(&mut self, key: &str) -> Option<i32> {
> +        let key = CString::new(key).expect("Couldn't convert to CString");
> +        let mut val: c_int = 0;
> +        unsafe {
> +            if libgit_configset_get_int(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
> +                return None;
> +            }
> +        }
> +
> +        Some(val.into())
> +    }

Nice.

I was wondering why libgit_configset_get_int() in [3/4] does not do
better than just wrapping the raw C interface, which returns the
error/success status separately from the value we parsed.  With this
higher-layer wrapper around it, the interface becomes a bit more
like a higher-level language.

Thanks, will queue.
