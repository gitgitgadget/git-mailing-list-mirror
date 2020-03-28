Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1968C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7749A206DB
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9P5u8sT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC1RdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:33:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45838 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RdW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 13:33:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id l22so11771373oii.12
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBzmBzLczait1roEQbkyOO17yh8fnajm/NzPQtLC5v8=;
        b=n9P5u8sTHxkhQc7ANDtlCZOxLHyohDCeXfwaqChFvtoMsLqWiEUFRrRJ385a/mv2YO
         hpo4MDrGgMMkhMknqciUfMJC+VL6IpIxdono675Htm4i7h1WYBe9pDuDh1Vmywki+996
         NHH7EyZsYQvla9yXRsAywrIkRyA4q/3P1KoDjUKqV76gathE9MLZUBXMNoFhJcSeCOsS
         7ocpC5AZyC5mnyObU29Zr7a7PSJpR2n+hueNcB/C1wKtInk2velSjkENLufN4+MSdUu6
         2gcv3/nzGY/V752LLhojRSHZYxmUhMR4DhkDzk34aZX5L3rO04KcdsHuIkDg/x0i7Lo3
         c2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBzmBzLczait1roEQbkyOO17yh8fnajm/NzPQtLC5v8=;
        b=TKMGUHNDGLRBDc21tj3/1uFZx2gI1hXMu7EOo6F0CzjmT6M3Cc6FElnuBmS5ecoy60
         VkdMqZTPZQZbr/UxtNHbzXbs/MQOiy2Rq6kYVpib7We1BjDw3FcxRVNg4cfLilgjtFpa
         WF0FNRdEVylAdG1ecojI7fo9w5zJVCrNY0bJgrayJOyg31MPn0eeIVsgOMkY5XkxLjWv
         CirNEO8c9Xs7/xBSS6EDnAnwnckJ5H1MX6SjjPwdMHnbTmSUXuz+YqqI4ZVE261dLIGZ
         DVjkS6uuzdYB8b7zNYTpeaEHXyV6vtOKsKlfLOQ0LYBSthtywksd+hpThGmzSs6ICJ5Y
         7yrQ==
X-Gm-Message-State: ANhLgQ0im/o4O7Av2MS5riJP9x+M59rfJGV1F61fnbP3Dqf65xYCfhCa
        jBS4RJeZ6B9ao/WJ2lig6rdu8ix3uHJtJvWxnmQbTQoy3CE=
X-Google-Smtp-Source: ADFU+vv430ZCYNMkCosz5Rr9fVnJvHU2ab9VPo96PD1JT1syJd8+j7za7ErgN8MzsIRheQbbIzWi9vYcAHw/xa1QNow=
X-Received: by 2002:aca:db08:: with SMTP id s8mr3034419oig.167.1585416801005;
 Sat, 28 Mar 2020 10:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
 <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com> <ad7c7cd7-2f2e-d406-6a1f-9dd7f155dc10@gmail.com>
In-Reply-To: <ad7c7cd7-2f2e-d406-6a1f-9dd7f155dc10@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 28 Mar 2020 10:33:10 -0700
Message-ID: <CABPp-BFXWx_MPL1Z0-X5hHf0N1T_13TEbAhVTKh6-atO1+g90Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Avoid multiple recursive calls for same path in read_directory_recursive()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 6:13 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/26/2020 5:27 PM, Elijah Newren via GitGitGadget wrote:
> > This series provides some "modest" speedups (see last commit message), and
> > should allow 'git status --ignored' to complete in a more reasonable
> > timeframe for Martin Melka (see
> > https://lore.kernel.org/git/CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com/
> > ).
> >
> > Changes since v3:
> >
> >  * Turns out I was wrong about the untracked cache stuff and had some bugs
> >    around untracked directories with nothing bug ignored sub-entries.
> >  * First patch now is no longer a change of expectation of the untracked
> >    cache, but some more thorough testing/verification in that test that
> >    helped explain my misunderstanding and uncover the bug in my refactor.
> >  * Corrected the check_only and stop_at_first_file logic in the last patch
> >    and added a big comment explaining how/why it all works. Also stopped
> >    disabling part of the untracked cache in the same patch, and undid all
> >    the changes to t7063 in that patch.
> >
> > Stuff still missing from v4:
> >
> >  * I didn't make the DIR_KEEP_UNTRACKED_CONTENTS changes I mentioned in
> >    https://lore.kernel.org/git/CABPp-BEQ5s=+6Rnb-A+pdEaoPXxfo-hMSegSe1eai=RE74A3Og@mail.gmail.com/
> >    which I think would make the code cleaner & clearer. I guess I'm leaving
> >    that for future work.
> >
> > As per the commit message of the final patch, this series has some risk.
> > Extra eyes would be greatly appreciated; one pair already helped me find one
> > bug.
>
> I'm glad that I could help you discover mixed expectations. This pair of eyes
> is now satisfied with this series to the extent I can check it.
>
> Adding the previous patch to our microsoft/git fork pass the functional tests
> in Scalar and VFS for Git, for what it's worth:
>
> [1] https://github.com/microsoft/scalar/pull/358
> [2] https://github.com/microsoft/VFSForGit/pull/1646

Thanks, that helps.

An update of my own for this series: Based on Felipe's reported
bash-completion issue I was modifying commands to try out a number of
other things and discovered some cases that can trigger the die("git
ls-files: internal error - directory entry not superset of prefix")
message from ls-files so there's still some fixes I need to make.
Will send an update when I've got it.
