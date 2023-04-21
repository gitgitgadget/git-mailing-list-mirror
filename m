Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A43C77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 21:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjDUV0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjDUV0t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 17:26:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E426A3
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 14:26:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b78b344d5so2249300b3a.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682112387; x=1684704387;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpIuoZt+eEgkGMFfeub+Luo78kIsKTrN6DMkcrQAbqs=;
        b=N1vf1FdSASz+zn2XuGB9VbjSMNYCMcuE7bQRf+lg8fnUghZu4nv7mbwG2A0cuVl5vt
         5tws49EixiAKSnxvpM1S1QKWoj1I+JSh1OjodVtt2YglRMc3RxdxE7lVh59XxxcPVxct
         w7C5Su8ACqWIs21BIigjES2LLamzS85DTAgJFkKWA5YHIZe0REUOn/j1QWik1TJr+xIa
         jauIMiV/Z9f2xCE+j6X6qQxzaAiKnS4rQROdNTNzrcXQXUcrYHENTUKAJ93r/3W1TV3S
         QCgna0cKOuqNaQZqZzjv7t9GRW0wddSTW9wPxGl4ifSu83OdmB9bJLyWHGwBFpE27Nma
         RdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682112387; x=1684704387;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpIuoZt+eEgkGMFfeub+Luo78kIsKTrN6DMkcrQAbqs=;
        b=Y1De6BWNPU5WjPaj43ZSA7QLq4kI0iqq/w5MTJuvmUJTJ9pk6pm/GQJ4Sp+c+H4aWz
         ywbu2rHbN/m+tlk/8OuhrIzKBeZhbufXmdxMu9TcByuCpbFOJ1pBj7JqBFYeSUl0AILv
         o3agTZxKhUxT1bXDfDlP1YQyH8mhPvf9+yNy/vB6IwijW4+4+DkweUy54ANvQtRC6p5h
         SwSWorJ1jWwUt0jNdr8T+rx9ZrGX5X5dSIMf4+P/1+iATsRYh+Ag7AsS9kkA0lgPccFK
         DCiO8N2Bnod9L+424mKvNDDLIGojGV+aqnDiV7LHK4YtnkzxCwES+T8kCbZPJ9vxUt/O
         H4sg==
X-Gm-Message-State: AAQBX9c3pUgiB82S6ZOicUGJqHkfphQ2mP4W8WkUKW0QNZbaVB8Ovd0U
        iAp9/qAbjm6VzP+vBkM2b3poPVqLrwNM9BKmrA==
X-Google-Smtp-Source: AKy350aPAyigTM5xzaSyvZaZ25L6SVeLhTT5NZSMwz3LG143FVo3oTuv8udOmlhofQBGWk2AoyPXrg==
X-Received: by 2002:a05:6a20:3956:b0:ec:6e2d:5a32 with SMTP id r22-20020a056a20395600b000ec6e2d5a32mr8520938pzg.62.1682112387188;
        Fri, 21 Apr 2023 14:26:27 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b0062608a7557fsm3363768pfg.75.2023.04.21.14.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 14:26:26 -0700 (PDT)
Message-ID: <111153b4-dba0-b533-fe49-57a6d5d3ba22@github.com>
Date:   Fri, 21 Apr 2023 14:26:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v7 2/2] diff-files: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-3-cheskaqiqi@gmail.com>
 <c382017a-8c65-24ba-5092-6b46428d8b9b@github.com>
 <CAMO4yUF1P1Sv1aVJ1aw9US-QeNYD-GfaS7ndr=bwp-dgvOyexA@mail.gmail.com>
 <069a53ef-63b8-c1e3-7502-6728bda50665@github.com>
 <CAMO4yUESBZw2Jr8y4NW_2N7640o2o2mpq58+nnC+3qffG3Y8=Q@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAMO4yUESBZw2Jr8y4NW_2N7640o2o2mpq58+nnC+3qffG3Y8=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Hi Victoria,
> 
>> If a user manually modifies a SKIP_WORKTREE file, SKIP_WORKTREE will be
>> removed from the file and the index expanded automatically [1]. If that
>> mechanism is working properly, there would be no need to manually check the
>> pathspec and expand the index.
>>
>> Have you tried removing the 'pathspec_needs_expanded_index()' and running
>> the tests? If so, is 'diff-files' producing incorrect results?
>>
>> [1] https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/
> 
> As per your suggestion, I tried removing pathspec_needs_expanded_index()
> from the code, and 'diff-files pathspec expands index when necessary'
> test failed.
> 
> So, I'm thinking about keeping it to ensure everything works properly.
> I'd like to know your thoughts on this. Should we keep it or explore
> other options?

Did the test fail because the index wasn't expanded in a case where you
previously expended it to be expanded? Or because of the returned results of
'diff-files' are invalid?

Only the latter represents incorrect behavior. If we're aren't expanding the
index for a case that was causing index expansion before *and* the
user-facing behavior is as-expected, that's the best-case scenario for a
sparse index integration!

Taking a step back, it's important to remember that the overarching goal of
the project is not just to switch 'command_requires_full_index' to '0'
everywhere, but to find all of the places where Git is working with the
index and make sure that work can be done on a sparse directory.

In most cases, it's possible to adapt an index-related operation to work
with sparse directories (albeit with varying levels of complexity). The use
of 'ensure_full_index()' is reserved for cases where it is _impossible_ to
make Git perform a given action on a sparse directory - expanding the index
completely eliminates the performance gains had by using a sparse index, so
it should be avoided at all costs.

I hope that helps!

> 
> Thanks,
> Shuqi

