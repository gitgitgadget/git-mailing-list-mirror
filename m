Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C202C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJKQ7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJKQ7F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 12:59:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B271EC64
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 09:59:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 10so13846985pli.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rI63BbJewGTtX99iQ057k4sNGRVzZi7DU0S7PlEsU4M=;
        b=g2y1u1mXL6/kZ9vinvNb4263dDrwqvOtT6uIdbwGRytx1fee9Dco/97qAY9hfF8HCY
         qVnqE1FGCIVQUrqnRLgQk0B7aUaBZ+49mwymoqYKu2RPEoqvRa5S3S1C6C+7/N8ecdPn
         CJbKkRuyxAdBiivZwuN4ce2DnuDbZARqm2W23rgdF4R79FgEZMq5mhX6Or+I3wexnDP1
         xtccvsry6hKi9+KYMex+a3pTbG3O+QUGch7BapFJlHArlQC6RjlCgg9xENQiOChETF86
         lyCkWRMo/yJmyXnAXnID2OkEi24ZUJ5TF3HPdVq5APFUn9ad09nRuZ4evmRpAHip5+Wy
         9EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rI63BbJewGTtX99iQ057k4sNGRVzZi7DU0S7PlEsU4M=;
        b=7xeL3pNERKYVS+P+9BLXzHmFy0seYq5cAM0YdCB2ewFmV9DGVDPBF5Js1RzbKoad+9
         VFZxiqrYJ1VPSEycIXRmksCAzxzk1uA+GmHSqJwRi49W/VzSk7ncbQSNa6+KdMvOGRlH
         CkOwXcZPZO2ZsEOVNN4nNdpEphHbWhSQQOoB1itozqYpp6z6aromB3IXcWKz1d0iNhq5
         bZ6NaxKCS8auJg5YQ1xUyQF8xRdr3tyrisrA+Czv8Nfdy3SF8PoE3L35BD3/hLNdR3vS
         rmNM7QfyLeSQKabWQNvRqr9KrnodywxxGdiZ6k23hijUEH+7sNQV+NufVYVtoT3cjHZs
         XNyw==
X-Gm-Message-State: ACrzQf1895n0bfv2AJoZIPWcAQ8uzTxmILp39/mkzDPxYq+YvimjUTHY
        2dmfFCJvIY0hGGALwU1oOeQF
X-Google-Smtp-Source: AMsMyM7zQmzVhoCiIYNBjLDnk39frrOziH8mm/UKzZzplYf8ihO5CdUucdN7uvr1ogUBGQvjIgOt+A==
X-Received: by 2002:a17:90b:2705:b0:20a:b25d:5d93 with SMTP id px5-20020a17090b270500b0020ab25d5d93mr71619pjb.218.1665507544339;
        Tue, 11 Oct 2022 09:59:04 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id q194-20020a632acb000000b00439d071c110sm8095293pgq.43.2022.10.11.09.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 09:59:03 -0700 (PDT)
Message-ID: <0c7a87bc-f2b7-4c9e-cfe5-b4ba6b33fee7@github.com>
Date:   Tue, 11 Oct 2022 09:59:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 01/10] technical doc: add a design doc for the evolve
 command
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
 <a5eb93254191b7ae9c17ce52e056955c669ea007.1664981958.git.gitgitgadget@gmail.com>
 <35d65b75-c5c4-132a-bbd5-49d3c012c69f@github.com>
 <3384d8ab-ddbb-6e57-1663-d039fc99e0a6@dunelm.org.uk>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <3384d8ab-ddbb-6e57-1663-d039fc99e0a6@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 10/10/2022 20:35, Victoria Dye wrote:
>> Stefan Xenos via GitGitGadget wrote:
>> 3. Can't handle multiple changes sharing the same parent when the parent
>>     needs to be rebased
>>     - Since the introduction of '--update-refs' [1], this is technically
>>       possible (although it needs a UI for the use case you mentioned).
> 
> '--update-refs' is more limited though I think. With evolve if I have
> 
>                   D (topic-2)
>                  /
>     A - B - C (topic-1)
>                  \
>                   E (topic-3)
> 
> then if I checkout topic-1 and amend one of the commits I can run "git
> evolve" to automatically rebase topic-2 & topic-3. One cannot do that with
> "rebase --update-refs". We could extend rebase (or have a new command) so
> that users can say "amend commit X and rebase all the branches that contain
> it".

Sorry, let me clarify what I mean. The 'update-ref' command in a
'rebase-todo' script (not the '--update-refs' option) can be used to create
a rebase script that does what's described in your example:

  label onto # A

  reset onto
  pick 1342ab B
  fixup 8a7f3e fixup! B
  label branch-point-1

  pick 90d7fc C
  label topic-1
  update-ref refs/heads/topic-1

  reset branch-point-1
  pick 42f92b D
  label topic-2
  update-ref refs/heads/topic-2

  reset branch-point-1
  pick 06d8ec E
  label topic-3
  update-ref refs/heads/topic-3

So, while it'd need a less manual UI (e.g., a 'rebase --evolve' option) to
generate that script, the 'update-ref' command makes this functionality
possible in a rebase.
