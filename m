Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFAC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD532076E
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaqTtTUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgKMQEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMQEc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 11:04:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF5C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 08:04:31 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so8954879wmi.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mL1Sx+uZntuYFExVpo8e5xY0y3X7GHVFvS5x3q6zfq0=;
        b=IaqTtTUmym/ymPFXtbl5gBVl9BtXi/hHt8/zGhx58KX/beNv1VSgedjVPBTzPgZigY
         o3mPV0ZJzZR2okOgT8f4Bn2zLn7DHylz2ZSllr4lhgwTBfCnmjry2F7OvzZQvMGyH2mg
         jsMbkhJ6aqBmSLVPYAlapS67gQqJYZJcSE1lo7dAwsNjWfXxjFEBT9r5k2Lbv7tq6pzg
         yYhUibDCFDoFVnLryQ4L8BxNCUZ8NNifCLwEFsySIxYTcERKVqPDufnaGUvKCSX/jzsB
         2Qou+mGyIR3eh0TL1KVXftT4hOqDcI12cSprZ0utCy7nIzg+114YkxcaqHUms7kRP6jq
         1ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mL1Sx+uZntuYFExVpo8e5xY0y3X7GHVFvS5x3q6zfq0=;
        b=NfRm3hUt5zzI5p1QQA0qw76/WVYZ/b9IR/7nyKF97paARAN+3Tga36J3gK8jc/b/C9
         U67mtfXcAB8nLVZdep+p3tWAvVpUN9Y44uUsNNpqtFbeESTcoZbYD/lOQKE9v7sijZDi
         KD0M2GM1u9Pje8xJgVfD1iybm//mBnM7zXBL58+EPKP55/pLMUznexHLv5sqy5iPUQZN
         D8VnH41uujLPUEsQnLi/1lTsGPKNtVVkHGR2uq7+8AMXvCE6YDuRFFLt1PA7cHSyPsRE
         59yor9cO3h+poB6u1EKjw2pMFvfBSxKMI3nMIJ3D7t5G1NKQv8Y4MpgB056lndoYs7j/
         iBJA==
X-Gm-Message-State: AOAM532RxQrBL1DMfI9QId1t2ARTHwx4Kv4BPi74qGAM4C80BBITKiUg
        q3mUgramz49HzekfrM+ehDQ=
X-Google-Smtp-Source: ABdhPJxl4f2/GTXrPnhUV5cZRh5Y2WU8yw2UPhHFijG2C8pRNNfTRrn6PnJnGkVzSnBOoeqxR1u2cw==
X-Received: by 2002:a05:600c:d2:: with SMTP id u18mr3297724wmm.102.1605283464914;
        Fri, 13 Nov 2020 08:04:24 -0800 (PST)
Received: from [192.168.1.240] (194.55.7.51.dyn.plus.net. [51.7.55.194])
        by smtp.gmail.com with ESMTPSA id v6sm12749666wrb.53.2020.11.13.08.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 08:04:23 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 04/11] add -i: use `reset_color` consistently
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <c857c4493213bd7cc4d057487db2d1a74fa0bbd6.1605097704.git.gitgitgadget@gmail.com>
 <6405f7c9-b084-ed48-e33e-009f388933bf@gmail.com>
 <nycvar.QRO.7.76.6.2011131452120.18437@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <820a19d2-2acb-3ee1-8927-8981de62bc7e@gmail.com>
Date:   Fri, 13 Nov 2020 16:04:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011131452120.18437@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 13/11/2020 13:53, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Fri, 13 Nov 2020, Phillip Wood wrote:
> 
>> Hi Dscho
>>
>> On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> We already maintain a list of colors in the `add_i_state`, therefore we
>>> should use them.
>>
>> Playing devil's advocate for a moment - why do we have a reset entry in that
>> list? The next patch makes sure it cannot be customized which is a good thing
>> so why not drop the `reset` member from `add_i_state` entirely? The perl
>> version needed to get the reset string from `git config` and store it
>> somewhere but in the C version we have a perfectly good constant we can use
>> instead.
> 
> Right.
> 
> On the other hand, does it hurt to keep that field for consistency with
> the rest of the coloring stuff? 

It creates the illusion that `reset` is similar to the others but it 
isn't as we don't want it to be customizable.

> It would probably cost more to make the
> change you suggested than it would benefit us.

At the moment there is one use of `s->s.color_reset` and two of 
`GIT_COLOR_RESET` in add-patch.c

Best Wishes

Phillip

> Ciao,
> Dscho
> 
