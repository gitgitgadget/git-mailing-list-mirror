Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AAD91F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeBWXQM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:16:12 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33523 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeBWXQL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:16:11 -0500
Received: by mail-pf0-f193.google.com with SMTP id q13so4123380pff.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GVLnBBM7Xo1FaacQ1Vq+zf2d/xGymqF1FJUsqLjPbRU=;
        b=RznWBnuuY/bqWxX+vWTbhZJ1npbVDgeFQr39QCRnqXvzdmOuwK2wFCnt7YLIVLDpHL
         +RYz0SUhJsepUE3cV0Y0gv0GnzM8JPwJLpT76xHCamOJtHoDcFqmUlkD0M4JFZ58P+FK
         gqafweXVMFL1xTGN+9Xuxs7tBKggJdzy/HXjDG+xdqa6vpOSbkrYUuSE9lgRljhqzSd9
         CZ3FHqYO0FGirDHQ3jqzRJJVrH9lueKTEtOfUCrGQqP/+UrK8LEJbLmrhry6MsFlLoRq
         E6mhCqv1DqY2Ci/itmpS7blAZ47PJQt91Retgryg0eryHpXTF+xcmt8gVlmSGephNPbq
         Rk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GVLnBBM7Xo1FaacQ1Vq+zf2d/xGymqF1FJUsqLjPbRU=;
        b=k/TcQBwI6XfxeyG6ytbw6zkidAmZpEi+/3LUNx3fGKWHb1w0iUzQaybvALdsNi6C+S
         av9g0tGAxfT7/RoAx7bq2JGUWjvtDfwOPZG5yVjbDN1caHY+L5aa5eUvbCNEqwy99InO
         5C5RXt1QMmU2hO1mudmFeggteuJBac8KaAYULSrqA+Oyety5iPoevzXLJ3w21KSY7JBi
         KZbv6iI9G2++9klHZ+iTlp9S0JcOTmHE6XVfJ+IejH465KCXqbRxPmyYFpJZqAV7fAGu
         oE5eKtuS+BRIAV/HT9jWWC0sEpUfRN6XkgjSNj5idWxNQY2r1pY/De1bb+O0k0px+4XG
         7CdA==
X-Gm-Message-State: APf1xPAm+GKExG96chHe+2du8mSPGJo16SHE1i7SpwSsrkHIdH3FecdV
        FSFWA+ReGjUEOitr3yAgIIifgw==
X-Google-Smtp-Source: AH8x224UTLCwLzP25Lc2xmnOk00SBUYSWQ7YrxQyFule7D99LhPk9RpNPt5n39rKk1YVGNEHMgme/Q==
X-Received: by 10.99.124.7 with SMTP id x7mr2607495pgc.356.1519427770322;
        Fri, 23 Feb 2018 15:16:10 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id u19sm6711899pfl.75.2018.02.23.15.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 15:16:09 -0800 (PST)
Date:   Fri, 23 Feb 2018 15:16:08 -0800
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
Message-ID: <20180223231608.GI234838@google.com>
References: <20180214180814.GA139458@google.com>
 <20180223095640.25876-1-pclouds@gmail.com>
 <20180223095640.25876-3-pclouds@gmail.com>
 <20180223222950.GK6619@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180223222950.GK6619@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, brian m. carlson wrote:
> On Fri, Feb 23, 2018 at 04:56:40PM +0700, Nguyễn Thái Ngọc Duy wrote:
> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> > index 7e3e1a461c..8ee935504e 100644
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -1673,6 +1673,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
> >  	if (prefix && chdir(prefix))
> >  		die(_("Cannot come back to cwd"));
> >  
> > +	if (!the_hash_algo) {
> > +		warning(_("Running without a repository, assuming SHA-1 hash"));
> > +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> > +	}
> 
> Is this warning going to be visible to users in the normal course of
> operation?  If so, people are probably going to find this bothersome or
> alarming.
> 
> >  	for (i = 1; i < argc; i++) {
> >  		const char *arg = argv[i];
> >  
> > diff --git a/common-main.c b/common-main.c
> > index 6a689007e7..12aec36794 100644
> > --- a/common-main.c
> > +++ b/common-main.c
> > @@ -1,6 +1,7 @@
> >  #include "cache.h"
> >  #include "exec_cmd.h"
> >  #include "attr.h"
> > +#include "repository.h"
> >  
> >  /*
> >   * Many parts of Git have subprograms communicate via pipe, expect the
> > @@ -40,5 +41,8 @@ int main(int argc, const char **argv)
> >  
> >  	restore_sigpipe_to_default();
> >  
> > +	if (getenv("GIT_HASH_FIXUP"))
> > +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> 
> I'm lukewarm on adding this environment variable, but considering our
> history here, we had probably better.  We can always remove it after a
> few releases.

Yeah I don't know what the best thing to do here would be.  I mean we
could always just init the hash_algo for the_repository here so that we
don't ever have to worry about it, but I don't know if even that is the
right approach.

> 
> >  	return cmd_main(argc, argv);
> >  }
> > diff --git a/diff-no-index.c b/diff-no-index.c
> > index 0ed5f0f496..f038f665bc 100644
> > --- a/diff-no-index.c
> > +++ b/diff-no-index.c
> > @@ -241,6 +241,11 @@ void diff_no_index(struct rev_info *revs,
> >  	struct strbuf replacement = STRBUF_INIT;
> >  	const char *prefix = revs->prefix;
> >  
> > +	if (!the_hash_algo) {
> > +		warning(_("Running without a repository, assuming SHA-1 hash"));
> > +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> > +	}
> 
> Again, same concern.  I can imagine scripts that will blow up loudly if
> git diff --no-index spews things to standard error.
> 
> I'm not opposed to making this more visible, but I wonder if maybe it
> should only be visible to developers or such.  The only way I can think
> of doing is that is with an advice options, but maybe there's a better
> way.
> -- 
> brian m. carlson / brian with sandals: Houston, Texas, US
> https://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: https://keybase.io/bk2204



-- 
Brandon Williams
