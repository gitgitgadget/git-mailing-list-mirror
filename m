Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19A01F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJJBdl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 21:33:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42048 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJJBdl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 21:33:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id b7-v6so2568123edd.9
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8NhrcmVXCadbH3evkJ9UgUlpsbXQJoUAycBhyDzh/4=;
        b=c4P3UL5KhDPMJVOIJEJcB2zFGEDOA9n9w9NcDvoul9mIZSCKjjL5duWT0K+noG/t/K
         eB3QCrrsBw9oguhB/8m5kmgTJuWLuJg4zYuJ1tJDQfh0q6BUG5n8xSQ2BsKdlhcyRJ+H
         D1YlwUKPiMqsbSibW82rdBWO+ZjZdDLLMjs5yToZ7hlRk2eU329ZGK/wzjReU/x02gvX
         4lL8yS75QM06wziKCtCuvoC+xgWu/ciAcImao4/MPkbHiHxJCcS2yJQMQM48klY8GWfS
         tSMQiJt+tbTEpRdDaCCUzF1xdnFFLWmu9EzHFG33THE+BqNYLaK9+uiusW04qkSCco/Y
         GTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8NhrcmVXCadbH3evkJ9UgUlpsbXQJoUAycBhyDzh/4=;
        b=IfrOi9GMyAVJKpRk7Yzq4sn7XSDPnl9h2GafK0pMNu7a70UoDz4bXONdtaynKu8fmM
         kGimrM8javMkaM21UliXIX7zqHUXRPujvuMV9ZSbKg6xtCvjmjRNuy/cIm1Ff26P/iKQ
         wXOp8G6UjuzJw3Q2VBu2VUl1pG7ieF1vLs8ctxxQKjUKiDMy1gs6/DArYVCnPf4ObE2u
         ai8/3KyOirGWtetpmGDccTR4w76eOGD2U5SE7wqcDWveSI4BgLm5bV8szcMEaZz0MZZF
         cCkjBiHVaQp6CsUQCjuvrE12czMPDnPguqjfhIkpJNjER7ySd1CMFnjPPTOU+YDbC/PD
         ElbQ==
X-Gm-Message-State: ABuFfojFVGcVgDpbIgdwebvCIoN0SUW2J9jcSwzozXKR6lit5NIH5Fms
        O15Qz+AMSsavf9xXW2jY233pRZZWR2q0+atcMWzMc32BKcBong==
X-Google-Smtp-Source: ACcGV62pX6bOwBm9UCqJzaiDZ2imAt4fcxKdFRO96Mpy3jtGwd8Zg1wHOtriiWv4Guzubh+/OVQiM2SM/+C2xne68c8=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr35945534edc.76.1539108926903;
 Tue, 09 Oct 2018 11:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.27.git.gitgitgadget@gmail.com> <725ebadc92a91469eed089eb501b705c2dd2c627.1539011820.git.gitgitgadget@gmail.com>
 <xmqq4ldvqyci.fsf@gitster-ct.c.googlers.com> <8b5dbe3d-b382-bf48-b524-d9e8a074ac4d@gmail.com>
In-Reply-To: <8b5dbe3d-b382-bf48-b524-d9e8a074ac4d@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Oct 2018 11:15:15 -0700
Message-ID: <CAGZ79kZHEco4KJXzGDfVTtp9ad1EqQdHCe4Y9yVMGGiAECjUQQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] midx: close multi-pack-index on repack
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 9, 2018 at 7:11 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> CC Stefan: Is there a plan to make get_object_directory() take a
> repository parameter?

Not an immediate plan. Regarding the large refactorings I am mostly
waiting for nd/the-index to stabilize (which may be stable enough by
now) before proceeding.  Specifically 2abf350385 (revision.c: remove
implicit dependency on the_index, 2018-09-21) is a missing piece that
I want to build on.

My next step is to look into making use of the refactorings that we did
over the last year, so I'd rather look into more submodule code again.

To come back to your question:
    git grep get_object_directory |wc -l
    30
    git grep "objects->objectdir" |wc -l
    11
2 out of the 11 matches are from the implementation of get_object_directory

So either we'd actually teach get_object_directory to take a repository
and inspect the 11 occurrences of direct access to objects->objectdir
or we'd view get_object_directory() as a fancy wrapper, that we might want
to drop eventually.
