Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E120C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 00:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42DBD60EBB
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 00:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhJMAys (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbhJMAyr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 20:54:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA34C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 17:52:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so659199pgl.10
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=82RclMckC7RCJ6DeciFMNGuar616UdM/QTkvyBSmEdQ=;
        b=EWDJftOmJQAAAh/Zm9Yq1ivZG6c5SZvb4Q2x3NS/9pD7YuMYQx/O/LONQFTrrekHgZ
         zeODdwLXOD3MJ0AQJ+T0nuO8oPdQOSAkXekwBA2DNR9VNMNivwy34yTdeXVGi6j7UEX8
         /werlg55t/OM9z3Hgy7Y+WP7RmMifzB2IDOY1iVcIPYXcXWP17cADa51q1b59SxMQAIy
         E6EAj9GoKE7QpvzBRqm2tuCngApVPwKtglKZ0Hs4dyW4T6g18Me5/heLzw7vMmmDtMZ0
         4q/P7HRgig4rh5+c2jBuR8cpwybKK9Bmmeoe4I9CvLt6zHWS0vq2R1nGefhOve10Jzo0
         0EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=82RclMckC7RCJ6DeciFMNGuar616UdM/QTkvyBSmEdQ=;
        b=S19tmNu3vguGoTq9Iugm3OJulImNKN1Zp1OWtLwlkrwuGBSHSTDcNQI8+VgOdzwnf0
         ltLM+YvRnBnOImDfQWyPYcagp2rpGMUuQl/G3+K5ofxkYnfNvXCJpzeOtCmZlV7xBDOv
         4AVL4KeQ2Kes7bgWujnTTjcrKG2Jzb1OPED7a4Wh2r/+i3wZhMwcnC9/WDeWZjNLcGoD
         /gZsM1cLo2rxvElyOTXalb5Spbv5Z/hrHwjw+ZFODrKsu3IteIa1EwdtvrVKfYvV4tAG
         BNtVjo0zaN5h41KWK6OIxmuMmm8XwWhlCsOo+lXG9B9KocfB3tyE3qmdaRkbL8PDaiM4
         ZfUg==
X-Gm-Message-State: AOAM532fJRC5PNLtgSeMxRBvXcW7D53YlGxxkne8QdzcE8KmCupYB5N6
        tz2RBORmxDJkxw1VcE0J0+Y=
X-Google-Smtp-Source: ABdhPJwRW7HEb91osKKGBCd3p1UrBQRNk8DDDAYUJmk60YZNEQ5is22Yd6zXS5oXFU3HMhnaPrsx1A==
X-Received: by 2002:a65:4209:: with SMTP id c9mr24883444pgq.399.1634086364486;
        Tue, 12 Oct 2021 17:52:44 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id w13sm3749538pjc.29.2021.10.12.17.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 17:52:44 -0700 (PDT)
Message-ID: <32bd578c-0369-8efe-8a92-d9ec248c0e34@gmail.com>
Date:   Wed, 13 Oct 2021 07:52:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 01/13] hook: add 'run' subcommand
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
 <patch-01.13-a39c0748d3f-20211012T131934Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <patch-01.13-a39c0748d3f-20211012T131934Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/21 20.30, Ævar Arnfjörð Bjarmason wrote:
> +run::
> +	Run the `<hook-name>` hook. See linkgit:githooks[5] for
> +	the hook names we support.
> ++

Drop the first person, so it become `list of supported hooks`.

> +Any positional arguments to the hook should be passed after an
> +optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
> +arguments (if any) differ by hook name, see linkgit:githooks[5] for
> +what those are.
> +

s/what those are/supported list of them/ (dunno?)

-- 
An old man doll... just what I always wanted! - Clara
