Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7C1C433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2130322209
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 18:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgL2Sh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 13:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2Sh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 13:37:26 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9332DC0613D6
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 10:36:46 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id q25so12570745otn.10
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 10:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HGrqObzii33S74eCRzYU4cz25T2+kFWXGpg0HDA9Vo0=;
        b=SqWPlHtrCpX6K9uo/knRWyJ0WZ6KeQSuyzNTWR+Z9d9aFvebUR1AOsjqemr5GfSHEd
         BxZWk5Q4JZiqYFbT9hBGRkZJuJ/QroeR0Gp9tyv9gjXVgwkVWPIpKS5Af/lbdSHp7D/m
         YvKOYOgHLwcl2ffa9AM+v4Vjo8Kq2UN4DHCmX/bPwJGEi8kvNVzZ7mkBw4mZsGRM2FFa
         O8mu2/I1cxp+KetoYtvBJFkshYDb5m1Qh1HcVcebDaxingVMKkrw30YedydyB5NQnEBs
         RslcvESFJQblG9PMoY1zx+i6A0QkJdl58AzE0o2HjzYf4L/w9mSOnK25hJFV2IizhlXm
         rxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HGrqObzii33S74eCRzYU4cz25T2+kFWXGpg0HDA9Vo0=;
        b=judk4at6v23cuE4q+pRMHO5DqFW/Ql+lEj7JJdHedk9evwWgStq9wnx3esl41QfqoL
         wns/YwOhrlVopeYQLE+xl8rQUzCmh7kYGAXKoqC9qIib2+MtjpiaHV2Eu3boNiNRSI1j
         KE8OCnXSrHW5gV6tK2Vtp/0lmz/nhItwWd1DlPecNC121GKtC/yl2YGX6fJl8mTGZu2U
         eUmiqkDAVYCd9PkzIb0Tz94b4Q5gGQVVNoweO6/oEqXcAxAkdaCweGqjblnnSei1/Pam
         RnJ+cFK8hCe+pVImh4Wl0Q7meOBi4OEZJc2TNP3iOcRQZ/3m48lkNaoS/JW8j/eckWsS
         SZdg==
X-Gm-Message-State: AOAM530Oyda8qdiGCNmjRLUPToVPUEjSEETkdZMETCR/cqkpLnpoUWSg
        X4kc1Ws9JSK01UCdXFXm7oUT7il9MZF2MQ==
X-Google-Smtp-Source: ABdhPJyJvxaCf1mLdYwI71IDbNnTniOvnMHpgjpp5+cFyhzQtyDAv/RXPnIWlY1VhDWtWNj/jDaU9Q==
X-Received: by 2002:a9d:2c43:: with SMTP id f61mr36094933otb.329.1609267005718;
        Tue, 29 Dec 2020 10:36:45 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id p28sm10023057ota.14.2020.12.29.10.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 10:36:45 -0800 (PST)
Subject: Re: [PATCH v2 2/2] CoC: update to version 2.0 + local changes
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
 <20201228171734.30038-3-avarab@gmail.com>
 <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <39190d36-b1ae-37d4-2fa4-8a442fd2e6e7@gmail.com>
Date:   Tue, 29 Dec 2020 13:36:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/28/2020 5:58 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
>> This change intentionally preserves a warning emitted on "git diff
>> --check". It's better to make it easily diff-able with upstream than
>> to fix whitespace changes in our version while we're at it.
> 
> I think there are only two lines that needs to tolerate trailing
> whitespaces, and even if we strip them, it should be still easily
> diff-able with the upstream with --ignore-space-at-eol or whatever
> appropriate option, so I am not sure if it is worth try "keeping"
> these whitespace breakage.
> 
> If you still want to do so, we should tweak .gitattributes so that
> "git diff --check" would not trigger.
> 
>> 1. https://www.contributor-covenant.org/version/2/0/code_of_conduct/code_of_conduct.md
> 
> Yes, thanks for the full URL.  In 5cdf2301 (add a Code of Conduct
> document, 2019-09-24) we pointed at the HTML version, but if we ship
> MD and they have MD, using theirs as the base makes perfect sense.

The cosmetic changes since Junio's version are positive. Thanks.

> Sign-off plus acks need to be collected here.

Acked-by: Derrick Stolee <dstolee@microsoft.com>
