Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA4BC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKCJfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKCJfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:35:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE582AD3
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:35:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o30so704106wms.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWu+iJysiIV1W9gT29rIRX8Wfcsi8Fnc0ZCdNy+a+Z4=;
        b=iR7iqZ2iGQh6cpjQ/qWblRJMEmoCA+ybFqacHcchqfXey0eQsrNgpisftENuO5t8uY
         EjAN1wAlGxkhT7Y34jcVo5OpZeHFhL1xGJETaw3DC/sy4tjTCZsLG2w/afxjrSTWIIOW
         Xf8YltGfyCgcEbpJeSaQn5AC76Nf+fkXzTC++uemuuDcZqkbIZtjVRpDhlDqIUpp1/tP
         yB7NRadCWOAw1RQu3V3tesBTyTxM5NyfErjVMk138FCZuGLD2Xvqz4HJ6w8ER6tk05b2
         vaAx578URdb5zwunPCgGq7rO338LKWD09hGH5eWY5j18SPq2LOrYxd/WRqA5qo/FZPPk
         YtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWu+iJysiIV1W9gT29rIRX8Wfcsi8Fnc0ZCdNy+a+Z4=;
        b=Y1JSV2KQswvdeIXn3hhoLLOz538h6QIgiBD+XmS1KVRqjoU+HdWFBWfqixv/HUmJse
         qqXXDejG6IMegwtAZl3OaaTuIC9nvxES1/l/SrlvwPnGVUNHfrRlrFrknsMuKniH925x
         fwbIqDZc6gNqhDbYdy1B2OI1y2ln0+uHokvcehUH9C5Cq+cEbTxf71wFuluJBfVEqBtG
         KPzEpB8EBQvEsmGOVSKl7QpZdqHQjtq9yFqQ5mvmnoE/V6qW/t7k9ziyAWKyu1h5duBx
         7TjZk8CT22bTNUxZcu8y78hMcTFDIRrz7uJKrN4cxbpPse6urDtRNHmdK/koELX6QJqt
         uQXQ==
X-Gm-Message-State: ACrzQf1zXbPPhFY0duVQoQTnQjXg21aaG+oicl8sHTg1OHDiZrLytcyV
        4rmKVRqmMVSj1/FpLD80jO8=
X-Google-Smtp-Source: AMsMyM4U78+LrO1NtlGnmpfLw+R+aGLzC0NhRPBolp2UGYGH3HxQc6ZCjumLvpBkfIvioxfjJGX4pQ==
X-Received: by 2002:a05:600c:4383:b0:3cf:6ab5:5c38 with SMTP id e3-20020a05600c438300b003cf6ab55c38mr16177267wmn.194.1667468100033;
        Thu, 03 Nov 2022 02:35:00 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id by13-20020a056000098d00b002383edcde09sm366308wrb.59.2022.11.03.02.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 02:34:59 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <eca36d20-8469-0e37-3af6-8a7a976df1a2@dunelm.org.uk>
Date:   Thu, 3 Nov 2022 09:34:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/11] cmake: document, fix on *nix, add CI
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/2022 04:26, Ævar Arnfjörð Bjarmason wrote:
>    cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
> 
> I tried to use the suggested "write_script" function, but couldn't get
> past cmake quoting issues. So the commit message is updated, but the
> change is the same.

That's a shame - what was the issue? My suggestion was cut and pasted 
from 
https://github.com/phillipwood/git/commit/0bb195b00c3a5ff27ec66a5966d0a9d91a187738 
I don't remember having any problems when I wrote it.

Best Wishes

Phillip
