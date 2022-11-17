Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49039C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 14:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiKQOCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 09:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiKQOB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 09:01:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A685B40933
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 06:01:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v27so2682626eda.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 06:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9YBORLC0JQ8hNTvZUU+L2Lt1aq3U7A0E8F0kxF+zGM=;
        b=EpeyVbxm0j+8a+EHuRsEQPxjwMvJPUeu5tAMWsmeytqwZkWjawKV9D2ZtwvVyI2nH4
         T0aOVU8B8hMKimvaksbs/K9SE70Deot/fU27fjseTL4JcuAdEorNx271fFdg2QoaWYDp
         26Q/rrig8qlP1n22xEOVFUbfBa8JZX8V+SKodjqI9PHOAtZgkv9Rwmw1UHL8ORcC/uMV
         CrWATY2x/nxC7qCrhhujoU5PNyfwIB4CsFB9SvzpEsRC7b61PGryWEC2386KOvJzfHkm
         ZA8z7dokEH10agKjKnOnhoKiOXXZDfdJCILBvLmUWg/rr5ujVLsHBluqAxbWS9Yup0uv
         FX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9YBORLC0JQ8hNTvZUU+L2Lt1aq3U7A0E8F0kxF+zGM=;
        b=Oz20DAHbme1ljjZRIeGomT2qOLSToS/BxmAH3aulPTO4bIdp3OGAo0ojq3gFwgyjeT
         X4RlqbP98y12FlbM2wUEfEP8/ZXgrAFFIFvJKWu+CAmYztKUKz7kUoKDp4VNX3YuZlO+
         omSpbUAknclZV6ewL7Xx43X9OSMYmWFdVDf8HfnBqD9/55czLeu1oxvI+ECGEFMbpiOB
         Sdj3ugX4Vg3VPjfwLI3cJJ0uKc5jThEPAW5ScngIVTLZvInbsq3GcHheNe85nLR2+wRO
         mmfn7+FvQLQJPkRrKyBiHfdf3Y6kbfCi4Bq8z1ZA/GrZKpXpsGiiHEEeMSOAPQaNWKoT
         7q6A==
X-Gm-Message-State: ANoB5pmBRqrvzXpc0n/Cmas3wHpKk6+KPI9VIXggcUMrKXqhhRyLfM1j
        N4/foBCH7N7ON1ULjj+Kjb0=
X-Google-Smtp-Source: AA0mqf6wrTKAUQrvAuNggyxc6ByEPa9x4W6xJjIUr4bwu1bt5ERRPAcp2iHs+F3jGtlxx7wxhMZaMA==
X-Received: by 2002:aa7:db90:0:b0:459:aa70:d4fd with SMTP id u16-20020aa7db90000000b00459aa70d4fdmr2206910edt.162.1668693716121;
        Thu, 17 Nov 2022 06:01:56 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id s6-20020aa7cb06000000b0046353d6f454sm562766edt.95.2022.11.17.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:01:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovfSl-004prp-0o;
        Thu, 17 Nov 2022 15:01:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 4/6] ls-tree: improving cohension in the print code
Date:   Thu, 17 Nov 2022 14:53:24 +0100
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
 <20221117113023.65865-5-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221117113023.65865-5-tenglong.tl@alibaba-inc.com>
Message-ID: <221117.86fsehisrw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> We use 'show_tree_long()' and 'show_tree_default()' to print entries
> when we want the output in 'default' or 'default long' formats.
>
> Function 'show_tree_common_default_long()' prints the "path" field as
> the last part of output, the previous part which separately implements
> in 'show_tree_long()' and 'show_tree_default()'.
>
> We can package the separate implementation together by the extension of
> "size_text" in struct "show_tree_data". By improving the cohesion in
> these two locations, some benefits such as uniform processing of the
> output can be achieved in future.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/ls-tree.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index afb65af4280..7661170f7ca 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -30,6 +30,7 @@ struct show_tree_data {
>  	const struct object_id *oid;
>  	const char *pathname;
>  	struct strbuf *base;
> +	char *size_text;
>  };
>  
>  static const char * const ls_tree_usage[] = {
> @@ -186,6 +187,7 @@ static int show_tree_common(struct show_tree_data *data, int *recurse,
>  	data->oid = oid;
>  	data->pathname = pathname;
>  	data->base = base;
> +	data->size_text = NULL;
>  
>  	if (type == OBJ_BLOB) {
>  		if (ls_options & LS_TREE_ONLY)
> @@ -204,6 +206,13 @@ static void show_tree_common_default_long(struct show_tree_data *data)
>  {
>  	int base_len = data->base->len;
>  
> +	if (data->size_text)
> +		printf("%06o %s %s %7s\t", data->mode, type_name(data->type),
> +		       find_unique_abbrev(data->oid, abbrev), data->size_text);
> +	else
> +		printf("%06o %s %s\t", data->mode, type_name(data->type),
> +		       find_unique_abbrev(data->oid, abbrev));
> +
>  	strbuf_addstr(data->base, data->pathname);
>  	write_name_quoted_relative(data->base->buf,
>  				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
> @@ -223,8 +232,6 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
>  	if (early >= 0)
>  		return early;
>  
> -	printf("%06o %s %s\t", data.mode, type_name(data.type),
> -	       find_unique_abbrev(data.oid, abbrev));
>  	show_tree_common_default_long(&data);
>  	return recurse;
>  }
> @@ -253,8 +260,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
>  		xsnprintf(size_text, sizeof(size_text), "-");
>  	}
>  
> -	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
> -	       find_unique_abbrev(data.oid, abbrev), size_text);
> +	data.size_text = size_text;
>  	show_tree_common_default_long(&data);
>  	return recurse;
>  }

I think this is a good example of how not to split up commits.

So, in this case the reader is left wondering what the point is, how
does having two callers, and introducing an exra parameter to flip
between what one or the other wants make sense for a "common" function?

It doesn't, that code should just belong in those callers, so this is
just making things more indirect.

We find out later in the series that the real reason is that this
eventually becomes an append to a "struct strbuf".

At that point we need to re-write these lines again, so in terms of
reviewers having to look at it they'd wonder here, and then look a that
code again...

This is better just either squashed into a 6/6, or in an explicit
"here's some refactoring to make a subsequent change smaller", which
e.g. could move to using the strbuf already, which we'd later make "real" use of.


