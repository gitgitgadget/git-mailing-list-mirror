Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B58C636D3
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 19:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbjA3TGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbjA3TGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 14:06:35 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A139BA6
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 11:06:35 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id bx13so5124994oib.13
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 11:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJckalHK2pOCjs0+UQq4M9cIOFwWrCasKZRp56URILg=;
        b=HgCn+IOOvMoB+Y6sqAhC7pkqcgsBSQBYqf/IyseQudg4+0KMQbYlpt4/0Q9n76t/5p
         EiMtWZslifG2p5R2KyLRkkTyY5CMrGuDbxrVWOzOL7wEDG/qVkaQ3ZwQIRSM1ZH7VN2O
         BOyJZTmmsOZM8BF4A3jyJE3gBYTdCNfHhoKHCh6RWROnz0UhHMY+E0w+dg2xci4K8nG8
         gh3S1tkm7vTY/Hu8dUy6EGpKR+srZsX5RfN8sEtXqDeTAw2x9UsKCCju7TxeKXv9voFb
         Sj31hG2kbltZWBoB/V5BM/gabHFMAyKnAHrM74lLV5nEUgWEJf1g1n9RNPdYo4GqJNjZ
         aq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJckalHK2pOCjs0+UQq4M9cIOFwWrCasKZRp56URILg=;
        b=IY9wN9Pxt7Wkq5Kw/w/YN2WhQ5lrbLq9xsO6327+oTJz4qLe8q6djgQ51wq5hknTqv
         6XL8QxtCVrfmcTAx5BnMt05WCjQCLpm3As0IA2LbCi380+wYqq1TCzVTgziFZALwISJq
         myeDfj35LsMTa2Zxi9p/MqClMLX8zPv7KcLLo0hy/pibrZ9YcaWbIaetlnZ7ERREdckP
         cmDhdNp9lTUZPpLSYl/Yq6pao30MoZbha6BngoGUbrTMTKdUn83ru8cQ8NZbIK8V869M
         QUh1LriBH3V/oiXO8F9lMMwMaL6YuT3eqyktV/w5/qrXskgUr/0sal8RtJeX4K/WCbwQ
         6Mmw==
X-Gm-Message-State: AO0yUKVJxISSXZ5gc4X7k6P1nrCTY47UCNoPc8W4nJssRTcmjcu6qEjE
        MxUFOW+B8zUy/Tqfi44ie+tY
X-Google-Smtp-Source: AK7set+PeLZD0q28+7VfIuR5FYBEpCA2iqc/43CehfHY93gt1fK/C3pX+7C2Gw4u5+rFPfKVBdPwPQ==
X-Received: by 2002:aca:c109:0:b0:377:fae1:1175 with SMTP id r9-20020acac109000000b00377fae11175mr4777591oif.11.1675105594306;
        Mon, 30 Jan 2023 11:06:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68? ([2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68])
        by smtp.gmail.com with ESMTPSA id q125-20020aca5c83000000b0036f02656fa5sm5043598oib.34.2023.01.30.11.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 11:06:33 -0800 (PST)
Message-ID: <35796b79-dfa8-92c3-33e1-3313da10975a@github.com>
Date:   Mon, 30 Jan 2023 14:06:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
 <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
 <xmqqleln90ka.fsf@gitster.g>
 <4913381a-769f-aba0-c04d-559d103e8396@github.com>
 <xmqq357v8poc.fsf@gitster.g>
 <b63611dc-a889-8900-403a-ec7c42a89705@github.com>
 <db04e31d-681f-5809-f51a-37b9c734b45a@github.com>
 <xmqqy1pj3l3k.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqy1pj3l3k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2023 1:58 PM, Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> I'm also still worried about cluttering scalar's UX with options that toggle
>> use of its internally-configured options and features. One of the big
>> selling points for including scalar in the upstream project ([2], [3]) was
>> its ability to "intelligently" configure all of the settings a user would
>> need to optimize a large repository *without* a user needing to know what
>> any of those options are/what they mean. These settings are inherently
>> subject to change (due to use of experimental features); exposing a feature
>> toggle entrenches that setting permanently within scalar and makes a user
>> aware of implementation details that were intended to be hidden. At a high
>> level, it pushes scalar towards simply being an "opinionated" 'git
>> config'-configurator, which was a model I explicitly tried to move away from
>> while upstreaming last year.  
> 
> I personally do not think "opinionated configurator" is a bad model
> at all.  And "this does not seem to work here, so let's silently
> disable it, as the user does not want to hear about minute details"
> is a valid opinion to have for such a tool.
> 
> I too share the aversion to command line option for this one.
> Disabled periodic task support is most likely system-wide, and
> passing --no-whatever every time you touch a new repository on the
> same system does not make much sense.

Thanks, both. v2 will include --no-src, but not --no-maintenance.

-Stolee
