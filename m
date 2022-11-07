Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB28C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiKGUqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiKGUqj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:46:39 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC60DF29
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:46:38 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id v8so7932735qkg.12
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+wpE+k2owp/m2kSV79L69AcP8JcQVYLPmVfz0o89X0=;
        b=TqPuggt6vmQo4vC9aP0awQNC1I8to7SF7SvNTZzTknLciWIJZLYUa5ACmSs9TaUwxy
         rZae6oICil88C7rDCPzzTvZI1So3vmeukCDNFkHmoH7+J7oSHwAM0sZCTUiDgsY3yNoT
         gkgaUzidhApgMGlnk+dA6cmyKihB7mam/zgWGFwpwQdI/vl42A5LVYZOyQNis7a8QzAw
         wcxZVAMn4U9SXbicPx7HfjKz9hKeKLLu9xzDFX2dL76woGYQBTlM0tJDFOQ9Cr6Ly5GL
         w30vRQ84T2FgW+Tig6GcVPqZIvaGDTWf29sPN7gKEMAYDstxlWBjDoEBpXkE/80G6CtQ
         wE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+wpE+k2owp/m2kSV79L69AcP8JcQVYLPmVfz0o89X0=;
        b=qo/IhknQ8RG5OS6X/K7LFUjHiyqeEZSY7vEXjBcMxH96yIAanU4ZDP0P0sN5ejGHiG
         ZuWS6KiFJvV3qKh+KuIG62gaxog8TEn6B6Qjec9eHZ6DGiuIK85VgCQpTM1SQzSpr5KB
         /bxNB638ZVMb0y2D/rIOlKL+OOiMuCRm079/Al4fC+AyREjdznCbWLGkwz/XowFL39aJ
         1hlSZHJXqjMIYPblhev/bLi5aKhM4qOwu7ePOB2HfIa15TgfabaJZf1evfpwrJCC9CsK
         4u0uiJK1XTotW9XmzhI9pgr3XaCDUX8GHhG4E2KYhwBZuWUP7F1uWmJv/ORSR/rESF2/
         V50w==
X-Gm-Message-State: ACrzQf1IzRnKVAnc7NhnMKLdozyjpHVXULCfcw5u1otsXkBwpBueBNH6
        9sJRD9YTo5538rWgX/msmAe3
X-Google-Smtp-Source: AMsMyM7G+qc8zzYfXc+AZDTB8IiOkCjLIzGV751b46UMRXF0f2eUJhfU4WtZdbiNJTpBjV8WWG6DNw==
X-Received: by 2002:a37:447:0:b0:6f8:cde1:fcd0 with SMTP id 68-20020a370447000000b006f8cde1fcd0mr36649993qke.150.1667853997705;
        Mon, 07 Nov 2022 12:46:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id ga23-20020a05622a591700b00399ad646794sm6782815qtb.41.2022.11.07.12.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:46:37 -0800 (PST)
Message-ID: <15d9326c-8a32-c11c-53b0-cf399e541a48@github.com>
Date:   Mon, 7 Nov 2022 15:46:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] for-each-repo: interpolate repo path arguments
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>
References: <20221105184532.457043-1-ronan@rjp.ie>
 <20221105184532.457043-2-ronan@rjp.ie> <Y2cAFSR83bjFFcq/@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y2cAFSR83bjFFcq/@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/5/22 8:30 PM, Taylor Blau wrote:
> On Sat, Nov 05, 2022 at 11:45:31AM -0700, Ronan Pigott wrote:
>> This is a quality of life change for git-maintenance, so repos can be
>> recorded with the tilde syntax. The register subcommand will not record
>> repos in this format by default.
>>
>> Signed-off-by: Ronan Pigott <ronan@rjp.ie>
>> ---
>>  builtin/for-each-repo.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Seems reasonable. So the 'register' subcommand will never write a record
> that isn't an absolute path, but a user may manually munge the
> maintenance configuration and we want to err on the side of flexibility.
> 
> OK, sounds good. Missing test, though?

I agree that this implementation looks good, but a test
would be helpful to be sure.

Thanks,
-Stolee
