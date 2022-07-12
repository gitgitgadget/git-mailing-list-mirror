Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E89C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 09:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiGLJWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 05:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiGLJWa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 05:22:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8EBA5E4D
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 02:22:27 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y3so8925908qtv.5
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6WyklJOQqQEZXySplzN6yeVr3Ko9ddiAeBkad3Ubbag=;
        b=YdXdguAWjx8XJaBImzAILHKp9sI3dBcTsT/LZxOutlADDnotFnlkg+69OUue8eOK7d
         /5aHA60m20QO6UPqA24cotDNj6bHgV/fPZ0tuaN3SSDxKiLVOKHD1TOJoUE3Kex4lORp
         ZYaH0kKAUc83PvwdP3IY7gvVSWfG7XkZJ6UIXElrQVmEenv6MllLN6OmREyxaVZqR2Cz
         9XEr/n1pNAYiVpVk5TQb068aFwWrWHz+N/uERO/L/h5k59VBCg8D8IeO5GwPfW9rdB8y
         TyOHTlXs4MjSMgwsY3sn8c9HTFwLQKy4Mb56dgsj3qe3Fsxh2Nx+weYlQZl89H+Ujtk5
         p9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6WyklJOQqQEZXySplzN6yeVr3Ko9ddiAeBkad3Ubbag=;
        b=cQgSkNDzhfqdJCjrWeFtME1dsezscyqeXC3/XBWiqh4BuGjtqYi6RKBpZnPhcrQoNz
         qmShVG+YrpSaRIIBjzekpACtsDDYCX7ahFyqwDA33lg2/Z4mcsZTOG+D6J/mrB7/0mgR
         BhUfPAcd/e0OdCHNbsnnmRkHWAK0S9vGaU1yatMhwsWU6rjPVMewH45PQiAPVWeRN8JI
         z9r6rOfkr2OlVuKuJzlwEp3JMpkSXrWTsA3nKrgciABg2LnfvMclAekhgFOGgVXhQ5v+
         i7f+YKm/GVpNcsG+Ppxl6VBeno/vtaJmSWaPcahS1DhsZrFeh2y04KsFLzM0rfgQ42L9
         1jTA==
X-Gm-Message-State: AJIora8gGxuOl/Lh7naY0oP9vIInN9P4Mla7HljOPBQEAiT9tsFG6oZl
        hs2mOjJg0wDKwSbgKe0Pvu3XSaDaBQjWJnPc
X-Google-Smtp-Source: AGRyM1ux0H459gg31XSWb3iQ/OV1sGJT15kS/ntgDjYbSlggQ4cCaMm9DMqRJLsvp/j8McKj08Vm5g==
X-Received: by 2002:a05:622a:6185:b0:2f1:ebdd:58c with SMTP id hh5-20020a05622a618500b002f1ebdd058cmr17364183qtb.400.1657617746921;
        Tue, 12 Jul 2022 02:22:26 -0700 (PDT)
Received: from ?IPV6:2605:2a00:8000:dead:55a4:52ad:2bdc:5b8c? ([2605:2a00:8000:dead:55a4:52ad:2bdc:5b8c])
        by smtp.gmail.com with ESMTPSA id bm8-20020a05620a198800b006a67d257499sm8940326qkb.56.2022.07.12.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:22:26 -0700 (PDT)
Message-ID: <a8d2a61d-b86f-9b89-6391-36c58c390a12@gmail.com>
Date:   Tue, 12 Jul 2022 05:22:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Why is reflog so obscure?
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Gerriko io <gerriko.iot@gmail.com>, git@vger.kernel.org
References: <CALF=2ANoq1eL-RqK_dLaVThoxbvfhzgPJXFHyD1kX8CFCPx3XA@mail.gmail.com>
 <f0bb8ee8-9b38-45a7-a54b-24cf245bb3c8@gmail.com>
 <Ys0e9MxIWQj/pVXx@coredump.intra.peff.net>
From:   Thomas Guyot <tguyot@gmail.com>
In-Reply-To: <Ys0e9MxIWQj/pVXx@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-07-12 03:12, Jeff King wrote:
> On Mon, Jul 11, 2022 at 06:55:09PM -0400, Thomas Guyot wrote:
>
>> The reflog is simply a log of where you've been, in descending order (latest
>> entry first), and is branch agnostic. It show every commit you've been on
>> from latest to oldest, and each entry can be heads, tags, or detached
>> commits. Some operations like rebase may even generate multiple entries if
>> it's done in multiple steps (ex conflicts resolution).
> This is right with one caveat: the HEAD reflog is branch agnostic. But
> there is a separate reflog for each individual branch, as well.

Hi Jeff,

Thanks for clarifying that - I suspected it since we can do 
<branch>@{<date>} although I didn't find any reference branch reflogs in 
the documentation. I could've missed it... Is there a way to read a 
branch reflog?

--
Thomas
