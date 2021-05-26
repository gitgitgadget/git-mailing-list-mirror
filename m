Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20671C47089
	for <git@archiver.kernel.org>; Wed, 26 May 2021 07:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8C3613EC
	for <git@archiver.kernel.org>; Wed, 26 May 2021 07:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhEZHus (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 03:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhEZHur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 03:50:47 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F57C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 00:49:15 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e10so87378ilu.11
        for <git@vger.kernel.org>; Wed, 26 May 2021 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qOa/0e2frL5pFUpo1LByfUnNUaQYoT4XnSmlBorIcmU=;
        b=s3RnzDa+SxtVgEAK1S0GY9MRd6lS1KzmJIylMzIOJ/3V/G7b5QnJkHxx/CKjwBmBmZ
         DJ8ZY27vEFxqfovDH5E1ufa0/75zJp8g4qk1DzYV4CeuZl7mgMWSkoBjNMFx5GT2fLcp
         79FEYqVQ8cmftrXRv+vllAQ2HswWvJ9cl+e7F7YSTeVxNF8ikZr3uNGwIu09itd3d2DS
         PkzEQ1kHhCUIHprhtFa8JXljwABHlXk7WUyPZhIUayjDQYEmcQmXKleDrxF2J54AxItW
         0VAjosq6DvWiMVMikb1+vo01+EVYNho0rI8rhGvTA75VbNLFJtSJ/qE8i0v6Xeh2dKIn
         Escg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qOa/0e2frL5pFUpo1LByfUnNUaQYoT4XnSmlBorIcmU=;
        b=XX3ksA8cFFz7pROfgyGo0cNimlDtfl4emioWP8bUPn0z2k87GuLE/oI/EfvketI+OM
         3/TwIm1+7uWQ0qRrRxs/Zl+0nYZWvpCRxrFcgTXiWo3CYfACCSm5Gwm18CuKnSVhyHiU
         rxvjCQcY1NqBydcUyQo4DvkTszl7Awyd1W6OTSi+wD0GBodFiAt4Y58hY35T0s5BO4Np
         rDUiaTd0dKa73OyRSyMMplOylsx54EmRqKZ1tQTj4RfnKVrQubN/yO1+3L0eosH0Uuw0
         FxZ88M+jCiDMH05ZaVliWPmNotwHrxJSbXRuUFT9R15x4i30KzHaVRlVpWqQTuHY1Bdm
         9R/A==
X-Gm-Message-State: AOAM532etr1pWVGeZd9SIaTNQzO3lDTHXvbba2f/fE7bDnAH8uvFg1Uq
        Ia4B/iBOoXOoBF8xiO+YZH3Z/psaeZmfJwwIJYY=
X-Google-Smtp-Source: ABdhPJxC7swrYVrVMpBcJZ6mP4+Btl/tWDcqiwEEjOBPj1e4nZ2yWuxzEYfrRtQAYl3pJOEBWnJr05OYwINSpb42tpk=
X-Received: by 2002:a92:d24d:: with SMTP id v13mr25833371ilg.174.1622015354690;
 Wed, 26 May 2021 00:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
 <19413cfdb1ea50de401ab958b954a550b6514688.1621763612.git.gitgitgadget@gmail.com>
 <xmqqfsybh0bn.fsf@gitster.g> <xmqqa6ojgy9h.fsf@gitster.g> <CAOLTT8TaJm=9mQNXMGxt-bME-ynOpv4CKZvZw+yo9zNueH_VPw@mail.gmail.com>
 <xmqqczteeo11.fsf@gitster.g>
In-Reply-To: <xmqqczteeo11.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 26 May 2021 15:48:59 +0800
Message-ID: <CAOLTT8RdEive+fCtO-c0fZVjpmaYi0WYMZofCE-8wd94SCrdMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] [GSOC] ref-filter: support %(contents) for blob, tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:11=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > So I don't know if adding %(header) will cause duplication of functions=
.
>
> I do not think you can duplicate the feature of %(header) with
> other existing placeholders.  You may want to dump the headers of
> series of commits so that you can find if there is any commit with
> unusal header elements, but %(tree), %(parents), etc. would by
> definition be the known ones, so any combination of them will not be
> a substitute.
>

Well, "find if there is any commit with unusal header elements"
is indeed one thing that may need to be done (not now).

I tried to build "%(header)" yesterday and found some problems:

1. These atoms are too "flat":
"tree", "parent", "numparent", "object"... they are all part of the
header, why not use "%(header:tree)" like "%(contents:subject)"
does? Similarly, why not use "%(author:name)" instead of "%(authorname)"...

2. Why is there no state machine to save the parsing state of an object?
`parse_tag_buffer()`, `parse_commit_buffer()`, they only parse part of the
content of the object. E.g. tag parsed "object", "type", "tag" and "taggerd=
ate"
in `parse_tag_buffer()`, but it did not save the starting position and leng=
th of
the parsed fields, which caused `grab_person()`, `grab_date()` to parse the
object again and again. I think this may be an optimization point.

> But nobody is asking for it right now, and your cat-file --batch
> does not need it right away.
>

Or we only provide the simplest "%(header)" and "%(header:size)"
(it can be easily supported with "%(raw)"), leaving the other feature
to the future.

> What I wanted to say in the message you are responding to was *not*
> that you would want to add %(header) for completeness right now.
> But thinking beyond your immediate need (i.e. the "whole thing") and
> imagining how various pieces, including the ones that do not exist
> yet, would fit together, would help you to avoid designing the parts
> you immediately need in a way you would regret in the future.

As I said before, many atomic designs are not very regular.
Our ultimate goal may be we can simultaneously support:

"%(raw)"
"%(raw:header)"
"%(raw:header:tagger)"
"%(raw:header:tagger:eamil)"
"%(raw:header:taggereamil)"
"%(header:taggereamil)"
"%(header:tagger:eamil)"
"%(taggereamil)"
"%(tagger:eamil)"
...

Each layer is a namespace. Of course, it may take a long
distance to support this.

Thank.
--
ZheNing Hu
