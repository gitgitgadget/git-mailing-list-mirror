Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE66C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A183F22482
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgLWOiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgLWOix (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:38:53 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C50C0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:38:13 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id i6so15210334otr.2
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=owgWS5gCRwQNp2AKktld2nYwY2LaUY8rS6Szkwhq0FM=;
        b=On3CIAV1KX13k0l4KHtlCJKCGkNVQGWNvkA+mes2rSMps1hJPta1bxW4j6u9I/BqRO
         dcv+8HKCYSJP6YdKzmRMq2v09YkNdtI9HXudg4omTmxVoaZNWc0rxvFGAhQA+6pqik5c
         E9he/10a6YtPAcxibd+8ZokTNvGeFw/EtnNre2anBMYjEQxnVS03G7vjIZLKsTS2PMxX
         l09O8ecqNltktsyPSVMiGEBogu39N5pcVv135xBSjkdPAxbXkQbuZ02hyLxYsr8eAYR6
         nT8k1eNLtZIfmqYaogVBMs3aq7zJBrk7LeDU4WruwtbNA9PRsavwYtm7sVWO/WPnFjLH
         dTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=owgWS5gCRwQNp2AKktld2nYwY2LaUY8rS6Szkwhq0FM=;
        b=c/OSlM03A9aTkGPRacjgQk6Lj8e3gWJkVNcqrrGwpBglvorgb115v8KRF+rR3UJNeT
         EvJrDvoQhK4q5YuwLfV6lxKtW4vi08xFmpfBlZVQrUGXhsJ1hiZbPIwvxJwajqVsTiKi
         yWrypgUHkxqJwSwGH8+5rY9/5nurJISAjF4Ilz5PyW6NmXERiTulJ8LogxGE7DO21dFv
         uEzCUskM2Ejm6ZPVP+Qt4MJqjgxsSHo+qq2ByKWQ4v5Uw328wf8MVrf8r2spcpWD7eLW
         8xxCXetFj/Lqw3xCXHUTl5dmbpuDtXpEvMgHfZQru7Z5KoMoSEH6yZJP1qw88J4LiQal
         KENA==
X-Gm-Message-State: AOAM5331rjxvTYm9rLhuq+5KxsZKbAeFLtzpMx1c94il61ibR7BE/Ugj
        iBLtv1+5jMQv70+7lVbl5VrHtVNEf3SoEg==
X-Google-Smtp-Source: ABdhPJzR2ZcqFJyCZ5l/mg3EGjM7F3QkLWUD9Ki2WPdRffd3ldl3/Xc1GpXLOvdmRix9JZ7FdsDK8w==
X-Received: by 2002:a9d:6b99:: with SMTP id b25mr20017875otq.49.1608734293074;
        Wed, 23 Dec 2020 06:38:13 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id w138sm5096404oie.44.2020.12.23.06.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 06:38:12 -0800 (PST)
Message-ID: <ab6e0536-19ed-99b3-a13d-873008b0f70e@gmail.com>
Date:   Wed, 23 Dec 2020 09:38:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20200901074355.GA4498@dcvr>
 <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
 <20200901144323.GA14554@dcvr> <xmqqbleliq58.fsf@gitster.c.googlers.com>
 <20201222231702.GA17661@dcvr> <xmqqk0t9fmq6.fsf@gitster.c.googlers.com>
 <xmqq8s9pfkls.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq8s9pfkls.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/22/2020 7:10 PM, Junio C Hamano wrote:
> From: Eric Wong <e@80x24.org>
> Date: Tue, 1 Sep 2020 07:43:55 +0000
> Subject: [PATCH] core.abbrev=no disables abbreviations
> 
> These allows users to write hash-agnostic scripts and configs to
> disable abbreviations.  Using "-c core.abbrev=40" will be
> insufficient with SHA-256, and "-c core.abbrev=64" won't work
> with SHA-1 repos today.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> [jc: tweaked implementation, added doc and a test]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks for picking this back up. Your version LGTM.

-Stolee
