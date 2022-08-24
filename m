Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C1C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 17:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiHXRtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbiHXRth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 13:49:37 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44CB8275E
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 10:49:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c20so13313783qtw.8
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc;
        bh=X96CBFbO8SjO099hT5wEB1B+q0CbRvXU7sUqRB5+2lU=;
        b=mta4J+DXZNL9Umc1K37hawm0J+SBe1voj0BBM6vC4b45sMSxcfpTf1FMjD67KQ/vwH
         P5iWqQumVnNFSTrgd/Cb4hYhhkZ3mlN5jSgbk4CMwjoTUD5RcHhg2JFmyPRH9aDrYtNX
         3ZyOdNHTaF1rYQtK99Wfxtqd2/2ym98ujhMAngVBCvv+7adjlMpjop89IT/4EW3C1qvX
         miLgxo/ylPZjqWbN57KpjlbVuc9iv8t23wzXw2QB4j3wO18bIzI27KJMG6/lzRVYah5V
         Ntuw2xSldsXlNtzWuRV4ri1vBPoezlEiWdVi+vMTaAzrzvH+RYAOZh/tXNbP7ijVHwZK
         9kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc;
        bh=X96CBFbO8SjO099hT5wEB1B+q0CbRvXU7sUqRB5+2lU=;
        b=fsPwghOy23PVgoeDy8ti9lkIBHuO/jngSIfUuqMfKTrbOEHzn3tMhPNykDhnf6qPKi
         xJUYwC73f8LwDatPYA8lAd9orCzmDnu2PqNpEWvcXhCOX9Zxdx2/xv1HRmDf6+WRWZ0Q
         INAUVGI1Y3RjZgqacLxSMTJIUZFFNAXvpEu43fuBh5GK8DM1hZaiS2VVlGiU8zN/m8pT
         kLiLg94Y5uc4NnlwYNxjqf0avve49+CP2lEg2V8OM/K8Z8FjTcbMP4MswgUailaQfIuC
         nNegEPQ6iywrWCfu6MMDnoUTuCegqX6tU7gN1VJfDI7DHER/t6gzGCd8x0xm9NYdZ+5X
         9z3g==
X-Gm-Message-State: ACgBeo1lJFRhwPSNr3ufki37ITKkSqlKxpgqFiaLIiVUBnOqLrgx4VBf
        Kl95fNe4k7SvLUJFRP8XqUj6HpCXpo4=
X-Google-Smtp-Source: AA6agR7K+RDo1x8h8ynlqba9YH3vFGJyp0TPJ+wUyeLuApa79uPxfHsFMjV/UZdsWXB6L3ci0n7rCw==
X-Received: by 2002:a05:622a:1343:b0:343:5b7:ffb with SMTP id w3-20020a05622a134300b0034305b70ffbmr352134qtk.91.1661363372702;
        Wed, 24 Aug 2022 10:49:32 -0700 (PDT)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bs37-20020a05620a472500b006bb208bd889sm15110476qkb.120.2022.08.24.10.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:49:32 -0700 (PDT)
Subject: Re: [PATCH 0/3] built-in add -p: support diff-so-fancy better
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
 <ab012782-1d02-b90b-9a4a-179ecc3f8e9e@gmail.com>
 <1r3pq48q-s728-8r2r-r4q3-72413r5483o1@tzk.qr>
 <41781ceb-bfad-2534-2970-c74618c93f2a@gmail.com>
Message-ID: <145ddce5-8084-a024-39b5-9dea870d1afe@gmail.com>
Date:   Wed, 24 Aug 2022 13:49:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <41781ceb-bfad-2534-2970-c74618c93f2a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2022-08-24 à 09:21, Philippe Blain a écrit :
> Hi Dscho,
> 
> Le 2022-08-24 à 02:27, Johannes Schindelin a écrit :
>> Hi Philippe,
>>
>> On Tue, 23 Aug 2022, Philippe Blain wrote:
>>
>>> However, I've tried it on a more "real-life" example, and then I get:
>>>
>>>     error: mismatched output from interactive.diffFilter
>>>     hint: Your filter must maintain a one-to-one correspondence
>>>     hint: between its input and output lines.
>>>
>>> This is despite using "diff-so-fancy --patch" as interactive.diffFilter, which should
>>> keep the number of lines the same.
>>
>> Would you mind sharing the example with me?
>>
>> Thanks,
>> Dscho
> 
> In trying to write a reproducer, I realize that this is in fact a separate "bug".
> I happened to have a submodule in the repository I was testing, and it had modified 
> content. This is what was causing the "mismatched output" error, although I'm not
> sure why. If I use a pathspec that does not include the submodule when invoking 
> 'git add -p', it works correctly. 
> 
> I'm a bit out of time now but I'll try to write a separate reproducer for this later today.

So in trying to write a new reproducer, I found the cause of the bug. A submodule in "modified 
content" or "untracked content" state (i.e. no new commit) has no "index" line in its diff
header. diff-so-fancy, with --patch, always *adds* a blank line before the diff-header 
because its modified diff header is 3 lines, whereas Git's is 4. So the count is off 
specifically for submodules in  "modified/untracked content" state. 

It seems the C version is less lenient than the Perl version, because the Perl version does
not complain. But I'd say that it's more of a bug on the diff-so-fancy side, even if it 
is a regression of the builtin version...
Delta does not alter the header (in its default configuration) and so it is not affected here.

For what it's worth, here is the updated reproducer script. It also downloads the 'delta' executable (for Linux)
and runs it. With delta, both Perl and C versions work. With diff-so-fancy, the C version 
complains bout mismatched output.

```bash
#!/bin/bash

set -euEo pipefail

repo=repro
rm -rf $repo

TEST_AUTHOR_LOCALNAME=author
TEST_AUTHOR_DOMAIN=example.com
GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
GIT_AUTHOR_NAME='A U Thor'
GIT_AUTHOR_DATE='1112354055 +0200'
TEST_COMMITTER_LOCALNAME=committer
TEST_COMMITTER_DOMAIN=example.com
GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
GIT_COMMITTER_NAME='C O Mitter'
GIT_COMMITTER_DATE='1112354055 +0200'
export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
export HOME=

git -c init.defaultBranch=unimportant init $repo
cd $repo
date>file
git add file
git commit -m file
git clone https://github.com/so-fancy/diff-so-fancy.git
date>>file
export PATH="diff-so-fancy:$PATH"
git submodule add ./diff-so-fancy
git commit -m "add sub"
date>diff-so-fancy/README.md
curl -sSLO https://github.com/dandavison/delta/releases/download/0.12.1/delta-0.12.1-x86_64-unknown-linux-gnu.tar.gz
tar xzf delta-0.12.1-x86_64-unknown-linux-gnu.tar.gz
export PATH="delta-0.12.1-x86_64-unknown-linux-gnu:$PATH"
echo -----
git -c interactive.diffFilter="delta --color-only" -c add.interactive.useBuiltin=false add -p < <(echo n)
echo -----
git -c interactive.diffFilter="delta --color-only" add -p < <(echo n)
echo -----
git -c interactive.diffFilter="diff-so-fancy --patch" -c add.interactive.useBuiltin=false add -p < <(echo n)
echo -----
git -c interactive.diffFilter="diff-so-fancy --patch" add -p < <(echo n) 
```

Cheers,

Philippe.
