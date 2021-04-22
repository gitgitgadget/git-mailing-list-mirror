Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE22C433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B822600D1
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 13:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbhDVNtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVNtm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 09:49:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD71C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 06:49:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p16so19608405plf.12
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3efeDYKE0fk0pdV0MxjEbFl5UYeI3b4JVQgxSC5HAxc=;
        b=dOPs17PRx4ldl83urBCuBXpre104LsXblQsnqjhvnE1knk1RYMqb7fTD/G1GLosI4g
         FqSt6APJ/VRylCmUkNsMaAdUqQmwUY0ACrn7BvIML7fb3zxwXbbGpoPgvdQScG2f0YxM
         bJx0bRics0SjEVsKuTRxDw9IfWnn1kHXqfE3XgsR5o2xppcGfbyw13UI4gMY4vxmyT0h
         9FNYeghDJdcCq+Yb4mYuNpzER/3XxQQVwy8x6QizOqTWPfGa9kL1m/oWn7DsgodFiA8m
         eLaTvd6fyIPeRNKDxd21Lg7Ixsz/6Yw6hF++Yxv41PSxwIx2o92bID9vb3BvVPDhGspP
         5HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3efeDYKE0fk0pdV0MxjEbFl5UYeI3b4JVQgxSC5HAxc=;
        b=qUysS3jEB3o+u6LAOHje0Jnqo3NCe87FSFx2yaDLaBEMh1lCRfduwiwLmz5jVWNCg7
         d3ggmn3mtQS4Rvz/xbLgBEs1FbpibFzxA1IyHimC0H90pNwTY0CAD1WEd3xMBK64CnBt
         zxn5+CxUSpKDrAmwcAyfpvpB8gItGWz1XTg8eSh+dZ5wnf8qUd/qRuG2QuN9TRDfV5nS
         nYrIP6c8NIq019a7/lS2hA11barvjrSJRpL18WpeI8TmslXjt4rayFMKbqgAyKpQAKCv
         fPb8/YuoH894yi6M4VX+C7CHT/Jraleo+ja3NBVeAWEmaZYnb03L+idK3scQBPjxhNJn
         BuVw==
X-Gm-Message-State: AOAM533xF/c74bBER9FvjoBsVnxu/w93eQKmkOd/VasyxvLeSVXv3Vir
        MMpSkJZpv4mPZEXOyqS2Xr+xL67lAjQ=
X-Google-Smtp-Source: ABdhPJxEWY6Mq+IzU36ySA1Jxud7PMVWFC/Ql9q2aymotKGBdwtaqQVBTubXdEZLqhM14i2dZQSBbA==
X-Received: by 2002:a17:903:248e:b029:ec:9c4f:765e with SMTP id p14-20020a170903248eb02900ec9c4f765emr3909476plw.17.1619099346195;
        Thu, 22 Apr 2021 06:49:06 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id a128sm2262211pfd.115.2021.04.22.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 06:49:05 -0700 (PDT)
Date:   Thu, 22 Apr 2021 20:49:04 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t6402: check exit status of ls-files
Message-ID: <YIF+0BZGwpMMI1pf@danh.dev>
References: <YIAAzJTG1UitiWyu@danh.dev>
 <20210421104102.3409-1-congdanhqx@gmail.com>
 <20210421104102.3409-2-congdanhqx@gmail.com>
 <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
 <CAPig+cS4tkXZLPDEWgEytzEOCR7oGrXyg1CZVKVPSXuJOifLjQ@mail.gmail.com>
 <xmqq5z0fxlgn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5z0fxlgn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-21 16:32:40-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Wed, Apr 21, 2021 at 12:55 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >>     count_ls_files 5 -s &&
> >>     count_ls_files 3 -u &&
> >>     count_ls_files 1 -u one~HEAD &&
> >>     ...
> >>
> >> The nice thing about having a helper function is that it can clean up
> >> after itself by not leaving a new file lying around, thus you wouldn't
> >> have to make adjustments to the expected number of untracked files (as
> >> mentioned in the commit message). If this is the sort of thing which
> >> comes up often enough (if there are more such cases beyond the two
> >> scripts you changed in this series), then it might make sense to
> >> promote the helper function to test-lib-functions.sh.
> >
> > The frequency with which this idiom crops up with commands beyond
> > git-ls-files suggests the more general solution of supporting it
> > directly in test-lib-functions.sh for any command. For instance:
> >
> >     test_cmd_line_count = 3 git ls-files -u &&
> >
> > Or, perhaps, a new mode of test_line_count():
> >
> >     test_line_count = 3 -c git ls-files -u &&

Hm, I'm not sure how would we implement such mode:

* Will we run such command in a subprocess and and pipe to "wc -l"
  directly to avoid a temporary file, but we will lose the exit code
  of running command in process?
* Will we run in a separated chain? Thus, a temporary file would be
  created, skimming over test-lib-functions.sh, I couldn't find any
  convention for creating such files, except for specific use cases,
  let's say "*.config".
* Another clever hacks that I don't know *shrug*

> 
> That looks nice on paper, but may be going too far.
> 
> We may want to count the lines in the error message,

Let's assume that we solve above puzzle.

Count the lines in the error messages is not too hard to be imagined,
let's say by -c2 or something like that.

> or we may want
> to count the lines after filtering the output with pipe.

However, when it involved a pipe, things becomes complicated.

> A test file that is dedicated to test ls-files with a file local
> helper "count_ls_files" smells like a better place to stop, at least
> to me.

Hence, I'll stick with local help "count_ls_files" for now.

-- 
Danh
