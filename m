Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAB8C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 10:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiKPKLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 05:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiKPKLF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 05:11:05 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB41E3D7
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 02:11:01 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-367cd2807f2so163115467b3.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 02:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UGzX8EVKUuYD0iptWFaHDn97r7+qI7fFQ9sLwOJORc=;
        b=I0sCgGxfSYdOPyYuExsFP0MSHTBwWl3bXE1SaIUrzERWQnUSlWAjorj2w3Wz76jl5P
         bduZLtycLRBUokJQMAxMO/UvXyIsKlE7oQTyrK4/+7mdgfJOD5sOzoItOKz9SlEljIh3
         bI9/HqzHLegGVlrxh1dnqm4cFgfG6+YOnnKbn4kVCu+kR9c4QGDgTNGC3ATeHwyke/b3
         O9V0GZHls7GNFBvzcAYmiZa/gI6dIVlvdcSJSFAu50ZBmpOuxMvzcLoF1S0SyteFlkxO
         Zqs8pO6yj8oPO7QEpjcGYJ4giFW1hb6NamJdSZgnSWXNERguuWXtT5zbZqvboAQzt1bE
         OMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UGzX8EVKUuYD0iptWFaHDn97r7+qI7fFQ9sLwOJORc=;
        b=oFsu1dIOTz051/Xyg/3tBT453XzQph4laz5ZfKGk16fLcDMQKgnToERrIzs3iy4i01
         sPKs5PLW7VLEptMmuZ8P/bLO6d3i+3AoeXGNQSBzFiBOK0hC/qTNemk4EsdZOSGSEW9e
         A3BDRVXIvzVZOjjpT9pWoL4v9gwtd5iahiq9z8JdUbeub3fxLHB1EbkLN6jimD3AqOCt
         uKYzAJUFyvHVgjw1aqaRQeLustwLpYVEoUuNGO/ZMj1WNQ8xSM9xiqHyevvs6MJpwN+s
         zxkY/4SsyykfWoQPeMJP3qOBMFWeuloWjJQXiCwBzPMWc+UtFFCsZFgkT3OmuiH1IBdN
         CAAg==
X-Gm-Message-State: ANoB5pk2TmWhcCu8+wRkYrKDfvUcxofmcEdIcqgS4qtJ74XPbFpdn45t
        B7P+FNdEJRfLBpbZ6MdC1N0zKW/xhqdlioH6m0wn57KjidJGcfEU
X-Google-Smtp-Source: AA0mqf64aI6V+K6AzTGsBVB4dKwTbtvUavAbAXk7omEf65UfAR71VpQ94zlqHuTRGzoJrX55lRUw042f5NZpiqmtUCE=
X-Received: by 2002:a81:4a09:0:b0:35f:dedf:fe5 with SMTP id
 x9-20020a814a09000000b0035fdedf0fe5mr21524913ywa.408.1668593461164; Wed, 16
 Nov 2022 02:11:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
 <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com> <CAOLTT8QOr-zTHBPLx5jibzQ6Co8a3VApgLEGRu0b+ht-VJh0nw@mail.gmail.com>
In-Reply-To: <CAOLTT8QOr-zTHBPLx5jibzQ6Co8a3VApgLEGRu0b+ht-VJh0nw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 16 Nov 2022 18:10:49 +0800
Message-ID: <CAOLTT8QPPJ-pPvr9r3nJQgBg_7xCp5Ys=dd9nhi6fhgW6gYLow@mail.gmail.com>
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout directions
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Glen Choo <chooglen@google.com>,
        Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=B8=89 18:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=B8=89 13:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Perhaps it's worth noting why I think the sparse specification should
> > be extended when dealing with the index:
> >
> >   * "mergy" commands (merge, rebase, cherry-pick, am, revert) can
> > modify the index outside the sparsity patterns, without creating a
> > commit.
> >   * `git commit` (or `rebase --continue`, or whatever) will create a
> > commit from whatever staged versions of files there are
> >   =3D> `git status` should show what is about to be committed
> >   =3D> `git diff --cached --name-only` ought to be usable to show what
> > is to be committed
> >   =3D> `git grep --cached ...` ought to be usable to search through wha=
t
> > is about to be committed
> >
> > See also https://lore.kernel.org/git/CABPp-BESkb=3D04vVnqTvZyeCa+7cymX7=
rosUW3rhtA02khMJKHA@mail.gmail.com/
> > (starting with the paragraph with "leery" in it), and the thread
> > starting there.  If the sparse specification is not expanded, users
> > will get some nasty surprises, and the only other alternative I can
> > think of to avoid such surprises would be making several commands
> > always run full tree.  Running full-tree with a non-default option to
> > run sparse forces behavior A folks into a "pick your poison"
> > situation, which is not nice.  Extending the sparse specification to
> > include files whose index entries do not match HEAD for index-related
> > operations provides the nice middle ground that avoids such usability
> > problems while also allowing users to avoid operating on a full tree.
> >
>
> I can understand the reason why we need to extend sparse specification:
> index often needs to handle files that are not in the sparse pattern.
>

I might have one more question: when we use "git diff -cached HEAD~",
what is the best way to check if an index entry is the same as HEAD here?
Do we need to run "git diff --cached HEAD <file>" again?
