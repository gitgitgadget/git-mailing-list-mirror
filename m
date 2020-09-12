Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62607C433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 00:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B09221EF
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 00:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di1Xb3dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgILAlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 20:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgILAlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 20:41:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F6FC061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 17:41:19 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q5so11708812qkc.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ff5x4oDKImCnLEvqe9yzKJUwAsfBTibopEi+BZhkw0=;
        b=di1Xb3dQoBw/E0Q1zXHjr8g+TIFPkMuS83b0i9rn0mw+zd1u5kVkNY9rPtGnwMyJR+
         Rvs2V9SRWFKh3DaOhbKExgKjowhUjIY/4F1vTRJ1SRbzdV0eM6SiP/Bl0NTRECw7Rttm
         5qhuVgB2lG0KjxSURT1EVQ0v/uOD5IaLUAa3kxNs9yK5NHExmWyCE7gu2boBcxqehLO3
         p7D4ElF0ZTkoqei7JTznrWo4fk+bvpqkrzqHWUc0vwbxzg8wPPTAivvLNacHKXK46Ew4
         C7El5V8CMRLRhR5kI9TJiHGrRcxaQhmXybTG0DNjggf4EcgdLVpQVCAJgsVAZ5qkqKmG
         Wyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ff5x4oDKImCnLEvqe9yzKJUwAsfBTibopEi+BZhkw0=;
        b=J2+LNXhg9mo9aZXiaVH4a4kptJiN7AOiltk4nTooCmC5Qy9oru5fF+PKn8czmarSBI
         SEmAg4cAJCdzlgYTcCANsmWu6qTyq5KHYROjNAq2z8zhGaD4bYzc7LEcMC9W2tsbgSLC
         YYWc0iOn59cN48xlWzyVV6Ejq7DlmNl9J8zzAezkIo9d+9ZACq4bAH0RdHlF62x15/16
         DCZE8tEQOTIWRiBvSUXicwu/XHU4U2qxXfNyBbZshaV24oABT12c6krFUvSnYitTdgT2
         rCWt9IYfGr9KrAZVtKhPAkNyqQBD7XBqSlowGn9y3s434e5kycQjzyujZraYBB+NsquX
         DGbw==
X-Gm-Message-State: AOAM532BRRaXwo76zBo5vqEa6n294DuRG4O7fQwN6Bpeltdts+wlIjMO
        puMfHeBPeAfNOq9LCDEfuUk=
X-Google-Smtp-Source: ABdhPJywZr2LbvaXgvz4HxaixI856SwgeWmYjq01GMMvjw7vVgn+COc1T+W0UlO+mQYe9HE8y7j18Q==
X-Received: by 2002:a37:b482:: with SMTP id d124mr3818530qkf.98.1599871278681;
        Fri, 11 Sep 2020 17:41:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3846:6663:b768:1725? ([2600:1700:e72:80a0:3846:6663:b768:1725])
        by smtp.gmail.com with ESMTPSA id k185sm4704215qkd.94.2020.09.11.17.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 17:41:18 -0700 (PDT)
Subject: Re: [PATCH 1/4] clone: add tests for --template and some disallowed
 option pairs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>, Jeff King <peff@peff.net>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
 <4cdcedff313751da8c91d701c095f1051e759ce2.1599848727.git.gitgitgadget@gmail.com>
 <8f864b6c-4b05-a9d6-b649-5f7c50697730@gmail.com>
 <xmqqsgbom3ho.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bfb8ed4a-604c-7c70-19cf-dea4a8bfe4c4@gmail.com>
Date:   Fri, 11 Sep 2020 20:41:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgbom3ho.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2020 5:02 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> +test_expect_success 'disallows --bare with --origin' '
>>> +
>>> +	test_expect_code 128 git clone -o foo --bare parent clone-bare-o 2>err &&
>>> +	test_debug "cat err" &&
>>> +	test_i18ngrep "\-\-bare and --origin foo options are incompatible" err
>>> +
>>> +'
>>
>> It seems that all of your tests have an extraneous newline
>> at the end.
> 
> That matches the older style to make the test body stand out by
> having blank lines around it.  All existing tests from the era (not
> limited to this script) used to do so.
> 
> It is OK to update them to modern style, but let's not do so in the
> middle of the series.

Thanks for correcting me. (and Peff for doing the same).

I should have looked at the context better, because that
is frequently the reason for "inconsistent" style. My
apologies.

-Stolee


