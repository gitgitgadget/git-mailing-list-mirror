Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B3AC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 14:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjAROoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 09:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjAROnl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 09:43:41 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BC459776
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 06:34:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y19so16298786edc.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 06:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xQZl6U+7Q+zqe/itPj7sr2n8Zaty896vhjTGUKnAww=;
        b=iFS4lwYu1TxNCuJO3pW58W0SeByAQHmJHsQ6r4qlCQDtroKD+NUO9BKdjZ/kzK9Eco
         m08CETYgRFfn3oBAC0zZg3OfFAFqosAmS3tVW6U2zVFs6kPbpjZwiLI2PXNJUlzsKcVq
         EZvkhq2rHDPC3f5UUMW6/oNGBPYTHO/B0TlPdXvZvHJilKLcHkhRBJ5rIm0T5xrKuT+H
         ne5UyyFPXecvSQyCGKcBleHZqzCv1MakPWdpfGx11UccuXMawawb1u+bS8j4LZWMTB4P
         DqO2PL7IMiuF38jupQhMVS2JWUA98RpLl/rg8MkSCqbngDK9d7adXVSNtC8IARpcyWf1
         d6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xQZl6U+7Q+zqe/itPj7sr2n8Zaty896vhjTGUKnAww=;
        b=mESeRZOtgYwpeYOYe0eXESL1vpOY4x6t/Tg+v/XywG9IJ7xBtaLaxMd3AlqVUZxGpE
         ENC1NVwvHAxjBd8Y1nk+DSu1kg/EWIZTohOlkZ6Lj4BW50oB8DYMW9GzPBnRfWNsC/o6
         tSEa93PijpSPAIeS6j+CCCCUQXAfAs9hhiDSQBZl5LAb9lhXxx1oM2sJ+oZKoELJnqBz
         DnkDBcWB/pHuM5hs49RQw7NUUypJ9Dft+t9OCykWsc8vBtehS6rg6pYSKXk4lTQWQA3R
         tm1aw49FD/nGqQg06+5c9dvtM6GfwSjUPMhq62g6D2Exadd6JXdBlugzoLYEd1OK40+M
         LKCg==
X-Gm-Message-State: AFqh2kpM9b/uXnKgQ3sBTW/kAga5ANkal4zf6fdp//Wkot1oXyXWvoTY
        gOKMMpKcr+wWqs91cfJhFUYSj7HzSso=
X-Google-Smtp-Source: AMrXdXszdRZYHwUuAunlqokEtUGbN5oNJOrehbJHaDdaTOvRQU0/P6TK/D8/eWvlYiyatWp4AWzlvw==
X-Received: by 2002:a05:6402:4305:b0:49b:4711:f4b4 with SMTP id m5-20020a056402430500b0049b4711f4b4mr9071113edc.0.1674052497297;
        Wed, 18 Jan 2023 06:34:57 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402150600b0049622a61f8fsm14321861edw.30.2023.01.18.06.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:34:56 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8025d5c7-ab55-c533-1997-05b4c7339d61@dunelm.org.uk>
Date:   Wed, 18 Jan 2023 14:34:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ssh signing: better error message when key not in agent
Content-Language: en-US
To:     Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Adam Szkoda <adaszko@gmail.com>
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <abec912c-065d-2098-962e-41f9646dd046@dunelm.org.uk>
In-Reply-To: <abec912c-065d-2098-962e-41f9646dd046@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/01/2023 11:10, Phillip Wood wrote:
>> the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All 
>> that
>> needs to be done is to pass an additional backward-compatible option 
>> -U to
>> 'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets 
>> the file
>> as public key and expects to find the private key in the agent.
> 
> The documentation for user.signingKey says
> 
>   If gpg.format is set to ssh this can contain the path to either your 
> private ssh key or the public key when ssh-agent is used.
> 
> If I've understood correctly passing -U will prevent users from setting 
> this to a private key.

If there is an easy way to tell if the user has given us a public key 
then we could pass "-U" in that case.

Best Wishes

Phillip
