Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E23C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3D421D40
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKQfRn/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgIJCAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgIJBwb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 21:52:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26679C0617AB
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 16:32:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c196so3670809pfc.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ejk7ltELmW/MvSu2OKAJSK1SrjjHZjUu7YypBs/pKkY=;
        b=QKQfRn/Sr2inUm/JF8NfVFXWjezzGcno5nDSFZOiZYmeqRRaYCB1kEhrxPpdCuGCCJ
         A8R9meVoYYdfv3zYFUTgIqEM8ehQYaDmd0tbv99N16Lh0+8i+zTULmt6YfA6YOGariD+
         NZdJnQOZ1iRaRrjTqV0nGCwzEtLbImpnvTHER4ocrJxUBtHnZR5th1UCfkbMN3bJH6A3
         HhOgThAKq9RbKRxuPN4VIYgtKZ09f8P95ggN2dlvNG7IhYA2YeuzF1PhJXpzN47rbT2n
         ByCiptoIQN4fwZb7q6MBjKcQ4/M4Dl/rajV/TegokDom+vAKNNrzM+KJCyZFP7zOLqMC
         X1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ejk7ltELmW/MvSu2OKAJSK1SrjjHZjUu7YypBs/pKkY=;
        b=EyjTeFuwaw7YK7XCH990r3vH3ur6nT0hlwg/XaKSJWy6qU7NvG/l3YL1wG5NHqqQkX
         /ysFfhxr7bG2C+c72Q7G8sZy8+KkeOMr353NvaW7Zo7AT7ejj6RVnK8Uw3W3cRzgeUIf
         wCvVTLNZAsBOTsn33jZ+hjIOAreLDx6vlNhNjqak8kGvu3Sc+ZBAtJgfi4xyWiM8eMFv
         8M+zq/le01OP3NL+UHsHF9u4/zxdWdsbaAySV2ZXuSNl90YE6RtVruSpvWWGgJ8fHtRy
         nHjF1uMBYm8rMyQzqBa0EdL3XINn9q3Y4HePYyH6zIutghjodY2iUiHj+rR/UPw0NvDG
         9SpA==
X-Gm-Message-State: AOAM530RgRiJEe0lzQDTbC0YvTkqsbd14xujEPiJFOBUi7GGJCLzDTxG
        uHzy7ft8ohpeoCHRmObd/whRXdBRa1E=
X-Google-Smtp-Source: ABdhPJwoDaR9RcAEJVI/iLlMZwLV/nn/bhIbE0loUBa/XEeBAINiJ+en0skUkAt6oqFBX5kLlekl7g==
X-Received: by 2002:a17:902:d354:: with SMTP id l20mr2999329plk.81.1599694370603;
        Wed, 09 Sep 2020 16:32:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 20sm3846300pfv.87.2020.09.09.16.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 16:32:49 -0700 (PDT)
Date:   Wed, 9 Sep 2020 16:32:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 6/8] config: correctly read worktree configs in
 submodules
Message-ID: <20200909233247.GA667601@google.com>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
 <3e02e1bd248438e0b435a19d857432edcaa15a2c.1599026986.git.matheus.bernardino@usp.br>
 <20200902201523.GA3941032@google.com>
 <CAHd-oW6jCiaXdsKnhde0iBDWXpZyh4cf5j_8zW7x=W3BaZ9Kbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW6jCiaXdsKnhde0iBDWXpZyh4cf5j_8zW7x=W3BaZ9Kbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Matheus Tavares Bernardino wrote:

> Sorry for the late reply, last week was quite busy.

No problem.  It's an unusual time for everyone.

[...]
> On Wed, Sep 2, 2020 at 5:15 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> @@ -1824,27 +1824,33 @@ void read_early_config(config_fn_t cb, void *data)
>>         struct config_options opts = {0};
>>         struct strbuf commondir = STRBUF_INIT;
>>         struct strbuf gitdir = STRBUF_INIT;
>> +       struct repository the_early_repo = {0};
>>
>>         opts.respect_includes = 1;
>>
>>         if (have_git_dir()) {
>> -               opts.commondir = get_git_common_dir();
>> -               opts.git_dir = get_git_dir();
>> +               opts.repo = the_repository;
>
> I'm not very familiar with the code in setup.c so I apologize for the
> noob question: have_git_dir() returns `startup_info->have_repository
> || the_repository->gitdir`; so is it possible that it returns true but
> the_repository->gitdir is not initialized yet? If so, should we also
> check the_repository->gitdir here (before assigning opts.repo), and
> call BUG() when it is NULL, like get_git_dir() does?
>
> Hmm, nevertheless, I see that you already check `opts.repo &&
> opts.repo->gitdir` before trying to use it in
> do_git_config_sequence(). So it should already cover this case, right?

Right --- the main point is that a BUG() call represents "this can't
happen", or in other words, it's an assertion failure.  As a matter of
defensive coding functions like get_git_dir() guard against such cases
to make debugging a little easier and exploitation a little more
difficult when the impossible happens.

[...]
> Thanks a lot for this :) I was thinking of adding it as a preparatory
> patch before the fix itself. May I have your S-o-B as the author?

Sure!

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,
Jonathan
