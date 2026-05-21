Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5D383991
	for <git@vger.kernel.org>; Thu, 21 May 2026 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386373; cv=none; b=XGVdP+cvO3t1kzKFN4Jnb5qvFQFh9D4ppbJV0xc6uRn7lHQf0T8ur26WE/PVODdNzBBuB1KK+DW6tgmGiEGQ5+T+wWGRZS1xPilXY/pvu5yq6JthMV2MU4ANa/frr7DLvLvbw/cnUe6B/fk5DGqmaG4Piv8OBHdBDOyBRokpktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386373; c=relaxed/simple;
	bh=3Mef224lEFecnlP8aBGJVxi+vOCYjzvJBHKwBppNed8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LbV553CiJl32SEqf0/PS0BaVKq+3A/erTn/9TK4ZmbCdJtN691QgK/QJv9myXpXIJVgUeEckPyuaADDh2xgnbqHxzIkR+xvuLXYUQY2Yhfznz4r8tUpyvmNY18fVzZw26jz8WVMtG6Sx1GmFfUn16Dv0vzcJq7Ke7FmkFj6hDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TAh+oIcg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YX7wsI0h; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TAh+oIcg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YX7wsI0h"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D1F341D000F7;
	Thu, 21 May 2026 13:59:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 21 May 2026 13:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779386366; x=1779472766; bh=QeHkYy1vbH
	O8HcCXZ6CAgZ0K9FQW1O7vYTYVK1D0IRE=; b=TAh+oIcg2D1ciUa4MHxe+IZQy0
	MrBrPNqFuGCzM+fnKYtj+y5Tnz0gRS/Gt9TXy1aIlabUpY72O/fiF8V9JD5UB/gO
	K6dS7ckywEk3XzKOUJvwKN59dPGAE2gnhOM8XXUQaLX5E8vwPMVdOs0d67DETNRg
	Kh80aFGTDVGeUGQNftRprf2AsSQ7Br3l7ga5u9D6zJrdlG1rJXaoIAFCRp9F9Uqd
	Ve1CoFLTOr6CGRfiq9pQA63yKyNHpY/Pr72o8jaakvhAMYgmTl01P0ImYZjD/rlk
	+Cg03VgfQ1ol2Y/Upf7jyuZcfebUO6Fd6JS863bOk7CZ4fJPrCbtIbyQ8EmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779386366; x=1779472766; bh=QeHkYy1vbHO8HcCXZ6CAgZ0K9FQW1O7vYTY
	VK1D0IRE=; b=YX7wsI0hO3NtBPuP0qN+Eiubc9OIj15XfCc8XvcG7wmK9cikLp3
	J7xlrpLTw1l7kOV/rRYwnLpdgdGNtRt9ueqsh9Gqf0m/VckN0JBPw+l2JGMWqhjW
	NG8KGHx3B/s5febnQH/lK4fvhs+1Iz5Ymn53CUK7VZlrh37GexRkKmtlEADW9Zve
	RjgoH2iisMf99RHwwKemrdam9vJNWjE0ZMvWExgkTJWkcrVe/U7871K8fNmBjdvW
	zzGPRzvQqeUsJokEogdM49FXIciJmy1Jm+dODZ3xRug/HPYXQKM7FJ0ZklVP4Ajb
	RLDYDQhBNv7vYWun/Kl8ad8tU/5U/rrWC4A==
X-ME-Sender: <xms:_kcPahtqZ8FnlGq468ThUPpDM3GjpQrfihqDN6r35Dlrxv3aaxjAwg>
    <xme:_kcPah5nEi8quRhJYP32v-wsf6LLT2sObkt2FWKQuQm5AyLbGlnLVTZzfa1BC1h4c
    cdfqYMxUgIzbnhBtK3HArvtR6FqvvCj1dbpQI50RN3UO2O9MiXeVg>
X-ME-Received: <xmr:_kcPaiLkoNvw-dJNOK5oxdJjFPJ4XCmtmsyaHNZ2PaPZpBqcjdo8_9WGlob1kxbTSZjiK6AgbladLFIEUBOkkI0VaoKlyT7bZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:_kcPah4ymsRD3NBDxZGi9d2UKeXfkICY2j_HbNn0wyWEXGunWAoFzg>
    <xmx:_kcPalzGt-AZpfXDf6pzwhlENK3LgPaC-N0YSRbtINepJyHi9mPXlw>
    <xmx:_kcPalae13l9QGtFrEFwbzaFkBfmLqzx3yL8hkSxCb7bBLzXSLvl9w>
    <xmx:_kcPanS4KpLNC8P9h9LDFOluFu0KACM0grJPp4w3X3m2OvfCNMgKdQ>
    <xmx:_kcPaiC8Ve_qO1Y61lwaDcOiwZFHXmme705BKO2_nnnYGl1tiISH-IGc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 13:59:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] setup: construct object database in
 `apply_repository_format()`
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-8-f130d2a7e8ae@pks.im>
	(Patrick Steinhardt's message of "Thu, 21 May 2026 09:42:35 +0200")
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
	<20260521-b4-pks-setup-centralize-odb-creation-v1-8-f130d2a7e8ae@pks.im>
Date: Fri, 22 May 2026 02:59:24 +0900
Message-ID: <xmqq4ik0zls3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> With the preceding changes we now always construct the repository's
> object database before applying the repository format. Remove this
> duplication by constructing it in `apply_repository_format()` instead.
>
> Note that we create the object database _after_ having set up the
> repository's hash algorithm, but _before_ setting the compat hash
> algorithm. This is intentional:
>
>   - Constructing the object database may require knowledge of its
>     intended object format.
>
>   - Setting up the compatibility hash requires the object database to be
>     initialized already, because we immediately read the loose object
>     map.
>
> The first point is sensible, the second maybe a little less so. Ideally,
> it should be the responsibility of the object database itself to
> initialize any data structures required for the compatibility hash. But
> this would require further changes, so this is kept as-is for now.

Yeah, I guess it is a good place to stop, instead of solving the
chicken-and-egg problem in one go.

> Further note that this requires us to move handling of the environment
> variables GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES into
> the repository format, as well. This allows the caller more flexibility
> around whether or not those environment variables are being honored, as
> we do do want to respect them in "setup.c", but not in "repository.c".

It seems that we really really really want to do so ;-).  "do do
want to" -> "do want to" or even "want to", perhaps.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  repository.c |  4 +---
>  setup.c      | 45 +++++++++++++++++++++------------------------
>  setup.h      | 10 ++++++++++
>  3 files changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/repository.c b/repository.c
> index 61dfbb8be6..187dd471c4 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -291,13 +291,11 @@ int repo_init(struct repository *repo,
>  	if (read_repository_format_from_commondir(&format, repo->commondir))
>  		goto error;
>  
> -	if (apply_repository_format(repo, &format, &err) < 0) {
> +	if (apply_repository_format(repo, &format, 0, &err) < 0) {
>  		warning("%s", err.buf);
>  		goto error;
>  	}
>  
> -	repo->objects = odb_new(repo, NULL, NULL);
> -
>  	if (worktree)
>  		repo_set_worktree(repo, worktree);
>  
> diff --git a/setup.c b/setup.c
> index 4a8d6230b1..513fc88749 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1752,12 +1752,22 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
>  
>  int apply_repository_format(struct repository *repo,
>  			    const struct repository_format *format,
> +			    enum apply_repository_format_flags flags,
>  			    struct strbuf *err)
>  {
> +	char *object_directory = NULL, *alternate_object_directories = NULL;
> +
>  	if (verify_repository_format(format, err) < 0)
>  		return -1;
>  
> +	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
> +		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
> +		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
> +	}
> +
>  	repo_set_hash_algo(repo, format->hash_algo);
> +	repo->objects = odb_new(repo, object_directory,
> +				alternate_object_directories);
>  	repo_set_compat_hash_algo(repo, format->compat_hash_algo);
>  	repo_set_ref_storage_format(repo,
>  				    format->ref_storage_format,
> @@ -1773,6 +1783,8 @@ int apply_repository_format(struct repository *repo,
>  	repo->repository_format_precious_objects =
>  		format->precious_objects;
>  
> +	free(alternate_object_directories);
> +	free(object_directory);
>  	return 0;
>  }
>  
> @@ -1785,7 +1797,8 @@ int apply_repository_format(struct repository *repo,
>   * If successful and fmt is not NULL, fill fmt with data.
>   */
>  static void check_and_apply_repository_format(struct repository *repo,
> -					      struct repository_format *fmt)
> +					      struct repository_format *fmt,
> +					      enum apply_repository_format_flags flags)
>  {
>  	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
>  	struct strbuf err = STRBUF_INIT;
> @@ -1794,7 +1807,7 @@ static void check_and_apply_repository_format(struct repository *repo,
>  		fmt = &repo_fmt;
>  
>  	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
> -	if (apply_repository_format(repo, fmt, &err) < 0)
> +	if (apply_repository_format(repo, fmt, flags, &err) < 0)
>  		die("%s", err.buf);
>  	startup_info->have_repository = 1;
>  
> @@ -1874,15 +1887,9 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
>  	}
>  
>  	if (is_git_directory(".")) {
> -		struct strvec to_free = STRVEC_INIT;
> -
>  		set_git_dir(repo, ".", 0);
> -		repo->objects = odb_new(repo,
> -					getenv_safe(&to_free, DB_ENVIRONMENT),
> -					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
> -		check_and_apply_repository_format(repo, NULL);
> -
> -		strvec_clear(&to_free);
> +		check_and_apply_repository_format(repo, NULL,
> +						  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
>  		return path;
>  	}
>  
> @@ -2034,8 +2041,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  	    startup_info->have_repository ||
>  	    /* GIT_DIR_EXPLICIT */
>  	    getenv(GIT_DIR_ENVIRONMENT)) {
> -		struct strvec to_free = STRVEC_INIT;
> -
>  		if (!repo->gitdir) {
>  			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
>  			if (!gitdir)
> @@ -2046,17 +2051,13 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  		if (startup_info->have_repository) {
>  			struct strbuf err = STRBUF_INIT;
>  
> -			repo->objects = odb_new(repo,
> -						getenv_safe(&to_free, DB_ENVIRONMENT),
> -						getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
> -			if (apply_repository_format(repo, &repo_fmt, &err) < 0)
> +			if (apply_repository_format(repo, &repo_fmt,
> +						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
>  				die("%s", err.buf);
>  
>  			clear_repository_format(&repo_fmt);
>  			strbuf_release(&err);
>  		}
> -
> -		strvec_clear(&to_free);
>  	}
>  	/*
>  	 * Since precompose_string_if_needed() needs to look at
> @@ -2805,7 +2806,6 @@ int init_db(struct repository *repo,
>  	int exist_ok = flags & INIT_DB_EXIST_OK;
>  	char *original_git_dir = real_pathdup(git_dir, 1);
>  	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> -	struct strvec to_free = STRVEC_INIT;
>  
>  	if (real_git_dir) {
>  		struct stat st;
> @@ -2826,16 +2826,14 @@ int init_db(struct repository *repo,
>  	}
>  	startup_info->have_repository = 1;
>  
> -	repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
> -				getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
> -
>  	/*
>  	 * Check to see if the repository version is right.
>  	 * Note that a newly created repository does not have
>  	 * config file, so this will not fail.  What we are catching
>  	 * is an attempt to reinitialize new repository with an old tool.
>  	 */
> -	check_and_apply_repository_format(repo, &repo_fmt);
> +	check_and_apply_repository_format(repo, &repo_fmt,
> +					  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
>  
>  	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
>  
> @@ -2892,7 +2890,6 @@ int init_db(struct repository *repo,
>  	}
>  
>  	clear_repository_format(&repo_fmt);
> -	strvec_clear(&to_free);
>  	free(original_git_dir);
>  	return 0;
>  }
> diff --git a/setup.h b/setup.h
> index 5ed92f53fa..821b55aca0 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -221,6 +221,15 @@ void clear_repository_format(struct repository_format *format);
>  int verify_repository_format(const struct repository_format *format,
>  			     struct strbuf *err);
>  
> +enum apply_repository_format_flags {
> +	/*
> +	 * Honor environment variables when applying the repository format to
> +	 * the repository. For now, this only covers environment variables that
> +	 * relate to the object database.
> +	 */
> +	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
> +};
> +
>  /*
>   * Apply the given repository format to the repo. This initializes extensions
>   * and basic data structures required for normal operation. Returns 0 on
> @@ -228,6 +237,7 @@ int verify_repository_format(const struct repository_format *format,
>   */
>  int apply_repository_format(struct repository *repo,
>  			    const struct repository_format *format,
> +			    enum apply_repository_format_flags flags,
>  			    struct strbuf *err);
>  
>  const char *get_template_dir(const char *option_template);
