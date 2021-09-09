Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BAFC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77616611C2
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhIIKLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhIIKLl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:11:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E69C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 03:10:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i28so1734352wrb.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zQG1QqdaDkTUklOZCNEc4jdtmOqRUyuEBCcL9zocEy8=;
        b=l0JIFt2YSRzMayUf78phpeiLVLPPwqL2AVHGaTpwUO6rks+cTp3L41/PQfKXkhUzCt
         RbU3t91GVZPVYvObILKpZPgHH0NAOlZrf3BSFlpqrjMyqX/Zdu62jasnE489WCS7Skod
         siz8h/BzBg0E1+YlZ8OtIo4i80rJRYdlrm0FkkSiJ2Oqt4xynAmHBvuEPutj/NNnDMUF
         BxyyijNxwN0Jw3yiEf3OasTcSeh2Pyw1B3/eG7reK7dVPj3/dHS8dI8jW1kVZcsTRuMX
         g8NBid0YllB0z1VEryKKAWc4jhxQHWi4+ZwA+Jiko4e0/5A9fm55hhXQ4OvencZxKBwX
         SmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zQG1QqdaDkTUklOZCNEc4jdtmOqRUyuEBCcL9zocEy8=;
        b=DHNCWH6Io71eDoCUk9kQLDS6/QKUseREgYk8GgwwGaHV6BahefpPCpO7Oa4WnHrF66
         VZeVbutiAXR/Zrjh8VE1axIFJYqGYgyTJ3s9begwnKgWN3pbd1yoNmBUhLCD+xq0MrE3
         Ayc63Vx4QGMe71aHCSP9rlxoMcbisgIzC2WUbvntreWmOYUhD0TANeG2C0Sd+/vOSamS
         incf8JD5CblyM1r9vomAtd+vuygxqxynGc1NW6YNtimsU9BVVsRUSNyNbgV3n4U6a8/k
         fhBH6TxxSkARE8pSKwAiDNgMQv46o4vKmF2re4FEpr7q3JT5O/V8sxU9Q/l8FyO3ZoRY
         brfw==
X-Gm-Message-State: AOAM5304KVhPCzOFSN+T+Rqw9cWpuf+8Bb6/AZrAt+6ZcnqLTugValC+
        asDqN0d74y+VDCYCtGYk4KU=
X-Google-Smtp-Source: ABdhPJwyI2gL5rhYzmW/ISoogxx9Rx5EEHj92BL8HMRnW1UaQG8dL5CAXJdbb9s0NCA6BepCM6poIg==
X-Received: by 2002:adf:c506:: with SMTP id q6mr2607442wrf.78.1631182230977;
        Thu, 09 Sep 2021 03:10:30 -0700 (PDT)
Received: from [192.168.1.201] (187.96.189.80.dyn.plus.net. [80.189.96.187])
        by smtp.googlemail.com with ESMTPSA id d15sm618566wrz.57.2021.09.09.03.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 03:10:30 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] sequencer.c: factor out a function
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <53cde4825b408e5fb893bbd9a222e7387d69a408.1631108472.git.gitgitgadget@gmail.com>
 <CAPig+cRL-EOZJVEDefdUgP3-DjrBnXVSiMc2EzimYOoECm5bfw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e0a82c28-0fe1-b397-541e-6e394179a63e@gmail.com>
Date:   Thu, 9 Sep 2021 11:10:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRL-EOZJVEDefdUgP3-DjrBnXVSiMc2EzimYOoECm5bfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/2021 18:51, Eric Sunshine wrote:
> On Wed, Sep 8, 2021 at 9:41 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> This code is heavily indented and obscures the high level logic within
>> the loop. Lets move it to its own function before modifying it in the
>> next commit.
> 
> s/Lets/Let's/ ... or just drop "Let's" altogether and start with "Move".

Thanks, well spotted as always

Phillip
