Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2932D45C
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544445; cv=none; b=eTPyFpD1tI1mdqEheKfE5CyUo8ylVA7V/6N5IwmF9CA/xczbzsvmOJwgaL8/rOx9hG1ckAuwGMo1AUr0JjrQ+vePBeSngQQe0hQxw3UO5R9VDpyaVQ9Kcm+wxFY2uyCe//3KH3YhIlKkcxIsE8L7iVdrnOH5fhBw3kGgk3pugIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544445; c=relaxed/simple;
	bh=aPTKiw86EBhfLml3VE2Jz3+DSRkdL4Xvumy2FkqeznY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feHoj0IPP9OARWTMF/14LSTkSWLBaVqRdjHbcumHXWbqPfAblYCMt3uKySvHEceOXV3nnZERXRTdub///wM+V8jsW8yzkgNSViSwxHGq1CdRnHNZnvDKBqthLO/E74S2vaL7EVLhPzpuYvb/IY8NcxrqWvJdmLxCrnN+KX6cUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lDoOabdO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDubZywW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lDoOabdO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDubZywW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8C80140014F;
	Tue,  3 Mar 2026 08:27:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Mar 2026 08:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772544442; x=1772630842; bh=EsZ2o3A1fX
	bVk+Y3/wbM8lpMULagb/CJbzODPE/rTa4=; b=lDoOabdOQAcweItnOUPseOI9Up
	Fpk2ioMzzIWjoaOF5/50ofG0uE7Mc9GJKBZaygPM0dOPfiusfAcCORSNJc1u/qC3
	ZrP+wtKyLhPLXriUzAxM7MT1y59/oz66A7z/ISA7Lvc9JbVY5UWV77POfjMt68M4
	nAbAygs0YUtChwQ/aG8IpZhG7FCWD2WXa8YxpHxLTrAPvKG7MZJYb2bNN29YEAmY
	zmM3JAdoSeAnr8akEY9XQHPoW7I+AM+mjUSj2H6vr8D0LuO03VbRubZfFNo0mzQb
	88o0QRGspBwXxP3pRalK96WYv1ZC6wBLOb49hg8ccyGDqANQcEw7utXKknzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772544442; x=1772630842; bh=EsZ2o3A1fXbVk+Y3/wbM8lpMULagb/CJbzO
	DPE/rTa4=; b=QDubZywWy+F7bTZwHoXt1of4zXdV6XV20UnPFl6vQVLemf+zudB
	XdoG2S+lTucop0+v5iOhROGlNuuD24HH10HbY/qx8Rs94fxuBoLiPwgrCVT9U32y
	8KhT/YHB+Q0q60nOO4+qh78wi95BY+uSP2JcO8fzMeOHXrPZscj2idG4/BPc0lNh
	W/66oI2ZUtLXuqRyOkJwqdngMTeNey+O8vgouP2NK4FyYD5SZE97GLBiahLOu6Vp
	ntH5/0dWU52UxCaVBfO7QxU+TuAbniJYSLY5/q0ePmCkAnl+lsUR13ezRK9BckXo
	kG1uks8OEUQ+9xAsXBLSmIk/R1eWRbFR8Fg==
X-ME-Sender: <xms:uuGmabip0LQKeWVVg194ZL2Z3VihyEZISxXavhjlYdBkECbrj69YMA>
    <xme:uuGmae55IJaXjhplvaMolUOFc88f5ahpJsosOM4ttwskd02VHVK9mAxQgeqMMTXRa
    mNS-gWLufQg1HiNVlhkwUS-ycq5eNOyPB3COcf7ZG2liwBU88EG7OY>
X-ME-Received: <xmr:uuGmaTZR2ocPD5N42H-Gh0_gZ4nwhuJuyBiIlgnBi_--fmKvDgLjebNAoC5wctrC69MCUy6bgBPkMIN95t3Pt8NM04ZUXIyVtsg1ooeVEfgf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    uhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:uuGmaT5CVDSJFgXBEswrWA_OrfRz_ZZ4LVWfrbJQPAohxdRkA_rKgg>
    <xmx:uuGmaWCloQVeVPsFukL0XgdHyLXiasbhT7X_7Kd8W8CkhEdyQAQQRA>
    <xmx:uuGmaZcD5FgjzgJfLXBEVFbEvnucIikbvIvytCc3U68SRTZ2j4s5vg>
    <xmx:uuGmaVJ5vEvGQ_iOUsk-uxWtbURvEptDI1EqU7KbIDTpHyhK-wTmHg>
    <xmx:uuGmafKdhqXSbUNxuajm-SjthKhfzHn7s9wxtvUsQwmhmjalRE_AlSIZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 08:27:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8e5ca60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 13:27:20 +0000 (UTC)
Date: Tue, 3 Mar 2026 14:27:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com, lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 2/6] builtin/repo: add helper for printing keyvalue
 output
Message-ID: <aabhtfWZG90YyhQ5@pks.im>
References: <20260223174120.2356504-1-jltobler@gmail.com>
 <20260302214526.2034279-1-jltobler@gmail.com>
 <20260302214526.2034279-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302214526.2034279-3-jltobler@gmail.com>

On Mon, Mar 02, 2026 at 03:45:22PM -0600, Justin Tobler wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index c7c9f0f497..782194cf4c 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -446,44 +446,51 @@ static void stats_table_clear(struct stats_table *table)
>  	string_list_clear(&table->rows, 1);
>  }
>  
> +static inline void print_keyvalue(const char *key, char key_delim, size_t value,
> +				  char value_delim)
> +{
> +	printf("%s%c%" PRIuMAX "%c", key, key_delim, (uintmax_t)value,
> +	       value_delim);
> +}
> +
>  static void structure_keyvalue_print(struct repo_structure *stats,
>  				     char key_delim, char value_delim)
>  {
> -	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->refs.branches, value_delim);
> -	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->refs.tags, value_delim);
> -	printf("references.remotes.count%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->refs.remotes, value_delim);
> -	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->refs.others, value_delim);
> -
> -	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
> -	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.type_counts.trees, value_delim);
> -	printf("objects.blobs.count%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.type_counts.blobs, value_delim);
> -	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
> -
> -	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
> -	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.inflated_sizes.trees, value_delim);
> -	printf("objects.blobs.inflated_size%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.inflated_sizes.blobs, value_delim);
> -	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
> -
> -	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
> -	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.disk_sizes.trees, value_delim);
> -	printf("objects.blobs.disk_size%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.disk_sizes.blobs, value_delim);
> -	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
> -	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
> +	print_keyvalue("references.branches.count", key_delim,
> +		       stats->refs.branches, value_delim);
> +	print_keyvalue("references.tags.count", key_delim,
> +		       stats->refs.tags, value_delim);
> +	print_keyvalue("references.remotes.count", key_delim,
> +		       stats->refs.remotes, value_delim);
> +	print_keyvalue("references.others.count", key_delim,
> +		       stats->refs.others, value_delim);
> +
> +	print_keyvalue("objects.commits.count", key_delim,
> +		       stats->objects.type_counts.commits, value_delim);
> +	print_keyvalue("objects.trees.count", key_delim,
> +		       stats->objects.type_counts.trees, value_delim);
> +	print_keyvalue("objects.blobs.count", key_delim,
> +		       stats->objects.type_counts.blobs, value_delim);
> +	print_keyvalue("objects.tags.count", key_delim,
> +		       stats->objects.type_counts.tags, value_delim);
> +
> +	print_keyvalue("objects.commits.inflated_size", key_delim,
> +		       stats->objects.inflated_sizes.commits, value_delim);
> +	print_keyvalue("objects.trees.inflated_size", key_delim,
> +		       stats->objects.inflated_sizes.trees, value_delim);
> +	print_keyvalue("objects.blobs.inflated_size", key_delim,
> +		       stats->objects.inflated_sizes.blobs, value_delim);
> +	print_keyvalue("objects.tags.inflated_size", key_delim,
> +		       stats->objects.inflated_sizes.tags, value_delim);
> +
> +	print_keyvalue("objects.commits.disk_size", key_delim,
> +		       stats->objects.disk_sizes.commits, value_delim);
> +	print_keyvalue("objects.trees.disk_size", key_delim,
> +		       stats->objects.disk_sizes.trees, value_delim);
> +	print_keyvalue("objects.blobs.disk_size", key_delim,
> +		       stats->objects.disk_sizes.blobs, value_delim);
> +	print_keyvalue("objects.tags.disk_size", key_delim,
> +		       stats->objects.disk_sizes.tags, value_delim);

It's still easy to miss any mismatch here, but I guess the result is
definitely easier to read regardless of that.

Thanks!

Patrick
