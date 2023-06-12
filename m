Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C1AC88CB2
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 17:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbjFLR4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbjFLRz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 13:55:59 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00CC198D
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:55:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a6820804abso1180978fac.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686592545; x=1689184545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHdA3oqzbsW8lMJkYzbPNUtgUuvoWIjZz75754tQyqo=;
        b=m4ljxxkVVVY7sizV+l6qqdDd1RZZq28vQ98wMfq+Iky2KKiqW6A3tiYx0OQbj1Re04
         LvdJLN9tjkabR8/Ilp1SfalVrQzEe9psT2teLNW67YFArCzQNa/9Pxa4MnNY5Z8y/cos
         9qG4p8aXOen56+xPWrBhPsbCs6DXpsiNhkvTl331ACIFyLGOaFnxt6MV8R/xbBZDr/hf
         2DcnplJ/Hy/QzfO8zGhGGTCAGnF7C2ISgHsMl+ifxVlpuaUu1oN8HuoVRVq+BlT5fbqJ
         aSTxnButUd5TfIKIXieG02g0ODCr9tKCL3MsiuUk9VpM7L0r/1OIbui6L9z7xgLet8aX
         wQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592545; x=1689184545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cHdA3oqzbsW8lMJkYzbPNUtgUuvoWIjZz75754tQyqo=;
        b=WGEoyO66gXDmohWacmcQhWYkzrhWxIIdkA5mqS56zBQi+QwnH1UDMuDVz9ZNGyvDaE
         W6uvyWydO6C4dDMX08Et75OAYftTZ07oKTTDjyq8YX0L8DYDUSOVu6bPUCXtjH4TzItH
         KcGYGqIOabbFGLaH6DGKvLRqrE9GHNJiW6oM2/ihsA5VfosW7ikiV+aKG6aGhtHAZ3rM
         aSHYpJPlZUDbDx/ezQw3RL9pLw2RwjacBm6K2HVnRoUeB1hMWZSY2SJE+W1MiVAAZBQf
         QsxsM92C5+Uyx2grBGuGd2cAcTLK7FVFQLeQoynxWLeHfZeTL4GYBMAOyZ6EC8OzCcZU
         W3Eg==
X-Gm-Message-State: AC+VfDwkkeDMSJXJLGn7GtyzJDjJo/DwKXcA0dX73YTgRYchWlsmSXFj
        tvH79Kqvytn0SCvjG3cVAPw=
X-Google-Smtp-Source: ACHHUZ4tg30uPYLzWnjfq6NK2OvR2lirVE2bb7oxWjaxUG7D+j7Pd0L2jJryPg9IfdEM6/8YzMXkuQ==
X-Received: by 2002:a05:6808:1b06:b0:39a:be57:964b with SMTP id bx6-20020a0568081b0600b0039abe57964bmr6025779oib.13.1686592544716;
        Mon, 12 Jun 2023 10:55:44 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902820800b001ac7c725c1asm8620049pln.6.2023.06.12.10.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:55:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2023, #02; Tue, 6)
References: <xmqq5y814aw8.fsf@gitster.g>
        <e08f5cea-67dc-6b96-098f-118934c11b6d@github.com>
Date:   Mon, 12 Jun 2023 10:55:44 -0700
In-Reply-To: <e08f5cea-67dc-6b96-098f-118934c11b6d@github.com> (Derrick
        Stolee's message of "Tue, 6 Jun 2023 09:35:01 -0400")
Message-ID: <xmqq8rcobm5b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 6/5/2023 9:50 PM, Junio C Hamano wrote:
>
>> * ds/add-i-color-configuration-fix (2023-06-06) 1 commit
>>  - add: check color.ui for interactive add
>> 
>>  The reimplemented "git add -i" did not honor color.ui configuration.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
>
> Your recommendation to compare the raw output to the color-decoded output
> is a clean way to simplify the test (and remove the whitespace errors in
> the meantime). I'll send a v2 soon with that change.

Thanks; I saw the update plus its 2/1 suggested by Phillp.

>> * ds/disable-replace-refs (2023-06-03) 3 commits
>>  - repository: create read_replace_refs setting
>>  - replace-objects: create wrapper around setting
>>  - repository: create disable_replace_refs()
>>  (this branch uses tb/pack-bitmap-traversal-with-boundary.)
>> 
>>  Introduce a mechanism to disable replace refs globally and per
>>  repository.
>> 
>>  Will merge to 'next'.
>>  source: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
>
> Please be sure to pick up v3 [1], which fixes a compilation bug in
> v2's patch 2. Want to keep history bisectable.

Thanks, will do.
