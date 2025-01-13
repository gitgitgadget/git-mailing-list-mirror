Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA94190692
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789114; cv=none; b=piQA6o+AQGIAhIftR8JKWrdGSR94BvsuAg7xvn76pFdYfaOzVRUJ+vIa5TsNZ2ghC1DLOq13AfILT7w3QNBl8UtQxU0ZjhGSfNOsA7wyeGm+w8+W7qVXgjHqOiVPIngGKTB1C74cOI9oOqDeNUKlO30FgXDUPA8ox5JVCyL9tHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789114; c=relaxed/simple;
	bh=jFnVSpgCX4mxcd/rgWKvs+Cil/C5i3D7AJS7hNcdCd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=toePXpOUZyQJSzbiGVGrIP+vt/f1dGbm+oyQM9atdNTgixzXZAHKFd436pSH87p27lJdsvKAG35islsyQxJwCFeDI1eZFPo2oVP9JwqEY/URfjn7Fw+flFnGyWjKkcQBaC4w8wlC1Un9xffMdHP/Cdb8xJyTG4Y4+qjQcD8XlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cJqJurRy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j6qF9sOm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cJqJurRy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j6qF9sOm"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B549925401A5;
	Mon, 13 Jan 2025 12:25:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 13 Jan 2025 12:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736789111; x=1736875511; bh=sBNZGuejGe
	P4ZUkvpH4eEvUA7QKwoBHtlCaUAJZm8yE=; b=cJqJurRyP6GHI3etfhYgVI8BRo
	FX4kdj62RFT4xuDyXuZwIIO4sSzqGS11xfZbWKEndzAc6V43JHqniUkj+OF44CZ8
	gESr0wlE5KUTtP5UwnED0D+JUM902+jZRYiF6QxEqRM/lMHzt2kEVEjDiRQcMhmY
	kvXn3vaRUH7mVCQMJLLRCbRnHk4CdspWpjjA6dUDJgSwNH3cxOuRxAMOrwbh1LCU
	Uck2UGPaEp/Lcp1gmoEkAJsVO6rGaASBHf4EitKn8IeKtb/8iCko6A25VwBbX8Cf
	J+zwZHy+FJMR9AzCn10GKg+fkC2XTOhbRxk8a7v1HkU0wNgCDdNsfxsEXt0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736789111; x=1736875511; bh=sBNZGuejGeP4ZUkvpH4eEvUA7QKwoBHtlCa
	UAJZm8yE=; b=j6qF9sOmJyZKNBh3ukieSDKYrICxV4+2I6VGWy5mPeSNZL2opZd
	ktkM8MppWDTRtuzIZHEOBpPj+UleerBy0MmeANs0ahq7rNM1hiASsGA1mIhhjlXy
	jt/WSRXWCdwfv7eMj7zg4Au/4ZHnD8QKOZsQQVFKpaS57fF+a2XS3HjjhD/CLcH4
	7F8L42IfMLa01jRvSo5hjsey4MM8L+aqNG6FeEQS2lCVLw8ZdsBsge1V7GA80wJo
	hlWzDeC0WLTSHcCCAda9BiGoy19jN+LtZ5eYEZSO3feZ3kSlTCL5Q4rwVI5yEtNw
	1jorAA2LAyHVr8AN6UU3jVGTW7kLBmDm5Zg==
X-ME-Sender: <xms:d0yFZ-tYhlDaQMgpLJS_acd_NZos7VJZeTAYmtyCWLSdbikbj8CR9w>
    <xme:d0yFZzcasQfZpfXk47PJYKgIrCNUZE9o52D_49-KVZCtdl4AF22gbO72SwGj0BjUq
    Lwo2B_DmGr9IU4faA>
X-ME-Received: <xmr:d0yFZ5zrCTj2HHJ4cote-ip_EWCNRLpzuyDzG6ME0kagsBgYkcc0G7k13laOBFTByApLafQ82IAcVK9h_3WXeO69iq1RUFQnfKB_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehrohhs
    shdrghholhgusggvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:d0yFZ5PlmoYgdVWoplt9cUDnaJ_SLIh8dQT3PKKqYhBsW-OksVaAmg>
    <xmx:d0yFZ--V_dNEvi2eMiqNf9Nhi31hxtFabmcddrRUmKiMDqktQcS52Q>
    <xmx:d0yFZxUt6BILUmIiwDPkwFHQGm0BSEdjT8LoikvG4CdgrX1qcHx96w>
    <xmx:d0yFZ3ehVd0UZF53_eEjqkZUDgODUZlVzDhTnLX0UOthV_5eOjcOfw>
    <xmx:d0yFZ-zOt5RfFA8jy2aA4F2V_GfVCLHTzSbakXrzOSV2qf3sVDLaH9uQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 12:25:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Ross Goldberg
 <ross.goldberg@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
In-Reply-To: <20250113051700.GA767856@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 13 Jan 2025 00:17:00 -0500")
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
	<6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
	<20250113051700.GA767856@coredump.intra.peff.net>
Date: Mon, 13 Jan 2025 09:25:09 -0800
Message-ID: <xmqqfrlmaaoa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> For now there is no program that uses more than one ref-filter format.
> But it seems like an obvious interface that would want to be lib-ified
> eventually. We are not there yet because of the static global used_atoms
> array. But the obvious path forward is to have a context struct
> representing one ref-filter iteration.
>
> I think the intent was that ref_format would be that context struct,
> though arguably it is a little funny since it forces the sorting and
> formatting to be joined (OTOH, that is very much how the code works,
> since it wants to share results between the two for efficiency).
>
> So one solution would be to make the use of that context struct more
> explicit, and require ref_sorting callers to provide a format struct.
> Like the patch below, which also passes your tests.
>
> I dunno. Your patch is deleting more code, which is nice. But I think in
> the long run we'd end up replacing it. But maybe making a clean slate
> now would make that easier? I could go either way.

I agree with you that libification effort would want to move more
static variables to members in a context structure.  I initially
suspected that would be more or less orthogonal, because it is not
like we are adding a static or two to a code path that already holds
everything else in a context structure, and would be a lot more
work, but now you have a patch that makes the first step in that
direction and it does not look too bad at all, so ...

Thanks.

> ---
>  builtin/branch.c       |  2 +-
>  builtin/for-each-ref.c |  2 +-
>  builtin/ls-remote.c    |  4 +++-
>  builtin/tag.c          |  2 +-
>  ref-filter.c           | 19 ++++++++-----------
>  ref-filter.h           |  2 +-
>  6 files changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 6e7b0cfddb..0c3f35cd0a 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -875,7 +875,7 @@ int cmd_branch(int argc,
>  		 * local branches 'refs/heads/...' and finally remote-tracking
>  		 * branches 'refs/remotes/...'.
>  		 */
> -		sorting = ref_sorting_options(&sorting_options);
> +		sorting = ref_sorting_options(&sorting_options, &format);
>  		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>  		ref_sorting_set_sort_flags_all(
>  			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 715745a262..4f247efe57 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -80,7 +80,7 @@ int cmd_for_each_ref(int argc,
>  	if (verify_ref_format(&format))
>  		usage_with_options(for_each_ref_usage, opts);
>  
> -	sorting = ref_sorting_options(&sorting_options);
> +	sorting = ref_sorting_options(&sorting_options, &format);
>  	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>  	filter.ignore_case = icase;
>  
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 42f34e1236..ed38b82346 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -61,6 +61,7 @@ int cmd_ls_remote(int argc,
>  	const struct ref *ref;
>  	struct ref_array ref_array;
>  	struct ref_sorting *sorting;
> +	struct ref_format format = REF_FORMAT_INIT;
>  	struct string_list sorting_options = STRING_LIST_INIT_DUP;
>  
>  	struct option options[] = {
> @@ -155,7 +156,7 @@ int cmd_ls_remote(int argc,
>  		item->symref = xstrdup_or_null(ref->symref);
>  	}
>  
> -	sorting = ref_sorting_options(&sorting_options);
> +	sorting = ref_sorting_options(&sorting_options, &format);
>  	ref_array_sort(sorting, &ref_array);
>  
>  	for (i = 0; i < ref_array.nr; i++) {
> @@ -173,6 +174,7 @@ int cmd_ls_remote(int argc,
>  		status = 1;
>  	transport_ls_refs_options_release(&transport_options);
>  
> +	ref_format_clear(&format);
>  	strvec_clear(&pattern);
>  	string_list_clear(&server_options, 0);
>  	return status;
> diff --git a/builtin/tag.c b/builtin/tag.c
> index c4bd145831..a5240f66e2 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -574,7 +574,7 @@ int cmd_tag(int argc,
>  			die(_("options '%s' and '%s' cannot be used together"), "--column", "-n");
>  		colopts = 0;
>  	}
> -	sorting = ref_sorting_options(&sorting_options);
> +	sorting = ref_sorting_options(&sorting_options, &format);
>  	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>  	filter.ignore_case = icase;
>  	if (cmdmode == 'l') {
> diff --git a/ref-filter.c b/ref-filter.c
> index 23054694c2..f5d0c448ed 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -3536,23 +3536,19 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
>  	free_array_item(ref_item);
>  }
>  
> -static int parse_sorting_atom(const char *atom)
> +static int parse_sorting_atom(struct ref_format *format, const char *atom)
>  {
> -	/*
> -	 * This parses an atom using a dummy ref_format, since we don't
> -	 * actually care about the formatting details.
> -	 */
> -	struct ref_format dummy = REF_FORMAT_INIT;
>  	const char *end = atom + strlen(atom);
>  	struct strbuf err = STRBUF_INIT;
> -	int res = parse_ref_filter_atom(&dummy, atom, end, &err);
> +	int res = parse_ref_filter_atom(format, atom, end, &err);
>  	if (res < 0)
>  		die("%s", err.buf);
>  	strbuf_release(&err);
>  	return res;
>  }
>  
> -static void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
> +static void parse_ref_sorting(struct ref_format *format,
> +			      struct ref_sorting **sorting_tail, const char *arg)
>  {
>  	struct ref_sorting *s;
>  
> @@ -3567,17 +3563,18 @@ static void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg
>  	if (skip_prefix(arg, "version:", &arg) ||
>  	    skip_prefix(arg, "v:", &arg))
>  		s->sort_flags |= REF_SORTING_VERSION;
> -	s->atom = parse_sorting_atom(arg);
> +	s->atom = parse_sorting_atom(format, arg);
>  }
>  
> -struct ref_sorting *ref_sorting_options(struct string_list *options)
> +struct ref_sorting *ref_sorting_options(struct string_list *options,
> +					struct ref_format *format)
>  {
>  	struct string_list_item *item;
>  	struct ref_sorting *sorting = NULL, **tail = &sorting;
>  
>  	if (options->nr) {
>  		for_each_string_list_item(item, options)
> -			parse_ref_sorting(tail, item->string);
> +			parse_ref_sorting(format, tail, item->string);
>  	}
>  
>  	/*
> diff --git a/ref-filter.h b/ref-filter.h
> index 754038ab07..1531bf1762 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -168,7 +168,7 @@ int format_ref_array_item(struct ref_array_item *info,
>  /* Release a "struct ref_sorting" */
>  void ref_sorting_release(struct ref_sorting *);
>  /*  Convert list of sort options into ref_sorting */
> -struct ref_sorting *ref_sorting_options(struct string_list *);
> +struct ref_sorting *ref_sorting_options(struct string_list *, struct ref_format *);
>  /*  Function to parse --merged and --no-merged options */
>  int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
>  /*  Get the current HEAD's description */
