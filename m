Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197E5C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 08:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbiFCIwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 04:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbiFCIwG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 04:52:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F272BFB
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 01:52:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id h23so3560055ejj.12
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1v8HX2P6vP+FbKS8a9IzshtDU1+/8jTTXTEqsx583rY=;
        b=lQFiYo0zRcrogfG2mIjARE6oLEW3HL0zUVHVX1gHTjVH19Ml44jVjHzzf+wA9wh9rM
         nBwdDcYPeKGot3JtD6GF+1RaqVBlphTeB/FMtElB8TN1eFDcBQPSA/+9O1VM8szvBFRQ
         1zlZhQEz8ZTXEd0y+BHDZ3j70eynxn8PTy7Saw0t3ubXOEs74yxmFqgeuCCM9u1GRgVp
         rTYoQjs0nsH/t0yrVapjIl+R7qoQsuDwEblUAAaJYqaz8oZS6N5qfrv9SczVVEnatZxf
         2knlPNVFTKXVkRuwtVMv3qmfAmACppZbp2eDQ7FHgmE5e6yJIfLsp2KJ1+LUcXyurYGn
         awIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1v8HX2P6vP+FbKS8a9IzshtDU1+/8jTTXTEqsx583rY=;
        b=bANO2JjzLwEVTWahq6zXTIdrRzk9gMtlQ48+D/LkR2bu7lOqDhmR8X2I17WpkDGYDg
         UxMbAEJnL+VFn1FWv5rMhr+T9iO5GLqmFHVeHK62FicyQ0+XXGRIwV6uMDBwnwDfFx8P
         YcY7srlxhfvJkfr3rofYpgg4uThIuQ+N4grdtHyzUAsn+Vq+N+XU2+XK22DWyjjuRTdJ
         JgieqZkgTZtKpjNs3fAPywzS+6lrH8E6rGIYnkfAkl/zhUQJKydNKCB0BxtWvBw3Mcaf
         b7btaFJvuJtxdKR7b8IxUni472Qh+Azoo49q97bsQKIr3LkMLFUj8kvetK31Ctn5hwFt
         kZBg==
X-Gm-Message-State: AOAM530HFvSPQajE6xMn6HVg2PFyz9VFKeFiFXaswDeeEOIMWfcYGv/c
        CwdQK3S3/6oSUaguvBtMcf0=
X-Google-Smtp-Source: ABdhPJzmoQSKSvtI7oKcEo5T8Iy1KNUaATNk9nnwtviTrJahvb74Q/S8wa3JPpLR1FW3RTQrDfk7VQ==
X-Received: by 2002:a17:907:7e83:b0:6fe:e929:ead0 with SMTP id qb3-20020a1709077e8300b006fee929ead0mr7740228ejc.286.1654246320875;
        Fri, 03 Jun 2022 01:52:00 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id dc5-20020a170906c7c500b006f3ef214db7sm2614716ejb.29.2022.06.03.01.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 01:52:00 -0700 (PDT)
Message-ID: <6e98dfe9-5df2-caab-ed3a-81f07b0bb6bc@gmail.com>
Date:   Fri, 3 Jun 2022 09:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/2] hook API: connect hooks to the TTY again, fixes a
 v2.36.0 regression
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
 <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 02/06/2022 15:07, Ævar Arnfjörð Bjarmason wrote:
> This series fixes a v2.36.0 regression[1]. See [2] for the v4. The
> reasons for why a regression needs this relatively large change to
> move forward is discussed in past rounds, e.g. around [3]. CI at
> https://github.com/avar/git/actions/runs/2428475773
> 
> Changes since v4, mainly to address comments by Johannes (thanks for
> the review!):
> 
>   * First, some things like renaming "ungroup" to something else &
>     rewriting the tests I didn't do because I thought keeping the
>     inter/range-diff down in size outweighed re-arranging or changing
>     the code at this late stage.
> 
>     In the case of the suggested shorter test in
>     https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206011827300.349@tvgsbejvaqbjf.bet/
>     the replacement wasn't testing the same thing. I.e. we don't see
>     what's connected to a TTY if we redirect one of stdout or stderr
>     anymore, which is important to get right.

I'm a bit confused by this, the proposed test uses this hook script

	write_script .git/hooks/pre-commit <<-EOF
	test -t 1 && echo "stdout is a TTY" >out
	test -t 2 && echo "stderr is a TTY" >>out
	EOF

if either of stderr or stdout is redirected then the corresponding "test 
-t" should fail and so we will detect that it is not a tty.

Best Wishes

Phillip
