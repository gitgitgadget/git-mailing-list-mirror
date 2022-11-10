Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19247C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 17:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKJRrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 12:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKJRrm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 12:47:42 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB92D744
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:47:41 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id q5so1346167ilt.13
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KP3uwTpBuNF75mmhiEbhaaXCM9/qlDNtCWy21hUawmE=;
        b=LtYBATWC9zHtCBjHm93NpeTxbNMG/3mVPZ+Wreb95Jl1ctXE1DVwagzLGx3ob2ZPqN
         yW8fgh4z97s7P5SxTdyeK2nQdgXjAeVuK0E754X2UwRC3IhvddT+PJA3r5Y+m7q0Xpgx
         KzQGbZf1j8J5KE0NbHAnqJKr8wnqQWXHx20axJscDxSxS99Hwr7DNZ/GO5dGvMnaARrp
         opk76NgDkg1b9l/THYwmc9nbnFnNZ/TM6l7kuCDzhv5Jeux07wY/ZoYhLnMS0XkipNCS
         J82Qk6nRlzoryUGFi4nOxmvY5r6p395WC4PX0yckMRbLjGuoJuFoIg3QoAqAXri98IK9
         7uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KP3uwTpBuNF75mmhiEbhaaXCM9/qlDNtCWy21hUawmE=;
        b=QyN0lQO2mopzGsbj6N7LSWXsSuyiw0wiHiNWaeQzObj/gO8EBr50dAJSh1l9FsE79d
         EtXSee8X8G2H+TmOqeIGgsFoSrsxlLheEWCRhwgh6EBqfVcH1tvh4dEADpby8xEGEbY8
         ooOjpIKHfnFSXa11DQjs4V03kgZw1UYWwgSx/3XqxDt/HFMhfVkvQgticsqz3mfbKsM5
         m21TGkEKJC3tLlJyVtumjIV0RZk6wSZOMSV+AiRhiuINDyrlvSn1JjTYy7LyrQQKG6m3
         CFcdY5nylb8rBDbiKgyP+QAwDQM3aH0uOmYcs+5w3Yq7wy1YWr8tl4quKTnM6quI6a5T
         akmw==
X-Gm-Message-State: ACrzQf0dz6WVQtlTwv8SyyTxp2b2UHfUTe6bncTL15SFuWvFsyRsYfEu
        0Fzoq7l+T6XttDbUR77B3nlpAFEUTdrwiFHhasM=
X-Google-Smtp-Source: AMsMyM4hEnas08bMs4b+reqN0wER7syvlrDmfTTehXg/c0qFfYSLe6dT6TLIZc/0rmyTHwPYNnbfXuJoBMFOZmbK/Zo=
X-Received: by 2002:a92:c847:0:b0:300:e66b:13a with SMTP id
 b7-20020a92c847000000b00300e66b013amr2879392ilq.42.1668102460889; Thu, 10 Nov
 2022 09:47:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
 <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com> <CAPig+cTGG-y6myEYOVeF8W9QBdCjhqeghsepi-2R9V-v7=YwZA@mail.gmail.com>
 <CANaDLWK9ZhtqdpJJCNvOJ24x0jtUzZjZE5WKdzBPnePA4eGqTg@mail.gmail.com> <CAPig+cTFRV=Np2oV5QJDpmwOwBaTVnjmAqcz-Ny7hCi6PexQUA@mail.gmail.com>
In-Reply-To: <CAPig+cTFRV=Np2oV5QJDpmwOwBaTVnjmAqcz-Ny7hCi6PexQUA@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Thu, 10 Nov 2022 11:47:29 -0600
Message-ID: <CANaDLWKR93_qfOkT6_u_qvUYZqjAZ_z_YXtzDFHXB+RY8nZhTg@mail.gmail.com>
Subject: Re: [PATCH v4] status: long status advice adapted to recent capabilities
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, thanks, all of this helps a ton. I know exactly what to do about
those two things now.


On Thu, Nov 10, 2022 at 11:30 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Nov 10, 2022 at 12:02 PM Rudy Rigot <rudy.rigot@gmail.com> wrote:
> > > the <<- operator allows you to indent the here-doc body
> > > (with TABs, not spaces), so you can align the body with the rest of
> > > the code
> >
> > Unfortunately, that's how I had done it first, but since some of those
> > lines are blank, the test code had lines just made of "<tab><tab>" and
> > nothing else, which made the check-whitespace check fail. I considered
> > replacing empty line with something on the fly with sed (like just an
> > "x" character for instance), but this felt hacky and brittle (in the
> > unlikely case where an actual "x" would find itself genuinely lost in
> > the middle of that output, the test would mistakenly pass). I went
> > with the solution I'm presenting here because the readability
> > downsides of missing that indentation felt less bad. Definitely
> > willing to be convinced though.
>
> Okay, I see what you're getting at. Fortunately, there is a simple
> solution as long as those lines are truly blank as emitted by `git
> status`: just leave the blank lines completely blank in the here-doc
> body (don't bother inserting a TAB on the blank line). This should
> product the exact output you want:
>
>     cat >../expected <<-\EOF &&
>     On branch test
>
>     No commits yet
>     ...
>     EOF
>
> Although it should not be needed here, the `sed` approach is generally
> fine, and we use it often enough in tests, though usually with a more
> uncommon letter such as "Q". See, for instance, the q_to_nul(),
> q_to_tab(), etc. functions in t/test-lib-functions.sh.
>
> > > I presume the reason you're escaping the "trash" directory is because
> > > you don't want these untracked "actual" and "expected" files to
> > > pollute the `git status` output you're testing?
> >
> > You are presuming right! The test was being flappy in CI runs before I
> > changed this, which I found used as a solution in other
> > git-status-related tests currently in the codebase. I'm not familiar
> > with the trash directory approach, but I'll figure it out.
>
> Each test script is run in a temporary "trash" directory which gets
> thrown away when the script finishes. We want tests to constrain
> themselves to the trash directory so they don't inadvertently destroy
> a user's files outside the directory.
>
> I see what you mean about some existing status-related tests using
> files such as "../actual" and "../expect". It's not at all obvious in
> a lot of those cases but they are safe[*] because those tests have
> already cd'd into a subdirectory of the "trash" directory, thus
> "../actual" is referring to the "trash" directory itself, hence the
> tests do constrain themselves to "trash".
>
> Anyhow, I suspect that crafting a custom .gitignore file in the test
> setup should satisfy this particular case and allow "actual" and
> "expected" to reside in the "trash" directory itself without mucking
> up `git status` output.
>
> [*] Unfortunately, some of those scripts are poorly structured because
> they `cd` around between tests, which can leave CWD in an unexpected
> state if some test fails and subsequent tests expect CWD to be
> somewhere other than where it was left by the failed test. These days,
> we only allow tests to `cd` within a subshell so that CWD is restored
> automatically whether the test itself succeeds or fails. So, this is
> safe:
>
>     test_expect_success 'title' '
>         do something &&
>         mkdir foo &&
>         (
>             cd foo &&
>             do something else >../actual &&
>         )
>         grep foo actual
>     '
