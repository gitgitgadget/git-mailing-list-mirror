Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AF91F453
	for <e@80x24.org>; Thu, 24 Jan 2019 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAXSzY (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 13:55:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44584 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfAXSzY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 13:55:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so5435202edd.11
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UoisqXJofc88lm96iJTDnhCYMSXr5INhPrC5xDaDjFk=;
        b=ueaKYNsRIMvQ6nb5Ks8blJWMEkvnTldHtioFp9tq5XgtF71Kl1BGiT9KWBqIM4PW/K
         Y7NGmXD8dsphFHK0IU86747Biw9a7cMI2VmnbOpujMFqu52VMZgTcoFw+4vsKXJEsHVS
         Qu+DjAfUFwtHXT72Kqrt6gQ/JGVT8q6v2E/9YOMsa0cGJ/KsqxAqwMYGQxkwWDjtFsye
         mU/+xcWufT32OWm5ZwmjXwseMGm1zbT59LGYcbmOllMpSX7qTvY2b6O+tHU2oewyhu2z
         OAr+jlar9HjgA8JjhhnO3kNsfMJhgRGX4t6fzBDeOHmBtqrYmYzXwHZ1J4NsmxaTvFrH
         7KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UoisqXJofc88lm96iJTDnhCYMSXr5INhPrC5xDaDjFk=;
        b=n7IIY6iw2ij3QNnhEvXDb4LpbddRD2/ytm3V3isTqsVQpNM3de9PoOjKhgBhW89XDn
         0/46HVbpZ9iEJACETp5IFxTIX7RgnKqBoHmO9b703vWE0q2F6uFShBXjggbiQ7qgyN16
         gZcUUdFd0eFXTeuAdgYlUxXjKBoYsKkjrh406a+03WmRIDBEWsGziZYsqKyb5ZC2ldnG
         DbOiYEZbzd0ANIpOwlZlV4qpYUs+6/jWXo3QlYA7/Ohoil9bPL3G69f+StXTjoNEP1TS
         dig837BJ5QGXBUwP3b/JkXIw8BYJ/EHLxg5MQLJh4swmcgrSXRlc49cCxb99tEdq8mUI
         tGIA==
X-Gm-Message-State: AJcUukfYog/zq5OvrwM7Nyyy0Zk0K90/67gIjrbqNnFBHhQzuuioJk8O
        jOL+axUpCXy0HKxb2k+DjJANE4YVfbDsDeq6N5KNQQ==
X-Google-Smtp-Source: ALg8bN5MvDhbc+0A9QpfWNxaGAsBragEY+0xNkwACP1wT1UCY+PudEjOSzWTSshU6l15zXXLzSZpPNZPvm32c5XM6UQ=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr7653224edy.231.1548356121889;
 Thu, 24 Jan 2019 10:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20190124122603.GA10415@sigill.intra.peff.net> <20190124123240.GB11354@sigill.intra.peff.net>
In-Reply-To: <20190124123240.GB11354@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 Jan 2019 10:55:10 -0800
Message-ID: <CAGZ79kbHLvN252v-gNbcpsyGg8pZ9GPBtyZquX50HwhtYep5oA@mail.gmail.com>
Subject: Re: [PATCH 2/6] diff: clear emitted_symbols flag after use
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 4:32 AM Jeff King <peff@peff.net> wrote:
>
> There's an odd bug when "log --color-moved" is used with the combination
> of "--cc --stat -p": the stat for merge commits is erroneously shown
> with the diff of the _next_ commit.
>
> The included test demonstrates the issue. Our history looks something
> like this:
>
>   A-B-M--D
>    \ /
>     C
>
> When we run "git log --cc --stat -p --color-moved" starting at D, we get
> this sequence of events:
>
>   1. The diff for D is using -p, so diff_flush() calls into
>      diff_flush_patch_all_file_pairs(). There we see that o->color_moved
>      is in effect, so we point o->emitted_symbols to a static local
>      struct, causing diff_flush_patch() to queue the symbols instead of
>      actually writing them out.
>
>      We then do our move detection, emit the symbols, and clear the
>      struct. But we leave o->emitted_symbols pointing to our struct.
>
>   2. Next we compute the diff for M. This is a merge, so we use the
>      combined diff code. In find_paths_generic(), we compute the
>      pairwise diff between each commit and its parent. Normally this is
>      done with DIFF_FORMAT_NO_OUTPUT, since we're just looking for
>      intersecting paths. But since "--stat --cc" shows the first-parent
>      stat, and since we're computing that diff anyway, we enable
>      DIFF_FORMAT_DIFFSTAT for the first parent. This outputs the stat
>      information immediately, saving us from running a separate
>      first-parent diff later.
>
>      But where does that output go? Normally it goes directly to stdout,
>      but because o->emitted_symbols is set, we queue it. As a result, we
>      don't actually print the diffstat for the merge commit (yet),

Thanks for your analysis. As always a pleasant read.
I understand and agree with what is written up to here remembering
the code vaguely.

> which
>      is wrong.

I disagree with this sentiment. If we remember to flush the queued output
this is merely an inefficiency due to implementation details, but not wrong.

We could argue that it is wrong to have o->emitted_symbols set, as
we know we don't need it for producing a diffstat only.

>
>   3. Next we compute the diff for C. We're actually showing a patch
>      again, so we end up in diff_flush_patch_all_file_pairs(), but this
>      time we have the queued stat from step 2 waiting in our struct.

Right, that is how the queueing can produce errors. I wonder if the
test that is included in this patch would work on top of
e6e045f803 ("diff.c: buffer all output if asked to", 2017-06-29)
as that commit specifically wanted to make sure these errors
would be caught.

>
>      We add new elements to it for C's diff, and then flush the whole
>      thing. And we see the diffstat from M as part of C's diff, which is
>      wrong.
>
> So triggering the bug really does require the combination of all of
> those options.

Similarly we can trigger bugs by using options that enable buffering
(so far only --color-moved) and options that do not fully buffer and flush.

>
> To fix it, we can simply restore o->emitted_symbols to NULL after
> flushing it, so that it does not affect anything outside of
> diff_flush_patch_all_file_pairs(). This intuitively makes sense, since
> nobody outside of that function is going to bother flushing it, so we
> would not want them to write to it either.

This would also cause the inefficiency I mentioned after (2) to disappear,
as the merge commits diffstat would be just printed to stdout?

>
> In fact, we could take this a step further and turn the local "esm"
> struct into a non-static variable that goes away after the function
> ends. However, since it contains a dynamically sized array, we benefit
> from amortizing the cost of allocations over many calls. So we'll leave
> it as static to retain that benefit.

okay.

>
> But let's push the zero-ing of esm.nr into the conditional for "if
> (o->emitted_symbols)" to make it clear that we do not expect esm to hold
> any values if we did not just try to use it. With the code as it is
> written now, if we did encounter such a case (which I think would be a
> bug), we'd silently leak those values without even bothering to display
> them. With this change, we'd at least eventually show them, and somebody
> would notice.

Wow. Good call.

>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Stefan Beller <sbeller@google.com>
