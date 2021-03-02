Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD9AC43333
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53F264F2D
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578515AbhCBPYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345118AbhCBG4o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 01:56:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E357C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 22:55:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o6so1294840pjf.5
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 22:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oU9ryKooSmjUlZvm9oQFjmWdcu1Fr7gE4wugTFS2IAg=;
        b=dnPVG9VzirZTXcsWPpzKBzlxVJQC32MpgUI6lBA3UPavu4PG72HzIskoPmQYbcQ5NT
         eDlz2ynZxm32AXy2xzJLOPWkpRv7FtYg72Wi5+JmKRWZv4xpoynu8aX7SpZZCC/1zmsk
         rOIPXoarrTp/c9XGhVK0wQS29wGZUQ9tm8T+NmIzjNiTiDwLZ15YnsyDnGnjafsWhdRB
         kg17+5Qd1/qVpuBsLaLO9AvLYJOMzyrJq3gEMKOIXmARn6VvEgjZomO2MT5+EqRSH4Ub
         Sa9iqLqoOitHGkBUFVKv1XcB1tsaawKBYrLRR3Bf5nWolKFlOgHyMfzuCOFt0QMXTbcM
         MMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oU9ryKooSmjUlZvm9oQFjmWdcu1Fr7gE4wugTFS2IAg=;
        b=mEcNmpd3nr4ImDsiJn6m0a+t3f9qZDEbnM0Xt5PiZf9jtKt4DEcKqfM7XlXVRk3NoS
         IVQMhxRppV8/kbe0r2UMErPHVxrQcD4lYVJXANR62Wu43WwULSYYPKrFH67Ze9Yp4Tfl
         SUY8XPGe6BT2Zl2G4C0hrgVpIj4kv7WPOHgYtDIznHgcqExFfzj0qLzEK7S5gLGaEgxY
         sZBqVbQt0rCIx4g/I8g8rpfjZPUKUIE8ruDSKgr+8JnQYOvd9QDxwemCGSARY3mk+d9S
         a6mC0RY6lpibkuhq2MY8g7K0/Ud2MeUcI04hCLMe6J0+JtcPovZpv8MiXx4oIa4Hmvq7
         08Uw==
X-Gm-Message-State: AOAM531WjA/1N3HQutRdlD6OUAlfXHbdlDrxRGi9v6B2g5wbBiD6hv0o
        YIEzvf9R7EMajuMifrp3CC0UU9u4iBZUjw==
X-Google-Smtp-Source: ABdhPJzgsLSaCrTgpT8tSZiZoyRuYjYzZGlC1D9jOP1bzTKzS8LfDFkTuJ/tUUJhUiOGvatcf+D4Bg==
X-Received: by 2002:a17:90a:4708:: with SMTP id h8mr3014134pjg.75.1614668130753;
        Mon, 01 Mar 2021 22:55:30 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-78.three.co.id. [180.214.232.78])
        by smtp.gmail.com with ESMTPSA id s10sm19120703pgl.90.2021.03.01.22.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 22:55:30 -0800 (PST)
Subject: Re: Argument list too long when fetching many missing objects from
 partial clone
To:     Bryan Turner <bturner@atlassian.com>
References: <fd1ba192-b90c-ef20-0843-c0e47925c76a@gmail.com>
 <CAGyf7-GJQU1s4H-pgVMEc_WB3C4ehppLieT2oiyxa5B8=yyjxA@mail.gmail.com>
Cc:     bagasdotme@gmail.com, git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f185e87e-d8d2-3ac4-9ca1-7b96ffb30562@gmail.com>
Date:   Tue, 2 Mar 2021 13:55:27 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAGyf7-GJQU1s4H-pgVMEc_WB3C4ehppLieT2oiyxa5B8=yyjxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After trying your suggestion, I now get:

error: RPC failed; HTTP 413 curl 22 The requested URL returned error: 413
fatal: unable to write request to remote: Broken pipe

On 02/03/21 02.22, Bryan Turner wrote:
> On Mon, Mar 1, 2021 at 5:20 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> I'm poking around with partial clone. On my local server on my computer
>> I have full clone of Git (git.git) repo.
>>
>> I do partial clone from that server as remote (which is actually on the same
>> computer):
>>
>>      git clone https://my-local-server.git/myself/git.git --filter=blob:none
>>
>> Inside the partial clone, I tried to convert it to full clone. First, I gather
>> list of missing objects:
>>
>>      git rev-list --objects --all --missing=print | grep -oP '^\?\K\w+' > .git/missing.list
>>
>> Then I fetched those:
>>
>>      git fetch origin $(cat .git/missing.list)
> 
> Since you're on Git 2.30, instead of trying to place all the object
> IDs on the `git fetch` command line, have you tried adding `--stdin`
> and having it read from your `missing.list` directly? Something like
> `git fetch --stdin origin <.git/missing.list` might do what you need.
> 
>>
>> What did you expect to happen? (Expected behavior)
>>
>> All missing objects fetched successfully
>>
>> What happened instead? (Actual behavior)
>>
>> Git returned:
>>
>>       -bash: /opt/git/bin/git: Argument list too long
>>
>> What's different between what you expected and what actually happened?
>>
>> (nothing)
>>
>> Anything else you want to add:
>>
>> I think the problem lies on how to feed list of 110K+ objects to `git fetch`.
>>
>> Note: Both the local server and the computer use Git 2.30.1
>>
>> Please review the rest of the bug report below.
>> You can delete any lines you don't wish to share.
>>
>> [System Info]
>> git version:
>> git version 2.30.1
>> cpu: x86_64
>> built from commit: 773e25afc41b1b6533fa9ae2cd825d0b4a697fad
>> sizeof-long: 8
>> sizeof-size_t: 8
>> shell-path: /bin/sh
>> uname: Linux 5.10.11-kernelorg-upstream-generic #1 SMP Fri Jan 29 12:56:19 WIB 2021 x86_64
>> compiler info: gnuc: 9.3
>> libc info: glibc: 2.31
>> $SHELL (typically, interactive shell): /bin/bash
>>
>> [Enabled Hooks]
>> (none)
>>
>> --
>> An old man doll... just what I always wanted! - Clara

-- 
An old man doll... just what I always wanted! - Clara
