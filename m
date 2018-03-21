Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6951F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeCUWEh (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:04:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39171 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbeCUWEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:04:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id k22-v6so3986604pls.6
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G3RFsRdItlHk4o2+xx7viWQRjgmWJXZmNRHxI0I4SiY=;
        b=SMd70j+AzDutfYgFdNfqqQ9sc2wLVOjNjK/cufAsPEXCgZiQ4Dq2b75ljvtB4T6WW6
         YT2x/IlYT5qjDQdF2/r5t2xtiNoQhg3QzUPDbbRcoZ0QmO7p27Kkwpo7KZj45VbikVZC
         q21yTw1SyNZ69WelyaNJUJ4hgAIP6sXXllvFbjRDyq/87SE2sNwOFVApclgER6sXNQww
         9G4WVlw5AOa+jb54hGrCaSOn7VvTzU35odhVM0hae5PZMjOxT1vYPQiRkJBrwM3MS5sN
         ssh31mdDEu/SqHFS0dEqzFqGpsddZ0J3Y4yGQooerQIpPAIIfUnP4yZr/mOmsCFi4+/2
         9lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G3RFsRdItlHk4o2+xx7viWQRjgmWJXZmNRHxI0I4SiY=;
        b=HVL5lfrzeyvwVPK1AArtpETuLOgyXGDRuxbDTCGZI1Qxp8x7kuw50+k6C/1ATA/HU5
         3ncyHytIwYY4vXBRBs9QZl4POWV/TT8ON5rogWBMmHH5OvakABBnKB0W7Qc+lY1pxMXW
         VrjBrPAl6p9vtvVlvZs0JY+OrG6EqG2jo9wDAQlVGBmeFiZ4cE9VwjIker7zHNvyoEIS
         SOUoVfBcth5eMULpRkZbKRE0PXni6rweqEPcEForpz2azVaagpLok+6A8eyZdAqabGeC
         3gwc5r+BT1uycBxLmd/5mI7UZ9d5X3w+LqUR5NA9xUcmEmud8cop8yf0rg7UFS9nEDEP
         Tjzw==
X-Gm-Message-State: AElRT7EN3rcTf8nmFdnH4nopHJR0j5Sl0HA9XJquDi7X05wSitWbaEQS
        q5SFXAIymso/qmsmcQs52gOkjQ==
X-Google-Smtp-Source: AG47ELthx8NL67YHiy8gYMMWc6NWJuiGw0GWMsNgmokPV7UH7IVrH8zUCAEcIam3C6TfB25S9MsEsg==
X-Received: by 2002:a17:902:e83:: with SMTP id 3-v6mr23008164plx.158.1521669873960;
        Wed, 21 Mar 2018 15:04:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y83sm10150375pfk.123.2018.03.21.15.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:04:33 -0700 (PDT)
Date:   Wed, 21 Mar 2018 15:04:32 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/44] repository: introduce raw object store field
Message-ID: <20180321220432.GF18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-7-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-7-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> The raw object store field will contain any objects needed for
> access to objects in a given repository.
> 
> This patch introduces the raw object store and populates it with the
> `objectdir`, which used to be part of the repository struct.
> 
> As the struct gains members, we'll also populate the function to clear
> the memory for these members.
> 
> In a later we'll introduce a struct object_parser, that will complement
> the object parsing in a repository struct: The raw object parser is the
> layer that will provide access to raw object content, while the higher
> level object parser code will parse raw objects and keeps track of
> parenthood and other object relationships using 'struct object'.
> For now only add the lower level to the repository struct.

Patch looks good. Only nit would be that I prefer the embedded struct to
be a pointer simply because I don't have to worry about putting '&' at
some points.  I know others probably feel the opposite so its not worth
changing for me :)

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/grep.c |  2 +-
>  environment.c  |  5 +++--
>  object-store.h | 18 ++++++++++++++++++
>  object.c       | 10 ++++++++++
>  path.c         |  2 +-
>  repository.c   | 14 +++++++++-----
>  repository.h   | 10 ++++------
>  sha1_file.c    |  3 ++-
>  8 files changed, 48 insertions(+), 16 deletions(-)
>  create mode 100644 object-store.h
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 3ca4ac80d8..0f0c195705 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -432,7 +432,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
>  	 * object.
>  	 */
>  	grep_read_lock();
> -	add_to_alternates_memory(submodule.objectdir);
> +	add_to_alternates_memory(submodule.objects.objectdir);
>  	grep_read_unlock();
>  
>  	if (oid) {
> diff --git a/environment.c b/environment.c
> index a5eaa97fb1..c05705e384 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -14,6 +14,7 @@
>  #include "fmt-merge-msg.h"
>  #include "commit.h"
>  #include "argv-array.h"
> +#include "object-store.h"
>  
>  int trust_executable_bit = 1;
>  int trust_ctime = 1;
> @@ -270,9 +271,9 @@ const char *get_git_work_tree(void)
>  
>  char *get_object_directory(void)
>  {
> -	if (!the_repository->objectdir)
> +	if (!the_repository->objects.objectdir)
>  		BUG("git environment hasn't been setup");
> -	return the_repository->objectdir;
> +	return the_repository->objects.objectdir;
>  }
>  
>  int odb_mkstemp(struct strbuf *template, const char *pattern)
> diff --git a/object-store.h b/object-store.h
> new file mode 100644
> index 0000000000..69bb5ac065
> --- /dev/null
> +++ b/object-store.h
> @@ -0,0 +1,18 @@
> +#ifndef OBJECT_STORE_H
> +#define OBJECT_STORE_H
> +
> +struct raw_object_store {
> +	/*
> +	 * Path to the repository's object store.
> +	 * Cannot be NULL after initialization.
> +	 */
> +	char *objectdir;
> +
> +	/* Path to extra alternate object database if not NULL */
> +	char *alternate_db;
> +};
> +
> +void raw_object_store_init(struct raw_object_store *o);
> +void raw_object_store_clear(struct raw_object_store *o);
> +
> +#endif /* OBJECT_STORE_H */
> diff --git a/object.c b/object.c
> index 9e6f9ff20b..e91711dd56 100644
> --- a/object.c
> +++ b/object.c
> @@ -445,3 +445,13 @@ void clear_commit_marks_all(unsigned int flags)
>  			obj->flags &= ~flags;
>  	}
>  }
> +
> +void raw_object_store_init(struct raw_object_store *o)
> +{
> +	memset(o, 0, sizeof(*o));
> +}
> +void raw_object_store_clear(struct raw_object_store *o)
> +{
> +	FREE_AND_NULL(o->objectdir);
> +	FREE_AND_NULL(o->alternate_db);
> +}
> diff --git a/path.c b/path.c
> index da8b655730..81a42d9115 100644
> --- a/path.c
> +++ b/path.c
> @@ -382,7 +382,7 @@ static void adjust_git_path(const struct repository *repo,
>  		strbuf_splice(buf, 0, buf->len,
>  			      repo->index_file, strlen(repo->index_file));
>  	else if (dir_prefix(base, "objects"))
> -		replace_dir(buf, git_dir_len + 7, repo->objectdir);
> +		replace_dir(buf, git_dir_len + 7, repo->objects.objectdir);
>  	else if (git_hooks_path && dir_prefix(base, "hooks"))
>  		replace_dir(buf, git_dir_len + 5, git_hooks_path);
>  	else if (repo->different_commondir)
> diff --git a/repository.c b/repository.c
> index 62f52f47fc..34c0a7f180 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "repository.h"
> +#include "object-store.h"
>  #include "config.h"
>  #include "submodule-config.h"
>  
> @@ -12,6 +13,7 @@ void initialize_the_repository(void)
>  	the_repository = &the_repo;
>  
>  	the_repo.index = &the_index;
> +	raw_object_store_init(&the_repo.objects);
>  	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
>  }
>  
> @@ -58,10 +60,10 @@ void repo_set_gitdir(struct repository *repo,
>  	free(old_gitdir);
>  
>  	repo_set_commondir(repo, o->commondir);
> -	expand_base_dir(&repo->objectdir, o->object_dir,
> +	expand_base_dir(&repo->objects.objectdir, o->object_dir,
>  			repo->commondir, "objects");
> -	free(repo->alternate_db);
> -	repo->alternate_db = xstrdup_or_null(o->alternate_db);
> +	free(repo->objects.alternate_db);
> +	repo->objects.alternate_db = xstrdup_or_null(o->alternate_db);
>  	expand_base_dir(&repo->graft_file, o->graft_file,
>  			repo->commondir, "info/grafts");
>  	expand_base_dir(&repo->index_file, o->index_file,
> @@ -140,6 +142,8 @@ static int repo_init(struct repository *repo,
>  	struct repository_format format;
>  	memset(repo, 0, sizeof(*repo));
>  
> +	raw_object_store_init(&repo->objects);
> +
>  	if (repo_init_gitdir(repo, gitdir))
>  		goto error;
>  
> @@ -214,13 +218,13 @@ void repo_clear(struct repository *repo)
>  {
>  	FREE_AND_NULL(repo->gitdir);
>  	FREE_AND_NULL(repo->commondir);
> -	FREE_AND_NULL(repo->objectdir);
> -	FREE_AND_NULL(repo->alternate_db);
>  	FREE_AND_NULL(repo->graft_file);
>  	FREE_AND_NULL(repo->index_file);
>  	FREE_AND_NULL(repo->worktree);
>  	FREE_AND_NULL(repo->submodule_prefix);
>  
> +	raw_object_store_clear(&repo->objects);
> +
>  	if (repo->config) {
>  		git_configset_clear(repo->config);
>  		FREE_AND_NULL(repo->config);
> diff --git a/repository.h b/repository.h
> index e7127baffb..6c383c05c6 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -1,6 +1,8 @@
>  #ifndef REPOSITORY_H
>  #define REPOSITORY_H
>  
> +#include "object-store.h"
> +
>  struct config_set;
>  struct index_state;
>  struct submodule_cache;
> @@ -21,13 +23,9 @@ struct repository {
>  	char *commondir;
>  
>  	/*
> -	 * Path to the repository's object store.
> -	 * Cannot be NULL after initialization.
> +	 * Holds any information related to accessing the raw object content.
>  	 */
> -	char *objectdir;
> -
> -	/* Path to extra alternate object database if not NULL */
> -	char *alternate_db;
> +	struct raw_object_store objects;
>  
>  	/*
>  	 * Path to the repository's graft file.
> diff --git a/sha1_file.c b/sha1_file.c
> index 4af422e3cf..792bb21c15 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -671,7 +671,8 @@ void prepare_alt_odb(void)
>  		return;
>  
>  	alt_odb_tail = &alt_odb_list;
> -	link_alt_odb_entries(the_repository->alternate_db, PATH_SEP, NULL, 0);
> +	link_alt_odb_entries(the_repository->objects.alternate_db,
> +			     PATH_SEP, NULL, 0);
>  
>  	read_info_alternates(get_object_directory(), 0);
>  }
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
