Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20319149E
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528320; cv=none; b=dKgdEQ6s1zACZhNGWs5xYA4UWYP/mcA5bSwTuISjlbrGQYsm0MBcXtX4VzqyQZs/EFO75VEXv42eQv4EsSEECVcfNiFCTWQaU9mA2GQzm9Sxq2o+fl9bAaImsO+bp2U/a8VZHtBPMU5ROtn94xg+0FsUwhyvam/pM90IRx/QpuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528320; c=relaxed/simple;
	bh=Doh5oH5zhgK0SaQdzMzFfDSRaOOm3JWsvPQjM5FED2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9NhVh1AHdyR83z9dVrYKuecEkGsU+PQZl5G3lzuNLKNgTOG3HMKn2yrr3pKz9QRE9Sx9fMZiXjNU5t8bB0rtryjRlymGIthcZACHgXfu0dDeNj446v6p0lCQicH78OyC+L7mZMPU5/e3hQl2UGmifUH/pJ6JjrwI/Dv5f0EL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J+gXNJ2d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtDqrCOo; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J+gXNJ2d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtDqrCOo"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 72B9F254015B;
	Mon, 25 Nov 2024 04:51:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 04:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732528317; x=1732614717; bh=KEvUJL+Ybp
	rIl+fCCTK78/h8LFN00sH9e0HJnyyt68E=; b=J+gXNJ2dLQ9ZnUA210cFfjV27j
	ymhGwQhrAoGY/5U3vAEjt98woO9DNOfRj7TnbJVslIP08BDCS99lZ7D3ruA5PGIe
	EUyPwN+TgFkvx2AkU5Bqcv9cNn9B3Ubphf/bOjHjXYaSgnXoUw1InjNkY9i23RT6
	kLnf4I5siKNPScVG2DSPummF8YxNTvib8du1BP36Nt8p/MLqTGRm6TXWgyCOjMqK
	ZyvDZgl5XuDdtOYy2SmssgHmtMCZev8O6sO18/yhsGzrgFJJ74F/vlifimf+afQT
	TiWodouRnaps1000EgJZQkX6OYSS/q3MUcF/5L0/GTIYXnvA/HyXKfwsHLlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732528317; x=1732614717; bh=KEvUJL+YbprIl+fCCTK78/h8LFN00sH9e0H
	Jnyyt68E=; b=LtDqrCOo9qDkR488p/feyL4cuQeIZ4sfqeqEGahPJRnZyhFdN/o
	RBh0WBLpNQP4obXuMM/OKFLIHB9pr37aKWJZ8mb9xBi5YbyFOHoqohwgL+OYrldW
	Umeu0CEYodBqBdwz4dGNt9qJMJFSQwICUWtRBCm0dVzM5njor+eleAGrHU2t7AUg
	ByMtUxrAw5wnNQjosltoDJvMwA508AFch8O0O/1PeRj3MVfNQKt7xSnDi9mSe2wu
	XYcDX+ReVDyOElitBNR4xRK5J8++EDm0I/S67/KLDXlzVFqHtplyzIU/oM6LDt7P
	q01J7Z0cqVG9h+h9JgQCEulcS36eASo0Ibw==
X-ME-Sender: <xms:vUhEZ8y5PPnOuWs3_blT7Gme-EWYMrS89r_MkuR_dP0kNe21v8oSBA>
    <xme:vUhEZwSAziXZC-Gs9oNln879S49kCe3NdOxomFowCvBa9Cil-NfUzXpzR49Zv2cb1
    Iu4yf5cWiBN7VtGEA>
X-ME-Received: <xmr:vUhEZ-VxABM8__ZUst2CRbDxsc1eNMER3Sv3f5zOQz55Us6fQodCkhNX5Ih0mU56l3Ey1dkLaoOne85BfnFzAJhS6VQu3x4-XkngbS-UdrbnpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghp
    thhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghrihgtrdhpvghijhhirghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtgho
    mh
X-ME-Proxy: <xmx:vUhEZ6iog1cRbCABycZMj4hepcCOYQO_9GkW7iQiNgZjCf79s79uww>
    <xmx:vUhEZ-CDufPosAlB7QU1AmIzI4lqOF0D8kiHp7zrhkbE5lLereFbUg>
    <xmx:vUhEZ7IC38Uy1-h64U1U_Z2qW_mqHmjGpxIc1OCr0yOLmSEBYoldGw>
    <xmx:vUhEZ1CjFeef46vcD0Sed3y3R3B3Tgcb7rHUfiRaQaMoRPX_DzgnlA>
    <xmx:vUhEZ62dc4f_543Ty6KBRJamKMfdPteOpYS0qOzvPhBm-zflG9KFL_oi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:51:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12f9b810 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:50:54 +0000 (UTC)
Date: Mon, 25 Nov 2024 10:51:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v7 6/6] cat-file: add remote-object-info to batch-command
Message-ID: <Z0RIrw2PszaY2Way@pks.im>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
 <20241125053616.25170-7-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125053616.25170-7-eric.peijian@gmail.com>

On Mon, Nov 25, 2024 at 12:36:16AM -0500, Eric Ju wrote:
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index d5890ae368..6a2f9fd752 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -314,7 +323,10 @@ newline. The available atoms are:
>  	line) are output in place of the `%(rest)` atom.
>  
>  If no format is specified, the default format is `%(objectname)
> -%(objecttype) %(objectsize)`.
> +%(objecttype) %(objectsize)`, except for `remote-object-info` commands which use
> +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not supported yet.
> +WARNING: When "%(objecttype)" is supported, the default format WILL be unified, so
> +DO NOT RELY on the current the default format to stay the same!!!

Is this stale or do we still not support `%(objecttype)`? I thought we
wanted to support that, as well, so that we don't have to change the
default format.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 5db55fabc4..ad17be69b0 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -576,6 +582,59 @@ static void batch_one_object(const char *obj_name,
>  	object_context_release(&ctx);
>  }
>  
> +static int get_remote_info(struct batch_options *opt, int argc, const char **argv)
> +{
> +	int retval = 0;
> +	struct remote *remote = NULL;
> +	struct object_id oid;
> +	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
> +	static struct transport *gtransport;
> +
> +	/*
> +	 * Change the format to "%(objectname) %(objectsize)" when
> +	 * remote-object-info command is used. Once we start supporting objecttype
> +	 * the default format should change to DEFAULT_FORMAT
> +	*/
> +	if (!opt->format)
> +		opt->format = "%(objectname) %(objectsize)";

Seems like it isn't stale. Hum.

> +	remote = remote_get(argv[0]);
> +	if (!remote)
> +		die(_("must supply valid remote when using remote-object-info"));
> +
> +	oid_array_clear(&object_info_oids);
> +	for (size_t i = 1; i < argc; i++) {
> +		if (get_oid_hex(argv[i], &oid))
> +			die(_("Not a valid object name %s"), argv[i]);
> +		oid_array_append(&object_info_oids, &oid);
> +	}

Should we return an error when the user didn't pass any object IDs?

> @@ -667,6 +726,45 @@ static void parse_cmd_info(struct batch_options *opt,
>  	batch_one_object(line, output, opt, data);
>  }
>  
> +static void parse_cmd_remote_object_info(struct batch_options *opt,
> +					 const char *line, struct strbuf *output,
> +					 struct expand_data *data)
> +{
> +	int count;
> +	const char **argv;
> +
> +	char *line_to_split = xstrdup_or_null(line);
> +	count = split_cmdline(line_to_split, &argv);
> +	if (get_remote_info(opt, count, argv))
> +		goto cleanup;
> +
> +	opt->use_remote_info = 1;
> +	data->skip_object_info = 1;
> +	for (size_t i = 0; i < object_info_oids.nr; i++) {
> +

Nit: empty newline at the start of a block.

> diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
> new file mode 100644
> index 0000000000..9fb20be308
> --- /dev/null
> +++ b/t/lib-cat-file.sh

I think it would make sense to split the introduction of
"lib-cat-file.sh" into a separate commit.

Patrick
