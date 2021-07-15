Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A82C636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 20:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF44613D9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 20:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhGOUlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbhGOUlL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 16:41:11 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEAEC0613DD
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 13:38:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s23so8273439oij.0
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTF25HvoYoxoKTkSeyFqWfuVHFLpNU0s1HrwoYc308w=;
        b=Zymb62K96UDK6VVYRg/0JFwKOEY9RvQUvR219TyibG0uiQPsBloDOztwpSP6v17Y1/
         nj30DV/I9vi5zTfmIarJJU916a4EGgE+goayQ+CPjAuNqnus9U62MYmjpMzHiiO2wWRC
         pUvxXmeEyreVVuMFop0kofAC4toCluwLQ72RHIOIYw3FFjEJfJyWuKTEGiXKT53hMUKu
         6arAbpbnMvGDsFy9LHlSMD5GQ2hZFbjgGky2e9EOZ1Ywfg+UAfW0BhmweAt12T+dtXOi
         KP/uxHG8+MSWAlCY4G2mIA/sKxDllfxFkz//bUPrsxUUZMpi3taiEUGSNK6rscvBZl2I
         Gaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTF25HvoYoxoKTkSeyFqWfuVHFLpNU0s1HrwoYc308w=;
        b=ScR+pM51kLoddapJt7kFLJc7XOU6g1I3IFNXe1HpHOGE1Gio7AsYsBp5QMMbiS6owe
         Fj/4cOToZlvpEs8IPlEF6WUZP58sNoV+rBq7BSRtXeYa7FRC6l0iI0GL83OHhSFIhVK6
         viD5X0a4pDHjR1iOpEh+jAuPOOe+nbj0HnVt+E88/QKcYnHG5pWPypOjQibDbTIt80Qo
         HA9wmhZ/9gGT8uSgxU1wEDvEPhH8J4oxVg71EtxUFaSO96L/7WmbMh/HE7zePLOSIInq
         cyeQGcu6oIqvb5kNbJqdS10xYeJqsbkwSKz5KHaxbUuVFRVDizuDtj12uf8YFhy3eBx4
         BTYw==
X-Gm-Message-State: AOAM533qX2Ib2WLme+5EKCfKBZoDH68QNpvm/4GPA3Cd+U8nTycXyvvm
        s1azT4hfdCAPFhj+Kl4bfP4xUHiaui0euuOZy3nAr5c9Sk4=
X-Google-Smtp-Source: ABdhPJyBNffDfwODZEUPj5eIrHJlgVImGgzEzxtXIJpeEqqT4MVcd1S9/DXWUnhzSS7tA7eYm8MrAI1jg1yDHqEbpAg=
X-Received: by 2002:aca:38c3:: with SMTP id f186mr1790130oia.39.1626381493135;
 Thu, 15 Jul 2021 13:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
 <xmqq7dhrtrc2.fsf@gitster.g> <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
 <xmqqlf67s560.fsf@gitster.g>
In-Reply-To: <xmqqlf67s560.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 13:38:02 -0700
Message-ID: <CABPp-BEhQqG=AtqVzW0Ud0NNPJ5SCXYBWoNVq9_7ERfPYLdhNw@mail.gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 1:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I thought this was the biggest hole in my proposal: there is both a
> > git merge --no-ff and a git rebase --no-ff, and they avoid
> > fast-forwards in different ways with different results.
>
> When you say "git rebase --no-ff upstream", you are telling the
> machinery that even if your current work is direct descendant of the
> upstream, you want your commits freshly rebuilt.  But in the context
> of "pull", you being descendant of the other side is called "already
> up to date", not even "fast forward" (the ancestry relationship
> between you and the other side is the other way around).

Oh, good point.
