Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F7C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 19:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjANT2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 14:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjANT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 14:28:06 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F9759DA
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 11:28:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o15so17305487wmr.4
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 11:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TRYa+hWxu803OoQMcIXooFEkKnZ9h4bA0z67V2y36w=;
        b=JTK7Omj5BfvxN05jU7fJE+zvVv1XeWLJnSmQW0w0oix1XKgCKy168MicVW9NRoXNL3
         s3hOnzLw4c1N3Afq3UQlkfqhv4+LGgiCE20DVUbZivhqYQmbotV21Rmt5NpiceVMHNII
         YwvH0Fv260rDC+BmjczvdOYQMQ/DQhbzNyg7ormxjDP7cyR7vkSKxLjd1YV/mgqq4q5N
         sckRFm/WcpRtkOVFastHTQK8rgupRubaX3FSc+7joqI7Wk9f9kSJLvR0rQHQdfHmVRG3
         bOPy+vqIq2IMG+4CYY+ZN7PqeTxikPBsMd+Vyn9Xc0CvSlh9XD4MVUgyJ9rgZppzkp4s
         A3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TRYa+hWxu803OoQMcIXooFEkKnZ9h4bA0z67V2y36w=;
        b=eVQ8WRkYtIK9YqWTDE8TR//sq8HXjbiHiXiRyiUzpJWcK9i5yc/fp5CY/MUSfE7SVP
         nSp+4fUvXNgF+H7EBvBZSdmbNulauLRDbyOqUY7CFOApyV9mo1v8UeUiBLC7lxzv+Y/r
         UeC9wGwwb/EjHA0DY7WEyWJWxlRJSS/gMBm2LqjwbuzaVM3AmHYNLm9uJkuxu4MOWgwx
         NlGM3fpBP40FZGl96ZMtVUAsfCO0R7w1i9Qy7RjLYQRfDjZI/dkmqvxeqjIaeW8IM/Lh
         nzks/ux51nLIf/dXhX1+3zCIS29NbA+WQ236IKE/lOJYAUmKilLOLIFR+d23qLvJI4Ae
         Kkmg==
X-Gm-Message-State: AFqh2kqng01xv+0m3clhQ1Wg9TpsNzbykQgi3vBpzFtrcfR9Cb98828T
        +qEIM+RPhjrFoET09b+Myizff7TXNe4=
X-Google-Smtp-Source: AMrXdXty1GlszY4B3NmOPh0k4zQCzejlehSJ8N7ZBvy//yom+zRnOTHuARUEjvgwzLpOTpR7160YBg==
X-Received: by 2002:a05:600c:91e:b0:3da:f4f5:ad0f with SMTP id m30-20020a05600c091e00b003daf4f5ad0fmr1003371wmp.10.1673724483960;
        Sat, 14 Jan 2023 11:28:03 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c020200b003d9ef8ad6b2sm20343596wmi.13.2023.01.14.11.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 11:28:03 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <11be1b0e-ee38-119f-1d80-cb818946116b@dunelm.org.uk>
Date:   Sat, 14 Jan 2023 19:28:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ja/worktree-orphan (was What's cooking in git.git (Jan 2023, #04;
 Sat, 14))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqilh9ms1p.fsf@gitster.g>
Content-Language: en-US
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
In-Reply-To: <xmqqilh9ms1p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/01/2023 08:36, Junio C Hamano wrote:
> * ja/worktree-orphan (2023-01-13) 4 commits
>   - worktree add: add hint to direct users towards --orphan
>   - worktree add: add --orphan flag
>   - worktree add: refactor opt exclusion tests
>   - worktree add: include -B in usage docs
> 
>   'git worktree add' learned how to create a worktree based on an
>   orphaned branch with `--orphan`.
> 
>   Will merge to 'next'.
>   source: <20230109173227.29264-1-jacobabel@nullpo.dev>

If possible it would be nice to clean up the ui before merging this, I 
think it would be quite a small change to the implementation. cf 
<e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>

Best Wishes

Phillip
