Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D32505D0
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898159; cv=none; b=qLE5DH06eeUGgiJwnMsRt7ypRXSLvhMHAZvipuN5v78obcMrVAEYsnlp0GGTC/zvNUnLyOeMFDliKSOaplwosMr8ABoJp0diq6nKNjeHHpJwOmUByQcx3o71QPkVIz0477ryQy+ROcQTW9ykTDJhn3p/D4pwkA2N1BzgM0IQ6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898159; c=relaxed/simple;
	bh=KwYUcFmuyVFxbXF3OzyzpyUvpgpBywsXHV5DEBOpwn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q8/uuGXVToDBEYESMGA4HaNUV8TRz9Aycawe85xxG1HNDTbtJrQNAwNyxoTBuoz6KA0rI3jZe8qiXxyurYF46cJcNbj9wI5PjxazBLkJmp8eRY4glNCTDcyD+ieVTCzdDgPMCmo1vzkNyNERZMd3dyv7om88RnhofjANzWCsmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FfTMxUMZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xMBx/Of9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FfTMxUMZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xMBx/Of9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 800A9254029F;
	Thu, 17 Apr 2025 09:55:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 09:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744898155; x=1744984555; bh=pBf2XBYz2B
	iqoyMmmas+vfXATcJbvGaVK06v3pOaPK0=; b=FfTMxUMZxQhsY3nWHEWZ7o+0WP
	zl1ClpiVZ3oosf8U+bKSnG54gZHl7d8Gs4shEDhJm2dcIjZ0/uoBJVKx8ela6c1A
	VTrWGsXpaMQ156WLneazuYf7dMr6CzggdkRTjsgs9aciguyIgH2CSNAubF+FRfl4
	Eto3UTLUQCSdKqP7ojW/fRELOjVe96s69tSu1GP2+Dv4pKMa0Xb1TK5zrhUrLuaQ
	sL7DL9duJDZoowBS/FskwA7Re0umispiIiZd533Yse4dtGFn4F0kK14SmqKfVoMQ
	EkZ014rkzH5buupa9UJO4KeBDTQM8AB/PnL4gtqEWprqUQaHKNZOlu1okWwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744898155; x=1744984555; bh=pBf2XBYz2BiqoyMmmas+vfXATcJbvGaVK06
	v3pOaPK0=; b=xMBx/Of9Xy/aD8he/72fHYngtFanYmJQO3P1z374SLEVkOHnXQi
	R1M61vn2wq6sprg+dtj/JcStv9JjCaV6H6RE3ro/aqqlhaPBwx7EQd9s2G/UXGIC
	eAOG1Z3CBtJruVUFqfhQhSQ3npwDLEaQKlg48K+rjDqdYpF+R1q+08aCLu/CoSh3
	TMPozjT2qvHc++BeJteSn4iIeOGIYkPQA+GH6+TjMlZsF4WdeRFdFtqBBgOaXISF
	zu0MbtPWww3QguzIE3UPxk17elxcHthcgxDOmEqiNkHR9YzjJc9E/488TzvEbJky
	k/DX+RNj7vDC0Eehe3JkHkyKe4JqQxUXePA==
X-ME-Sender: <xms:aggBaBaCVzHXAlX0hXgFOtgpoIYpeKZihI9yGwtYU9Mi5DwyFEVYYA>
    <xme:aggBaIZDYOkob5tmjwDi5Y0B1tnHk-I3r9Dlyb1nAzt9qkI2AyxEOQ3K57YQvt-qV
    5IXJUNXd44uwLlBnA>
X-ME-Received: <xmr:aggBaD98j0VfAGVVGK5spBItzBWeYK5CddO041PvSkJgBbJ0W_dR3ffDTQrprc6ECTfnwvNaa2SP2-PNkmg_miENSUPw-ZN8tgZB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:aggBaPrsr_g7tumnAQv9K05WUq_eHd9nD8RfjFvb2ILvEJe1yhDSXg>
    <xmx:aggBaMpGjHCNaDR4brgSUOMvQybDY6f4kEiOFGuTOGEkKScy-74bqA>
    <xmx:aggBaFQ8cuJD50qUp_Cr9IJDNyQ8P_7Umi_9oj0JymHDD-ADSRrpjA>
    <xmx:aggBaEq55PTYMtQZnTGYEFnd6D_jpX6S3lXYXN0ofREBnkkPijlUQQ>
    <xmx:awgBaDktsBBsCJqaWynscd2-t-KjMwNpUfwMiZd4YQgOKK6F2y_8N0Km>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 09:55:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v3 13/13] config.mak.uname: set CSPRNG_METHOD to
 getrandom on Linux
In-Reply-To: <20250416231835.2492562-14-ramsay@ramsayjones.plus.com> (Ramsay
	Jones's message of "Thu, 17 Apr 2025 00:18:34 +0100")
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
	<20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
	<20250416231835.2492562-14-ramsay@ramsayjones.plus.com>
Date: Thu, 17 Apr 2025 06:55:52 -0700
Message-ID: <xmqq4iymgadz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Commit 05cd988dce ("wrapper: add a helper to generate numbers from a
> CSPRNG", 2022-01-17) added a csprng_bytes() function which used one
> of several interfaces to provide a source of cryptographically secure
> pseudorandom numbers. The CSPRNG_METHOD make variable was provided to
> determine the choice of available 'backends' for the source of random
> bytes.
>
> Commit 05cd988dce did not set CSPRNG_METHOD in the Linux section of
> the config.mak.uname file, so it defaults to using '/dev/urandom' as
> the source of random bytes. The 'backend' values which could be used
> on Linux are 'arc4random', 'getrandom' or 'getentropy' ('openssl' is
> an option, but seems to be discouraged).
>
> The arc4random routines (ar4random_buf() is the one actually used) were

arc4random_buf(), if I am not mistaken?

> added to glibc in version 2.36, while both getrandom() and getentropy()
> were included in 2.25. So, some of the more up-to-date distributions of
> Linux (eg Debian 12, Ubuntu 24.04) would be able to use the 'arc4random'
> setting. All currently supported distributions have glibc 2.25 or later
> (RHEL 8 has v2.28) and, therefore, have support for the 'getrandom' and
> 'getentropy' settings.

OK.  This explains that getrandom/getentropy have better
availability than arc4random.

> The arc4random routines on the *BSDs (along with cygwin) implement the
> ChaCha20 stream cipher algorithm (see RFC8439) in userspace, rather than
> as a system call, and are thus somewhat faster (having avoided a context
> switch to the kernel). In contrast, on Linux all three functions are
> simple wrappers around the same kernel CSPRNG syscall.

OK.  With this and the previous paragraph, we establish that there
is no reason to use arc4random on Linux, while on BSDs and Cygwin,
it is a natural choice.

Very clearly explained.  Thanks.

> If the meson build system is used on a newer platform, then they will be
> configured to use 'arc4random', whereas the make build will currently
> default to using '/dev/urandom' on Linux.



> Since there is no advantage,
> in terms of performance, to the 'arc4random' setting, the 'getrandom'
> setting should be preferred from an availability perspective. (Also, the
> current uses of csprng_bytes() are not in any hot path).
>
> In order to set an appropriate default, set the CSPRNG_METHOD build
> variable to 'getrandom' in the Linux section of the 'config.mak.uname'
> file.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 330741eb5a..db22a8fb31 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -50,6 +50,7 @@ ifeq ($(uname_S),Linux)
>  	HAVE_ALLOCA_H = YesPlease
>  	# override in config.mak if you have glibc >= 2.38
>  	NO_STRLCPY = YesPlease
> +	CSPRNG_METHOD = getrandom
>  	HAVE_PATHS_H = YesPlease
>  	LIBC_CONTAINS_LIBINTL = YesPlease
>  	HAVE_DEV_TTY = YesPlease
