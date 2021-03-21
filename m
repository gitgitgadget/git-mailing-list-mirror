Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB74C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F01161943
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 14:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCUOFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 10:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCUOFG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 10:05:06 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED82C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 07:05:06 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so13289962otf.12
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3e1GP58Lij0O9md37m6Fbm9duAx7mvEVXR2QIE5ecs=;
        b=QJSg5OR4+xNiC1W8Ymp3cHvXIPYv1R0NYY19NQJZMbRhA5LR0sHxRHEysi0JMA7ZRl
         SRiUme+f7RhM3/XrsBqwwOr4mtoLhIAAQVvG5f1T9y2h2xQ8AkYLy+TxYZEa4iURtO3P
         DclqJvJbdtSbBeUH8eKHupXcWWCH3M+W4J+URK2p0vjgFg8o8zDp++AmEl/wvP075BQa
         ekU3/gc591C29EswZt1v9Z/QSRWsSD/Pj8+oR+ac8+Zhq8gMZzL8gkysZlT4m9E2zL69
         BH7htAq7GeuG6wASfhqzdGOcADp2Ttw2p2uF2Y7a0N9n75eyHAIRJw5e4ryQ/GTr4Q9g
         KaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3e1GP58Lij0O9md37m6Fbm9duAx7mvEVXR2QIE5ecs=;
        b=Blp/mvxaLxXDqcE6hWBPht5kPRYDZj29IoQaVxW0JF3bKmrUG5Gv3e4wytOzMY1rDg
         Tq+XSOchcYLfoY/AmQYovIlac6xgo/59HU3B7kHiRaT5474gAusHaYDW2dK0iBIT8d2b
         kn/M+QVsWDnmT3NNa6wvzl39tOGGLtcUVsO/UJiX+4+AOJzdUh1xerOpAbru+49TMTtt
         hDcLpN8FsiX9FIz935CUqXxaA4BpzymRWM9+gV3bwdb5dPcFbenLOSCJ8sRmK7OFIia4
         yvNw0c3FKjblNGXzWFlE6Tz49nb5aS5W55Jo2sIC9STVXmso+FcEuvJlo9imq1E7m8m5
         BjBg==
X-Gm-Message-State: AOAM5303chSYKDMnZsdkgqNHQsCYqDf399mJiq1l6rOA3NG9HqIjsezB
        lU9HPPK829H7Yt7APqltfzyw1OMk+WBLNFScMpA=
X-Google-Smtp-Source: ABdhPJwPMNU3r2WnK3De7QE3yUQUqCIqt+aHLue9JfSfS+dVsnzFP/2nVAQM5U+qUJ4+V6UKe8Qj7VacIBInJl/BibE=
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr8154074oto.299.1616335505936;
 Sun, 21 Mar 2021 07:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <pull.911.v2.git.1616317134.gitgitgadget@gmail.com> <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
 <1722fbad-6ff3-444f-ad3f-59e37b640fc7@gmail.com>
In-Reply-To: <1722fbad-6ff3-444f-ad3f-59e37b640fc7@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 21 Mar 2021 22:04:54 +0800
Message-ID: <CAOLTT8Tnt_Ai9xyXSYQ9dt4Vh1iViiihiMNEY0fzSGk=Xgw6cA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think please consider this case: When I add --trailer "Reviewed-by:@bat", and there are two
> identity pairs that match (`batman <email1>` and `batman <email2>`), I need to choose one that
> will be in the trailer (for example because <email1> is primary email). So a disambiguation
> prompt should be added, something like:
>
> ```
> There are <N> identities that match, please choose one that will be added to the trailer:
> 1) batman <email1>
> 2) batman <email2>
> ...
> n) batman <emailn>
> ```
>
Hi,

I think this kind of prompt will be beneficial to users, temporarily
adopt the method of
`find_author_by_nickname()` to get the last match commit "name <eamil>" pair.
If I want to find all these matched "name <eamil>" pairs and exclude
duplicates, I may need to
think about it for a while.

> The prompt can be repeated for each trailer values that are non-unique.
>
> Thanks
>
> --
> An old man doll... just what I always wanted! - Clara

Thanks.
--
ZheNing Hu
