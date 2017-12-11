Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74F501F404
	for <e@80x24.org>; Mon, 11 Dec 2017 20:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbdLKUf0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 15:35:26 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43135 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdLKUfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 15:35:25 -0500
Received: by mail-wm0-f66.google.com with SMTP id n138so16874157wmg.2
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZcnt13QcAvWrrXnmxaQNzkMKrS8dfoTeT3U522X+ro=;
        b=hlmhin8wWhNT89Be6NHaxKWz7bCCH07GZ0p2KHhF9hwC4ixqjkZWL79j2kG2zALh74
         qRDrm6gGwA+/mk7B6SfrTFsN08JnSiClJ909pBgiW9KhOZ4o4teJ+CY1SW9+wfJVVyKO
         3j9j/MbMMK6oafc3tLDXDgyNZRvvHLuxJeGlKT03+vSyoKyj1GzYEesviR604EhyXGEH
         TiSnF7RM7o3Vg75b/iu3BIvBW9Qq22NEtXifdioaf4LJ5FUTPUpmzcb5qZBjQwoX8RA6
         pW+LwGlocsgj59BcXrI07PFck8t1CT7+HbKC+goH7wWTTm/GY9sU5f4KuCfHsuMmRXNz
         5U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZcnt13QcAvWrrXnmxaQNzkMKrS8dfoTeT3U522X+ro=;
        b=tBiUizYv6x4u8aEzqVbs+xF6021wLnBPT+lS50f5i4QWfrr0svP+8Jne+663BIOpR7
         PXEKwxb2f/2rttdo5GbYjOaf05cx6aOUdMzHXFDyQ1q+DOGw/azf5jv74xa0MBGZnc/Y
         MfTFRLokrX3NqZY83LV20LaLdYN1mbJO2ZMiHtCNM6muSiJPSfRv+r2k/81Apn6kXbs9
         w99+MZzAptfzqT9sqnK7/8CQcq+mLxKqWUsfOGxaEl3iI+RFjxExBUF2lXplP148gXXO
         vcdltRqP4fQH2armd675oAlPj500DS1hX/ut7oAtUH6yCe7cOo0/2vX6E1kUer0qCV9B
         0xSg==
X-Gm-Message-State: AKGB3mIDXmmE/sdpDoHP52Mcgy3u46vDCsmhrg/W92E+5PoMGLa+RDmu
        AfiYwMYhI27+lFACs88vcjY=
X-Google-Smtp-Source: ACJfBouLhBjIhTitk0kymz5X5Pmq4q6KdkCJ68O3HC2+N8gf1kgeCvvM0J0U1IP5DqnAz6Q6mxjrqQ==
X-Received: by 10.28.190.12 with SMTP id o12mr1829400wmf.148.1513024524000;
        Mon, 11 Dec 2017 12:35:24 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id a203sm9781050wmh.45.2017.12.11.12.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 12:35:23 -0800 (PST)
Date:   Mon, 11 Dec 2017 20:37:07 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] repository: fix repo_read_index with submodules
Message-ID: <20171211203707.GB25616@hank>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171210212202.28231-2-t.gummerer@gmail.com>
 <20171211185406.GA177995@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211185406.GA177995@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11, Brandon Williams wrote:
> On 12/10, Thomas Gummerer wrote:
> > repo_read_index calls read_index_from, which takes an path argument for
> > the location of the index file.  For the split index however it relies
> > on the current working directory to construct the path using git_path.
> > 
> > repo_read_index calls read_index_from with the full path for the index
> > file, however it doesn't change the cwd, so when split index mode is
> > turned on, read_index_from can't find the file for the split index.
> > 
> > For example t3007-ls-files-recurse-submodules.sh was broken with
> > GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
> > object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
> > broken in a similar manner, probably by introducing struct repository
> > there, although I didn't track down the exact commit for that.
> > 
> > Fix this by introducing a new read_index_for_repo function, which knows
> > about the correct paths for the submodules.
> > 
> > The alternative would have been to make the callers pass in the base
> > path for the split index, however that ended up being more complicated,
> > and I think we want to converge towards using struct repository for
> > things like these anyway.
> 
> Thanks for catching this, I'm not a user of split index myself which is
> why I unfortunately overlooked this.  Definitely a good change.  I
> really only have one nit below.

Me neither, I just remember to run the split index tests every once in
a while, which is also why it's taken so long to catch this.
Hopefully after we fixed this we can get travis to run the tests,
which should help :)

> > 
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  cache.h      |  1 +
> >  read-cache.c | 19 +++++++++++++++++--
> >  repository.c |  2 +-
> >  3 files changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/cache.h b/cache.h
> > index cb5db7bf83..d42bea1ef7 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -614,6 +614,7 @@ extern int read_index_preload(struct index_state *, const struct pathspec *paths
> >  extern int do_read_index(struct index_state *istate, const char *path,
> >  			 int must_exist); /* for testting only! */
> >  extern int read_index_from(struct index_state *, const char *path);
> > +extern int read_index_for_repo(const struct repository *);
> >  extern int is_index_unborn(struct index_state *);
> >  extern int read_index_unmerged(struct index_state *);
> >  
> > diff --git a/read-cache.c b/read-cache.c
> > index 2eb81a66b9..4d5c4ad79b 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -20,6 +20,7 @@
> >  #include "split-index.h"
> >  #include "utf8.h"
> >  #include "fsmonitor.h"
> > +#include "repository.h"
> >  
> >  /* Mask for the name length in ce_flags in the on-disk index */
> >  
> > @@ -1871,7 +1872,8 @@ static void freshen_shared_index(char *base_sha1_hex, int warn)
> >  	free(shared_index);
> >  }
> >  
> > -int read_index_from(struct index_state *istate, const char *path)
> > +static int do_read_index_from(struct index_state *istate, const char *path,
> > +			      const struct repository *repo)
> >  {
> >  	struct split_index *split_index;
> >  	int ret;
> > @@ -1896,7 +1898,10 @@ int read_index_from(struct index_state *istate, const char *path)
> >  		split_index->base = xcalloc(1, sizeof(*split_index->base));
> >  
> >  	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
> > -	base_path = git_path("sharedindex.%s", base_sha1_hex);
> > +	if (repo)
> > +		base_path = repo_git_path(repo, "sharedindex.%s", base_sha1_hex);
> > +	else
> > +		base_path = git_path("sharedindex.%s", base_sha1_hex);
> >  	ret = do_read_index(split_index->base, base_path, 1);
> >  	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
> >  		die("broken index, expect %s in %s, got %s",
> > @@ -1909,6 +1914,16 @@ int read_index_from(struct index_state *istate, const char *path)
> >  	return ret;
> >  }
> >  
> > +int read_index_for_repo(const struct repository *repo)
> > +{
> > +	return do_read_index_from(repo->index, repo->index_file, repo);
> > +}
> > +
> > +int read_index_from(struct index_state *istate, const char *path)
> > +{
> > +	return do_read_index_from(istate, path, NULL);
> > +}
> 
> Instead of passing NULL and having to special case it in
> 'do_read_index_from()', how about we pass in 'the_repository'?

I think that makes sense the only way this function used to work with
split index turned on is if it's called from the main repository, so
just passing through 'the_repository' would have the function behave
the exact same way as before.

> > +
> >  int is_index_unborn(struct index_state *istate)
> >  {
> >  	return (!istate->cache_nr && !istate->timestamp.sec);
> > diff --git a/repository.c b/repository.c
> > index bb2fae5446..928b1f553d 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -229,5 +229,5 @@ int repo_read_index(struct repository *repo)
> >  	if (!repo->index)
> >  		repo->index = xcalloc(1, sizeof(*repo->index));
> >  
> > -	return read_index_from(repo->index, repo->index_file);
> > +	return read_index_for_repo(repo);
> >  }
> > -- 
> > 2.15.1.504.g5279b80103
> > 
> 
> -- 
> Brandon Williams
