Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F06DC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344381AbiA1AIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiA1AIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:08:34 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5EDC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:08:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ka4so9990481ejc.11
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4T770/dXiUSNHRGQtgIiYXmrlsc+1bjNsXL5349AIw=;
        b=cTX7Sj7JDYYHYjf4VkSZM47GEvYpU3DfYPHR0pgq191rZL4L+3kmJMuAo2ZdiffWlP
         IJIxdlZ5L5OAxDfKvoDrcEeiKhpfG2Fi9HHo2Cvc3x4GwLZJTreyO6GReOOnKUaFh6pk
         PPZz/9qE8/b7W88n40Y9OHAL07BpH2c92hF/5Jv4Y+FQdw/8zQTH0pX8W+iJ70EQ6Bae
         kBd+ohzjEW/vaEZzEb3Fon+ngKFVQBo6xrA+fRn2hjhoV9yCvXx+ikRO6P5LwWbPRgg3
         BsqQpFtCrlfiEf43QoOAwCuIyoKbo2wBPn6WIg+2pKzayNciIP8Ltz1rDprZSfgHMBNt
         0ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4T770/dXiUSNHRGQtgIiYXmrlsc+1bjNsXL5349AIw=;
        b=kDU76MGOXAV1rmgmz0cQJgDwGmJZPXC2XyWoAgEo6lTtLrSFvu+tXXTKxEqhlWv4us
         g32rZpbv7Xuhxi36mv5q83heKqOMM6MxXGqFxm0PoLM59s79/pLlQhgv9LvnAcXwU1/h
         QC8EC8+StTPuNwALVJ2xmJL+HPZgH8e7imQU4bpNwtmS8KqaTkFlvsFYWi+czQ5wtcJd
         UB+U5/T6duBcSYUFGVKlV9QlLLsZno3wMKivmMSz2bfe5+axr1So+PeC7qEhOG5O+GZk
         UvsWDktqGT+cQysZg2PvQKnICjeATPymO63yRGr/dzqXBLpkr9b+n5Iaod+ZnGotrMdh
         89vw==
X-Gm-Message-State: AOAM531PEOEIA5/3oh8gwE5/Vxf9ucEtLjyXVceqHpO8l15FX/Rah7mE
        9vLwN0XjuJ1fy56031CJ4M+nbWwgtJJ4vzUKI44pTBuF
X-Google-Smtp-Source: ABdhPJxtqM6ce+3tWAzHZ+UQbqb0imQrWWVhqN8r24yU6PwFSZugzWrj6960Vp4MaAEi/1kmM5gC4fJk2ZG7Mt2LGL8=
X-Received: by 2002:a17:907:7d88:: with SMTP id oz8mr4953465ejc.328.1643328512635;
 Thu, 27 Jan 2022 16:08:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com> <5bb598a055dd8121ad5c7228b11618b037029478.1643318514.git.gitgitgadget@gmail.com>
In-Reply-To: <5bb598a055dd8121ad5c7228b11618b037029478.1643318514.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Jan 2022 16:08:20 -0800
Message-ID: <CABPp-BFdaLpmcnU2DUy0Wx1rapsWckz4=aG5yTGdCcM3U3on8Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] completion: add sparse-checkout tests
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 1:21 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Add tests for missing/incorrect components of custom tab completion for
> the sparse-checkout command. These tests specifically highlight the
> following:
>
> 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
> (it is missing reapply and add).
> 2. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
> both file names and directory names. While this is the correct behavior

s/is/may be/

(Yes, Junio declared it to be the behavior he wanted to see, but
there's a difference between "this is clearly desired behavior" and
"here's the official edict declaring which bad option is the lesser
evil" situation.  As Junio pointed out, completing on files and
directories avoids one type of surprise for users -- but as I've
pointed out elsewhere, it introduces multiple other types of negative
surprises.)

> for non-cone mode, cone mode sparse checkouts should complete only
> directory names.
>
> Although the first two of these tests currently fail, they will succeed
> with the sparse-checkout modifications in git-completion.bash in the next
> commit in this series.
>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  t/t9902-completion.sh | 75 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 518203fbe07..6004d854102 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1447,6 +1447,81 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>         EOF
>  '
>
> +test_expect_failure 'sparse-checkout completes subcommands' '
> +       test_completion "git sparse-checkout " <<-\EOF
> +       list Z
> +       init Z
> +       set Z
> +       add Z
> +       reapply Z
> +       disable Z
> +       EOF
> +'
> +
> +test_expect_failure 'cone mode sparse-checkout completes directory names' '
> +       # set up sparse-checkout repo
> +       git init sparse-checkout &&
> +       (
> +               cd sparse-checkout &&
> +               mkdir -p folder1/0/1 folder2/0 folder3 &&
> +               touch folder1/0/1/t.txt &&
> +               touch folder2/0/t.txt &&
> +               touch folder3/t.txt &&
> +               git add . &&
> +               git commit -am "Initial commit"
> +       ) &&
> +
> +       # initialize sparse-checkout definitions
> +       git -C sparse-checkout sparse-checkout set --cone folder1/0 folder3 &&
> +
> +       # test tab completion
> +       (
> +               cd sparse-checkout &&
> +               test_completion "git sparse-checkout set f" <<-\EOF
> +               folder1
> +               folder2
> +               folder3
> +               EOF
> +       ) &&
> +
> +       (
> +               cd sparse-checkout &&
> +               test_completion "git sparse-checkout set folder1/" <<-\EOF
> +               folder1/0
> +               EOF
> +       ) &&
> +
> +       (
> +               cd sparse-checkout &&
> +               test_completion "git sparse-checkout set folder1/0/" <<-\EOF
> +               folder1/0/1
> +               EOF
> +       ) &&
> +
> +       (
> +               cd sparse-checkout/folder1 &&
> +               test_completion "git sparse-checkout add 0" <<-\EOF
> +               0
> +               EOF
> +       )
> +'
> +
> +test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
> +       # reset sparse-checkout repo to non-cone mode
> +       git -C sparse-checkout sparse-checkout disable &&
> +       git -C sparse-checkout sparse-checkout set &&

Can we add a --no-cone here in preparation for the default to switch?


> +
> +       # test tab completion
> +       (
> +               cd sparse-checkout &&
> +               # expected to be empty since we have not configured
> +               # custom completion for non-cone mode
> +               test_completion "git sparse-checkout set f" <<-\EOF
> +
> +               EOF
> +       )
> +'
> +
>  test_expect_success 'git switch - with -d, complete all references' '
>         test_completion "git switch -d " <<-\EOF
>         HEAD Z
> --
> gitgitgadget
>
