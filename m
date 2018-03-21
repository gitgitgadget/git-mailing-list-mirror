Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7FA31F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbeCUWaF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:30:05 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38910 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeCUWaE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:30:04 -0400
Received: by mail-pl0-f67.google.com with SMTP id m22-v6so4039406pls.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x49ztQ4ILP4OVIV5oRihGGhuLja3vr08xrK6WoGDKK0=;
        b=ZEZykMMCF/UjDg5suUpy0KIR0foENgkwR2TelUpRAPZCFZeLtRz0RHkrWT+fdaXkwC
         ppaP+6G5+OYxB9OUGmaDq5Fky4DfT6SLlxRwf3W+02rlipReonTBfhaiKI08kSW8eKUr
         TAaUzD9kYaAKkXGYomdOLQb+fKgfvyLUBotFtyZAETpm/kl7LqkyyUY8rcVoaOQglDnh
         kQ1JSI76VrA+inESb6bZxOKMfg0mVaNjeJparzX1c33Zu9WOymOT2T+c+BuT2LKIwMii
         a4E/dkYW7w2WM4G7jfH+HGdehNti0xfev7Edb2kpzQ6ex/TFvCzGQMMq3f2FaWddjqOX
         mtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x49ztQ4ILP4OVIV5oRihGGhuLja3vr08xrK6WoGDKK0=;
        b=c1Poy/5X6+muGwx9mDN8cbNmz7wAbroqse6PtIiztcsQon9MyyGjDPW0SLiVHu70LJ
         sgVLuTvlGctlS5K81q4O6esrX5kOofLPP2n+1J/ezQZV7wa7pjICeGqdK5OEjVGwq3Er
         UIgEnsxT3XSnW/EEiXLjoiYUeE/okjk8sRMmYlb26fBEo2FqgDJloFLVSvkxJ0VABcfq
         eXUIogwEB1OYw/efWxaiDA5ZcLBcdOrGhGpOwUGDufbEhZG392/zZd/Hwj4Nlrwo/f/A
         9SgFS2QKwcLBMqr9qodsRVa9RfG/WPq4S6u349rh/AquFVpCxkqvT6pN1fgnor3YKwMS
         8GUA==
X-Gm-Message-State: AElRT7GDrMX4Pvti87Mfjk49qjL5PtzyxV14Mm8qccUxoQCAIAMAhekh
        lGSmJxsy7Mk4SWt4RhdsXQDZ1GFqKhg=
X-Google-Smtp-Source: AG47ELswm3k4Y68cCsoS35xELe0oMpxNP7BKAOmy3RRWTY45NwDdQaFpS7HBkwU/fbU/r6UzSB95uQ==
X-Received: by 2002:a17:902:b101:: with SMTP id q1-v6mr22465831plr.287.1521671403637;
        Wed, 21 Mar 2018 15:30:03 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z21sm8153602pge.42.2018.03.21.15.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:30:02 -0700 (PDT)
Date:   Wed, 21 Mar 2018 15:30:01 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 19/44] sha1_file: allow link_alt_odb_entries to handle
 arbitrary repositories
Message-ID: <20180321223001.GL18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-20-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-20-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> Actually this also allows read_info_alternates and link_alt_odb_entry to
> handle arbitrary repositories, but link_alt_odb_entries is the most
> interesting function in this set of functions, hence the commit subject.
> 
> These functions span a strongly connected component in the function
> graph, i.e. the recursive call chain might look like
> 
>   -> link_alt_odb_entries
>     -> link_alt_odb_entry
>       -> read_info_alternates
>         -> link_alt_odb_entries
> 
> That is why we need to convert all these functions at the same time.

This conversion looks good.

> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  object-store.h |  4 ++++
>  sha1_file.c    | 36 ++++++++++++++++--------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/object-store.h b/object-store.h
> index 3d0f8a87cb..20ba136c1f 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -18,6 +18,10 @@ struct alternate_object_database {
>  	char loose_objects_subdir_seen[256];
>  	struct oid_array loose_objects_cache;
>  
> +	/*
> +	 * Path to the alternative object store. If this is a relative path,
> +	 * it is relative to the current working directory.
> +	 */
>  	char path[FLEX_ARRAY];
>  };
>  #define prepare_alt_odb(r) prepare_alt_odb_##r()
> diff --git a/sha1_file.c b/sha1_file.c
> index 027e0f3741..f34eb69e39 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -390,11 +390,10 @@ static int alt_odb_usable(struct raw_object_store *o,
>   * SHA1, an extra slash for the first level indirection, and the
>   * terminating NUL.
>   */
> -#define read_info_alternates(r, rb, d) read_info_alternates_##r(rb, d)
> -static void read_info_alternates_the_repository(const char *relative_base,
> -						int depth);
> -#define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
> -static int link_alt_odb_entry_the_repository(const char *entry,
> +static void read_info_alternates(struct repository *r,
> +				 const char *relative_base,
> +				 int depth);
> +static int link_alt_odb_entry(struct repository *r, const char *entry,
>  	const char *relative_base, int depth, const char *normalized_objdir)
>  {
>  	struct alternate_object_database *ent;
> @@ -420,7 +419,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
>  	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
>  		strbuf_setlen(&pathbuf, pathbuf.len - 1);
>  
> -	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
> +	if (!alt_odb_usable(&r->objects, &pathbuf, normalized_objdir)) {
>  		strbuf_release(&pathbuf);
>  		return -1;
>  	}
> @@ -428,12 +427,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
>  	ent = alloc_alt_odb(pathbuf.buf);
>  
>  	/* add the alternate entry */
> -	*the_repository->objects.alt_odb_tail = ent;
> -	the_repository->objects.alt_odb_tail = &(ent->next);
> +	*r->objects.alt_odb_tail = ent;
> +	r->objects.alt_odb_tail = &(ent->next);
>  	ent->next = NULL;
>  
>  	/* recursively add alternates */
> -	read_info_alternates(the_repository, pathbuf.buf, depth + 1);
> +	read_info_alternates(r, pathbuf.buf, depth + 1);
>  
>  	strbuf_release(&pathbuf);
>  	return 0;
> @@ -468,12 +467,8 @@ static const char *parse_alt_odb_entry(const char *string,
>  	return end;
>  }
>  
> -#define link_alt_odb_entries(r, a, s, rb, d) \
> -	link_alt_odb_entries_##r(a, s, rb, d)
> -static void link_alt_odb_entries_the_repository(const char *alt,
> -						int sep,
> -						const char *relative_base,
> -						int depth)
> +static void link_alt_odb_entries(struct repository *r, const char *alt,
> +				 int sep, const char *relative_base, int depth)
>  {
>  	struct strbuf objdirbuf = STRBUF_INIT;
>  	struct strbuf entry = STRBUF_INIT;
> @@ -487,7 +482,7 @@ static void link_alt_odb_entries_the_repository(const char *alt,
>  		return;
>  	}
>  
> -	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
> +	strbuf_add_absolute_path(&objdirbuf, r->objects.objectdir);
>  	if (strbuf_normalize_path(&objdirbuf) < 0)
>  		die("unable to normalize object directory: %s",
>  		    objdirbuf.buf);
> @@ -496,15 +491,16 @@ static void link_alt_odb_entries_the_repository(const char *alt,
>  		alt = parse_alt_odb_entry(alt, sep, &entry);
>  		if (!entry.len)
>  			continue;
> -		link_alt_odb_entry(the_repository, entry.buf,
> +		link_alt_odb_entry(r, entry.buf,
>  				   relative_base, depth, objdirbuf.buf);
>  	}
>  	strbuf_release(&entry);
>  	strbuf_release(&objdirbuf);
>  }
>  
> -static void read_info_alternates_the_repository(const char *relative_base,
> -						int depth)
> +static void read_info_alternates(struct repository *r,
> +				 const char *relative_base,
> +				 int depth)
>  {
>  	char *path;
>  	struct strbuf buf = STRBUF_INIT;
> @@ -516,7 +512,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
>  		return;
>  	}
>  
> -	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
> +	link_alt_odb_entries(r, buf.buf, '\n', relative_base, depth);
>  	strbuf_release(&buf);
>  	free(path);
>  }
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
