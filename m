Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51E1C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 16:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJEQLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJEQLK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 12:11:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2C7CB63
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 09:11:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v186so16215777pfv.11
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=x6age0ZlfxnU4ke3aqpm5HD/eI9xZ0wPhtYytwwXUoI=;
        b=gjAy/hVbB5y5ixjPDR/agoMl7kAd5mTIkuewJiRQvKVV490xTWtVtE7Q2t33NmN7k9
         o06BqbhcWcVTpyoIcWAqgqncmGarVidhGflv4SzVwii/Hsr2oTrOndFxDdBCbxcmkZgp
         gRMmfCe/IY632tKdEYz4r0BQe90K8MtL4xD10OfEBY6rzmn+f+MyrMLliEcOqIlxwjDr
         ZyDuBXp1HTybZhROSyBVVs/VqVS4pss+QWjvV9oC/yrcaFj1xg7R1O3/bDNxy2fv0NlW
         6b3q26tiVpw+Dx/AImwoXZa14/2g30j6qC2kc/GrSjaC+f2+Yp+4bgq4V3J+B3HiR+Jv
         d7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=x6age0ZlfxnU4ke3aqpm5HD/eI9xZ0wPhtYytwwXUoI=;
        b=7KKT2au/zB1Oba803edmPhHwSxKBl1LuYS2HTOggb2pO4BY5ey5EVJzQ1C1gpf5j6J
         brSyS81+H8kBlUSjujIKEb3IJGnXjqraHPN5NpxE+UngKWtOL/sg4xiqkd/CUkRuCYM/
         j43TkOox7mnl3cxkoyLGMvuB9MmDcOynbf6u3wJnZAX7dSugQE8wYYF1ZaHFcbXtVt4P
         bRps1o707Brpozkc4lrQHGluXsDG7a0gLrsXJZNmKj36TFr/VSaDpCmFXJf9v3LcvXwB
         2xU4+WYwqJSE8kSdb81Yj+/pzU9OVN95+pLykibeEdxvUQtKMexxDjtF37YIaSOwEvO3
         GIug==
X-Gm-Message-State: ACrzQf3FeVgUzpUxtJ8UDBSMABDE8E029eTB95z87IBsU6vTUmpRcBOL
        Z2NVZV5/rP7bjYVggdNGZZXD
X-Google-Smtp-Source: AMsMyM7kskm0Au+wIb2UA/RbqY2QG7TihdUv/NXUUZe0TUQcEsvcgTFFIqWO3JONK0qH/deuy96eWA==
X-Received: by 2002:a63:4f09:0:b0:440:4706:2299 with SMTP id d9-20020a634f09000000b0044047062299mr469753pgb.115.1664986268159;
        Wed, 05 Oct 2022 09:11:08 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w23-20020a634917000000b00454f8a8cc24sm3128357pga.12.2022.10.05.09.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:11:07 -0700 (PDT)
Message-ID: <85def494-46c5-3785-8c78-31a733ab72e0@github.com>
Date:   Wed, 5 Oct 2022 09:11:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: Bug report: `git restore --source --staged` deals poorly with
 sparse-checkout
Content-Language: en-US
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com>
 <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
 <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com>
 <CAESOdVByucFm=yJn2yL1mwKGqey7tHXH4A-JM-yP125Ok+_Q+g@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAESOdVByucFm=yJn2yL1mwKGqey7tHXH4A-JM-yP125Ok+_Q+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk wrote:>>>> Theoretically, 'restore' (like 'checkout') should be limited to pathspecs
>>>> inside the sparse-checkout patterns (per the documentation of
>>>> '--ignore-skip-worktree-bits'), but 'Documentation' does not match them.
>>>> Then, there's a difference between 'restore' and 'checkout' that doesn't
>>>> seem intentional; both remove the 'SKIP_WORKTREE' flag from the file, but
>>>> only 'checkout' creates the file on-disk (therefore avoiding the "deleted"
>>>> status).
>>>
>>> Restoring only into the index (as I think `git restore --staged` is supposed
>>> to do) is weird.
>>
>> 'git restore --staged' is intended to restore to both the worktree and index
>> (per 183fb44fd2 (restore: add --worktree and --staged, 2019-04-25)). The bug
>> you've identified is that it's not restoring to the worktree.
> 
> Ah, `--worktree` is on by default even if I pass `--staged`, I see. Hmm, the
> help text actually says "Specifying --staged will only restore the index."...

You (and Elijah [1]) are correct. '--staged' overrides the "checkout to
worktree" default behavior of 'git restore' to only restore to the index. If
you want to checkout to the worktree _and_ the index, 'git restore --staged
--worktree' is what you'd use.

Sorry for the incorrect information! 

[1] https://lore.kernel.org/git/CABPp-BGeC3hXw-v3voniY5ZU2f6W8NXfXVvq0C03eGGhvSefgg@mail.gmail.com/
