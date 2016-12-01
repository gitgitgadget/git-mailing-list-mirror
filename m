Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0198F1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757875AbcLASbN (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:31:13 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33926 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752921AbcLASbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:31:12 -0500
Received: by mail-qt0-f176.google.com with SMTP id n6so229479338qtd.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 10:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pdBV5hqASiMpuDuHbniQ3ScQbn7hgECnRxZqzz51bi0=;
        b=Ue5k/iw/MzAXBk43cA4T/leTO4lgtBRXYYy8a5OZkuIk7cO2NDGdWhlrEmZgrgE4HH
         +xrkLjnZTk0pABV9E02SqiesHw39yT4u0Z0kxu++4GZl4ou85leMOMUNzlDklF+cJtUu
         zE+SPD0i5teB1EJqu0thwfaqDoj4JBoV7yQWrLOzJSjSS8L8iZFphFBTktclKT0Wo8Fa
         sm1wjohs6Z8GuT0me0GUxNJ+CFBgCr1R/J9CgWiVh9E4OhdYyjXESrv6/kRxKSIEjKOC
         CQ6UzPyNoUFLrsfVhP73oBlWjJFRa9cdDDb1iLW/oS6ovsdagu7d+NScyS6fHVGSyx76
         1Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pdBV5hqASiMpuDuHbniQ3ScQbn7hgECnRxZqzz51bi0=;
        b=k4aMjUJ4SxlA5bwQITOUsmijWLkF28tf8Q3TM4TtPvHb0XuCtRUVwUeQCI8B/aW9F0
         rmvfj2VQqR/QDqfjcjsUkRse6Mu12nJPrmlv0eNUY5R8gQ2GhBLnj8FwOLFwolam3qiq
         NqSugvVQewLa+XIYW2HHfnRxlTT27f8BIZi3FPIWzYD5aya9OhFiZCQE/ETL4EAByUqn
         cth/BIpFntqmD3L+7aG9aY0AS0B+YtfB0Dw7RRZFtzhYgu9kUb1ezAsVkL1WZtuCgOPT
         SyCiSrb15l5HtNFN5+ctxz2dvxWq4ZDQnXgrJ4jhxxs5tdBtnKXH4pxBoplrhFWk737G
         X8+w==
X-Gm-Message-State: AKaTC02G7KczdhorcHxsgeAp7NXsy92UIhALLwgVJShEA/+XDtXkkfJHQyb/qtuogN0DSdutQN62aidS2buI4dQf
X-Received: by 10.200.53.9 with SMTP id y9mr33731382qtb.176.1480617066673;
 Thu, 01 Dec 2016 10:31:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 1 Dec 2016 10:31:06 -0800 (PST)
In-Reply-To: <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com> <1480555714-186183-2-git-send-email-bmwill@google.com>
 <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Dec 2016 10:31:06 -0800
Message-ID: <CAGZ79kaXe7QY5FUZwmnhMiRb9u5aF+Yq-u8JPAQVAubW71u3Cg@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 8:29 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 30, 2016 at 05:28:29PM -0800, Brandon Williams wrote:
>
>> +/*
>> + * Determine if a submodule has been populated at a given 'path'
>> + */
>> +int is_submodule_populated(const char *path)
>> +{
>> +     int ret = 0;
>> +     struct stat st;
>> +     char *gitdir = xstrfmt("%s/.git", path);
>> +
>> +     if (!stat(gitdir, &st))
>> +             ret = 1;
>> +
>> +     free(gitdir);
>> +     return ret;
>> +}
>
> I don't know if it's worth changing or not, but this could be a bit
> shorter:
>
>   int is_submodule_populated(const char *path)
>   {
>         return !access(mkpath("%s/.git", path), F_OK);
>   }
>
> There is a file_exists() helper, but it uses lstat(), which I think you
> don't want (because you'd prefer to bail on a broken .git symlink). But
> access(F_OK) does what you want, I think.
>
> mkpath() is generally an unsafe function because it uses a static
> buffer, but it's handy and safe for handing values to syscalls like
> this.
>
> I say "I don't know if it's worth it" because what you've written is
> fine, and while more lines, it's fairly obvious and safe.

OK, chiming in here as well. :)

I plan on making use of the is_submodule_populated method in
the checkout --recurse-submodules series, and for that I am
undecided whether a cheap stat is the right approach or if we want
to have the result of resolve_gitdir as that fails in weird corner cases.

Anyway, I'd propose to change the name when going with either the
code as is or what Jeff proposes to be one of

    is_submodule_populated_cheaply
    is_submodule_populated_with_no_sanity_check
    is_submodule_dot_git_present
    have_submodule_dot_git

I think I'd prefer the last one as that describes what the function
actually does in a concise way?

Thanks,
Stefan
