Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D3FC433F5
	for <git@archiver.kernel.org>; Sun,  8 May 2022 15:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiEHPhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 May 2022 11:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiEHPho (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 May 2022 11:37:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B70AE03D
        for <git@vger.kernel.org>; Sun,  8 May 2022 08:33:53 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id k2so9422563qtp.1
        for <git@vger.kernel.org>; Sun, 08 May 2022 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5icwPKC63crjEJDtNH/79PVDLbwLPOer8WrVfWzycqg=;
        b=Sc2wZlQHqmyZRpRACRHNqkPfKiceKVPlISQA0FS6g57HAaURS7hsDkT3yFfZ8gx2zV
         IOXYoScfNHFFdFVsCILgNOeAskLQeCvY2gz9X5VKDsnlihPqB1lCyc7OVnkqiDw0scbX
         wVsm9dSfPU0f9ggPLwEO7GBWu5TK6FWC/3WF5lwPWSmuHgrhektutvZP6Hffi/P0RIPD
         XpJ1hctOO5V73cqG7hSUKJNOCsi79l/srJgWeILNwXZV+3VZMsN4XjG7FxuY84D79iJZ
         Cmt17VIKUjJVUFQSn7SNYUql8ZBnftmvtelhIDeNdvU+dw7p8lOojtOQycHaeXGooXf5
         xwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5icwPKC63crjEJDtNH/79PVDLbwLPOer8WrVfWzycqg=;
        b=6RDA+SFxW4t5bHlmG+FWvVnnDtgqNtZqsk6NFhw+GvTZp7IjHx+jffdX2NWmLGjiwa
         B09n8NAiM94Rt775kL+m7cmvbfil/voHDTIT8wXYpVjcqetyswCaacsv+nAxcf82+5sL
         XtZM98y1DaPAGIbOIY1tfzAF/C5+ey4FKY+8VYQiE767QHb//9aCPi/2bo5Z000/sAl9
         9Zh2a8YKFPF8a6UrMR3J2CsHw/Q2MKnVG0kfZGxyvNnZ0rxhDV4IeICyDwGPtKqlHJ4q
         vIXEIXsGmZYS7QbktbBB0TheA+PySAlFrG2YF6cXeqSBi2HJjMR4oyDfxfSiOgNM7syB
         vwPQ==
X-Gm-Message-State: AOAM5313pXQNcFg6XPXSMYyLZVEwpIUWAoK2wZob9D3l1mPhnwm9zfgl
        1/Hq5UX+yzaN9midEP/cBuIa7m3Vwi8=
X-Google-Smtp-Source: ABdhPJymVCj1hyM6f3xTtWLz4cMdBIFR/fbA8Dx6sl36lGgvZM+JQXmtXMh95454qSOueJPczd1QZw==
X-Received: by 2002:a05:622a:82:b0:2f3:b5de:4d2d with SMTP id o2-20020a05622a008200b002f3b5de4d2dmr11485968qtw.144.1652024032720;
        Sun, 08 May 2022 08:33:52 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id i22-20020ae9ee16000000b0069fc13ce1e5sm5494671qkg.22.2022.05.08.08.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 08:33:52 -0700 (PDT)
Subject: Re: [PATCH v3] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1227.v2.git.1651591253333.gitgitgadget@gmail.com>
 <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <aa9884d5-b69a-bfd2-4235-a30326bd65f6@gmail.com>
Date:   Sun, 8 May 2022 11:33:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

Le 2022-05-07 à 10:20, Abhradeep Chakraborty via GitGitGadget a écrit :
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 
> `git remote -v` (`--verbose`) lists down the names of remotes along with
> their urls. 

small nit: I would capitalize URLs.

> It would be beneficial for users to also specify the filter
> types for promisor remotes. Something like this -
> 
> 	origin	remote-url (fetch) [blob:none]
> 	origin	remote-url (push)
> 
> Teach `git remote -v` to also specify the filters for promisor remotes.
> 
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>     builtin/remote.c: teach -v to list filters for promisor remotes
>     
>     Fixes #1211 [1]

I don't think this matters much, but if Junio is OK with that, it would
be nice to include the reference to the GitGitGadget issue in the commit
message itself, though with its full URL, something like:

Closes: https://github.com/gitgitgadget/git/issues/1211

as another trailer before your signed-off-by. By including it in the 
commit message we allow the issue to be closed automatically when your topic
branch is merged to 'master'. By using the full link we make sure that GitHub 
knows we are targetting that issue specifically, not any other issue or PR in 
any fork of Git with the same number.

>     
>     In the previous version, documentation is updated (describing the
>     proposed change) and url_buf is renamed into remote_info_buf. In this
>     varsion, some more test cases are added and broken indentations are
>     fixed.

Again, small nit to make it easier for reviewers: usually we prefer to see
what has changed since the previous version first, and then (if you want, 
it's not strictly necessary) what changed in the other previous versions. 
It's not necessary since if we want that info we can refer to the cover letters
of the previous iterations directly. And ideally, in bullet points. So something like:

Changes since v2:
- added more test cases
- fixed broken indentations

Changes since v1:
- updated documentation
- renamed url_buf into remote_info_buf

>     
>     [1] https://github.com/gitgitgadget/git/issues/1211
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1227%2FAbhra303%2Fpromisor_remote-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1227/Abhra303/promisor_remote-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1227

Thanks,

Philippe.
