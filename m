Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C833E7
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455070; cv=none; b=gDofrDcvCMEgqtCDlmmbQCsD8RdZYn2MrpuUDSMUwoiqUfE22VOD+BUnZ5kJ8dN4A7I7VX4+yGuC3ZGvoB7FyU7fgo19bfiu/IqH5xR4+eCn5f95v8t/s2/V47mCI0be/9S8Whd/17WQ/ex1grQFmM3+4gLNrIe4oo/c0aQ82XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455070; c=relaxed/simple;
	bh=ycaTwEp6fjXRQRiKvoaQcf4xtV6tsafg57k5pLDtMTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WBZ7TRqdB+xHA9KI0u+t1znPId71ddQvTgi21NSPoq17xslD1ummRuatvFNq8PW6OBomJUEDZGaVW4XdyjRrH/Jugg6m9cFE5hd+1VJDXQcvWa88e7on6NK7SwyfcjzYcmpz7wLAorc0WCD1CY917uc2XJA6Kdh3Cmr3qGLO8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VKco16ag; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZsTV+7F; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VKco16ag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZsTV+7F"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54E2325401CA;
	Fri, 20 Jun 2025 17:31:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 20 Jun 2025 17:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750455067; x=1750541467; bh=+XRNh2/mut
	JJ5Ugu0Jucc8zeWGNdcj9/rrICoWfX+mo=; b=VKco16agF6B9pLhhk+g0m93PKv
	LpTBgWJ1gumDKQjArl3TNsomM5+40IPvDt7p7Ziryke5oav097nDpx2ExBCXxLQO
	bGoGYDY5ZDIa/tsA1/4HbE0pqCfi82Qbb5aJkUVjJluG31CuWiRICOUQxn8lrhQL
	pZJziXO0leRCpAL7Btd5kP9vVGKSPFHH+JruYyzcKHWElVyP3nW9uSVelYhV4Ay4
	xjgK615ofUowjP7RwI6MdhkV3vqe2wm8GaDjgb92iicjK8H7jpWNGd1VTs8M2QQ3
	GjfC/9b0gIkHmSNgzZR5WXSQrsZMVhH0XPKzVwN2ZlT9RqNYqLLZUwU9X9CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750455067; x=1750541467; bh=+XRNh2/mutJJ5Ugu0Jucc8zeWGNdcj9/rrI
	CoWfX+mo=; b=ZZsTV+7Fa1hFGLJ30WUq4+v9FAQL504/PUIeH8InqgXsX1GCSdU
	bWc4HwBBdy5ZGZVXboYkUgBW+yFV6DdqByvp6Ga6b8S9Xxg0RLWcyWoCNMjjN5sC
	5/5wJfjNygzeeb/qv5zqYFK56tfVykzEXcJzrPGz7w4DU4p1V0vnYJvC0zLiBp20
	lLICyVbKga+czik238baHLquyWvOaad+ZNg97HUU1KPbQ7Mo0qfloO8BAtayxe27
	xNbXbWdzPhR4DaE93KJ6pRNWfKdJOisEx2b5IVAoS/b4szwa2PEiRgRiP9ptG5Pz
	Nski2mPOR6pLAPL1HG6FEt7hYlVlOSfkwWg==
X-ME-Sender: <xms:GtNVaKYL2aeGw7Cokq-P_VXO3mRlRuB9FclQCHN6v2m1nyJTmLhLkA>
    <xme:GtNVaNY133BRYr9zeg7G-j23B-ERTyPP-i3O-xEmUKalGJgVnyHGmrBDhw2XILycD
    V-3keVzze0ezT4pkw>
X-ME-Received: <xmr:GtNVaE-IEMYptpG6xQEhh82VfUwDbAs0q8ZwrMIcIVU4nOp1BqnS1IjGlJ9k6Ao-SLBjyG1nLczdHWMRAIB-CIDQhnbT47K757w4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdelgeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GtNVaMpvOJ_0WdDP_tt81pcIUTtahbKK58JpYN-CHntFFVpJbokWZA>
    <xmx:GtNVaFrZ8vWDMRS-ji702dRErIcuc7NoiAjEBvbsI-8QLRLnF6iPhQ>
    <xmx:GtNVaKQDjNONMOUOfgzYV-g-vrzOMGx-1xCoZ08qG3qd8fwTYnOHDA>
    <xmx:GtNVaFp2sOMOxtR7705p2r9ily4P2xIhKw7M9P87ok3fZYiZDSmF_Q>
    <xmx:G9NVaJ34isjtrtDs7eRc1jGGA3CDc1T_akBbdxErlqG_mA9ODxJRDIOD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 17:31:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  ben.knoble@gmail.com
Subject: Re: [GSoC RFC PATCH v2 2/7] repo-info: add the --format flag
In-Reply-To: <20250619225751.99699-3-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 19 Jun 2025 19:57:46 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-3-lucasseikioshiro@gmail.com>
Date: Fri, 20 Jun 2025 14:31:05 -0700
Message-ID: <xmqqecve14o6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the --format flag to the repo-info command, allowing the user to
> choose between output formats. Use 'json' by default.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  builtin/repo-info.c  | 54 +++++++++++++++++++++++++++++++++++++++++++-
>  t/meson.build        |  1 +
>  t/t1900-repo-info.sh | 22 ++++++++++++++++++
>  3 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100755 t/t1900-repo-info.sh
>
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index a5c43e253f..cbe1475e30 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -1,21 +1,73 @@
>  #include "builtin.h"
> +#include "json-writer.h"
>  #include "parse-options.h"
>  
> +enum output_format {
> +	FORMAT_JSON
> +};

If you give a trailing comma after FORMAT_JSON here, then a future
step that adds other values to the enum would not have to touch this
line, e.g. instead of

     enum output_format {
    -    FORMAT_JSON
    +    FORMAT_JSON,
    +    FORMAT_FOO
     };

you can do this

     enum output_format {
         FORMAT_JSON,
    +    FORMAT_FOO,
     };

when you add a new value "FOO" to enum.

cf. Documentation/CodingGuidelines

   . since early 2012 with e1327023ea, we have been using an enum
     definition whose last element is followed by a comma.  This, like
     an array initializer that ends with a trailing comma, can be used
     to reduce the patch noise when adding a new identifier at the end.

> +struct repo_info {
> +	struct repository *repo;
> +	enum output_format format;
> +};
> +
> +static void repo_info_init(struct repo_info *repo_info,
> +			   struct repository *repo,
> +			   char *format)
> +{
> +	repo_info->repo = repo;
> +
> +	if (format == NULL || !strcmp(format, "json"))
> +		repo_info->format = FORMAT_JSON;
> +	else
> +		die("invalid format %s", format);
> +}
> +
> +static void repo_info_print_json(struct repo_info *repo_info UNUSED)
> +{
> +	struct json_writer jw;
> +
> +	jw_init(&jw);
> +
> +	jw_object_begin(&jw, 1);
> +	jw_end(&jw);
> +
> +	puts(jw.json.buf);
> +	jw_release(&jw);
> +}
> +
> +static void repo_info_print(struct repo_info *repo_info)
> +{
> +	enum output_format format = repo_info->format;
> +
> +	switch (format) {
> +	case FORMAT_JSON:
> +		repo_info_print_json(repo_info);
> +		break;
> +	}
> +}
> +
>  int cmd_repo_info(int argc,
>  		  const char **argv,
>  		  const char *prefix,
> -		  struct repository *repo UNUSED)
> +		  struct repository *repo)
>  {
>  	const char *const repo_info_usage[] = {
>  		"git repo-info",
>  		NULL
>  	};
> +	struct repo_info repo_info;
> +	char *format = NULL;
>  	struct option options[] = {
> +		OPT_STRING(0, "format", &format, N_("format"),
> +			   N_("output format")),
>  		OPT_END()
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN_OPT);
> +	repo_info_init(&repo_info, repo, format);
> +	repo_info_print(&repo_info);
>  
>  	return 0;
>  }
> diff --git a/t/meson.build b/t/meson.build
> index 50e89e764a..d9ecaba3b7 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -246,6 +246,7 @@ integration_tests = [
>    't1700-split-index.sh',
>    't1701-racy-split-index.sh',
>    't1800-hook.sh',
> +  't1900-repo-info.sh',
>    't2000-conflict-when-checking-files-out.sh',
>    't2002-checkout-cache-u.sh',
>    't2003-checkout-cache-mkdir.sh',
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> new file mode 100755
> index 0000000000..f634e1a285
> --- /dev/null
> +++ b/t/t1900-repo-info.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +test_description='test git repo-info'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +parse_json () {
> +	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
> +}
> +
> +test_lazy_prereq PERLJSON '
> +	perl -MJSON -e "exit 0"
> +'
> +
> +test_expect_success PERLJSON 'json: returns empty output with allow-empty' '

Allow-empty?

Instead of "if no command line args, list everything, or show only
the ones specified on the command line", wouldn't it be far easier
to explain if you made it "we show only the ones specified on the
command line, but giving '--all' on the command line behaves as if
you listed all the ones known to us on the command line"?

> +	git repo-info --format=json >output &&
> +	test_line_count = 2 output
> +'
> +
> +test_done
