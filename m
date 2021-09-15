Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C3DC433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A922610D1
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhIOQe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhIOQe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284E3C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:33:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m3so5344900lfu.2
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBoehdbz/wWskZ8bUHwy9f2MWkTTtFhTQ//4BBO2wD4=;
        b=sq/9SN10oOSukoEdkKP9a/UEQqL8Z95ezqAbMFkHyYSCPmEPStO/fouOyOJw0i6ZRd
         pk5LkBDqYwNLsdDl/XPDsdNqm7smLtfh+Sx2YsUC6vZsP4mrKj0nV401+4tHYqF9bP8a
         tT1V55atEbyoMi0I6BhOMvSq/ozEzuI1o5kye9qSrmqJiBkBpVGoCkH2tt32xvdohBg7
         MR+KWyhBph5wYq0zOHCLRmiORWg+DdZTq1JjOxXrIJFnDzpSHp+YYm8HZQ7b2D6TOS7f
         Jk+oiyorHwEI4XVtcG69eVc5hLI+XxuRjuvRajQIjzMav5DIqoqq22SMWNcMfhg5qX8R
         LsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBoehdbz/wWskZ8bUHwy9f2MWkTTtFhTQ//4BBO2wD4=;
        b=siaz11rnZg+yZVBINoyH+LTCIqv36VasJF+R+O3rQOcbTJqHf+x5QduVTMjNIlO/Im
         PPPm5w3zsGRx6esTM4GJkIeMI+W0slnqdaYXrPdkbjjYBW950htUuQRdwBDwP6lQmcFN
         qcMxSr8y8r4GtPIhi6lr9buZSuvLcqOsxOXLskY9p3v7p5zyDkZPY3f3y4SM0ge5a5Ot
         +eHFiGT+Pf+yAoMAG3bsCcgOfprF6tXZNqFjAWdgI/jQMrop/gGyT7Wiwr9u0TgifHf5
         nwudtcULvqUe5Izjn83LkdjyQzkvt5ufOj1yT/BQl+Fxgdu4qsqWHkaUoSXkIQdFDmYb
         Ky/g==
X-Gm-Message-State: AOAM532sLBJnDEeZMNohaYMd+6OFsGDz+rziGv4KFPW6DbH9ZSFXAo8Z
        jEuPlXcBBkfw6uM3ccwq0lqPaNtSOAnDwBBM6m953Q==
X-Google-Smtp-Source: ABdhPJzvhr6v5sN4iZjDWtvbd/lDV9D7gAkfsYCHU1ksGMlYBykT/vLtf5GsDGK6OWw0ECg4y8AO+E0SFdzCj634PlI=
X-Received: by 2002:a05:6512:1329:: with SMTP id x41mr603588lfu.9.1631723588434;
 Wed, 15 Sep 2021 09:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com> <8aefce6254c0bcbbbca909a62d033c74c90f980b.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <8aefce6254c0bcbbbca909a62d033c74c90f980b.1631453010.git.gitgitgadget@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Wed, 15 Sep 2021 13:32:57 -0300
Message-ID: <CAHd-oW59G6MF04aUA-XJewa=0VnqbHenb2khkeO7U9egW_6S4A@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] t3705: test that 'sparse_entry' is unstaged
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 10:23 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The tests in t3705-add-sparse-checkout.sh check to see how 'git add'
> behaves with paths outside the sparse-checkout definition. These
> currently check to see if a given warning is present but not that the
> index is not updated with the sparse entries.

Hmm, I probably missed something, but don't we already check that with
the `test_sparse_entry_unchanged` helper? The only test case that we
don't call it is 'git add --refresh does not update sparse entries',
but we explicitly compare the cached 'mtime' from before and after
`git add` there.
