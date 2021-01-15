Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,PLING_QUERY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7271C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 10:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB6C235F9
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 10:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbhAOKaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 05:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAOKaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 05:30:13 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A8C061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 02:29:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m187so606721wme.2
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 02:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6vIgDVLayLVGJnwVVuB1IU/apm5qKfXmPnqAmoUaf1o=;
        b=KTbpTH4QtkEBWPQh/2TU+VHvkmlTgEFtgdYmqUgFOEXhEDz2LjvC68PhB4qcV2CBKf
         787RV672I7GQ6NbpYIEjHPvRZYj5c7jO6uCqpKTh9lJ3pGbkoFawhq6CUw0RTV/HEUGt
         NR/Hx6kPVn23g7NXnu+RkePJ0f0WlRzpdiZBeNOEA3LdTbckly6ydyLt+TwV6TuFdh63
         zqtqdkI3uMiM3jlasNp+DhNXrChipmTTc+DUu6XvM+2cmIZ351qjaM7KGd5aueqDn3Sq
         wEmoT8/9DuMAunFwKMTbpWlmVKEviEXYKb3ymTz5swv/vWZWjlxySg5eMGBTpQpYFuag
         aJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6vIgDVLayLVGJnwVVuB1IU/apm5qKfXmPnqAmoUaf1o=;
        b=rd89wIAkEAqv+Snci1AfA1Htr+afrd1imT9ytlfr4B6TuFa34+X7WcZAEWu4Q7zRKM
         GUJa01m6KNWausM9Tj04YC7qbjZpSNV9nQh8NO6sOpRUqs96K5HSay9OAOkmgTywJlrF
         X3f9zVYXPnVIMnVZXJLuzkCC6lXf/WmI9k+nfkFNbqdXTv9VzdluPOkMajnJuRxIv6qF
         OgeCWCtzlExFYCmJoeX/SFeY9Y25kTfY8uVtzO+HGG0A6Py6tWFzFRHZ+DWu8QGzlaWj
         fR8fDiRN7RMTXRkgetQ6zgvGPYOYz6RMyLLXxdi5tc9Iaimrl27pqWAiaBeYY9V26gXf
         +XXQ==
X-Gm-Message-State: AOAM531/S5DUtibS1II/efNSPdtPIk7avZvjVG+BeYKEkk/iovq4hqny
        BBOQU1imL3O1JmzcFHiJ+C+/0siizHc=
X-Google-Smtp-Source: ABdhPJzQBGOxP7HxQiYtA22N8A2wVhB0/rJfJelSqQYPWiPTnApNBFY8dEfADZeB5jLKdoKtdVUbnA==
X-Received: by 2002:a05:600c:1549:: with SMTP id f9mr8178497wmg.61.1610706572118;
        Fri, 15 Jan 2021 02:29:32 -0800 (PST)
Received: from [192.168.1.240] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.gmail.com with ESMTPSA id h13sm14252305wrm.28.2021.01.15.02.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 02:29:31 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: How to implement the "amend!" commit ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
 <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
 <xmqq7dofxnru.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <81d3784c-fa64-a18d-9cc8-6ff50bbdd6ac@gmail.com>
Date:   Fri, 15 Jan 2021 10:29:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dofxnru.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 14/01/2021 20:32, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> This is the only option that is backwards
>> compatible. `--fixup=:/<text> ` still works and can be used with the
>> new syntax as `--fixup=amend::/<text>`.
> Do you mean both "--fixup=:/<text>" and "--fixup=amend::/<text>"
> work and do the same thing?  If so, that is good.

"--fixup=:/<text>" will work as it does now and "--fixup=amend::/<text>" 
will create an amend! commit.

>> Note that we intend to allow
>> accept any prefix of "amend" and "reword" so --fixup=a:<commit> would
>> work.
> 
> "a" and "r" may happen to be unique but we would not want to be
> limited to these two forever---future developers are allowed to
> invent other clever variants.  So let's say "accept unique prefix as
> abbreviation for these operating mode words like 'amend' and 'reword'"

Sure - that's actually what I meant but I wasn't very clear

Do you think we want to support "--fixup=squash:<commit>" so there is a 
uniform way for creating all flavors or is that just going to be 
confusing when we have "--squash=<commit>" already?

Best Wishes

Phillip
