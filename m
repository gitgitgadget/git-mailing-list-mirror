Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874EC4332F
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 13:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiDRNFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbiDRNCy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 09:02:54 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1834126AE6
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:42:59 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id d9so10824175qvm.4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a0cc3LhFR59clah4UPUhfYGztgGXOJDA/fEp8iPFKeo=;
        b=Q4uKiAQjzIc+tewyajgEiwgXHvz++/c27/s5hFCHG/OTOk/1x6LsJhYkAeRaNjN5rw
         LrTtKj4J67gNuTVwahLLXXzSv5mPUpRtLqBUORsPMY5MKdbroEUJfj9kQCUylgMS7x92
         8M/vtvt2I7UWadUGrqeXe9UXyh2FGxJvgZHyoWPCR9v0XNkAVVnmNNzWjkzE7q6YwS5l
         CJ4lHp8p0i1OWfUrArmoGrXnj3ZnZgMelhKdN76Qs5ERle6Kv7Nv0dKSKyYjS4sngkwY
         FLk2EIwu/3+3nCSNKleClSkEjOaOqfjGeWLFd3tbjqNZuvM4lxR8/jnobjnD4J6Rga45
         IOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a0cc3LhFR59clah4UPUhfYGztgGXOJDA/fEp8iPFKeo=;
        b=J3r5MeJtYkr4Ie17Dti/xubqnadtwfJVwRVihna3Bhlc5GpjNBCn0O2kupaTuWtLuv
         1ozH9nn/AxEKsyFGrpJQXePkdlYE3qlQ7ncMpeZS/WfPwMighuAOaPTlfDezlmCAqk/x
         zy3+t0SYJ3ZAat7etlpnzU44eog+SsyvYPeUVSAIJIf+KfS8UkHCoGymX26LIRquXjlZ
         el/eAhkEnY81ezjCFPWWXirysG9RKYHxXj/5G2CwytN6SVPMsULVfnklRpK6ho1tgdD/
         5frjhbfjio+7KbgXqNo9qTVqV2/+K6/+G6Qxc44cbAIWhKVjKwLp2SMs4ug35k2goJ7w
         mjDQ==
X-Gm-Message-State: AOAM532KJR8w9MuYYOmRt/WY0SmabW8liWORl7UsDg5NXE7SD1Wb4Lwy
        uBwiOJb4j4sQ5wGfsurpvZXO
X-Google-Smtp-Source: ABdhPJwCumJy4ZuU8VlEUOLOqmhtg1Y+2pAbofzkb1sNyQe1sSUn8qF0PIHy9huEv/wEEteLp/aMPg==
X-Received: by 2002:a05:6214:2a82:b0:443:e2fc:c209 with SMTP id jr2-20020a0562142a8200b00443e2fcc209mr7552611qvb.59.1650285777671;
        Mon, 18 Apr 2022 05:42:57 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f6-20020ac859c6000000b002ee0948f1aesm7344951qtf.72.2022.04.18.05.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 05:42:57 -0700 (PDT)
Message-ID: <61829024-32ab-bbdb-7950-8929b17d6add@github.com>
Date:   Mon, 18 Apr 2022 08:42:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/4] Sparse index integration with 'git show'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        vdye@github.com, shaoxuan.yuan02@gmail.com
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <Ylhp+q96KOt2+OGZ@google.com> <xmqqk0brz7tb.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqk0brz7tb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2022 5:14 PM, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
>>> 'git show' is relatively simple to get working in a way that doesn't fail
>>> when it would previously succeed, but there are some sutbleties when the
>>> user passes a directory path. If that path happens to be a sparse directory
>>> entry, we suddenly start succeeding and printing the tree information!
>>>
>>> Since this behavior can change depending on the sparse checkout definition
>>> and the state of index entries within that directory, this new behavior
>>> would be more likely to confuse users than help them.
>>
>> The two paragraphs above did not really convey to me on first
>> read-through what the problem was. IIUC the main points are:
>>
>> * git-show does not currently work with the sparse index.
>> * A simple change fixes the above, but causes us to sometimes print
>>   unexpected information about trees.
>> * We can use the simple change in our implementation, but must do
>>   additional work to make sure we only print the expected information.
>>
>> I think this could be clarified by:
>> * Including examples of the unhelpful output from the simple
>>   implementation.
>> * Describing in more detail the situations that trigger this.
>> * Describing why those situations don't currently happen without support
>>   for sparse indexes.
> 
> I think the issues patches 2-4 addresses are not limited to any
> specific command, but how ":<path-in-the-index>" syntax is resolved
> to an object name (including the way how error messages are issued
> when the given path is not found in the index).

Yes, this is the critical bit. It's the only part of "git show"
that cares about the index.
 
> But the title of the series and presentation place undue stress on
> "git show", which I suspect may be confusing to some readers.
> 
> For example, with these patches, wouldn't "git rev-parse" start
> working better, even though the proposed log message for no commit
> in the series talks about "rev-parse" and no tests are done with the
> "rev-parse" command?

Probably, assuming we unset the command_requires_full_index
protection on 'git rev-parse'. This might be a good case for
Shaoxuan to try.

> I am not suggesting that commands other than "show" should be also
> discussed in detail or tested.  It would help readers if we said
> that we are using 'show' merely as an example to demonstrate how
> ":<path-in-the-index>" syntax interacts with the sparse index
> entries (1) before the series, and (2) how well the improved
> object-name parsing logic works after the series.
 
I can see that.
Some background: as we shipped our sparse index integrations in
the microsoft/git fork and measured performance of real users, we
noticed that 'git show' was a frequently-used command that went
from ~0.5 seconds to ~4 seconds in monorepo situations. This was
unexpected, because we didn't know about the ":<path>" syntax.
Further, it seemed that some third-party tools were triggering
this behavior as a frequent way to check on staged content. That
motivated quickly shipping this integration. Performance improved
to ~0.1 seconds because of the reduced index size.

Thanks,
-Stolee
