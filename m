Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1426C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753A222AAD
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgLDNrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 08:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgLDNrp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 08:47:45 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20226C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 05:47:05 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id t143so6149229oif.10
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 05:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/rEBdoW8ArzXBqqukdW3W4Epg18qPCyjFsoBCiFohlg=;
        b=eDaisP+AQ7YrOh28so44dK1sH7jikpEpHVBVwc8S9Ksnnds30VjA+4Lbj6CQh4mGEs
         rz0DBsks21MY9rHchOGC3Bf4TUKKlS4BAJ6DNZxFa0xOfdlpLEX+UVVkd3oIMa8itDC1
         oZSYxFi6wBzEi5fY8/RzRH0/y48RaMWnhdNIdiKFvitbHASUTVPfyfaV5/VAHwcFXv6B
         Ve+MFcN6iJjxhhtfgaeOd8Js670q2/PLOMbNPsCPY5lJyMMRdb8uPbJ/exMmfCXqF+u6
         hBO+wePNCzr5UCkk+2HNAOOf3mxASGcURoq0v+szIGe05vQF8YjolvxXck0tLQBZqIK0
         BQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/rEBdoW8ArzXBqqukdW3W4Epg18qPCyjFsoBCiFohlg=;
        b=UBZotXJ9FcelT+qpyJoa+ach/J/DA6YW8iS9Mv9JeIt7qJixeNAOVQHJPzR4uAG4f2
         W/qsBnEpBzNFzh4OqpAVH8MiOT8/6/8oX5n0k5XXNCqvTtu13FCMFjUIsX5poR1F6Mc5
         Ixob1TI8NnHnuXX4NsmsG0PK8PtT3QrXlI1pNGRJmoF8tIKEsB4ac82lQJgaQxFOnFv+
         8s4nt/xUXhGh2c3ENzB4JmPtAyLEXTGgGepHTQdyjD2W45PZODH8bEa+p4y6hpQRe1fW
         fzei4l0sXavbps7D3oF406BckFIIKMj/HyHKRVZNGa84AHokM5d5zkxCxCOovjLYMIJL
         yz7A==
X-Gm-Message-State: AOAM532l6aJZaVr49WILcYOuqX9MnFnsjaaakT5bZ4cjmQYu+Mi8lHwM
        o4t/OWkH+nMzXzAQte+eqrY=
X-Google-Smtp-Source: ABdhPJwRuqZNtxiVptkxdY4gTWTNmzCEWuF9Cq1CAROTkr/pAlW9WDiN46wWElN0O2W4nUmnZ7SRdg==
X-Received: by 2002:a54:4d9b:: with SMTP id y27mr3280916oix.130.1607089624551;
        Fri, 04 Dec 2020 05:47:04 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id h3sm621618otq.33.2020.12.04.05.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 05:47:03 -0800 (PST)
Subject: Re: [PATCH 13/15] chunk-format: create chunk reading API
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <6801e231f7414444a272f2ea87dcc6f60f29e25a.1607012215.git.gitgitgadget@gmail.com>
 <xmqq5z5ih6v1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a7be6d74-373e-e18e-b915-487bab28f438@gmail.com>
Date:   Fri, 4 Dec 2020 08:47:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z5ih6v1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2020 5:17 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Now that the chunk-format API has a consistent mechanism for writing
>> file formats based on chunks, let's extend it to also parse chunk-based
>> files during read.
> 
> Heads-up.  The generation-data work by Abhishek would conflict with
> the way how this refactors the way the beginning offset of each
> chunk is found.

Right! I should have checked against 'seen'. Abhishek's work should
take precedence and I can adapt on top of his topic. For now, feel
free to keep this topic out of 'seen' while we address the worth
of the topic (re: René's concerns).

Thanks,
-Stolee

