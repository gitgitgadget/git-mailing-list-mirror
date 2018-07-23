Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67351F597
	for <e@80x24.org>; Mon, 23 Jul 2018 20:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbeGWV4V (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 17:56:21 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:38991 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbeGWV4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 17:56:21 -0400
Received: by mail-yw0-f171.google.com with SMTP id r184-v6so742235ywg.6
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EdtIr/vnIYm1yqyFVMW88eE7gKXosocZXUqQB3LBRg=;
        b=tDhHBcx5bvLix2bLLn3mdv8c4/dS/yaoSpw6xU7TNYGGCk8G/HEMuhgvwLF1OnHIRf
         R5SudHtF7+hI8VIvogJhKKjKJXuRw5oITPFjVaRetZfic3CCugiGRkOkDJIPoyKGWTgR
         w4pgrYRWuj3HZ3J0tr+MWeMdSK0FcZJ5Tbuq6SUCZTTLdCTThpmCf2G2f/IbvxTaxh7r
         SHrQgAMCRF2LaG4vNMDJsGInIzFdx4D+wcmAZW9M1YX5pdlfiOrgVz1bEC81d+s0BDiQ
         mrXk9V0O40CtiXnUxQqg4xJJLskZv3h0iHitnmyFkbpq9OvAksPmPm7/AvpsgPh430Yz
         sLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EdtIr/vnIYm1yqyFVMW88eE7gKXosocZXUqQB3LBRg=;
        b=B+85unWOi91SmMSO3pO74E5D+9ule/c2sRYHm6nwYBdxvtHtn5f2gE6zzrv6ezJC6A
         h4BeKuYCA+R8QCbZsOrntZREvap6WLNu5WBOYAXNiEy5CX9HQ3FJZeapQvWr+fTpRzpU
         szWH/P9D/javoBfQbRxt5hbIhXRFzAzi0NJ+HrUZVxVMpJbJhyqQqdqTyLOm+n5SZ1Xn
         3nJmPVDxysiGHypHZA9prqDMgYiiyYufs5OyYCVHl9HnaaqXSyDLWwqo3NWUs9Yh5tg5
         XxQzegM2/NqXGwMmd4ieeJWqs5VKAI7szEw4Db91RQa+9ctyMZi1J3Q557uynH26Tuqc
         eRIw==
X-Gm-Message-State: AOUpUlFDMA2PsiKwso4z5I3N0GcMAnR54ETTwTOKq79v9LWj5CMsQ5hW
        SpgPWQLubOTWK1xQETsvr+f4EzvdBbioy9PPdI8LGA==
X-Google-Smtp-Source: AAOMgpfUnharX7Q23qdu+jf37tOYmI5C1MGcFXVtxvhqhm8jvq6qv+g7sKcmTGXlbdDiQ/xS5KnAJlWei8IXcJE/Dzc=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr7506331ywj.33.1532379201551;
 Mon, 23 Jul 2018 13:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.12.git.gitgitgadget@gmail.com> <78f7a5e4baae162d1dff18701a25903b304adf9e.1532353179.git.gitgitgadget@gmail.com>
 <xmqqmuuh69xx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuuh69xx.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 13:53:10 -0700
Message-ID: <CAGZ79kag=YC6PxOnBbVAqY92dNd5yuqfvash-oPVrEktowNbVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] t7406: avoid failures solely due to timing issues
To:     Junio C Hamano <gitster@pobox.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 12:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > To prevent such false positives from unnecessarily costing time when
> > investigating test failures, let's take the exact order of the lines out
> > of the equation by sorting them before comparing them.
> > ...
> >  cat <<EOF >expect2
> > +Cloning into '$pwd/recursivesuper/super/merging'...
> > +Cloning into '$pwd/recursivesuper/super/none'...
> > +Cloning into '$pwd/recursivesuper/super/rebasing'...
> > +Cloning into '$pwd/recursivesuper/super/submodule'...
> >  Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
> >  Submodule 'none' ($pwd/none) registered for path '../super/none'
> >  Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
> >  Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
>
> Thanks.  It obviously goes in the right direction to loosen the
> ordering requirement that fundamentally cannot be met, as the log
> message cleanly analizes.
>
> Do we know that the write(2)s that show these lines are atomic, or
> are we merely lucky that we don't see them intermixed in the middle
> of lines (sbeller cc'ed).  I _think_ they are but just wanted to
> double check.

Not just the lines, but the whole message per submodule (i.e.
the "Cloning... " lione and its accompanying "done") is one
atomic unit. These messages are from processes invoked via
run_processes_parallel (in run-command.h), which buffers
all output per process.

This test was last touched in c66410ed32a (submodule init:
redirect stdout to stderr, 2016-05-02), merged as f2c96ceb57a
(Merge branch 'sb/submodule-init', 2016-05-17)

The parallelizing effort was made before that
(2335b870fa7 (submodule update: expose parallelism to the
user, 2016-02-29) via bdebbeb3346 (Merge branch
'sb/submodule-parallel-update', 2016-04-06)), but did not
review existing tests for the newly introduced raciness.

Thanks for the fix!
Stefan
