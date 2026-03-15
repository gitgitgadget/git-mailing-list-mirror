Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE91C84DE
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773538443; cv=none; b=HOFPF+QjbAp143POGP7H4TtOdN7psH71g4CBFx1xl3B6n50xR/CdYIfz8F4RBpF8DGQgnymGvkwck9InHRopIjj1RM+Vb0aDlBa7iqo6ywiSkut/s+5jAVqugZgy/BW65vHR31T7Xl53Kr+WH6wmkWET6g1luIdQS8cbK6+jI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773538443; c=relaxed/simple;
	bh=lMW7MgY+x9DKlxp0r25jUsqYor9sJO9L2Em7BVNZ/hA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JIUcUvAPP9JKLDMjsSaV6iIYj7vMkystA9w5WMsSY+nfBOza1lsKh6ApNhOLmwSlBIay9j0afGqr8TV/UtqzSh0z3LbI3hgBGhSHDIZ76pXk6FvivvE/rus/WM4XyhHAiCT20Fi17qSRWrPZXI+46TwPRJIj5Tv3la2RsVt2YMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev; spf=pass smtp.mailfrom=braithwaite.dev; dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b=QuAO/njW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3AHREW4X; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b="QuAO/njW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3AHREW4X"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BC5FDEC031B;
	Sat, 14 Mar 2026 21:34:00 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-05.internal (MEProxy); Sat, 14 Mar 2026 21:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=braithwaite.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1773538440; x=1773624840; bh=3UrqLhTS5S8HeY6Iwj7s39jxaVxw3dgr
	Sv6Tkps6Tno=; b=QuAO/njWpcYPiirR96hZEhvimQebPFgwALYH3VIuFFI9rQIH
	FgsOX5R+vRNmdO8h9Pep3LSjBY5c7OqDB1R1t7gpIS9bFE+YxJheDD0ewB/mQtod
	ezUKGEAprY41S2qskk4Q5nCV7HWcELtYhb2x5E61/hALTEgnMVWyJ5BmADv3aBkc
	fc53+M/abbU5xfhhGyKFoajANmod/mCG77Hy2+dMDg8lzZVYc0emJkHyaH5t5Ga9
	mK0cy8CO9RUcHiUa1CxZKXbZHmpS8Op1c8szEuQ4cBJACA+uKoM+S4S3rCaYQ/6T
	xsOR4ibrO9kFCsVaLjqLsW7yvB2cpOxiU8E31g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773538440; x=
	1773624840; bh=3UrqLhTS5S8HeY6Iwj7s39jxaVxw3dgrSv6Tkps6Tno=; b=3
	AHREW4X2b8tkYnDllSZPIUNEZlVS37MbB2Xhkk/dBZqNCA+0EiB8co2te4Ag+58t
	i5gAqZYDqmZn+mtZ5DJbEREoRJBpqdjpYvQ6jkzudxkYpCmH03AmXWTiw6gKFXX7
	WvrGBby1VpB04XxoLozESao1MWvvlfbgN7Pt7rtv/54/PiSnHQOAG+GjpYiJL1Kz
	HS1yHBIXJqb+iLh/Y6un2NDwPYkTT++7Itzahj49lpe/xuvpkFUAI6oJtSx8Lwxj
	lBIwaP6vV4yy7jfhUL7K0j3w9tyldmyKrj9Q8qBALepZbhtY9wYlr8MTrG8YCkKx
	/E0x9+RJvsXfb7YWEfUAw==
X-ME-Sender: <xms:iAy2aab7TlRShfiJ9M0XUhjp0iGw_XFTxigbtwQG-6oTKEwpl13rHQ>
    <xme:iAy2aYMdT6hDr3H911NppviGUrijwDINRvocFX9JFBgN3H3MuVXvA1WOHRAzSRD9a
    AHurFlSfMcjA7-qpWi--4ovshlYg0WR7Loz5Z0hMeGddXxvjtdS2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleegudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlrghn
    uceurhgrihhthhifrghithgvfdcuoegrlhgrnhessghrrghithhhfigrihhtvgdruggvvh
    eqnecuggftrfgrthhtvghrnhepgeethedvjefftedvhfeufefhfedvlefffffgjeffhfdv
    jefhhffhkefhgeeftdeunecuffhomhgrihhnpehthhgvmhhoshhtshhpvggtihhfihgtuh
    hrlhhmrghttghhfihinhhsrdihohhupdhgihhthhhusgdrtghomhdptghorhhprdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlrg
    hnsegsrhgrihhthhifrghithgvrdguvghvpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:iAy2aVW4T4dj6bB7amB2L4be3_gt_fr8BbpJaekrjyjZRT86Kvwzvg>
    <xmx:iAy2aaiPdu5uDlxrLYLcdLdSu7GPxgA2FUEDi7hoRJ4rn0MOrfNxvQ>
    <xmx:iAy2aVpK7K3oMtv08DauxsTc_GtCSEgb9AjQ3TeJvhPhX3zEihBwJA>
    <xmx:iAy2aYE6AgF5WGgf54n7gc9N2hR0EpV8j6aV7yvk4YrT6eqzzwEetA>
    <xmx:iAy2acdAiFA7gucrtHitCDp3B3s2diIMKIwdH6JfKrLF0TNNNaoX60Po>
Feedback-ID: i1a914699:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0AF841EA006C; Sat, 14 Mar 2026 21:34:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AItb9aa6r_v7
Date: Sat, 14 Mar 2026 18:33:38 -0700
From: "Alan Braithwaite" <alan@braithwaite.dev>
To: "Patrick Steinhardt" <ps@pks.im>,
 "Alan Braithwaite" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, jonathantanmy@google.com,
 me@ttaylorr.com, "Junio C Hamano" <gitster@pobox.com>,
 "Jeff King" <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <9b67801b-ce07-42b6-b2c6-2e7f0e5fd5f7@app.fastmail.com>
In-Reply-To: <abEdTQrRtAveH1rB@pks.im>
References: <pull.2058.v4.git.1772833649843.gitgitgadget@gmail.com>
 <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>
 <abEdTQrRtAveH1rB@pks.im>
Subject: Re: [PATCH v5] clone: add clone.<url>.defaultObjectFilter config
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks for the review, Patrick.

> `url_normalize()` will return a `NULL` pointer in case
> it cannot parse the URL.  We need to be prepared for
> this, otherwise we might segfault.

Good catch.  The updated patch guards on the return value
and skips the urlmatch lookup entirely when the URL cannot
be normalized.  Today `match_urls()` happens to handle
this safely (it returns 0 when `url->url` is NULL), but an
explicit NULL check guards against future regressions in
that code path.

> Do we want to "test_when_finished rm -rf
> default-filter-clone" here and for all the subsequent
> tests?

Done -- added `test_when_finished` cleanup to each test.

Patch incoming. :)

Thanks,
- Alan

On Wed, Mar 11, 2026, at 00:44, Patrick Steinhardt wrote:
> On Sat, Mar 07, 2026 at 01:33:56AM +0000, Alan Braithwaite via 
> GitGitGadget wrote:
>> diff --git a/Documentation/config/clone.adoc b/Documentation/config/clone.adoc
>> index 0a10efd174..1d6c0957a0 100644
>> --- a/Documentation/config/clone.adoc
>> +++ b/Documentation/config/clone.adoc
>> @@ -21,3 +21,37 @@ endif::[]
>>  	If a partial clone filter is provided (see `--filter` in
>>  	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also apply
>>  	the filter to submodules.
>> +
>> +`clone.defaultObjectFilter`::
>> +`clone.<url>.defaultObjectFilter`::
>> +	When set to a filter spec string (e.g., `blob:limit=1m`,
>> +	`blob:none`, `tree:0`), linkgit:git-clone[1] will automatically
>> +	use `--filter=<value>` to enable partial clone behavior.
>> +	Objects matching the filter are excluded from the initial
>> +	transfer and lazily fetched on demand (e.g., during checkout).
>> +	Subsequent fetches inherit the filter via the per-remote config
>> +	that is written during the clone.
>> ++
>> +The bare `clone.defaultObjectFilter` applies to all clones.  The
>> +URL-qualified form `clone.<url>.defaultObjectFilter` restricts the
>> +setting to clones whose URL matches `<url>`, following the same
>> +rules as `http.<url>.*` (see linkgit:git-config[1]).  The most
>> +specific URL match wins.  You can match a domain, a namespace, or a
>> +specific project:
>> ++
>> +----
>> +[clone]
>> +    defaultObjectFilter = blob:limit=1m
>> +
>> +[clone "https://github.com/"]
>> +    defaultObjectFilter = blob:limit=5m
>> +
>> +[clone "https://internal.corp.com/large-project/"]
>> +    defaultObjectFilter = blob:none
>> +----
>> ++
>> +An explicit `--filter` option on the command line takes precedence
>> +over this config, and `--no-filter` defeats it entirely to force a
>> +full clone.  Only affects the initial clone; it has no effect on
>> +later fetches into an existing repository.  If the server does not
>> +support object filtering, the setting is silently ignored.
>
> This all reads good to me.
>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 45d8fa0eed..1207655815 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -757,6 +758,47 @@ static int git_clone_config(const char *k, const char *v,
>>  	return git_default_config(k, v, ctx, cb);
>>  }
>>  
>> +static int clone_filter_collect(const char *var, const char *value,
>> +				const struct config_context *ctx UNUSED,
>> +				void *cb)
>> +{
>> +	char **filter_spec_p = cb;
>> +
>> +	if (!strcmp(var, "clone.defaultobjectfilter")) {
>> +		if (!value)
>> +			return config_error_nonbool(var);
>> +		free(*filter_spec_p);
>> +		*filter_spec_p = xstrdup(value);
>> +	}
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Look up clone.defaultObjectFilter or clone.<url>.defaultObjectFilter
>> + * using the urlmatch infrastructure.  A URL-qualified entry that matches
>> + * the clone URL takes precedence over the bare form, following the same
>> + * rules as http.<url>.* configuration variables.
>> + */
>> +static char *get_default_object_filter(const char *url)
>> +{
>> +	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
>> +	char *filter_spec = NULL;
>> +	char *normalized_url;
>> +
>> +	config.section = "clone";
>> +	config.key = "defaultobjectfilter";
>> +	config.collect_fn = clone_filter_collect;
>> +	config.cb = &filter_spec;
>> +
>> +	normalized_url = url_normalize(url, &config.url);
>
> `url_normalize()` will return a `NULL` pointer in case it cannot parse
> the URL. We need to be prepared for this, otherwise we might segfault.
> I guess the best route is to simply ignore the URL in that case --
> otherwise, we would always error out in case the remote has a weird URL
> configured.
>
>> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
>> index 1e354e057f..1254901f3e 100755
>> --- a/t/t5616-partial-clone.sh
>> +++ b/t/t5616-partial-clone.sh
>> @@ -722,6 +722,124 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
>>  	git -C partial gc --prune=now
>>  '
>>  
>> +# Test clone.<url>.defaultObjectFilter config
>> +
>> +test_expect_success 'setup for clone.defaultObjectFilter tests' '
>> +	git init default-filter-src &&
>> +	echo "small" >default-filter-src/small.txt &&
>> +	dd if=/dev/zero of=default-filter-src/large.bin bs=1024 count=100 2>/dev/null &&
>> +	git -C default-filter-src add . &&
>> +	git -C default-filter-src commit -m "initial" &&
>> +
>> +	git clone --bare "file://$(pwd)/default-filter-src" default-filter-srv.bare &&
>> +	git -C default-filter-srv.bare config --local uploadpack.allowfilter 1 &&
>> +	git -C default-filter-srv.bare config --local uploadpack.allowanysha1inwant 1
>> +'
>> +
>> +test_expect_success 'clone with clone.<url>.defaultObjectFilter applies filter' '
>> +	SERVER_URL="file://$(pwd)/default-filter-srv.bare" &&
>> +	git -c "clone.$SERVER_URL.defaultObjectFilter=blob:limit=1k" clone \
>> +		"$SERVER_URL" default-filter-clone &&
>
> Do we want to "test_when_finished rm -rf default-filter-clone" here and
> for all the subsequent tests?
>
> Patrick
