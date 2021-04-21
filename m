Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7739C43460
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975B461456
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbhDUNTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241830AbhDUNSU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 09:18:20 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EAFC061359
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:17:31 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id i9-20020a4ad0890000b02901efee2118aaso1634776oor.7
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=095+mf9uRaL8Rl0/vOjESeMEqKbResi2M+KQ4YW3Wws=;
        b=OZGnNV8W8fuw1uXTmTABKuGH5wSgQyxx8yPmVsHFTXvwPTNxJHsjBd6a+kJz0ZZKne
         wJ0MePwFrLz7oVGYZmvHKp+4OGUIFJjOZZhLxE9xhgsqp4a0OI5vHX+S16MSRHrWuWA8
         Irh2yhiW3vUmVglluF9YTQKFO/pF1UyhDP6B5a5j3bG2PwFJBThMdo3ZnPafPJ+CYxfH
         LjekbGff51XXe8zjS0glcVzG1i51hAtGKqIy3sq5mO2Bki1bUtqII4Ng+/wzt1Ab4Edr
         pYSR96hX3k0830JiDr7KGTd5oOX9dggUk8IXxlAiIc/fdPffx1lC6+IC3+vgtewEGZxX
         VtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=095+mf9uRaL8Rl0/vOjESeMEqKbResi2M+KQ4YW3Wws=;
        b=TVxaD7DQ41TJavUQYTkd6rcHp+ie0mUyV146O59Tfh5pK7KG2L1tahCIE/eoDyFKYV
         iShmelpZj9/r46JSmsYC0fh94zVUaTyQ1MBpjS3DmV+GYJfee57ykMR8YCMHLxFg1xmm
         myvResQNMOjrZWruBi6yc1wsZaGeW4DsaDx9AG2BDGLWmsPkdPMvdb1uuD+pxvbQ3HHI
         Hhkyw7e6AK5nXVBLNqjPblFBkN9pQhaYthKES9ys8p9AtXRe2mceIGjsLuSlRLDDpuXB
         Nq2RDWCQP/Zce2JPzoqXgjjcMhjfmN82jqmmOtUVKl5e3sQyLZcfPUEEK7MBDUVSG9Z7
         Pz2Q==
X-Gm-Message-State: AOAM532ac+U2hn0QYS0vIogpWoWOaPf4iNvWBFTa2WKON0swuU1UDe+W
        JoTlkhLLjKfgSM9OaFc1e2U=
X-Google-Smtp-Source: ABdhPJxy3PIHJWT+rl+wtMlWEd3FnGW9ECR5sOFrlbV/BIAP6j2IwUMs2WQ2k5f1VQN3nFybbkAehQ==
X-Received: by 2002:a4a:a44a:: with SMTP id w10mr12076878ool.26.1619011050701;
        Wed, 21 Apr 2021 06:17:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e10e:eea5:8b82:2147? ([2600:1700:e72:80a0:e10e:eea5:8b82:2147])
        by smtp.gmail.com with ESMTPSA id h59sm506324otb.29.2021.04.21.06.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 06:17:30 -0700 (PDT)
Subject: Re: [PATCH 00/23] [RFC] Builtin FSMonitor Feature
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <xmqq8s5hkfxm.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2104201646210.54@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f2f61f43-51ec-366f-9fac-f0d42d707de0@gmail.com>
Date:   Wed, 21 Apr 2021 09:17:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2104201646210.54@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2021 11:27 AM, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Fri, 16 Apr 2021, Junio C Hamano wrote:
> 
>> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> This patch series adds a builtin FSMonitor daemon to Git.
>>
>> This hasn't seen much (if any) activity for a few weeks.
...
>> What does it need to get this topic unstuck?
> 
> The same resource that you keep complaining about, and that seems to be
> drained more quickly than it can be replenished: reviewers.

I purposefully stayed away from reviewing the series since we are on
the same team, but I have _not_ been involved in the development. At
least that lets me have fresh eyes.

If no external community members are willing to review it, then I will
dedicate time for a careful review this week.

Thanks,
-Stolee
