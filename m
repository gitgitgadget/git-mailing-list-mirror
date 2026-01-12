Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202A30BF59
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209707; cv=none; b=uYNBwQQgqTq8jFZPtldzG8eW5lccq5l/KpgWiagOUzgjB884RTJi6RUdwbFA6XRaNym3eDv5QKgi546UYIgGYJKL2X5THxeYUAl6Zho6XnxJL3MufOcFuRxyj6OlYxCHs7bU3EsfY/D2y7ihYRpl7G585To7jz3+m/QWocnJmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209707; c=relaxed/simple;
	bh=85VeA9XW9/l8WnqCaIV5CJMkTRHujJAoIwIgXpOy3Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjjVGC3PR2hdEgvrohW+alHXPurKeU3gmdrUQyXqQCcHx/Ry+ARsBfpjnXDSfQ8eY3jiHTbNtBJPB624dte+NHpsaghdDwDkue050DhIu3K0RGTZly4/OZ6rwJLXMEHg4CDeuw7SewKfRViPI3KnsPuin6bMWPUSgxRjLuMWsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hMxFG7CR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aHe+B6bp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hMxFG7CR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aHe+B6bp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C8EE1D00089;
	Mon, 12 Jan 2026 04:21:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 04:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768209705;
	 x=1768296105; bh=6z5IUEPjPuEF0xF+odD/zYVl/LlzUAxMGyNF3aujhJg=; b=
	hMxFG7CR341+ReQaGu57008NiabS8htsf+o+zDU5kEIAZRRmCbI6VKvqHLbUGpS0
	tyns6SUdjCtHyC+WozSE3obLveRSkxjGipLpXTdtZFUaX3wcXNfYIxUBMKkrZSwM
	ELvF3gjBbN1rNsMgrmaUsItAKmJQ7tBbqtWsyUtq2ptVeHdj94afN83xA1lxCsGx
	++mn8F+HiI+IEVoJoUEF2CKhC6CIeCHEvXw+69FqcK6ZlQ5Aecy3nbDuR9kEdajP
	gKj7jT9m70YbgBUKrgH7XBpirxETgzpsIWnAqZwcm1pLKuLCbVRrX+7G7BGbTqKR
	9L5K/kO30OvIFSL7jB7e/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768209705; x=
	1768296105; bh=6z5IUEPjPuEF0xF+odD/zYVl/LlzUAxMGyNF3aujhJg=; b=a
	He+B6bpLxJRilnptOoz0L/dD5d8p1kLV+3LbC0h1lg05BQ7WFzDMroiTK5lutKfB
	bUe8gSK6R3cWEyA4hopurQyOWMg8Q+Lu8jMMLCOBA1PRdDaA29O646zQW9HGZN7f
	g8ZsMewAf+ssvq7iOAxnGowpkLTEiFPmkvooM4DX0pvSWntD8AcMIyw+KXM3OqFh
	6K14UZQrYdY/JWXB+nxOvyswkB86hpGTNlhaO1UiN/ss2dICZjgJIIlJawPaYaJ6
	kkOIepLDpHTSIsdaCS76hPcyfvNgzFSxZ9IwX20mVyUwWRskYfjMEheKyQCKn87R
	4ELSjT+bWZonkya9WaWIg==
X-ME-Sender: <xms:Kb1kaRk3yOhnxWb203WIWjafd6pwx89w_JjMuOo3WOHmpVq-LV6EqA>
    <xme:Kb1kaS2LX1C-0D8sgSxhY2NwW2lLb_wa9jwFTT9IoZQ5nyu-mlsc5ljn1KnV1j4-j
    K4DBH1q03osu5aXv0h4rS5K_zxjF_WSUqJ8WNE6onE4ijotVGtsOOc>
X-ME-Received: <xmr:Kb1kaVSmfZfVtRNGqhchF8M0Q39jqV9n0q-pQXI9QRk42a51C7BYRLHJZ0FOqLM3nidaZ4riDTAJC3LX8-dstB-JiCwmlDbpuPr2M4zALQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Kb1kacuSObmaEjnz_ZwyOFD5Bz70k_59V1TqwYwrmHxAoBsaj-0QXQ>
    <xmx:Kb1kaSZgUN7kc9s2pwqDjtKbYE9XfTJI9FcWNfAREIYSCQXrJtYmRw>
    <xmx:Kb1kaZv_OhMKvNpHYqrNNvcBpyOMXm_UNgJcxYQVLBsn5HEL_g2-Wg>
    <xmx:Kb1kacHJPBrsKdLEu5Z_0cHYoezjfzmCYEXPdLQf9vrCS8zVLKPL1Q>
    <xmx:Kb1kac_Fq1OIc5AfCxtCs409w2myVB0QRYNmrG400oNvxvbbDEGSUWF0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:21:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d157ff3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:21:43 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:21:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] environment: move access to core.maxTreeDepth into
 repo settings
Message-ID: <aWS9JLb3UyxOwg9Z@pks.im>
References: <20260109213021.2546-1-l.s.r@web.de>
 <20260109213021.2546-2-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109213021.2546-2-l.s.r@web.de>

On Fri, Jan 09, 2026 at 10:30:12PM +0100, René Scharfe wrote:
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b0673d1a450..bebcf9f698c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -578,6 +578,30 @@ static inline bool strip_suffix(const char *str, const char *suffix,
>  #define DEFAULT_PACKED_GIT_LIMIT \
>  	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? (32 * 1024L * 1024L) : 256))
>  
> +#ifdef _MSC_VER
> +  /*
> +   * When traversing into too-deep trees, Visual C-compiled Git seems to
> +   * run into some internal stack overflow detection in the
> +   * `RtlpAllocateHeap()` function that is called from within
> +   * `git_inflate_init()`'s call tree. The following value seems to be
> +   * low enough to avoid that by letting Git exit with an error before
> +   * the stack overflow can occur.
> +   */
> +#define DEFAULT_MAX_ALLOWED_TREE_DEPTH 512
> +#elif defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__aarch64__)
> +  /*
> +   * Similar to Visual C, it seems that on Windows/ARM64 the clang-based
> +   * builds have a smaller stack space available. When running out of
> +   * that stack space, a `STATUS_STACK_OVERFLOW` is produced. When the
> +   * Git command was run from an MSYS2 Bash, this unfortunately results
> +   * in an exit code 127. Let's prevent that by lowering the maximal
> +   * tree depth; This value seems to be low enough.
> +   */
> +#define DEFAULT_MAX_ALLOWED_TREE_DEPTH 1280
> +#else
> +#define DEFAULT_MAX_ALLOWED_TREE_DEPTH 2048
> +#endif
> +
>  int git_open_cloexec(const char *name, int flags);
>  #define git_open(name) git_open_cloexec(name, O_RDONLY)
>  

Why is this new constant defined in "git-compat-util.h"? That feels way
too global for my taste for a value that should ultimately only be
required by "repo-settings.c". Is there a reason why it's not declared
in "repo-settings.h"?

I think we could even get away with declaring it in "repo-settings.c".
The expectation is that the settings need to be prepared anyway, so we
can simply set up the default when parsing the config.

Patrick
