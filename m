Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2AB520988
	for <e@80x24.org>; Tue, 18 Oct 2016 23:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934123AbcJRXwz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 19:52:55 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:32953 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934102AbcJRXwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 19:52:53 -0400
Received: by mail-qt0-f178.google.com with SMTP id s49so6216161qta.0
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dmmwZ/jDwOwOI2IPn0deWk13FMrL14EG3iCBkAPdEcM=;
        b=XBIbOEfziBifOU6tblGzsOZ242MtK3KrI94et23OOCEWvr7PmYdYhHVPsjvrSyM7cY
         oBPSn5bozMr/5o9FAjP8tSoYWF/1bb8TU9FuBh1tDvskdQigzZRTXq8CHP3rh/nDsLUN
         29AzxqB9A/6vk1mjJM1iTyMBnPbc0hS7WLslL9hcLRAxQ+1QwYQPtMmL5IVO8u5GfZsT
         nalzreC7qVJOeBCRlAv8mg/x+rdZKISRFuXQRuoLNxs7To49j+IV+FeaDjzTM5KCX8aM
         US/3rAFa7Ohf+xOEdp+b93t0hnTAR8dP/L/S7obqKRXxJ84amwtwa3iwfMbgKuW6uL64
         q4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dmmwZ/jDwOwOI2IPn0deWk13FMrL14EG3iCBkAPdEcM=;
        b=OkepyAX6JEYRFYVZ2WTe+r+JUzePAydiMmoK6fkoIXhiHHAyXhFjH895BzIXKAV5fM
         fRAdf4VJg4sMeBAwV6hkMQDFczXgynmqh0QN2y9VAD4KLEM/r9L1q4r3kIbXqu3zIM0E
         8a9AfqBs59m65olRIx4RmwNJKcMe5Bo/jd2xRWr+e9sgnP21ph2Dwi49CbkbnJ66JAhL
         iH+SZEE73y1sUN6FWW2s59M3ldjKQplwOfjvjDs4lyUHfKHweNWcxxeliaMBkbm57Xob
         qW7efRGBTVZAK8Ev5zCr31K/pFzTrUroYI4kyq20FZLBSV7jbLWkSJTzG8rUX/DpFfHc
         pCqQ==
X-Gm-Message-State: AA6/9Rlpk1u/SZ0YxdcxsmoLue2PUWRoL4GIDvR8VO6DEQMvWrG4gqCfBT/cdh5jfZLyzJAYjg9x5/HDvxH7jE80
X-Received: by 10.200.44.162 with SMTP id 31mr3477938qtw.1.1476834772419; Tue,
 18 Oct 2016 16:52:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 18 Oct 2016 16:52:51 -0700 (PDT)
In-Reply-To: <xmqq8ttr0wny.fsf@gitster.mtv.corp.google.com>
References: <20161012224109.23410-1-sbeller@google.com> <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com>
 <xmqq8ttr0wny.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Oct 2016 16:52:51 -0700
Message-ID: <CAGZ79kbS4mP7sVTCM+QJXTwKsgZ40xvVDng-F3igZnJWLYek0A@mail.gmail.com>
Subject: Re: [PATCHv3] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 8:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> *1* Would we need a wrapping struct around the array of results?
>
> By the way, I do see a merit on the "check" side (tl;dr: but I do
> not think "result" needs it, hence I do not see the need for the
> "ugly" variants).

So we'd rather go with const char **result instead of our own new struct there.
Ok, got it.

>
> Take "archive" for example.  For each path, it wants to see the
> attribute "export-ignore" to decide if it is to be omitted.  In
> addition, the usual set of attributes used to smudge blobs into the
> working tree representation are inspected by the convert.c API as
> part of its implementation of convert_to_working_tree().  This
> program has at least two sets of <"check", "result"> that are used
> by two git_check_attr() callsites that are unaware of each other.
>
> One of the optimizations we discussed is to trim down the attr-stack
> (which caches the attributes read from .gitattributes files that are
> in effect for the "last" directory that has the path for which
> attrbiutes are queried for) by reading/keeping only the entries that
> affect the attributes the caller is interested in.  But when there
> are multiple callsites that are interested in different sets of
> attributes, we obviously cannot do such an optimization without
> taking too much cache-invalidation hit.  Because these callsites are
> not unaware of each other, I do not think we can say "keep the
> entries that affects the union of all active callsites" very easily,
> even if it were possible.
>
> But we could tie this cache to "check", which keeps a constant
> subset of attributes that the caller is interested in (i.e. each
> callsite would keep its own cache that is useful for its query).
> While we are single-threaded, "struct git_attr_check" being a
> wrapping struct around the array of "what attributes are of
> interest?" is a good place to add that per-check attr-stack cache.
> When we go multi-threaded, the attr-stack cache must become
> per-thread, and needs to be moved to per-thread storage, and such a
> per-thread storage would have multiple attr-stack, one per "check"
> instance (i.e. looking up the attr-stack may have to say "who/what
> thread am I?" to first go to the thread-local storage for the
> current thread, where a table of pointers to attr-stacks is kept and
> from there, index into that table to find the attr-stack that
> corresponds to the particular "check").  We could use the address of
> "check" as the key into this table, but "struct git_attr_check" that
> wraps the array gives us another option to allocate a small
> consecutive integer every time initl() creates a new "check" and use
> it as the index into that attr-stack table, as that integer index
> can be in the struct that wraps the array of wanted attributes.
>
>         Note. none of the above is a suggestion to do the attr
>         caching the way exactly described.  The above is primarily
>         to illustrate how a wrapping struct may give us future
>         flexibility without affecting a single line of code in the
>         user of API.
>
> It may turn out that we do not need to have anything other than the
> array of wanted attributes in the "check" struct, but unlike
> "result", "check" is shared across threads, and do not have to live
> directly on the stack, so we can prepare for flexibility.
>
> I do not foresee a similar need for wrapping struct for "result",
> and given that we do want to keep the option of having them directly
> on the stack, I am inclined to say we shouldn't introduce one.
>
> If we were still to do the wrapping for result, I would say that
> basing it around the FLEX_ARRAY idiom, i.e.
>
>>         struct git_attr_result {
>>                 int num_slots;
>>                 const char *value[FLEX_ARRAY];
>>         };
>
> is a horrible idea.  It would be less horrible if it were
>
>         struct git_attr_result {
>                 int num_slots;
>                 const char **value;
>         };

So const char** but with an additional number of slots, all we do
would be to compare this number of slots to the checks number of slots and
die("BUG:..."),  which is just a burden and no help.

>
> then make the API user write via a convenience macro something like
> this
>
>         const char *result_values[NUM_ATTRS_OF_INTEREST];
>         struct git_attr_result result = {
>                 ARRAY_SIZE(result_values), &result_values
>         };
>
> instead.  That way, at least the side that implements git_check_attr()
> would not have to be type-unsafe like the example of ugliness in the
> message I am following-up on.

Ok I will reroll with the const char** instead of the macro stuff that
I came up with,
(that would be type safe though uglier than the pure variant).
