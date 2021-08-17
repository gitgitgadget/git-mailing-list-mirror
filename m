Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7281C4320E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38FF60F41
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbhHQKGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbhHQKFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 06:05:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8DC0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:05:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x12so27704910wrr.11
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tYFzrOO6XQrcRiu9VNUN54UEPvBROnJzros+yWSXn9I=;
        b=tW+Usa5l4/mGclcAKMeJvAbFXZk7y7/mauDErU1eXQOFeC3suAfs3IHZJu4lTdCMvJ
         Be7Vy7W0eE8gOiCuYSxxyW7QM/Yr2unQUsxjNzgy8beyofgIiBXS7AJ9lSkmInCSS0GP
         mfvdTkItabY3Z/3hzd16PeIf/NYdUigLmrb0tfdd1MA48ZIrhwArZma6UNOXQ1L2baWT
         TwSh+/AApWGNlFriv3h35kCOw73Fkjalfehdy+C6fT2PL8MPphgdbJJ6yW3e/7eYf6TQ
         lhLFcE5np8CJT22W5s0+ngI3+cwLQuiOuAZchv6arbqPXzkyBSuM6z5Qz689/REN0FPH
         egLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tYFzrOO6XQrcRiu9VNUN54UEPvBROnJzros+yWSXn9I=;
        b=LZCWjEoYqtnoJofrvT2OsNoJ0b/pUtxocQvoBAMgLU+z/y364Yf0CDsRwM3SuvxwVO
         KDyjb0SnDetCVqeQRZP8en86S2Sz55aB9bkSrqi/eRNsUYzdce3xCyFABm1fVCr3gZS/
         esDPqjvlpYxuFv2crdrua5Gc4IjDFROLetjJN6b7hlL/CqNh7cBXPS9zd7yMg+ep/B8N
         AlJ30U0CQVCdj31wKEMyfF5kApg7Low3Cnz8alwtK0c09AeZHBOQGmHU7IMOb7Ei6eQ4
         4t7xauRo80WFSVW+r6U1s59vweLjyhnLK3z0sMQPsaK1cFEaiO4msijaIbQh5ZIMc+4Y
         CCmQ==
X-Gm-Message-State: AOAM532Bx+P1RL75giCPwVKMbYvLldDU/3HrmjyCj1LQWqdWhDBx/q9u
        Gm9dV01C2T+AGesxJLZvz9BDWC36SFE=
X-Google-Smtp-Source: ABdhPJy948YG3FJNmNh6Wh6lFyKcKW6/f9SWJaCLMZq6PBatiBeI03r68MX6h6HX7qBIft0gE4G6Cw==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr3060428wrs.307.1629194703721;
        Tue, 17 Aug 2021 03:05:03 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id k17sm1935552wmj.0.2021.08.17.03.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 03:05:03 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] t3403: fix commit authorship
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
 <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com>
 <CABPp-BFFTLgtrs_m9Gp7tSRwpBnAEoArhMZhhJcuzqNS_g8sUw@mail.gmail.com>
 <xmqq5ywddtsn.fsf@gitster.g> <3b438e42-488c-e4ab-d1fe-3d0992ef0619@gmail.com>
 <nycvar.QRO.7.76.6.2108142350420.59@tvgsbejvaqbjf.bet>
 <xmqqsfzasj80.fsf@gitster.g> <043edd52-c666-0939-bf6d-51b0d225157e@gmail.com>
 <xmqq8s11s5wk.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9444dcd0-4733-aed1-0b94-6aa6337552dd@gmail.com>
Date:   Tue, 17 Aug 2021 11:05:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq8s11s5wk.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/08/2021 17:36, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I wonder if it would be better to hard code the author in this test rather
>> than rather than relying on git log like this
> 
> To be quite honest, I am pretty happy with the tests as posted, and
> the choice among various ways we are discussing depends on what the
> likely mode of breakage we expect.
> 
> The breakage we are expecting to catch in the second hunk of your
> patch is somehow "rebase -i" fails to keep the authorship of
> amended-goodbye and ends up making the commit at HEAD under
> different authorship.
> 
>   - A likely source of a different authorship information that would
>     be recorded, when such a bug gets introduced, is from the
>     environment (i.e. GIT_AUTHOR_NAME etc. that test-lib.sh sets up).
>     This can happen by a new bug in the test added before the second
>     hunk of your patch we see below, and with or without this patch,
>     such a bug in the test will not be caught.
> 
>   - Or amended-goodbye may by a test bug have been recorded under a
>     wrong authorship information to begin with, and if it were done
>     as the default author we use in our tests (i.e. the bug you fixed
>     in your patch that started this thread).  If we reintroduced such
>     a bug, the second hunk of this patch will help.
> 
>   - Or the variable $another_author gets clobbered in a future change
>     between the two hunks of this patch, and the check in the second
>     hunk would be broken.
> 
> Overall, I do not think any of the above breakage is so likely to
> happen, and that is why I am happy with the tests as posted.  The
> necessity for a plain shell variable to retain its value for such a
> long haul across tests the patch below introduces may be making the
> test more brittle than safer.
> 
> So...

Okay lets leave the test as it is then

Thanks

Phillip
