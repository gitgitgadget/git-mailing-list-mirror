Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F5AC77B72
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 10:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDKKGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjDKKG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 06:06:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292D3C28
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 03:06:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id he13so9179319wmb.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681207566;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qCEFQ9le05Ub0CCu+FQn7nnGx1+Nq97SEtlzs6XMQqA=;
        b=YpHMtwCEacMLxEdgWgHffSiP/BGq2eURax0pSOpgK8jeAAaVfJbZVPCWUTD4iah9ss
         pYqrRMh5Dpq+VC8ERj/K1d2I+MBxF+LO9s0cX9TI0qO6XaJaOGHc67CGZkTSPWc+O+tE
         4s2+Jq9agihV1/s5VBQ3Us9G1SwFgzV3aS6UmLz7t6Hx1i5EENBkPh04RsJml0yweglC
         1Eo/IgagVG5Ge35pupb8W/1vB1vFrLHwdOvG9Bbj4/HZ5KBaXtQOl9OoHxWBlZfKXV9l
         wIlZLiXdTNnujM3YXYUzPkQqiPvaveBzedyzmEici8nQ/khjqWJBrsmu5/W9+MOMzea+
         DxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681207566;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCEFQ9le05Ub0CCu+FQn7nnGx1+Nq97SEtlzs6XMQqA=;
        b=ZoG+DJSWRdq794jVQ+8y8LpoeFTF/mhI0vkZTWlV+Sqq6CW6BOn1YRn9fAX6LJPOLl
         lRDZu5KbbRHRCeFJfSc3Ow7CToM4jUNKo3HzyxqWOJRZhbGgvR64k7CiFoU+r6P2r4MI
         DSdEyQsmWChxbO8Oei6LiYXGmMeWF9LQZ1wudQaj9EmX0g9GGnV54gMuC2BXrDPxd1Gw
         lHdv2VS+h26wtKxLje9jmoaX2FAcvSvHXwE9A8DZpwJJMQSIB4JoaohYeWErsHEE1Xi7
         0K5JAL7ucswW5U2O7wtGRQ3CJvJ4C8KUBPHL0+G2luyYBDDj+aSOq6c1lLJCqxkZow4c
         cqLA==
X-Gm-Message-State: AAQBX9ciUEGl471rPt4I0ATzZHWUDE+FMlJi9ODuf0YeBctnlibM0jSS
        m6QBnUs+bCklxMDid2D1q9psSKZAN7c=
X-Google-Smtp-Source: AKy350Yxux+9NKdW5nb37SLHcrJ0h4sP/JMWmXmScM/p7kAtjtLfYXbL2GNDdabkKoS0aLLdQsh+aQ==
X-Received: by 2002:a7b:c3d6:0:b0:3eb:3104:efef with SMTP id t22-20020a7bc3d6000000b003eb3104efefmr6747168wmj.31.1681207566222;
        Tue, 11 Apr 2023 03:06:06 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id f6-20020a1cc906000000b003eeb1d6a470sm16402062wmb.13.2023.04.11.03.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 03:06:05 -0700 (PDT)
Message-ID: <390e6a25-72db-8a9e-97af-7b9d803cfb2d@gmail.com>
Date:   Tue, 11 Apr 2023 11:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] rebase: implement --rewind
Content-Language: en-US
To:     git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
 <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de> <ZCMRpnS9gzN1Rlbh@ugly>
 <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de> <ZC2Qhi73YKSOJrM2@ugly>
 <230406.86zg7ls2jx.gmgdl@evledraar.gmail.com>
 <CAMP44s13z=hZHzU+EB7qBZnqQcmRGe4aknF=wocOK9uh6NHbcA@mail.gmail.com>
 <ZC+/nYp2RRF9Gjrd@ugly>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZC+/nYp2RRF9Gjrd@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/04/2023 08:00, Oswald Buddenhagen wrote:

> at this point i'm actually thinking in the opposite direction: introduce 
> commands that let me move by a few commits without even opening the todo 
> editor (where have i seen that already? jj?).

When I'm working on a patch series I use this approach a lot with a "git 
rewrite" script I have. To amend a commit I run "git rewrite amend 
<commit>" and it will start a rebase or rewind the current one. It will 
also take a file, line number pair and use "git diff" to map that line 
onto HEAD and then "git blame" to work out which commit to amend so you 
can run it from your editor and say "amend the commit that added this 
line" which is a great time saver. I'd love to a command like that 
upstream in git but I don't think it covers all the cases that "rebase 
--rewind" does such as dscho rebasing git-for-windows.

Best Wishes

Phillip


