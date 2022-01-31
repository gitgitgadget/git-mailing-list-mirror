Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DB9C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381037AbiAaRfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381036AbiAaRey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:34:54 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A696FC061741
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:34:44 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id s18so17832608ioa.12
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fbFljXIqwW8G4rkbofn09LeivaVc5HGe7b5Z7CpNHRY=;
        b=EF72s2HyxaeeUdnloYvAFxu15c1p3RwiX1OQ9rA6KJ+8Stk52tjj7fYNHikfnKnnA2
         8BsYFrnzPPx82oc65ZQ2kmuQAEFQfOhBhLB22bYIGogWaXl19nzFsKKT7Y6kPZ+VrgL9
         tZuGnsEQ2LjE+EnohgS7bquDzN3MThp0P1yzfUsG672y19DeHTPZ98ovyj9aJRc+CZyq
         uOrFGgrUJmvBw0hYBF3YmSkvMqiAVnoTRKHmpN8yfugYLHMc5C2y4AO51bJUTI2W54rH
         yFF4nTg52LYqk6nbHcq+dmJWGE/sK52WMgHYnFkxwtrksc8vHK7i0O5JQU2S28XswHcR
         CWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fbFljXIqwW8G4rkbofn09LeivaVc5HGe7b5Z7CpNHRY=;
        b=frcWi2FdaUZq1ArwYnujFcniQBykdaCri5I+cvHIL096pxUDURGMGsocewDcKFhjM4
         BZcvEdosGipvA5lWyrugu67TecyMqjqYa3FMUUCUhrY9bi/WIj3GcbezbtEQwJ8iu0bg
         3EmQjnTDkNfrfamHQ/klXGZlws4PiEDcHZEkwbPVzKoLnIbV8X9I4DOBHvLUVVcHcYYv
         YEFspZH3HokflPk9icnqbBzJln6moYx8RRad/Wt9/3MiwN5cSSBOU793NPBm0AdJ0rDL
         klBdoyYsIHGPchOHy94uY42YiubbQcJeE+32STBcMf/0oA3bgRFaYv8YplhUxSz/IbtM
         vzZg==
X-Gm-Message-State: AOAM530oLL1skZfzosmsit9gelDgjLYYPBRt+KiSYQZnbG2EMWkWDLCN
        Op7m3y1mJqT1oLfQYohwX194Vw==
X-Google-Smtp-Source: ABdhPJxmBWEIqs0TigKBhBxn870YSwm8h/xgc0fvrBftBKUPA/7k2bRgNSSFnwaPCzckO4c/Ex2zjA==
X-Received: by 2002:a05:6638:4105:: with SMTP id ay5mr9893201jab.301.1643650483770;
        Mon, 31 Jan 2022 09:34:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q16sm17690928ion.27.2022.01.31.09.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:34:43 -0800 (PST)
Date:   Mon, 31 Jan 2022 12:34:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git ML <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: BUG: Various "advice.*" config doesn't work
Message-ID: <YfgdsnfQ05ywre8l@nand.local>
References: <220128.867dakcgj0.gmgdl@evledraar.gmail.com>
 <YfgLeVw0rrk7Q5/+@nand.local>
 <xmqq1r0nke71.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r0nke71.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 09:28:02AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > But having something like (in builtin/add.c:add_files()):
> >
> >     if (advice_enabled(ADVICE_ADD_IGNORED_FILES))
> >         advise(_("..."));
> >
> > feels like it opens the door to call advise() by default if we happened
> > to forget to read the configuration.
>
> True.
>
> > I think that is a good candidate to
> > be replaced with advice_if_enabled().
>
> Meaning advice_enabled() will lazily load the configuration?  If so,
> then what you saw in builtin/add.c::add_files() would automatically
> become just as safe as advice_if_enabled(), no?

The change I was wondering aloud about was having advice_enabled()
lazily load the configuration.

So what is written in add_files() above would become safe (if it wasn't
already), and could easily be replaced with advise_if_enabled().

> > I'm not sure if that is true in general, though. Take a look at this
> > example (from branch.c:create_branch()):
> >
> >     if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
> >         error(_(upstream_missing), start_name);
> >         advise(_(upstream_advice));
> >         exit(1);
> >     }
> >     die(_(upstream_missing), start_name);
> >
> > This also makes it possible to call advise() when we shouldn't have. But
> > how should we rewrite this code? Wanting to either error() (and then
> > call exit(1)) or die() based on whether or not we're going to print the
> > advice makes it tricky.
>
> I am puzzled why you think the above "check, do things, give a
> piece of advice, and do even more things" needs to be rewritten.
>
> Everything you are showing above becomes a problem only when
> advice_enabled() does not work reliably, due to a bug that fails to
> read the configuration.

What I'm more or less trying to point out is that an unguarded advise()
function defeats the purpose of the advice API, which should exist to
avoid mistakes like these (where advice is printed to the user when they
have already opted out of that advice).

I was thinking that it would be nice to have advise() take an
advice_type enum and have it behave like advise_if_enabled(). But there
are spots that you really do want to print advice unconditionally. And
that spot in create_branch() is one of those where it isn't clear that
the change I'm proposing works.

(BTW, I would definitely disagree that I'm saying anything "needs" to be
rewritten here. This is all just thinking aloud about what the advice
API can and should help callers with.)

> > Maybe, though I still think BUG() is a bit extreme, and we could
> > accomplish the same by having the advice API just read the config if it
> > hasn't done so already before emitting advice.
>
> Calling things like git_config(git_default_config) with side-effects
> on other global variables are definitely a no-no, but as long as it
> reacts to configuration variables only under advice.* namespace,
> that might be OK.

Yes, I definitely agree we should absolutely not be calling
git_default_config() as part of "lazily load the advice.*
configuration".

> Thanks.

Thanks,
Taylor
