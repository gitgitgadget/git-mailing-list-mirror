Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85526378D6B
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857765; cv=none; b=DHgpC6/J+SrK39Z9gnF+zybqU5TUdIr3acF2PMVkzXRs5z04eJGIMuylhQQnoeWVj0tNoR5jCWRcELsZwaFH0v91vmGy+louIjz2sQMv+Jl0nW2HzukjGhnhf58UUdXHltHTmDgEmlHoICgKbdai+79lRCzFRVRLc35YPQ8buNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857765; c=relaxed/simple;
	bh=CI5U5HJZ6DFh/qpvElo/Nu3CmvCd5WX1Q9fOz2jhp0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eu1spnbeJiK7cJnAAsVw7Yf/k7qxmyWFjS7Z88x+rLLurieJxP0pPYlavedGCUHTXTqmMy37p9tAKphbhKonZ5/5K22dtxJaPJphp7Pz4zv5UsceGpCgc6tQ9zfsR7SIe4d+zwb0mwn5OKhbN4stKSY5BJrIj6zYU3WBu5cet68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=shvVogX2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARWTvsRG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="shvVogX2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARWTvsRG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7146514000B0;
	Thu, 27 Aug 2026 15:09:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 27 Aug 2026 15:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787857762; x=1787944162; bh=t11NGNnoYz
	L2Gl8l5sMzyD2junZBSnqEVY3URUorfoQ=; b=shvVogX2s/RhZm3RHAxPPpXKs1
	u7/5qYzyjf+C6RqbfBHQoQnp7iILQ3jy9xAyOUr63VG5a2a8ubh5YxY7ls5xd8O7
	NFvuPQiNCxLf3sHTuqjgzUTsW5JL9m5+rmGNCmB8a+DD+03aR0Ht2C5XEYetZE6K
	Sm4k5PRpEq8p9HSqfaFsfw/vD2hsn7NcEVnyJMRKhWa+73Xj8qDCGxKQohLIz2ks
	8Xk+gje+7L6u8OJ4MP51wQvYGrNo8E08fqucCH5EuNjkjsjYZUT+wIEkzm97f9cG
	5xzGbuLwmpHe3R4MsCL/h9xD38FDaWXtzMKVUlXaGAYzT8De3EsGi+MGHJ6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787857762; x=1787944162; bh=t11NGNnoYzL2Gl8l5sMzyD2junZBSnqEVY3
	URUorfoQ=; b=ARWTvsRGWq7sDslsI8LDPw3W6NnASDwpqDUSW0eeU/0f5WjT6cS
	9K6SD6u23TxeiW6/W7MVLEBH7pTwWyWg6Pc3vXOvrjGKzIQIkByZNIOZDoPsOUr7
	GJjL1SbOKAsAs1zTmn9dJB7Yi9cueKWkJqRdorA7SxaWnwYVhK+qJ905kmNMxann
	xu7b/OYwE6Zmn6t8r+8eFfyNkYjijcuTEH0diDLRA2hyRj01fLpkzIL7PTErexNC
	TtSxN5yaLMCIHy6n6v9J2lvzAjEN7DS0cUAJt5Vpdh/3LgSd2UQaOptA4VENZda4
	tUS2dVxLc5rrg69H0l18T5K1k1Aogq1SaDg==
X-ME-Sender: <xms:YouQaiZSt83Kwra8TPjQtgsbKS7SXAbxkAWXZ_2-jfNj1-5O5GI-KQ>
    <xme:YouQas0VtqvMA75uRP72Ipmbpb9FHeY8k74phwDuY997tocLRTxJP1PnaXX8yBK9q
    C_3IP6FBgIsH0dpsiL87EGU6usKJBV62-lBMTX81AO2-PBU5bfpwA>
X-ME-Received: <xmr:YouQaqV-l8eS3IkIKQPrt2isRjgvZugbELBJGa2ZNQgsu-fn3QxSmiEMiv8p1vYl1DTaEly-MHVWFI1dVqg4jhigX7a6V22mMg>
X-ME-Proxy-Cause: dmFkZTFH1bzJPb6vL1G1MLf4+/RzKbvsXxBlxoZFDtaZN+AoeNiDeIyP1urkkDynUKlqPe
    Y5cEQwWoghxC9+8b9HTjpJ9WC7z3+kYYzq9BqiljeP1EWcu9gsesntrGEOux5hXQJEJkhO
    H0+ePpau+QjrOgoiYknb+DuKa7ssGkv0aEvM07QJ8eoXgQYeMiACQ83TYG0I6aYzRmHlS/
    +v3pFownHVgHL+NHgB3qIHYxGupkGe7Izf3ZyUpRoyjbLzGrDg4xfZ2EL9hwOppduy5KJB
    Qjztl4FLsH/OprnDhW6vZ3vLxEbYlUtIzc3CQ1QojcB/iRtmy5DL0E6Whoi32XIxgyXJjO
    6hrDftNCzaqLy/cwadahnbNPoGqhsyIGbEaypDETPxWcE3MGWq7TNeuId48mJ5/L8SGFaV
    UL8mkKzGW2rqINQ/eZy+ENyPOujICrmzz4qyMH6PxdtO2jdfWZbPu0vBhWyxOJG/VO05/N
    OQhTHLWxacuy1MJM5v1BsbS9lam0/AAT8Yn/mQKYteo1+oVO6+eEHnKSXPbqmZvHFAtJgi
    6iJD3ll20ka0CZgCS4bqhGU4dCtX0Pxrk+gAdYmmNzsMGUVw5DgpG4FWvvE1rN4xMXWAQu
    P0+r2lbUHzz3BAraM+qQSWHe1xNqgoJiR9J30FEQJ93Ki8ajy1XUMTQK9oLQ
X-ME-Proxy: <xmx:YouQauWtL9ZimzDF6ulMPKblU1JTCiVF8EtwjeWAEnRs78zJd1wKGA>
    <xmx:YouQahdEBli8gzmITav4p83jt6Hq0IMw8Pl-seUQ_wuDnNDMyiMCaA>
    <xmx:YouQavUond3zj_pDMkwfpDKLpLomJne4MJIl-ZckFT8AY0CGnMVyrQ>
    <xmx:YouQaieYZTSi9A6pSdToHXkaKgwLmAMcNfH9cojpH3i3OSxMDzRitw>
    <xmx:YouQak0iP8ZQyH1pPaw5s9hYan66_djHeDcG-NLGRpnoP4CLMdSAUIb1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 15:09:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin: replace the_repository parameter in
 is_bare_repository()
In-Reply-To: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com> (Hardik
	Kumar's message of "Thu, 27 Aug 2026 23:59:00 +0530")
References: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
Date: Thu, 27 Aug 2026 12:09:20 -0700
Message-ID: <xmqqo6en8jof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hardik Kumar <hardikxk@gmail.com> writes:

> The patch leaves some instances of this case that would require
> additional changes rather than simply replacing the arguments passed to
> the function call.
>
> - Only update sites that do not introduce any functional changes.

How did you make sure that the places touched by this patch do not?

How do you deal with repo==NULL case in these code paths?

> - `UNUSED` is dropped from `*repo` parameter to match the changes.
>
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
>  builtin/blame.c | 4 ++--
>  builtin/gc.c    | 4 ++--
>  builtin/repo.c  | 4 ++--
>  builtin/reset.c | 4 ++--
>  transport.c     | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 48d5251c6d..dbf4b4ffc7 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -957,7 +957,7 @@ static void build_ignorelist(struct blame_scoreboard *sb,
>  int cmd_blame(int argc,
>  	      const char **argv,
>  	      const char *prefix,
> -	      struct repository *repo UNUSED)
> +	      struct repository *repo)
>  {
>  	struct rev_info revs;
>  	char *path = NULL;
> @@ -1187,7 +1187,7 @@ int cmd_blame(int argc,
>  
>  	revs.disable_stdin = 1;
>  	setup_revisions(argc, argv, &revs, NULL);
> -	if (!revs.pending.nr && is_bare_repository(the_repository)) {
> +	if (!revs.pending.nr && is_bare_repository(repo)) {
>  		struct commit *head_commit;
>  		struct object_id head_oid;
>  
> diff --git a/builtin/gc.c b/builtin/gc.c
> index de2f9e7fed..8e82cce86b 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -582,7 +582,7 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
>  int cmd_gc(int argc,
>  	   const char **argv,
>  	   const char *prefix,
> -	   struct repository *repo UNUSED)
> +	   struct repository *repo)
>  {
>  	int aggressive = 0;
>  	int force = 0;
> @@ -637,7 +637,7 @@ int cmd_gc(int argc,
>  		die(_("failed to parse gc.logExpiry value %s"), cfg.gc_log_expire);
>  
>  	if (cfg.pack_refs < 0)
> -		cfg.pack_refs = !is_bare_repository(the_repository);
> +		cfg.pack_refs = !is_bare_repository(repo);
>  
>  	argc = parse_options(argc, argv, prefix, builtin_gc_options,
>  			     builtin_gc_usage, 0);
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f83f..0bf3c0a475 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -58,9 +58,9 @@ struct repo_info_field {
>  	get_value_fn *get_value;
>  };
>  
> -static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
> +static int get_layout_bare(struct repository *repo, struct strbuf *buf)
>  {
> -	strbuf_addstr(buf, is_bare_repository(the_repository) ? "true" : "false");
> +	strbuf_addstr(buf, is_bare_repository(repo) ? "true" : "false");
>  	return 0;
>  }
>  
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 78e69bd84b..e029b7e99a 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -336,7 +336,7 @@ static int git_reset_config(const char *var, const char *value,
>  int cmd_reset(int argc,
>  	      const char **argv,
>  	      const char *prefix,
> -	      struct repository *repo UNUSED)
> +	      struct repository *repo)
>  {
>  	int reset_type = NONE, update_ref_status = 0, quiet = 0;
>  	int no_refresh = 0;
> @@ -470,7 +470,7 @@ int cmd_reset(int argc,
>  	if (reset_type != SOFT && (reset_type != MIXED || repo_get_work_tree(the_repository)))
>  		setup_work_tree(the_repository);
>  
> -	if (reset_type == MIXED && is_bare_repository(the_repository))
> +	if (reset_type == MIXED && is_bare_repository(repo))
>  		die(_("%s reset is not allowed in a bare repository"),
>  		    _(reset_type_names[reset_type]));
>  
> diff --git a/transport.c b/transport.c
> index 25e2c14a7b..82eea3024b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1528,7 +1528,7 @@ int transport_push(struct repository *r,
>  
>  	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
>  		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
> -	    !is_bare_repository(the_repository)) {
> +	    !is_bare_repository(r)) {
>  		struct ref *ref = remote_refs;
>  		struct oid_array commits = OID_ARRAY_INIT;
>  
> @@ -1555,7 +1555,7 @@ int transport_push(struct repository *r,
>  	if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
>  	     ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
>  			TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
> -	      !pretend)) && !is_bare_repository(the_repository)) {
> +	      !pretend)) && !is_bare_repository(r)) {
>  		struct ref *ref = remote_refs;
>  		struct string_list needs_pushing = STRING_LIST_INIT_DUP;
>  		struct oid_array commits = OID_ARRAY_INIT;
>
> ---
> base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
> change-id: 20260827-env-is_bare_repo-564917c2d3ab
