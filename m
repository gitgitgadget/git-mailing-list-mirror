Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E872C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 22:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiCaWW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbiCaWW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 18:22:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1218B7A6
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 15:21:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w21so868130pgm.7
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/yYRhtPsbrqyEwmgnjKxQSOwlhfELE0qrF9N73gTLeg=;
        b=HfXwMLxsvV23TIltqxw7cnuNL95HymgnQX1eaTe8uTo3SPeyvMQhYoiJYDq1TMTUN9
         hZr4LIvlgAPQN4PTjDsIIY8obUeMMErNPqFU9zRYoEWtCTJ7sPB1lCjr/+m5yDHK9O40
         I7AbWHL4+Gjhw2l0pzF3pQfZaJaVwxGQ42XT9YhrDY3t/iovanCr2sNC6TcHfF2kYxGB
         PHipTB5gOTDnBQVe2gOoLJFoABhOk0jk8bDJe0jYN2mNjoRqk/4i0XaLKDzqQEgGyrxe
         maMR1zeDeWieZJ3LfWjimKgaHwFZm6Zd2w0IG1lLivRqMgW0wF6L/lqUapmhhrjIkpYu
         dSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/yYRhtPsbrqyEwmgnjKxQSOwlhfELE0qrF9N73gTLeg=;
        b=6oolADe0zht0eQuHf6zQWJH2ZRPytDJZFQcwJZld8bFNrfTRWWZudQRLx7Vr23uQ2e
         v4eKtlfMHRvNSXqKfD9dYs+9Snvw+zgEMlytgR2uDRGavkHG6oZ5DBfqiMNYR2SCeqLD
         QtLj1rrw+oPQ6LDZfl4GeWOsmn411N0qFtpRMxdt7X/999szLxogXgUPftieG2HiqT7a
         qcmLug6QW/1hzderGQTla7vEX5XbQOhUZh3nzB4kwYEy7bMSyjinw52WLOfMha+167z7
         zMjTZV0eK/k7Cpmu0tfBTBdtlBd0hvBqezG4KLi8grb1vlkU6jvtTSy5KQb3xQb7dgtH
         JGjg==
X-Gm-Message-State: AOAM532nbvsfuagVVH/zj0BpmHFTFNYiOvnmBDbFnEImMVYH2aSwDZvJ
        HR4LtwXKtzhrvV1a3SrDOA0sXrNptrJn
X-Google-Smtp-Source: ABdhPJyeW+XmoYvQhzSlveA4WJlonJlLcgYK05emBXHIBcWabvzaY7xRs0WmlEQwEaOm99YMx/345Q==
X-Received: by 2002:a65:6e9a:0:b0:382:1804:35c8 with SMTP id bm26-20020a656e9a000000b00382180435c8mr12748162pgb.584.1648765267585;
        Thu, 31 Mar 2022 15:21:07 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id bx23-20020a056a00429700b004fa79b2cb31sm472826pfb.51.2022.03.31.15.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 15:21:07 -0700 (PDT)
Message-ID: <3c6a562b-d55f-d73e-3547-36ce752fcc6f@github.com>
Date:   Thu, 31 Mar 2022 15:21:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [WIP v1 0/4] mv: fix out-of-cone file/directory move logic
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Before integrating 'mv' with sparse-index, I still find some possibly buggy
> UX when 'mv' is interacting with 'sparse-checkout'. 
> 
> So I kept sparse-index off in order to sort things out without a sparse index.
> We can proceed to integrate with sparse-index once these changes are solid.
> 
> Note that this patch is tentative, and still have known glitches, but it 
> illustrates a general approach that I intended to harmonize 'mv' 
> with 'sparse-checkout'.
> 

Thanks for working out some ways to make 'mv' behave more nicely with sparse
checkouts! I did my best to address some of the specific implementation
questions you had in your commit messages. Beyond that, my main points of
feedback (beyond some formatting nits and implementation questions) are:

* Patch 2 deals with sparse directories, which won't show up until you
  enable sparse index; since you can't test that yet, you should save the
  patch for your "sparse index integration" series.
* Patch 4 should either be moved to the beginning of the series (with the
  tests flagged with 'test_expect_failure' until the patch that fixes the
  associated behavior), or split up with the tests associated with a change
  moved into the patch that makes that change.

And, as always, I'm happy to answer any questions and/or clarify weird
behavior you encounter while making changes to this (or subsequent) series!

> Shaoxuan Yuan (4):
>   mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
>   mv: add check_dir_in_index() and solve general dir check issue
>   mv: add advise_to_reapply hint for moving file into cone
>   t7002: add tests for moving out-of-cone file/directory
> 
>  builtin/mv.c                  | 76 ++++++++++++++++++++++++++++++++---
>  t/t7002-mv-sparse-checkout.sh | 72 +++++++++++++++++++++++++++++++++
>  2 files changed, 142 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b

