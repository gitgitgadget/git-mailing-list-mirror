Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0361F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeFNR0T (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:26:19 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43961 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbeFNR0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:26:18 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so3900168plj.10
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T1d1dys2EJl1CD1tdVObWz2lzlW8H8X01rFsHFcfLoo=;
        b=LVymmpjLUiXxeiI3Ps3pAbgEM8rAwfz0vGaCe2ehb0Rpfvhb7jLhUGmIsoi63OFMia
         rkXgjW8T3kMDGULl6iGlSMszR4UShhl6M26p8eKLwxt/80PfuGLGtPOOBQiBtyaJQoSv
         CDSVJWkyzpqYEbFTby3CilznSMqlo3tJryTcZs7JHoM4rdhpl56JtFgPDNNrDJjwc1AY
         zqGuO9dinqO7u4g84rPQq7UxnodXM4zFA4eq1Y6e3D/npIyIwjSi+3kTAO7NOKGNVSmo
         pdH6T69ZlWHZfx0pRQZkjS5ODt8eqBWyd/jG7AeOYlnHzvsFXYBC1HDHEwn8Kf2hUMfX
         DjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T1d1dys2EJl1CD1tdVObWz2lzlW8H8X01rFsHFcfLoo=;
        b=SvDoTM1PsmQlLNUFd61rhePj3EJYMctgMRH6zWUZid8ea99mMdaxUjVQ7lWcbSbtJ1
         Da0kH3RVPdC8aiN5K/F2y5HZF14H0vYgmKsMM4u/0ttcTgvf3h6kQHs8OxB7R9VQVgmn
         24lyKx9jsthZH867LVgKUCddD/XNkE56WpTgpDdlHaZ3nmIf/AOd3ycVXBhVNd4O+9de
         ETMpS6jemJZw+aB+y9Fb7e7PN5DwV9daroUYuX9BeapCtv6fCGTow6/fA+BHtKgXh+/Z
         ONAeBITJAMKKAgGfZKWLuhQ0Q64qI7Y2KP4YvFONRoWLdd6eZfsnMV3OqYhReuRJx7XS
         FCMw==
X-Gm-Message-State: APt69E0jmVXclntfOJDAZo/pRzSUeCcViM8Yl+gxek3aRYuoJVrJAoo7
        JSIHN78UrFwd3XJZvwo7J7TiQzwfiXg=
X-Google-Smtp-Source: ADUXVKKkfJG0TEeyGwe/2a2G38fWjzb1/v0deD/r0TX4gU6X23RwIkXUoD7guGWQ7kobHFlyLfsUsA==
X-Received: by 2002:a17:902:3181:: with SMTP id x1-v6mr1842563plb.198.1528997177410;
        Thu, 14 Jun 2018 10:26:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h78-v6sm12223837pfh.141.2018.06.14.10.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:26:16 -0700 (PDT)
Date:   Thu, 14 Jun 2018 10:26:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/8] fetch-pack: split up everything_local()
Message-ID: <20180614172615.GA220741@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <cover.1528317619.git.jonathantanmy@google.com>
 <5687c0b22bf3b2bdbbe29b09788cc305a89710fc.1528317619.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5687c0b22bf3b2bdbbe29b09788cc305a89710fc.1528317619.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Jonathan Tan wrote:
> The function everything_local(), despite its name, also (1) marks
> commits as COMPLETE and COMMON_REF and (2) invokes filter_refs() as
> important side effects. Extract (1) into its own function
> (mark_complete_and_common_ref()) and remove
> (2).
> 
> The restoring of save_commit_buffer, which was introduced in a1c6d7c1a7
> ("fetch-pack: restore save_commit_buffer after use", 2017-12-08), is a
> concern of the parse_object() call in mark_complete_and_common_ref(), so
> it has been moved from the end of everything_local() to the end of
> mark_complete_and_common_ref().

Thanks, this is much cleaner.

> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index a320ce987..5c87bb8bb 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -734,12 +734,20 @@ static int add_loose_objects_to_set(const struct object_id *oid,
>  	return 0;
>  }
>  
> -static int everything_local(struct fetch_pack_args *args,
> -			    struct ref **refs,
> -			    struct ref **sought, int nr_sought)
> +/*
> + * Mark recent commits available locally and reachable from a local ref as
> + * COMPLETE. If args->no_dependents is false, also mark COMPLETE remote refs as
> + * COMMON_REF (otherwise, we are not planning to participate in negotiation, and
> + * thus do not need COMMON_REF marks).
> + *
> + * The cutoff time for recency is determined by this heuristic: it is the
> + * earliest commit time of the objects in refs that are commits and that we know
> + * the commit time of.
> + */
> +static void mark_complete_and_common_ref(struct fetch_pack_args *args,
> +					 struct ref **refs)
>  {
>  	struct ref *ref;
> -	int retval;
>  	int old_save_commit_buffer = save_commit_buffer;
>  	timestamp_t cutoff = 0;
>  	struct oidset loose_oid_set = OIDSET_INIT;
> @@ -812,7 +820,18 @@ static int everything_local(struct fetch_pack_args *args,
>  		}
>  	}
>  
> -	filter_refs(args, refs, sought, nr_sought);
> +	save_commit_buffer = old_save_commit_buffer;
> +}
> +
> +/*
> + * Returns 1 if every object pointed to by the given remote refs is available
> + * locally and reachable from a local ref, and 0 otherwise.
> + */
> +static int everything_local(struct fetch_pack_args *args,
> +			    struct ref **refs)
> +{
> +	struct ref *ref;
> +	int retval;
>  
>  	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
>  		const struct object_id *remote = &ref->old_oid;
> @@ -829,8 +848,6 @@ static int everything_local(struct fetch_pack_args *args,
>  			      ref->name);
>  	}
>  
> -	save_commit_buffer = old_save_commit_buffer;
> -
>  	return retval;
>  }
>  
> @@ -1053,7 +1070,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  	if (!server_supports("deepen-relative") && args->deepen_relative)
>  		die(_("Server does not support --deepen"));
>  
> -	if (everything_local(args, &ref, sought, nr_sought)) {
> +	mark_complete_and_common_ref(args, &ref);
> +	filter_refs(args, &ref, sought, nr_sought);
> +	if (everything_local(args, &ref)) {
>  		packet_flush(fd[1]);
>  		goto all_done;
>  	}
> @@ -1377,7 +1396,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  			for_each_cached_alternate(insert_one_alternate_object);
>  
>  			/* Filter 'ref' by 'sought' and those that aren't local */
> -			if (everything_local(args, &ref, sought, nr_sought))
> +			mark_complete_and_common_ref(args, &ref);
> +			filter_refs(args, &ref, sought, nr_sought);
> +			if (everything_local(args, &ref))
>  				state = FETCH_DONE;
>  			else
>  				state = FETCH_SEND_REQUEST;
> -- 
> 2.17.0.768.g1526ddbba1.dirty
> 

-- 
Brandon Williams
