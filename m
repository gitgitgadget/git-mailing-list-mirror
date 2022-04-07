Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DBAC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 13:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiDGNXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiDGNXg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 09:23:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D76C951
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 06:21:37 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so3842607otj.10
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OgSbUAAY3s+YlQJXVe9AUFg6gt1wYPM+47Ye5FZ2PQQ=;
        b=GYeI0EQidXsY9xZ3aWQKoDCKXAMU2MdTtDdjItiLj2gpKZhji8gkfg2l04/YdjbE35
         TA4eQaxiY6QGlKwHpS1zT4YyL8s4Bd3/BiqLIlyGT3DwrqkyqRCDtBFioRTS9FNb/VbP
         NCu2JkmaWCMdFD7LmWYxZQ3fzYMqqBzDsCd2IyHlfmq3FYq/N5gAucad717OBZ7CC+WV
         F+z978eZ5udwZwUrYF/jmAPe800sHhbr7uwvO92Byit8DGSFGom6j7wlpeawcR+KeJxj
         gDP192uiRiGG5vRXzhs07ehNIqHURvO0tZfmcrgEBH/xHw36krIP6o6M9dISagGRvKoX
         JkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OgSbUAAY3s+YlQJXVe9AUFg6gt1wYPM+47Ye5FZ2PQQ=;
        b=bKX/QpJhLmQyBCV+1imjZEV03usRHOhpCzWLgFW9FXaTWnx6uc7ECbIjtx+RZnRNsy
         7NVYdWE1FJiP33XUYbmS15djEZr72yqco/tbZecZ7YAh3eoILontnBSC3Jcxlcrl2N1n
         PU67D6pqUX2cE2sA9fOnxIDvVSekx3XQgboVbI2vF11dnORpF6ZbL84SE8dEBJBK401O
         o1FxwZSKq/oQ/H1IZ5fBAUUTtrREB40omrH7+ZJ9LcjGf6W0cwQmJkFXG1uGC2MLgRJh
         Q4SRBaJSupxdoCNYoDkyoztp56Fl9vS9WCNDnAwBYHY12QXbfiIJFDI8VYaO9ZQq+H4J
         MxHA==
X-Gm-Message-State: AOAM532tMkqDbQAE9Pn+pG5tF+8+McSUnhDI0CQ9PmIm/EBAKCHeMVEh
        ClWpcpSUeiHjmczJ7LKpAlcBZcxifCXz
X-Google-Smtp-Source: ABdhPJwphYbDdMjQuyQjNrl4c0BVfP2B6/pP5/muBZr3hZ3mzAngNWvD/uAgGR23X68a1WfiCZz+ig==
X-Received: by 2002:a05:6830:138d:b0:5b2:4b0a:a4fa with SMTP id d13-20020a056830138d00b005b24b0aa4famr4810029otq.380.1649337696461;
        Thu, 07 Apr 2022 06:21:36 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w4-20020a4adec4000000b0032109de628esm7072327oou.6.2022.04.07.06.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 06:21:36 -0700 (PDT)
Message-ID: <e81cdc6e-da42-d1d1-5d66-7d5e2a8aebbe@github.com>
Date:   Thu, 7 Apr 2022 09:21:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fsck: detect bare repos in trees and warn
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220406232231.47714-1-chooglen@google.com>
 <nycvar.QRO.7.76.6.2204071440520.347@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <nycvar.QRO.7.76.6.2204071440520.347@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2022 8:42 AM, Johannes Schindelin wrote:
> Hi Glen,
> 
> On Wed, 6 Apr 2022, Glen Choo wrote:
> 
>> Git tries not to distribute configs in-repo because they are a security
>> risk. However, an attacker can do exactly this if they embed a bare
>> repo inside of another repo.
>>
>> Teach fsck to detect whether a tree object contains a bare repo (as
>> determined by setup.c) and warn. This will help hosting sites detect and
>> prevent transmission of such malicious repos.
>>
>> See [1] for a more in-depth discussion, including future steps and
>> alternatives.
>>
>> [1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com/
> 
> Out of curiosity: does this new check trigger with
> https://github.com/libgit2/libgit2? AFAIR it has embedded repositories
> that are used in its test suite. In other words, libgit2 has a legitimate
> use case for embedded bare repositories, I believe.

It is definitely good to keep in mind that other repositories have
included bare repositories for convenience. I'm not sure that the behavior
of some good actors should outweigh the benefits of protecting against
this attack vector.

The trouble here is: how could the libgit2 repo change their project to
not trigger this warning? These bare repos are in their history forever if
they don't do go through significant work and pain to remove them from
their history. We would want to have a way to make the warnings less
severe for special cases like this.

Simultaneously, we wouldn't want to bless all _forks_ of libgit2.

Finally, the real thing we want to avoid is having the Git client write
these trees to disk, for example during a 'git checkout', unless the user
gives an override. (We would want 'git bisect' to still work on the
libgit2 repo, for example.)

A more complete protection here would be:

 1. Warn when finding a bare repo as a tree (this patch).

 2. Suppress warnings on trusted repos, scoped to a specific set of known
    trees _or_ based on some set of known commits (in case the known trees
    are too large).

 3. Prevent writing a bare repo to the worktree, unless the user provided
    an opt-in to that behavior.

Since your patch is moving in the right direction here, I don't think
steps (2) and (3) are required to move forward with your patch. However,
it is a good opportunity to discuss the full repercussions of this issue.

Thanks,
-Stolee
