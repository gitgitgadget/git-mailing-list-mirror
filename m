Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BFF32E728
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405919; cv=none; b=fJ+jXXNjgCKsQhJ3V3bDQ2C0r7sXvprkbWktHIvHC3/Ko9H9/1Jw2sZkVVVBmDTOHMi5W/pJFNjVXsoMk9h8o767lU9myHDXHeYStd8IRd28ra6j0b0HX63jWFI6pQjpkC+T3WymC2H0gV191neoxtnEuSH2ZHXDaRIOGuw29K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405919; c=relaxed/simple;
	bh=5Qs9rlCO463Zdhg4vLy1vlBJdJ0t5quqKRIpxV3byoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vo3L0AMPZJ+Vj9Ko9hLHu7ZZEn0DBz3lNY/vmjOr1xO087K4EiOkFy06WxzKjcMhxDer8yzL6BOcWM0X/W7S8g/W1hKtdjyfKES0B/w3ssqJOjvkEtvT32128zf2Aq86Ai3zzqJ1hw4VHfYo+a/UW7WVhUvPZDBX6gbbFedC6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TBmd8i+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UN/3i0FM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TBmd8i+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UN/3i0FM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5907314001DA;
	Mon, 17 Nov 2025 13:58:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 17 Nov 2025 13:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763405916; x=1763492316; bh=rCYtOk3v9K
	ICf+BcEmb/NcHI8aQ2bI7nDQcX6vb/Kx8=; b=TBmd8i+BI8JTfHwA+4x7pN4f1f
	oFGYvcVxhTrP1leoH6mjZSlrhgkxybyCQOlM5I1Fu9PbvIYnhJCxYBz1qWKrjz6B
	UkkpL+CqTAnViAIhgvCcDz78uKAKjPUOe4GQNTuXy4/bz3ZITUSqlWMAGQfj0faZ
	YToGvuTECZvuNlrzVz7q20ReDZ+FTg8kfuQYSaVWmiIQBgyS0HtRIzPenoCr334G
	eQBeWF1fQhiRYJRoZxzNTv7eFZfCow/Fldy9dC2qNABtP7eYI9FMiKYF/nBBDDRz
	596as7PFk+XrAh4zwiTxZPoH9hSFNvLRGMBzCIUvvSdrEAZM7bEKm2vMC+pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763405916; x=1763492316; bh=rCYtOk3v9KICf+BcEmb/NcHI8aQ2bI7nDQc
	X6vb/Kx8=; b=UN/3i0FMCz6EGPMV9PvINoX9RAopiJZLb4otZFnAhxK9UlfaO0A
	wjqghsZNK8aBKvT2c80XTRKM1ww3TkIQUW/uXr5Mie2JwndckSkpYnEu3N8DS/DZ
	Klk5PsoiIvxYwXBwV10p3QBuqivQbGttH1piTLDEK0+IrSj8H0wWIif53pCvosjl
	hRShEHC2JsBi5mSgBkRfiKiRl6RXgc7CCDsSIACIOmgu7d8kQTjwNf/gwaetKsTs
	drbcjX31IDnrES2AjIHtlUJ5IH7CydS57254jq9jlVyhBxEqWJjbNIJ652DZHqZm
	ZiQ/SiE0hx8wLpFRJVtaLk7TK3uSylg/CSQ==
X-ME-Sender: <xms:XHAbabMCNVFm53Ph7LE9P5UJecCurUawMGOgKewIbnRtlmpVr_4tdw>
    <xme:XHAbaZo5dOKLuPZbrJFWYtM-iW-jY2Bx9H4-GUfFYMRjRKsWq5M-C7mED-e2oSZvc
    wE2ZSID1wGOoYoG29wyLJ9mHHA-u_bWO6YYCtyj3gy6HzysA1w95G8>
X-ME-Received: <xmr:XHAbaUE9-MWesY7V2VxSt9Qno17DyGvMYxRRyQ7cT4C3iley-Z5S-Ez8QbyviHRu9p-a7njFbOKTnS1z6n4-KMtfh0RKF9fOtCzT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudelvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XHAbaWrqkwvtHSomiTc4YVUqxbkMv-S9X9tBJVe8aXSGgCdVeq6SHA>
    <xmx:XHAbaVbawz72n2uhOdlbFDxfdLnUKkHCtqPq-MWuI4ZoytiAlBB77g>
    <xmx:XHAbaXVZBRohP6FY2QDIZks06lU7eAIydIuPn4-OO79A1_csXDwOuw>
    <xmx:XHAbaW-rit41NpnhS67NP3EIJoIsx_te3A7RdJ-UhaW7jqL4uuKwRg>
    <xmx:XHAbacRWr41jP70V3OzBmn3E71Cjes5xpzFf_aLyuneQbLvdhIqMZDi2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 13:58:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  ps@pks.im,
  karthik.188@gmail.com
Subject: Re: [PATCH v4 2/2] repo: add --all to git-repo-info
In-Reply-To: <20251117151844.14802-3-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 17 Nov 2025 12:02:52 -0300")
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
	<20251117151844.14802-1-lucasseikioshiro@gmail.com>
	<20251117151844.14802-3-lucasseikioshiro@gmail.com>
Date: Mon, 17 Nov 2025 10:58:34 -0800
Message-ID: <xmqqh5usiizp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> +static void print_all_fields(struct repository *repo,
> +			     enum output_format format)
> +{
> +	struct strbuf valbuf = STRBUF_INIT;
> +
> +	for (unsigned long i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
> +		const struct field *field = &repo_info_fields[i];
> +
> +		strbuf_reset(&valbuf);
> +		field->get_value(repo, &valbuf);
> +		print_field(format, field->key, valbuf.buf);
> +	}
> +	strbuf_release(&valbuf);
> +}

I am not sure if "unsigned long i" is the type you want here.  I do
not mind, and actually I prefer, a simple platform natural "int i"
for something simple like this [*], but I know other people prefer to
use "size_t" to work with ARRAY_SIZE() these days.

    Side note: The reason they insist using size_t here is that
        "-Wsign-compare" makes the compiler complain.  But I would
        say that it only shows what a misguided feature
        -Wsign-compare warning is, especially given that the
        compiler perfectly well knows how big repo_info_fields[]
        array is and the iteration cannot do any harm if done with a
        signed integer smaller than size_t

Anyway.

We grab each field, ask it for its value, and then print it.  What a
straight-forward flow that is pleasant to read! ;-).

Compared to that, printing of individual keys given by the end-user
is much uglier, but it is not a fault of this two-patch series, so
my comment here is only as #leftoverbits for later clean-up.

The print_fields() function does this (modulo error checking for
missing key):

	for (int i = 0; i < argc; i++) {
		get_value_fn *get_value;
		const char *key = argv[i];

		get_value = get_value_fn_for_key(key);
		get_value(repo, &valbuf);

We should get rid of the get_value_fn_for_key() helper, and instead
add and use repo_info_field(const char *key) helepr.  That way, the
logic become exactly the same as the "get all" case.  The body of
the loop would read (modulo error checking for missing key):

		const struct field *field = repo_info_field(argv[i]);
	        field->get_value(repo, &valbuf);

whcih is much nicer, when the repo_info_fields[] gains more
attributes other than a callback function, we do not want to keep
adding get_this_attr_for_key() functions.

    Side note: By the way, it should be named repo_info_field[].
        Name arrays singular so that you can name its 0th element by
        saying dog[0], not dogs[0].  "dog[1] and dog[2] are friends"
        not "dogs[1] and dogs[2] are friends".  An exception is when
        most of the time you use the array as a single unit as a
        collection, passing it around in the call chain, and you
        rarely address each individual element (other than outside
        the implementation of the API).  I am OK to see such an
        array that is mostly used as a collection named plural (but
        of course, singular names are always fine).  Adding this to
        CodingGuidelines is perhaps a #leftoverbits material.

> @@ -167,6 +185,14 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
>  	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
>  		die(_("unsupported output format"));
>  
> +	if (all_keys) {
> +		if (argc)
> +			die(_("--all and <key> cannot be used together"));
> +
> +		print_all_fields(repo, format);
> +		return 0;
> +	}
>  	return print_fields(argc, argv, repo, format);

This would work, but the symmetry between a list of keys vs the
"--all" option is lost.

I'd rather see something like the following after a #leftoverbits
clean-up commit:

	if (all_keys && argc)
		die(_("--all and <key> cannot be used together"));

	if (all_keys)
		return print_all_fields(repo, format);
	else
		return print_fields(argc, argv, repo, format);

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index 2beba67889..51d55f11a5 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -4,6 +4,15 @@ test_description='test git repo-info'
>  
>  . ./test-lib.sh
>  
> +# git-repo-info keys. It must contain the same keys listed in the const
> +# repo_info_fields, in lexicographical order.
> +REPO_INFO_KEYS='
> +	layout.bare
> +	layout.shallow
> +	object.format
> +	references.format
> +'

Again, this would work for now, but maybe "git repo info --keys"
that emits these would be easier to manage.  This can be left to
#leftoverbits of course.

But then we have seem to have seen too many #leftoverbits material,
you might want to handle some or all of them in this series in a
reroll?  I am starting to become undecided.

With "repo info --keys", the user could even do

    git repo info $(git repo info --keys)

if they wanted to.

No, I am not suggesting to discard the "--all" option; only pointing
out that conceptually, "--all" can be explained in terms of
"--keys".
