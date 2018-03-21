Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6EE1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeCUWTa (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:19:30 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39362 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeCUWT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:19:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id a19so2490255pgw.6
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TL7/shMSecxNtL26f7aE5UfBT4jCfBy5IKZUKBdPYw8=;
        b=noymxPYUwZ+LJTOKNwjNxEQKxYnGXBc01WiB25XBEobvuH9Bh/i3RLu58d0MecMZFU
         xW+8+f5s8JPFC3T0EM2WHTNpF9HP7zdcO+CDelPgfToSVn96p3FHeAq0YhTD/LmdBlBY
         UgwRUlCOz5j+Bjgi0n2JvX40uVtiNhhGrBv/6HlBGtK5HzTJ45OXcQ4cp4n8GK7d/Rf8
         x9ai9F/giaQr/nKJRhFJNWvp2lRFeEluuEp5Xnxd10ANAdFXM/dFV5YK9XnDaQz/Mkpb
         skud6aLtgX44CvhcHmM4Q28vcZDPYuZdg/y9Cg4IyJUIt0J6qb5lM41RiEPWn6IUpYS1
         +oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TL7/shMSecxNtL26f7aE5UfBT4jCfBy5IKZUKBdPYw8=;
        b=ftnUwzsNUGKDWdMEORPmPxB489JaTZYJm8SrbOXY+x251kniHfMm88CFqL/K3MqSsE
         gPiGon99yW8TFKiQa4uYRyPU7frLAuZ2mOmSVyrb56JsW9iAOagIWC0GM1amPoYK0uuQ
         WqNlqLlv6nVXRAmkYRVU7bIGs8UB+KeZ//3Or6tuLuAKhRSXkHaGPwXu8lIA3AVbn2IS
         mReLbhftNaBzhPvquHFUHRqPcjQfZD6RR/KYTVPo15J9Pn6J8RsK4SZU6/ZaWr1QRNV8
         ZC4jopDYvc3QPRWHbNcfAdAlcMAeknXmefMIfoziA2z0NCTmc+Nd3DXlDarWLsUr3dJw
         HG+w==
X-Gm-Message-State: AElRT7HpA0Z8+HMQutUs1CzxPeTwBC01nFls7KZXW4W1jb4PUrXGTewk
        wVgj1UeItRA8U/Vujk5ruemK2A==
X-Google-Smtp-Source: AG47ELv0I8Su8Ul+oyjvbQOVHzU7IZNt/AGwxzyGF0GiNvarjoUcF3YYxo+v2DqHnUVu2auemFTALw==
X-Received: by 10.99.147.25 with SMTP id b25mr1845646pge.309.1521670768880;
        Wed, 21 Mar 2018 15:19:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f5sm9231983pgn.56.2018.03.21.15.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:19:28 -0700 (PDT)
Date:   Wed, 21 Mar 2018 15:19:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 11/44] object-store: close all packs upon clearing the
 object store
Message-ID: <20180321221927.GI18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-12-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-12-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Looks good.

> ---
>  builtin/am.c           | 2 +-
>  builtin/clone.c        | 2 +-
>  builtin/fetch.c        | 2 +-
>  builtin/merge.c        | 2 +-
>  builtin/receive-pack.c | 2 +-
>  object.c               | 7 +++----
>  packfile.c             | 4 ++--
>  packfile.h             | 2 +-
>  8 files changed, 11 insertions(+), 12 deletions(-)
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
> index b7ce7c7f52..ac478b7b99 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2026,7 +2026,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  			proc.git_cmd = 1;
>  			proc.argv = argv_gc_auto;
>  
> -			close_all_packs();
> +			close_all_packs(&the_repository->objects);
>  			if (!start_command(&proc)) {
>  				if (use_sideband)
>  					copy_to_sideband(proc.err, -1, NULL);
> diff --git a/object.c b/object.c
> index 83be6b1ecb..60ca76b285 100644
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
> @@ -475,8 +476,6 @@ void raw_object_store_clear(struct raw_object_store *o)
>  	o->alt_odb_tail = NULL;
>  
>  	INIT_LIST_HEAD(&o->packed_git_mru);
> -	/*
> -	 * TODO: call close_all_packs once migrated to
> -	 * take an object store argument
> -	 */
> +	close_all_packs(o);
> +	o->packed_git = NULL;
>  }
> diff --git a/packfile.c b/packfile.c
> index d3c4a12ae0..1e38334ba2 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -310,11 +310,11 @@ static void close_pack(struct packed_git *p)
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
> index 76496226bb..5b1ce00f84 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -66,7 +66,7 @@ extern void close_pack_index(struct packed_git *);
>  
>  extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
>  extern void close_pack_windows(struct packed_git *);
> -extern void close_all_packs(void);
> +extern void close_all_packs(struct raw_object_store *o);
>  extern void unuse_pack(struct pack_window **);
>  extern void clear_delta_base_cache(void);
>  extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
