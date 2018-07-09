Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21A61F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933696AbeGIRil (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:38:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37622 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933495AbeGIRil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:38:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so6351671plc.4
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=73H47FhuFR9I24ShdF9aAqw5jJ7TYV1Dmq1CqbjNcQw=;
        b=QEFXVrVxjqlxHUMbhi1zkL44BFLUrLHq55jxtT3T5Y3TFYygjFko61WlZnKL3OS/uV
         O7CS3TFyAraoOcu4SzWdpnsol/nQApmq0SgT1Wrdo19tbCt6vG03iJwM9yB6pAgl4lbD
         6fXgJIfA5/6HPT8pTLViaNT0L9cVobs7tg7/9QHI07BsJP0s+E4J8uar+QuMX/mM3iGa
         4v8UDkQmqjK9ahqk0dE6G5blF8FIqPqm6WB06rvnKi+4Xlqwspp4bLFki6ININ1vj1Yj
         HWXv8ekvp8HHi9x333ZtpGzNpmVwLyrWywbbtstSJv5GSVudT8c9Fw4avoW9DvsjEB9S
         zieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=73H47FhuFR9I24ShdF9aAqw5jJ7TYV1Dmq1CqbjNcQw=;
        b=HRrSfmw01oO8Tc032eZMEz4ho2IiebAvL/gqmD55k6o9DmMkWgyr11d4l2DLSQ5FPT
         2FlgJVpg5CrsbKCHxV7viLuVQhc/cFxIQvcYsy56wSyNJmEC52QPbJ3lYREUPJrcHsNn
         OCS2VbZk5bKyl5mszjnnPxUU6GuVtXNBmXjYhsif8EOcIcYu0C9/NSRld3LFnbPjxaay
         fZgrebtSwksZQMOlAa5PgJnxsKK//mor/1tqLda3pMiMywHuIfcnVQUECEzX+HmXvPbZ
         5OuY+FUpwLXc3RnOGR25GN2A4fchFakWfqDewu5iGCkXduCMwK7r6fL/NhPmdbO7pZCf
         Toew==
X-Gm-Message-State: APt69E0ju5N7ieyBFvCVmpDw2Ja6qgVZAgaKcCQO+j81tPwAGmTiwEbE
        ELmqB896m1hoovT6qDSUecGEV5cv
X-Google-Smtp-Source: AAOMgpfRtX3vyd/YqbwnWst2yo/qQGYVPTbHpa9Eg+8PAqyK083czyY6iXMbV7TyeCanrbJox1F4cQ==
X-Received: by 2002:a17:902:758c:: with SMTP id j12-v6mr21426423pll.195.1531157920395;
        Mon, 09 Jul 2018 10:38:40 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d141-v6sm28340090pfd.54.2018.07.09.10.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:38:39 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:38:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
Message-ID: <20180709173813.GA14196@aiede.svl.corp.google.com>
References: <cover.1528233146.git.jonathantanmy@google.com>
 <cover.1528234587.git.jonathantanmy@google.com>
 <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -359,7 +359,7 @@ static struct ref *get_ref_map(struct transport *transport,
>  		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
>  
>  	if (ref_prefixes.argc &&
> -	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
> +	    (tags == TAGS_SET || tags == TAGS_DEFAULT)) {

Makes a lot of sense.

This means that if I run

	git fetch origin master

then the ls-refs step will now include refs/tags/* in addition to
refs/heads/master, erasing some of the gain that protocol v2 brought.
But since the user didn't pass --no-tags, that is what the user asked
for.

One could argue that the user didn't *mean* to ask for that.  In other
words, I wonder if the following would better match the user intent:

 - introduce a new tagopt value, --tags=auto or something, that means
   that tags are only followed when no refspec is supplied.  In other
   words,

	git fetch --tags=auto <remote>

   would perform tag auto-following, while

   	git fetch --tags=auto <remote> <branch>

   would act like fetch --no-tags.

 - make --tags=auto the default for new clones.

What do you think?

Some related thoughts on tag auto-following:

It would be tempting to not use tag auto-following at all in the
default configuration and just include refs/tags/*:refs/tags/* in the
default clone refspec.  Unfortunately, that would be a pretty
significant behavior change from the present behavior, since

 - it would fetch tags pointing to objects unrelated to the fetched
   history
 - if we have ref-in-want *with* pattern support, it would mean we
   try to fetch all tags on every fetch.  As discussed in the
   thread [1], this is expensive and difficult to get right.
 - if an unannotated tag is fast-forwarded, it would allow existing
   tags to be updated
 - it interacts poorly with --prune
 - ...

I actually suspect it's a good direction in the long term, but until
we address those downsides (see also the occasional discussions on tag
namespaces), we're not ready for it.  The --tags=auto described above
is a sort of half approximation.

Anyway, this is all a long way of saying that despite the performance
regression I believe this patch heads in the right direction.  The
performance regression is inevitable in what the user is
(unintentionally) requesting, and we can address it separately by
changing the defaults to better match what the user intends to
request.

Thanks,
Jonathan

[1] https://public-inbox.org/git/20180605175144.4225-1-bmwill@google.com/
