Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0421F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBVAn5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:43:57 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43736 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeBVAn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:43:56 -0500
Received: by mail-pg0-f67.google.com with SMTP id f6so1349854pgs.10
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xJCZxEsLEBSZx8xjJSVpW1GtQhsZtUCP2N+S0+dpcrI=;
        b=rBkrmnt7fsIZs9MRvlcqo+4Bp+nTJvpR6YJxWy6Bc3fdMuV5xilZ10hGEYPTjTg2bR
         4GD9StM7qfPq37ZE/R+KynxUMbb1v0hKBE9Ech2ZeECoYMM2xvCmUYHcllG86EUn1+4w
         q1A/CbkRNuRSf3Jzp6S/mKOxrUWWRQYGPAhzhLqwesf3wNC+Zgyu0pSZIk83btNin3Vr
         qZ5qAE+YS6MB6usvQgZYcBi4HjeQASEDC9mnt/U96FIyZu18qWOCRmx6dzqRsTge/ZXq
         NVDwJSFAcLmpOHMnwyguXm7Y9rGFjyuvKlvT8PDsxDSx7f7fK9Hp57Z+lKahCwquBPrv
         eyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xJCZxEsLEBSZx8xjJSVpW1GtQhsZtUCP2N+S0+dpcrI=;
        b=IMa6Ha+mCDyLEpj59/m5a6LwQA6URwEBGDAPGyoG4CrT6sLb5tUbHYh4ZBO0TMZPpm
         U7F73n0wmvDTjKh43tudODZ9BRwnxpqtmXzvyMb1WCRZPYjAkT9a6slIPGhx3g5N4R8d
         zuqv5AJQOjSQzh/kQwELRUqPUjnT477LUYHFajlQt/HnW6hluX5Gz8BOq8MuNfsTBfqP
         MQOmCidXSUR/F26MC8UBQBLQp3Q3DewIuWWHGxd1h0Y3JIG2GRna5c5mvMyaK8u65AJB
         853TGI4Upjus4wnn2xMcFPgnuLXGYUSFw8GyiVsJIjx9Chxxr9VxjpwpPQ974wfKBE9h
         xhrw==
X-Gm-Message-State: APf1xPDs/fqu0OL+GSk604TaaCvjDoo9OHmxIH+Bcd7U3BSaATVNjzOk
        eCqKBH53kMeelOlpE0TGdyhcj6R/lNk=
X-Google-Smtp-Source: AH8x226dNjFQc9xI2SnWNX5h7OVEWVVtZisnrxyJS8FNtFR93UYxuzo5ofLgHw1FYxROk+0HQtwH0w==
X-Received: by 10.99.120.5 with SMTP id t5mr4112651pgc.156.1519260235244;
        Wed, 21 Feb 2018 16:43:55 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id e22sm32606368pgn.50.2018.02.21.16.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:43:54 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:43:52 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH 06/27] object-store: close all packs upon clearing the
 object store
Message-ID: <20180222004352.GE127348@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-7-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-7-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>

Straight forward change, looks good.

> ---
>  builtin/am.c           | 2 +-
>  builtin/clone.c        | 2 +-
>  builtin/fetch.c        | 2 +-
>  builtin/merge.c        | 2 +-
>  builtin/receive-pack.c | 2 +-
>  object.c               | 6 ++----
>  packfile.c             | 4 ++--
>  packfile.h             | 2 +-
>  8 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index 5bdd2d7578..4762a702e3 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1859,7 +1859,7 @@ static void am_run(struct am_state *state, int resume)
>  	 */
>  	if (!state->rebasing) {
>  		am_destroy(state);
> -		close_all_packs();
> +		close_all_packs(&the_repository->objects);
>  		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>  	}
>  }
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 101c27a593..13cfaa6488 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1217,7 +1217,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	transport_disconnect(transport);
>  
>  	if (option_dissociate) {
> -		close_all_packs();
> +		close_all_packs(&the_repository->objects);
>  		dissociate_from_references();
>  	}
>  
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 8ee998ea2e..4d72efca78 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1478,7 +1478,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	string_list_clear(&list, 0);
>  
> -	close_all_packs();
> +	close_all_packs(&the_repository->objects);
>  
>  	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
>  	if (verbosity < 0)
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 30264cfd7c..907ae44ab5 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -411,7 +411,7 @@ static void finish(struct commit *head_commit,
>  			 * We ignore errors in 'gc --auto', since the
>  			 * user should see them.
>  			 */
> -			close_all_packs();
> +			close_all_packs(&the_repository->objects);
>  			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>  		}
>  	}
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index b2eac79a6e..954fc72c7c 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2027,7 +2027,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  			proc.git_cmd = 1;
>  			proc.argv = argv_gc_auto;
>  
> -			close_all_packs();
> +			close_all_packs(&the_repository->objects);
>  			if (!start_command(&proc)) {
>  				if (use_sideband)
>  					copy_to_sideband(proc.err, -1, NULL);
> diff --git a/object.c b/object.c
> index c76b62572a..34daaf37b3 100644
> --- a/object.c
> +++ b/object.c
> @@ -4,6 +4,7 @@
>  #include "tree.h"
>  #include "commit.h"
>  #include "tag.h"
> +#include "packfile.h"
>  
>  static struct object **obj_hash;
>  static int nr_objs, obj_hash_size;
> @@ -469,8 +470,5 @@ void raw_object_store_clear(struct raw_object_store *o)
>  
>  	while (!list_empty(&o->packed_git_mru))
>  		list_del(&o->packed_git_mru);
> -	/*
> -	 * TODO: call close_all_packs once migrated to
> -	 * take an object store argument
> -	 */
> +	close_all_packs(o);
>  }
> diff --git a/packfile.c b/packfile.c
> index d41e4c83d0..511a2b0cdf 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -311,11 +311,11 @@ static void close_pack(struct packed_git *p)
>  	close_pack_index(p);
>  }
>  
> -void close_all_packs(void)
> +void close_all_packs(struct raw_object_store *o)
>  {
>  	struct packed_git *p;
>  
> -	for (p = the_repository->objects.packed_git; p; p = p->next)
> +	for (p = o->packed_git; p; p = p->next)
>  		if (p->do_not_close)
>  			die("BUG: want to close pack marked 'do-not-close'");
>  		else
> diff --git a/packfile.h b/packfile.h
> index a7fca598d6..6a2c57045c 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -63,7 +63,7 @@ extern void close_pack_index(struct packed_git *);
>  
>  extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
>  extern void close_pack_windows(struct packed_git *);
> -extern void close_all_packs(void);
> +extern void close_all_packs(struct raw_object_store *o);
>  extern void unuse_pack(struct pack_window **);
>  extern void clear_delta_base_cache(void);
>  extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
> -- 
> 2.16.1.291.g4437f3f132-goog
> 

-- 
Brandon Williams
