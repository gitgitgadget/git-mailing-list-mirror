Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E28C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 17:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhL1REF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 12:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbhL1REE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 12:04:04 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31FAC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 09:04:04 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so24602146oti.11
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 09:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HPaWkWW6bZmZ8IAjNqJLOe/0N08hyzN5j5eZknQzilo=;
        b=Zerm8VzL96iiYUp+Ys8jEs3/PbVUi4r2ZrsuuMzt565XoKnIofZJ8vMHppY+P120Kd
         mgE4E7LmXF5PbRExLaSrf9nMOzH8kLtUnGNZ3HyhWJYp2d2badD2ZoEjrmnEv6MOYpOs
         V/WqCSwwxK0NqZqPDJ8Euv4tZ38mFsjrOZdC5AEaOTI1hkIyWKMSy+NbckXtaIQhbQi7
         ALzIviMHMQcdOSWqxhduB9aSaW9dYCaYQU7NqZNgUXlLt9lm0/sSc5lE1qfwTs6Z4mSY
         raLy2/CoMNkYfKcDJ7eXtWmy5LYgAXgcedHA/3UwKqVvhUiV8N7ZthKyUxqEQ7oFjzD+
         Y7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HPaWkWW6bZmZ8IAjNqJLOe/0N08hyzN5j5eZknQzilo=;
        b=Z3hCFgSGulYhKxmH7mhe+3MDu1W3tQ5XLuBKhRDCZrYIfJFD1O+Sl7k8YG0VHCvyG7
         SOOeQCBk6/8QpV7BZ0PucC6GxqZ2g2qtSPIflyoqdryG5cXiu1HKb/IadS86OZv8yv30
         usJCpnGPjdD+Hb9qzqmrMyXRVnQXHmjOe8ldxan31eeb3w/v6mQX8dqPvFGAd0TEWcox
         BC1VbqhIwYL5UF6u7Kahda+pKpPunQ5jKZRjimpHXXcTTIdXHGVHF9QFSo22irVKOGm7
         u1oju6D0gd2Nok8WGwu2ZU35ZmNI6Jigu1k+1UxU6RfN0IoFmBV6W/e8mZZMUZjkXuXE
         90UA==
X-Gm-Message-State: AOAM531URrlNu2WVqGG2e6q6kjQnNfNUDDnRSmlIqNhJAqYwcWoZXfBv
        VNVC8EruXG581tb7yKXeI68=
X-Google-Smtp-Source: ABdhPJyyuOFeScnOzP2kl3nLTT2F/bcK9jp7/AArXnOSwFZwkZodH5MSHuT9EQhSAkQFG5t6Fi6MMw==
X-Received: by 2002:a9d:51cd:: with SMTP id d13mr15987827oth.37.1640711043925;
        Tue, 28 Dec 2021 09:04:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a8af:d265:ced5:e098? ([2600:1700:e72:80a0:a8af:d265:ced5:e098])
        by smtp.gmail.com with ESMTPSA id j5sm3212779oou.23.2021.12.28.09.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 09:04:03 -0800 (PST)
Message-ID: <67cf358c-3a64-0c2f-4696-d444d36cfd97@gmail.com>
Date:   Tue, 28 Dec 2021 12:03:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 3/5] worktree: add upgrade_to_worktree_config()
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <ed8e2a7b19d236642b3b8d3a49d017d29753db56.1640114048.git.gitgitgadget@gmail.com>
 <CAPig+cQrJ9yWjkc8VMu=uyx_qtrXdL3cNnxLVafoxOo6e-r9kw@mail.gmail.com>
 <53f3531d-29ee-f16e-1d60-21ca7b4a3fbd@gmail.com>
 <CAPig+cT76vv08wjM7ryopXxFsg15Cy9Ax3tYNsERM9D_gJCYbw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cT76vv08wjM7ryopXxFsg15Cy9Ax3tYNsERM9D_gJCYbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/28/2021 11:58 AM, Eric Sunshine wrote:
> On Tue, Dec 28, 2021 at 10:03 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 12/21/2021 7:45 PM, Eric Sunshine wrote:
>>> It would be a good idea to drop the final sentence since there is no
>>> such thing as a bare worktree (either conceptually or practically),
>>> and end the first sentence at "case": i.e. "... stops that special
>>> case."
>>
>> Bare worktrees don't exist, that is correct. But if one existed it
>> would be a directory where you could operate as if it is a bare repo,
>> but it has its own HEAD different from the base repo's HEAD. Not sure
>> why one would want it.
> 
> I'm not following. I also still don't know what "base repo" is or
> where two HEADs would arise.
> 
>>>> +       char *base_config_file = xstrfmt("%s/config", r->commondir);
>>>> +       char *base_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
>>>
>>> Per path.c:strbuf_worktree_gitdir(), this use of `r->commondir` is
>>> correct. Good.
>>>
>>> Can we use more meaningful variable names? It's not at all clear what
>>> "base" means in this context (I don't think it has any analog in Git
>>> terminology). Perhaps name these `shared_config` and `repo_config`,
>>> respectively.
>>
>> 'repo_config' is too generic, because I want the worktree config for
>> the "original" repo. I chose to call that the "base" repo and its
>> worktree config. Shared_config is a good name, though.
> 
> There seems to be some terminology confusion or conflict at play here.
> We're dealing with only a single repository and zero or more
> worktrees, so I'm still having trouble understanding your references
> to "original repo" and "base repo", which seem to indicate multiple
> repositories.

Your use of "main worktree" is what I am meaning. I will adopt your
terminology.

Thanks,
-Stolee
