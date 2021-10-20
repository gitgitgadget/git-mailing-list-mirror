Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACA2C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 04:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A3960FE8
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 04:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhJTFBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 01:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhJTFBF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 01:01:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA315C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 21:58:51 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d5so1909568pfu.1
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ei1/yG4DaQNGNthyyDU+7A+8PzaewkobdI370VvTTUg=;
        b=TkGyROyTvSHHmXFZFyKarX3z/96IyttgpU+O3smtQ1iP7Wci9Gn4RKaRySFmUIdVMx
         CiTyfhs/tYriL+T1g6TDLHVQMnieI4U+kmnVcG+/rt/ANMTFKqiOFKjn62sFQ9vd4Huc
         okCQ6y/E1ANO/Yjr3EfF5qCwcQ9zuquBhDjfF/H197PjFY3vCCg9/zwOkx5MeR7cI2DQ
         zc3V3/HR3rSYFZhHMIWi/EoKoAV99pMbZHbvfznV18o275ww+p8ZNhGJcQ6SjuUJalHd
         VQ35aLyt6I+34FpY6UYEXq4EQja/bM+XkFDHcKNj33bmd55I3QrqW7SUPzdzq5S2xRz3
         vllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ei1/yG4DaQNGNthyyDU+7A+8PzaewkobdI370VvTTUg=;
        b=bOhzhTvkVg6N01Ng7/+H62WcGTv4EoLr6RMZGB2W+1VexFETUMg9sq9xweJUIRdR6X
         y7HnL8SbzMrbq5de1vWEfeSvjm66aDUvXFihqDqTbHBtEYySn8DZpdIQVBHtHmLC1eqh
         80oh6LR30/z5Wqz6sSH4WDFMQdTHAsWjoKZesndfJCqwVtUPNoHAevDpQ1kMYOBMLhLm
         qlEaIiA/MANTWtYZih6shkESeFEvSa6HKVuuc/BfBYrfkvUhDwh0tupJ9I5/sGI7w2rY
         j+ztgeV9zIzBKGlIrGZV6F8LI3J1lLYS8VT6mpwElxjlMyzOcZwTDVhb1O/WsZkOUf/k
         6KOw==
X-Gm-Message-State: AOAM530yVa4hNBQb0jcMwwXDjEFJwHFdZR+/fv4q1dQrNUx5s0Mnej7g
        KHzi98oks1bqu1QSe2gFf3U=
X-Google-Smtp-Source: ABdhPJxruszE8Qo5KFi8on+ldZs7AYP2+BQuY88BionbzYd0pr8ZQyBF9sMD40QKL3efcsRAwbwS9Q==
X-Received: by 2002:a62:7850:0:b0:44c:5b71:2506 with SMTP id t77-20020a627850000000b0044c5b712506mr4148688pfc.37.1634705931219;
        Tue, 19 Oct 2021 21:58:51 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id h2sm754512pjk.44.2021.10.19.21.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 21:58:51 -0700 (PDT)
Message-ID: <a2719de4-d8ec-5e78-bb73-7712c07c90c7@gmail.com>
Date:   Wed, 20 Oct 2021 11:58:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/4] doc: add a FAQ entry about syncing working trees
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-5-sandals@crustytoothpaste.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20211020010624.675562-5-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/10/21 08.06, brian m. carlson wrote:
> +Be aware that even with these recommendations, syncing in this way is
> +potentially risky since it bypasses Git's normal integrity checking for
> +repositories, so having backups is advised.
> +

This raises question: how users can backup their repos? The answer is 
same as this FAQ for syncing working trees: have your repo to be pushed 
to the spare server at disposal, or use rsync (as long as the 
preconditions are met).

-- 
An old man doll... just what I always wanted! - Clara
