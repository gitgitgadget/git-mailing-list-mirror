Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7F2C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 18:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiDNSkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiDNSkS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 14:40:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C81DDCAAC
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:37:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso6500391pjj.2
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fDerJoOrGPK0CLEu+SGAISLL5z+F5NXX/PbhuokBJ+Y=;
        b=KmCzcv9K7U0ddPBikA7jsyV4/59RsRc+PcwrLtUAz8LFYDB2ozgogZjWEBp0kbt5ZT
         rci4MiweqMtp2RqXdz5UoYJWI8oOhhubyScXBWk3h6g8STTMo4F3WjGKSZp9VZRdKrpY
         rBfM+5PlFj+BjXx38wfwth4KP7lRBKLgg6CjzlcLjWBvIEA7CK3OtVS8HngmsqH1QV9A
         /FsGISXvZlwoFkxWKqzGkXB7NC5IEer0GWD9W2XK3x7L9QcoH9KO8R97H4R0tGDFRbgR
         ybr0BONPuQwEDbgfZDs4lqdKoTdsHlGB7YMpMhYvlfcLHGIE5MoJ9SN7tMtdne/VfNXp
         0PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fDerJoOrGPK0CLEu+SGAISLL5z+F5NXX/PbhuokBJ+Y=;
        b=4+dAisVZ5sL0N+GPOFqUSx0lkt4g2qMXgakoGPuZZk/wTgO/zGlsay7QIAhfZECGnf
         /2kIojyI4hqBva+KOb2G1m64HJ+Vnh7dPm2gK+Tw+HMQyv42p31MN/iHrjqrntG3cPIb
         3YgkCbwuaZRwSkoOFxw7CGCj1dfCi7wo4z4OdS4fJqMawVvpI1F2mmX2YZaxY1H8T9Jk
         wV/ZBUXaeN19m/9s7jI+dD1b1DtfAlDGAWVd61pVXB9LBSTfidLPflx4TQFlETtZ08XC
         YOvBX//LloMZdSsRwdwX9OAWR996skcZ4mnB2xqKwXJKM0yLtmfuWXLNVaBBla03Lrkp
         HX+A==
X-Gm-Message-State: AOAM531Xuf2Q+6RP0ZZZVPF+VXoaBh0jkIs6++A6SmfaaI5/lC1vHdHr
        ahsPBZhHPHmrVoxQgxOu7B6zEQ==
X-Google-Smtp-Source: ABdhPJxlAa5H68OV6RZAq3vituxhStkuexys6dOvl0Bf0wall/X2fw5VqjcD8l6lpH9zKJPIwDfA8A==
X-Received: by 2002:a17:903:18a:b0:158:c459:ab48 with SMTP id z10-20020a170903018a00b00158c459ab48mr2221540plg.52.1649961472505;
        Thu, 14 Apr 2022 11:37:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c26e:8dc1:2f6e:26bc])
        by smtp.gmail.com with ESMTPSA id 73-20020a63064c000000b003a216524089sm881699pgg.57.2022.04.14.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:37:51 -0700 (PDT)
Date:   Thu, 14 Apr 2022 11:37:46 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] Sparse index integration with 'git show'
Message-ID: <Ylhp+q96KOt2+OGZ@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

Thanks for the series! All my comments are from the perspective of
someone without much knowledge of the index, much less sparse-index, or
sparse-checkout. I am not sure whether the project should cater to
reviewers in my position, but I did have trouble understanding most of
this series. I didn't have any concerns with the implementation, but the
cover letter, commit messages, and tests were fairly confusing and I
think can be explained better with a few changes:

On 2022.04.07 16:37, Derrick Stolee via GitGitGadget wrote:
> This continues our sequence of integrating builtins with the sparse index.
> 
> 'git show' is relatively simple to get working in a way that doesn't fail
> when it would previously succeed, but there are some sutbleties when the
> user passes a directory path. If that path happens to be a sparse directory
> entry, we suddenly start succeeding and printing the tree information!
>
> Since this behavior can change depending on the sparse checkout definition
> and the state of index entries within that directory, this new behavior
> would be more likely to confuse users than help them.

The two paragraphs above did not really convey to me on first
read-through what the problem was. IIUC the main points are:

* git-show does not currently work with the sparse index.
* A simple change fixes the above, but causes us to sometimes print
  unexpected information about trees.
* We can use the simple change in our implementation, but must do
  additional work to make sure we only print the expected information.

I think this could be clarified by:
* Including examples of the unhelpful output from the simple
  implementation.
* Describing in more detail the situations that trigger this.
* Describing why those situations don't currently happen without support
  for sparse indexes.

> Here is an outline of this series:
> 
>  * Patch 1: Add more tests around 'git show :' in t1092.
> 
>  * Patch 2: Make 'git show' stop expanding the index by default. Make note
>    of this behavior change in the tests.
> 
>  * Patches 3-4: Make the subtle changes to object-name.c that help us reject
>    sparse directories (patch 3) and print the correct error message (patch
>    4).
> 
> Patches 2-4 could realistically be squashed into a single commit, but I
> thought it might be instructive to show these individual steps, especially
> as an example for our GSoC project.
> 
> This series is based on the current 'master'. I know that Victoria intends
> to submit her 'git stash' integration soon, and this provides a way to test
> if our split of test changes in t1092 are easy to merge without conflict. If
> that is successful, then I will likely submit my integration with the
> 'sparse-checkout' builtin after this series is complete.
> 
> Thanks, -Stolee


Thanks,
Josh
