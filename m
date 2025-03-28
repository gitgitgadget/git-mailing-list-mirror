Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6F2AD25
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743145218; cv=none; b=i5MpMSOasFUekVHrllv5IEKrZoyWYGHSr6F2TJBNoQnq9oPkua9TtvVVEmSD8nUVYaIQ9oxz4s1XLjsvUOvjCKo3Hc7oahD9nZ0Ee8PtSK1pxN6GfjsVSaqS9USxtO7Pc9vCehog5Z+99i6k+W69mmE3z0edzjAYEaiKGqXQvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743145218; c=relaxed/simple;
	bh=D4lbsUtPuycUHRprWLYuiGonjC2shwzMNWIX/D3f9vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV9qCwpmrLtWxgHlTzNIdF/a2F4Mm1/371IzgNkyItKh8cvpwCXo6IJacas0oLKKrlVF3Ji0i9XbU7KUWlq8VFydG9/w8sokzw1D+HmMZtuiSfObxdS13JMdhGqj62o6KIpWbaiJCzAParPhYXARzPvcZitN3UPghxTfvA7nJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hWOeoKPs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEOLVv7r; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hWOeoKPs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEOLVv7r"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7AE4B11401CD;
	Fri, 28 Mar 2025 03:00:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 28 Mar 2025 03:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743145214; x=1743231614; bh=sdIJNYhig4
	nDkfBxU+9phejoirajxXMzTeb71KrlP0A=; b=hWOeoKPsnYyJtFPUiUWyMry+fB
	YBsGo/8NhGwvv5AHheBxWABX4nVy7lGWigNcCqxjOwiOnnAnxV35iW2IKVMRjfkV
	TmM1o1oAoAxjwx0qkDLiVitb1IEnD0PGQ1qrkj9UU2OB2X/9NIlx7uFa0jY5nxYv
	rYtdCHQ9aNgTZgvusvWdUcSOEJ7BuTiXmQrK2CMHoKCqD/LjYvNAWy+GcW/loeju
	KIJXF5RysszrzT37So5gbBWU9DqiLvxLMwI+zckmHrDgWqIdVX/kfDn9pUkJEpxF
	QLiuTZ7+Ro7Sc//OISkWNFj/8xSott97nIgRY0LPpB8+RCAH4Jo6sISDtbfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743145214; x=1743231614; bh=sdIJNYhig4nDkfBxU+9phejoirajxXMzTeb
	71KrlP0A=; b=eEOLVv7runvSQjjZuTJTVPxJRCNU8rg59DhELN8r1AwUYklSxc6
	17lmn6q/WFWhuxQ3c4naEatP9vjyUwYglLXgAtibm6t7NyLABa4NKgB2XpaWqz++
	0jWeKxMwB2QV7l71PUCt7NJcOTiPmFgYglUPG//SaQgcgDqFe2E8gD391bV0cNU/
	4VwT9UxOXkTnvZMrEKvilTy5mOJDhEvRovKonfSHbaAwUlVRY+82PKYDcuiAYRd/
	KE5iOJ2bD5wlpgWx1lGqrAc8DnXPkdgajC8Sc2SclB0rGsX8JySwqr8OANL3KFmL
	iVYLTNaH6rMEBMzPuvAW77WmOSQlVdYuz+A==
X-ME-Sender: <xms:_UjmZ_K1CXXrFc7MckTVh3YwKLXs1rD7dJmnvaBzgml_DYk-UMQ2vg>
    <xme:_UjmZzIAqG1tmZZgxOyEH-ReDeKOv_Oj4BbdHrh4G460ZlQc1F88y2cfeIe0iDVZb
    MH-K_JaqAMd7xU_yw>
X-ME-Received: <xmr:_UjmZ3tZLSIpo_tWgnSrv9B71Zvs2Ti_1U2kkGH46fhdn9jqDrQD6lcRPmGV1CIaauEDmqLV5IciFM_I0V9fHsApjHtH4gtPy0z4y9u0fmdzMII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_UjmZ4YH-7ct6bXNUy9x7deT0nDubM1a0asH_bKGr4dgbV66tsC0Pw>
    <xmx:_UjmZ2ZccD4ASyrAb8NMKtlerTG8ZWVz_zMDrg8ViJkW7Z34ieG6UA>
    <xmx:_UjmZ8CXyavR7yUMQlE7uduxDFY79rqlVDpLT_wWWPgFXWzKP-Pm0Q>
    <xmx:_UjmZ0auyRqg_PNqVYYdXNEti6xoUd4ButyFtxalwOUVeZO0X7Jfqg>
    <xmx:_kjmZ7N7-KeTRza5n_t2zDaTbwpv_DbdRDW4Yl-9Qw4bTdDJ90MSxd9L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 03:00:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee94715b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 07:00:09 +0000 (UTC)
Date: Fri, 28 Mar 2025 08:00:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com,
	gitster@pobox.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] blame: print unblamable and ignored commits in
 porcelain mode
Message-ID: <Z-ZI-M2jBf5pqMoA@pks.im>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com>

On Wed, Mar 26, 2025 at 10:06:10PM +0100, Karthik Nayak wrote:
> diff --git a/builtin/blame.c b/builtin/blame.c
> index c470654c7e..528bfef249 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -351,6 +351,19 @@ static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
>  		write_filename_info(suspect);
>  }
>  
> +/*
> + * Information which needs to be printed per-line goes here. Any
> + * information which can be clubbed on a commit/file level, should
> + * be printed via 'emit_one_suspect_detail()'.
> + */
> +static void emit_per_line_details(struct blame_entry *ent)

Tiny nit, feel free to ignore: should this something like
`emit_porcelain_per_line_details()` to highlight that this is part of
the porcelain format?

> +{
> +	if (mark_unblamable_lines && ent->unblamable)
> +		printf("unblamable\n");
> +	if (mark_ignored_lines && ent->ignored)
> +		printf("ignored\n");
> +}
> +

Another tiny nit: you may use `puts()` instead of `printf()`. I don't
mind it much though, both versions work equally well.

> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
> index 370b768149..306fc61057 100755
> --- a/t/t8013-blame-ignore-revs.sh
> +++ b/t/t8013-blame-ignore-revs.sh
> @@ -158,6 +158,16 @@ test_expect_success mark_unblamable_lines '
>  	test_cmp expect actual
>  '
>  
> +for opt in --porcelain --line-porcelain
> +do
> +	test_expect_success 'mark_unblamable_lines with $opt' '
> +		sha=$(git rev-parse Y) &&
> +
> +		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
> +		test $(grep ^unblamable actual | wc -l) -eq 2
> +	'
> +done
> +

Okay, makes sense. We cannot batch the information on the first time
we've seen the commit here because both the "unblamable" and "ignored"
properties are properties of the line, not of the commit. So we'd expect
to see the information per line in both modes.

Patrick
