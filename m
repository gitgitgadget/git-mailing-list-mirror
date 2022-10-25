Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2B4FA3741
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 18:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJYSBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiJYSBn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 14:01:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A09167DD
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:01:34 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id f205so15672077yba.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ywYpwQs8OyX35QK07VtLjYMMDc6jlLJuIeeidwjDaeo=;
        b=e6tQjppNi+zmymyqlZSIF5V3B17MhI5qdBmno3eCvkatTRodHPvWU+lssWxZAbLRRu
         0zT3YSTHKbUGkkO98dSeV9+o5NoCjkibZVh45HFAssvT6Ha9CUWUIKrQqvPFqKfMR56E
         Kmdios6KnUNVijtPOTqPWDPltoOZZocS6iR7eljmOUg6pJ5kaJpAThQsazS8vxSS/pz2
         HzCgp5yMjyCsUJ0ke5ayf9SzITW/yJxntvGKXyichZXMEmcnD1IUCwuVjsO3Yz+dn3bk
         dt+KS5HVdCqIg/Z4YfUgtirGeaP2W9W0U474ZwAFdcXf9zLGQdMBvW75slfv64zXJklt
         iVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywYpwQs8OyX35QK07VtLjYMMDc6jlLJuIeeidwjDaeo=;
        b=SVVK5x3ig5ye0AB8ePCuWwW2+ObR7GbXKNvhGZUdbB88BahRs6CXX5ZmV+xqhuHOeF
         MsSdvndJt6j4iY42fkmVsCGftc9G+4QqAFHu8LUOoFbDc6JLTvJEEJ+3BvMt8g9VL81W
         fVYTBUJIAAGFqCz0ccjfGtiax5ZIYwuhSyvKA35SzRzgkYYtO/Jab/ZCC0waa6q5/d0T
         arNEE8wyc++sY18wRxf/hQjj49xh2OyXsH9cMlWZoHbAsdJ/7RBskvYBTiKjh4eYTCPP
         19BG2WEV3b/1JvR6nh450Um8UI2xQQERAm5Bk4AfxAFLKYqvY/mPtxu0GvZPRYwOKvAo
         wtPw==
X-Gm-Message-State: ACrzQf1kH+YsunnpsHKhPWuynzrfvqvpAoHepNP1YXlolX+PuYU4ZEXR
        rzJjh7YLj5DvlfF5f5NPzldyDWyLeSjy8slrjnKgFw==
X-Google-Smtp-Source: AMsMyM7fs5nBTy/NYZdyTGsslwlsZYwfCTofFpMdC5eOTB5feIjALoknM4kLvlaN09sGv4Re8nCGQkIbOh+igkOjxB0=
X-Received: by 2002:a25:420d:0:b0:6cb:77dd:8289 with SMTP id
 p13-20020a25420d000000b006cb77dd8289mr3333521yba.392.1666720893035; Tue, 25
 Oct 2022 11:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFySSZAbsPuyPVX0+DQzArny2CEWs+GpQqJ3AOxUB_ffo8B3SQ@mail.gmail.com>
 <221025.86sfjccjay.gmgdl@evledraar.gmail.com>
In-Reply-To: <221025.86sfjccjay.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 25 Oct 2022 11:01:21 -0700
Message-ID: <CAFySSZBnuszT0iYdFThRzktBuMaCTfGCTz5nbhK6sbrt=QL+5w@mail.gmail.com>
Subject: Re: Parallelism defaults and config options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > The next inconsistency is for values < 1. Most options use online_cpus()
> > when set to 0 except index.threads which is a special case of its own.
> > Some options error out when set to a negative number while
> > checkout.workers falls back to online_cpus() and http.maxRequests falls
> > back to 5. I don't think we can fix this retroactively unless we decide
> > that all config options will be set to online_cpus() if the value is
> > negative. Should that be the case going forward or should 0 be the only
> > special cased value for now? I can see an argument for allowing other
> > negative values to be configured in the future for different defaulting
> > options.
>
> We also have other options, like warning() on negative values if we
> think it's worth making these consistent while slightly annoying
> existing users.
>
> I think it's safe to say that by far the majority of git users aren't
> tweaking these at all, so we have a lot of leeway for sensible changes.

I like the warning() idea -- it doesn't break people's git and sets the correct
precedence for what to expect for similar parallelism config options.

> > The final inconsistency is how values are defaulted if unset. Some
> > default to online_cpus() while others default to 1 (http.maxRequests is
> > 5). I want to call out grep.threads specifically here -- on my machine
> > with 48 cores, the default is actually SLOWER than using 1 thread. This
> > is because the grep operation is heavily IO bound, so creating too many
> > threads adds overhead every time the read head changes. Interestingly,
> > this option runs optimally at 4 since that's how many PCIe lanes my SSD
> > uses. While it makes sense to default processor heavy operations to
> > online_cpus(), does it make sense to do the same for IO heavy
> > operations? (I wasn't able to find an equivalent of online_cpus() for
> > drive reading capabilities.) And what about operations that have a fair
> > mix of each?
>
> First, http.maxRequests is different from any of the rest, it'll impact
> 3rd party servers. So we should treat it differently. I'd think unless
> we have solid evidence for something else we should just leave that one
> be, and certainly not have it be some function of online_cpus().

I wasn't planning on touching that one either -- mostly brought it up as an
example of an arbitrarily picked default.

> > The safe option is to default to 1 process for many of these config
> > options, but we trade off in improving the experience for the average
> > user that is unaware of these options. If we're already defaulting to
> > online_cpus() for grep.threads and selecting 5 for http.maxRequests,
> > then why not do the same for other options? My suggestion would be
> > defaulting IO dominant operations to min(4, online_cpus()) since that
> > seems like the standard number of lanes for people using SSDs. I would
> > also default operations that have a mix of both to
> > min(8, online_cpus()).
>
> I haven't thought/tested what the defaults *should* be, but I think it's
> a fair assumption that the current defaults were probably picked on the
> basis of a few ad-hoc tests on some person's laptop :)
>
> I.e. the 48 core case you mention etc. is likely to be untested & wasn't
> thought of at the time.

Even with 8 threads, git grep runs very slightly slower than with 1 thread
for me. Unless we have something along the lines of "git setup-parallelism",
any default we pick will have different outcomes for different users, but I
think we can at least make a better guess than what we currently have.

> I think *structurally* the best approach is something like having a
> family of config variables like:
>
>         core.jobs: [(false | 1)|(0 | true) | [2..Inf] ]
>         core.jobs.IOBound: [(false | 1)|(0 | true) | [2..Inf]]
>         core.jobs.CPUBound: [(false | 1)|(0 | true) | [2..Inf]]
>
> Note that it's "0 or true" and "1 or false", not a mistake, i.e. that
> matches our current defaults. You'd set it to "true" to get the "yes, I
> want it parallel" setting.
>
> We'd have these take priority from each other, so "grep.threads" would
> override "core.jobs.IOBound", which in turn would override "core.jobs".
>
> The common case would be that you wouldn't set either "core.jobs" or
> "grep.threads", so we'd default to "core.jobs.IOBound", which we'd set
> to some sensible default.

While I like this concept very much, my worry is that some commands
might not fall nicely into IOBound or CPUBound. If they're a mix of the two
or bound by possibly something else (like network for fetch.parallel? not
sure about this one haven't looked too into it), then what bucket would we
put them under?
