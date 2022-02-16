Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB84DC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 19:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiBPTDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:03:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiBPTDy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 14:03:54 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056B13CA1E
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 11:03:41 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d3so3739350qvb.5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Co19jgr5mLd7NTnxA/w3nHWOH3NVKkH4+YxDagNzN1w=;
        b=UANf4f3bATXpTiz3M6B12EZoNOzQcOjWd7xYzgTRTL20MqVq2xAefyeAGHkfxN2MoI
         nrw0yLPxEpBWIznb76zCIgfh2sxCAaaMs7UcBSL2MMBpcEEqs3PwlQV1er+8I8vk1LAu
         BwxDTQoApYiHwrQqUhiZDGxPohX9tHVGOz3wSp204V5sUkuT3rTcYE+awTFlSoO8nPs2
         OOIFDprYVVw1IHIRqb8gbCGMDwUy8EFhFxu7WjQQRNpsJWaT5W7GZPFX9fiN+IiQ54QP
         N5d7bWZC0guJDQ+pqYlZFT0PuChtQ/h+lETqW1pcZQrpkMWyOzltxr8TzrJMELsCJpHR
         Sinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Co19jgr5mLd7NTnxA/w3nHWOH3NVKkH4+YxDagNzN1w=;
        b=BdhQPGb2jbqBInYGW3ku9HJMzO+Fcf3XImbRIhglwwkdLVAKOtwghEZn7XxTeHQZ8B
         JSOoXozuWGdiKTFG54hyTRUjLqSOziPEqE8HLF61Xz1Gn0RQsUY+agZTxqd7HCaGLQYC
         5hBXk/gHht1JAofF8sc1irpkq1wzTDMqec5APWgoT/bCF4cMga9ZbnBf0gsz8C58jdTW
         SACl4+f3iWJBZUX3amU5+M6krUPH58Hhri6qmXrqSKzhlN4p+28vzRNqjTJp2sbQpTJ6
         tAIyVtpbPKf4seHbbQ5d2Dg/efBVSSaA+BNRkkGXOWYdgM6rx91xlT5bSJLxuh1eqY03
         m8pw==
X-Gm-Message-State: AOAM530UpP2uV6ATfCN31hZQH+SbysZv86FgKGzZ/wWZs+aNHmGBeNq0
        8XKj86R7diJ4PHwQD6l6Vvg=
X-Google-Smtp-Source: ABdhPJwto0XxbBZS1iv4N1jNjhJSzt5ZyX0tnchZ6BAHw8xJ97RlAdnSOB9erf83tdzcCO20BDrBxg==
X-Received: by 2002:ad4:46f3:0:b0:42c:3b5a:cade with SMTP id h19-20020ad446f3000000b0042c3b5academr2977059qvw.60.1645038220417;
        Wed, 16 Feb 2022 11:03:40 -0800 (PST)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id u11sm19422116qkp.21.2022.02.16.11.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:03:39 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
Date:   Wed, 16 Feb 2022 14:03:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Erlend Egeberg Aasland via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Erlend Egeberg Aasland <erlend.aasland@innova.no>
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
 <xmqqbkz6vjkj.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <xmqqbkz6vjkj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/16/22 11:54 AM, Junio C Hamano wrote:
> From: "Erlend E. Aasland" <erlend.aasland@innova.no>
>> This makes it easy to get rid of short-lived branches:
>>
>> $ git switch -c experiment
>> $ git switch -
>> $ git branch -D -
> 
> Or you can use @{-1} directly.  Or short-lived experiment can
> directly be done on HEAD without any branch ;-)
> 
> Thanks for trying to make Git better.

Patches implementing this behavior for `git branch -D` have been 
submitted previously but were rejected (if I recall correctly) since 
"delete" is a destructive operation, unlike other cases in which `-` is 
accepted. A relatively recent submission and ensuing discussion is at [1].

[1]: https://lore.kernel.org/git/20200501222227.GE41612@syl.local/T/
