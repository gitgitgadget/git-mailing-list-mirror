Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9201F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeHNWIY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:08:24 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45507 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHNWIY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:08:24 -0400
Received: by mail-qt0-f196.google.com with SMTP id y5-v6so22310824qti.12
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 12:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AVAMfBYJCINFqB7EkNtoaVZWLf0c1pJrgdUZZPBw5BU=;
        b=TNlhz1SEccch33Oj/aLPV84fp0GNRE6k/3lH+NWmXrAMWbzzBPzjjpqDq46VRuDu5q
         R7ON21c7IwN1AeISpAKTCax2qic8euV87kV3pe1r5m8sXs0vl0VOVSDDflwl5xLIp1xO
         QIOPTcA87SrRjVPzecCXJSjO9Yp+J8ddzTqCf9Vfk49FlHn5nWdgxzmUKg6z4Gd+BleW
         QgrqxvozYKqQtk0RFG90l66NG9HeBa9GDCmrTS7GkDs8VEhRo8MBqQfu1EgUIHhpPNuB
         H1j00B8xvd8M4O75J4scuN7T4cLZLbkA1cTJpd/f+ZCdlcXPUlgct0+MqmahDHdYcWYa
         qVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVAMfBYJCINFqB7EkNtoaVZWLf0c1pJrgdUZZPBw5BU=;
        b=YVnEwb/xLbHvOwemOcexKkZTnaPsdYkm62LFWwjChe1GKCoJBLg3BPA5YZEYmDVna/
         vdsu2x9nmETzSUGSqZKKHNYxzn3mU9oY+6pLvkrfoTo9D9phz6I6nWk3cDRS8jDO6VcN
         zqQa/MuNolJsnJkDICa30HkVJsX3cF4EBkwAtVYak/ZSaYlq2KWz2B5tQzoepuQevZR6
         QNYES7Zij0L1qNkuVkU+nMOPSWr1JU/S5u1QK+ozMy0alNaWUkiM4Dr2uZWedLL376OZ
         BToHWzbhZ3IkMbthn+osoaT2U9zY96D34ImXwj/iXFSKf5rH9FJnb8OuF7J6WTe85OXs
         /JQw==
X-Gm-Message-State: AOUpUlH6eYcDJmjzDQ1LFaXOTM5EyO4pBv/Rfc1NEgWl3mDVEWdxYQJo
        yVbf3FFzkkJ4Uy9f2mHd1bk=
X-Google-Smtp-Source: AA+uWPwBYi2atbIS3DAys1Bj2kCDcfDu+FDeU/XIR7UZWn9jI1nqRyDLb0MskMj9/6qD8AlbfQjv1Q==
X-Received: by 2002:a0c:9493:: with SMTP id j19-v6mr20450193qvj.79.1534274384408;
        Tue, 14 Aug 2018 12:19:44 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id k5-v6sm10184593qkf.53.2018.08.14.12.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 12:19:43 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] Speed up unpack_trees()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, Elijah Newren <newren@gmail.com>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a0d4142a-795d-ddd3-0c9b-b54131591b7c@gmail.com>
Date:   Tue, 14 Aug 2018 15:19:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180812081551.27927-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/12/2018 4:15 AM, Nguyễn Thái Ngọc Duy wrote:
> v4 has a bunch of changes
> 
> - 1/5 is a new one to show indented tracing. This way it's less
>    misleading to read nested time measurements
> - 3/5 now has the switch/restore cache_bottom logic. Junio suggested a
>    check instead in his final note, but I think this is safer (yeah I'm
>    scared too)
> - the old 4/4 is dropped because
>    - it assumes n-way logic
>    - the visible time saving is not worth the tradeoff
>    - Elijah gave me an idea to avoid add_index_entry() that I think
>      does not have n-way logic assumptions and gives better saving.
>      But it requires some more changes so I'm going to do it later
> - 5/5 is also new and should help reduce cache_tree_update() cost.
>    I wrote somewhere I was not going to work on this part, but it turns
>    out just a couple lines, might as well do it now.
> 
> Interdiff
> 

I've now had a chance to run the git tests, as well as our own unit and 
functional tests with this patch series and all passed.

I reviewed the tests in t0090-cache-tree.h and verified that there are 
tests that validate the cache tree is correct after doing a checkout and 
merge (both of which exercise the new cache tree optimization in patch 5).

I've also run our perf test suite and the results are outstanding:

Checkout saves 51% on average
Merge saves 44%
Pull saves 30%
Rebase saves 26%

For perspective, that means these commands are going from ~20 seconds to 
~10 seconds.

I don't feel that any of my comments to the individual patches deserve a 
re-roll.  Given the ongoing discussion about the additional tracing - 
I'm happy to leave out the first 2 patches so that the rest can go in 
sooner rather than later.

Looks good!

> diff --git a/cache-tree.c b/cache-tree.c
> index 0dbe10fc85..105f13806f 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -426,7 +426,6 @@ static int update_one(struct cache_tree *it,
>   
>   int cache_tree_update(struct index_state *istate, int flags)
>   {
> -	uint64_t start = getnanotime();
>   	struct cache_tree *it = istate->cache_tree;
>   	struct cache_entry **cache = istate->cache;
>   	int entries = istate->cache_nr;
> @@ -434,11 +433,12 @@ int cache_tree_update(struct index_state *istate, int flags)
>   
>   	if (i)
>   		return i;
> +	trace_performance_enter();
>   	i = update_one(it, cache, entries, "", 0, &skip, flags);
> +	trace_performance_leave("cache_tree_update");
>   	if (i < 0)
>   		return i;
>   	istate->cache_changed |= CACHE_TREE_CHANGED;
> -	trace_performance_since(start, "repair cache-tree");
>   	return 0;
>   }
>   
> diff --git a/cache.h b/cache.h
> index e6f7ee4b64..8b447652a7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -673,7 +673,6 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
>   #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
>   #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
>   #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
> -#define ADD_CACHE_SKIP_VERIFY_PATH 64	/* Do not verify path */
>   extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
>   extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
>   
> diff --git a/diff-lib.c b/diff-lib.c
> index a9f38eb5a3..1ffa22c882 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -518,8 +518,8 @@ static int diff_cache(struct rev_info *revs,
>   int run_diff_index(struct rev_info *revs, int cached)
>   {
>   	struct object_array_entry *ent;
> -	uint64_t start = getnanotime();
>   
> +	trace_performance_enter();
>   	ent = revs->pending.objects;
>   	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
>   		exit(128);
> @@ -528,7 +528,7 @@ int run_diff_index(struct rev_info *revs, int cached)
>   	diffcore_fix_diff_index(&revs->diffopt);
>   	diffcore_std(&revs->diffopt);
>   	diff_flush(&revs->diffopt);
> -	trace_performance_since(start, "diff-index");
> +	trace_performance_leave("diff-index");
>   	return 0;
>   }
>   
> diff --git a/dir.c b/dir.c
> index 21e6f2520a..c5e9fc8cea 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2263,11 +2263,11 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>   		   const char *path, int len, const struct pathspec *pathspec)
>   {
>   	struct untracked_cache_dir *untracked;
> -	uint64_t start = getnanotime();
>   
>   	if (has_symlink_leading_path(path, len))
>   		return dir->nr;
>   
> +	trace_performance_enter();
>   	untracked = validate_untracked_cache(dir, len, pathspec);
>   	if (!untracked)
>   		/*
> @@ -2302,7 +2302,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>   		dir->nr = i;
>   	}
>   
> -	trace_performance_since(start, "read directory %.*s", len, path);
> +	trace_performance_leave("read directory %.*s", len, path);
>   	if (dir->untracked) {
>   		static int force_untracked_cache = -1;
>   		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
> diff --git a/name-hash.c b/name-hash.c
> index 163849831c..1fcda73cb3 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -578,10 +578,10 @@ static void threaded_lazy_init_name_hash(
>   
>   static void lazy_init_name_hash(struct index_state *istate)
>   {
> -	uint64_t start = getnanotime();
>   
>   	if (istate->name_hash_initialized)
>   		return;
> +	trace_performance_enter();
>   	hashmap_init(&istate->name_hash, cache_entry_cmp, NULL, istate->cache_nr);
>   	hashmap_init(&istate->dir_hash, dir_entry_cmp, NULL, istate->cache_nr);
>   
> @@ -602,7 +602,7 @@ static void lazy_init_name_hash(struct index_state *istate)
>   	}
>   
>   	istate->name_hash_initialized = 1;
> -	trace_performance_since(start, "initialize name hash");
> +	trace_performance_leave("initialize name hash");
>   }
>   
>   /*
> diff --git a/preload-index.c b/preload-index.c
> index 4d08d44874..d7f7919ba2 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -78,7 +78,6 @@ static void preload_index(struct index_state *index,
>   {
>   	int threads, i, work, offset;
>   	struct thread_data data[MAX_PARALLEL];
> -	uint64_t start = getnanotime();
>   
>   	if (!core_preload_index)
>   		return;
> @@ -88,6 +87,7 @@ static void preload_index(struct index_state *index,
>   		threads = 2;
>   	if (threads < 2)
>   		return;
> +	trace_performance_enter();
>   	if (threads > MAX_PARALLEL)
>   		threads = MAX_PARALLEL;
>   	offset = 0;
> @@ -109,7 +109,7 @@ static void preload_index(struct index_state *index,
>   		if (pthread_join(p->pthread, NULL))
>   			die("unable to join threaded lstat");
>   	}
> -	trace_performance_since(start, "preload index");
> +	trace_performance_leave("preload index");
>   }
>   #endif
>   
> diff --git a/read-cache.c b/read-cache.c
> index b0b5df5de7..2b5646ef26 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1170,7 +1170,6 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>   	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
>   	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
>   	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
> -	int skip_verify_path = option & ADD_CACHE_SKIP_VERIFY_PATH;
>   	int new_only = option & ADD_CACHE_NEW_ONLY;
>   
>   	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
> @@ -1211,7 +1210,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>   
>   	if (!ok_to_add)
>   		return -1;
> -	if (!skip_verify_path && !verify_path(ce->name, ce->ce_mode))
> +	if (!verify_path(ce->name, ce->ce_mode))
>   		return error("Invalid path '%s'", ce->name);
>   
>   	if (!skip_df_check &&
> @@ -1400,8 +1399,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>   	const char *typechange_fmt;
>   	const char *added_fmt;
>   	const char *unmerged_fmt;
> -	uint64_t start = getnanotime();
>   
> +	trace_performance_enter();
>   	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
>   	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
>   	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
> @@ -1471,7 +1470,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>   
>   		replace_index_entry(istate, i, new_entry);
>   	}
> -	trace_performance_since(start, "refresh index");
> +	trace_performance_leave("refresh index");
>   	return has_errors;
>   }
>   
> @@ -1902,7 +1901,6 @@ static void freshen_shared_index(const char *shared_index, int warn)
>   int read_index_from(struct index_state *istate, const char *path,
>   		    const char *gitdir)
>   {
> -	uint64_t start = getnanotime();
>   	struct split_index *split_index;
>   	int ret;
>   	char *base_oid_hex;
> @@ -1912,8 +1910,9 @@ int read_index_from(struct index_state *istate, const char *path,
>   	if (istate->initialized)
>   		return istate->cache_nr;
>   
> +	trace_performance_enter();
>   	ret = do_read_index(istate, path, 0);
> -	trace_performance_since(start, "read cache %s", path);
> +	trace_performance_leave("read cache %s", path);
>   
>   	split_index = istate->split_index;
>   	if (!split_index || is_null_oid(&split_index->base_oid)) {
> @@ -1921,6 +1920,7 @@ int read_index_from(struct index_state *istate, const char *path,
>   		return ret;
>   	}
>   
> +	trace_performance_enter();
>   	if (split_index->base)
>   		discard_index(split_index->base);
>   	else
> @@ -1937,8 +1937,8 @@ int read_index_from(struct index_state *istate, const char *path,
>   	freshen_shared_index(base_path, 0);
>   	merge_base_index(istate);
>   	post_read_index_from(istate);
> -	trace_performance_since(start, "read cache %s", base_path);
>   	free(base_path);
> +	trace_performance_leave("read cache %s", base_path);
>   	return ret;
>   }
>   
> @@ -2763,4 +2763,6 @@ void move_index_extensions(struct index_state *dst, struct index_state *src)
>   {
>   	dst->untracked = src->untracked;
>   	src->untracked = NULL;
> +	dst->cache_tree = src->cache_tree;
> +	src->cache_tree = NULL;
>   }
> diff --git a/trace.c b/trace.c
> index fc623e91fd..fa4a2e7120 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -176,10 +176,30 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
>   	strbuf_release(&buf);
>   }
>   
> +static uint64_t perf_start_times[10];
> +static int perf_indent;
> +
> +uint64_t trace_performance_enter(void)
> +{
> +	uint64_t now;
> +
> +	if (!trace_want(&trace_perf_key))
> +		return 0;
> +
> +	now = getnanotime();
> +	perf_start_times[perf_indent] = now;
> +	if (perf_indent + 1 < ARRAY_SIZE(perf_start_times))
> +		perf_indent++;
> +	else
> +		BUG("Too deep indentation");
> +	return now;
> +}
> +
>   static void trace_performance_vprintf_fl(const char *file, int line,
>   					 uint64_t nanos, const char *format,
>   					 va_list ap)
>   {
> +	static const char space[] = "          ";
>   	struct strbuf buf = STRBUF_INIT;
>   
>   	if (!prepare_trace_line(file, line, &trace_perf_key, &buf))
> @@ -188,7 +208,10 @@ static void trace_performance_vprintf_fl(const char *file, int line,
>   	strbuf_addf(&buf, "performance: %.9f s", (double) nanos / 1000000000);
>   
>   	if (format && *format) {
> -		strbuf_addstr(&buf, ": ");
> +		if (perf_indent >= strlen(space))
> +			BUG("Too deep indentation");
> +
> +		strbuf_addf(&buf, ":%.*s ", perf_indent, space);
>   		strbuf_vaddf(&buf, format, ap);
>   	}
>   
> @@ -244,6 +267,24 @@ void trace_performance_since(uint64_t start, const char *format, ...)
>   	va_end(ap);
>   }
>   
> +void trace_performance_leave(const char *format, ...)
> +{
> +	va_list ap;
> +	uint64_t since;
> +
> +	if (perf_indent)
> +		perf_indent--;
> +
> +	if (!format) /* Allow callers to leave without tracing anything */
> +		return;
> +
> +	since = perf_start_times[perf_indent];
> +	va_start(ap, format);
> +	trace_performance_vprintf_fl(NULL, 0, getnanotime() - since,
> +				     format, ap);
> +	va_end(ap);
> +}
> +
>   #else
>   
>   void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
> @@ -273,6 +314,24 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
>   	va_end(ap);
>   }
>   
> +void trace_performance_leave_fl(const char *file, int line,
> +				uint64_t nanos, const char *format, ...)
> +{
> +	va_list ap;
> +	uint64_t since;
> +
> +	if (perf_indent)
> +		perf_indent--;
> +
> +	if (!format) /* Allow callers to leave without tracing anything */
> +		return;
> +
> +	since = perf_start_times[perf_indent];
> +	va_start(ap, format);
> +	trace_performance_vprintf_fl(file, line, nanos - since, format, ap);
> +	va_end(ap);
> +}
> +
>   #endif /* HAVE_VARIADIC_MACROS */
>   
>   
> @@ -411,13 +470,11 @@ uint64_t getnanotime(void)
>   	}
>   }
>   
> -static uint64_t command_start_time;
>   static struct strbuf command_line = STRBUF_INIT;
>   
>   static void print_command_performance_atexit(void)
>   {
> -	trace_performance_since(command_start_time, "git command:%s",
> -				command_line.buf);
> +	trace_performance_leave("git command:%s", command_line.buf);
>   }
>   
>   void trace_command_performance(const char **argv)
> @@ -425,10 +482,10 @@ void trace_command_performance(const char **argv)
>   	if (!trace_want(&trace_perf_key))
>   		return;
>   
> -	if (!command_start_time)
> +	if (!command_line.len)
>   		atexit(print_command_performance_atexit);
>   
>   	strbuf_reset(&command_line);
>   	sq_quote_argv_pretty(&command_line, argv);
> -	command_start_time = getnanotime();
> +	trace_performance_enter();
>   }
> diff --git a/trace.h b/trace.h
> index 2b6a1bc17c..171b256d26 100644
> --- a/trace.h
> +++ b/trace.h
> @@ -23,6 +23,7 @@ extern void trace_disable(struct trace_key *key);
>   extern uint64_t getnanotime(void);
>   extern void trace_command_performance(const char **argv);
>   extern void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
> +uint64_t trace_performance_enter(void);
>   
>   #ifndef HAVE_VARIADIC_MACROS
>   
> @@ -45,6 +46,9 @@ extern void trace_performance(uint64_t nanos, const char *format, ...);
>   __attribute__((format (printf, 2, 3)))
>   extern void trace_performance_since(uint64_t start, const char *format, ...);
>   
> +__attribute__((format (printf, 1, 2)))
> +void trace_performance_leave(const char *format, ...);
> +
>   #else
>   
>   /*
> @@ -118,6 +122,14 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
>   					     __VA_ARGS__);		    \
>   	} while (0)
>   
> +#define trace_performance_leave(...)					    \
> +	do {								    \
> +		if (trace_pass_fl(&trace_perf_key))			    \
> +			trace_performance_leave_fl(TRACE_CONTEXT, __LINE__, \
> +						   getnanotime(),	    \
> +						   __VA_ARGS__);	    \
> +	} while (0)
> +
>   /* backend functions, use non-*fl macros instead */
>   __attribute__((format (printf, 4, 5)))
>   extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
> @@ -130,6 +142,9 @@ extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
>   __attribute__((format (printf, 4, 5)))
>   extern void trace_performance_fl(const char *file, int line,
>   				 uint64_t nanos, const char *fmt, ...);
> +__attribute__((format (printf, 4, 5)))
> +extern void trace_performance_leave_fl(const char *file, int line,
> +				       uint64_t nanos, const char *fmt, ...);
>   static inline int trace_pass_fl(struct trace_key *key)
>   {
>   	return key->fd || !key->initialized;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 1438ee1555..d822662c75 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -201,7 +201,6 @@ static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
>   
>   	ce->ce_flags = (ce->ce_flags & ~clear) | set;
>   	return add_index_entry(&o->result, ce,
> -			       o->extra_add_index_flags |
>   			       ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
>   }
>   
> @@ -353,9 +352,9 @@ static int check_updates(struct unpack_trees_options *o)
>   	struct progress *progress = NULL;
>   	struct index_state *index = &o->result;
>   	struct checkout state = CHECKOUT_INIT;
> -	uint64_t start = getnanotime();
>   	int i;
>   
> +	trace_performance_enter();
>   	state.force = 1;
>   	state.quiet = 1;
>   	state.refresh_cache = 1;
> @@ -425,7 +424,7 @@ static int check_updates(struct unpack_trees_options *o)
>   	errs |= finish_delayed_checkout(&state);
>   	if (o->update)
>   		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
> -	trace_performance_since(start, "update worktree after a merge");
> +	trace_performance_leave("check_updates");
>   	return errs != 0;
>   }
>   
> @@ -702,31 +701,13 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
>   	if (!o->merge)
>   		BUG("We need cache-tree to do this optimization");
>   
> -	/*
> -	 * Try to keep add_index_entry() as fast as possible since
> -	 * we're going to do a lot of them.
> -	 *
> -	 * Skipping verify_path() should totally be safe because these
> -	 * paths are from the source index, which must have been
> -	 * verified.
> -	 *
> -	 * Skipping D/F and cache-tree validation checks is trickier
> -	 * because it assumes what n-merge code would do when all
> -	 * trees and the index are the same. We probably could just
> -	 * optimize those code instead (e.g. we don't invalidate that
> -	 * many cache-tree, but the searching for them is very
> -	 * expensive).
> -	 */
> -	o->extra_add_index_flags = ADD_CACHE_SKIP_DFCHECK;
> -	o->extra_add_index_flags |= ADD_CACHE_SKIP_VERIFY_PATH;
> -
>   	/*
>   	 * Do what unpack_callback() and unpack_nondirectories() normally
>   	 * do. But we walk all paths recursively in just one loop instead.
>   	 *
> -	 * D/F conflicts and staged entries are not a concern because
> -	 * cache-tree would be invalidated and we would never get here
> -	 * in the first place.
> +	 * D/F conflicts and higher stage entries are not a concern
> +	 * because cache-tree would be invalidated and we would never
> +	 * get here in the first place.
>   	 */
>   	for (i = 0; i < nr_entries; i++) {
>   		int new_ce_len, len, rc;
> @@ -761,7 +742,6 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
>   
>   		mark_ce_used(src[0], o);
>   	}
> -	o->extra_add_index_flags = 0;
>   	free(tree_ce);
>   	if (o->debug_unpack)
>   		printf("Unpacked %d entries from %s to %s using cache-tree\n",
> @@ -791,7 +771,17 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
>   
>   		if (!o->merge || df_conflicts)
>   			BUG("Wrong condition to get here buddy");
> -		return traverse_by_cache_tree(pos, nr_entries, n, names, info);
> +
> +		/*
> +		 * All entries up to 'pos' must have been processed
> +		 * (i.e. marked CE_UNPACKED) at this point. But to be safe,
> +		 * save and restore cache_bottom anyway to not miss
> +		 * unprocessed entries before 'pos'.
> +		 */
> +		bottom = o->cache_bottom;
> +		ret = traverse_by_cache_tree(pos, nr_entries, n, names, info);
> +		o->cache_bottom = bottom;
> +		return ret;
>   	}
>   
>   	p = names;
> @@ -1142,7 +1132,7 @@ static void debug_unpack_callback(int n,
>   }
>   
>   /*
> - * Note that traverse_by_cache_tree() duplicates some logic in this funciton
> + * Note that traverse_by_cache_tree() duplicates some logic in this function
>    * without actually calling it. If you change the logic here you may need to
>    * check and change there as well.
>    */
> @@ -1425,11 +1415,11 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   	int i, ret;
>   	static struct cache_entry *dfc;
>   	struct exclude_list el;
> -	uint64_t start = getnanotime();
>   
>   	if (len > MAX_UNPACK_TREES)
>   		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
>   
> +	trace_performance_enter();
>   	memset(&el, 0, sizeof(el));
>   	if (!core_apply_sparse_checkout || !o->update)
>   		o->skip_sparse_checkout = 1;
> @@ -1502,7 +1492,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   			}
>   		}
>   
> -		if (traverse_trees(len, t, &info) < 0)
> +		trace_performance_enter();
> +		ret = traverse_trees(len, t, &info);
> +		trace_performance_leave("traverse_trees");
> +		if (ret < 0)
>   			goto return_failed;
>   	}
>   
> @@ -1574,10 +1567,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   			goto done;
>   		}
>   	}
> -	trace_performance_since(start, "unpack trees");
>   
>   	ret = check_updates(o) ? (-2) : 0;
>   	if (o->dst_index) {
> +		move_index_extensions(&o->result, o->src_index);
>   		if (!ret) {
>   			if (!o->result.cache_tree)
>   				o->result.cache_tree = cache_tree();
> @@ -1586,7 +1579,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   						  WRITE_TREE_SILENT |
>   						  WRITE_TREE_REPAIR);
>   		}
> -		move_index_extensions(&o->result, o->src_index);
>   		discard_index(o->dst_index);
>   		*o->dst_index = o->result;
>   	} else {
> @@ -1595,6 +1587,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   	o->src_index = NULL;
>   
>   done:
> +	trace_performance_leave("unpack_trees");
>   	clear_exclude_list(&el);
>   	return ret;
>   
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 94e1b14078..c2b434c606 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -80,7 +80,6 @@ struct unpack_trees_options {
>   	struct index_state result;
>   
>   	struct exclude_list *el; /* for internal use */
> -	unsigned int extra_add_index_flags;
>   };
>   
>   extern int unpack_trees(unsigned n, struct tree_desc *t,
> 
> Nguyễn Thái Ngọc Duy (5):
>    trace.h: support nested performance tracing
>    unpack-trees: add performance tracing
>    unpack-trees: optimize walking same trees with cache-tree
>    unpack-trees: reduce malloc in cache-tree walk
>    unpack-trees: reuse (still valid) cache-tree from src_index
> 
>   cache-tree.c    |   2 +
>   diff-lib.c      |   4 +-
>   dir.c           |   4 +-
>   name-hash.c     |   4 +-
>   preload-index.c |   4 +-
>   read-cache.c    |  13 +++--
>   trace.c         |  69 ++++++++++++++++++++--
>   trace.h         |  15 +++++
>   unpack-trees.c  | 149 +++++++++++++++++++++++++++++++++++++++++++++++-
>   9 files changed, 243 insertions(+), 21 deletions(-)
> 
