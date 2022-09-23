Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4FBC07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 21:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiIWVTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIWVTg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 17:19:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D12BF5
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 14:19:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c24so1278878plo.3
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 14:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=O4UuZ368Jm75a4ZG4LftZnEZdtqdy93rx1V7VXbaLF0=;
        b=eCaiDghyHo62nhBbTigSw1LiXI4xVJR9tjPoyuseMBsk2ojxw3hxr1qOndglTh9RpN
         JXoyChWuL2KloPINgpydYbRGrS1cwtQ3nKeeVB9kpO/WI2GEGUrBZACP8zFnDpo+FUWS
         Dc3bVbIkanl/Ti7jmTonKoE0FxSEkyGepLnoW1J9DdWjFeCKomvMnuPHZCFruAL58uT8
         znu8nZbwiF2lM5qjMAqCk2Wntvq6oM/qp6xi435A5nUh7xxwDgHp+RgZk6sdreixbKFS
         S+Uzpaw+8hvD2InWv4Ufv6cAb6belcSCizedTV7G+E0L7fENPzUh+cusH3lCCSlveWcp
         nXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=O4UuZ368Jm75a4ZG4LftZnEZdtqdy93rx1V7VXbaLF0=;
        b=d5Z+vxrp9s25sgDbZ7rH0cuwKMWZma9s0RQ2OphgNLmWYTqTZ8DTCsXWavCr6DhJ7X
         3R5cqBBRcqfRt2wPMgH5+nwH+CuXN9+Xmv+wYS0S0KImR8E6FaP56DNbCujS/pumCq0K
         iAgo6O9nXPEFaxtYLZiNs2y1nFGUX+ygmCYNvpzca7al/hegBSsXZXAnlD2ceMhW1xVB
         shTKzKfvpaG9DtAlV6YKlo2OFfRiaStrRCWG/NI6bK0YbgJTgMcFEJ825LsNaUc8aCIw
         PucybPw1iUVfCA59yP9XI+iCR8SOw+lRWqPb8OpSbUN8Dvz/OCNzS1GZjFrQwUxuiHam
         1bfQ==
X-Gm-Message-State: ACrzQf3mx9k0e8vIR0PNnmJ5ctSw5zQlsmU20bDrHslF2Jq8QM038O2W
        jtZ9xKSUFpPfFus/6sKeQMVwJJWvDZGE1Auv
X-Google-Smtp-Source: AMsMyM73k+ofpSnOvWFf595R7Q+MTWqNxE/KY4EC7VzN7VTeqUj4UKJElubrJejJIMRfTT1uMb2Ekw==
X-Received: by 2002:a17:90b:4f8e:b0:202:dd39:c04d with SMTP id qe14-20020a17090b4f8e00b00202dd39c04dmr12040640pjb.66.1663967971900;
        Fri, 23 Sep 2022 14:19:31 -0700 (PDT)
Received: from initialcommit.io ([2600:8801:9c0a:f300:449a:6533:97b5:bdb6])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b00176d347e9a7sm6571938plh.233.2022.09.23.14.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 14:19:31 -0700 (PDT)
Date:   Fri, 23 Sep 2022 14:19:28 -0700
From:   Jacob Stopak <jacob@initialcommit.io>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Yy4i4I15RjOy+sLm.jacob@initialcommit.io>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqillevzeh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 09:17:10AM -0700, Junio C Hamano wrote:

> It is unclear what timestamp is used, how a "month" is defined, etc.
> As "git shortlog --since=2.years" cuts off based on the committer
> timestamp, I would expect that the committer timestamps are used for
> this grouping as well?

It uses the "commit->date" member from the commit struct in commit.h,
which I assumed was the committer timestamp, but I'll confirm that's
what actually gets populated in there since I don't see a separate
member for the author timestamp...

> If I make a commit on the first day of the
> month in my timezone, but that instant happens to be still on the
> last day of the previous month in your timezone, which month would
> your invocation of "git shortlog --group=month" would the commit be
> attributed?  My month, or your month?

I need to look into how Git typically handles these timezone differences
and will try to apply similar behavior for these time-based groupings.

> Does it make sense to even say "group by month and year"?  I expect
> that it would mean the same thing as "group by month", and if that
> is the case, the command probably should error out or at least warn
> if both are given.

Yes, "group by month and year" and "group by month" means the same
thing the way I implemented. If both groups are supplied, it will
just ignore the year group and group by month like you mentioned,
by flipping off the YEAR bit as follows:

if ((log->groups & SHORTLOG_GROUP_MONTH) &&
    (log->groups & SHORTLOG_GROUP_YEAR))
	log->groups ^= SHORTLOG_GROUP_YEAR;

I can add a warning message to make this more clear to the user.

> An alternative interpretation could be, when
> told to "group by month", group the commits made in September 2022
> into the same group as the group for commits made in September in
> all other years, but I do not know how useful it would be.

In data analytics terms this is usually referred to as "month of year",
and personally I see it less useful in Git's shortlog context because I
envision more folks would find output useful for single or consecutive
time periods. However, adding a "month of year" grouping could be useful
to answer questions like "what periods throughout the year are contributors
most active?". If we decide to add a "month of year" grouping option as
well, it would be trivial to include.
 
> Not a suggestion to use a different implementation or add a new
> feature on top of this --group-by-time-range idea, but I wonder if
> it is a more flexible and generalizeable approach to say "formulate
> this value given by the --format=<format> string, apply this regular
> expression match, and group by the subexpression value".  E.g.
> 
>     git shortlog \
> 	--group-by-value="%cI" \
> 	--group-by-regexp="^(\d{4}-\d{2})"
> 
> would "formulate the 'committer date in ISO format' value, and apply
> the 'grab leading 4 digits followed by a dash followed by 2 digits'
> regexp, and group by the matched part".
> 
> That's a better way to implement "group by month" internally, and
> allow more flexibility.  If a project is well disciplined and its
> commit titles follow the "<area>: <description>" convention, you
> probably could do
> 
>     git shortlog --no-merges \
> 	--group-by-value="%s" \
> 	--group-by-regexp="^([^:]+):"
> 
> and group by <area> each commit touches.  Of course, existing
> --committer and --author can also be internally reimplemented using
> the same mechanism.

At first look this sounds very flexible and appealing, and I would be 
interested in exploring a refactor to this in the future. I think the
rub is that supplying custom patterns wouldn't necessarily stack up
neatly into good groups, which could lead to confusing results for the
user in terms of both grouping and sorting. But like you mentioned
it could be really cool if used judiciously for a consistent history
like Git's. And the generalized re-implementation of the current
shortlog groups would be a nice bonus.

> > @@ -80,6 +82,14 @@ counts both authors and co-authors.
> >  --committer::
> >  	This is an alias for `--group=committer`.
> >  
> > +-m::
> > +--month::
> > +	This is an alias for `--group=month`.
> > +
> > +-y::
> > +--year::
> > +	This is an alias for `--group=year`.
> > +
> 
> Let's not add this in the same patch.  I am fairly negative on
> adding more, outside "--group".  Besides, we do not have a good
> answer to those who want to group by week.  -w is already taken.

No worries - I'll remove the shorthand flags for v3.
