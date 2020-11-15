Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E706C2D0E4
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD2322409
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 20:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="NhdqNP4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgKOUMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Nov 2020 15:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgKOUMR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Nov 2020 15:12:17 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD87C0613CF
        for <git@vger.kernel.org>; Sun, 15 Nov 2020 12:12:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d17so22060373lfq.10
        for <git@vger.kernel.org>; Sun, 15 Nov 2020 12:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pi++HyxrgdabWj9DENuFjSrdv0GxXosKylW8BVKEWxY=;
        b=NhdqNP4R9egT4udNPtbak/WmiOJFAr6ZHq8H9fg1Bd0M2TpqBA2IK3lD6mAN1ls11K
         PmbTZEXeNnU2QHPRvUj/ibP2RtDgt/+3+kp/LnfR/CySxS0If6/6TA2ispiP4xp33Vn6
         SUlk2zxk0m+9eSGYQp4RcYX5ApjVSemudZv9BtXnwLp39sHrdyAsQNPQ9UJ+QakZr4My
         QgzMNsCDCopvZjMxu2rBvvjpHQrUb51a7BQglEQPDvM/cTdcRdHpmGSk06VkI6dqC2bd
         OabxBpccaHOf35d8k/wYTStO+BvEA9DIMEAb6UaZIO1bjoeA+fB7Zj7ISBk6uK3GNJpk
         /z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi++HyxrgdabWj9DENuFjSrdv0GxXosKylW8BVKEWxY=;
        b=Us8aMashDctoeznGeCVPgsBlEJKktmnA5D2cEWfZ4kskWKuRhgvBhOJj27WuSFQMKq
         iFv+mJwAcCx8tZ+bGDGtXNdpNsnJk/z61HNOUrqXeU5BTcW21FCjaVs1oJjQ/pMRr4P3
         MxCKJf0Zvcio48DkanbDY+3qxG4DZEtF6x6TAySASeB2h2/armsasZEHCj/oNqLKLM7P
         f/p+g2r1+GoI+iE36N7gPQmZqNBJ7u62zNi/93jQ/Y35KJ8+izbIFU7oOyUpVg6we3jS
         YRLofruYI9PiM5AMWgBCujXMUWm+tUy9ehtjlvpzcbNGtu+Z5ekduOv/tbxwsravZhhU
         ATDg==
X-Gm-Message-State: AOAM5325QsWxw2ixnISeRBuJtgH8hNiKWALI4PWONd6l8zLVmHN+BPt3
        2X4G87HupBPerqpZ7NaI0SG3+CaQR0VQ7lOQikqyMg==
X-Google-Smtp-Source: ABdhPJwty7l6H2C8y+27PCe54qnM8nQXIO9rEkVzZRimRG27ZjUQWYPWCyDfuxzH5si8H8vMhQj4OasMEcJcfkvVzLQ=
X-Received: by 2002:a05:6512:348e:: with SMTP id v14mr4084416lfr.97.1605471134088;
 Sun, 15 Nov 2020 12:12:14 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com> <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com>
In-Reply-To: <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 15 Nov 2020 17:12:02 -0300
Message-ID: <CAHd-oW7X3fEM8PDFWQVc4kG_vfkY4LbvADzJfQrocjyaAr28TQ@mail.gmail.com>
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Stolee and Elijah

Thank you both for the comments. I'll try to send v2 soon.

On Fri, Nov 13, 2020 at 10:47 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/12/2020 6:54 PM, Elijah Newren wrote:
> >
> > Do we also want to include a testcase where the user specifies a
> > directory and part of that directory is within the sparsity paths and
> > part is out?  E.g.  'git sparse-checkout set /sub/dir && git rm -r
> > sub' ?
>
> That is definitely an interesting case.

I've added the test [1], but it's failing on Windows and I'm not quite
sure why. The trash dir artifact shows that `git sparse-checkout set
/sub/dir` produced the following path on the sparse-checkout file:
"D:/a/git/git/git-sdk-64-minimal/sub/dir".

If I change the setup cmd to `git sparse-checkout set sub/dir` (i.e.
without the root slash), it works as expected. Could this be a bug, or
am I missing something?

[1]: https://github.com/matheustavares/git/commit/656bffa1793ce86b638d7ad1da2452103ce8b14b#diff-69312bb98fb0cf46e6906e3384c11529f3f04713d331a85d67fc77a3e43944f9R919
