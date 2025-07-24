Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE7190664
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338143; cv=none; b=j7K7e1zzfr9nLmH0c33IYPJlwIO/pRrKOcJupJ4KRPvqzUmwfr2NTp61/WHw+KwOBlkpCQxZWaAwSHkBgNpa9B43M0jiitGEodcxtrf8iV80qdFcVvSFPd2GBw5KycF6ZBNCu6O9kks40akkTLtsqYL/zFDDtmgmOP9TdnEdYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338143; c=relaxed/simple;
	bh=Yue0NfUy14qKOBNySD5uOPlcBIuqzdU2uvCnEf413TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVXtq07drIB+f36o0Ff+VMONqgzgMeo/qD/uULvSxUe/VByRuj8F9GHUp1IDH7ONIoew7wz8lWCSq4YxlXQkdEwCAkppUMdvnOyaQznU/7lw89jfnb+LzZ5llqKCUcClj3Rq2DRiKf5vohz7LmdSY54yHbtgq2+mQVDbtqv/8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WOLaJfSD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZgUx/tgy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WOLaJfSD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZgUx/tgy"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 156B81D00162;
	Thu, 24 Jul 2025 02:22:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Jul 2025 02:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753338139; x=1753424539; bh=bK4kqoUc1q
	zTRbNnSjiwmX+XZ56EmtaJmm1xMYclUt0=; b=WOLaJfSDzrsDP9tj/C6sgM8X2C
	bKZUK0EIialTirMoXHaKKQiJ9NRv1IjLPVkCg6hIuJ0vKMrfupdY+FqxsOVeN6cb
	hHVNaWyxUmK5TI2Jj5fp7pUAfIDhuHr98Nezzjuybs6I6xwcGtdQrJDCZFwLI5Z9
	KIrKzsfFFhCx3AhFYvkwsacRuWwe+VTAE9zI8vPuPi1ei0TiYO1h2OSsAwVmbbXf
	64A8yFxyxgJrZ7riFuhRoXORlxKFYWec5pf+505VHpPmcOBED7UGo1hoKtjmWD+H
	O33NKNjFa0fp7zKnnoaBBoHrfP+c2rFp4MQKP3KdIYFf9F5m3dFFFatqHvOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753338139; x=1753424539; bh=bK4kqoUc1qzTRbNnSjiwmX+XZ56EmtaJmm1
	xMYclUt0=; b=ZgUx/tgyYkiDegqbDH2AOeDzMRsdzfvUhp9yCWczjQ4wMJiSegd
	Qq9SSA0sQ2TSZIUlyVxguG9Mor1xFbMdM0vzqjR1XUyLXSgpjWD49DVYg3RJuBhh
	XRCycyWe9S8QNUEBk9LpThS7vrmOHEWJTcF5dpf0aO1edN51brYmv6iJlCySnbqP
	qgP6b9oVIgqOEz9VuKorsxc4Zf1Yq0zNkfNwdlclov5R1lzK7XnHIGBRFEZknyrn
	9xmdr0hGVy2+L3qDvMzeeyIYAfK11ePPxNeA7qt1ONQv6T+rDxwwMEWhym4JO6Fv
	O9ZuR0IF8t7HAyvcFocfyxUWe1eXT3LjMcQ==
X-ME-Sender: <xms:G9GBaI2Fp2JQpilaG9N9fywFeRnhfK1KoWx9cJwAVnf0Yjz4DmWfQQ>
    <xme:G9GBaIQZiw-5MkH1QqePOd41O-tpkt606kVh-wZTN4gr8VLeXdRcnkJ_rxyS27W6R
    f0wMhy8kvme7MBn2g>
X-ME-Received: <xmr:G9GBaBxzjnXB0IkcKkb0N3ecYklq0xcIvnDJD-otbewdU90wd_-vztsKqIUPJRrKsiltBtgbRcjfV-rcXupWyRmOowUV4SZfKhjKEfL4ZTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlug
    drsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoheplhhutggrshhsvghi
    khhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:G9GBaIB7pfGIu_CT9hRMqJxprXWyny3j3IxhZbrRaZ7dzN4fSE1gKg>
    <xmx:G9GBaNF1Hp1SPqayryufnCUeKJtW9ZLCAJpEc9TXT7ppN3nWyzLIkg>
    <xmx:G9GBaPPEm6Vr2GiixxtVRkwMcWUzYy_UW2-_lBD8Dv4o4Ae7ciAkbQ>
    <xmx:G9GBaO7i1c3JPBXIqbGA1dpYrB6ODAqMu6FMZBYG5gDj6zdSnToOSw>
    <xmx:G9GBaGt16MHYDQ3JvXRj83dVWosMkHgT3J0GRsmy8ax3ZCwPBnOfE65w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 02:22:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 342482c7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 06:22:18 +0000 (UTC)
Date: Thu, 24 Jul 2025 08:22:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com
Subject: Re: [GSoC PATCH v5 5/5] repo: add the --format flag
Message-ID: <aIHRFkAdrdPZWrll@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-6-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722002835.33428-6-lucasseikioshiro@gmail.com>

On Mon, Jul 21, 2025 at 09:28:35PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 375b956d3f..5bdc3831a7 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -18,10 +18,21 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>  
>  COMMANDS
>  --------
> -info [<key>...]::
> +info [--format=<format>] [<key>...]::
>  	Retrieve metadata-related information about the current repository. Only
>  	the requested data will be returned based on their keys (see "INFO KEYS"
>  	section below).
> ++
> +The output format can be chosen through the flag `--format`. Two formats are
> +supported:
> ++
> +* `keyvalue`: output key-value pairs one per line using the `=` character as
> +the delimiter between the key and the value. This is the default.
> +
> +* `null`: similar to `keyvalue`, but using a newline character as the delimiter

Our manual typically says "NUL"-terminated format in other places, like
for example in git-update-ref(1). So let's rather name the format `nul`.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 490fa9dd49..10d02bb3ea 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -8,6 +8,11 @@
>  
>  typedef const char *get_value_fn(struct repository *repo);
>  
> +enum output_format {
> +	FORMAT_KEYVALUE,
> +	FORMAT_NULL_TERMINATED,

Likewise, this should be `FORMAT_NUL_TERMINATED`.

> @@ -61,9 +66,24 @@ static int qsort_strcmp(const void *va, const void *vb)
>  	return strcmp(a, b);
>  }
>  
> -static int print_fields(int argc, const char **argv, struct repository *repo)
> +static int print_fields(int argc, const char **argv,
> +			struct repository *repo,
> +			enum output_format format)
>  {
>  	const char *last = "";
> +	char kv_sep;
> +	char field_sep;
> +
> +	switch (format) {
> +	case FORMAT_KEYVALUE:
> +		kv_sep = '=';
> +		field_sep = '\n';
> +		break;
> +	case FORMAT_NULL_TERMINATED:
> +		kv_sep = '\n';
> +		field_sep = '\0';
> +		break;
> +	}
>  
>  	QSORT(argv, argc, qsort_strcmp);
>  

Makes sense.

> @@ -81,17 +101,38 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
>  			return error("key %s not found", key);
>  
>  		value = callback(repo);
> -		printf("%s=%s\n", key, value);
> +		printf("%s%c%s%c", key, kv_sep, value, field_sep);
>  		last = key;

This here is where we can introduce the quoting. Something like:

	if (format == FORMAT_KEYVALUE) {
		strbuf_reset(&quoted_value);
		quote_c_style(value, &quoted_value, NULL, 0);
	}

	printf("%s%c%s%c", key, kv_sep,
	       format == FORMAT_KEYVALUE ? quoted_value.buf : value,
	       field_sep);

>  	}
>  
>  	return 0;
>  }
>  
> -static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
> +static int repo_info(int argc, const char **argv, const char *prefix,
>  		     struct repository *repo)
>  {
> -	return print_fields(argc - 1, argv + 1, repo);
> +	const char *format_str = "keyvalue";
> +	enum output_format format;
> +	const char *const repo_info_usage[] = {
> +		"git repo info [<key>...]",
> +		NULL
> +	};
> +	struct option options[] = {
> +		OPT_STRING(0, "format", &format_str, N_("format"),
> +			   N_("output format")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
> +
> +	if (!strcmp(format_str, "keyvalue"))
> +		format = FORMAT_KEYVALUE;
> +	else if (!strcmp(format_str, "null"))
> +		format = FORMAT_NULL_TERMINATED;
> +	else
> +		die("invalid format %s", format_str);

Nit: this should be translated and quote the format string:

	die(_("invalid format: '%s'"), format_str);

Patrick
