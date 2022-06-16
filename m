Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BBAC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiFPNDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFPNDn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:03:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E875320BD7
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:03:40 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z11so860078ilq.6
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FrXKsS5E+xK8vTxawqJzJwfJH/GI/40HXqJ/q8ACZLA=;
        b=HVHIGthJXjKw44Uoc5pQ0dKbTSVDhBfoxVYuqMvfqVLCv+1qR+fEhBr+pCUfqo0byg
         A/UawU57S9c1bJ+ViZVxegkYMJADG/GZ40EyANJWCgH5rr/HxuI9UoNAo4Vt8+eyKZWX
         DBvRHISBpf6IGLp9kUSXmdiDosumQl5Q9+JFjVxuKjc6jlA9TxQ+FonK7vsKFvhxiESf
         HWgKTOeBhcZuDjUcyqDegYQAdYwhb+JZcwoKAjrPECriRnuTVIBqOOQr8rGtsRJ0vov7
         MXqEqNaw1Xw6cuK0dwH+usJFHI5ITOKuRdydXPccH3WSiNhmR0nsqd4/ZUKQv2+5i8t5
         R4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FrXKsS5E+xK8vTxawqJzJwfJH/GI/40HXqJ/q8ACZLA=;
        b=KgtDXbz7C89SRHuDAD4ykEtI8tWfWux5MqeaEZXE9NU3oTavvekj1Zq6R+D67J0bMb
         hLoQ5S8F9IQjCm1CR4ixhaov6KtcDNW5NsU+rcU5oXYIGseOhshNe52PRstk8GbRKm8o
         pun+dioSXKbfv9cUySq/VH31FZxaZVKLLq0pF6udqtseHc1RS4yZVrK6h81tReHc7wYZ
         rO2tEPk7gmxnUgBeN6020GmRxPzxj5ZfoOAI3L0tvfMb3REEqOlzxpsvWCcFZfgNufyL
         LIiRBrHhF+5zo8WSss6CEgt3mo0rlKhxYHc3jcf0eWWMwijY1UzvBA856pzRIY2bLVEJ
         z8Ng==
X-Gm-Message-State: AJIora9JjyZmHLPgV+2hWDTU2nmqCWNGjjHs9GwoyULTXqueGZffwCe0
        S+4blH6xNS4NP4UrQB5a4QWtNY6em+5N
X-Google-Smtp-Source: AGRyM1tgqnycZKWrTxxCkSRCZBOXimxTqygV6J8HgizjJjLS7ZlVhqU4rrWA0d00FhoqYNA1bwwtWQ==
X-Received: by 2002:a05:6e02:1a21:b0:2d3:e475:4523 with SMTP id g1-20020a056e021a2100b002d3e4754523mr2704514ile.137.1655384620357;
        Thu, 16 Jun 2022 06:03:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:cfb:ad5:8ed2:9eba? ([2600:1700:e72:80a0:cfb:ad5:8ed2:9eba])
        by smtp.gmail.com with ESMTPSA id n24-20020a02cc18000000b0032e168fa56fsm856573jap.83.2022.06.16.06.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:03:40 -0700 (PDT)
Message-ID: <6671fd2c-ffcb-6278-494f-2d3cfe4c36d1@github.com>
Date:   Thu, 16 Jun 2022 09:03:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] perf-lib: fix missing test titles in output
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Neeraj Singh <neerajsi@microsoft.com>
References: <YqrXLO5oMYeOr2PB@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YqrXLO5oMYeOr2PB@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/16/2022 3:09 AM, Jeff King wrote:
> Commit 5dccd9155f (t/perf: add iteration setup mechanism to perf-lib,
> 2022-04-04) modified the parameter parsing of test_wrapper() such that
> the test title was no longer in $1, and is instead in $test_title_.
> 
> We correctly pass the new variable to the code which outputs the title
> to the log, but missed the spot in test_wrapper() where the title is
> written to the ".descr" file which is used to produce the final output
> table. As a result, all of the titles are missing from that table (or
> worse, using whatever was left in $1):
> 
>   $ ./p0000-perf-lib-sanity.sh
>   [...]
>   Test           this tree
>   ------------------------------
>   0000.1:        0.01(0.01+0.00)
>   0000.2:        0.01(0.00+0.01)
>   0000.4:        0.00(0.00+0.00)
>   0000.5: true   0.00(0.00+0.00)
>   0000.7:        0.00(0.00+0.00)
>   0000.8:        0.00(0.00+0.00)

Yikes!
 
> After this patch, we get the pre-5dccd9155f output:
> 
>   Test                                                       this tree
>   --------------------------------------------------------------------------
>   0000.1: test_perf_default_repo works                       0.00(0.00+0.00)
>   0000.2: test_checkout_worktree works                       0.01(0.00+0.01)
>   0000.4: export a weird var                                 0.00(0.00+0.00)
>   0000.5: éḿíẗ ńöń-ÁŚĆÍÍ ćḧáŕáćẗéŕś                          0.00(0.00+0.00)
>   0000.7: important variables available in subshells         0.00(0.00+0.00)
>   0000.8: test-lib-functions correctly loaded in subshells   0.00(0.00+0.00)

Good catch. LGTM.

-Stolee
