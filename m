Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4487FC433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 12:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1105722CA1
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 12:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbhAXMTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 07:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbhAXMTf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 07:19:35 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE8C061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 04:18:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id dj23so11856613edb.13
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 04:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=r1+5RIH0tlRLJBf1vsQfhsEvcvhLU9Mop43dTpb62Io=;
        b=SCTFaJ003fm37LqjXoImuNUNhMkMlOkh8cHqKZc+g+AAnxhth745EEfVqETugkvbgp
         sLlECjMpBrd5fjtCQnrmxyYUQwQkR1fbfjDF4diY23qZMj4lscpaAA3QfvIWnigOCyGh
         9bhup4sYtj58LvFwxkanqkZEFIhuFyL1g8QUnXFHuCs5fKFS1l45jP8+1+ybZE53TEWt
         dyH8o+ebyzF7jWpkMs0jtOIP5cTMpLyp5k48v3jY9FmMM32IvMcxH+20KqbqWftmo6kM
         AH2k4+OuHWf6BV2OoeL3/k9iNdtlD/pOnVEvQEbB4islb81Vv6qU2b2tZD2deM90RxVH
         ldbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=r1+5RIH0tlRLJBf1vsQfhsEvcvhLU9Mop43dTpb62Io=;
        b=dzt3cnJyNXwHAPHrsfUd+M6ZJKCo1XuVjpzTnxRmGc5+CoZLUz42AP2PLw7J66Y7Ty
         j6vokqoxIrfJyEBRF8dpwVg71ewTSLmkOkuJ2q0k0niyDp2T3TCbcYuHq50stnpzEzse
         E0MKxDKmCjQsXynRBhluJKquAM2AGsdoTWTbVM95PMl0+DIZLF/JM8aaTVnd4ixBUf1+
         zeGLJ0DF/fEQnsvnDu7eJtdl2ktFVOdP4MbO6jEhYIZgKDaIa4kpCjmVoPKyl1e86CMr
         kMBLKZ2QVoKRTJ0VSv7VQgQw4IhlGR1eFB9Q/wiz01j5pIrnYmJG/CzBY5gS3+ZkTQ3l
         MfDA==
X-Gm-Message-State: AOAM532Gf4UbF43VezhBu4TfET12rgF+lCAuc596m70D/wCHNq2KRJKV
        mdm8YvpITVZa2LU0XHpDZsKtriClqRKLAQ==
X-Google-Smtp-Source: ABdhPJwb29aFWKE8Xi3cwAwKrW1pV0Axag3vCxC85zTG39ealmz9FKlZ/y+jYXQmW1bVnVqVcQr7yA==
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr509466edx.218.1611490732807;
        Sun, 24 Jan 2021 04:18:52 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id g14sm6934367ejr.105.2021.01.24.04.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 04:18:52 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <cover.1611455251.git.jonathantanmy@google.com>
 <2d6d8c2671fe424c752994dcb5277d4d923e17a0.1611455251.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <2d6d8c2671fe424c752994dcb5277d4d923e17a0.1611455251.git.jonathantanmy@google.com>
Date:   Sun, 24 Jan 2021 13:18:51 +0100
Message-ID: <87ft2q7ck4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 24 2021, Jonathan Tan wrote:

> +void register_found_gitmodules(const struct object_id *oid)
> +{
> +	oidset_insert(&gitmodules_found, oid);
> +}
> +

In fsck.c we only use this variable to insert into it, or in fsck_blob()
to do the actual check, but then we either abort early if we've found
it, or right after that:

        if (object_on_skiplist(options, oid))
                return 0;

So (along with comments I have below...) you could just use the existing
"skiplist" option instead, no?

>  int fsck_finish(struct fsck_options *options)
>  {
>  	int ret = 0;
> @@ -1262,10 +1267,13 @@ int fsck_finish(struct fsck_options *options)
>  		if (!buf) {
>  			if (is_promisor_object(oid))
>  				continue;
> -			ret |= report(options,
> -				      oid, OBJ_BLOB,
> -				      FSCK_MSG_GITMODULES_MISSING,
> -				      "unable to read .gitmodules blob");
> +			if (options->print_dangling_gitmodules)
> +				printf("%s\n", oid_to_hex(oid));
> +			else
> +				ret |= report(options,
> +					      oid, OBJ_BLOB,
> +					      FSCK_MSG_GITMODULES_MISSING,
> +					      "unable to read .gitmodules blob");
>  			continue;
>  		}
>  
> diff --git a/fsck.h b/fsck.h
> index 69cf715e79..4b8cf03445 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -41,6 +41,12 @@ struct fsck_options {
>  	int *msg_type;
>  	struct oidset skiplist;
>  	kh_oid_map_t *object_names;
> +
> +	/*
> +	 * If 1, print the hashes of missing .gitmodules blobs instead of
> +	 * considering them to be errors.
> +	 */
> +	unsigned print_dangling_gitmodules:1;
>  };
>  
>  #define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
> @@ -62,6 +68,8 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
>  int fsck_object(struct object *obj, void *data, unsigned long size,
>  	struct fsck_options *options);
>  
> +void register_found_gitmodules(const struct object_id *oid);
> +
>  /*
>   * Some fsck checks are context-dependent, and may end up queued; run this
>   * after completing all fsck_object() calls in order to resolve any remaining


This whole thing seems just like the bad path I took in earlier rounds
of my in-flight mktag series. You don't need this new custom API. You
just setup an error handler for your fsck which ignores / prints / logs
/ whatever the OIDs you want if you get a FSCK_MSG_GITMODULES_MISSING
error, which you then "return 0" on.

If you don't have FSCK_MSG_GITMODULES_MISSING punt and call
fsck_error_function().
