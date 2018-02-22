Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B33F91F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeBVAtt (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:49:49 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39800 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBVAts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:49:48 -0500
Received: by mail-pg0-f65.google.com with SMTP id w17so1359599pgv.6
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V+a36Ha1PmCbQiW4jgEe0iIakSh5tZWThu7BJpbgrLU=;
        b=lcZfOl/kBKdVZEMr7XImCofmg8ZykevmYnh2iY4aKAb+/rtbCzWHC88vqPOwR4GROw
         IWmLW67/3FdUB6OGGjnJe1JJjfPSpJRYGLBb0s8kjjfdg2UGe6ll9bh8iuCBBsfnOG2I
         CFDNGafGaDes/pd7q5fcSfdTin8cvpah1HqxvxdT9H9GURyZ2NPq/koXqlyioRdmALPm
         50Kas5PDQjUMht09m9ukKXv8rursSEVBiLgL6aKUvBZifeoMzE/jFRm/AGM0TCuthwhs
         +o2g+Cd3q0K4Vl77ixsCiCx7fiqd62vJj1q/PvMLfeQ/gim6UX52+WtwoJ192Nddpujw
         yH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+a36Ha1PmCbQiW4jgEe0iIakSh5tZWThu7BJpbgrLU=;
        b=F2ibHvCTQIZ2gsVH5RCJ4eIuSC4oX+LFZRSCsTWOfsGjGKmx6jTH8CCdcVakZ5MCve
         RHnMLpwGU9jt2kEiuFutkI6cziu8yw/UydnmyhbgNpHjbNMk3b7yazncqRI0VjgMlWZ1
         YxLcavCJxWP3ii46p5pTEXRX4s2KPhPwhH0PbID9SsbkhKh+mys4b209G3G6qrOaSbsG
         zsxDNZVlJZGVb7JFl6S7jD1CfMvTQwbo/rTMKb9KFX6WkWsjZI5utiAy87b6Uyec+mJz
         ZCb9UKbiWfCnGPw0jo3RXMbomx5A+lyAW7wcizfq/71THkAC55XA3uXkYCR531P24m7e
         B9Iw==
X-Gm-Message-State: APf1xPB/WEKObRKVsfnrMSd4JcJgxJsw9oQaovBA06pbBBXY0waxk3rw
        JZbB66Hu9oBEYSwsnp9FHQxdag==
X-Google-Smtp-Source: AH8x226s0BPhKEFmYU5P3gTdJPnpH4QkgkBcoqHs7GjulqTIGML19poeYwTEFzfQUS0LQWhiMZqnng==
X-Received: by 10.101.89.6 with SMTP id f6mr4202881pgu.22.1519260588133;
        Wed, 21 Feb 2018 16:49:48 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id n67sm5349063pfh.150.2018.02.21.16.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:49:47 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:49:45 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 14/27] sha1_file: allow link_alt_odb_entries to handle
 arbitrary repositories
Message-ID: <20180222004945.GG127348@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-15-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-15-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20, Stefan Beller wrote:
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
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Looks good.

>  object-store.h |  4 ++++
>  sha1_file.c    | 36 ++++++++++++++++--------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/object-store.h b/object-store.h
> index 514ad94287..f283fbdba9 100644
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

Thanks for adding the comment.

>  	char path[FLEX_ARRAY];
>  };
>  #define prepare_alt_odb(r) prepare_alt_odb_##r()
> diff --git a/sha1_file.c b/sha1_file.c
> index c26921df4a..6e5105a252 100644
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
> 2.16.1.291.g4437f3f132-goog
> 

-- 
Brandon Williams
