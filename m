Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75EE41F576
	for <e@80x24.org>; Thu, 22 Feb 2018 06:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeBVG0m (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 01:26:42 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:43097 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVG0k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 01:26:40 -0500
Received: by mail-io0-f195.google.com with SMTP id l12so4813245ioc.10
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 22:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TuEm9lmXIv+bpXxx3rLOOxi8ya/Xt2LXXhMesxKCPQs=;
        b=QdCd/gQcsTWFY3NhjijPUncYNwsgOB57y68+VZFNnylwGTF67HAU+6Kohvzhhz4OF4
         7D/72OYdvdgkoysCJflaBJrtDAefIfZbpUWDw/NgLEW0NZN8oc8mlnWoP1iMnCCTKwUq
         w1JRzCVvGXVwHidTB3HhIN3UzTmmluTAFU46mE+c7DvnrHUANAqNn5cp8+PfUxqOPnnK
         uItIIUv8Fq7dk+yKl0PNGIsth6plzhDRIYeuhN92llgt3Q3iFoPkuEplXb33IOihVVao
         jndy2woLKaOqN6r9dIL7GmbUAAosJtz4ilz2Q6ZzgGVIjRwHc7JcsKCu7DJN3Gf8ruVk
         kfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TuEm9lmXIv+bpXxx3rLOOxi8ya/Xt2LXXhMesxKCPQs=;
        b=pKX9orfxngwDqFjzBiWlAtArjiMMo74nUny7vtHBEiV3sVkEwn5M0jJHHxAnE3O4Cz
         AAEUI1rCD8N6fMo/qONoJkNYOL8jE1Z6s+sgAdhTMv109t62DFcVJmUCX0t/OUpQlpQZ
         Q2wJmHKmBQhVVAIPrCTK81q8DD7T241qRVf8nebIvJXU5es4hfLAlcmfOnb9mHyiOwT3
         QNkEA7sdfNQh25wqs8u7aahWzRignCIaP/+r4KtYRj2WxyW6o5l6F2sFRLFZ7vFujDpt
         qzLn1wNpq81oFRLi9PIzE2W53i+SJfBusmsPsOHIdsuzITZbMntwVz5b4U6FEqeh4sz7
         2QHA==
X-Gm-Message-State: APf1xPA2oPGsXbNXNkDTgQ5H4aVUDvcKqAelvSasIkzHGny7BKPA4Xen
        O1u60BS+Z1/eklKfGA96F5Q=
X-Google-Smtp-Source: AH8x2247FsWouZEYEQv3iyMwMgZO/GwrHhuNbtc3LJ59Mbm4xxqHd7kEDYMkG7dxzv5LeHMkTs9sng==
X-Received: by 10.107.174.14 with SMTP id x14mr7516745ioe.67.1519280799912;
        Wed, 21 Feb 2018 22:26:39 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j130sm25573286ita.33.2018.02.21.22.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 22:26:39 -0800 (PST)
Date:   Wed, 21 Feb 2018 22:26:35 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH 01/27] repository: introduce raw object store field
Message-ID: <20180222062635.GC133592@aiede.svl.corp.google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-2-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

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
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Heh, I suppose that sign-off makes me not a great candidate for
reviewing this.  It's been long enough since I looked at the patch
that I feel okay trying anyway.

[...]
> --- /dev/null
> +++ b/object-store.h
> @@ -0,0 +1,15 @@
> +#ifndef OBJECT_STORE_H
> +#define OBJECT_STORE_H
> +
> +struct raw_object_store {
> +	/*
> +	 * Path to the repository's object store.
> +	 * Cannot be NULL after initialization.
> +	 */
> +	char *objectdir;
> +};
> +#define RAW_OBJECT_STORE_INIT { NULL }

Who owns and is responsible for freeing objectdir?

> +
> +void raw_object_store_clear(struct raw_object_store *o);

Oh, that answers that.

It could be worth a note in the doc comment anyway, but I don't mind
not having one.

[...]
> +
> +void raw_object_store_clear(struct raw_object_store *o)
> +{
> +	free(o->objectdir);
> +}

Should this use FREE_AND_NULL?

[...]
> --- a/repository.c
> +++ b/repository.c
[...]
> @@ -42,8 +49,8 @@ static void repo_setup_env(struct repository *repo)
>  						    !repo->ignore_env);
>  	free(repo->commondir);
>  	repo->commondir = strbuf_detach(&sb, NULL);
> -	free(repo->objectdir);
> -	repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
> +	free(repo->objects.objectdir);

Should this call raw_object_store_clear instead of calling free
directly?

> +	repo->objects.objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
>  					    "objects", !repo->ignore_env);

Long line.  One way to break it would be

	repo->objects.objectdir =
		git_path_from_env(DB_ENVIRONMENT, repo->commondir,
				  "objects", !repo->ignore_env);

>  	free(repo->graft_file);
>  	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
> @@ -209,12 +216,14 @@ void repo_clear(struct repository *repo)
>  {
>  	FREE_AND_NULL(repo->gitdir);
>  	FREE_AND_NULL(repo->commondir);
> -	FREE_AND_NULL(repo->objectdir);
>  	FREE_AND_NULL(repo->graft_file);
>  	FREE_AND_NULL(repo->index_file);
>  	FREE_AND_NULL(repo->worktree);
>  	FREE_AND_NULL(repo->submodule_prefix);
>  
> +	raw_object_store_clear(&repo->objects);
> +	memset(&repo->objects, 0, sizeof(repo->objects));

If raw_object_store_clear uses FREE_AND_NULL, this memset won't be necessary.

[...]
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
> @@ -21,10 +23,9 @@ struct repository {
>  	char *commondir;
>  
>  	/*
> -	 * Path to the repository's object store.
> -	 * Cannot be NULL after initialization.
> +	 * Holds any information related to the object store.
>  	 */

This comment doesn't make it clear to me what the field represents.
Can it be replaced with some of the description from the commit
message?

> -	char *objectdir;
> +	struct raw_object_store objects;
>  

Thanks,
Jonathan
