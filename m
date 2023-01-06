Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0335DC3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 14:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjAFOaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 09:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjAFO3k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 09:29:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5370181110
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 06:29:22 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g10so1172158wmo.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 06:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7h1ogK+KdZUzEXCBepFfgllfleDQBgcVyYPQByc8Fww=;
        b=UdUx6WwgmxwM804quMCtgzDuJwN09evrKhDGBTVKicw84JkaXoO+VGoee2ATXGwHIv
         0CopdrnDlcAmwzDXljrbtQf3rw6CDfTbihbgbaCmUfwFRaniX6XjAbyVRcmePFmQMJQW
         ktxE+l6AN6tnW5b4816t2x1NSNEobAzROEEfCjUHbZwqMu5krKKGATMOao0Iuuet/cOv
         BJsTzoJlABzVao5Pw1GBWJ6kesQf8B66L2dnHSBOtbBc0Z0xQ0/F3jPSNdagFzOo0LAC
         TlTXZL2FMvloVH/ga3uwwWg4qwEABsr6/cWpPmZ9IzvTq5TZSEv7nEcakni2B356h72w
         YYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h1ogK+KdZUzEXCBepFfgllfleDQBgcVyYPQByc8Fww=;
        b=xb6nP4BqHZEQ9eXiVrV39vJzPHpvHTt5ofo4yMG4DYHTV1hsYWfOGNlQ6DmCswMzw1
         SNxyRY9eh5gBi2SKBlJrALuBOBKy0avgMWZUMA4yDD/Smhpv9IT4R5HfgbrEJdkP8M9/
         8eQm41Ayhk7rSHjwRlDS208L/N+KAU8nDz2fb0jtODqIXbO5fR1PpmUSc6NeEe+QT1z0
         weYK5m+Bk9eJn1GagC9GHWLZ6D26WYrK5kWFZpFLtONoxIiDv+zMWL9rOsLFmn3IQbT8
         Q+16gjEy4/UFNfyqvHIdC8K1n9+fZzCBuZKt/F9LGNG43B58Qmfwc42kIN4xTtHD00fv
         Xg9A==
X-Gm-Message-State: AFqh2kqGvcy5muYOSOqwuzugSJFROr/6WopAWyBMa4DHjAomYS7dfdjE
        KXtpQDSqYuf+GKAagp8MSXk4j5tvUqE=
X-Google-Smtp-Source: AMrXdXsPNz5w2CRb9AE6jo1K1ZWr8x05A2rxte+kiemji6HGpjNhnkihj+TxNtwZOXFbYTw3OhAzvA==
X-Received: by 2002:a1c:720e:0:b0:3d1:f629:6b56 with SMTP id n14-20020a1c720e000000b003d1f6296b56mr39245197wmc.20.1673015360860;
        Fri, 06 Jan 2023 06:29:20 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b0024258722a7fsm1278377wrm.37.2023.01.06.06.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:29:20 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <81218256-5354-4b0a-6f74-7e9605131968@dunelm.org.uk>
Date:   Fri, 6 Jan 2023 14:29:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug?: ORIG_HEAD incorrect after reset during git-rebase -i
Content-Language: en-US
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
References: <CA+JQ7M-ynq1cLN-3ZodXae=x-H5k7Ab6uPBwUFhG+kgtOvCgtA@mail.gmail.com>
 <e6adaad6-f6ee-57d3-dc8f-d14a760c57c2@talktalk.net>
 <CA+JQ7M9G8HqqieRAK3C6csMM93PHOmaMd8GMPrDEfogWG0bteA@mail.gmail.com>
 <ef389a14-8513-4650-21e4-89421a24df2d@gmail.com>
In-Reply-To: <ef389a14-8513-4650-21e4-89421a24df2d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe & Erik

On 05/01/2023 00:11, Philippe Blain wrote:
> Hi Phillip and Erik,
> 
> Le 2021-12-16 à 11:44, Erik Cervin Edin a écrit :
>> Hi Phillip,
>>
>> Yes, I know.
>> It's just that I was under the impression ORIG_HEAD was to be reverted
>> to .git/rebase-merge/orig-head at the finish of the rebase.
>> Personally, it's the behavior I would expect.
>>
>> Thanks for the tips.
> 
> I just hit the same bug (I think it qualifies as one). In fact git-rebase(1) explicitely mentions
> that ORIG_HEAD is set to the branch tip before the rebase starts:

Strictly speaking that is what we do so we're documentation the 
implemented behavior. What's not clear from the documentation is that if 
the user run 'git reset' while rebasing then ORIG_HEAD will be 
overwritten. We could update ORIG_HEAD at the end of the rebase as you 
suggested but I wouldn't be surprised if some else complains that 
ORIG_HEAD no longer points to the commit that the reset while running 
rebase. I also wonder if users would expect 'git rebase --continue' to 
update ORIG_HEAD to point to the pre-rebase HEAD so it is consistent 
each time rebase stops. Basically I think the situation is confusing and 
I don't have a clear idea as to how to make it better. If someone 
submits a patch to try and clean things up I'll happily look at it but 
unless I'm hit by a bright idea as to how to fix it I probably wont work 
on it myself.

Best Wishes

Phillip

> $ git grep -C2 ORIG_HEAD Documentation/git-rebase.txt
> Documentation/git-rebase.txt-36-The current branch is reset to `<upstream>` or `<newbase>` if the
> Documentation/git-rebase.txt-37-`--onto` option was supplied.  This has the exact same effect as
> Documentation/git-rebase.txt:38:50:`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
> Documentation/git-rebase.txt-39-to point at the tip of the branch before the reset.
> Documentation/git-rebase.txt-40-
> 
> Here is my runnable reproducer. It is slightly more complicated than Erik's, since
> I split the second commit in two, but this is not necessary to trigger the bug; just
> running 'git reset HEAD^' as Erik wrote is enough.
> 
> ```bash
> #!/bin/bash
> rm -rf repro
> git init repro
> (
> cd repro
> # Create 3 commits
> cat << EOF >test
> hello
> every
> one
> EOF
> git add test
> git commit -m initial
> cat << EOF >test
> hello
> 
> add new lines
> 
> every
> 
> and also here
> 
> one
> EOF
> git commit -am second
> cat << EOF >test
> hello
> 
> add new lines
> 
> every
> 
> and also here
> 
> one
> 
> still more changes
> EOF
> git commit -am third
> # Rebase to split the second commit
> GIT_SEQUENCE_EDITOR="sed -ie '1 s/^p /e /'" git rebase -i HEAD~2
> git reset HEAD^
> cat << EOF >test
> hello
> 
> add new lines
> 
> every
> one
> EOF
> git ci -am "second 1/2"
> cat <<EOF >test
> hello
> 
> add new lines
> 
> every
> 
> and also here
> 
> one
> EOF
> git ci -am "second 2/2"
> # Finish rebase and demonstrate bug
> git rebase --continue
> echo ---
> echo "@{1} is :"
> git log -1 @{1}
> echo "ORIG_HEAD is :"
> git log -1 ORIG_HEAD
> 
> )
> ```
> 
> Cheers,
> 
> Philippe.
