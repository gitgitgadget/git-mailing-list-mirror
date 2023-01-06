Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FE2C5479D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 23:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjAFXlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 18:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbjAFXlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 18:41:09 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0A3D5E7
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 15:40:56 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id i20so3442847qtw.9
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 15:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHQoV23YVtELHQnxUilXh9FqW1UmpMC5GRkGy8OuaNg=;
        b=gtcdfh4W7Q9Jd44fRd2gmVZJ05Txb32HRtBvV5jOFvnf23zjHkIjDuIRB+fIVA10sl
         7BzK6zfyT19O7MAB8wS94wxTVKcwqrNG/9KOtpe4gtbNaRDIw/wl5pu/6whORtAdwYYI
         Bncma6v/XAsuAENXBvPf9Pa5tQOGaYGAFehS91bsrz0lFmEEX/7KiX4+OOj1wtyeYXKU
         EFs95VetC09c2PU0N1vN2JtrmtGSxdXwTBo4hf/vE0ClSlqFTJ6LqkRd+vHyUsXO+ke+
         OFBjO4f+JdtBPdLHCePQf2+h0TqSa6rQlSYwxS2eRRCo/quzm/wD02rt3zRFdgsEDjfQ
         mxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHQoV23YVtELHQnxUilXh9FqW1UmpMC5GRkGy8OuaNg=;
        b=lIrm4HZeSbLucuQAvmVbkyOoDIxfWV7w61xsNPiCFRYCRhjvnqIY1GGg9m9eys2uYr
         yB9XYw9pOO08iLfGLSxn7Yoc3ArZUcNpVmb4EgyeaTZWGjI6tJVtpWD4AAp2LqoWWkK6
         K/Md5FGkenKFj+X80hezgOMIIknAyZlQf3JDUtMr1W0a87rP9zt4vFEffEGrIIriJysj
         /WrpC7iubkWTMsBLJz4EWKoB1WJ3I/Y62Hq7tRcG/9CkAVRLVyabXxOV1Jikv8Y0Xd85
         x0FwZzkVPW27rQOzjblfoR3IeUoN9yXVYGO91YKsjdov0dEFp2Ad6tt6de+l38v0UHQz
         wTWA==
X-Gm-Message-State: AFqh2kpYWf51JxUimse4QPmULc/7vNqGq2I3Wstc4wbPy3yBlZsSI85N
        tW8Fc9V3WkoEShKd+7B+cp+kA3pbaQsE1Sk=
X-Google-Smtp-Source: AMrXdXtGvmxLEy2UWtcpEzTFNlKlUu2qy6tOUC3wPc7iM9NRpIWzvzgu1GXLHh0NZF98ieu+WlHXBg==
X-Received: by 2002:a05:622a:4d47:b0:3a7:f183:7f66 with SMTP id fe7-20020a05622a4d4700b003a7f1837f66mr86504130qtb.22.1673048455881;
        Fri, 06 Jan 2023 15:40:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e894:2488:e26c:1f55? ([2600:1700:e72:80a0:e894:2488:e26c:1f55])
        by smtp.gmail.com with ESMTPSA id l13-20020ac8724d000000b00399fe4aac3esm1163723qtp.50.2023.01.06.15.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 15:40:55 -0800 (PST)
Message-ID: <bb48b1e2-819f-8bf3-ef4a-b9e4d23080b2@github.com>
Date:   Fri, 6 Jan 2023 18:40:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/4] Optionally skip hashing index on write
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, newren@gmail.com,
        Jacob Keller <jacob.keller@gmail.com>
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
 <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
 <221216.86sfhf1gbc.gmgdl@evledraar.gmail.com>
 <b2164be2-72e9-cee5-26db-3e4fbfec3051@github.com>
 <xmqqmt6vqo2w.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqmt6vqo2w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2023 5:45 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> After investigating some of the failures from creating a BUG() statement
>> when istate->repo is NULL I see several problems, and they are not related
>> to submodules for the most part.
>>
>> The first issues I've found are due to code paths that operate on the_index
>> without actually initializing it with a do_read_index(), or otherwise
>> initialize an index using a memset() instead of a common initializer. This
>> looks to be a frequent enough problem that solving it would require a
>> significant effort. It's not a quick fix.
> 
> Thanks.  It is not entirely unexpected X-<, considering how the
> connection from the in-core repository and the in-core index has
> been developed and evolved.  So in short, istate->repo is not yet
> ready to be used, until the problems you identified are resolved?
> 
> We probably should start paying down such technical debts.  We've
> punted on them too many times, saying "yes this is klunky but what
> we have is good enough for adding this feature", I suspect?

Yes, I'll make note to prioritize this soon.

Thanks,
-Stolee
