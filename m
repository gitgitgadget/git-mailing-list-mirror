Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F57C433FE
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 13:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbiDKNjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346431AbiDKNjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 09:39:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981022180D
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:37:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e21so6559621wrc.8
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aJ7hUIfPxvcjGn/aFJ1/gisuCTd0MJlxjQl31D1vPa4=;
        b=XWsFMEhE5K3xpVawWYjd5VN+rcrKXYRtP6WKw3ky8L/oeyWg7u8Rr/ar0ogCp93Hd2
         G05dwWoeoqj+fFCSOxdoRNi7XwxWZvXOqOJGVH60XKBQau61R7AdShR1Sh/SK/f1NNAb
         kNHtZa2httNfJYFMBS2B5Ro7VEEoRrqLevDfKI7yAvmD6elZMP5qSE/OGbMUh2w8ZVuA
         2Ayam+ZEYUErawDeGgM/UfSQ9dbIvmeEQh3FXcWqhUil7L8PwmCpuwch4TtJK6BezOi3
         YDGxhSyr034I6wnNny1E/t4xwVcg3bNdjmQN0Ruz9uT8fA0eKSF3FcortLVV/nxl1Tvn
         jhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aJ7hUIfPxvcjGn/aFJ1/gisuCTd0MJlxjQl31D1vPa4=;
        b=FXaORK66NzvAQr4Ey0gwLP11kyuXdKKZXUFL1KtyzoV3uGOChIVxeh+bfrHQgiiITZ
         aYqMyfnuLjdQ8leKa0MTU4ZpiqtMVntVBMYmvo8BgG1Xprnk1/yGEa/GAupnYqh4orF2
         MEiv4tz+48x2Y2RBbhkkvj0SlvQaGYO0r8WZjshwiYek0xu14z+Hso3Y3KyDpUheCfym
         nMxOZEv693AXMk8VwSrP3hiGgej6A6Wx1Vcy6E+G2+iUFAwDhCxclhdnj7MJSyncEdGh
         3QhPxY5sreHioZ47Mj+RPGTKL/K1YgyfMQIha0HYdrt9N9n4DE5GL2S5hhh49p2sXKQF
         rwuA==
X-Gm-Message-State: AOAM5325cJ3OPYFRBWvJD28Pufz2LIBMaevOGDEgpRKlV65/Xx+GZSAU
        tcCimEn/lNvY0fuuWuIbYWQ=
X-Google-Smtp-Source: ABdhPJwsS0ThvV7c8+Pnoujtes4C0Gy5FrkSg1salm/gQZ6I+7UJHcIoJgN1t7Yvf+3SPq55oEoh9g==
X-Received: by 2002:adf:b64c:0:b0:1e3:16d0:3504 with SMTP id i12-20020adfb64c000000b001e316d03504mr24956412wre.333.1649684228146;
        Mon, 11 Apr 2022 06:37:08 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d65c3000000b00207a63b9d3esm3192249wrw.105.2022.04.11.06.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:37:07 -0700 (PDT)
Message-ID: <df287d4f-e9da-4ce0-d7e9-1b1fe7671aab@gmail.com>
Date:   Mon, 11 Apr 2022 14:37:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/6][GSoC] iterate dirs before or after their contents
Content-Language: en-GB-large
To:     Plato Kiorpelidis <kioplato@gmail.com>, git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu
References: <20220410111852.2097418-1-kioplato@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220410111852.2097418-1-kioplato@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plato

I think this would be a useful addition to git, thanks for working on 
it. I've left some comments on the individual patches. In general I 
think this series would benefit from trying to work with the existing 
code and change one aspect at a time in stages rather than rewriting 
large chunks all at once.

Best Wishes

Phillip

On 10/04/2022 12:18, Plato Kiorpelidis wrote:
> Hello. Some time ago I worked on converting opendir/readdir calls to use
> dir-iterator [1], however this cleanup required to iterate directory paths after
> their contents. Matheus pointed me out to a previous patch series[2] that
> attempted to implement such functionality in dir-iterator. From it, I mainly
> used Michael's feedback and feature requests and tried to include it in my work.
> 
> My fork: https://github.com/kioplato/git/tree/dir-iterator
> CI: https://github.com/kioplato/git/actions/runs/2141288008
> There are some memleaks, I'll track them down in v2.
> 
> I aim to implement more functionality in dir-iterator, my goal being to simplify
> the codebase by introducing an abstraction layer for iterating directories.
> I would like to eventually simplify read_directory_recursive(). I wanted to
> check in with you to make sure I'm heading in the right direction with what I've
> implemented.
>    * Are my tests overly exhaustive?
>    * As of now we can't thoroughly test dir-iterator on directories with complex
>    structure since readdir produce dirents with undefined order in a directory.
>    I thought about introducing a tool for generating permutations with stable
>    parts in test-lib. Is there a need to something like this for other tests?
>    Or maybe should I sort each level iterated by dir-iterator inside
>    test-dir-iterator before printing to stdout? In these patches I did enumerate
>    the path permutations for some tests by hand, but that's not viable really.
>    * We also don't test for deleted entries between dir_iterator_advance() calls.
>    * Are my comments too much? Throughout git, .c files don't have many comments,
>    should I remove mine as well? I think they provide better context when reading
>    through the source code.
> 
> I do understand that it probably is too early to worry about most of these.
> However I wanted to communicate my thoughts and setup for the following
> versions.
> 
> While I wait for review, I'll implement/fix:
>    * DIR_ITERATOR_RECURSE proposed here[3], but with finer control. Instead of a
>    flag I'll introduce a new integer parameter in dir_iterator_begin(), which
>    will specify the maximum iteration depth.
>      * Supplying 0 will have the same behavior as DIR_ITERATOR_RECURSE i.e. it
>      will iterate over the entries of the root directory.
>      * Supplying -1 will iterate to maximum depth. This is the default right now.
>    * DIR_ITERATOR_DIRS_ONLY proposed here[4]. Enabling this, dir-iterator will
>    show only directories. Failing to enable DIR_ITERATOR_DIRS_BEFORE and/or
>    DIR_ITERATOR_DIRS_AFTER will result in dir_iterator_begin() returning NULL.
>    Is this a good way to encode "show only directories" in the flags?
> 
> I'll include them along with feedback and suggestions from this version in the
> next one.
> 
> I didn't refactor entry.c to use dir-iterator. It's a good first issue for
> someone else to become introduced to the community. I applied my patch[1] and it
> does not pass t/, as it used to, because of 15th test in t1092. Should I work on
> entry.c in my next version or leave it alone for a newcomer?
> 
> This serves as my microproject for GSoC. Could my future work on dir-iterator
> and cleanup of read_directory_recursive() and other customers of dir-iterator
> become a seperate GSoC project I could undertake?
> 
> [1]: https://public-inbox.org/git/20191208180439.19018-1-otalpster@gmail.com/
> [2]: https://public-inbox.org/git/1493226219-33423-1-git-send-email-bnmvco@gmail.com/
> [3]: https://public-inbox.org/git/CACsJy8DBa-oH3i+5P=iVr9NhJwsicZ43DO89WmvpYEQu90RrMw@mail.gmail.com/
> [4]: https://public-inbox.org/git/xmqqmvc265hk.fsf@gitster.mtv.corp.google.com/
> 
> Plato Kiorpelidis (6):
>    t0066: improve readablity of dir-iterator tests
>    t0066: better test coverage for dir-iterator
>    dir-iterator: refactor dir_iterator_advance()
>    dir-iterator: iterate dirs before or after their contents
>    t0066: remove redundant tests
>    test-dir-iterator: handle EACCES errno by dir-iterator
> 
>   builtin/clone.c              |    4 +-
>   dir-iterator.c               |  302 ++++++---
>   dir-iterator.h               |   34 +-
>   refs/files-backend.c         |    2 +-
>   t/helper/test-dir-iterator.c |   23 +-
>   t/t0066-dir-iterator.sh      | 1202 +++++++++++++++++++++++++++++++---
>   6 files changed, 1371 insertions(+), 196 deletions(-)
> 

