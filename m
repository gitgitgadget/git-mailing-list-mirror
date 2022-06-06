Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF70C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 20:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiFFUdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 16:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiFFUdk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 16:33:40 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA1478907
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 13:33:38 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c8so11249140qtj.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YYAwtK5MzQrxyKBiNVe/Kw11hgzCgQaQ80oqGxcMQpE=;
        b=WvwI2sA2PaDt59W59X3v15RCJ8vl4/wJo2xzEItjicjsBrkbV4ZgaSwDj7A5tUauFE
         ckFBPeiTs5y9BYFQP1slN6c+7ugqt/eyN31P7QjicoG/vvUm2kE6EU7TqKRC0hiNRkHa
         uq3QZBXAJQx+MLVvc8T3aHSpYiGu2Ka03uqMr9O0eQoS7uKsyHIkyCb5sLnGVW9j4hMi
         SLgySzjMYQWCfFryq7ZCfbF1saM0WEolI9SgI6mTENVdl0s8i1uWtkA9t556IaohL43g
         /ggKKfWZvB4WAFx/r42a1wjB1VI+MIaK6LVK8lhHbNw0+/KmXGrp4Fk6WUp8G/ccFDOI
         tnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YYAwtK5MzQrxyKBiNVe/Kw11hgzCgQaQ80oqGxcMQpE=;
        b=oWu3Ot/7FiWWpjWo5XVyGGPFPr5m5EK7VAQl6gUPWcXFoM68NhxBbhw6tG88KdrHK/
         NBtcK3e1l0E8pncZN8/zkstOatq1HdXy48eF6p0gOj47167gs6VUL5CrBWKs17L6tOjw
         UOYs/nqUalpttB6bHQAoHmXKEbhwLSyEAEel68to6Vx7I8lUjNplkkPbY6lJH78Kbzas
         SIJMwio6jZrjSOL0/5B9Gylq782KTs8aGwzLQ6y1BcK7CTnzC9QF0jtPicAmljldo3qV
         4TQfPXXwH7/VEz55eNKbGuqopt5GQJjyD42I7YiNgNmLe892XU3mMlSmH23utV/dkLfh
         /AEg==
X-Gm-Message-State: AOAM531igM/MZPnU2P3/CU/J9cjzs26DpWNwoBvF0h0s4W61fx3gneHp
        yvk8CNQ41TLl7QLp17CdGuuUTrruCKc=
X-Google-Smtp-Source: ABdhPJwRVUmqcDOf2kzLq+V0uEzp7oNKyrDKqIjkzloHBZ3vkTtwYlZ+gTbld/pDWZE4yw9IvUfKLQ==
X-Received: by 2002:a05:622a:1805:b0:2fc:ca5e:7b8c with SMTP id t5-20020a05622a180500b002fcca5e7b8cmr20212423qtc.429.1654547617674;
        Mon, 06 Jun 2022 13:33:37 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a258f00b006a6af149cffsm6263336qko.61.2022.06.06.13.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 13:33:37 -0700 (PDT)
Subject: Re: [PATCH] range-diff: show submodule changes irrespective of
 diff.submodule
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2206021724240.349@tvgsbejvaqbjf.bet>
 <xmqqwndznf0z.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <ed907ed2-ee9c-789f-0f25-0a1f5b58714f@gmail.com>
Date:   Mon, 6 Jun 2022 16:33:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqwndznf0z.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-06-02 à 13:36, Junio C Hamano a écrit :
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> Force the submodule diff format to its default ("short") when invoking
>>> 'git log' to generate the patches for each range, such that submodule
>>> changes are always shown.
>>
>> Full disclosure: I do not see much value in range-diffs in the presence of
>> submodules. Nothing in the design of range-diffs is prepared for
>> submodules.
>>
>> But since `--submodules=short` does not change anything when running
>> `range-diff` in repositories without submodules, I don't mind this change.
> 
> IOW, "I wrote it for the purpose of doing X, I do not care those who
> have been using it for doing Y, I am OK with changing behaviour on
> them".
> 
> Philippe, do you have a good guess on other users and workflows that
> may benefit from the current behaviour?  I suspect in the longer term
> this might have to become configurable, and I am having a hard time
> judging if (1) a temporary regression (to them) is acceptable or (2)
> the new feature to also show submodule changes is not urgent enough
> that it may be better to make it configurable from day one, instead
> of using a different hardcoded and only setting like this patch does.
> 
Just to be clear: the "out of the box" behaviour (i.e. nothing in the config)
is correct, i.e. submodule changes are detected and shown by 'git range-diff'.

It's only if someone has 'diff.submodule={log,diff}' in their config that submodule changes are
quietly ignored (log) or might crash 'git range-diff' (diff). So I do not think
of any user or workflow that benefit from the current behaviour, no. If you have 
diff.submodule={log,diff} set in your config, it's most probably because you work
in projects that involve submodules and you do care about submodule changes. So 
having these changes "hidden" by range-diff (or having range-diff crash) just because the output format 
of 'git -c diff.submodule={log,diff} log' does not use a 'diff --git' header for submodules is really
not expected. So I do not think we need to make that configurable. I think hardcoding
'--submodule=short' is an easy fix and a good first step in making 'git range-diff'
more useful for submodule users. 


Thanks,

Philippe.
