Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D5EC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86E761248
	for <git@archiver.kernel.org>; Fri, 28 May 2021 17:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhE1Rxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 13:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhE1Rxj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 13:53:39 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604EAC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 10:52:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so4263485otk.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MRzTwO4gd/ChtigpTfn0qe0J5rVVHMD4p8oplqI01ns=;
        b=MpPQ9Q6kQ+HdgH4LZKNWSbgq3vZlZCgEDG0zn79bbNahf0RtCImcZDsBFQubbNe/+0
         ILcIM32KXchPwVxseGGKuI2SAkvC1/xd1rLVimCt6cogoeQ6IRcKIe6TOe9npLdVwV96
         3aj8czSpBewKDz7PrhAjSBc2d38wWbHC4RlmaJABSKIJSbv7BiO43uA/yTXRFoZfnO0l
         ctNrkZNvH4/OCJTu1JWCOTXJrSMTRHPdLAQ9XgC7/+/YsGp2ax79yUiyDcJ2F02enCat
         VlsNmkM326aVsMvRM3bgwxmZp0ZQXAjg0C9+77wyEoshE3rJksv0U3wsvZMgt9bMrSlu
         ryMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MRzTwO4gd/ChtigpTfn0qe0J5rVVHMD4p8oplqI01ns=;
        b=cTt8CaooofHVdYIokp7gjFfqeryRsNmtfyw7Cj/13apqlq7akkFMsvcWY42t5witfu
         773aigl5UUbnardaZrq1CopyYJ2BVG9c5KQkipTvcpiQbIArPaYoK3FoK7o10ShAd8Fx
         Dl/r70vyEl5eFnmgsE+HWAEpoQiti4Ud88WPcX5Km7dA4jQEo3pUpjuKg0MeQBX/+Khh
         TReRTcnf17msuoZWMS2HFF23+I4pkfy7IAThnxPN6mxD8gg6KpxD6orGxwzVZoD4nfb0
         yY7E8k93mdCNApP0IfKIjipPRyA9m6j+RVJsmW4WKpYl0+VmONp+tpQFOtjbOZf7U55T
         jWHA==
X-Gm-Message-State: AOAM530f1iFWQJhpsu/9x4S3z7ZrIAmqoqb5C+zghhErWzBQ2XAutxXw
        6BgMFBGvguJzHppUOP5coqzg7CzSorw9Cw==
X-Google-Smtp-Source: ABdhPJw/gNMLi0RqgcKrd//kxc7+lqLN8Dbf24vC7zqaddJPkdGRne4RE9iTLcwKMutP5+2loCOx+A==
X-Received: by 2002:a05:6830:1518:: with SMTP id k24mr7753064otp.40.1622224323752;
        Fri, 28 May 2021 10:52:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id h2sm1200478oop.47.2021.05.28.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 10:52:03 -0700 (PDT)
Date:   Fri, 28 May 2021 12:52:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <60b12dc1f19b1_5190820879@natae.notmuch>
In-Reply-To: <f9f38d42-2b93-0d3b-798b-4c6f44eb111d@gmail.com>
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
 <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
 <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
 <f9f38d42-2b93-0d3b-798b-4c6f44eb111d@gmail.com>
Subject: Re: git push doesn't use local branch name as default
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Kunter wrote:
> > you only get the "current" behavior when fetch_remote is non-NULL.
> 
> Well, then my suggestion actually is to also use the `current` behavior 
> when fetch_remote is NULL - i.e. change
> 
> > return (fetch_remote && fetch_remote != remote);
> 
> to
> 
> > return (!fetch_remote || fetch_remote != remote);

It's not quite that easy. You need to see the context of that code:

  static int is_workflow_triangular(struct remote *remote)
  {
    struct remote *fetch_remote = remote_get(NULL);
    return (fetch_remote && fetch_remote != remote);
  }

That would affect many pathways.

> I'd argue that if `simple` pushing is used, then the expected behavior 
> of the command
> 
> > git push <remote_name>
> 
> on a branch without upstream would actually be to use the `current` 
> behavior instead of bailing out with an error.

I agree, but this mis-mash of modes makes the logic very hard to see.

I'll send patches to cleanup the logic, it makes no sense to have a
frankenstein of two modes and that is in fact the default mode. The
logic of the default mode should be crystal clear.

Cheers.

-- 
Felipe Contreras
