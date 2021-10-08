Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFA6C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2221D60FC3
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbhJHDof (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 23:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242724AbhJHDo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 23:44:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B7C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 20:42:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a25so15202853edx.8
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5+c/XBom+ePnTZkqZi+tMFuEKJ8/QcJ98/YLpn4bxw=;
        b=m7XzLo57buVsjZKoi96WFhvzbkq/zvdhrkCXS84GB0JXBRaJrNYvgXvbCtBUnc0KUH
         MjXpTkmLuNy2wlLw3TOZSJHGJooM3inxG+/qQiWkJGlcl+HaqVS7pvXcFYHNZ1a3CFLo
         kPDqBjyAjE2U0Q/BIrM42+WDZwIptYsfWFnV7hzAcUNedWwfOcSuLLh7/6sKHPC/rRHw
         w0kK0+KwBuK7FmXiuxFs9dU5A5H8YaYXevGZV/DkhH91YG7cXVO3QS4Fy6K9Tes+x4Ph
         AX0datGN6jk6CliriY+9yEv1iBVWlTOChQVrBfZI1g1rQB/espkOTsCtaVoQEaJvGAF2
         mtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5+c/XBom+ePnTZkqZi+tMFuEKJ8/QcJ98/YLpn4bxw=;
        b=7lw44pNW+TBrFzhY8fiAz0JrYfcHKdEYE0KvyrBHEUgThE6AJAZV7Wnw5t2+lJPXI9
         Oy/edzcMxIhrmf/ST0E20hfvTqapYdfNrcjIAzbh+/zIANsjBGzlzGcD8vRrppQnXyTe
         yMJAF00iSn6d78ZzaBMd3igRBFzDfNEZ0+xTxwi2S++TImtGqiysRzTqZNsMlBUxMT5J
         V4G/+LukOm47Cgs2tEtocnqe/1V80ABfQTbKxDSFlMp9ZG4jvENTfi1xCfwMLMCu0IH/
         5o9IDxHU1vkYsmlX95zBNJn4MqtM3RGsiGQ9G2m7kLVpG/4cqylr8TzdHMTHbqJSOY8u
         st3g==
X-Gm-Message-State: AOAM530N3aQvSnaIeasvCgCpcQdfs8PupxZwRZoiLaA0jVkaCN43E08P
        vmdC4FlWbrjRpNeNQONyJu2EnBSYja3UmpEEgHQ=
X-Google-Smtp-Source: ABdhPJwsX0wndNpprcMiQikaZdCp1aC7SaeEVxUf020wVcabqtkpXcnU9xeiSvp8vIwi+G9yZVwdtyDhe3NuAEBXWmQ=
X-Received: by 2002:a17:906:eda6:: with SMTP id sa6mr1045511ejb.443.1633664552475;
 Thu, 07 Oct 2021 20:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com> <f7cb9013d46731855c3ed42add62b021c0ad0c73.1633440057.git.gitgitgadget@gmail.com>
 <CABPp-BHD3khX+q7crk4JnNbGd9fN-vJW0L1x=5JdzkFL6X1BBg@mail.gmail.com> <3cfa0810-4449-1170-1f7b-cd029e5ce434@github.com>
In-Reply-To: <3cfa0810-4449-1170-1f7b-cd029e5ce434@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Oct 2021 20:42:21 -0700
Message-ID: <CABPp-BF+bEUcyE0N79uRCkpCayJx_NMqOpnMSHHrpJM5a9hAWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] update-index: add --force-full-index option for
 expand/collapse test
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 6, 2021 at 1:40 PM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > On Tue, Oct 5, 2021 at 6:20 AM Victoria Dye via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Victoria Dye <vdye@github.com>
> >>
> >> Add a new `--force-full-index` option to `git update-index`, which skips
> >> explicitly setting `command_requires_full_index`. This lets `git
> >> update-index --force-full-index` run as a command without sparse index
> >> compatibility implemented, even after it receives sparse index compatibility
> >> updates.
> >>
> >> By using `git update-index --force-full-index` in the `t1092` test
> >> `sparse-index is expanded and converted back`, commands can continue to
> >> integrate with the sparse index without the need to keep modifying the
> >> command used in the test.
> >
> > So...we're adding a permanent user-facing command line flag, whose
> > purpose is just to help us with the transition work of implementing
> > sparse indexes everywhere?  Am I reading that right, or is that just
> > the reason for t1092 and there are more reasons for it elsewhere?
> >
> > Also, I'm curious if update-index is the right place to add this.  If
> > you don't want a sparse index anymore, wouldn't a user want to run
> >    git sparse-checkout disable
> > ?  Or is the point that you do want to keep the sparse checkout, but
> > you just don't want the index to also be sparse?  Still, even in that
> > case, it seems like adding a subcommand or flag to an existing
> > sparse-checkout subcommand would feel more natural, since
> > sparse-checkout is the command the user uses to request to get into a
> > sparse-checkout and sparse index.
> >
>
> This came out of a conversation [1] on an earlier version of this patch.
> Because the `t1092 - sparse-index is expanded and converted back` test
> verifies sparse index compatibility (i.e., expand the index when reading,
> collapse back to sparse when writing) on commands that don't have any sparse
> index integration, it needed to be changed from `git reset` to something
> else. However, as we keep integrating commands with sparse index we'd need
> to keep changing the command in the test, creating a bunch of patches doing
> effectively the same thing for no long-term benefit.
>
> The `--force-full-index` flag isn't meant to be used externally or modify
> the index in any "new" way - it's really just a "test" version of `git
> update-index` that we guarantee will accurately represent a command using
> the default settings. Right now, it does exactly what `git update-index`
> (without the flag) does, and will only behave differently once `git
> update-index` is integrated with sparse index. Using `--force-full-index`,
> the test won't need to be regularly updated and will continue to catch
> errors like:
>
> 1. Changing the default value of `command_requires_full_index` to 0
> 2. Not expanding a sparse index to full when `command_requires_full_index`
>    is 1
> 3. Not collapsing the index back to sparse if sparse index is enabled
>
> I see the issue of introducing a test-only option (when sparse index is
> integrated everywhere, shouldn't it be deprecated?). If there's a way to
> make this more obviously internal/temporary, I'm happy to modify it. Or, if
> semi-frequent updates of the command in the test aren't a huge issue, I can
> revert to V1.

If it's a test-only capability you need, I'd say add it under
t/helpers/ somewhere, either a new flag for an existing subcommand of
test-tool, or a new subcommand for test-tool.
