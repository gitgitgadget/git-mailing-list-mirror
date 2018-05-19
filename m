Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA211F42D
	for <e@80x24.org>; Sat, 19 May 2018 06:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750780AbeESGyR (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 02:54:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38991 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESGyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 02:54:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id j193-v6so17035125lfg.6
        for <git@vger.kernel.org>; Fri, 18 May 2018 23:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WSWT3Kjczaaq5uzvcg4KXtcjE8B3Gmkpg7lxEZw4vG4=;
        b=KbcflUggkAccuZiEQ6CRPG+LXOFe3LA5cZqzRhokMvHlipq3/UUVUTIcvRfXnzGuOH
         ZUHyeYXozcAbvWDJ6ObmryAueLmHNY/n0+Hcuph3+eRsoU+lKRraduhbyBAjAlSTIwQ4
         4nOj20VUlWtZSHaRVjb+A1xefVQ0rrk5rFjFaKgBudxCms/YbbUQ6qsVT+xKwMCa8frV
         xb4QVtf+w7lrS1zrNkn1e5oq6p8c0Ht7OCuVMip9iu0vMYA2lpNqS84npnaPdYgm7anr
         JpKlrLgGVb0QldADXBOOhLMSmj7NhVY2YE/QcLM+5Y6seOCh9WaL/HR7VEODan7YAN2a
         vlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WSWT3Kjczaaq5uzvcg4KXtcjE8B3Gmkpg7lxEZw4vG4=;
        b=fUyaMJ4rwY58GyrHq9ngoy+BvsD33R/WymfHTNUopwoTeDEJIQ9A2bbMRzwRZYZNXq
         MqKP4zk2DSh3n1WIXXxD2HbMyBr1UTXvRebJqcE3O3Gf7Pc8SkNsU/5bJy0kDXA276QP
         1TIjBwsRdPGRVgBlTZPrZWgYZ3VpCcsRQll9Jg0YRSCrSYT/RVoZWe7CgTUmQXOQF5XM
         dM/FEYXSsVIs+sV0P/4sdVKXz6m9hGgcZPi9PQk5uuGzkvtAdQnUjBS9X2Rd+BpDQw7q
         KnczUOtNmEt0HvKQk7lXKzE3RKbZbxoBpSG3M4srWRqSolxwgQCpGZOWzoUtdIKzUT2x
         VN3w==
X-Gm-Message-State: ALKqPwe4FEiN2Ng80hXEvPAKqA/HeLr+zcIHjWg656n3wjFlQh70kVWa
        zbP0xQIFWxxI4CLTeLmC26k=
X-Google-Smtp-Source: AB8JxZrzjlaY1HRb+3f8p2S4w2fUtenT3K0f2yY+YaYLdOsKG9KIq68CRurmOqiy2pO9TEuIpjG1UQ==
X-Received: by 2002:a2e:3613:: with SMTP id d19-v6mr7250847lja.100.1526712854957;
        Fri, 18 May 2018 23:54:14 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b202-v6sm2236165lfg.42.2018.05.18.23.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 23:54:14 -0700 (PDT)
Date:   Sat, 19 May 2018 08:54:12 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 11/11] read_cache: convert most calls to
 repo_read_index_or_die
Message-ID: <20180519065411.GB14755@duynguyen.home>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
 <20180516222118.233868-12-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516222118.233868-12-sbeller@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 03:21:18PM -0700, Stefan Beller wrote:

This commit may need some more explanation. It's not always safe to
replace "read_cache();" with "repo_read_index_or_die();" and you do
sometimes avoid that variant.

While I agree _or_die() is the right thing to do most of the time. You
need to consider that we (or some of us) have tried to avoid die() in
some library code. So..

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  blame.c               | 5 +++--
>  builtin/am.c          | 3 ++-
>  builtin/diff.c        | 3 ++-
>  builtin/fsck.c        | 3 ++-
>  builtin/merge-index.c | 3 ++-

These should be good.

>  check-racy.c          | 2 +-

Meh.. this one is test code.

> diff --git a/diff.c b/diff.c
> index 1289df4b1f9..383f52fa118 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -22,6 +22,7 @@
>  #include "argv-array.h"
>  #include "graph.h"
>  #include "packfile.h"
> +#include "repository.h"
>  
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -4210,13 +4211,13 @@ void diff_setup_done(struct diff_options *options)
>  		options->rename_limit = diff_rename_limit_default;
>  	if (options->setup & DIFF_SETUP_USE_CACHE) {
>  		if (!active_cache)
> -			/* read-cache does not die even when it fails
> +			/* repo_read_indexe does not die even when it fails

s/indexe/index/

>  			 * so it is safe for us to do this here.  Also
>  			 * it does not smudge active_cache or active_nr
>  			 * when it fails, so we do not have to worry about
>  			 * cleaning it up ourselves either.
>  			 */
> -			read_cache();
> +			repo_read_index(the_repository);

Should we write a warning message or something?

> diff --git a/revision.c b/revision.c
> index 1cff11833e7..8ad9824143d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -23,6 +23,7 @@
>  #include "packfile.h"
>  #include "worktree.h"
>  #include "argv-array.h"
> +#include "repository.h"
>  
>  volatile show_early_output_fn_t show_early_output;
>  
> @@ -1344,7 +1345,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
>  {
>  	struct worktree **worktrees, **p;
>  
> -	read_cache();
> +	repo_read_index_or_die(the_repository);

I think here we should be able to tolerate a bad index file. If you
have bad index file, we ignore object references from it and continue
on the rev walk without it. So repo_read_index() may be better,
optionally with a warning.

> diff --git a/sha1-name.c b/sha1-name.c
> index 5b93bf8da36..83d5f945cf1 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1639,7 +1639,7 @@ static int get_oid_with_context_1(const char *name,
>  			oc->path = xstrdup(cp);
>  
>  		if (!active_cache)
> -			read_cache();
> +			repo_read_index_or_die(the_repository);

This should return an error code instead. I notice there's a
"only_to_die" flag somewhere in here. Something to think about.

BTW you probably want to move away from "active_cache" too. It makes
sense to read "if active cache is null then read the cache". But with
the move to the repository it now seems disconnected.

This looks clearer but a bit verbose

		if (!the_repository->index_file.cache)
			repo_read_index_or_die(the_repository);

This might be the best

		if (!repo_index_loaded(the_repository))
			repo_read_index_or_die(the_repository);

but obviously more work for you, so your choice :)

>  		pos = cache_name_pos(cp, namelen);
>  		if (pos < 0)
>  			pos = -pos - 1;
> -- 
> 2.17.0.582.gccdcbd54c44.dirty
> 
