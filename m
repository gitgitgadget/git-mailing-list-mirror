Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7791F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeB0UMy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:12:54 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35740 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeB0UMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:12:53 -0500
Received: by mail-pg0-f67.google.com with SMTP id l131so35930pga.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wU3dCftr2UE6mU8XTm0AM72+kCA3vljBJo305B0GCEA=;
        b=ZYzPK3bj68rB1CeQZ21NO/t95Nr4OJtZozFR471TnzwhZGPez5qb/pZxv2iAdyCkT3
         TrxJdQbrigHx8Uq2YK7xgi/YmT6bjTf6RIH3EV8mpVTRS+FHxLO5TFFa9y5uaKLHHuFR
         XwbxdBykKND5JSIJvXMVjlrBh69MmcLGHdS1ii/Batn8jfTZnm1eNBKMa1HzfhG/aCHV
         rPNBXo+c7L/y9RSu++EPK665lPkba1qa1qUC+0zeje3tVbQ7AUwVN9SmuNfkKl+jgjQ9
         mUf/m9/CqtpG4RB0tXUnGIrbdValrUiQaqBVxR3lF+8hkriEvs7ggeuIvE43kaIEZqPK
         Pzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wU3dCftr2UE6mU8XTm0AM72+kCA3vljBJo305B0GCEA=;
        b=GdKGmxvk8bDyYRqDJkNpX3NhABOVd/YAJ1ugptypLII9arYQk4H/Ue3ezwg7l3Tq/B
         Cr440ug5KOBxgKa/6tP/GZ6hNbLUJXrpMil0tRTkzIMUlrCv6YpBQAo5IIwQbGfCcMH3
         mXLuWhfe6yTz3aBq1hsT9uYnVH9ZXIg6dEfSVDaBZIOerTwvNyonA1niqIRFjsRLaYoT
         VLJMp1nHykVk8xEfcY4lZ9yrJq1jGtGosEvjmOpsR5Jf3lpI5wAdNymPUV61ByUd+Lw6
         BhHMkVdwCCVgVInAbr5lrxPxcdrsU/fiXCmEedmbfVVMW9oZQx4M13zsmd1gok6ecqPs
         NqTw==
X-Gm-Message-State: APf1xPAQk1rFiLPRxF5k8nzdf/3KfyWf0Svsr7nx3Llf7+fYieslwWrx
        MHG4eQgJOoiLtduDa5LzCIGYjA==
X-Google-Smtp-Source: AH8x226+4Bn2IBwhmaqEcHqn7yrJ5ET2YKG0DtkKUuDImbUjhfZtMztQh84fUm83JIMVRdPaPO8wNA==
X-Received: by 10.98.75.129 with SMTP id d1mr13581913pfj.19.1519762372886;
        Tue, 27 Feb 2018 12:12:52 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id v12sm7671237pfd.141.2018.02.27.12.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 12:12:52 -0800 (PST)
Date:   Tue, 27 Feb 2018 12:12:50 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 3/4] sha1_file.c: move delayed getenv(altdb) back to
 setup_git_env()
Message-ID: <20180227201250.GL209668@google.com>
References: <20180226103030.26900-1-pclouds@gmail.com>
 <20180227095846.9238-1-pclouds@gmail.com>
 <20180227095846.9238-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227095846.9238-4-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Nguyễn Thái Ngọc Duy wrote:
> getenv() is supposed to work on the main repository only. This delayed
> getenv() code in sha1_file.c makes it more difficult to convert
> sha1_file.c to a generic object store that could be used by both
> submodule and main repositories.
> 
> Move the getenv() back in setup_git_env() where other env vars are
> also fetched.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  environment.c  | 1 +
>  object-store.h | 5 ++++-
>  object.c       | 1 +
>  repository.c   | 2 ++
>  repository.h   | 1 +
>  sha1_file.c    | 6 +-----
>  6 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/environment.c b/environment.c
> index 74a2900ddf..47c6e31559 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -174,6 +174,7 @@ void setup_git_env(const char *git_dir)
>  	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
>  	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
>  	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
> +	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
>  	repo_set_gitdir(the_repository, git_dir, &args);
>  	argv_array_clear(&to_free);
>  
> diff --git a/object-store.h b/object-store.h
> index afe2f93459..9b1303549b 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -87,6 +87,9 @@ struct raw_object_store {
>  	 */
>  	char *objectdir;
>  
> +	/* Path to extra alternate object database if not NULL */
> +	char *alternate_db;
> +
>  	struct packed_git *packed_git;
>  	/* A most-recently-used ordered version of the packed_git list. */
>  	struct list_head packed_git_mru;
> @@ -109,7 +112,7 @@ struct raw_object_store {
>  	unsigned packed_git_initialized : 1;
>  };
>  
> -#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0, 0, 0 }
> +#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0, 0, 0 }
>  
>  void raw_object_store_clear(struct raw_object_store *o);
>  
> diff --git a/object.c b/object.c
> index a7c238339b..5317cfc390 100644
> --- a/object.c
> +++ b/object.c
> @@ -464,6 +464,7 @@ static void free_alt_odbs(struct raw_object_store *o)
>  void raw_object_store_clear(struct raw_object_store *o)
>  {
>  	FREE_AND_NULL(o->objectdir);
> +	FREE_AND_NULL(o->alternate_db);
>  
>  	free_alt_odbs(o);
>  	o->alt_odb_tail = NULL;
> diff --git a/repository.c b/repository.c
> index 7654b8ada9..e326f0fcbc 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -61,6 +61,8 @@ void repo_set_gitdir(struct repository *repo,
>  	repo_set_commondir(repo, o->shared_root);
>  	expand_base_dir(&repo->objects.objectdir, o->object_dir,
>  			repo->commondir, "objects");
> +	free(repo->objects.alternate_db);
> +	repo->objects.alternate_db = xstrdup_or_null(o->alternate_db);

Just a note that this only works because the object store is embedded in
the repository struct, it isn't a pointer to an object store.

Patch looks good.

>  	expand_base_dir(&repo->graft_file, o->graft_file,
>  			repo->commondir, "info/grafts");
>  	expand_base_dir(&repo->index_file, o->index_file,
> diff --git a/repository.h b/repository.h
> index b5b5d138aa..b1da2a6384 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -94,6 +94,7 @@ struct set_gitdir_args {
>  	const char *object_dir;
>  	const char *graft_file;
>  	const char *index_file;
> +	const char *alternate_db;
>  };
>  
>  extern void repo_set_gitdir(struct repository *repo,
> diff --git a/sha1_file.c b/sha1_file.c
> index dfc8deec38..ad1cd441e6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -673,15 +673,11 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
>  
>  void prepare_alt_odb(struct repository *r)
>  {
> -	const char *alt;
> -
>  	if (r->objects.alt_odb_tail)
>  		return;
>  
> -	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> -
>  	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
> -	link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
> +	link_alt_odb_entries(r, r->objects.alternate_db, PATH_SEP, NULL, 0);
>  
>  	read_info_alternates(r, r->objects.objectdir, 0);
>  }
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
