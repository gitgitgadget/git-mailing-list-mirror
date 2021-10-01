Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A04BC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CEF61A7F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 08:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352519AbhJAI6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhJAI6G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 04:58:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEDBC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 01:56:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r18so32061337edv.12
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 01:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=c29JKR+dl77Q4Yl70jIkfAKnx/3EAahQp87EMxJ1W1M=;
        b=nuYaRBG14wJpHNsp2VHkgKUSf10wYO2lgafzN11TRqYbTS1xx4iXjROx/J1NtYoBXg
         4lXhg2lffVloUXU51M2VEXUiQGHFougNx6KexDs3IROjUG0fvWUBCanVRqu05tji6LKI
         OUzpp8p37QHiKsQ1LEWBiTdSWmi7J/PERg4J2+Wd7SAbJKbTzi+ymFWM+HCShfSFEjnf
         Y2XZXp4Jw25GEMCS1CrVpyVyq8iQUPuV9kt5FsR1fZHcV+cBqK9sPRs+mMzKC/sFbA78
         2OMh4GN+/YzXLgO27+udwR+mxH94zJDWMbVWn7Hn0ghia/ka2BdKQby8sx3KNc0dxDCt
         Zrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=c29JKR+dl77Q4Yl70jIkfAKnx/3EAahQp87EMxJ1W1M=;
        b=HawtjK5TC9yCudRaotR0asWsaYcP2LmS6jP047f67sZ9z4fvVVmORkQo+QNH2qeqRC
         Zw8ARK4O73AKHbjiHeZbIvEd7WuDVeU51SPoMJoXTC2prOL/tOm+c9HfO39N2Zc1mgXM
         CUb28MSkmkyahFeUhZugf+tY96Ih7cCSqkXZBmphfnUa8PPZaQHVVpMeY199Zvp46xDd
         4ROrwLvTxKGA07jhyeegbEB9EpJ0SOmHrvFyTJtn1ah1XPtpn9C6/t2YxdICKvmcWAQB
         VbWDh0+cpOjPSmGK2ThJU+qcordYiCd+vHD48fda0yWXzgMbVL6qHIxo1D/trTm4QV5L
         cINw==
X-Gm-Message-State: AOAM5334ZsnOD9NyTtTeRzTrODVy8P6v5AGKjUKuGy51iZHUr7mXJnKD
        TYuiEKipLS5WsDmgGadqbYA8mSoL6PRTHw==
X-Google-Smtp-Source: ABdhPJziJF8PdD1rflbtaK85iQw/EiZQM6KvWTel8eXTjSkKc9qB7DfWzPOw7KqSTPEqyUlWYBv7Og==
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr4746527ejo.215.1633078581280;
        Fri, 01 Oct 2021 01:56:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id de9sm2793931edb.8.2021.10.01.01.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 01:56:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: en/removing-untracked-fixes [Was: Re: What's cooking in git.git
 (Sep 2021, #09; Thu, 30)]
Date:   Fri, 01 Oct 2021 10:51:33 +0200
References: <xmqqh7e18soj.fsf@gitster.g>
 <CABPp-BHKOt+x+B3DGh3BJV_voP64pvTrL5B-w4hWqHNKfr2K3w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BHKOt+x+B3DGh3BJV_voP64pvTrL5B-w4hWqHNKfr2K3w@mail.gmail.com>
Message-ID: <87fstlrumj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Elijah Newren wrote:

> On Thu, Sep 30, 2021 at 6:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> * en/removing-untracked-fixes (2021-09-27) 12 commits
>>  - Documentation: call out commands that nuke untracked files/directories
>>  - Comment important codepaths regarding nuking untracked files/dirs
>>  - unpack-trees: avoid nuking untracked dir in way of locally deleted fi=
le
>>  - unpack-trees: avoid nuking untracked dir in way of unmerged file
>>  - Change unpack_trees' 'reset' flag into an enum
>>  - Remove ignored files by default when they are in the way
>>  - unpack-trees: make dir an internal-only struct
>>  - unpack-trees: introduce preserve_ignored to unpack_trees_options
>>  - read-tree, merge-recursive: overwrite ignored files by default
>>  - checkout, read-tree: fix leak of unpack_trees_options.dir
>>  - t2500: add various tests for nuking untracked files
>>  - Merge branch 'en/am-abort-fix' into en/removing-untracked-fixes
>>
>>  Various fixes in code paths that move untracked files away to make room.
>>
>>  Will merge to 'next'?
>
> Phillip (Wood) just recently acked the series[1].
>
> =C3=86var made multiple good suggestions on an earlier round that I
> incorporated.  A few others commented as well and I incorporated each
> or responded why it didn't make sense, I believe to the individuals'
> satisfaction.
>
> However, on the latest series, =C3=86var has tried to suggest some changes
> around the 'dir' member that he seems to want to see squashed in.
> There's multiple reasons I don't like those changes, and even if we
> ended up adopting them, I think they'd need a separate commit with a
> good explanation of the assumptions being added by those changes[2].
> I think such a change, if others want it, could and likely should be
> submitted separately from this series.  And I suspect he's struggling
> just as hard to see my point of view as I am to see his.
>
> So...maybe I reroll the series with Phillip's Acked-by, and give it a
> few days to see if either =C3=86var or I can convince the other?
>
> [1] https://lore.kernel.org/git/b23bb983-39e6-75ad-0cb5-d9a5ba2cd4d8@gmai=
l.com/
> [2] https://lore.kernel.org/git/CABPp-BGi03JunRaMF_8SJKC00byOnq1kL3JyYhKW=
atz8-B4RsA@mail.gmail.com/

A tl;dr of the relevant reply from me[1] is that I'm fine with this
being merged down as-is.

As noted I should have been clearer from the beginning, it was really a
"oh interesting, on my larger topic of memory leaks I did XYZ
differently" than "your XYZ here needs to be an ABC". Should the "ABC"
be worthwhile I can submit that on top.

I did suggest in [1] that maybe the question of "ABC" v.s. "XYZ" would
be better dealt with in some other series, i.e. just ejecting (if
possible) the memory leak fixes while at it from this larger
mostly-unrelated topic. But again, I'll leave whether you'd like to do
that to your judgement after you've caught up on mail.

1. https://lore.kernel.org/git/87k0ixrv23.fsf@evledraar.gmail.com/
