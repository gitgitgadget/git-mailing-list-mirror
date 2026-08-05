Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E23E51E8
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966451; cv=none; b=QzpZN5Z2R1nKm077rvtibSGvssWS6KjAr/VyJCDOMBfZU/pVdBndIXEjhQcuAYcUzM/iIWr73IyX47baxlYLDrgRlh7r1YCtT3tOZQ9b0gdYS40KQnAJwYl99EpsDlAVUXedc52vZXGV10ymtBGKgFKl8tabF7WCrSIDvjXCm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966451; c=relaxed/simple;
	bh=ge359lfv6UpOn8elLceVOpbfcB/yWeAMu075vvoTe0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSzwXcJoR+sGZWQ/GHRnQ5BH88KJxe5QnnJxkVQZhBzgWpRDDRtop3+Us1nQKCeFtPzlKQX2W3EiovMYu+YHd1EDPvV4wvZeWwIPee/mDGLhIXV+j8KRwNaBRyAMN2EMvb7muEspBceafizzWhh4P9Ued/YqkVU3g0rZIrYKr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QLUf+9ze; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+RHoxTT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QLUf+9ze";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+RHoxTT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DC591D000FB;
	Wed,  5 Aug 2026 17:47:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 17:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785966448; x=1786052848; bh=yuGC3FNx/w
	mThofsDDZ7fFfP0wAkhPg5z8DIcJjS4lA=; b=QLUf+9zeIG6/GO1od84/XGJnoQ
	WpTByP+bQpxnTq+/lBa6yt2l+1h/fAbLH5k/Z4G9VEhg/+cwgEAriQxjow/1KjGM
	erFGYmMQtsn18UmwY9tWdeHfkJyAMAYprg1vTIHAs4DfZyf6SrxMSFiiwJbeYyTy
	c+b1Xyny/LpkPMe3B61BeMuNwh11zaHCzgqsebL4B+nTOnPCFvAlMWXxOzmlGeBc
	ug6k7F7lSWWh4dHOL5LiAbpWWgE3Oae1P/jObaET84rsgmnXA8E9spmhi0GaaujU
	h8y9Q7t/DuqGtnO7No9fWyA3/P3hsJ1nRLCmq+PZ2/3YraCmWfLkMXXB0SOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785966448; x=1786052848; bh=yuGC3FNx/wmThofsDDZ7fFfP0wAkhPg5z8D
	IcJjS4lA=; b=d+RHoxTTZZvcHNFJCucY5ZqUyHa0Wxid7jap28aH6q+Vn+saaTi
	m8t3unTh2cFpHkoBZ171t6/xBShVgNNtAVU4iAuwdzaJ8PiJVT+JeEOEEnSabEAT
	/efB5hc9bf/zrzNj7aZKufupFSA2BHQ5ZoVMFgFbcOH6sdLMWPftYaOBkL2hNpiI
	Qt8hfWWTf8aXWt3o/mgsdDPqsDO3zcTMTuqP2F2dW4pQ7OLqwPYQM49zSv566Gy9
	u2QZXRD5ifGijhWUuyh8IUwQAp3hCDMxzjOPqec/HI9Wyr8FOG0DYA3Qws1D4weX
	A8ceqyO0wKygym9VmZA48tSQld+uEuoAOng==
X-ME-Sender: <xms:cK9zarjhpC2UAHB-RtUHYLkWkZ7NGjU5Bs7Mky8bU7pwAS48SJAD7A>
    <xme:cK9zarusEC8RE7sBNGWCWd8DbmZHudO7s6caTq5Qvnfd53d8-VbKqnkPOEjhY7ukM
    LUypmr9dyZzLwnEeGgI-QOCCVoOvhcL3aUgWH8ZkqcE0uNIdzsDIQQ>
X-ME-Received: <xmr:cK9zak7ocLSU_wBhqpUUed8FrxJnNyzfDunBHgvTPmWxjsx_8nvmY5ie6YSIzxLWLQ-d0PSCj7tPeWFGThA48xOgEpzgCyrn1g>
X-ME-Proxy-Cause: dmFkZTGx/MfIqfpNvUfoPwBVcAcED0vpd2QmG6fiaPyBB2W0QatI9iNE/aAC98A5kQgEp7
    ESnP0BRpxL3ry6Xq1T5gtdNhp48EcJNSsgkZNi0bIyDNNCBbVIkhRVfUlHAgfykiFQBj6r
    glPXNWLOOZwm/u3ZHS5U98LCIytsUjkD7PARlXMjxYLiI+95iWJV8AcLjZBiu0mWml5vAT
    WoFs0FsF3AYIPEGTAUxUfoKFoYjMMwz+KwgWDgOVUpOYG5CyXhydzqWD/HOl0BmzRJCdxw
    6ekslGfKuwa65z+kG4M7Ba1tbOCsOjjQ1bRjUI9bsXTstq07US0k8+JttPjl9TnIj1piCm
    bHJiaWtdYaJ9UNb9H/ljbK7q+jTdAj/r7YvPwgN09rDUFcDviQmDNtaiBwwTzqZbP0tsax
    bOVDi5johktmzoaqi5olkhxQGp1mFm91HzxbF+cmufHyf9jBGiSyGWMIylUvBuCd/wJdRN
    rgGyX8vHBQkmdIf/pNzW5aNrCb5qofLB5+IhZYns9fjDNOn74l99lZ+0ITyDtbOqozCkG0
    +1IwBbU5GZMVN54LJOxEPIKsgOHzi8jNE5TUiyS/IHxxb+OTBtFqA5DDfn8mGqB3fRQobV
    K/a2dOw55jX7YB4+1Y8rYPgfUdHNGKUhG1RLujz+eMVUPPKcjyfEmHedtGIw
X-ME-Proxy: <xmx:cK9zavNsnvQprxaFXBbVJ0bOJO3SftYjEK2GV44CVHfRvUyE50ifow>
    <xmx:cK9zaquE0A3ML-L4r0T5mciDVSWD1YRG-3ujroICcV-ANsRg6u6ZEA>
    <xmx:cK9zaqY9zl_4hD5unjQx7oVCLxFtib-TthnrMyaVBwDXDUWyWF7nhg>
    <xmx:cK9zakzaQ-3ol35mwOVV1xqE3wiH6rEkUoLQf-uYcvxLLkqr_Ks9sQ>
    <xmx:cK9zasvjPVt_cwZlx4E9JdIZyOnUEhKc9r5cGbeumU7PmYTy1APVhAHm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 17:47:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH 3/3] environment: reorder variables in
 repo_config_values structure
In-Reply-To: <20260805115342.3939931-4-cat@malon.dev> (Tian Yuchen's message
	of "Wed, 5 Aug 2026 19:53:41 +0800")
References: <20260805115342.3939931-1-cat@malon.dev>
	<20260805115342.3939931-4-cat@malon.dev>
Date: Wed, 05 Aug 2026 14:47:26 -0700
Message-ID: <xmqqo6fgnssx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Reorder the fields in struct repo_config_values and its initialization
> function to follow the order of configuration sections.
>
> Keeping the declaration and initialization order aligned makes the
> structure easier to review and maintain.

Really?

Do you have some automated tool to make sure these initialization
assignments in the environment.c file and declaration in the
environment.h file match the order in Documentation/config/*.adoc or
something else?  Have you designated some list as the authoritative
source of truth to check these against?  Without such a list to
check the code against and a mechanism to enforce the ordering, I
find it hard to agree with such a claim that this makes it easier to
maintain.

It is typical to list the structure members in the order of stricter
to looser alignment requirement of their types.  I do not know how
strictly it is followed for "struct repo_config_values", but by
spreading pointer valued members more widely with smaller enums in
between, the change certainly is making the overall structure size
larger by requiring more padding between the members with different
alignment requirements.  Not that we would have 100s of instances of
these structures.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.c | 31 +++++++++++++++++++++----------
>  environment.h | 20 +++++++++++++-------
>  2 files changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index f5628b6758..918d8b50b8 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -745,31 +745,42 @@ int git_default_config(const char *var, const char *value,
>  
>  void repo_config_values_init(struct repo_config_values *cfg)
>  {
> +	/* core */
>  	cfg->attributes_file = NULL;
>  	cfg->excludes_file = NULL;
>  	cfg->editor_program = NULL;
>  	cfg->pager_program = NULL;
>  	cfg->askpass_program = NULL;
> -	cfg->apply_default_whitespace = NULL;
> -	cfg->apply_default_ignorewhitespace = NULL;
> -	cfg->push_default = PUSH_DEFAULT_UNSPECIFIED;
> -	cfg->autorebase = AUTOREBASE_NEVER;
>  	cfg->object_creation_mode = OBJECT_CREATION_MODE;
>  	cfg->apply_sparse_checkout = 0;
> +	cfg->trust_ctime = 1;
> +	cfg->check_stat = 1;
> +	cfg->zlib_compression_level = Z_BEST_SPEED;
> +	cfg->precomposed_unicode = -1;
> +	cfg->core_sparse_checkout_cone = 0;
> +	cfg->warn_on_object_refname_ambiguity = 1;
>  	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
>  	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
>  	cfg->ignore_case = 0;
>  	cfg->trust_executable_bit = 1;
>  	cfg->has_symlinks = platform_has_symlinks();
> +
> +	/* apply */
> +	cfg->apply_default_whitespace = NULL;
> +	cfg->apply_default_ignorewhitespace = NULL;
> +
> +	/* branch */
> +	cfg->autorebase = AUTOREBASE_NEVER;
>  	cfg->branch_track = BRANCH_TRACK_REMOTE;
> -	cfg->trust_ctime = 1;
> -	cfg->check_stat = 1;
> -	cfg->zlib_compression_level = Z_BEST_SPEED;
> +
> +	/* pack */
>  	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
> -	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
> -	cfg->core_sparse_checkout_cone = 0;
> +
> +	/* push */
> +	cfg->push_default = PUSH_DEFAULT_UNSPECIFIED;
> +
> +	/* sparse */
>  	cfg->sparse_expect_files_outside_of_patterns = 0;
> -	cfg->warn_on_object_refname_ambiguity = 1;
>  }
>  
>  void repo_config_values_clear(struct repo_config_values *cfg)
> diff --git a/environment.h b/environment.h
> index 30678257b5..52ed13c0fc 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -121,16 +121,11 @@ struct repo_config_values {
>  	char *editor_program;
>  	char *pager_program;
>  	char *askpass_program;
> -	char *apply_default_whitespace;
> -	char *apply_default_ignorewhitespace;
> -	enum push_default_type push_default;
> -	enum rebase_setup_type autorebase;
>  	enum object_creation_mode object_creation_mode;
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;
>  	int zlib_compression_level;
> -	int pack_compression_level;
>  	int precomposed_unicode;
>  	int core_sparse_checkout_cone;
>  	int warn_on_object_refname_ambiguity;
> @@ -140,11 +135,22 @@ struct repo_config_values {
>  	int trust_executable_bit;
>  	int has_symlinks;
>  
> -	/* section "sparse" config values */
> -	int sparse_expect_files_outside_of_patterns;
> +	/* section "apply" config values */
> +	char *apply_default_whitespace;
> +	char *apply_default_ignorewhitespace;
>  
>  	/* section "branch" config values */
> +	enum rebase_setup_type autorebase;
>  	enum branch_track branch_track;
> +
> +	/* section "pack" config values */
> +	int pack_compression_level;
> +
> +	/* section "push" config values */
> +	enum push_default_type push_default;
> +
> +	/* section "sparse" config values */
> +	int sparse_expect_files_outside_of_patterns;
>  };
>  
>  struct repo_config_values *repo_config_values(struct repository *repo);
