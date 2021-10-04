Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B4DC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E077611C0
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhJDOxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbhJDOxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:53:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C5C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 07:51:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id bm13so15831991edb.8
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=35Z2tu/PlTiqb8oJ22f/8D1Nif0XKubhnGp/6x/6ZCA=;
        b=Fxp9PDUHXN3huidLlJl4OI/DfuzW+fFMdJ/9neI1ctD8Qb8cVXMREzWO0JkiTiFIvG
         wjw3b6qdKLXq99SMjAFMUbea4bZIGSy/GjlVTmhcAIqFhxUauahWUgPvZonU1GOYg9sZ
         kXU84+A6Ka3nUz1HdUVFwLOnnRY7bFcfHF8thOMJzeIw1QHKOIehvvHkxq44GNgcE7JJ
         iOoPuK0LW4Yg/5pAzVsZ5nJawJIoU/ZhwYmvG60SAG+eX1g8lVma+AgPKNeuGFAheNSW
         EQazMYsA3YTQ8kYQuUpkwoOOVnwgZ8pLfjCX8tv1pflyDYtaiXWoP6CBXTXd15GuCoQX
         943A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=35Z2tu/PlTiqb8oJ22f/8D1Nif0XKubhnGp/6x/6ZCA=;
        b=poy+p6lu/08Oi9mhZKuw1RE4KiwD8fGq+d5al2Yj1uhXIXSyX/NgF3Kj1gWhFxz90N
         y+lSMcecF5jv9RdYH28nJWH4x1ingzjYcCgnn8e7n9rTfeG4FbFPVytIJJbUuQxbYjek
         u2wT+aR4dche8pXanvmvnuBOAXEErDj7qSx2V4JKaaeK0Lq0lrDuj07WnfmSaSowbhRH
         Fazey9GJcI4eIEvAQ+KMqze9znZ3+6t8FDmgpHKXqzQbixHiHl/su8YtI/0Imx3pD2Rz
         UhyiNt1jikvz+F/Sl9avO/PvSHIwuFBKlMVvH/ZtKRLt1859fwvPhMYcBwEZkYhmOUCY
         yPxg==
X-Gm-Message-State: AOAM533c4XBrasGB7DLvZAo3Hld+fqY2c1TLB5Y8velSYYUONHsJ/OZq
        IVXz7MHlCUjt2G1L+zveKl3nslxrPnrNXg==
X-Google-Smtp-Source: ABdhPJz6PUKUtWgi/ByFKcQPefPnGUW46xZKPWEQHJWFUiE8hTKEOwpMx4DRf2pVfIuClgDuwKaMAw==
X-Received: by 2002:a17:906:9501:: with SMTP id u1mr17655076ejx.496.1633358991681;
        Mon, 04 Oct 2021 07:49:51 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q9sm6658905ejf.70.2021.10.04.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:49:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/10] merge-recursive.c: call a new
 unpack_trees_options_init() function
Date:   Mon, 04 Oct 2021 16:41:00 +0200
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-02.10-050399cbfbf-20211004T002226Z-avarab@gmail.com>
 <CABPp-BFYxWXZQXvDSrM1Y1ZaQ1d2TENQDvx1cyawvrDO1OvExA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BFYxWXZQXvDSrM1Y1ZaQ1d2TENQDvx1cyawvrDO1OvExA@mail.gmail.com>
Message-ID: <87y278n8tt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Elijah Newren wrote:

> On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> In the preceding commit we introduced a new UNPACK_TREES_OPTIONS_INIT
>> macro, but "merge-recursive.c" could not be converted to it since
>> it (re-)initializes a "struct unpack_trees_options" on the heap.
>>
>> In order to convert use the macro as the source of truth for
>> initialization we need to not only convert the initialization in
>> unpack_trees_start(), but also call the new
>> unpack_trees_options_init() just after the CALLOC_ARRAY() in
>> merge_start().
>
> Um...why?

Replied below.

>> When we call merge_trees() we'll call merge_start() followed by
>> merge_trees_internal(), and it will call unpack_trees_start() before
>> it does much of anything. So it's covered by an initialization in
>> unpack_trees_start().
>>
>> But when merge_recursive() is called it will call merge_start()
>> followed by merge_recursive_internal(), which won't call
>> unpack_trees_start() until its own call call to
>> merge_trees_internal(), but in the meantime it might end up using that
>> calloc'd "struct unpack_trees_options".
>
> Nothing in merge-recursive.c usings unpack_opts before
> unpack_trees_start() or after unpack_trees_finish().  If anyone
> attempts to use it elsewhere, that would itself be a bug.  So, I'd
> replace the above three paragraphs with:
>
> "Change the initialization of opt->priv_unpack_opts from using memset
> to 0, with unpack_trees_options_init()."
>
> or something like that, and then drop your change to merge_start().

Sure, I'll defer to you about being confident about that. I didn't want
to leave a copy if it hanging without the proper initialization in case
there were new callers.

>> This was OK before, as setup_unpack_trees_porcelain() would call
>> strvec_init(), and our "struct dir_struct" in turn is OK with being
>> NULL'd. Let's convert the former to macro initialization, we'll deal
>> with the latter in a subsequent commit.
>
> This is quite confusing; it's really hard to understand how this
> relates to the rest of the commit message.  I have to read the code to
> see what you're doing, and then write my own commit message in my head
> because the wording in this paragraph still doesn't parse.
>
> I'd make the change strvec_init/STRVEC_INIT changes be a separate
> patch.  I suspect it'll be easier to write the commit message for it
> as a standalone commit as well.

Sure, FWIW I had it split up locally, and figured it would be easier to
explain if the API usage change came with the initialization change that
made it possible.

>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  merge-recursive.c | 3 ++-
>>  unpack-trees.c    | 8 ++++++--
>>  unpack-trees.h    | 5 ++++-
>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index e594d4c3fa1..d24a4903f1d 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -405,7 +405,7 @@ static int unpack_trees_start(struct merge_options *=
opt,
>>         struct tree_desc t[3];
>>         struct index_state tmp_index =3D { NULL };
>>
>> -       memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts=
));
>> +       unpack_trees_options_init(&opt->priv->unpack_opts);
>>         if (opt->priv->call_depth)
>>                 opt->priv->unpack_opts.index_only =3D 1;
>>         else
>> @@ -3704,6 +3704,7 @@ static int merge_start(struct merge_options *opt, =
struct tree *head)
>>
>>         CALLOC_ARRAY(opt->priv, 1);
>>         string_list_init_dup(&opt->priv->df_conflict_file_set);
>> +       unpack_trees_options_init(&opt->priv->unpack_opts);
>
> Drop this hunk.

Speaking of splitting things up in more understandable ways: If we're
going to hard rely on the interaction between merge_start() and
unpack_trees_start() wouldn't it make sense to lead with a change that
dropped that memset, which if this invariant holds is also redundant to
the CALLOC() of opt->priv in merge_start() in the pre-image.
