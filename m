Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954942E54B1
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542336; cv=none; b=GW9kNQAChVo+F9VsUz87w0T0aBUD2MlPielK4nwGZddszs5AmEailFcdUUxYlsKtYS5unTa7WBP6nIwtWcat8SW6xpHyDTLgj8IGfM51kdc6x1PTkBfSDFUEV2ZqiVo3bpgvSIqfOeFxjgyz1zvvAdUq6s3qXcuVXAk2+Ls7Uzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542336; c=relaxed/simple;
	bh=kZZTr8P5/vdlnjACuOTt8Kz1oU6C2lSTnNzqjVcvJaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSakp9iGKBka1MP1/CRLR4BDRMbf+EMDDgYY4GRvwyGnLb0cw/fHzzrceIfsv/mPoeD2nTXwcfxbU0Q84MuktDuQgAKM+nWt/pcf16iH1VUT8dQNRoeezUvQNM3DD7WixjzCkPYyze2knEsiOtrX+Ibk18gvfFOB6TIY3s01gjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XP8K+Afc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQBOgKQk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XP8K+Afc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQBOgKQk"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D69747A018F;
	Thu,  3 Jul 2025 07:32:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 03 Jul 2025 07:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751542332; x=1751628732; bh=GyOUdWpdMU
	X1SohfwugvABNGtQ8XJoEKDh01hf6bRPU=; b=XP8K+Afca1ZdCfr7Dd3fqb9K2d
	dG711VnVpTzzcLx13kMgvCiqUJst6K4ECpDMknZoytkb7zv8253TSXBd02YDOTff
	8N8z0dhd0NZSdYPfHUGckFnx0sssbee9rRwnMqW2mcNLb6rHHxXU5j0jStl3BZQ4
	BetCNloz3wZT7U7RAMBna49s7gk9+/8vp86MJb7P1uJEammFsRsHMr/Lbavr5WUX
	q0AHmRoaAi+F84PjQsEe/Syp9RxmK5kST78uj8opHfpJ4ADD/1DOmxC/fhN3itNL
	Nof5qi5EjSrGm/iFPnQX1WqWnx2+vBlj9THBntcZ/u2kSO6byFokVKRRXgng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751542332; x=1751628732; bh=GyOUdWpdMUX1SohfwugvABNGtQ8XJoEKDh0
	1hf6bRPU=; b=lQBOgKQkaHhlxwAM8SI8Q+iODCNuPbqfB2bGKIZUdWTGrjhnrWx
	ow/8EHLjWcINA7okLUQN7eh4DEZpcGoRkKDBti9SJlywt47t5GMFDyw5zlSnyvPO
	NyXJLUzd5jhBqPdMwpZGBO3gi8jMJRPmR/FryUzXw7l7vhvmWjjWjMMLVPU3pMiY
	Ys1vQWyTBaSgk1b9rZzGK0LwcZOO2F0u3lJNI1xsEiJfWVu8TdrN9CngNpJELjGB
	SKlxNfidl8hEB6wQ2W4ZlAbDSc3G8NM5Hn349TgHu2Ozq/fT5LQRK1kgaj8gVz0i
	9AbHeN7ZqMKyToVugb2GCkWQ/auznTVRzbg==
X-ME-Sender: <xms:PGpmaFetxzFha0kmvq3Cs1wkYOQzUzuR7y7vPwYWoY-Puay3HJfM8g>
    <xme:PGpmaDMU6x3rD13YBfvdfIUKscKTEN7SlxkzATsudciA0J05BbRZBdYJoMTadQMZj
    McChc4WILrPiJAgwQ>
X-ME-Received: <xmr:PGpmaOjDocEYQqIpori1UXP-6oUVl8_bb96DVW2nNN-jblCwyKogEN3XRShpgIyqIOBN73Xjyy5NTQ9lSE2lxmFetLxQmNrTycxaPA1kNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PGpmaO9FptbjZuiWPvH8aeUPC4soLQzAtF2bRjar3pO9MccLoEblpA>
    <xmx:PGpmaBtFOL6oUJ5kz0KQIgJLXJWXCNdOBgr8UFaW7jJkRl5o4NA_QA>
    <xmx:PGpmaNFK1itb1LEN7CX5jLesfx3xT-ykGJSmE3H6_rpfXoTbs8t31A>
    <xmx:PGpmaIMyv9qMgSnngiTk8iRrKc2SHj3QQJJkdE_zkRYYCjJUGBPlvw>
    <xmx:PGpmaHfTxoMSM7MFawLYnPfVQJd9pU3-ehZpvXTdPyuPqKXXJ-ml7aAw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 07:32:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ab80018 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 11:32:10 +0000 (UTC)
Date: Thu, 3 Jul 2025 13:32:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
	gitster@pobox.com
Subject: Re: [GSoC RFC PATCH v2 5/7] repo-info: add the field
 references.format
Message-ID: <aGZqN-oqctJ79Chz@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-6-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619225751.99699-6-lucasseikioshiro@gmail.com>

On Thu, Jun 19, 2025 at 07:57:49PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index 6499be0eae..6ce3e6134f 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -1,21 +1,56 @@
>  #include "builtin.h"
>  #include "json-writer.h"
>  #include "parse-options.h"
> +#include "quote.h"
> +#include "refs.h"
>  
>  enum output_format {
>  	FORMAT_JSON,
>  	FORMAT_PLAINTEXT
>  };
>  
> +enum repo_info_category {
> +	CATEGORY_REFERENCES = 1 << 0
> +};
> +
> +enum repo_info_references_field {
> +	FIELD_REFERENCES_FORMAT = 1 << 0
> +};

Missing commas after both enum values.

> +struct repo_info_field {
> +	enum repo_info_category category;
> +	union {
> +		enum repo_info_references_field references;
> +	} field;
> +};

Hm, okay. I guess later patches will add separate enums for each
category, so this saves us a couple bytes as the number of categories
grows.

>  struct repo_info {
>  	struct repository *repo;
>  	enum output_format format;
> +	int n_fields;

This should be `size_t`. Also, it's typical in our code base to call
this `fields_nr`.

> +	struct repo_info_field *fields;
>  };
>  
> +static struct repo_info_field default_fields[] = {
> +	{
> +		.category = CATEGORY_REFERENCES,
> +		.field.references = FIELD_REFERENCES_FORMAT
> +	}

Missing comma.

> +};
> +
> +static void print_key_value(const char *key, const char *value) {

Formatting: the curly brace should sit on its own line.

> +	printf("%s=", key);
> +	quote_c_style(value, NULL, stdout, 0);
> +	putchar('\n');
> +}
> +
>  static void repo_info_init(struct repo_info *repo_info,
>  			   struct repository *repo,
> -			   char *format)
> +			   char *format,
> +			   int allow_empty,
> +			   int argc, const char **argv)
>  {
> +	int i;

This variable can be declared in the loop itself:

    for (int i = 0; ...)

>  	repo_info->repo = repo;
>  
>  	if (format == NULL || !strcmp(format, "json"))
> @@ -24,19 +59,83 @@ static void repo_info_init(struct repo_info *repo_info,
>  		repo_info->format = FORMAT_PLAINTEXT;
>  	else
>  		die("invalid format %s", format);
> +
> +	if (argc == 0 && !allow_empty) {
> +		repo_info->n_fields = ARRAY_SIZE(default_fields);
> +		repo_info->fields = default_fields;
> +	} else {
> +		repo_info->n_fields = argc;
> +		ALLOC_ARRAY(repo_info->fields, argc);
> +
> +		for (i = 0; i < argc; i++) {
> +			const char *arg = argv[i];
> +			struct repo_info_field *field = repo_info->fields + i;
> +
> +			if (!strcmp(arg, "references.format")) {
> +				field->category = CATEGORY_REFERENCES;
> +				field->field.references = FIELD_REFERENCES_FORMAT;
> +			} else {
> +				die("invalid field '%s'", arg);
> +			}
> +		}
> +	}
>  }
>  
> -static void repo_info_print_plaintext(struct repo_info *repo_info UNUSED)
> +static void repo_info_release(struct repo_info *repo_info)
>  {
> +	if (repo_info->fields != default_fields) free(repo_info->fields);
>  }
>  
> -static void repo_info_print_json(struct repo_info *repo_info UNUSED)
> +static void repo_info_print_plaintext(struct repo_info *repo_info) {

Formatting.

> +	struct repository *repo = repo_info->repo;
> +	int i;

Variable can be declared in the loop.

> +	for (i = 0; i < repo_info->n_fields; i++) {
> +		struct repo_info_field *field = &repo_info->fields[i];
> +		switch (field->category) {
> +		case CATEGORY_REFERENCES:
> +			switch (field->field.references) {

I wonder a bit what it buys us that we have the difference between the
category and reference format. Right now it feels like it can cause more
errors that it prevents, as we now always have doubly-nested switches.

Wouldn't it make more sense to only only pass around the fields as
`repo_info_references_field`? We could then have two arrays that we
define globally:

    static const char const* name_by_field[] = {
        [FIELD_REFERENCES_FORMAT] = "references.format",
    };

    static repo_info_category category_by_field[] = {
        [FIELD_REFERENCES_FORMAT] = CATEGORY_REFERENCES,
    };

So `name_by_field[FIELD_REFERENCES_FORMAT]` would yield the name and
`category_by_field[CATEGORY_REFERENCES]` would yield its category. But
the benefit is that you only need to pass around the field enum from now
on, all other information is implicit.

The reverse information can also be obtained easily. To e.g. get all
fields of a reference you'd iterate through `category_by_field` and take
all array indices whose value matches the desired category.

> +			case FIELD_REFERENCES_FORMAT:
> +				print_key_value("references.format",
> +						ref_storage_format_to_name(
> +							repo->ref_storage_format));
> +				break;
> +			}
> +			break;
> +		}
> +	}
> +}
> +
> +static void repo_info_print_json(struct repo_info *repo_info)
>  {
>  	struct json_writer jw;
> +	int i;

Variable can be declared in the loop.

> +	unsigned int categories = 0;
> +	unsigned int references_fields = 0;
> +	struct repository *repo = repo_info->repo;
> +
> +	for (i = 0; i < repo_info->n_fields; i++) {
> +		struct repo_info_field *field = repo_info->fields + i;
> +		categories |= field->category;
> +		switch (field->category) {
> +		case CATEGORY_REFERENCES:
> +			references_fields |= field->field.references;
> +			break;
> +		}
> +	}
>  
>  	jw_init(&jw);
>  
>  	jw_object_begin(&jw, 1);
> +
> +	if (categories & CATEGORY_REFERENCES) {
> +		jw_object_inline_begin_object(&jw, "references");
> +		if (references_fields & FIELD_REFERENCES_FORMAT) {
> +			const char *format_name = ref_storage_format_to_name(
> +				repo->ref_storage_format);
> +			jw_object_string(&jw, "format", format_name);
> +		}
> +		jw_end(&jw);
> +	}
>  	jw_end(&jw);
>  
>  	puts(jw.json.buf);

Patrick
