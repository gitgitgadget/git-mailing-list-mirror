Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084412E7BD6
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919042; cv=none; b=Mowp/1+DHcEA6uX/SV7uLla7eYZejUsEYuv+nyOHlVvKnOHrI9P9xTLAOcN2NpJz0hPYdky3TRESaaKABdEtqyvy+aYVRoYpcwgItFDUPSFEYtLKj7Z7hVAhyUkI3LmQyhIW4q11jcw7zc+VlYDBGbGOId9lT2bJZcg21KN0sJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919042; c=relaxed/simple;
	bh=IkYZScmNDdz3+5SV7jWyKEDqVlhxA6+XvE+RzUx5Lik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJ09DbjQ9arVsqGhZHB1aaVGl24gSrflv76wy0zEXklHExBfFQ9BxuX8bn1B8kyWtnLfBYBqTDLy365xK3Jg1P7Q+wpooCcMbjMemYkuJC5XWg5UZY8B2Rz4omuBQeZGbMmPh425FGI3/CLzWRFgz8Om7WIAXa5qveewhJ9WG5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KPG+tWQH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eSMrstep; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KPG+tWQH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eSMrstep"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 465091D004A9;
	Fri, 24 Jul 2026 14:50:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 24 Jul 2026 14:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784919040; x=1785005440; bh=WNoFUaXRHs
	hnTe4QO+CGiImiarO/m18i4CpOLlfke28=; b=KPG+tWQH5TgBjG2y36AwMP7sl/
	V9moiRvGsG3776pahgGObqzuC1okHJei1hlv9HZFPCLgZvsoEfZPYUpMYreX1TUB
	5nKupdBmayq+7pQDohV154bBeAbak+JPmNonzyTKxJy9DixKafkg+Zmi3AAxF7c5
	rYZSuj1uMKDyHPnPPIERyw7yVdCaGIFM7c18Yln5sb8lOAN4Ho9Qh1hPDTlH8wzc
	nowEsM8PF+tB+UZ+qvTf/If+lCN8zx7KaSvKhowujlkLQOHhVWg9yH5KB/K95hrH
	pwPb73r8UUrBasYd3DVy78BUnQ9NYNuduQjYFOPFHTKcLPEcKroW6VBhfBmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784919040; x=1785005440; bh=WNoFUaXRHshnTe4QO+CGiImiarO/m18i4Cp
	OLlfke28=; b=eSMrstepOz0K0qaQbloy2oS5i/S+jBOhqLoahSlfqe6pFZaiu0e
	yKl20sCECXLG8BShCkqheGDFMqmvT6DIx4rnAPFnsKc22PTOF4BOQ/i0iCY9la1w
	9OE3KMdCFqcB9qo9UF6hhYX6rRQXpIsd8x6gJLMscNESkS3S7saq+IDxH2cJhnZw
	zClX76ubmACj4xUpjImPgwAAg5Ykw6dk8r/I2xIslHpwUxJ+mF4w+ukZ5D3idi7n
	VZfQCGCyIu1ctEtXsOhWmP0eYMuSYIU9pLKi2Wtcekp8aNQk80bg5R+ldsKBTYMF
	/N8EfjLWXol/r7BOuh/oRYpOkMr+NAdfPmA==
X-ME-Sender: <xms:_7NjatfOevqT-SF-jsdqVS3ALEa_PuperoqRKokt_Jq7ZMmqrQ8nhg>
    <xme:_7NjaiozJc7M0K2CFN8gWucqwwJ4rDSrDJHRvlKwrCAwnEBuQqSwjQMW6glVt9z2z
    9wBdeYieDyxGDc0XomiuojdjDaLmEycbfKt84bNDuhr3tZJ1I7iKQ>
X-ME-Received: <xmr:_7Njaj6NBP3VuohtBG2MlgIgGdwJHaHO5DSKiWlpKSgsVYMKo0xaA1uzr_YsHmY72G2SkjC3Ik4sg8pENBZdEXUq_G7y0cPa3g>
X-ME-Proxy-Cause: dmFkZTE0Mcn2WUTRZ375L6KHKjMZFUxCbrHhQzIqkQeaoUtSzhQodXB/bCycF6J8qh5lTY
    vjo7o74V9Ee0jBZzZoWOqLkHf1ONkOmn2V8ZAlVDIIun4vVm4x+eOpAA+gZHUk7eJkNYZJ
    +PAkkqMBuGELYTJvFw2zDzvYEzWYo4rk8N+TofQseTf76IOJUtxnKvnKKqs4+oRf/YHRra
    t02UNHuRyYAAM2uR9baNSwlZ+pKqzTJ+FPoRFVisEduwlqV/LoPzhaeIeLgU3TL9Bn6CXK
    gOC8dff3O3ZzB8m/NH0pcI7YdgP1Bj91Vawz4jPF9+5kKvZ4zQOJyMwxak8CgdzyG/EEF/
    FYpp3WguFfx3iz5FWpKyCsdcArjLiPunMVSthzlba+grpNqmyeoenZf+NfT4G+DHAwhAsj
    EbfW195ZIpay+2hE54D9LHkB8zCVE5Qm7HGBvgWzO/GIRIuEVwBo+hVzc0098+sJXE7i8H
    pprASzTMZ/Ksa/ktp5H1EondOpICwQ0teQWsMJ7e0KepfBFCKtMSHVUHcVyirlJTJTfCEf
    wUAbJYC6GBu9ST26vQV0XXB5vKqD2UrU36jT8+HVWTgBz/mAlUSbiCFdCPLgswyqvkvALc
    SYRktk+4SejWXUwnUMwYn1YReke55sAX7POeJaeOxbHOZHRtxKpn/qCAVRPA
X-ME-Proxy: <xmx:_7NjagpbyLPpXq6oVG3559j2u66ACh7zG5xRDEh1UBzfQEX3HrFB7A>
    <xmx:_7Njatg6s5GrE_xDfvwEApmQ0u6Uh72SirqD0P57JJwTEKkNWgwjYw>
    <xmx:_7NjaiKf36lLKFpceuhdPmxabNP_Qwgv46gSMdYDATkQzNQliRcPkA>
    <xmx:_7NjalBXWtomyW-s7HnM9XMKsIAMgSNesHHh-sDQaHE_mCMVdr1J2w>
    <xmx:ALRjaix-2-5XbVa_Omj8LQz6tuPRmRG1SaIKEhSJiDnF48Rk0kI_NWeV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 14:50:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] setup: defer object database creation
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-3-3b3d265d979b@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 Jul 2026 05:48:42 +0200")
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
	<20260724-pks-odb-create-on-disk-v1-3-3b3d265d979b@pks.im>
Date: Fri, 24 Jul 2026 11:50:38 -0700
Message-ID: <xmqq5x246x35.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In a subsequent commit we'll make the creation of the on-disk data
> structures of an object database pluggable. This will lead to an
> in-between state where we have already configured the repository's
> object database, but it's not usable yet until we eventually call
> `create_object_directory()`.
>
> Defer the object database creation so that we handle both steps in the
> same function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 35 +++++++++++++++++++++++++++--------
>  setup.h |  9 +++++++++
>  2 files changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 825572f5f1..a7b1b9eaef 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1760,6 +1760,13 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
>  	return result;
>  }
>  
> +static void get_object_directories(char **object_directory,
> +				   char **alternate_object_directories)
> +{
> +	*object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
> +	*alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
> +}
> +
>  int apply_repository_format(struct repository *repo,
>  			    const struct repository_format *format,
>  			    enum apply_repository_format_flags flags,
> @@ -1779,8 +1786,9 @@ int apply_repository_format(struct repository *repo,
>  	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
>  		const char *shallow_file;
>  
> -		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
> -		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
> +		get_object_directories(&object_directory,
> +				       &alternate_object_directories);
> +
>  		shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
>  		if (shallow_file)
>  			set_alternate_shallow_file(repo, shallow_file);

HONOR_ENV still means we read the environment variable to learn where
the object directory (which is admittedly a files backend specific
concept) and alternate object directories (ditto) are.

> @@ -1803,8 +1811,9 @@ int apply_repository_format(struct repository *repo,
>  	repo->repository_format_precious_objects =
>  		format->precious_objects;
>  
> -	repo->objects = odb_new(repo, object_directory,
> -				alternate_object_directories);
> +	if (!(flags & APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION))
> +		repo->objects = odb_new(repo, object_directory,
> +					alternate_object_directories);

And SKIP_ODB_CREATION can tell apply_repository_format() not to
create an odb there.

> -static void create_object_directory(struct repository *repo)
> +static void create_object_database(struct repository *repo)
>  {
> +	char *object_directory, *alternate_object_directories;
>  	struct strbuf path = STRBUF_INIT;
>  	size_t baselen;
>  
> +	get_object_directories(&object_directory, &alternate_object_directories);
> +	repo->objects = odb_new(repo, object_directory,
> +				alternate_object_directories);
> +
>  	strbuf_addstr(&path, repo_get_object_directory(repo));
>  	baselen = path.len;
>  
> @@ -2672,6 +2686,8 @@ static void create_object_directory(struct repository *repo)
>  	strbuf_addstr(&path, "/info");
>  	safe_create_dir(repo, path.buf, 1);
>  
> +	free(alternate_object_directories);
> +	free(object_directory);
>  	strbuf_release(&path);
>  }
>  


> @@ -2867,9 +2883,10 @@ int init_db(struct repository *repo,
>  	 */
>  	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
>  	repository_format_configure(&repo_fmt, hash, ref_storage_format);
> -	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
> +	if (apply_repository_format(repo, &repo_fmt,
> +				    APPLY_REPOSITORY_FORMAT_HONOR_ENV |
> +				    APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION, &err) < 0)
>  		die("%s", err.buf);
> -	startup_info->have_repository = 1;

Early in initialization, we no longer recreate the ODB when calling
apply_repository_format(), and we defer declaring that we have a
repository until we call create_object_database().

> @@ -2885,7 +2902,9 @@ int init_db(struct repository *repo,
>  
>  	if (!(flags & INIT_DB_SKIP_REFDB))
>  		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
> -	create_object_directory(repo);
> +	create_object_database(repo);
> +
> +	startup_info->have_repository = 1;

Instead we call create_object_database() rather late, after we
finish creating leading directories and default files and processing
the configuration.  I guess this is a prelude to specifying "no, we
are not doing the files backend but are using this new thing" in the
global configuration?

> diff --git a/setup.h b/setup.h
> index 654f10e059..e55d647b70 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -241,6 +241,15 @@ enum apply_repository_format_flags {
>  	 * relate to the object database.
>  	 */
>  	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
> +
> +	/*
> +	 * Usually, the object database is created after the repository format
> +	 * was applied. This step is skipped if this flag is set, which leaves
> +	 * us with a partially-working repository.
> +	 *
> +	 * This is useful when initializing a new repository.
> +	 */
> +	APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION = (1 << 1),
>  };

OK.
