Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF45C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E92613E7
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFCM6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 08:58:42 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33775 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhFCM6m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 08:58:42 -0400
Received: by mail-ot1-f45.google.com with SMTP id q9-20020a9d66490000b02903c741e5b703so4495470otm.0
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AH7tjjgFKISQzNU5NzqjiWLU70LHgtv/awIArAGpQ44=;
        b=Hx0H/cLUZeMGYr1tsN8/ofaIIFlgsnJgnhCthhkq2zc7Dx/O1issGO3hLBoi2dWWql
         Fx3S46dof0qjvQrGt5WVahraZlbhTdmqLUJ+pf9+meC6rB+3REmrt0meNWCFQkwnCoQI
         fP9orLjHsLl8imAXLGM2QhaD0gCr4ArNZu3xhaDOOo/NlLS14SRVlfNdNY2llrmlUAXv
         5Y5UIivPIRd99D9dBAp/oJS/lFYD/TnTH0KimUPeMHxJtJpjFafpSbUt/DyNrYxIfoK+
         AN/YiGKD9yRe6CFjHhbok5MRn8l8GyTgn8V0+n2PxZCtXpmwBbPfMwyB6/w8a75IIKVK
         KSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AH7tjjgFKISQzNU5NzqjiWLU70LHgtv/awIArAGpQ44=;
        b=Fd4VCMZEMLYBMIU/kU/SarIswOi8aNj1r644/kMW1lDmPdt/MuE4VwDOq+2RG62Ss4
         tqypWy/O64Dyjmp1sX5AGacIXA1ehlBnzbeu0A1A/9313Yk5DCt6NI4vCStTA4C9YvJx
         6g8YMt8n3DN2ZiO/2M/2bQpzCwiKuaCR7jFkKBOGpWU+GC0nbScSZ10SG2UixpWi5tD3
         7juEZI2cgr/4CKYq0ozIM/suhHWWz9mUYj0sJlbtc4XjyjQxogkJQ3FzmNf4KoLKR0ht
         +sIPUV1LvIlrhcY6QQIFQz/HM/eU7QmmqopE9v2xt1824fn8FtToasN6i2NNgSnhJasu
         PBzg==
X-Gm-Message-State: AOAM533uumGeMWuj25V51z/ZsRXO+g2GLFDFnTpDbCRy7hFp5aQE2YJq
        48RWf07CQmZzrzMkHT984Rs=
X-Google-Smtp-Source: ABdhPJwTql1XWfXXlre8JveJusxp3jyKQ+d46IYP5MlRwKqvlc6oofG52eUnhJ1POIesQLzYY67C1A==
X-Received: by 2002:a05:6830:19d9:: with SMTP id p25mr4900590otp.236.1622724941226;
        Thu, 03 Jun 2021 05:55:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:c134:af19:92db:52e4? ([2600:1700:e72:80a0:c134:af19:92db:52e4])
        by smtp.gmail.com with ESMTPSA id y14sm646970otq.4.2021.06.03.05.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 05:55:40 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Optimization batch 12: miscellaneous unthemed
 stuff
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <20ec3b80-ce94-6ccf-05f1-3ee488e467ca@gmail.com>
Date:   Thu, 3 Jun 2021 08:55:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2021 10:58 AM, Elijah Newren via GitGitGadget wrote:
> This series depends on en/ort-perf-batch-11 textually, but is semantically
> independent of it.

I have read this series and really only found some nits in
Patch 1, but also think Patch 3 should be ejected until it can
be consumed by a full integration with a testable command.

The other patches look good to me.

Thanks,
-Stolee
