Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B9FC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 16:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355975AbiBNQTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:19:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353292AbiBNQTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 11:19:48 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97960AA5
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:19:40 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id r14so15864416qtt.5
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kqg8ffdu4CbuosV5x4lg359xRUsEwh4+ir2KnFpGJaw=;
        b=JKGRcR5E2Vy/4yuL0mCf4kLTu9rrROJDjlXWrmzoPFz44mKK9e6p2TQQg3DllQJrjq
         920FpyUip1RjMWRynxox+1bgWfsB/pQabGg31W97THIJgJ5NQrHu8RypUzAYxFCDF36P
         g+sGz5AlX76c6Lo1EdpdlIcYAqRNvkh0msYRvslZYFW3TMCBFUKNuzkDSZ286yMZ4CBv
         gHMVKL+qe4j6ERbc5pzPNfiOzU30AtsKMKl/gNT2/miJSYTy+OUGXOcF0XFaW3JoeuEW
         iuxVEM4UygFF9GseEV764d9+KvcgPp/IMXnc07KdIGkUX4bGBJsuRrqVLl7oIM688AnB
         UntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kqg8ffdu4CbuosV5x4lg359xRUsEwh4+ir2KnFpGJaw=;
        b=h4Aua88tfZr5aGtFZ06Udn+PhhMQOF7Rvl050azsT20tiz+IR5jpgrqnr6xXuHoYLo
         cz6VP6ku8NGWCvmQl4+4E3cX6JzqgzEC55jt7MTeFIcYBumm3zn8I+38nwU2mC00cgDi
         68j4FEoJ5WzBet+Kkaz6Pk56ydkGSGVaVhKzsq07R7DvuKvU2AkQ4PrDXT73AMUfVZRS
         DJN1UVirO7Cj1QBWnsfxEONSMvWFpT+OCQWHK7OVyj7ah4aiQiSNznw+qSun2TvhMAV1
         kYfDdxQQa2mDn3cLrfGg3seFJqX4tVaIqrdoceyIAAmOeVhXtfKicyinjX+nmz553lCS
         ODGQ==
X-Gm-Message-State: AOAM5319p02riy1oqLt2thrw6IL65Jmdmvmf1wEn0sso2EXvzuK05pk5
        9NdPar0KCQvCeycDI/P/oaK2
X-Google-Smtp-Source: ABdhPJxXZCsGsMv3ZFE9VPvIAuZq7SDDNSo5nE7A8UTVU8GnaBJSaTfNhfMm2OMCHO13Ddk9tB8U5A==
X-Received: by 2002:a05:622a:15:: with SMTP id x21mr454444qtw.30.1644855579302;
        Mon, 14 Feb 2022 08:19:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:eccf:bfbc:c638:47f4? ([2600:1700:e72:80a0:eccf:bfbc:c638:47f4])
        by smtp.gmail.com with ESMTPSA id w3sm18556336qta.13.2022.02.14.08.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:19:38 -0800 (PST)
Message-ID: <dfda7d2e-940b-bb54-6d2b-cda3a00abc0a@github.com>
Date:   Mon, 14 Feb 2022 11:19:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/7] RFC: sparse checkout: make --cone mode the default,
 and check add/set argument validity
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> Note (reason for RFC): this is RFC primarily because of dependencies (you
> may not want to pick this up yet, Junio), though there is also a question of
> whether to split patch 7 into two steps -- one for now and one we take in
> some future release. In particular, the first step could be to have
> sparse-checkout error out if neither --no-cone nor --cone are specified and
> then change the default to be --cone in some future release. I don't think
> splitting it into two steps is needed given (a) users who are unaware of the
> change will still get useful error messages telling them that directories
> are expected due to patches 4-6 of this series, and (b) the huge
> "EXPERIMENTAL" warning and explicit note about likely behavioral changes in
> git-sparse-checkout.txt serves as warning about the changes. However, the
> two step approach is an alternative.

I support this change. This will also require an update to the 'git clone'
documentation around the '--sparse' option, as I imagine we are going to
be changing behavior there. (If not, then we should do that as part of the
deprecation.)

> Note 2 (dependencies): this depends on en/present-despite-skipped (which
> depends on vd/sparse-clean-etc) and on
> ds/sparse-checkout-requires-per-worktree-config, because of otherwise heavy
> text conflicts in patch 7 to git-sparse-checkout.txt. Given that neither of
> those have merged to next yet, it may be premature to pick up this series.

Yes, hopefully things will start to settle down a little, especially since
vd/sparse-clean-etc is due to merge any day now.
 
> This series continues attempts to make sparse-checkouts more user friendly.
> A quick overview:
> 
>  * Patches 1-2 fix existing bugs from en/sparse-checkout-set
>  * Patch 3 fixes sparse-checkout-from-subdirectories-ignores-"prefix" (see
>    https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/),
>    at least in cone mode. In non-cone mode it is not clear if patch 3 is a
>    "fix" or a "break" (see the "NON-CONE PROBLEMS" section of the manual
>    added in patch 7, and
>    https://lore.kernel.org/git/e1934710-e228-adc4-d37c-f706883bd27c@gmail.com/
>    where Stolee suggested it might be incorrect).
>  * Patches 4-6 check positional arguments to set/add and provide
>    errors/warnings for very likely mistakes. It also adds a --skip-checks
>    flag for overridding in case you have a very unusual situation.

I took a close look at these patches and mostly have minor typo fixes. There
was one behavior issue: I don't think you should warn for file paths in non-
cone-mode. Being able to select a single file in a directory full of large
files is one of the main reasons to use non-cone-mode, in my experience.

It might be worth adding some documentation about how to reorganize a repo
to fit cone mode patterns, but that's not necessary.

>  * Patch 7 makes cone mode the default, and makes large updates to the
>    documentation both to explain why we changed the default, and to simplify
>    the documentation since users can just use directories and ignore the
>    intricacies of gitignore-style patterns and how they relate to sparse
>    checkouts.

I'm a fan of the end-result of this patch. I responded with some specific
comments and a suggestion for splitting it into a series of four patches.

Your first 6 patches are likely to be noncontroversial and could merge
more quickly than the deprecation. I think it would be good to get the
full deprecation under full review as soon as possible so we can give the
community a long window to comment on it.

We can also consider if we need a release or two where this behavior
change is announced, but not actually done. I'm not sure if that is
necessary. Making '--no-cone' required might stir up some noise that
indicate how much of an impact the change would make.

Thanks,
-Stolee
