Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E22CC04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 13:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiJYNWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiJYNWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 09:22:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA512344F
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 06:22:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y16so10474496wrt.12
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WD2al8aAwXWYU2MsTDrAOIkbbQJFt8lbOMBE+SHWtIk=;
        b=R7aETPOVsPqaX3rIdIZG1WSdK8pWfzQyP+6HmITUvmqrwYXoKobqvGO/NM0Hnm9/ip
         Tt+GLcQJ1Njmeg4ctTgHlkljgDMm/g1/ZHn07FsfxPKUdX/ZateKMqjwMi1ZZbGQeap8
         15xqn2EYxdMLlzRvRfjf12ESRGjBX2+gn+0Sun3yG5JDwniaOSzNZkDjsV59971acywt
         37HELKVcYi1nIL/VgF5P9j7Bv9Sb/VX4ICLaWeVDkUDZbGNuFkJjRA1SlZrh6LWjJjOP
         0qvZ/vHNdsKkgRQsaHCrk1k8cHITZfqZBjqSKbiq29rtjnuSgpm6Wo4F7xH6zLYoZD/g
         4uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD2al8aAwXWYU2MsTDrAOIkbbQJFt8lbOMBE+SHWtIk=;
        b=76o6QcZvUU4Dp13ECJ+wN/NBg9mJ4nl/LsHLUMMDzOs0vw32hG6mXTj/p0cksV9H8R
         Z1+xXmv126hp+iPLPg8kjhgRYZc9cMOlqX24zvAUuVBRdtMvOeAywuCSSOEKwwFJ5s5v
         mc73THvz5zOX0Y7ajx/KJjQAkkHVzyM6SveuogM8A6jLnB1VHEB/zN0WXuh+yrayWSr/
         OzXe+KF1jV+sdGy+46hZJWvPxuyfnEr0XT4xvlnxKOvsnEQfqcfzu/xKEzwV/f+5r8vQ
         3Wvc/84gfNZDrk8aLCnkFnvVFhp31NxFZ7NC/U9xb7FOaWzJAb/U5JRp/frAivANCHJM
         pg7g==
X-Gm-Message-State: ACrzQf0voPLE3+CUnFnIOxm+dyUwc0Hb/YCiRAAM0yJKb8/6yohAP1Im
        Pswzsi72Ev8PxOgzsds9inE=
X-Google-Smtp-Source: AMsMyM5dxLLbHRrpcsLalFRMqptrLAxvBXlpai/nm50oyml4vopR9PMSd8omHh3P8AFexqJydEZthw==
X-Received: by 2002:a05:6000:1287:b0:236:712d:2545 with SMTP id f7-20020a056000128700b00236712d2545mr7223094wrx.52.1666704139315;
        Tue, 25 Oct 2022 06:22:19 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id y5-20020adfd085000000b002364c77bcacsm2516468wrh.38.2022.10.25.06.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:22:18 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a083087d-969c-55dd-2ac7-5aaf4e7c7ff6@dunelm.org.uk>
Date:   Tue, 25 Oct 2022 14:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/9] cmake: fix *nix & general issues, no test-lib.sh
 editing, ctest in CI
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <49d65210-583b-67a2-1ad5-c7166e81396e@dunelm.org.uk>
 <221021.86zgdpdud6.gmgdl@evledraar.gmail.com>
In-Reply-To: <221021.86zgdpdud6.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/2022 16:55, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 21 2022, Phillip Wood wrote:
> 
>> On 21/10/2022 10:44, Ævar Arnfjörð Bjarmason wrote:
>>
>> I think this series contains a couple of interesting ideas[...]
> 
> c'mon :) Getting it to a 100%[1] pass rate on *nix from 76%[2] & having
> "ctest" running in CI now is a bit more than an interesting idea :)

It's certainly useful, I didn't think the fix which is "make the scripts 
executable" was particularly interesting. I'm more interested in the 
ideas around making the tests run without editing them or writing 
GIT-BUILD-DIR and being able to change the arguments passed to tests 
when running ctest.

Best Wishes

Phillip
