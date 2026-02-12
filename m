Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDAF9D9
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770883574; cv=none; b=ndjnSyePML/Zh3L26Rx3bujxVGZIwIDfvLqDOg0XdyHCvMBSeSzRYTTtdmMmUakGKrjlnDatsc2ukmvM9chZDZNsjUqyyrXVA37ljZTPGZPvDFV9xwfpvalA+X3iLWqpOYZZ3lCfhCnBPP99J9jTu88ICoM8LF19Bj0LF+Sa6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770883574; c=relaxed/simple;
	bh=Kmjn5+bYWXxZIP2aWEi+brKaGk4VnbTaCbmkeFW3YwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L87y48S+NKlDL2pkKp5RPaRuuox5245xmIYSM9XrCJDfvLv4u+AAjgP/Edrnfe3fr3VP/POt//kht+y/uXptDvwQxA0miL42zmw52EGs1O9tN3FoMyxxqjanfJ4MN22ibeKmEkPIwIlRqaMxQQ9xXwJe1q6nL6JpjU1egEmyNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j6mxJ1vn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pil51CGk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j6mxJ1vn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pil51CGk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B437EC05FA;
	Thu, 12 Feb 2026 03:06:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Feb 2026 03:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770883572;
	 x=1770969972; bh=YmNdutZkYSj7yyxAW1OhzkC9WA1OrGZ6zWp+I9Oob3A=; b=
	j6mxJ1vn0Dv3CTnpBa3qKtHmFBPEtVstUMWIy/3TTaP2dmG26BrJpl1JGUdMtk5j
	o0vR2hRztW2GNdw5MIMXTidAaNXH7kS3+AN6N1B5tIZk//9Epce++bv6HAQ8CTyr
	jCN9QX4CvqTTT30yCcQeYgPV8ZNIsXdotrwyRN0ABEAx37FZA7IhTCFYUIqodNkL
	+sCcFkJ6MMfyEVDXqs0GJ7kiWKf0SjIGIRQRNzKBuMONNiDQAK9hQNMdiNkHf2AR
	2lO85at7a+RhIw7KH0/5b3Vzz6SY3fMnVdXyPyPsmnt3sahcHlfkyTaH9sztq5jn
	37+4ifDc3JlAMvTv7AukOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770883572; x=
	1770969972; bh=YmNdutZkYSj7yyxAW1OhzkC9WA1OrGZ6zWp+I9Oob3A=; b=P
	il51CGk3XLYz4XJKg6utYu84d5Qm9Lgs/7+BMDxqCmWh363kh2vKzNA0uYAI6cyK
	O/B+oMR4OgPQo5f4G8cPX0OfMOF/VYQjBPjMuYCpFWJ/lpRph+cQSLbIudbOFiME
	GLOf0Ep408pzwMmZZevZ0FCadpBjIl7rZsHGRQr3QhMfVItPnGGhNxhPUvWJhj10
	PyGyePY11UvvDALdYhaKz7m8FrLMcFFnfrqhDBK1Vx9QOPSr55ws6jPjbkxYe5wH
	QWaJ+SIex/Pgr/q8bVH4SxWKDt+Jy1WVRjX7vgMVKEEZaqzP6RYWwmUa2Xk0lCKL
	CsBYTLUbVKR1kxjprGfxQ==
X-ME-Sender: <xms:84mNaQ2OSYI-hQFmGI9RBIychVDMlHfcn899PKdbjKsdst1K26Jw8Q>
    <xme:84mNaclTjk5RvQtTs8DYJ2yiPbURwTJcZkjnZYeDTIqhbEQx6W9Ygw5iMM4r34Jzn
    -JwhA7oJA-gixnM1PMvN1wca_ZSgbya-gSvn0kfWNOXVvMZARVXwg>
X-ME-Received: <xmr:84mNaY__QRLcc0oTLXELurQCsgUOLizPTiaJ6xgn1b0gfwLX2psndy8vW5oTw6FJMrMHpv3OOZUBRSF0U0u66wEoHfn8mhMr4oUuhKJaGnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegleekleehjeejffdufeduvdfggfehieetveffveeftdelteefjeeuffdukeekveen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmpdhinhdrtggtnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrg
    hrthhinhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhouges
    ughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:84mNaZqjhK8d8xoltX6fMsIKHhXyaBRwae6_OVHsewYWZzqo2M7SSg>
    <xmx:84mNaZlMp5qfGxh2ZVB1z1Yg4XU_YOQWZ9orPSsW3pIsu7j9Y4iT7g>
    <xmx:84mNaYhUimpEdo5msxGt7d_fuaU-QAMLTvDACcwhYjNwSnwAnzkr_Q>
    <xmx:84mNaZeI-8oCCOguW9F2RDpV8BZHW3ArTy8Q8IWEiret6S2SAD3L-w>
    <xmx:9ImNaV6N8f9eQJ82pZ7sUWAECUa690cu5kv-SQB7QLERTNH5muRn9lJV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 03:06:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efb6a8d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Feb 2026 08:06:09 +0000 (UTC)
Date: Thu, 12 Feb 2026 09:06:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Martin <evan.martin@gmail.com>
Subject: Re: [PATCH v3] meson: regenerate config-list.h when Documentation
 changes
Message-ID: <aY2J6lcBC4Gcy-SK@pks.im>
References: <c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>
 <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>

On Wed, Feb 11, 2026 at 06:51:02PM -0500, D. Ben Knoble wrote:
> Notes (benknoble/commits):
>     Changes from v2 (<c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>):
>     
>     • Pick up (and tweak) Patrick's depfile proposal
>     • Include the script itself as a dependency
>     • Escape output paths (spaces, octothorpes, and backslashes) for Ninja
>     
>     I'm not 100% sure I've actually done the escaping correctly, though,
>     since Ninja's source says that a space preceded by 2N backslashes
>     represents 2N backslashes at the end of a filename, and

I guess you refer to [1], more specifically this quote:

  Rather than implement all of above, we follow what GCC/Clang produces:

      Backslashes escape a space or hash sign.

      When a space is preceded by 2N+1 backslashes, it is represents N
      backslashes followed by space.

      When a space is preceded by 2N backslashes, it represents 2N
      backslashes at the end of a filename.

      A hash sign is escaped by a single backslash. All other
      backslashes remain unchanged.

>         λ printf '%s\n' 'foo\' | sed 's/[# \\]/\\&/g' | xxd
>         00000000: 666f 6f5c 5c0a                           foo\\.
>     
>     So would they interpret that as the filename 'foo\\' instead of 'foo\' ?
>     (Or, no because the 2N slashes aren't followed by a SP, but a NL?)

I think it would be interpreted as "foo\\". I would say that we really
don't need to go too much into detail here. I very much hope that no
sane person would have literal "\ " in their paths. One might wonder
about Windows, where backslashes are common. But filenames cannot start
with a space there, so this is fine.

So I'd say we should only care about quoting ' ' and '#', nothing else.
We can still iterate going forward if we see that we're too naive.

>  generate-configlist.sh | 10 +++++++++-
>  meson.build            |  4 +++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 75c39ade20..091efd4564 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -36,3 +37,10 @@ print_config_list () {
>  	echo
>  	print_config_list
>  } >"$OUTPUT"
> +
> +if test -n "$DEPFILE"
> +then
> +	printf "$OUTPUT: %s\n" "$0" "$SOURCE_DIR"/Documentation/*config.adoc \

I think it's a tiny bit hacky that we output the script itself as a
dependency here, and that it would be cleaner to do this via
`depend_files` in the target itself.

> +	    "$SOURCE_DIR"/Documentation/config/*.adoc |
> +	    sed 's/[# \\]/\\&/g' >"$DEPFILE"
> +fi

From the above rules I would think that we should simply ignore
backslashes here. As the last rule says, "All other backslashes remain
unchanged.".

> diff --git a/meson.build b/meson.build
> index 3a1d12caa4..fb5d7367f5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -720,11 +720,13 @@ endif
>  
>  builtin_sources += custom_target(
>    output: 'config-list.h',
> +  depfile: 'config-list.h.d',
>    command: [
>      shell,
> -    meson.current_source_dir() + '/generate-configlist.sh',
> +    meson.current_source_dir() / 'generate-configlist.sh',
>      meson.current_source_dir(),
>      '@OUTPUT@',
> +    '@DEPFILE@',

I didn't know about `@DEPFILE@`, nice.

Thanks!

Patrick

[1]: https://github.com/ninja-build/ninja/blob/cc60300ab94dae9bb28fece3c9b7c397235b17de/src/depfile_parser.in.cc#L27
