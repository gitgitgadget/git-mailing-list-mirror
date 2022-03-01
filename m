Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EC7C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 03:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiCADKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 22:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiCADKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 22:10:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A433DDD7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 19:09:30 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b9so24689543lfv.7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 19:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kXBeUp8i4aS7csZqmwkWFXeTYtHV7M7K8wg5jItLqE0=;
        b=HwS2JXcgtHVTc9N4CSB1oVfjC/DAQREWlRJMrKa4xti90NLz+kwS/t4Py03W+UgPKn
         ue0D3xS3v8FodK2H5F58GWfD+jXbizDpc0wrqF3nnsZmOpNFcgE8gILPfoASMrPTVx5U
         mHcYPtApiG2Ves1auKRloOqgyMYkVVGBputRLqqwJGnzgosc1bN3BPdMueFFE4Nlx+7+
         8o4wy/4tiYRgWvNAxU0tZ7Dfq1ZXs0VxoGs4Eoc2u8G7VbZtV60w0hGklTbrmmTcnH2w
         0yxggA1g0c57kLj8noWUXa+ZJEUCssfi6bvrSc6x2BXesDbakLw6MlsvQQO8OpGaNXPg
         U57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kXBeUp8i4aS7csZqmwkWFXeTYtHV7M7K8wg5jItLqE0=;
        b=Tt8IBc0g6u23oddTQUNSRpMv+LB+LkYK4WjoorjBhvphvUrdFK0qKBfs2XzJXsKahj
         OqrZPiCtEDT2/2D3plJDWiVacAoQNfwuOe156wZHAq7Ra3FHZNsptbllRpWUN7c7gi1R
         dK4yxO6t6JCrCrG6VEmXkc4PEBAePj+nC18hrrfOwiUszZ9M0nitr88dJGhwVx/V0sbl
         cRfaPXbe20WI8qHI5KAmIfo+CcVk3r02e1A2HneKFHacSyd7dS28Wswx1k0ZAvwdlMRH
         3Es4QqjNmj7fDYJGmxbVTwxf6Escqpg0mnkbgLVyBPMATzP4a1+IAjyJpvl8nhppXOjL
         oV3A==
X-Gm-Message-State: AOAM532jx24Tlt+abeu5PHM8WBf6tpic6Kb2NaRXXf0bda/p5ixuJwEn
        rYwETYlpqadVEfG4idd/ed9EfutBDm8n9LGXxCk=
X-Google-Smtp-Source: ABdhPJy6qyYNvyXtg5WH4U6hDU57PXQcy6IL6rx60Tco+Xyps3rmL6kh3lWmgnQdyyYLYDAq/CfDL88KXqlKJ0VFVzU=
X-Received: by 2002:a05:6512:402a:b0:431:f517:17f1 with SMTP id
 br42-20020a056512402a00b00431f51717f1mr14254305lfb.567.1646104168685; Mon, 28
 Feb 2022 19:09:28 -0800 (PST)
MIME-Version: 1.0
References: <patch-v3-03.12-92fd020d199-20220204T234435Z-avarab@gmail.com>
 <20220217045943.30223-1-worldhello.net@gmail.com> <220217.86mtipj14m.gmgdl@evledraar.gmail.com>
In-Reply-To: <220217.86mtipj14m.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 1 Mar 2022 11:09:16 +0800
Message-ID: <CANYiYbFZN=mvcxRT4Cf4Gzao89KR2UjMJXnJM63S2zAtbD32Jg@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] object-file API: add a format_object_header() function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 5:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Feb 17 2022, Jiang Xin wrote:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > Type casting can be avoid if we use "void *" as the first parameter of
> > "format_object_header", and do type casting inside the helper function.
> > [...]
> > The return value of `type_name(type)` has not been checked for the orig=
inal
> > implement, how about write a online inline-function in a header file li=
ke this:
> >
> >       static inline int format_object_header(void *str, size_t size,
> >                                              const char *type_name,
> >                                              size_t objsize)
> >       {
> >               return xsnprintf((char *)str, size, "%s %"PRIuMAX, type_n=
ame,
> >                                (uintmax_t)objsize) + 1;
> >       }
>
> I don't think the casting in the callers is bad, in that for the callers
> that do use "char *" we get the compiler to help us with type checking.
>
> Using a void * is something we really reserve only for callback-type
> values, because it mens that now nobody gets any type checking.
>
> I think if we wanted to avoid the casts it would make more sense to add
> a trivial ucformat_object_header() wrapper or whatever, which would take
> "unsigned chan *" and do the cast, or just tweak the relevant calling
> code to change the type (IIRC some of it used unsigned v.s. signed for
> no particular reason).
>
> But I think just leaving this part as it is is better here...
>
> > [...]
> >> +    if (!name)
> >> +            BUG("could not get a type name for 'enum object_type' val=
ue %d", type);
> >> +
> >
> > The return value of `type_name(type)` has not been checked for the orig=
inal
> > implement, how about write a online inline-function in a header file li=
ke this:
>
> Yes, this part is not a faithful conversion on my part, but I think it
> made sense when converting this to a library function.
>
> The alternative is that we'd segfault on some platforms (not glibc,
> since it's OK with null %s arguments), just checking it is cheap & I
> think a good sanity check...

After sending the last email, I was offline for over a week due to an
emergency at home.

According to the rest patches of this series, your implementation of
"format_object_header()" which uses "enum object_type" as the
parameter instead of "char *type" is better.  And adding a validation
for `type_name(type)` is also better than my one-line inline function.
This series of patches LGTM.

--
Jiang Xin
