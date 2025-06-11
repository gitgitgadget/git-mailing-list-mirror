Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAD2E610A
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646776; cv=none; b=Wliy56gpT9G/sDYLgaulgMpC+BQvj6skEB/2x8FRrHpce96WSpCTbpsuxLjvteFPJJqTGadYv5J2a3kzTXFq7NJJ5MT2j0d3VNLMbkuaxBeqKgFutSoIOb6+LZN3kuHGSzY3avaZLSjpHP3uel8kH+EdT3TXf7MTzQF/OygDB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646776; c=relaxed/simple;
	bh=dMu/zFmOST6VLRFB20NE4QOusgFmPjnrPNsNylqdKs0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sA8ISa8pHlPeawYnKMs5Zr5VyiKi8L2NF2G+FmWYTjGokq1PGq1NCZhSpi+1JBk/boQVAzEmHSjzdoelw8xDeU4VcPgmHTWQjXt+EJWoqJu6AqFyLN5bIgaWpAMZjDnU5DYYV7TQYtM7zT5pqkijUxkjc/4Xf/Mh7ul4RpnhHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvP3Lzd1; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvP3Lzd1"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52d9a275c27so4560051e0c.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749646773; x=1750251573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9j++p+toPjBh0E0Z3z+jfZL04gACUQzTV33e4+ErGV0=;
        b=AvP3Lzd1JSGYk7DznCj3l43gjPyVY9hEpg2/r/S2wc6zwr4Ir+MkWh5goSWEr+cKx9
         5spGc4p1J6dxaWwgi4HlK1JGSwGo4VNP6C6dZIDeT/vakARdNVQ75FQLz6xfpw+se46o
         9oTDPVRqNin8Svue/MhSGsaSLZ4rxmfEo/j5CjUIkUx+HOBDIbslbecE+YjyASI+Uopf
         RLXybiFFo1+b6vAlKwdoMzY443lAdbCoiwFQfXjbFaUMRV06ZkArqWaFn7Y8BD/YxiwK
         dDrJ+C18K9QrtZ70FR4FJqoHHJev50nMAZZlFa5GLl39D+KWhWOerKr+trKuTzcEJplb
         dCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646773; x=1750251573;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9j++p+toPjBh0E0Z3z+jfZL04gACUQzTV33e4+ErGV0=;
        b=DjVqPSoBNsLbzCXyZ61owocGn51FD0aSKYMZ2tvFVVuqYZpSB1o4lBue+zx29p4704
         uAzZALb2xPvG/aD0+YTZ03p/XjkAN+u7ZDxRxy1NYFO/U+J3Oms5DBsOp+9ZfzXdKRwZ
         UIUaxUu/sjLkJb0IA1tX9KRPyrMUHQbA2Oi3oBQNxxM4OvNV/McA5MZH0lipxdRZsDB2
         j73WY3vaVQBoiIUCNV2LGB+AP2gomtrHRThT1easo4yd+0A4D76bdhCLleJThSwVqB/o
         H2WtfumXLS2SrHMEiDP0s5grz6I2pJZ9skhzzEkHizF+cfEeiTuxFIc79cgclvV5i17m
         dzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiaoq0CrqwDBDCSCN9uIEQs2rsB2FiaLqMi56lV/k801WhOf0rBxKphT2I8gG4cKNTc84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnoHvvpnoIn2Y848k1u4QPXGBtSWVQNj3r8gcl0dm6QZVAduR
	r8daR1eH46DtcuBjwFd1LU6pPvFwiCE345xAGu01gS/azT23fuU9G6YbUE0pmsM8PqLFWnWvS3u
	cuoOtR4TmS8ADn5bDjpT5smr5NxIug2SyvUd2nuc=
X-Gm-Gg: ASbGncvuuDgE0puA16zmgElT+zE2p2ttvfgcdJzunz6GqbkBWwcsU3MQmEMrK1CKUjz
	2mLgj8xo6ImQxWrrIferIOIpHoyqvQ+vymZUIG8LIETQaHbfu85LvdUynmjawnWAhfLByZ91U6k
	DeTZlU+RYK42iT8N0qFnR5DEQ+cSmmceXdZA+gr6Ut9w==
X-Google-Smtp-Source: AGHT+IF6WQb5Y2YYdrtol4Dv37X2nsrYKw6XfNfYc7lqggZUB3v/u5YMxZysDVrxXyGYIkwwPOtA0NxUv7Sro1zcX+c=
X-Received: by 2002:a05:6122:1d9f:b0:531:2afc:4635 with SMTP id
 71dfb90a1353d-5312afc4f28mr544799e0c.3.1749646773313; Wed, 11 Jun 2025
 05:59:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jun 2025 07:59:32 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250610152117.14826-4-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com> <20250610152117.14826-4-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Jun 2025 07:59:32 -0500
X-Gm-Features: AX0GCFuIiagfBB2J0-fRtlkL_dgL7xMdaM30y2js68nUf3S9ROwFZW0A_fTYHwM
Message-ID: <CAOLa=ZTNpSKoFcfQHDOQNhq-jdFJvGEsXm-rYKrHCZG8CfaqaQ@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 3/5] repo-info: add the field references.format
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000068011a06374b6249"

--00000000000068011a06374b6249
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the field references.format to the repo-info command. The data
> retrieved in this field is the same that currently is obtained by
> running `git rev-parse --show-ref-format`.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  builtin/repo-info.c  | 97 +++++++++++++++++++++++++++++++++++++++++---
>  t/t1518-repo-info.sh | 20 +++++++++
>  2 files changed, 112 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index 4d539a17fb..a1c9d3942e 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -9,18 +9,40 @@ enum output_format {
>  	FORMAT_JSON
>  };
>
> +enum repo_info_category {
> +	CATEGORY_REFERENCES = 1
> +};
> +
> +enum repo_info_references_field {
> +	FIELD_REFERENCES_FORMAT = 1
> +};
> +
> +struct repo_info_field {
> +	enum repo_info_category category;
> +	union {
> +		enum repo_info_references_field references;
> +	} field;
> +};
> +
>  struct repo_info {
>  	struct repository *repo;
>  	enum output_format format;
> +	int n_fields;
> +	struct repo_info_field *fields;
> +};
> +
> +const char *default_fields[] = {
> +	"references.format",
>  };
>
>  static void repo_info_init(struct repo_info *repo_info,
>  			   struct repository *repo,
>  			   char *format,
> -			   int allow_empty UNUSED,
> -			   int argc UNUSED,
> -			   const char **argv UNUSED
> +			   int allow_empty,
> +			   int argc,
> +			   const char **argv
>  			   ) {
>

Nit: we wrap to 80 chars generally, so you can put multiple arguments on
the same line.

> +	int i;
>  	repo_info->repo = repo;
>
>  	if (format == NULL || !strcmp(format, "json"))
> @@ -29,18 +51,82 @@ static void repo_info_init(struct repo_info *repo_info,
>  		repo_info->format = FORMAT_PLAINTEXT;
>  	else
>  		die("invalid format %s", format);
> +
> +	if (argc == 0 && !allow_empty) {
> +		argc = ARRAY_SIZE(default_fields);
> +		argv = default_fields;
> +	}
> +
> +	repo_info->n_fields = argc;
> +	repo_info->fields = xmalloc(argc * sizeof(struct repo_info_field));
> +

Nit: perhaps use ALLOC_ARRAY or family here?

> +	for (i = 0; i < argc; i++) {
> +		const char *arg = argv[i];
> +		struct repo_info_field *field = repo_info->fields + i;
> +
> +		if (!strcmp(arg, "references.format")) {
> +			field->category = CATEGORY_REFERENCES;
> +			field->field.references = FIELD_REFERENCES_FORMAT;
> +		}

Makes me wonder if the default fields can be defined as an array of
'repo_info_field' and avoid the strcmp since the information is
pre-defined. Perhaps something like:

  diff --git a/builtin/repo-info.c b/builtin/repo-info.c
  index a1c9d3942e..81c7b5f896 100644
  --- a/builtin/repo-info.c
  +++ b/builtin/repo-info.c
  @@ -31,8 +31,13 @@ struct repo_info {
   	struct repo_info_field *fields;
   };

  -const char *default_fields[] = {
  -	"references.format",
  +const struct repo_info_field default_fields[] = {
  +	{
  +		.category = CATEGORY_REFERENCES,
  +		.field = {
  +			.references = FIELD_REFERENCES_FORMAT
  +		},
  +	},
   };

   static void repo_info_init(struct repo_info *repo_info,
  @@ -53,8 +58,8 @@ static void repo_info_init(struct repo_info *repo_info,
   		die("invalid format %s", format);

   	if (argc == 0 && !allow_empty) {
  -		argc = ARRAY_SIZE(default_fields);
  -		argv = default_fields;
  +		repo_info->fields = (struct repo_info_field *)&default_fields;
  +		return;
   	}

   	repo_info->n_fields = argc;


> +		else {
> +			die("invalid field '%s'", arg);
> +		}
> +	}
> +}
> +
> +static void repo_info_release(struct repo_info *repo_info) {
> +	free(repo_info->fields);
>  }
>
> -static void repo_info_print_plaintext(struct repo_info *repo_info UNUSED) {
> +static void repo_info_print_plaintext(struct repo_info *repo_info) {

This should definitely go into its own commit or at least be mentioned in
the commit message.

> +	struct repository *repo = repo_info->repo;
> +	int i;

Nit: always nice to leave a newline between the variable declarations
and following code. Also we can move move `int i` declaration directly
inside the loop.

> +	for (i = 0; i < repo_info->n_fields; i++) {
> +		struct repo_info_field *field = &repo_info->fields[i];
> +		switch (field->category) {
> +		case CATEGORY_REFERENCES:
> +			switch (field->field.references) {
> +			case FIELD_REFERENCES_FORMAT:
> +				puts(ref_storage_format_to_name(
> +					repo->ref_storage_format));
> +				break;
> +			}
> +			break;
> +		}
> +	}
>  }
>
> -static void repo_info_print_json(struct repo_info *repo_info UNUSED)
> +static void repo_info_print_json(struct repo_info *repo_info)
>  {
>  	struct json_writer jw;
> +	int i;
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

Doesn't this mean that each value of CATEGORY_REFERENCES and
FIELD_REFERENCES_FORMAT should have no common bits? Especially in the
former across different categories too.

I wonder if we can solve this in a easier way. We care about:
- Retaining the order of fields input by the user
- Having a default set of fields if no input received

But, for JSON formatting, order of fields doesn't matter as per the spec
[1]:

  An object is an unordered set of name/value pairs. An object begins
  with {left brace and ends with }right brace. Each name is followed by
  :colon and the name/value pairs are separated by ,comma.

So, do we really want to keep the order? Especially since one suggestion
is to only work with the JSON format for now.

If we don't care about the order, we can simply have a structure with
bit fields and work with that.

>  	puts(jw.json.buf);
> @@ -92,6 +178,7 @@ int cmd_repo_info(
>  			     PARSE_OPT_KEEP_UNKNOWN_OPT);
>  	repo_info_init(&repo_info, repo, format, allow_empty, argc, argv);
>  	repo_info_print(&repo_info);
> +	repo_info_release(&repo_info);
>
>  	return 0;
>  }
> diff --git a/t/t1518-repo-info.sh b/t/t1518-repo-info.sh
> index 2e1a6f0c34..a99198b0f6 100755
> --- a/t/t1518-repo-info.sh
> +++ b/t/t1518-repo-info.sh
> @@ -6,6 +6,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>  . ./test-lib.sh
>
> +DEFAULT_NUMBER_OF_FIELDS=1
> +
>  parse_json () {
>  	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
>  }
> @@ -46,4 +48,22 @@ test_expect_success 'plaintext: returns empty output with allow-empty' '
>  	test_line_count = 0 output
>  '
>
> +test_repo_info 'ref format files is retrieved correctly' \
> +	'' \
> +	'references.format' 'files'
> +

This expects that the repository is created with the 'files' backend by
default, but that is defined by the 'GIT_TEST_DEFAULT_REF_FORMAT' env
variable. So wouldn't this fail when in the CI job for reftables?

> +test_repo_info 'ref format reftable is retrieved correctly' \
> +	'--ref-format=reftable' \
> +	'references.format' 'reftable'
> +
> +test_expect_success 'plaintext: output all default fields' "
> +	git repo-info --format=plaintext >actual &&
> +	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
> +"
> +
> +test_expect_success 'json: output all default fields' "
> +	git repo-info --format=json | parse_json | grep '.*\..*\..*' >actual &&
> +	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
> +"
> +

While line count is good, we should also check the default values, no?

>  test_done
> --
> 2.39.5 (Apple Git-154)

--00000000000068011a06374b6249
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e2c6b051613fd99c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oSmZiSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMk5sQy85Z2xCQU9IMlZZQmpscVQ1eWhFTzB5NFVEcAorKzdmenJIVVkx
RGs2Q2t5eEdJM3hKcjY4MC8zZjl6V3ZjaUdVcVdQYkZBR244WFp4VExZSG0yUWk4NlczSnVECmwy
MjhuQnI3dFAxdEM3NTMrZFhsc2pMeXZ5SmRuN2JjNzRrcUtWaHFyVDlhZWY0MVMweHBtdWdodmk3
SDVLNkgKM2tLMXB2UTNtby83R2RoZW04MjVYQytVTXJOeEpZQlVVa2t6NkhFeFZkTkN2WHF5Rnpu
SXN0eVgxTGVERVdkNwowSlBHZzhwY3VsOGpSc1pSU3MwTktKbU1EeWlIKzlIUTd3UC9XT2Z5UzhC
cjVWOGVLRkZNbndTNkRmU1lIMjYwCnU5VmczdkUzQ1IrRzVxN2hqK0lLQVB5eWVXZmE5dGxpQm81
ZUx5M2s3ZTQ2WWhxUkE2Q0FNeXJRT21iNFQ3UjgKb2dnQkR2ZDBvRlJPWkVNdjZtejJybG5QVzVT
US9rQzVvWmhuK1BFbmNwQ1NZN0Y3cDFzNDEzODFKQlgvMkJhaApaeDVmWC9RYldXTTBsSTNJcGNR
MVNQWm9ad0toWjBCcU5UOXZUclE1cE11SzVvUGRrMi92YjJJdlE5SXBQeldZCkRiWk4xbHdjS05a
WkJlMVFEeW12cUVSWW9ETlNuZHlMaEROOTVJbz0KPVMyM00KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000068011a06374b6249--
