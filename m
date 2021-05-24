Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36838C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0AC61405
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhEXUtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhEXUtE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 16:49:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C69C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:47:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i7so25971187ejc.5
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N0Io3RXLEbZz2qxVG/LtV++U+0pUO9C8jPH1AankWQU=;
        b=nDNSg24tHSz91tdieb6KdCyHBa6B6CwMt/PGFqRsHL+fKZWTDgupfGT2oVl5bDe6N+
         k3UjVdbnr9FtyR4lOKbbouEg9Xh0vpA9lHs5LMf6PjU9Ze+h9a59Eih3j+c51atrgZ9P
         Ur8JKoMVk39tBYpMKspoyXAfJ7+m6LSZCphHiUYtgzuinC0I5WE9eogNhIce6susXiHE
         GtHiRhK+sMTQqEC0CsG8iCZrZHshQN/X1nwsrujcFYYKQ4+dJx2+mqOSLXVgzS5AcZpR
         NvbCxV94WBeGrI1FCki+LuCzBsOk12XC7J0QGkdoYig/B+I3MBm6xWC/81zUdvRVw+b0
         Cttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N0Io3RXLEbZz2qxVG/LtV++U+0pUO9C8jPH1AankWQU=;
        b=gZWsgTHy/5Sa+5T1/saH+3wI9zJpNu+RrZFmA0s1+DbtkIa9NTTq+ywfyS+b4+2c+I
         1wmwr+FL7rySqX0sHJ2WO0h4EsZUDJO70yr6iO1V75F5vQW01tAxK3Kyf119VEru6i+A
         LNkIp09osNVoJaxHnNREpIwqvVZTLRdiIC9cazW3rZzQue+XoxeKkPY2qZs8SRvMiu7y
         KxgvEbVMCAf8slwfcDawHcQNlG25/zvBbo2TT63d5sPrJxLejJSH+fuamFelhvnpQuc6
         894lrOJA1eTmYC301u5YXdfaEa1WvYU8s4w0NwFYIw4Y/WZGyZJk+qaoMcvoFQeKOxeS
         Uxdg==
X-Gm-Message-State: AOAM531JS1Q+iLWg7mFLooiRv+pdMjyDOnPDg+QXRFZaR4ivL0WeqR/M
        zAxj1cc9TTgvLvJ5PWtp6V69q+zJyxVQZcXlug8=
X-Google-Smtp-Source: ABdhPJxVn2XjdSFj7BsHTFCEevzHzhTJfZFRBc/lOoYq1RL3I10ceUhFDDn1c/7x5HEZS374IkHAtTOqBPNVOI5JceA=
X-Received: by 2002:a17:906:1c04:: with SMTP id k4mr24538420ejg.197.1621889253304;
 Mon, 24 May 2021 13:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8Tu1Xvc6sJ79n6f9B6TiuKp3akTQcQcuzEe7sG-kVOXAA@mail.gmail.com>
In-Reply-To: <CAOLTT8Tu1Xvc6sJ79n6f9B6TiuKp3akTQcQcuzEe7sG-kVOXAA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 24 May 2021 22:47:22 +0200
Message-ID: <CAP8UFD0sG9La8zpns+9Vzz1FA3XG+OF0+gRTDLU1s16aVY1-Yg@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 1
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 23, 2021 at 12:53 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My first week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-1/

Great!

See some comments below, but you don't need to update your blog post
for each comment. Some are just remarks that might help you.

> -----
>
> ## Week1: Git Adventure Begin
>
> Use Git to submit Git patches to the Git community.
> Does it sound magical? I fell very lucky to be selected

s/fell/feel/

> by the Git community this year and start my Git Adventure
> in GSoC.
>
> I am no stranger to Git usage, and before the start of GSoC,
> I have learned some Git source code content, but I only saw
> the tip of the iceberg of Git source code, there are still many
> things that I need to explore.
>
> ### What happened this week
> - In [[GSoC] Hello
> Git](https://lore.kernel.org/git/CAOLTT8SHE-ok3D+oLNSWFi7KPU=3D=3DVQnTMDm=
C4YxUyNBJKmBD8A@mail.gmail.com/),
> Christian and JiangXin interacted with me.
> - I checked Olga's patch at Christian's prompt and learned a way
> to make `cat-file --batch` use `ref-filter` logic: Use `format_ref_array_=
item()`
> in `batch_object_write()`, this is indeed a good entry point. But
> before implementing this function, we must make `ref-filter`
> support the function of printing the original data of the object
> (as `cat-file --batch` does). I decided to reuse the atom

In your blog post it looks like a space is missing after "object" as
we see "object(as".

> `%(content:raw)` in ref-filter to implement this function.

The above could be understood as saying that `%(content:raw)` already
exists, which is not really true. Maybe you could say something like
"I decided to add the ":raw" option to the existing `%(content)` atom
in ref-filter.c to implement this function."

> ### The difficulties I met
> In [[PATCH] [GSOC] ref-filter: add contents:raw
> atom](https://lore.kernel.org/git/pull.958.git.1621500593126.gitgitgadget=
@gmail.com/),
> I submitted a patch, which support atom `%(content:raw)`

s/support/supports/

or

s/support/adds support for/

> for `ref-filter`.
>
> Unfortunately, this patch has a big problem:
> I ignored the breakage on the test. This led me to

Maybe: s/the breakage on the test/a test breakage/

> discover a bigger problem:
>
> If our references points to a blob or a tree, and  these objects may
> be binary files,

The raw content of a tree indeed contains the binary contents of the
hashes it references, while other objects like commit and tags contain
hashes in the hexadecimal format.

> this means that we cannot use functions related
> to `strcmp()`,`strlen()` or `strbuf_addstr()`. The possible '\0' will
> cause the output to be truncated. We have to think of a way to make
> `ref-filter` can accept the output of these binary content.

The strbuf API has functions to deal with binary content.

> So I searched for all the codes in `ref-filter.c` that buffer might be
> truncated by '\0' and use the appropriate method to replace them.
>
> Just like replacing `strcmp()` with `memcmp()`, We can use `strbuf_add()`
> instead of `strbuf_addstr()`,
> At the same time I also wrote the equivalent `*._quote_buf_with_size()`
> to replace `*._quote_buf()`.

Nice!

> I just submit it to the mailing list right now:
> [[GSOC][RFC] ref-filter: add contents:raw atom]
> (https://lore.kernel.org/git/pull.959.git.1621763612.gitgitgadget@gmail.c=
om/)

By the way a better title for your patch might be "[GSOC][RFC]
ref-filter: add ':raw' option to %(contents) atom"

> I don=E2=80=99t know if this is the right approach at the moment, let
> us slowly wait for the suggestions of mentors and reviewers... ;-)

Thanks,
Christian.
