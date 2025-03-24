Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A425D530
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830979; cv=none; b=rQOkeM2L1Z9NKv6CY2FGLMlP6JSPYRPS1X6XLsb05AMLNAnqcSfH6Oy0j4dZyeOeGnfADFIyfkyLIzvWEJU5hhSjktQ/eHKIqHkyVL3MezrgjOpDgxIv4lEjb9A7sWyrp/KhMEoT1dXFD0xwNuTO96q0vOea7dd20G9ey+MxqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830979; c=relaxed/simple;
	bh=PaGITsKVvDwR0OMzvf4FCYD3cVHcby3KFeMzZBvzE20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PDCrcetM1be+V64pe++lshQ0Fo9KQqjEy4CL7zQZY99HDVkqvJLLaNe4Bow7IhEtmfO3zh+7muladLlkwuh9yGvCa+uF/Xt4OxcmLWRUxTHOo7c2dLJJFSa1ZYWGuiqBaZN49+g7rDXQSTrjronuipqhCg3Eh7Flj/tCZXXBKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K3hZFHfw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aacHElsC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K3hZFHfw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aacHElsC"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87A8A1140094;
	Mon, 24 Mar 2025 11:42:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 24 Mar 2025 11:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742830976;
	 x=1742917376; bh=PaGITsKVvDwR0OMzvf4FCYD3cVHcby3KFeMzZBvzE20=; b=
	K3hZFHfwInUZZwCgoMST3IXct92VCqTfHx9VJtmw7nIyfQUblQlSvqcqtcPJIzSr
	csnWvs3zO85FtFXNetW/HlgFPZQjPQ2T8VA1C3Do5/+Twa/QOyMkOW1L3zzZk8V2
	v1bdG/VVnUL6/rKweBhJp8aus7ilWoRvve4H5Fl8EkNSywqNcbT6b/4J3x7FVGoo
	Ujx9K++VUxpIUPkfU4+R2RoNseulOapDNdZVL3FgGD4tIa1v4NibYu/kHpfcQOLt
	TpNUk5o27D3fs9OJvWPt8EES3y3G3TtYSAQdxZvqrFV/vbjOk/iyh3n8jvGYL70R
	317BDlHPEl5ouwcGyykY4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742830976; x=
	1742917376; bh=PaGITsKVvDwR0OMzvf4FCYD3cVHcby3KFeMzZBvzE20=; b=a
	acHElsCnSiSPkTFr2Dt4sqRPWJTEinSNgFmWo7cImpxE7QWYtvepArNcMoFcFQcv
	rzUNV8okN4HJG8ynLghj+IH3Ga/UvRlY5Ixd9+WK64VUythMCDz70FskSCq4HF1K
	3P7IrGMoOCErq+KMWX78fZe25vu/j5DB3IruuQLAxtBlZu4hWHcLzm0DPN/ZcUAI
	xD1h+VQelNq1DCthfnzR7JgaJIcyyJiBs2hd1IbWUnNe5nbuvUcOCKDGP35zzvgJ
	2RwmppZqSMyrGe+d7uc74wkwsZkcILZbPWlHxZTi8VqpN6gj+xYv8YVE15oCiTdp
	on93oLKFe7La3nazjIuYQ==
X-ME-Sender: <xms:gH3hZ5Yq_4wt819eBaOET8TdSxrriLVq6vi323IS6NjBJT4b46Ij-g>
    <xme:gH3hZwYCJudHlxmN2Lgwnz_svsSkNgcYi8KdYrUA9PDsmVBHI0-rk1loGDEF1IcU2
    sDr5jwRnTNUeKduoA>
X-ME-Received: <xmr:gH3hZ7-Y6JnUv0Feuj_otK2TCZPVLd30UBnZnLIhm8WuXhEdfykTG6EK_w694i2NZChcT8siwNKz5CfrKT_sQmaLIxwPIt8PN4dk_TI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeggefhudefkeegueeigfejhfejvdej
    vedtheeguedukefgieelfeeuteejieeuleenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:gH3hZ3oPPDgnELbgti9y_rS-l7kjtMizXmShwtFz1LzYo95wq6UcEw>
    <xmx:gH3hZ0r3NTTU942Wh4JimhNJvPfB9f50CsHnL5dgamux1-hFGJ__nA>
    <xmx:gH3hZ9RiRVy0CpfVfi9JjDvtMR4JxNRU0VLRNPHM5jM4BFeVROtwrw>
    <xmx:gH3hZ8odYwYSEGolRecXwl7fdapyKX1uEoUtwatQXW4BbKTr5ESLmA>
    <xmx:gH3hZ1dhhAIzh3wo67Bdj85FXSLQNK05OMMXQhbLpB1OrzQmozNWdhA6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 11:42:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/5] libgit-sys: add symlink to git repo root and
 build out of tree
In-Reply-To: <CAPig+cQ+05r0iJO3me2=yz1KWaU_S_WQmbeciOqZGxYWgbT8dw@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 22 Mar 2025 21:46:49 -0400")
References: <cover.1742339107.git.josh@steadmon.net>
	<cover.1742594960.git.steadmon@google.com>
	<6befc95a2d0893aa269142a18d60ad07e79c6e88.1742594960.git.steadmon@google.com>
	<CAPig+cQ+05r0iJO3me2=yz1KWaU_S_WQmbeciOqZGxYWgbT8dw@mail.gmail.com>
Date: Mon, 24 Mar 2025 08:42:54 -0700
Message-ID: <xmqqo6xqo2o1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Mar 21, 2025 at 6:14 PM Josh Steadmon <steadmon@google.com> wrote:
>> Unlike `cargo build`, `cargo package` does not get access to the entire Git repo
>> containing a Rust crate. Instead, it prepares a directory starting from the
>> crate root (potentially excluding files, such as those not under version
>> control, or explicity excluded in the Cargo.toml file).
>
> s/explicity/explicitly/
>
>> diff --git a/contrib/libgit-sys/git-src b/contrib/libgit-sys/git-src
>> @@ -0,0 +1 @@
>> +../..
>> \ No newline at end of file
>
> Meh.

https://github.com/git/git/actions/runs/14030831429/job/39278185588#step:3:1

All of the Windows test jobs (not build ones) are broken due to the
presence of ../.. symbolic link.

Is that ugly hack the only way we can make this work?
