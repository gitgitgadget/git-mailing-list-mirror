Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C55C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAAB207BC
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzqtuoRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJENQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJENQv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:16:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544B2C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 06:16:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so5977775pgl.9
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HSxJ5R8cC9mgiybjOTtkXFSBKwNg5YQihwQHXIWZi/s=;
        b=NzqtuoRnrh8yvv2LmLg6VD0nvbUtn+aICA5SYsW3EopKmvZ6Pu1hbPojDYFFbeFaAY
         ieAUgtgNdyg0FVKcvl2+euRucvdV5kMfE6QCKdTx0NmdOPfD+Q0sB673zceN/6Zw3Trg
         4jGBr76lmAN915ZYwAfhw42TUdTjqVN7xNBbRIHIdLJsTgk+k7gsaKfnKwgIsANDp9ni
         Lw36BHPQuspzRuLHnL2VPZA2tALlqEszOl16DJ1Fz2AG5wJ85Ot0yILICukwCbG5fJuY
         BEzb9MQ/4XwRu/HgUtQjcJ9utTnedQxdPGvNDS2iBRBkODXP4zlCPrzXnrX062wZab+V
         degw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HSxJ5R8cC9mgiybjOTtkXFSBKwNg5YQihwQHXIWZi/s=;
        b=oZAniiFwngdRaiPJRVOG6KdxReCRqf2GcmgB5h+qnYfuWbs+Wq7yrKbBYXNqsjU/pU
         qh/MCt+asUT07L415CVsI14M7gPK3NDIfvo+GBsXXVmxOstdYyrB31iZIcouVS8uH8nn
         B0MojdKoP40TTpZ8U2b03wffuNC/23Sm/K3ZjrR1cQKGAxGh4L4vR6N2qQ3mrJ8CnCGi
         zKJgzxCzKBgWL/Xl9WwRIO58k+qJLs+V+ljy6teLnMhHP6wx0jd6v4/u0l8tHlNWICAC
         AJ2i6tIGjY56q6R1F6objtLP/ovl1VhlvCbpKHP+zIeVK5q2aFxeVvH45syoBxWKGhYH
         8QJg==
X-Gm-Message-State: AOAM530oSSaXSswD/Sz/DFM4FDdWbhdauUDsZVh22RB4hDPU36Mbq9KD
        1pblXZMIRZEXd5GAulbzIGy5sN8UFtw=
X-Google-Smtp-Source: ABdhPJy5hL5DKepbHI/TFZjqSZfGjG90XTU7QtKFjWDKJAnomwSeCOMbrv49Z5tv79PyQhJfRESv6g==
X-Received: by 2002:aa7:9af1:0:b029:152:6101:ad17 with SMTP id y17-20020aa79af10000b02901526101ad17mr9453075pfp.25.1601903810776;
        Mon, 05 Oct 2020 06:16:50 -0700 (PDT)
Received: from localhost ([2402:800:63a8:e735:e424:e5d:450a:d98e])
        by smtp.gmail.com with ESMTPSA id m11sm6696713pfa.69.2020.10.05.06.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 06:16:50 -0700 (PDT)
Date:   Mon, 5 Oct 2020 20:16:47 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 6/7] maintenance: recommended schedule in
 register/start
Message-ID: <20201005131647.GA20195@danh.dev>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
 <f609c1bde27558db2a9601ac34f8a51ce86f0e2c.1599846561.git.gitgitgadget@gmail.com>
 <CAN0heSqkJoqXKP5ccaGMA1_ppd0bcQ7G0ozUH+H7tBMonhcrjQ@mail.gmail.com>
 <bb9cd08f-1e59-ae19-b184-545688451203@gmail.com>
 <3e18199a-1dcb-057d-4753-03d5acfcc036@gmail.com>
 <20201002003844.GA28643@danh.dev>
 <2198ba04-e73a-cfd5-960c-909a4f3ef0d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2198ba04-e73a-cfd5-960c-909a4f3ef0d2@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-01 21:55:40-0400, Derrick Stolee <stolee@gmail.com> wrote:
> On 10/1/2020 8:38 PM, Đoàn Trần Công Danh wrote:
> > On 2020-10-01 16:38:48-0400, Derrick Stolee <stolee@gmail.com> wrote:
> >> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> >> index 7628a6d157..52fff86844 100644
> >> --- a/Documentation/git-maintenance.txt
> >> +++ b/Documentation/git-maintenance.txt
> >> @@ -37,6 +37,21 @@ register::
> >>  	`maintenance.<task>.schedule`. The tasks that are enabled are safe
> >>  	for running in the background without disrupting foreground
> >>  	processes.
> >> ++
> >> +If your repository has no `maintenance.<task>.schedule` configuration
> >> +values set, then Git will use a recommended default schedule that performs
> >> +background maintenance that will not interrupt foreground commands. The
> >> +default schedule is as follows:
> > 
> > I don't mind about using a default schedule (but someone else might).
> > I think some distributions will be paranoia with this change and shiped
> > with disable by default in system config.
> 
> If a user wants to prevent this schedule, then they can simply change
> any one of the `.schedule` or `.enabled` configs in their --global config
> and these defaults will not be used.
> 
> Of course, perhaps you are missing the fact that "git maintenance run
> --schedule=<frequency>" is only run as a cron job if a user chose to
> start background maintenance using "git maintenance start" (or "git
> maintenance register" after running the 'start' subcommand in another
> repo). So this is _not_ starting by default without some amount of
> choosing to opt in.

Yes, I missed that fact. Sorry for the noise I generated.

Thanks,
-- Danh
