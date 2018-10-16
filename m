Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34401F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeJQHG3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:06:29 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:41469 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJQHG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:06:29 -0400
Received: by mail-ot1-f74.google.com with SMTP id v40so17921087ote.8
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gjgCJBkHQCX5i7dUXtiNs0PYAbihDxCqNpUfoAnfFlc=;
        b=vzhkJjQxPVARHHYfR0IQstoFetnmPBWKpZHo2JS9c+7xPTR27Vv6u6rzR2w5z4IwUn
         4ic3MWVm1obTauZ+HVr43mRHF0zRZsDSj0Xj1k5GQCFf4W+FWpUbUrWt25wjTpsw36Sl
         r9sB1gjlz9bho1xHNunRwhBi2KQ8F9shl0UOli9qg9EZOOxJgHa4lRZ8BUyfGFVVWptR
         m2zLAHLMncbK4Xz8cL/AdWLsCu/Q8km7WwaMdaptg/4toItB1fHBaWd72ZCXzFQjXQYk
         4x0UZXxATKbIjQoYlBLaQPT4ZCbX1ZUihaj+oX4qc/5dtQjY4ncl1Rl8SZL1j8PvY8+U
         gGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gjgCJBkHQCX5i7dUXtiNs0PYAbihDxCqNpUfoAnfFlc=;
        b=aiJ6rTvpik2FbuX+CpMl+CopsK7gHQcrl5AQxg12+5uzXmB2VaJf0nqQimibXZLFKC
         ZvymaxXc//hTsbKhOq1wWeM/VWpowlScVvZI9DHrgzAUSUKFLkFrlwdWvCgw+Tc65Ike
         hE7iRMvSYGNBz9HSkmJWCecA74SgKood13JC6HMD892ywaarLRMaanGzv3Dt97vDEN5R
         9kAIQk3Wu7+5IQSLC12XjsQEUAQ0GdTwmZi4NpxiLe1w5bqyktkySwAF4NFftHxVuISY
         /pZ9TSmfY4Ji02uZIFu08FGemZUaGWqKMXSOQagI4eDzJIAv7NPbVrb2hYaj3CbuHJMM
         gitQ==
X-Gm-Message-State: ABuFfoj5mbAQ/Spmxj2ZYJL6vaJs+2QAjZQWj3EpjnLxsfNoo+RWHwzt
        yfebI6VWzC+qauVIgB49UZkvVg/yi3iz+MDhbtmQ
X-Google-Smtp-Source: ACcGV62/nFA6M/v67y/7/wU7jH9YueEdp9gMVp0mNTFJlHfdCy9hfVJhfSRbJmYevFCyW3ZmyLr933Zl0Huj5i6wWGr1
X-Received: by 2002:a9d:3f90:: with SMTP id r16mr20159801otc.38.1539731628606;
 Tue, 16 Oct 2018 16:13:48 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:13:43 -0700
In-Reply-To: <CAGZ79kYS7at89igHdg163mcZGmsOXO1jj6iBqSZF_VuMEh=g9A@mail.gmail.com>
Message-Id: <20181016231343.189184-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAGZ79kYS7at89igHdg163mcZGmsOXO1jj6iBqSZF_VuMEh=g9A@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 17/19] submodule: use submodule repos for object lookup
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks for the review of the whole series!
> 
> I have redone this series, addressing all your comments. I addressed
> this comment differently than suggested, and put the submodule
> repository argument at the end of the parameter list, such that it
> goes with all the other arguments to be filled in.

Sounds good.

> I was about to resend the series, but test-merged with the other
> submodule series in flight (origin/sb/submodule-recursive-fetch-gets-the-tip)
> which had some conflicts that I can easily resolve by rebasing on top.

I presume you are talking about [1]? Maybe consider rebasing that one on
top of this instead, since this is just a refactoring whereas
submodule-recursive-fetch-gets-the-tip changes functionality, from what
I understand of patches 8 and 9.

[1] https://public-inbox.org/git/20181016181327.107186-1-sbeller@google.com/

> It conflicts a lot when merging to next, due to the latest patch
> ("Apply semantic patches from previous patches"), so I am not sure
> how to proceed properly. Maybe we'd omit that patch and
> run 'make coccicheck' on next to apply the semantic patches
> there instead.

Omitting the patch sounds good to me. For me, just stating that you have
excluded any coccinelle-generated patches in order to ease merging into
the various branches is sufficient, and people can test the coccinelle
patches included by running "make coccicheck" then "patch -p1
<contrib/coccinelle/the_repository.cocci.patch".
