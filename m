Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B31FC7EE29
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 04:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjFFEW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 00:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjFFEWi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 00:22:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10C7E9
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 21:22:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-543ae6ce8d1so1819500a12.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 21:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686025355; x=1688617355;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+YVGS7dCERCrwtQvd4EiJ5JAyJujoTZwiDdkXIDyRI=;
        b=IMvxK4/RaIiMn4dkvhr0nEQrS8oKreCYMoGsR85IuKO1Du1a4dD6LDabrYnmpnn+zy
         9PiiQB3vjrzlunJWIjtKq58xSqQsWFjkW/M1fjJw/mWN0ixsaq15IrahIqQNhqDIvF9X
         j8GlmC/HwKbhTN97KLHDcFQvoXuN7GcK3Ldwu8BkbOFsUZ4Vruv46WToPCGvpa1iLf+U
         bE29pc/M4rjLTblcwdKZcn3WKXkvV6Tkvwuku22SFIW7svHdlQpp+KeZ0Ybi7bBSprhk
         qVufXG4rPAyTGodW1wOC/lkIapufy4uXgCQfLqBuc4FCMpTVxfp2owxl+5z8IP3azWlT
         N8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686025355; x=1688617355;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+YVGS7dCERCrwtQvd4EiJ5JAyJujoTZwiDdkXIDyRI=;
        b=JN7A3cdCCWBTgzJUZTDl9wsjrrN7XsF8wCfpRTAckh0leWOWnPU/eYk1+LMo4DjL/f
         n7c7i69IcZg5pba1F6zdcQ4Nii4wnlpysZ1IRjO8LSPXFMVY+seHkACFaFuAI3qSRR7F
         0qE+c8Os0kmUuM5x6YnnGQ70TLlJarUejG/I9NH773r9qlN9eCSbDh5cmmx3T6kcizX/
         0ZG7WYjxuA2p8JENEVywu7NkUI4tpFveuo04oOEjwzBidDkxy96WuvI3eslQ4FFQDGF8
         IA767OpXuDEQwf5/owfzVdVYUi5daNhMAt3zHGejQjIo1F03ViurMGq71fQ4gVnRkSmA
         aWiw==
X-Gm-Message-State: AC+VfDyvcMjktX3kQpF0vZFj7uxM48FSM4ARNqdVMkTer8uAEyjOsye4
        oBdgiUdL8adj0c6F9iF1h2fyl2yAXyXZH37u1A==
X-Google-Smtp-Source: ACHHUZ7YhW34LZOa+XyImJ4OCdeDXgMzXPPcAvoTlObtaT3M5CLOUWPqntxRk0RGPD3u7PrJgy0rgw==
X-Received: by 2002:a17:90a:2c85:b0:24d:f59a:d331 with SMTP id n5-20020a17090a2c8500b0024df59ad331mr767745pjd.26.1686025355423;
        Mon, 05 Jun 2023 21:22:35 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090adc0700b0025043a8185dsm6712008pjv.23.2023.06.05.21.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 21:22:34 -0700 (PDT)
Message-ID: <523de20d-a816-5101-af82-5bfff26fbcac@github.com>
Date:   Mon, 5 Jun 2023 21:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v1] worktree: integrate with sparse-index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20230605161644.491424-1-cheskaqiqi@gmail.com>
 <773c2f7a-8637-ab0b-e0a8-ab553c90e88b@github.com>
 <CAMO4yUEQZz8DqPb7RyN8Owb=23p==6XS6G7Bza77p4-iydo6Qg@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAMO4yUEQZz8DqPb7RyN8Owb=23p==6XS6G7Bza77p4-iydo6Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
>>> +test_expect_success 'worktree is not expanded' '
>>> +     init_repos &&
>>> +
>>> +     test_all_match git worktree add .worktrees/hotfix &&
>>
>> Shouldn't 'git worktree add' not expand the index? Why use 'test_all_match'
>> instead of 'ensure_not_expanded'?
> 
> Here's my perspective on why my use of "test_all_match" instead of
> "ensure_not_expanded" in "git worktree add":
> 
> The functions "validate_no_submodules" and "check_clean_worktree" are
> specifically related to the "git worktree remove" command, and "git
> worktree add" doesn't require index reading, so with or without the
> "ensure_full_index" wouldn't affect the "git worktree add" command.
> I look forward to hearing your thoughts regarding whether my
> understanding is correct or not.

I see, thanks for the explanation. I could understand it both ways: on one
hand, you don't want redundant/unnecessary tests; on the other hand, that
test design decision relies pretty heavily on knowing the internal
implementation details, which the tests conceptually shouldn't have
visibility to. 

I'd still lean towards using 'ensure_not_expanded' (it protects us from
future changes causing index expansion, although that seems fairly
unlikely). However, if you do choose to stick with not using
'ensure_not_expanded', I'd recommend using 'git -C sparse-index worktree add
.worktrees/hotfix' instead of 'test_all_match'. The 'worktree' test already
compares behavior across the three test repositories; to keep things focused
on index expansion, only the 'sparse-index' repo should be set up & tested.

> 
> Thanks for your valuable feedback！

