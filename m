Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B1C7EE23
	for <git@archiver.kernel.org>; Fri, 26 May 2023 13:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243605AbjEZNTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 09:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjEZNTq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 09:19:46 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F68A12C
        for <git@vger.kernel.org>; Fri, 26 May 2023 06:19:45 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-561a7d96f67so11987357b3.3
        for <git@vger.kernel.org>; Fri, 26 May 2023 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685107184; x=1687699184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PkwpQWlR/bLo3H4m48hW9u1OyLEfLv79MO46dEvJAQ=;
        b=BP4zhTIt05xyLH2qdLBMe+YgXEjoHWm+fxHWow8wZAyrsMa1AbcbQTyr1K6nFXYh90
         jkD4vzlHgWZegMqXfMiHSLQ8VngsAbiOdBA7OfUVyzrEMh/wMOPNKkBhaXVk3C4i+KwO
         gSCARlbz3aZ74JlgSq6J+CF5AUCR97fNZikUoc912rQpZjwPG2FJHxKNPUKeW8SQfwlm
         cGA1Gn6B6hz2vrDUblNbFS2a2fwVQiWNRSnJxAtLc23vbgy4PNI43Og6m8zazasprAUv
         vxdUVkmf5/IvDOXj5zMCT6h05b3rGmvasZXzxx+kXkFHW4rBVhP3MhwvBl57UcefgTTp
         QJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685107184; x=1687699184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PkwpQWlR/bLo3H4m48hW9u1OyLEfLv79MO46dEvJAQ=;
        b=h/efbVwk5NCgehEWkN8troJruYewlVm76XnbvT34Y0dt9RxBkQPFej8F4sDpG/6rGB
         nibjS/DNiYQvYF1nPyCA5JHm6tZ0qWjsazsVXaHB8CkEK4dvNlblRExt7vvY1dPP38py
         Mf1m3VX6bvgexYrSTsyGVPl2aD0/Yk9feW6Z8gO29XVSUarSnfAdb4rGf2nBzA1v4kKE
         EYPpi+JbmTJDLBoSUVYduy7i3Suk4ZAUJ/u3bjBxfPFJfzJJRjDNwxvFVMVOJjKrMcZW
         FJ+lctlHhpl4/4FUe/GaPQ1W+t7VE9EuqUMD5H7bwcRYaqkEhZ+X/vKctbAHDzhu073c
         gfkg==
X-Gm-Message-State: AC+VfDxvBkf9Y9GAxa7W4P5c+W/VpC8VvcvPRnIChfNO8hPCoQFLRE8i
        ZIGudIAsY1+2ugA6u+G8aRdp
X-Google-Smtp-Source: ACHHUZ7FBomc7gthZWsQiWS2467afF3td5aSkA1WeiCMLIuO3+ewxyUKYUdKLNeF74V8nzBeYEykIQ==
X-Received: by 2002:a0d:ffc4:0:b0:561:baee:ee8 with SMTP id p187-20020a0dffc4000000b00561baee0ee8mr1984825ywf.32.1685107184467;
        Fri, 26 May 2023 06:19:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ac38:474f:c310:a7c6? ([2600:1700:e72:80a0:ac38:474f:c310:a7c6])
        by smtp.gmail.com with ESMTPSA id m6-20020a0de306000000b0055a486140b6sm1182362ywe.36.2023.05.26.06.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 06:19:43 -0700 (PDT)
Message-ID: <a4d22518-d3e6-76aa-fe94-2ec77a1de96a@github.com>
Date:   Fri, 26 May 2023 09:19:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH 2/2] commit-graph: fix murmur3, bump filter ver. to 2
To:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
References: <20230524212657.1348621-1-jonathantanmy@google.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230524212657.1348621-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2023 5:26 PM, Jonathan Tan wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> IOW, even if the version of Git is
>> capable of writing and reading v2, it does not have to use v2,
>> right?  To put it the other way around, we will have to and can keep
>> supporting data that is labeled as v1, no?
> 
> I think this is the main point - whether we want to continue supporting
> data labeled as v1. I personally think that we should migrate to v2
> as quickly as possible. But if the consensus is that we should support
> both, at least for a few releases of Git, I'll go with that.

I agree on migrating quickly as possible, within basic safety guidelines.

Shipping a Git change that suddenly is unable to use on-disk data that
it has previously relied upon is not a safe change. And that is the
absolute minimum amount of safety required. The other side is to not
make a Git change that suddenly changes the on-disk format without a
switch to disable it.

Think about it this way: if there was a bug in the code, could we
safely roll it back? If we are immediately writing v2 filters after
the deployment, then rolling it back will cause the previous version
to not recognize those filters, leading to a delayed recovery.

I'd be willing to modify my suggested steps:

>>> 1. v2.42.0 includes writing v2 format, off by default.
>>> 2. v2.43.0 writes v2 format by default.
>>> 3. v2.44.0 no longer parses v1 format (ignored without error).

to something simpler:

 1. v2.42.0 writes v2 format by default, but can be disabled by config.
 2. v2.43.0 no longer parses or writes v1 format.

With this, we could proactively set the config value that disables the
v2 format in our production environment, then slowly re-enable that
config after the binaries have deployed. This allows us to limit the
blast radius if something goes wrong, which is really important.

Further, I'm describing an environment where we control all of the Git
versions that are interacting with the repositories. Other environments
don't have that luxury, such as typical client users.

Even the three-version plan is an accelerated deprecation plan, based
on previous examples in Git.

Thanks,
-Stolee
