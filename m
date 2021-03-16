Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6423C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8721864FA6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhCPVTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhCPVTK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:19:10 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D31AC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:19:10 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m1so9196721ote.10
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NGTGFGkrSBXXRdfmZKC2q+ReD+n5TfiTYDA5r3MscOw=;
        b=CKoRTgk5Xauv1XdR3s0M30CX2SwjIEG6dGENQIljteOrGzwTm9YYaSSjJlc/CEocxW
         AZ93T4p4l7EHB3D9KKgGU/3c4TgCqK/WBEWrQ/HmJSAzytyJfUZWw6hOtMbLujH+cK1n
         3jWeKiDwFBu2yx5MUGDLL4xX8qW+ok5o5pgFLM9DwXNy0bypF46GGCo7RjX6/QZk7W1t
         k58ga9rzoPKCAFcjVM1rWyaYz2I079uc2ij4N4Tz0ZOc34u1aqFgUZOFHd1uqyuV0gjA
         HKjACuWbq56gu6lMhZDToyW1Jyc4klqe+L/l0N9A27qmbsdCsrLF+3MyTTxmSvwjN6R0
         Hg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NGTGFGkrSBXXRdfmZKC2q+ReD+n5TfiTYDA5r3MscOw=;
        b=oYwS1qaG0Wyz/gjo+kl5q7/JBlXck3h34+7Abr7vbi10PVgXtjVllX+MdcJoq/2mvt
         gt3oLtDGfQ5xMoKDi2md4PWnVNqUnmd/F9JRrqVR21f7WicJ0c7pS4n1UfVmccmKQdLC
         jvxKDAb5Yi0ix5WlpZkZ/H/Y2WI8Roer3Wtg5Gqq51Clw1GMYzknqPIBN/l/7nOxKEc2
         +OROly8cKA2ooQe+hK70K+UYOud54SeW6023+jqVf2I43E+lBPa5wMF5KOm8zqP3Orii
         D5K1MUV7EtDnGDZwyozKCm7+phFVe4f31Bl6x5BCZHEuKwjfW3M+YPrrWN0fw35GLLTg
         36vg==
X-Gm-Message-State: AOAM5327kmhTfGZZ4VJaSGqbGPAmj+H5SJk+IZBHfM63F20FxRgUy7kL
        d/pqLnjv/ySiK+i3mTqMdffcP3hS0qfFYX7/QrsHicD3wldFQQ==
X-Google-Smtp-Source: ABdhPJwrLy0jsoz6vVIN3QmFa0TkqS+P+oBePHAyyjpf/039JqFl0W5wXlv+1C9qwZy1RC/HlJ7KKOuKN0kzv+lgnw0=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr626738otf.162.1615929549810;
 Tue, 16 Mar 2021 14:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com> <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Mar 2021 14:18:58 -0700
Message-ID: <CABPp-BGpDaj6GqK9zRw-_GUvGZewk7gsVxdjckfJXbkqbTQaeQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Sparse Index: Design, Format, Tests
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 9:43 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Here is the first full patch series submission coming out of the
> sparse-index RFC [1].
>
> [1]
> https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.co=
m/
>
> I won't waste too much space here, because PATCH 1 includes a sizeable
> design document that describes the feature, the reasoning behind it, and =
my
> plan for getting this implemented widely throughout the codebase.
>
> There are some new things here that were not in the RFC:
>
>  * Design doc and format updates. (Patch 1)
>  * Performance test script. (Patches 2 and 20)
>
> Notably missing in this series from the RFC:
>
>  * The mega-patch inserting ensure_full_index() throughout the codebase.
>    That will be a follow-up series to this one.
>  * The integrations with git status and git add to demonstrate the improv=
ed
>    performance. Those will also appear in their own series later.
>
> I plan to keep my latest work in this area in my 'sparse-index/wip' branc=
h
> [2]. It includes all of the work from the RFC right now, updated with the
> work from this series.
>
> [2] https://github.com/derrickstolee/git/tree/sparse-index/wip
>
>
> Updates in V3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> For this version, I took =C3=86var's latest patches and applied them to v=
2.31.0
> and rebased this series on top. It uses his new "read_tree_at()" helper a=
nd
> the associated changes to the function pointer type.
>
>  * Fixed more typos. Thanks Martin and Elijah!
>  * Updated the test_sparse_match() macro to use "$@" instead of $*
>  * Added a test that git sparse-checkout init --no-sparse-index rewrites =
the
>    index to be full.

I've read through the range-diff.  Sorry for not spotting the conflict
with =C3=86var's series (that I also reviewed).  Anyway, my Reviewed-by
from the last series still holds.
