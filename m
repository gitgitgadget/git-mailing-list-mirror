Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D3CC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FEB61040
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhHTQLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhHTQLs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 12:11:48 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E9C06175F
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:05:17 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so6327934otg.11
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKN2cq+0RV8OCBInSVtSIxt9iI7wGUKSd97VZQButLE=;
        b=HtRKjgFHAuLEWjW9USlnKqAUiZRMR1E82g/SgOD4c5hQAa6VhQpYtMdVUuSTJLTk6S
         4m7hthxCu/wH/HtE6UJ2QjU5eGuobsdDjRvckSK0tlAiZ5ZxNWG5rIssm2oCT/0iFJcD
         jilBOuk2ZWgE6/Zt2GvTJ7n71jC5EFydp0FVkfV1OnLxrcOap26Zf8xqUQVdvTHxetsc
         ZpRd3HWnjYFeNkx4PV9cKOOJZ2hJwT2z4a9q9ZXnQPjv3SJfXVUIFdbCjs9yjp7x20Qk
         IvvK5K1B7mUh0OXviMKaHxws3mPA3f3M2F3hAvNvzz95SATpbOPy1czPRb1wG3UrCjT8
         +MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKN2cq+0RV8OCBInSVtSIxt9iI7wGUKSd97VZQButLE=;
        b=seg0B9bDJeDTsEF3y7/pSvU0Dnkg9YN2/bf1uLfhydy8EuAWCXiK4bmwVHb39g9Tk1
         PCr1lHms9j2ICZVQzJiFzpS1wWsAZMriyHFTJduZAw+8QF4p+00hdyesrkpzQMN4xO+K
         o2fcTkl3XuZGNCp6lTuFg4vSL3tjz/eYwhvh/k5GYaWsezlKnPwqa5jrRYpf//23W8J+
         mpkYwyqaeIlSOp16YN2NOgSGDS8fBUTLeCZKCYndi9Kh92yAM+DCYe4JNUCunG6apVjp
         2xSxZh8Odzkqv38KWLN3a1mkRv7LlXPsdlSWZ9MH9KYH6/fN9u/2vz3FDXXVpesndax/
         9ZBw==
X-Gm-Message-State: AOAM530pO4YKg7f4u9c+Umdle6uZGHmtlhBWWVc7ky8q1wiRNfiGD08v
        3TsNYEOV5PXkZqV8RrblisAvsMeC7RPggfUi4vQ=
X-Google-Smtp-Source: ABdhPJyMc8q93al8RS/C8TXbH+9VlSy9BfMFLgprnnLIAd6YcgdKxrckZ6Bu1O1ZFUO+gat2JQUepVHuyE178E/ayho=
X-Received: by 2002:a9d:630e:: with SMTP id q14mr17199032otk.316.1629475517019;
 Fri, 20 Aug 2021 09:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <c9e100e68f80196a35a37b5d0aad74e8e1174766.1629206603.git.gitgitgadget@gmail.com>
 <CABPp-BHqTSv7MkS8-nq3Qg3CA3pLxSD9TOVvL_8R1-eF3Rn7pQ@mail.gmail.com> <07cc5a17-024a-910c-35c5-0dc468172f5e@gmail.com>
In-Reply-To: <07cc5a17-024a-910c-35c5-0dc468172f5e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 09:05:05 -0700
Message-ID: <CABPp-BEf0JEc=VgjFVcpF9uZq8aD492Pkf-OzQC_us6RXx6drg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] attr: be careful about sparse directories
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 8:39 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/19/2021 4:53 PM, Elijah Newren wrote:
> > On Tue, Aug 17, 2021 at 6:23 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +       /*
> >> +        * In the case of cone-mode sparse-checkout, getting the
> >> +        * .gitattributes file from a directory is meaningless: all
> >> +        * contained paths will be sparse if the .gitattributes is also
> >> +        * sparse. In the case of a sparse index, it is critical that we
> >> +        * don't go looking for one as it will expand the index.
> >> +        */
> >
> > "all contained paths will be sparse if the .gitattributes is also sparse"?
> >
> > Do you mean something more like "the .gitattributes only applies for
> > files under the given directory, and if the directory is sparse, then
> > neither the .gitattributes file or any other file under that directory
> > will be present" ?
>
> Yes, you understand correctly and explain it better. Thanks.
>
> > Also, out of curiosity, I was suggesting in the past we do something
> > like this for .gitignore files, for the same reason.  Do we have such
> > logic in place, or is that another area of the code that hasn't been
> > handled yet?
>
> I don't believe this has been handled. It definitely is less obvious
> what to do there, because the point of .gitignore is to skip files that
> exist in the working tree even if Git didn't put them there. Meanwhile,
> .gitattributes is about how Git writes tracked files, but Git doesn't
> write sparse tracked files.

Well, one advantage of deleting ignored files in sparse directories
when we sparsify, is that we know if any files are left, they are all
untracked and not ignored.  So we don't need to load the .gitignore
file for those sparse directories.

Sure, there's a small edge case of users adding new untracked files
that would have matched the .gitignore file, but it's also clear that
they removed the .gitignore file when they sparsified, so I don't see
a problem in reporting it as untracked while that directory was
as-sparsified-away-as-possible.
