Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21228C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02E864DE3
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhBASLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhBASLM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 13:11:12 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A8C0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 10:10:31 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id w11so8562870qvz.12
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vwtkw7JXg3OxoTKUKmQHdTy4PYFJaSRhUMWl9rQ8GHM=;
        b=kTpnhRE9PKUiLRudEGziJjpTfu5+BqCRhJurNEfG0X6jZKgW9+GPmMkXyeeDFIRyaF
         ACh3ehXcyVzvIdpEWGxKAJrPH7qj09lYqEMXHtT7YykVF7VhuqxxQp38Vhov1TIQUiyg
         Ei64fS5RzZfwokM7CWKxPHnkwW3sqi2HPSkNh3XXtxIc0MbnP2Y47KYrrzqt2M5sz7d9
         xWgPfWZ0srikwPD+TW2WfqiwlzTAjkShjn2hZtz19Rc9QuVAcR7hALlnpDJwgRqTrh+B
         IAdwisipXbyVKQaFOLRDar1N3/ER60lw3qxuUblHY6nv6E18OMMmhIzxUi+AK/1bujSh
         xRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vwtkw7JXg3OxoTKUKmQHdTy4PYFJaSRhUMWl9rQ8GHM=;
        b=BtuaXkXdm6QPqFubX6ioXwOsGpdrZPxlRbyFZ/DG4HWJOzjQaKt34PhV9I+czJkWv6
         GLa18DCWEfUudnxJ3Ykc2xz8wh3+7AP0TxAuUfpGEfk8QiMnU0+VPfY85lJ2UoP5685W
         wklD92X3lvzZiuLASZwnJUr/DJsHTJ3L+0v7N6vETpDfaQw1x8qgCRSibYGw2/0ICfdu
         hWMCENdnlqJ+vMSgXHVpc+eYRPG0EcqIF40a/quomQL8Hx3GUwT0bOSj5JauKDykAw+n
         Zc0G+goS1m0gKtSITHALkcLS8UZkm0CWSyIE5kWm5vd3Ad3+c9sep9/ILZIynf/Lcics
         A7/w==
X-Gm-Message-State: AOAM530u6lcwfIdzjKuDxEilVvOAUwAyk9ByViA1t/qdm2z8+oAbccU5
        37RDF6lDLfsrvnegaaLX7bA=
X-Google-Smtp-Source: ABdhPJz06aV1u3hn63eJKKalc+LbICCMlojl8nMUgNnpJR9tzd+3oibhsql6ESrg5iBYK6EicnXZxw==
X-Received: by 2002:a05:6214:3f0:: with SMTP id cf16mr16132194qvb.25.1612203031157;
        Mon, 01 Feb 2021 10:10:31 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8497:2090:4038:7fd1? ([2600:1700:e72:80a0:8497:2090:4038:7fd1])
        by smtp.gmail.com with UTF8SMTPSA id q92sm13903215qtd.92.2021.02.01.10.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 10:10:30 -0800 (PST)
Message-ID: <a040a680-42ac-66cc-831b-c23a23dd9837@gmail.com>
Date:   Mon, 1 Feb 2021 13:10:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 3/5] commit-graph: validate layers for generation data
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gister@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <d554fa306601c9e5e0e804d10b7a73b6eece6b04.1612199707.git.gitgitgadget@gmail.com>
 <YBg858G1eFy1if6o@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YBg858G1eFy1if6o@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 12:39 PM, Taylor Blau wrote:
> On Mon, Feb 01, 2021 at 05:15:05PM +0000, Derrick Stolee via GitGitGadget wrote:
>> +	struct commit_graph *p = g;
>>
>> -	if (!g)
>> -		return;
>> -
>> -	read_generation_data = !!g->chunk_generation_data;
>> +	while (read_generation_data && p) {
>> +		read_generation_data = p->read_generation_data;
>> +		p = p->base_graph;
>> +	}
> 
> This could probably be guarded with an 'if !read_generation_data', since
> if the previous while loop always read '1' from
> 'p->read_generation_data', then nothing needs updating, no?
> 
> (If you do make this change, please don't add '!read_generation_data' to
> the while expression, since it isn't a property of the loop.)

True, we could do that. It's enough to add

	if (read_generation_data)
		return 1;

>>  	while (g) {
>>  		g->read_generation_data = read_generation_data;
>>  		g = g->base_graph;
>>  	}
>> +
>> +	return read_generation_data;

then this becomes

	return 0;

Thanks,
-Stolee
