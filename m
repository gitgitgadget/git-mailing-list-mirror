Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2557FC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 13:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbiCGNmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 08:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbiCGNmp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 08:42:45 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E8685BE3
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 05:41:51 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id o22so3565318qta.8
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 05:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mODeORzTpligVGBiM6YdSlxju+JFsaCgnBfgnt4adHY=;
        b=by1JZ4a5CxTavKDf/hCgZhQZNiPzb0hGCS6ln1Z46RepolKd/lInzkWmDYRlJPoAep
         hzjzBc5YEYCZw1sXls9dzBsyFdhn9AE4f4TSts65nfFQSpR8deAEhPzpQeN6nEcpV9ey
         IEghJE9f/GwZjiR8GVV+6LdTVsw/b0EcnbSa9GpZOmcuYuwIHzxw+TSVnCq7FtB5h/LZ
         e7sOmQFb5/+y2CHZ5MMChOHC2QL1tgyTnam6lNfZCvhUzXtHaW48btgQQs8E9Ah1/4z9
         y0Hvhydaoczm0NpGQSNCmO9rz9RVItlCHNn0eWHbGDyuTQjlVFts0Ym4mWFcFWzfHMhj
         Gg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mODeORzTpligVGBiM6YdSlxju+JFsaCgnBfgnt4adHY=;
        b=f/1dcOUdTOZY199l72Zzhh3l7Qvjfi/J0zZA/7msHrrx4xLcudet4bjqQGSiJdDB73
         ODmpncbByR6utgoAuAyNW4VjNKdZtyGoyNboATez2Lcy5haVkYSg9eLaB/uF6Q0ahEv1
         BunUXwmqHflyAGbce5CtNgAd/Y6+VgWkdqX7/M7edXDQSHMQfxH4ntBXBBOXlIX6HR72
         Gm0jXKbtucBZp0/zAi04bPOBfhNU8mpm1CFLDNnk36fPBoWfC8vgHmaCqwMOblDzhWXL
         wq0lDdEPOmzWb2S1NcnC7R+ivkjNhmOT1SZ4td3VcUu6H1BmduPT1bz6NAs+SA+84CsS
         Ab4Q==
X-Gm-Message-State: AOAM530xrlXigMjRr1PggZdaQPpXxRkFA354gzcxTdQiKKsDxVz7DvZR
        dk0Wp1+q8G3Urd/lb98yKjtYc7MjHl88
X-Google-Smtp-Source: ABdhPJwFsZnIJRTEyRuLkKKQG9BHTxh4ZMFK4pTfWHrmMyRyyXPXclYzK0l0tZ4yqItA07S6hiL9Zg==
X-Received: by 2002:ac8:594e:0:b0:2c6:c63f:8f12 with SMTP id 14-20020ac8594e000000b002c6c63f8f12mr9251512qtz.451.1646660510136;
        Mon, 07 Mar 2022 05:41:50 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d77-20020ae9ef50000000b00649555ce936sm6237275qkg.83.2022.03.07.05.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:41:49 -0800 (PST)
Message-ID: <a34c37c0-b6fd-9f4f-e990-9869f375937e@github.com>
Date:   Mon, 7 Mar 2022 08:41:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] gettext API users: correct use of casts for Q_()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
 <patch-1.2-83659fbc459-20220307T113707Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-1.2-83659fbc459-20220307T113707Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 6:38 AM, Ævar Arnfjörð Bjarmason wrote:
> Change users of the inline gettext.h Q_() function to cast its
> argument to "unsigned long" instead of "int" or "unsigned int".
> 
> The ngettext() function (which Q_() resolves to) takes an "unsigned
> long int", and so does our Q_() wrapper for it, see 0c9ea33b90f (i18n:
> add stub Q_() wrapper for ngettext, 2011-03-09).
> 
> In a subsequent commit we'll be making more use of this pattern of:
> 
>     func(Q_(..%"PRIuMAX..., (unsigned long)x), (uintmax_t)x);
> 
> By making this change we ensure that this case isn't the odd one out
> in that post-image.


>  	if (!res)
> -		printf(Q_("updated %d path\n",
> -			  "updated %d paths\n", count), (int)count);
> +		printf(Q_("updated %"PRIuMAX" path\n",
> +			  "updated %"PRIuMAX" paths\n", (unsigned long)count),
> +		       (uintmax_t)count);

Why are we adding more uses of "unsigned long" which is not consistent
in its size across 64-bit Linux and 64-bit Windows? Specifically, on
Windows "unsigned long" is _not_ uintmax_t. Shouldn't we be using
uintmax_t everywhere instead?

Thanks,
-Stolee
