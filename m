Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78890C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiHWUrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiHWUqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 16:46:53 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AA94330A
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 13:41:23 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3376851fe13so377604377b3.6
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 13:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1f+FiUTa+rICguqkvIm5uTGeXx+C5X4U8eq2kSD4Tqk=;
        b=MkLcwX0qehpg+84MC4SjCYIa47ZnTNB5eUF4fC1HS8cDt+f5IrpF04YBOfspbZHYKi
         sZmPFnoQSY49PFVb/OgDCbO814b8AojO2ECL5j/MxIvSHSVP0lRqW12mcitTvvkfJiDP
         qFvs17YXClpER3kFIAW5NzjPw+5INN+bnPEmpP2BLWNduhSuYbtwBte6N4K9drP7zikj
         NQxw/iyc3vln68paMS2xwj+4q01edGdhCDYtrjMdP+SKZ1LFDQXicyQ2hqNQrxlnQbu/
         5I1yeiza+8Ta+O3jGYdHFYr4pr7n5NEKAB/2sBMCqoRVbdkwxG1up5m2w9ESeRq/uDop
         eaBg==
X-Gm-Message-State: ACgBeo1iVffJFXflkYFXlJ//I2ePW3cfTxKAIfiQW6bKumbueHhOVlR5
        9PfKMbDOfhBwQdjWI0eUOy1UO4FCOpznyS9jjZw=
X-Google-Smtp-Source: AA6agR5YKDFunW1BWZmcdaxgzGd9f4/COKG53nWXFvoEoPT9vURD9MtP47LBacL7eTgLFpk0zUVt6erTRc4Pg1NFXtI=
X-Received: by 2002:a81:1ecc:0:b0:334:45e1:6fa9 with SMTP id
 e195-20020a811ecc000000b0033445e16fa9mr27617156ywe.482.1661287281825; Tue, 23
 Aug 2022 13:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1313.git.git.1661281689747.gitgitgadget@gmail.com>
In-Reply-To: <pull.1313.git.git.1661281689747.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Aug 2022 16:40:51 -0400
Message-ID: <CAPig+cSf+Gi4cHQLcTenxH=RzBxxqCApKhFTkCUMAS=0fYXZDA@mail.gmail.com>
Subject: Re: [PATCH] grep: fix multibyte regex handling under macOS
To:     Diomidis Spinellis via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Diomidis Spinellis <dds@aueb.gr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2022 at 4:04 PM Diomidis Spinellis via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/t/t7818-grep-multibyte.sh b/t/t7818-grep-multibyte.sh
> +# Multibyte regex search is only supported with a native regex library
> +# that supports them.
> +# (The included library is compiled with NO_MBSUPPORT) and only if it
> +test -z "$NO_REGEX" &&

The comment above seems incomplete (i.e. "and only if it...").
