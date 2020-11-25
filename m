Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADADC5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 14:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13629206F9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 14:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpfdjX5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgKYOIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 09:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYOIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 09:08:18 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3927FC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 06:08:18 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id f11so2942080oij.6
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 06:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ptvxO7CthouuPeIuaWi7GVUzw6mz4FrT/PKPqswI4as=;
        b=lpfdjX5l5pi6DurPTFlXNxMZn3hoAwFhDZN9TWB17ZCfRrZjZyZgNEmhBDNHo1uGBa
         IwYbtbdy4awJ5msoLdA5YG/+c6iiFw/mASeqfSQtj38fjiy2TCwl7tqilP3aQbOSJKG2
         H9jc6P+sQy5mL6hGG0TmqQAo1bjwzuI9BloweD3jZQV6RLoVzrRVT40zsnqXoZ4aNKEg
         JbytBU5IQ59rSNP2pCu04OwNjUY6o0U44SRzGMkEjUugqqZu6uD5sKucS/Rtb3/i+RTP
         3VM6qjoAOTKlBnduIMTMcNJ2hHnR9x6rrxHyP6Vf0gZA0/hzNMEf1rf72GX4u93+wX2q
         eKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ptvxO7CthouuPeIuaWi7GVUzw6mz4FrT/PKPqswI4as=;
        b=rSravkEpk/sX4YyWveJm4uD/Kt2tjZl6dEePWBtQYDRSUQrMjVneMYkE2YAtLaQxhY
         um1qhBS0mdltKnqYJGoqJ8I+/6Fu6+4D/LEwqv2lVeOU0CYaif6vbsVH8CzVYD0Umkxd
         8Xg+h4qzUZCNyHw93f8JMlfbONsn3VeP2qXRWPxCdQ5Oc0u91btmkPEB21iq85div5Li
         PI6+CZSmgPguS3+3Iy6sLfKD9uANGY7unwZPYVU6j7qMRlmdBSVOZV26ZzExRB1AmRN+
         WR38EvGcipt+k/Q2MN9s6dPPGehtTJHgC/H7iqWNHuPXK3dFk7FveB8QK94NKUM4wJdK
         m3Kg==
X-Gm-Message-State: AOAM530qNmf1QAIB9fzfpPQeEayW23cSMdip6jcHk90BgfJqWmXI9HeP
        GDUlYajjgVkHXgxugjt8NJg=
X-Google-Smtp-Source: ABdhPJzltoqRRosczD25rA9+f6bgc7spoBWkBoIr31wBiTwnlgXPpC3Yyjb69oSKCJ8HKIfJ+oAnIA==
X-Received: by 2002:aca:4188:: with SMTP id o130mr2391318oia.158.1606313297504;
        Wed, 25 Nov 2020 06:08:17 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b5e9:7f83:ac96:1a69? ([2600:1700:e72:80a0:b5e9:7f83:ac96:1a69])
        by smtp.gmail.com with UTF8SMTPSA id i6sm1449004oik.36.2020.11.25.06.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 06:08:16 -0800 (PST)
Subject: Re: [PATCH v2 4/7] config: add --fixed-value option, un-implemented
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <0e6a7371ed4696f6cc85df07466fb6c20d58d62e.1606147507.git.gitgitgadget@gmail.com>
 <20201123215122.GD499823@google.com>
 <xmqqy2irlmq5.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91af356f-d0a0-1149-15dc-32da803ac6d9@gmail.com>
Date:   Wed, 25 Nov 2020 09:08:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2irlmq5.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/23/2020 5:41 PM, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
>>>  	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
>>> +	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when matching values")),
>> I'm not sure how to feel about this phrasing. I wonder if it would be
>> clearer to say something like 'treat 'value_regex' as a literal string
>> instead'? Hmmm.
> 
> Update the document and help text with s/value_regex/value_pattern/
> and say "use value_pattern as a fixed string, not an extended regexp",
> perhaps?

If I go about changing all documentation and error messages to say
"value_pattern" instead of "value_regex", should I also update the uses
in the *.po translation files? Or, should I leave them unmodified to
trigger manual intervention by the translators?

Thanks,
-Stolee
