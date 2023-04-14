Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E5C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 19:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDNTta (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDNTtY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 15:49:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EC14C39
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 12:49:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso6113752pjb.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681501759; x=1684093759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CC4oRzqMk72n/6GwASutxIcm7ZjAxLSLXNxzCjp0AEE=;
        b=F+T+BkMxRMUJjoeEBnFOAQUS7RGt2rWu07PTQja1v41H7rtoIXjByXzuXZFBpkY1wn
         91JomY6cbZYpsyRp/ElG8F4dncOhsuDMLrF1RfIkskqIg5Qpi+EqyUiKGGgVB8A5g5Xr
         7qyBuVBlXHQQq6ds8RB4n5s9UaLZZR9ohIRVVkn8SHJv0UgFAUy71VHCbHUbYkAS4Odx
         I1ZGTAwO62/HM4dZRQztGG1zFSzgPabtbkSKDe5+vDHJmH9hP6vNPFC7WETs/Q1DcQ2L
         aaVw7wnWAstUcVReIftRkQ2TO/M9SWDpoY5BBZrZIVPYHA2iqyp6R3AJkoKLFGPYi07m
         yelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681501759; x=1684093759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CC4oRzqMk72n/6GwASutxIcm7ZjAxLSLXNxzCjp0AEE=;
        b=XZqYCILMGdpsuy7Xv0Eut3feJ21UHZAcgVdBYM1qnZpmVfddjS/4MIfIpf3FNF3rep
         i7R9MWq7zuetUe2rrH0MKFcdxOs2WraEJck83Pyp9LNvLd1cRs5vRc+oA9MaEXC43hMK
         Y1Pa8npr6WCBDSZkkE4JWDOanHdULGkaFo+zqTY+YeitMEli78hLKOdGZuYT3Y6IMvp7
         kG3smlYbq0czu67PhzGYO8R0ThUL2+txWlyZOOSxIIBOak0/g6E+GMX8K/wG8Oagcj3S
         1emKfYRHxTv8LbITn3Lzsdh5tJs6x3z6q0fxj2Az/9JFmMv6kZHS36xQ4F5THnjRrLze
         nl6A==
X-Gm-Message-State: AAQBX9fjMp4m3S4nkVsdOIrixOxWVOQoNNIn3jpP6QB/wKO4ro0iwPk+
        SRcAdDzqiuVnvTwec6WU022k
X-Google-Smtp-Source: AKy350ZAwBw7a/ZPKYTGs9DmVmzAsY63LhxQMxkMGHjI20ekEbEf9+ZiyBEe81uv3Oz2xpSHwsIEIQ==
X-Received: by 2002:a05:6a20:4a04:b0:d7:380b:660 with SMTP id fr4-20020a056a204a0400b000d7380b0660mr7343188pzb.3.1681501758926;
        Fri, 14 Apr 2023 12:49:18 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 142-20020a630494000000b00513955cc174sm3186968pge.47.2023.04.14.12.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 12:49:18 -0700 (PDT)
Message-ID: <ebcf2426-db40-e967-9db5-532869cac8ff@github.com>
Date:   Fri, 14 Apr 2023 12:49:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] revisions.txt: document more special refs
Content-Language: en-US
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <66c7e514157f3c8220eb994cea7c4659d5241042.1681495119.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <66c7e514157f3c8220eb994cea7c4659d5241042.1681495119.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain via GitGitGadget wrote:
> @@ -55,8 +55,15 @@ you can easily change the tip of the branch back to the state before you ran
>  them.
>  `MERGE_HEAD` records the commit(s) which you are merging into your branch
>  when you run `git merge`.
> +`REBASE_HEAD`, during a rebase, records the commit at which the
> +operation is currently stopped, either because of conflicts or an `edit`
> +command in an interactive rebase.
> +`REVERT_HEAD` records the commit which you are reverting when you
> +run `git revert`.
>  `CHERRY_PICK_HEAD` records the commit which you are cherry-picking
>  when you run `git cherry-pick`.
> +`BISECT_HEAD` records the current commit to be tested when you
> +run `git bisect --no-checkout`.

This is a fairly minor point, so feel free to ignore if you disagree or feel
it's not worth the effort:

Although the special refs in this list (HEAD, MERGE_HEAD, REBASE_HEAD etc.)
are visually separated by newlines in this doc, they render in the manpages
& HTML in a single monolithic paragraph (see [1]). With the addition of
three more descriptions (four if you count 'AUTO_MERGE' in patch 4/5), that
paragraph is getting large enough that it might be difficult for a reader to
parse and find information about a specific ref. 

To help with that, you could create visual separation in the rendered doc by
adding a '+' between each special ref description; converting them into a
bullet pointed list would also work, I think.

[1] https://git-scm.com/docs/revisions#Documentation/revisions.txt-emltrefnamegtemegemmasterememheadsmasterememrefsheadsmasterem

>  +
>  Note that any of the 'refs/*' cases above may come either from
>  the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.

