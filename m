Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7540FC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 17:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiI3RXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 13:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiI3RXc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 13:23:32 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513A1C2F99
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:23:29 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d14so2522822ilf.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1PvZEmSlCayhKy/k3yjdRYW39dcVoyfovt9BDW4ZGEQ=;
        b=CXTxQYQwQGiCYMQu7eknb5Y8lCZHDNe8WYfhDnaG8me3WQXoKBft7cUvVHRxJrbZ35
         RfpN6NFK8pV+Y4HJ8ZX6LE+6Ok2xLubVm5qW9vAOF2S9zikeHjqJawYGIpMr4Nw9n1ym
         Dq0rnWxg/Fs91kvUTJV2Z5aRfeoFFXXuK8bhfgZkJp85PC2Qop0xCwoBbWSISKJY+Z7a
         15teZrINeTaIOmP8KH9AS/4iBvqO/PKnLJPVDYrxNwOkbikGmraRYZWASDW8YkipMXdc
         WaJl6blHABi5q3EMCUuCbr6hEseVlgBzLXAPEvX+rqOgI9mYSNbULalhT1H79paifeKr
         R+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1PvZEmSlCayhKy/k3yjdRYW39dcVoyfovt9BDW4ZGEQ=;
        b=R5pxn3S2vxpKqT9euXQzAw38kraYliwPGJL9Xq+mG1ioy3oKM8r5EUrPAt/eJCqZB6
         UIfoUf7RFthUagLqgr7AIfE3p/KGp9nYry3DO4wDRdqRSE38RvBWGIUkCbhPWWqmL7BR
         WIr+zE/fVf1O/0Cd3KzbI6p+G9IdIDaZdz3Z8kQfzV3ZlzoL5gsGXrgpqmENFXtCgFHG
         pIhQmMwKzCi6elMyuAgcjAUg+YPNa2wId9DyJ57olBXxPm167LbTbgV5xe1N0PNZzfnz
         krqTY7TQRhM0kxtOv9v0cZcNB1EWtTQYC5ln1ORl4CoW6CTvRJCC+J6iW4rbMoeEjDdk
         M4Cw==
X-Gm-Message-State: ACrzQf0sNlOpxaOoYwecTLQEN02Mqcrl06eXY/H+i6pFqT3RhyWQWiqe
        dTusd3NTDgrnOfvRK6RYllaKkNab8b0t
X-Google-Smtp-Source: AMsMyM73G9k7Lh8bbK1KMloOF3U1sZlIX32ajNKgHO/emtJxldja8OUleqaRDGeaqKuq7FJ1IRzlVQ==
X-Received: by 2002:a05:6e02:168f:b0:2f8:3d20:ea6 with SMTP id f15-20020a056e02168f00b002f83d200ea6mr4524594ila.322.1664558608712;
        Fri, 30 Sep 2022 10:23:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8c53:a5aa:3322:e297? ([2600:1700:e72:80a0:8c53:a5aa:3322:e297])
        by smtp.gmail.com with ESMTPSA id q12-20020a02a98c000000b003566d1abeabsm1128943jam.5.2022.09.30.10.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 10:23:28 -0700 (PDT)
Message-ID: <1711157b-8f04-008b-1672-f1fbac3c3e81@github.com>
Date:   Fri, 30 Sep 2022 13:23:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 5/6] sequencer: duplicate the result of
 resolve_ref_unsafe()
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
 <20220930140948.80367-6-szeder.dev@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220930140948.80367-6-szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/30/2022 10:09 AM, SZEDER Gábor wrote:
> When 'git rebase -i --update-refs' generates the todo list for the
> rebased commit range, an 'update-ref' instruction is inserted for each
> ref that points to one of those commits, except for the rebased branch
> (because at the end of the rebase it will be updated anyway) and any
> refs that are checked out in a worktree; for the latter a "Ref <ref>
> checked out at '<worktree>'" comment is added.  One of these comments
> can be missing under some circumstances: if the oldest commit with a
> ref pointing to it has multiple refs pointing to it, and at least one
> of those refs is checked out in a worktree, and one of them (but not
> the first) is checked out in the worktree associated with the last
> directory entry in '.git/worktrees'.
> 
> The culprit is the add_decorations_to_list() function, which calls
> resolve_ref_unsafe() to figure out the refname of the rebased branch.
> However, resolve_ref_unsafe() can (and in this case does) return a
> pointer to a static buffer.  Alas, add_decorations_to_list() holds on
> that static buffer until the end of the function, using its contents
> to compare refnames with the rebased branch, while it also calls a
> function that invokes refs_resolve_ref_unsafe() internally [1], and
> which overwrites the content of that static buffer, and messes up
> subsequent refname comparisons.

Good catch!

> -	const char *head_ref = resolve_ref_unsafe("HEAD",
> +	const char *head_ref = xstrdup_or_null(resolve_ref_unsafe("HEAD",
>  						  RESOLVE_REF_READING,
>  						  NULL,
> -						  NULL);
> +						  NULL));

Moving to a 'char *' matches our typical pattern of "I am responsible
for freeing this or passing that responsibility to someone else."

> +test_expect_success 'what should I call this?!' '

Perhaps 'with multiple refs, correctly report worktree' ?

Thanks,
-Stolee
