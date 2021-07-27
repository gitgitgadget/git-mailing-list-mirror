Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91624C4320A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5D961A8A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhG0NY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbhG0NX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 09:23:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B00C0613D3
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:23:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso4804703pjf.4
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u+PUYA9TLPDOr46du4DrOXPYOVyz2d7I4wnfE2OLQkg=;
        b=BRS8+Sn6D7gmQ/JfSDY9tDYboxlvG7kENAVmlO4eZPOKp3JEUpnqTVHFozvh2h5zWw
         V2MhsYkPoURcU/1QC3OQpR7+ynU72IH1VFP0cG4+zITu99EcrZXd5Y7aR/NjxlJxjHUQ
         SEYLG5B+txeL/cfN6XZoEpQnvOgDrP13zl1Subb754iNm1KDoTUkFt1bGahmdw9w1moQ
         A8DyzrGQVn+uOV29kZic1vb86P/P/QfzEpI5QKixdARUOgtATR8ioMcjgt0i6JzBz6o4
         dqMXUp+x0xCW0/DjdUOxYIbt3GB6rdKKNpcKY/qNbIe32bGnVBPQvmEAfnewnWe+ZDjV
         no5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u+PUYA9TLPDOr46du4DrOXPYOVyz2d7I4wnfE2OLQkg=;
        b=ZJpWeEbHcKNjcKXDX59g0A8GtO7T9myE0gXlSR2jbtxRueEMIlg0GeuUvMhq8wNncw
         +o8qGUEImopIJ60Fb0vYcFnFIooW5wLe1pmEp2BomMHfm73SbtZIFlcSnaTWHHM/QKMP
         BBahMZx/zb0uXOmuD+PbgHC9bezwtgZkNi00F1sfRwetwL/Kf0dl32MjhLjVSnOpiE3F
         1J68nL2zyaCfq5fjvoS6gjaXaXQVxi8FVJpVc8BN17SJHuk7bUZsyxHRsJfp5IEO0aAx
         hm0v62sUpjisyE4F46YL3u457yuSARNVCOR+YbgNIH01IRhCN+oC4mdLZt4DAfunZDvQ
         N9xg==
X-Gm-Message-State: AOAM532pcQUixt+pUFpCLeJ8qFD2mFdGGpu50+kQd8HF9MxaGe9r9ohi
        93BHWi6j/qhFTIbaUURC4JA=
X-Google-Smtp-Source: ABdhPJzk8wOTz1Nnotzvd3GucuVyCAan1UHRghgSzJfHPphpuq3uLqNwIYOeuYj51CyTUkV1BbUnRw==
X-Received: by 2002:a17:902:ed95:b029:ee:aa46:547a with SMTP id e21-20020a170902ed95b02900eeaa46547amr18804448plj.27.1627392193583;
        Tue, 27 Jul 2021 06:23:13 -0700 (PDT)
Received: from [192.168.0.46] ([119.82.121.47])
        by smtp.gmail.com with UTF8SMTPSA id c83sm3905202pfb.164.2021.07.27.06.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 06:23:13 -0700 (PDT)
Message-ID: <a562fbe5-e7a5-bb62-428e-92f9fd4fca18@gmail.com>
Date:   Tue, 27 Jul 2021 18:53:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0
Subject: Re: [GSoC] A small survey + My Git Blog, week 10
Content-Language: en-GB
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        avarab@gmail.com, Emily Shaffer <emilyshaffer@google.com>
References: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
 <60ff06ad2b298_31bb20891@natae.notmuch>
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <60ff06ad2b298_31bb20891@natae.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/07/21 00:32, Felipe Contreras wrote:
> Atharva Raykar wrote:
>> As for the "survey part", jump to the section here:
>> https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-workflow
>>
>> ...feel free to reply in this thread.
> 
> It would have been nice to copy the survey on the email.

Okay. Thanks for quoting it here.

>> What tools, systems and workflows do you find valuable in your
>> day-to-day work? In particular I’d be happy getting insights like:
>>
>> * Any strategy or approach to work, kind of like the example I quoted
>>   above
>> * Any scripts and tools that assist you
>> * Opinionated handling of multiple in-flight series and methods to
>>   approaching reviews
>> * Atharva, you are overthinking this! I just use a straightforward {
>>   editor + MUA + git } stack and go with the flow!
> 
> Personally I use mbsync + notmuch + notmuch-vim + vim + msmtp. You can
> watch an example session in asciinema.org [1].

Thanks for the visual demonstration!

> This deals with the filtering issue that you talked about in your blog
> post, for example one of the latest queries I ran is
> "from:felipe subject:mergetool", plus there's tags so I can mark
> messages with "inbox", "git", or "to-do".
> 
> Of course you can use emacs instead of vim, but I use vim.
> 
> Haveing all the feedback readily available helps me address it easily.
> 
> For me notmuch is like git for mail.
> 
> Cheers.
> 
> [1] https://asciinema.org/a/oo4yUOQDDF2CrWZbzhZURFtTW
> 

