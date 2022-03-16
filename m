Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9585BC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 21:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358190AbiCPWAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 18:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344834AbiCPWAO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 18:00:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E22B220C9
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 14:58:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x9-20020a5b0809000000b00631d9edfb96so2949457ybp.22
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PSR45jN73sODQWF09Ryoq6Gs5kUuX1y6UqOgnCZp84o=;
        b=GDxq+tIoEICByD11ih8Z1HrzrRyXwLhR5hheGiuEbT1cUtwT2pUPd8NsLv6Glw0jU4
         KjR8F2acsEbxlA45Lda5X+tzuNhOyC8za1DhMCdPFyGvqD0iL+gbd1tv2m5TR8q0isa9
         7hYmjdkR3OAWw3pjVcCEbTMxMHdaXAETGKdzZrON7kaOlxW9B3VsFLGJHJW6DTQpKQH6
         q9zoHXtCysyVl0sfO1vOC0Jlm7GnFKkrQiJbLrpUqh/x8JNCv9vH3YoSOqNH//HbC73h
         /ksgUhFPNkqWNFVgFjk3ULBg1jEU2/CoREnbi2hbW+/NoZq9VydFdycV4Q0DZCW2+Mgl
         g+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PSR45jN73sODQWF09Ryoq6Gs5kUuX1y6UqOgnCZp84o=;
        b=SdyVI5V+EkvYgkoJ1d8QBYixhrVv7/MwYrepPkZM7cjs1LHHJa0R9A555Jwof35dar
         VR7U0PJIJUwRe4R6u+FC3wWOh8WwvAj2W3XHCbJ757By8NP4jRIYFzWIhaRMFIj6YXag
         cLXviDNgcVNbAY1+XwGwIWu61hMwFGSzx2gM86kgBM1QxDZG0ZAFjmJXxxWjg2nHXJFO
         +38vKQ2vtFRkRqGY7hsqtIZUX87RLlp8162nkS8D8Q5IvWAPrqvyWOGDAF71Frf+SX23
         NVW9y3MmPKomoL2DZu8+AgYkM4iwMm/uEWPJYfIU/yUB+MhY2knhc26CoyFY2+D8CKTv
         w1eQ==
X-Gm-Message-State: AOAM531510C+iCZmFUO4UAjU9vTeLJiCST2faQhOQPtrrGb2KV81/eDM
        7YfiDVzVXowKkfKjQSa1KwyH/iJskaabqQ==
X-Google-Smtp-Source: ABdhPJy1C5pDOwU5UKPRwFAQ7oI/PTp+5/YZR69+pSo2atcjU3pu3RMvJhpx3HlgY0WBoQ8QRhKsvpnvCrMdEQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:8106:0:b0:2dc:1f07:920b with SMTP id
 r6-20020a818106000000b002dc1f07920bmr2622940ywf.330.1647467938781; Wed, 16
 Mar 2022 14:58:58 -0700 (PDT)
Date:   Wed, 16 Mar 2022 14:58:55 -0700
In-Reply-To: <kl6lzgly4vz3.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6la6dplfts.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
 <xmqqr17dp8s9.fsf@gitster.g> <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqfsnrkkhd.fsf@gitster.g> <kl6l5yom6h4j.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq4k46nae4.fsf@gitster.g> <kl6lzgly4vz3.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> To clarify, does this opinion of "don't use config values that aren't
>>> copied into .git/config" extend to in-tree .gitmodules? Prior to this
>>> series, we always read the in-tree .gitmodules to get the config - the
>>> user does not need to copy the settings to .git/config, but we don't
>>> pick a commit to read .gitmodules from.
>>
>> I think we do, but I also think it was a huge mistake to allow
>> repository data to directly affect the behaviour of local checkout.
>
> I'm inclined to agree.
>
>> Fixing that is most likely outside the scope of this series, though.
>
> Agree. Thanks!

I thought that this would have been the end of the discussion, but after
reading <xmqqa6dpllmc.fsf@gitster.g>, I guess I had the wrong impression
(oops).

If I am reading everything correctly, we both agree that it's not
good to read _any_ config values from .gitmodules (even if it's
in-tree), and that we should clean it up outside of this topic. So for
this topic to be merged into 'next', is it enough to say that I will fix
this behavior in a follow up topic?
