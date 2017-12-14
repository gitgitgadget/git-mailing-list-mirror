Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C90E1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 22:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753968AbdLNWaZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 17:30:25 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:40947 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753794AbdLNWaY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 17:30:24 -0500
Received: by mail-qk0-f173.google.com with SMTP id b123so8232264qkg.7
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lYQbNERg1Yjgqe6iHCtz6O2JneQUqVLeS1e3vPEJHH0=;
        b=IdRoRRF2QWvo1nIsLhv6LFssrNGj6OoPLuzUttU3ikoAlSYKC1oROJp1cNSBjq/fY4
         ja5dTpLH9tO/Us42zKEeG16A6qI9nV7C1qKmIoLrP3hQ+tuiiKh4dhUWEWQUWAwrY8Hd
         +4zUTsh2tCUq0FFktkjxucdUxnJnttL3mJEtDwE7RXD+aP3O9SUhJ03Ks1uSeP6ZYZz7
         JXn51haFaMxDMhPvOj6piXXo6qouJht7ggWnJSG0GNlQF9ykQnp4lVyn71f+l/HX46dp
         +BqRw0L1XE5vgIQKtkZEwDZRpPN+UX0uD/RMq5r9cZTYD7Equn6l6+ueN9LsUxwnWQig
         dEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lYQbNERg1Yjgqe6iHCtz6O2JneQUqVLeS1e3vPEJHH0=;
        b=bpdPyF2ZgDOteRixN99t5Uu3wgybHi60fBi/0mxv9pESg5G6LPvn3RQ27pvfyTffoZ
         2Fxv/ShjmJUi1gg0AvRCs6vQMxrkEatGsj81Dlx/+G+RqzoKvPIicTLHlIb8IRu9igmM
         g8kAJxxVBJ20di0Qz/5562a1D9vBbu/m/RP8+PvyCB4jPfUTngROsjJD6yGNsaQAczP4
         YKWCW7tcBV4NSJKHcqROfT92v85EOJiNBLexTQu2m0REsk1lCYsigwoK5KXsN9Ph9vSu
         ISKSp5PCdE+YbazujBfbX05O/ye4oE5ldnmbWFhQXwCXoZx5r7GiGgjV3TdjBvS0CcVJ
         hiRg==
X-Gm-Message-State: AKGB3mL+Vw/dj/WVpWMrrDe79HJ1tYcyRkTwPUDiN298WeYeWVDDMcDL
        rHMFXG8cycfUJsj2rdMlDD2CH5mW0hxtZomKKbolCA==
X-Google-Smtp-Source: ACJfBov8cJiXzmkYpugrNToUqkLKqxELQdVGYVjWEkZTiI99I6+xCYlft4KNqSM6jsT9JxX0T2bekP+fy3PSJYEYu+Y=
X-Received: by 10.55.26.35 with SMTP id a35mr18235351qka.40.1513290623574;
 Thu, 14 Dec 2017 14:30:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 14 Dec 2017 14:30:22 -0800 (PST)
In-Reply-To: <20171214212234.GC32842@aiede.mtv.corp.google.com>
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
 <20171212012422.123332-1-sbeller@google.com> <20171214212234.GC32842@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Dec 2017 14:30:22 -0800
Message-ID: <CAGZ79kZdUuoM79n09ziG0F7WCWNLpZ2AiFA6fb_qgND1b3_F9A@mail.gmail.com>
Subject: Re: [PATCH] diffcore: add a filter to find a specific blob
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 14, 2017 at 1:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> - what about mode changes?  If the file became executable but the
>   blob content didn't change, does that commit match?

./git log --find-object=$(git rev-parse ba67504f:t/perf/p3400-rebase.sh)

claims it does find the mode change (commit ba67504f is just a mode
change)

> - are copies and renames shown (if I am passing -M -C)?

It restricts the commits shown, not the renamed files. But I assume
you mean it the same way as with mode changes.
I did not find a good commit in gits history to demonstrate, but as
it is orthogonal to the object id restrictions, I would think it works

> Nit, not related to this change: it would be nice to have a long
> option to go along with the short name '-t' --- e.g. --include-trees.

follow up patches welcome. :)

>
> Another nit: s/gitlink entry/submodule commit/, perhaps.  The commit
> object is not a gitlink entry: it is pointed to by a gitlink entry.

Well, what if the user doesn't have a submodule, but uses gitlinks
for other purposes? We do inspect the gitlink, so it is correct IMHO.

> Another documentation idea: it may be nice to point out that this
> is only about the preimage and postimage submodule commit and that
> it doesn't look at the history in between.

That is sensible. One might be tempted to ask: "Which superproject
commit contains a submodule pointer, that has commit $X in the
submodule history?", but this new option is totally not answering this.

>>                                                          The
>> reason why these commits both occur prior to v2.0.0 are evil
>> merges that are not found using this new mechanism.
>
> Would it be worth the doc mentioning that this doesn't look at merges
> unless you use one of the -m/-c/--cc options, or does that go without
> saying?

I assumed it goes without saying, just like the lacking -t could mean
to ignore trees. ;)


>
> [...]
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -500,6 +500,12 @@ information.
>>  --pickaxe-regex::
>>       Treat the <string> given to `-S` as an extended POSIX regular
>>       expression to match.
>> +
>> +--find-object=<object-id>::
>> +     Restrict the output such that one side of the diff
>> +     matches the given object id. The object can be a blob,
>> +     gitlink entry or tree (when `-t` is given).
>
> I like this name --find-object more than --blobfind!  I am not sure it
> quite matches what the user is looking for, though.  We are not
> looking for all occurences of the object; we only care about when the
> object appears (was added or removed) in the diff.

Thanks! Yes, but the 'edges' are so few commits that a further walk
will reveal all you need to know?


>
> Putting it in context, we have:
>
>         pickaxe options:
>         -S: detect changes in occurence count of a string
>         -G: grep lines in diff for a string
>
>         --pickaxe-all:
>                 do not filter the diff when the patch matches pickaxe
>                 conditions.
>
>                 kind of like log --full-diff, but restricted to pickaxe
>                 options.
>         --pickaxe-regex: treat -S argument as a regex, not a string
>
> Is this another kind of pickaxe option?  It feels similar to -S, but
> at an object level instead of a substring level, so in a way it would
> be appealing to call it --pickaxe-object.  Does --pickaxe-all affect
> it like it affects -S and -G?
>
> Another context to put it in is:
>
>         --diff-filter:
>                 limit paths (but not commits?) to those with a change
>                 matching optarg
>
> If I understand correctly, then --diff-filter does not interact with
> --pickaxe-all, or in other words it is a different filtering
> condition.  Is this another kind of diff filter?  In that context, it
> may be appealing to call it something like --object-filter.
>
> --diff-filter is an example where it seems appealing to have a
> --full-diff option to diff-tree that could apply to all filters and
> not just pickaxe.
>
> [... implementation snipped ...]
>
> The implementation looks lovely and I'm especially happy about the
> tests.  Thanks for writing it.
>
> Thoughts?
> Jonathan

Regarding finding a better name, I would want to hear from others,
I am happy with --find-object, though I can see --pickaxe-object
or --object--filter to be a good narrative as well.

Stefan
