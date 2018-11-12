Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9A91F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 15:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeKMBmZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:42:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33778 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeKMBmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:42:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id o89so14036903qko.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8zIKO8Y1flLtKrTumUeDbhjDGGCaLtIeRpj7pG/wD0M=;
        b=R+F5Y2prUgNhphDYXx3h8wZKAGtQRgBZFQpcJwzQxfQbRD1RQuSkmweZ69QTe6xlhU
         um5B9qMy6ZiYRs8IYr2h7lvW6AGkerrs586TKqJLyZXaKS6uwzMj/2aOq1ALW47a3jfI
         /eA2mA8hBkyBl4mC9nnJ7GQMzfLINgfEJwkxOeaCq4lgNjQ9IhnVy54Vt7tXc5OhhWxg
         tZknLSjMZhd1s9jWT3TYBuiGd1mVxh1Jhq6JUnfrwaVeSk5HjtpMPHnv82S/FueMoBO3
         xI+p/G5ZvNloDrgsVaLW3uMtxzcM2umr/CcjDO9K654e9e4vfpFGUJN/uj3OwaL132RS
         QCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8zIKO8Y1flLtKrTumUeDbhjDGGCaLtIeRpj7pG/wD0M=;
        b=qrOt7V7SJJ00qiVZEOcaizd76wj63TOjDJZC5IRqbGVVvyUZ6NdfXUzrnUUZLOkUDG
         d6Br64slh/Vo7uiRwLjQILEJw6UpYTpIvOrfuz0LhoUCXSwMrbceZCYjilvqbdp+TXJs
         dL2i+UH4APiOrvm/3H0+FG5p0XSLRvt9Au1KZs7gLq/XIGvf1nCPO9t4Kg/0Y7nGN7P5
         t7DqQuh6bjSuJU/FvKPv3+GW/8ubfPvo4pthe4HwUaFmP8t9hO1fT5bF7HdPEpGPJJo0
         LikPenXrlNwYUBw2a207fjRsg6+Q+jVWczlGP0K0v1sgTw8/zosjNimwhUDSugFN/BgM
         82vQ==
X-Gm-Message-State: AGRZ1gKRnTvlSFSkbXkf7AzpybliehHaQOEla9LAhZzkx2uOrQMcUmTK
        yJGugRCgieKOgZYR7YSjsL4=
X-Google-Smtp-Source: AJdET5eBMN2A73DXdawXrhq4tmM0GajuqX6D9QjvHmcBXLuis0PCXNewuMWPcdYWHeJhEp5Ys4/LTA==
X-Received: by 2002:aed:3a69:: with SMTP id n96mr1436054qte.246.1542037716054;
        Mon, 12 Nov 2018 07:48:36 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:705f:75d7:178c:fe1c? ([2001:4898:8010:0:5995:75d7:178c:fe1c])
        by smtp.gmail.com with ESMTPSA id r67sm10022483qkr.28.2018.11.12.07.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:48:35 -0800 (PST)
Subject: Re: [PATCH 6/9] sha1-file: use an object_directory for the main
 object dir
To:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145039.GF7400@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <421d3b43-3425-72c9-218e-facd86e28267@gmail.com>
Date:   Mon, 12 Nov 2018 10:48:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181112145039.GF7400@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/2018 9:50 AM, Jeff King wrote:
> Our handling of alternate object directories is needlessly different
> from the main object directory. As a result, many places in the code
> basically look like this:
>
>    do_something(r->objects->objdir);
>
>    for (odb = r->objects->alt_odb_list; odb; odb = odb->next)
>          do_something(odb->path);
>
> That gets annoying when do_something() is non-trivial, and we've
> resorted to gross hacks like creating fake alternates (see
> find_short_object_filename()).
>
> Instead, let's give each raw_object_store a unified list of
> object_directory structs. The first will be the main store, and
> everything after is an alternate. Very few callers even care about the
> distinction, and can just loop over the whole list (and those who care
> can just treat the first element differently).
>
> A few observations:
>
>    - we don't need r->objects->objectdir anymore, and can just
>      mechanically convert that to r->objects->odb->path
>
>    - object_directory's path field needs to become a real pointer rather
>      than a FLEX_ARRAY, in order to fill it with expand_base_dir()
>
>    - we'll call prepare_alt_odb() earlier in many functions (i.e.,
>      outside of the loop). This may result in us calling it even when our
>      function would be satisfied looking only at the main odb.
>
>      But this doesn't matter in practice. It's not a very expensive
>      operation in the first place, and in the majority of cases it will
>      be a noop. We call it already (and cache its results) in
>      prepare_packed_git(), and we'll generally check packs before loose
>      objects. So essentially every program is going to call it
>      immediately once per program.
>
>      Arguably we should just prepare_alt_odb() immediately upon setting
>      up the repository's object directory, which would save us sprinkling
>      calls throughout the code base (and forgetting to do so has been a
>      source of subtle bugs in the past). But I've stopped short of that
>      here, since there are already a lot of other moving parts in this
>      patch.
>
>    - Most call sites just get shorter. The check_and_freshen() functions
>      are an exception, because they have entry points to handle local and
>      nonlocal directories separately.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> If the "the first one is the main store, the rest are alternates" bit is
> too subtle, we could mark each "struct object_directory" with a bit for
> "is_local".

This is probably a good thing to do proactively. We have the equivalent 
in the packed_git struct, but that's also because they get out of order. 
At the moment, I can't think of a read-only action that needs to treat 
the local object directory more carefully. The closest I know about is 
'git pack-objects --local', but that also writes a pack-file.

I assume that when we write a pack-file to the "default location" we use 
get_object_directory() instead of referring to the default object_directory?

>
>   builtin/fsck.c |  21 ++-------
>   builtin/grep.c |   2 +-
>   commit-graph.c |   5 +-
>   environment.c  |   4 +-
>   object-store.h |  27 ++++++-----
>   object.c       |  19 ++++----
>   packfile.c     |  10 ++--
>   path.c         |   2 +-
>   repository.c   |   8 +++-
>   sha1-file.c    | 122 ++++++++++++++++++-------------------------------
>   sha1-name.c    |  17 ++-----
>   11 files changed, 90 insertions(+), 147 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 55153cf92a..15338bd178 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -725,13 +725,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
>   		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
>   	} else {
> -		struct object_directory *alt_odb_list;
> -
> -		fsck_object_dir(get_object_directory());
> -
>   		prepare_alt_odb(the_repository);
> -		alt_odb_list = the_repository->objects->alt_odb_list;
> -		for (odb = alt_odb_list; odb; odb = odb->next)
> +		for (odb = the_repository->objects->odb; odb; odb = odb->next)
>   			fsck_object_dir(odb->path);
>   
>   		if (check_full) {
> @@ -834,13 +829,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
>   		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL };
>   
> -		commit_graph_verify.argv = verify_argv;
> -		commit_graph_verify.git_cmd = 1;
> -		if (run_command(&commit_graph_verify))
> -			errors_found |= ERROR_COMMIT_GRAPH;
> -
>   		prepare_alt_odb(the_repository);
> -		for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
> +		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
>   			child_process_init(&commit_graph_verify);
>   			commit_graph_verify.argv = verify_argv;
>   			commit_graph_verify.git_cmd = 1;
> @@ -855,13 +845,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   		struct child_process midx_verify = CHILD_PROCESS_INIT;
>   		const char *midx_argv[] = { "multi-pack-index", "verify", NULL, NULL, NULL };
>   
> -		midx_verify.argv = midx_argv;
> -		midx_verify.git_cmd = 1;
> -		if (run_command(&midx_verify))
> -			errors_found |= ERROR_COMMIT_GRAPH;
> -
>   		prepare_alt_odb(the_repository);
> -		for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
> +		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
>   			child_process_init(&midx_verify);
>   			midx_verify.argv = midx_argv;
>   			midx_verify.git_cmd = 1;
> diff --git a/builtin/grep.c b/builtin/grep.c
> index d8508ddf79..714c8d91ba 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -441,7 +441,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
>   	 * object.
>   	 */
>   	grep_read_lock();
> -	add_to_alternates_memory(submodule.objects->objectdir);
> +	add_to_alternates_memory(submodule.objects->odb->path);
>   	grep_read_unlock();
>   
>   	if (oid) {
> diff --git a/commit-graph.c b/commit-graph.c
> index 5dd3f5b15c..99163c244b 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -231,7 +231,6 @@ static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
>   static int prepare_commit_graph(struct repository *r)
>   {
>   	struct object_directory *odb;
> -	char *obj_dir;
>   	int config_value;
>   
>   	if (r->objects->commit_graph_attempted)
> @@ -252,10 +251,8 @@ static int prepare_commit_graph(struct repository *r)
>   	if (!commit_graph_compatible(r))
>   		return 0;
>   
> -	obj_dir = r->objects->objectdir;
> -	prepare_commit_graph_one(r, obj_dir);
>   	prepare_alt_odb(r);
> -	for (odb = r->objects->alt_odb_list;
> +	for (odb = r->objects->odb;
>   	     !r->objects->commit_graph && odb;
>   	     odb = odb->next)
>   		prepare_commit_graph_one(r, odb->path);
> diff --git a/environment.c b/environment.c
> index 3f3c8746c2..441ce56690 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -274,9 +274,9 @@ const char *get_git_work_tree(void)
>   
>   char *get_object_directory(void)
>   {
> -	if (!the_repository->objects->objectdir)
> +	if (!the_repository->objects->odb)
>   		BUG("git environment hasn't been setup");
> -	return the_repository->objects->objectdir;
> +	return the_repository->objects->odb->path;
>   }
>   
>   int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
> diff --git a/object-store.h b/object-store.h
> index b2fa0d0df0..30faf7b391 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -24,19 +24,14 @@ struct object_directory {
>   	 * Path to the alternative object store. If this is a relative path,
>   	 * it is relative to the current working directory.
>   	 */
> -	char path[FLEX_ARRAY];
> +	char *path;
>   };
> +
>   void prepare_alt_odb(struct repository *r);
>   char *compute_alternate_path(const char *path, struct strbuf *err);
>   typedef int alt_odb_fn(struct object_directory *, void *);
>   int foreach_alt_odb(alt_odb_fn, void*);
>   
> -/*
> - * Allocate a "struct alternate_object_database" but do _not_ actually
> - * add it to the list of alternates.
> - */
> -struct object_directory *alloc_alt_odb(const char *dir);
> -
>   /*
>    * Add the directory to the on-disk alternates file; the new entry will also
>    * take effect in the current process.
> @@ -80,17 +75,21 @@ struct multi_pack_index;
>   
>   struct raw_object_store {
>   	/*
> -	 * Path to the repository's object store.
> -	 * Cannot be NULL after initialization.
> +	 * Set of all object directories; the main directory is first (and
> +	 * cannot be NULL after initialization). Subsequent directories are
> +	 * alternates.
>   	 */
> -	char *objectdir;
> +	struct object_directory *odb;
> +	struct object_directory **odb_tail;
> +	int loaded_alternates;
>   
> -	/* Path to extra alternate object database if not NULL */
> +	/*
> +	 * A list of alternate object directories loaded from the environment;
> +	 * this should not generally need to be accessed directly, but will
> +	 * populate the "odb" list when prepare_alt_odb() is run.
> +	 */
>   	char *alternate_db;
>   
> -	struct object_directory *alt_odb_list;
> -	struct object_directory **alt_odb_tail;
> -
>   	/*
>   	 * Objects that should be substituted by other objects
>   	 * (see git-replace(1)).
> diff --git a/object.c b/object.c
> index dd485ac629..79d636091c 100644
> --- a/object.c
> +++ b/object.c
> @@ -482,26 +482,26 @@ struct raw_object_store *raw_object_store_new(void)
>   	return o;
>   }
>   
> -static void free_alt_odb(struct object_directory *odb)
> +static void free_object_directory(struct object_directory *odb)
>   {
> +	free(odb->path);
>   	oid_array_clear(&odb->loose_objects_cache);
>   	free(odb);
>   }
>   
> -static void free_alt_odbs(struct raw_object_store *o)
> +static void free_object_directories(struct raw_object_store *o)
>   {
> -	while (o->alt_odb_list) {
> +	while (o->odb) {
>   		struct object_directory *next;
>   
> -		next = o->alt_odb_list->next;
> -		free_alt_odb(o->alt_odb_list);
> -		o->alt_odb_list = next;
> +		next = o->odb->next;
> +		free_object_directory(o->odb);
> +		o->odb = next;
>   	}
>   }
>   
>   void raw_object_store_clear(struct raw_object_store *o)
>   {
> -	FREE_AND_NULL(o->objectdir);
>   	FREE_AND_NULL(o->alternate_db);
>   
>   	oidmap_free(o->replace_map, 1);
> @@ -511,8 +511,9 @@ void raw_object_store_clear(struct raw_object_store *o)
>   	o->commit_graph = NULL;
>   	o->commit_graph_attempted = 0;
>   
> -	free_alt_odbs(o);
> -	o->alt_odb_tail = NULL;
> +	free_object_directories(o);
> +	o->odb_tail = NULL;
> +	o->loaded_alternates = 0;
>   
>   	INIT_LIST_HEAD(&o->packed_git_mru);
>   	close_all_packs(o);
> diff --git a/packfile.c b/packfile.c
> index d6d511cfd2..1eda33247f 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -970,12 +970,12 @@ static void prepare_packed_git(struct repository *r)
>   
>   	if (r->objects->packed_git_initialized)
>   		return;
> -	prepare_multi_pack_index_one(r, r->objects->objectdir, 1);
> -	prepare_packed_git_one(r, r->objects->objectdir, 1);
> +
>   	prepare_alt_odb(r);
> -	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
> -		prepare_multi_pack_index_one(r, odb->path, 0);
> -		prepare_packed_git_one(r, odb->path, 0);
> +	for (odb = r->objects->odb; odb; odb = odb->next) {
> +		int local = (odb == r->objects->odb);

Here seems to be a place where `odb->is_local` would help.

> +		prepare_multi_pack_index_one(r, odb->path, local);
> +		prepare_packed_git_one(r, odb->path, local);
>   	}
>   	rearrange_packed_git(r);
>   

Thanks,
-Stolee
