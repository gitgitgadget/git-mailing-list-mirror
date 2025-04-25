Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618731DE3C3
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600704; cv=none; b=IeFuWorAI+2YzaeLux5voqHunJ7Auxpd2QSmEHRY9FIvr3ci6dmt1uNGH4D5E+12EDg0EjoK8jewA4ZCOTtQ61hMt76my0ApbeThZqjhIA8FsfGDSoINcdiadSRu5MQZQ9jrjN8my9CrrYNwR+RAt74tY5hQR4Kf4g2PZcwHP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600704; c=relaxed/simple;
	bh=TgozoHAAuhRUoahXdPg59HylTXhPNeCJya2ZdD0zPcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kALAgux373R0NUvaVQaX9Skg+pZQEIXw9AObymeubPYf4qqdTz3craZjAq6crcmaPHqSXPXU7dlR+KZOsj3g8Ng7TsdPl7DhKLp+ca8zwEOHsFuMwZOH0Y6FE8akryHDW8j3iGLNg5zklayvzTx91whEZO6kKck5R6z9GXbk5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=imUwZiSx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uGqamrgP; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="imUwZiSx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uGqamrgP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C8C0254018F;
	Fri, 25 Apr 2025 13:04:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 25 Apr 2025 13:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745600697; x=1745687097; bh=0EjwIVhKBk
	utKUaA8WqbbPGW96amMLXP/IjFtXpEbZo=; b=imUwZiSxideWjHydsBF9Il/qXG
	4YNlK74XQbUbyHikIOw/70vaHRRMtvoT4Ogsa9F9gbhyrcMooDnGelTABIdezTPf
	//mdJvnSuBmKqzVnSK/ZDnLBDggCft7n5JyfGO9yByio9BnVjrHnJAm6Svl9PxWf
	6M3Y1eNWf91ONUHZZppVGpQQvblmY5x0OWbVgMYS4vcckcs5LEJDV2LPoZBvP7p8
	7aEBsXjzCGZfERkNKMTZJPM1H8A8DdwSExXqlRzPD2zRcgzn7/GbT9TR+L3X/X+V
	KqETtJ0yysZdbpUr/rADJtx3RrwtMrqvehWkAMpQH2XScvN2Bugcuj3JGRgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745600697; x=1745687097; bh=0EjwIVhKBkutKUaA8WqbbPGW96amMLXP/Ij
	FtXpEbZo=; b=uGqamrgPFl1nHgq3OSMDxuK2fNZHoed7r5sVK9OdjC9c4fXMJha
	+2ETF8biVu+MS1nZ5wFFyfyPNJaUCVtG4oJgP9kiLr/yu2ufAk6Rvb+Wkw7hCmm1
	DPDYgL6L0/jqL3tErQcOHujst76KVX7aYkoVfvbS83YvYb7qGn2SozzKRZ1ZCSO9
	u0eUbbroxqFZ5hnQpyczDHe3gsFsWAErtTFdwl5pcHGvZN1McgjkI2DyK8BeYIG+
	UAyI1whtwhZHRdMDn1ys2y1fc5euEMGE9FlqgFEvkV0HLVJCc/LQfZJWEw15zmuS
	0r2MdulubngNzKo8+eDR1Hqy5Gyyse76vTw==
X-ME-Sender: <xms:uMALaCWkA9JFo8HgLBTlNY8jEDh9FgiMARiH8XyJvRJ9cGriaUU1MQ>
    <xme:uMALaOk9GGEbtE0iJ8hv0h5_hXoF2bW1umzSK0hDtbeKy1P4vt-hH0wKKaMhrUNLD
    CAkf0um2yPIBL2kAA>
X-ME-Received: <xmr:uMALaGYKHjd7Z_e29MIpPnX0IcbRcuJtzkTETPIM_4RI_GDWjYmeaN6bQdr-tTq1Fbh-myR4adB87X2syjsoDRtIZp7cF6qdbCTW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhsrdhrvghpohhrthesghhmgidrnhgvthdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uMALaJV9DcSF9Q14gmcgJ9NUviSeuEP6djlboyiBhHyjPB1IkM-5AA>
    <xmx:uMALaMkaMtCYK-qRoNC6CbTadk4KpIU46_9rIKRhhqq9sw_GBAPfvQ>
    <xmx:uMALaOeZmCkE_Q4lEfs7EDqgmf3O2SdzeeuS0bsEjVXSzZhd0SRt_g>
    <xmx:uMALaOGi0HWuL5q9nBwGwKY31KdCDeKYbbxMAeh7y7fHMU18OGrz1A>
    <xmx:ucALaBPbQkvNmVnaovq6MfJGdq-PmFIHTWPHUQITGM8LKiKKro4TA2eL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 13:04:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Peter Seiderer <ps.report@gmx.net>,  Eli Schwartz
 <eschwartz@gentoo.org>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
In-Reply-To: <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
	(Patrick Steinhardt's message of "Fri, 25 Apr 2025 16:11:29 +0200")
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
	<20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
Date: Fri, 25 Apr 2025 10:04:55 -0700
Message-ID: <xmqqy0votbns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Meson detects the path of the target shell via `find_program("sh")`,
> which essentially does a lookup via `PATH`. This may easily lead to a
> subtly-broken Git distribution when the build host has its shell in a
> location that the target host doesn't know about.
>
> Fix the issue by appending "/bin" to the custom program path, which
> causes us to prefer "/bin/sh" over a `PATH`-based lookup. While
> "/bin/sh" isn't standardized, this path tends to work alright on Linux
> and BSD distributions. Furthermore, "/bin/sh" is also the path we pick
> in our Makefile by default, which further demonstrates that this shell
> fulfills our needs.
>
> Note that we intentionally append, not prepend, to the custom program
> path. This is because the program path can be configured by the user via
> the `-Dsane_tool_path=` build option, which should take precedence over
> any defaults we pick for the user.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Looking good.

> diff --git a/meson.build b/meson.build
> index a180c66ee69..6a90310a2ca 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -236,7 +236,11 @@ sed = find_program('sed', dirs: program_path, native: true)
>  shell = find_program('sh', dirs: program_path, native: true)
>  tar = find_program('tar', dirs: program_path, native: true)
>  
> -target_shell = find_program('sh', dirs: program_path, native: false)
> +# Detect the target shell that is used by Git at runtime. Note that we prefer
> +# "/bin/sh" over a PATH-based lookup, which provides a working shell on most
> +# supported systems. This path is also the default shell path used by our
> +# Makefile. This lookup can be overridden via `program_path`.
> +target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)

I wonder if we should be a bit more friendly to beginners (either
'meson' beginner or a newcomer to the project who are not yet
familiar with how our meson.build files are written), than saying
"via 'program_path'" by referring to "-Dsane_tool_path=", possibly
even with an example.

Now I am showing my ignorance, but does this support folks whose
shell are not spelled "sh" (like "/usr/local/bin/dash"), and more
importantly, if it does not, shouldn't we be using a mechanism that
does?  I think -Dsane_tool_path=/usr/local/bin would help with the
leading directory path, but I suspect that find_program() does not
help specifying "dash" to be used as our target_shell (or host
shell), or "perl5" as our perl.

Of course, this "my sh is called dash" can be left totally outside
of the topic of these two patches.

Thanks.
