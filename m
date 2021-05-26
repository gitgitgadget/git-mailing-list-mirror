Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD1C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 09:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF5E61432
	for <git@archiver.kernel.org>; Wed, 26 May 2021 09:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhEZJYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 05:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhEZJYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 05:24:08 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05865C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 02:22:37 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e10so279211ilu.11
        for <git@vger.kernel.org>; Wed, 26 May 2021 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KgBYQcSMzr+5HzznHNt+W9N9HwxhCUk6fokN0HYJO4o=;
        b=njKsqdHkggwmnv8LLOvqfczGSLcw135104Wv31nVdEcGGf0f1gVsCQPt2hwVOwC5sg
         SueHfBM5FrdyU+ONx0dx4p43uJBuZKKvfEjOKa88GijRi/35jro+5c0Y7PMRpN+OEyzc
         xsjZTjpdMpmiZ0JbcrYKDHfD8bHzkh+wQfkNlYg7YigLGC+cHDv3JMeCs7jINMglHFqo
         l6/hlLw46NWBSQYvQ5dXdXBMEftKTnNolt6fCah415ZAv29CQVCpkFfuy3xZv4NFn7sI
         exXFAKoIxyOMEBwLT/q1kddBQMh0+EhulxHbhbSvC/S8syg0qVJxSISlTcwW4QvRyFHX
         LLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KgBYQcSMzr+5HzznHNt+W9N9HwxhCUk6fokN0HYJO4o=;
        b=hl30pov+70UdCBM8xSZkwIctvbv5vZvEpHiLe+Easktax189ZMQw04CL1D+p8kTo5M
         da+qfnwxDBgIkcNyxX5pMrS3XCiDw9ysOofhyGgFhGwuIY0hdhJ3v1XV7iihEvIS9cCe
         qRO3nc045JzZQ0Q6fcDEV+Dp+cBmp4/U6Cb4TfKf7+mypJxcKkD5Ko0+haUre5HscdTc
         CpkUC9CCLQCsK9W3E7GiNE9nVubVETFOjIpWC2pVpJzZxuygnBGkeLQVtaIPwA7mTJb7
         aVlvgn2oGoJGL/PQyLhw+beLiFIeIxLLLoayr0HlFfTRo4UzDHxGzsOBWtTVO8IU/gh5
         YBPg==
X-Gm-Message-State: AOAM532Pe/m3PmWcjtJtRaGnugRFxa+OlDOfbDPlaoF29ubj7POx6+v6
        fqc0VnXgJ1Hy50GKmtDarMwBjElsu8053FXggYc=
X-Google-Smtp-Source: ABdhPJxIfXACBPTkib1/Ypi7iM341QxxxsnZtY9iayWBmTQ8asovoKyuFYvtZQvSLPg/NhDwuDzEtRSz/ty7S2Zo+MQ=
X-Received: by 2002:a92:c56a:: with SMTP id b10mr23163135ilj.17.1622020956330;
 Wed, 26 May 2021 02:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8Tu1Xvc6sJ79n6f9B6TiuKp3akTQcQcuzEe7sG-kVOXAA@mail.gmail.com>
 <CAP8UFD0sG9La8zpns+9Vzz1FA3XG+OF0+gRTDLU1s16aVY1-Yg@mail.gmail.com>
In-Reply-To: <CAP8UFD0sG9La8zpns+9Vzz1FA3XG+OF0+gRTDLU1s16aVY1-Yg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 26 May 2021 17:22:21 +0800
Message-ID: <CAOLTT8R1j5m7XHHGrf9SoAEBR85yaT+tNJGzS+Pg1pcSm0csdA@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 1
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8825=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:47=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Sun, May 23, 2021 at 12:53 PM ZheNing Hu <adlternative@gmail.com> wrot=
e:
> >
> > My first week blog finished:
> > The web version is here:
> > https://adlternative.github.io/GSOC-Git-Blog-1/
>
> Great!
>
> See some comments below, but you don't need to update your blog post
> for each comment. Some are just remarks that might help you.
>
> > -----
> >
> > ## Week1: Git Adventure Begin
> >
> > Use Git to submit Git patches to the Git community.
> > Does it sound magical? I fell very lucky to be selected
>
> s/fell/feel/
>
> > by the Git community this year and start my Git Adventure
> > in GSoC.
> >
> > I am no stranger to Git usage, and before the start of GSoC,
> > I have learned some Git source code content, but I only saw
> > the tip of the iceberg of Git source code, there are still many
> > things that I need to explore.
> >
> > ### What happened this week
> > - In [[GSoC] Hello
> > Git](https://lore.kernel.org/git/CAOLTT8SHE-ok3D+oLNSWFi7KPU=3D=3DVQnTM=
DmC4YxUyNBJKmBD8A@mail.gmail.com/),
> > Christian and JiangXin interacted with me.
> > - I checked Olga's patch at Christian's prompt and learned a way
> > to make `cat-file --batch` use `ref-filter` logic: Use `format_ref_arra=
y_item()`
> > in `batch_object_write()`, this is indeed a good entry point. But
> > before implementing this function, we must make `ref-filter`
> > support the function of printing the original data of the object
> > (as `cat-file --batch` does). I decided to reuse the atom
>
> In your blog post it looks like a space is missing after "object" as
> we see "object(as".
>
> > `%(content:raw)` in ref-filter to implement this function.
>
> The above could be understood as saying that `%(content:raw)` already
> exists, which is not really true. Maybe you could say something like
> "I decided to add the ":raw" option to the existing `%(content)` atom
> in ref-filter.c to implement this function."
>
> > ### The difficulties I met
> > In [[PATCH] [GSOC] ref-filter: add contents:raw
> > atom](https://lore.kernel.org/git/pull.958.git.1621500593126.gitgitgadg=
et@gmail.com/),
> > I submitted a patch, which support atom `%(content:raw)`
>
> s/support/supports/
>
> or
>
> s/support/adds support for/
>
> > for `ref-filter`.
> >
> > Unfortunately, this patch has a big problem:
> > I ignored the breakage on the test. This led me to
>
> Maybe: s/the breakage on the test/a test breakage/
>

Thanks for these grammatical corrections. I will apply them
to my blog (very easy)

> > discover a bigger problem:
> >
> > If our references points to a blob or a tree, and  these objects may
> > be binary files,
>
> The raw content of a tree indeed contains the binary contents of the
> hashes it references, while other objects like commit and tags contain
> hashes in the hexadecimal format.
>
> > this means that we cannot use functions related
> > to `strcmp()`,`strlen()` or `strbuf_addstr()`. The possible '\0' will
> > cause the output to be truncated. We have to think of a way to make
> > `ref-filter` can accept the output of these binary content.
>
> The strbuf API has functions to deal with binary content.
>

Yes it is.

> > So I searched for all the codes in `ref-filter.c` that buffer might be
> > truncated by '\0' and use the appropriate method to replace them.
> >
> > Just like replacing `strcmp()` with `memcmp()`, We can use `strbuf_add(=
)`
> > instead of `strbuf_addstr()`,
> > At the same time I also wrote the equivalent `*._quote_buf_with_size()`
> > to replace `*._quote_buf()`.
>
> Nice!
>
> > I just submit it to the mailing list right now:
> > [[GSOC][RFC] ref-filter: add contents:raw atom]
> > (https://lore.kernel.org/git/pull.959.git.1621763612.gitgitgadget@gmail=
.com/)
>
> By the way a better title for your patch might be "[GSOC][RFC]
> ref-filter: add ':raw' option to %(contents) atom"
>

Good suggestion.

> > I don=E2=80=99t know if this is the right approach at the moment, let
> > us slowly wait for the suggestions of mentors and reviewers... ;-)
>
> Thanks,
> Christian.

Thanks.
--
ZheNing Hu
