Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB95C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 00:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C0460FDA
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 00:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbhICBAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 21:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbhICBAY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 21:00:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A232C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 17:59:25 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n24so4858322ion.10
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 17:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=c+M1zogo4a76iodr2nZkEP/RCv1ECiBPNKjOTlccm7Y=;
        b=hMfxiYE8QrP9CtpAcsKM4hOmHZ0/K/6+O9flgE7SpVzjKsq9qFQwJikRx8PopDxe5A
         sV5wEzsvWwIzia4YAWbYYS1P9rvHRWsy0vlSnm26JKj+PI3mYvcVI2YrB/BvwmRRw4dH
         4SasIz6hH6nc+n1asbiny2qaefOiVNvYbXvPKGMVjrsH7YKaNprihOYxCmVThJeyG034
         n6oXcxhprUdfNYbelkcbmDPaaKYGiK+WtaGFAnpXYq37wBaqkWzVsWqoyCHus/jalCe9
         WOhyZ2rX83fAPBP/mzwcGhIy3tsjvzu1Gk4nD/uXFWcNxXuJqVuW4hH1xPoHHjA5pbpz
         e9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c+M1zogo4a76iodr2nZkEP/RCv1ECiBPNKjOTlccm7Y=;
        b=HtjFhYrsvNfiUiD2pfXZE5eOe2j0++eT+JwIG4f5vjxUK0KCnP5zA3OFIUkHVAiCFJ
         UXxmrFgTuyyXqQsagXfHsCiPGienMwkVLQNiyMv51ZF6lAd2jQtipdWHQM0BAB15O+fi
         NNgLLWSNIjpfdKShLJJNh30ogrv1bIlOh3YiWblLq0sfGyUQHjghwas3kMiQiBY5XYvQ
         a5/2HqmA8gbNN71ZrH7ObSontNQiMy2MwvaLAIb9PSQMtdVImi6KbsmEIbHRAGbI15Fz
         eyTE9GtO02AgNkzUNIePwDoL6IchG4050nF7qegBnVbDFxgACiOsgORniiNBfoMF6Xo+
         /AdA==
X-Gm-Message-State: AOAM533dvkW9qQqOy5N7UkdzvPTkcmkE1NPW0UYAceDTbercS0PaYQr0
        9DeozcG42qGElmmJGPt86zN+As/qB9o=
X-Google-Smtp-Source: ABdhPJxIS3GPKhVZfSP/n9E0GTdcTYDNQs3DdPFQvlT5RwJnZDr18JNzs/7xIL7P+rRGu3dPPTmt7g==
X-Received: by 2002:a02:9695:: with SMTP id w21mr484179jai.64.1630630764712;
        Thu, 02 Sep 2021 17:59:24 -0700 (PDT)
Received: from [192.168.66.137] ([142.46.68.231])
        by smtp.gmail.com with ESMTPSA id o2sm1809617ilg.47.2021.09.02.17.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 17:59:24 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq35qmiofp.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <4a8296e4-6650-67d9-4d42-20fd2e88b6e3@gmail.com>
Date:   Thu, 2 Sep 2021 20:59:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqq35qmiofp.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2021-09-02 à 18:48, Junio C Hamano a écrit :
> 
> * pb/test-use-user-env (2021-09-01) 3 commits
>   - test-lib-functions: optionally keep HOME and TERM in 'debug'
>   - test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_pause'
>   - test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
> 
>   Teach test_pause and test_debug to allow using the HOME and TERM
>   environment variables the user usually uses.
> 
>   Will merge to 'next'?

I'll send a v4 that clarifies/generalizes the warnings as you and Elijah
suggested. I'll also tweak the 'debug' patch a bit. So I'd prefer this
stays in seen until then.

Thanks,

Philippe.
