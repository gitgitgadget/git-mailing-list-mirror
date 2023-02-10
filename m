Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C86C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 09:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjBJJ6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 04:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjBJJ6L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 04:58:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEB677171
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 01:58:08 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so7486893lfv.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 01:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PqlFQ7L1ydsjUXKJwUxv8gn4TCaNx3GV9xjd0kNjBB8=;
        b=Q8lgyPD58yV9I4Kbi6GJUKaH2ZXMRT+JIDL5R4bWiYWYWEb5ikX+GbL+Hg1ddEpBj5
         v+qitDblNV35Cwj5Xj0nZunHNzqO7tZ2L4yW8e3mdSCWNWsunw+r099SprUMAzt7AbVt
         iOLQITVnXnfx4sR38TQGyIdyQWzf1bjkyZ6GrStOdVF4Q83SD0buk3/yY2Jispl4MWTN
         +iQIk75kZHOQqQCm4Mv+eK2dLh02u1sJ9XFNNGV06hK748/uPxw3faLdVFLz6VZwANsp
         OSUfxzzidwHiCbDFR5Qc0mPj5YgwLkRjpopaD3iCy36QQfuYStslU38gf1M1zNhU0FT2
         9h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqlFQ7L1ydsjUXKJwUxv8gn4TCaNx3GV9xjd0kNjBB8=;
        b=wjniyv/WUu+qAF26Qy28C/bZ9FhHbPIWdRCZ7DGZCOMDSjXczf/phkUqHDCLvIZ0RZ
         NgvZEkE3CZLiK2AP1161VvCoAXK7ULcFgtsATGqpWB0yL8c0eKdSJPE7yOgtRhSEdWCf
         w8NvR/ruDdaQe+wneuIWeCwhHtrBUYGQD7VlFTg5M7F9vDGSk6HdWwBxt/dDW054E4wI
         nz3rTTPdiH+VqpjazbufeXKJIalCdxVUk5LL07a+9IpcgH5UszSprS8l18WRcBVJu0E4
         gDfbjGiMi8FLthihY/AMChJbqQJRzzliJEaOZsHCLNA6RF61iDTo2fH6gb+aOMTDp8H/
         KFBQ==
X-Gm-Message-State: AO0yUKV7cJbYpeZL61L0V2a/PMKLe6+p97D5XmfRIIqWbixoWFe25bg3
        VLckMJdPohpM49fz0/xM2biC+7nUaxhUC46HWPaSQEX4q4Y=
X-Google-Smtp-Source: AK7set/jtSDKhB5LdD10ss4mURiXtfjgR+CzsvGr1OuChn85kVDZvhDMm4U4L4wsbx9+RB2ByxFYNy9IFlOkKlVgrTY=
X-Received: by 2002:ac2:5a0b:0:b0:4d2:381c:87dc with SMTP id
 q11-20020ac25a0b000000b004d2381c87dcmr2388079lfn.124.1676023086658; Fri, 10
 Feb 2023 01:58:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com> <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk> <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
 <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com> <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
In-Reply-To: <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Feb 2023 01:57:53 -0800
Message-ID: <CABPp-BHQDS+AzWXtk9WV4HY2QZ8UdXrWJJDr-y6VPoLB6HuAfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
To:     phillip.wood@dunelm.org.uk
Cc:     John Cai <johncai86@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, Feb 9, 2023 at 6:44 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 09/02/2023 09:09, Elijah Newren wrote:
> > Hi John and Phillip,
> >
> > On Tue, Feb 7, 2023 at 9:05 AM John Cai <johncai86@gmail.com> wrote:
> >>
> > [...]
> >>> Perhaps I'm over simplifying but having read the issue you linked to I couldn't help feeling that the majority of users might be satisfied by just changing gitlab to use the patience algorithm when generating diffs.
> >>
> >> Right, I recognize this is a judgment call that may be best left up to the list.
> >>
> >> We don't have a way in GitLab to change the diff algorithm currently. Of course
> >> that can be implemented outside of Git,
> >
> > Well, the below doesn't allow users to make diffs better for
> > *individual* files of interest, but if you agree with me that we
> > should just make diffs better for all users automatically, it's a
> > two-line change in git.git that I'd love to eventually convince the
> > project to take (though obviously doing that would also require some
> > documentation changes and some good messaging in release notes and
> > whatnot).  I've used it for a good long while, and had a few dozen
> > users using this patch too, all without complaint:
>
> I'd support a change to either patience or histogram as the default
> algorithm. My personal preference would be for the patience algorithm as
> I think it generally gives nicer diffs in the cases that the two
> disagree (see below, I've tried changing diff.algorithm to histogram a
> few times and I always end up changing it back to patience pretty
> quickly). However I can see there is an advantage in having "diff" and
> "merge" use the same algorithm as users who diffing either side to the
> merge base will see the same diff that the merge is using. The histogram
> algorithm is known to produce sub-optimal diffs in certain cases[1] but
> I'm not sure how much worse it is in that respect than any of the other
> algorithms.
[...]
> [1]
> https://lore.kernel.org/git/CAGZ79kZYO6hHiAM8Sfp3J=VX11c=0-7YDSx3_EAKt5-uvvt-Ew@mail.gmail.com/

Thanks, I might have a fix, though I'm a bit worried my tweaks might
trigger issues elsewhere or cost a bit of performance; I'll need to
test.  Are there any other good known testcases where histogram
produces sub-optimal diffs?

> To see the differences between the output of patience and histogram
> algorithms I diffed the output of "git log -p --no-merges
> --diff-algorithm=patience" and "git log -p --no-merges
> --diff-algorithm=histogram". The first three differences are
>
> - 6c065f72b8 (http: support CURLOPT_PROTOCOLS_STR, 2023-01-16)
>    In get_curl_allowed_protocols() the patience algorithm shows the
>    change in the return statement more clearly
>
> - 47cfc9bd7d (attr: add flag `--source` to work with tree-ish, 2023-01-14)
>     The histogram algorithm shows read_attr_from_index() being moved
>     whereas the patience algorithm does not making the diff easier to
>     follow.
>
> - b0226007f0 (fsmonitor: eliminate call to deprecated FSEventStream
> function, 2022-12-14)
>    In fsm_listen__stop_async() the histogram algorithm shows
>    data->shutdown_style = SHUTDOWN_EVENT;
>    being moved, which is not as clear as the patience output which
>    shows it as a context line.

If my current changes are "good", then they also remove the
differences between patience and histogram for the second and third
commits above.  (And the differences between the two algorithms for
the first commit look really minor.)

> I think there is a degree of personal preference when it comes to which
> out of patience or histogram is best and the user can easily select
> their preferred algorithm so I'd be happy with either.

:-)
