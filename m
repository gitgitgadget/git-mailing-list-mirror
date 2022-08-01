Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E779C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 22:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiHAWYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiHAWYs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 18:24:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513E845074
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 15:24:45 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c20-20020a9d4814000000b0061cecd22af4so9124530otf.12
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=duOQRVJ28ydB4Q6qSBp2+2r1Lhlparqvm2vV7juFKdU=;
        b=jIbHq9XrWETeBdGBVl37GoV1VNqcQmk2o8coFenI14JhOqOcx0BX9MUHTXy2dhQ/Ey
         BWMxdJIKVIknVcd/5csZIlQcIaNtSqzWzYzbncqsA3qVuF+1ww9GSNeavMyJgtfoKgUj
         aHIe/VGI4XtXqTeOM1RWhnGddwKchFy+ahMVZKuNoGGkN6RtC87o8IAXl7kN8z0HT+Ja
         2mn0YVlZetoGVQrBHtfub/yFPI8CX0UcY4/B2/lPbE4/JGQwfolC5ghbPzNgUaslVRHB
         DeV04VKsyXWdhaLy18TmSx3C/xK4ggb7WWaM6Dm2U9ZB9I2F3+zgNv71eEZVc2xh9OyQ
         8Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=duOQRVJ28ydB4Q6qSBp2+2r1Lhlparqvm2vV7juFKdU=;
        b=07Sz4C3EkUDMxSg+VD/TgFpUHlDMR7/cnNYaXiKnnftVPLcRzFu045Nr7kpFNMJBIE
         gyfgZPCZHKHCWd+YLM4h3JDptxb/tRrDST3R54+2IpvZXZiT9bDQUxW5PYV9UO+s+0T0
         3e8aOkZsWjwe1y/tj9CUhnWRsMMZKFOe/+VckYFo7oul6V6bo371wC6YWeOnad7PUiJb
         wQYTsdzjPdcJqhF9VsFKxuVglVQI4t1DCzv5DBsz8yyKWQ6EqBh8+H2mD/kCftA/4zO8
         hohF2TUNbs3zpuaijCSNt/1MvKKAD0p1vl/AHX8AQhwfa0d5ZfdHBgbCWGyysalhWRma
         sAnQ==
X-Gm-Message-State: AJIora+DTK90RWWsfeSktks9nCHAwor7oU3pLzM+WZmtqXd1oiCHijIu
        k9gXCtHpDcyDRltpNapDAo5zcZovdAGFuYkwlyJ+lw==
X-Google-Smtp-Source: AGRyM1uaiZHQfYe6uIdnZwSSO33+RzCvHKDRd0mogI5EPzaYrd4JqkM+294F+SwzK75syiZVOjH/9L1JiZLv7nwpa0A=
X-Received: by 2002:a9d:22a1:0:b0:61e:e511:5674 with SMTP id
 y30-20020a9d22a1000000b0061ee5115674mr4892861ota.56.1659392684518; Mon, 01
 Aug 2022 15:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220726210020.3397249-1-calvinwan@google.com>
 <20220728211221.2913928-1-calvinwan@google.com> <CABPp-BE9hdzn_8fqSa-JYXS14xbXDEvKi=yupvWDFAUnALhD9A@mail.gmail.com>
In-Reply-To: <CABPp-BE9hdzn_8fqSa-JYXS14xbXDEvKi=yupvWDFAUnALhD9A@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 1 Aug 2022 15:24:33 -0700
Message-ID: <CAFySSZBdTvxn8QjOujvu2orkf_tA4Y1nufdjaNJHLsUTWsoo-A@mail.gmail.com>
Subject: Re: [PATCH v7] submodule merge: update conflict error message
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > 4. Submodule not checked out: Still returns early, but added a
> >    NEEDSWORK bit since current error message does not reflect the
> >    correct resolution
>
> s/does not reflect the correct resolution/also deserves a more
> detailed explanation of how to resolve/ ?

ack

> Thanks.  Including a range-diff in the cover letter would be really
> helpful, for future reference.

will do

> Um, repo_submodule_init() returns 0 on success, non-zero upon failure.
> So !sub_initialized means "submodule IS initialized", though it
> appears to read to mean the opposite.  Can you consider renaming your
> variable (maybe just to "sub_not_initialized")?

ack


> Technically, we just did generate an error message ("Failed to merge
> submodule %s (not checked out)").
>
> Maybe replace "immediately rather than generating an error message"
> with "immediately.  It would be better to "goto cleanup" here, after
> setting some flag requesting a more detailed message be saved for
> print_submodule_conflict_suggetion()".  Or something like that.

Sounds like a better place to put the NEEDSWORK bit.

>
> >                 return 0;
> >         }
> >
> > +       if (is_null_oid(o)) {
> > +               path_msg(opt, CONFLICT_SUBMODULE_NULL_MERGE_BASE, 0,
> > +                        path, NULL, NULL, NULL,
> > +                        _("Failed to merge submodule %s (no merge base)"),
> > +                        path);
> > +               goto cleanup;
> > +       }
>
> Does this need to be moved after initializing the submodule?  I
> thought that was the point of introducing the sub_initialized
> variable, and we're clearly not going to use it, so it would seem to
> make more sense to not initialize it for this case.

The submodule needs to be initialized to generate part of the error
message. See the following in cleanup:

repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV)

> Yuck.  I'm not a translator, so maybe what you are doing is preferred.
> But wouldn't translators find it annoying to have to translate " - %s"
> and "  %s" in all these places (and wouldn't there need to be a
> TRANSLATORS comment before each and every one)?

As per Avar's suggestion, I made a helper function so translators
only have to translate " - %s" and "  %s" once. This change does
end up lining up the `git add ...` command, but I think that's fine

- come back to superproject and run:

   git add sub3 sub2 sub

   to record the above merge or update

> I also find the big block of code somewhat painful to read.  Could we
> instead do something like (note, I have both a tmp and tmp2):
>
>     strbuf_add_separated_string_list(&tmp2, " ", csub);
>
>     for_each_string_list_item(item, csub) {
>         const char *abbrev= item->util;
>         /*
>          * TRANSLATORS: This is a line of advice to resolve a merge conflict
>          * in a submodule. The second argument is the abbreviated id of the
>          * commit that needs to be merged.
>          * E.g. - go to submodule (sub), and either merge commit abc1234
>          */
>         strbuf_addf(&tmp, _(" - go to submodule %s, and either merge
> commit %s\n"
>                             "   or update to an existing commit which
> has merged those changes\n"),
>                             item->string, abbrev);
>     }
>
>     strbuf_addf(&msg,
>                 _("Recursive merging with submodules currently only
> supports trivial cases.\n"
>                   "Please manually handle the merging of each
> conflicted submodule.\n"
>                   "This can be accomplished with the following steps:\n"
>                   "%s"
>                   " - come back to superproject and run:\n\n"
>                   "      git add %s\n\n"
>                   "   to record the above merge or update\n"
>                   " - resolve any other conflicts in the superproject\n"
>                   " - commit the resulting index in the superproject\n"),
>                   tmp.buf, tmp2.buf);
>
> This will give translators precisely two messages to translate (and we
> can't drop it to one since one of the two is repeated a variable
> number of times), and provide more built-in context about how to
> translate since the whole message is involved.  If one of the messages
> translates into something especially long, they can even add line
> breaks and reflow the paragraph in ways that make sense for them,
> which your current version just doesn't permit.

I think Avar's suggestion makes translating the formatting easier than
your suggestion, at the cost of having a big block of code to setup it
all up.
