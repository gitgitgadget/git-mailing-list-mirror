Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EA0C04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 09:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiJYJM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiJYJMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 05:12:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E6D16EA25
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:06:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l6so6580627pjj.0
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP7ArPt6hprqP+k9HVXwwtsZyRA6vHAgXbba2gMxNCo=;
        b=fpr6vmycpo8VSOeLM+i6f9JGirLXYsjQWM9XF+7AffkETbjPecaqALrHLwV5mN5j0J
         7BCEC08n5yufJi1i0GQh4xgZ2Sw3CyC7FLuEuRtNG9jy49VDh8WiEqmdW8ZlZv5MiCDf
         a+iY5BScD3KYZ5UTT4j1TejSAhi3TGwOFiZZFCN6GaSQVKU3EV01qdbtAgTf5UAMuK4T
         p4/PLO8/pf5i47L64hXCiFxU2GEqLo1raLm+SuOIvNrDx0FdG49TsUorUb+nWW40yFI+
         Rh3nHDtKufz4KB0WaeR9R5h1TAnSwoD2aFZ51G5YzkJXeAG3mUsCM4HCaTYTTHS1R9b8
         bfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KP7ArPt6hprqP+k9HVXwwtsZyRA6vHAgXbba2gMxNCo=;
        b=8CWwJFUt/SoFbXHhiPDUpXVcxrFObvwmPnk73BlLd1yizC9+Wc3TQ5wMPfdsKlzzJJ
         MxuhX2E0nj/ueEJIM0yOcIQaqC7w9ejfypyu8eFUUuN/HPysX4EzoJuN6EwjXUp1vhKF
         WIPiIySzL3QEJASlPq4sPiP0lGabWOlGBRHF7PUQnsNdshPnrR0lqoSfejQN9TSGow6d
         rpuVsxhKVNs1uk0qq7SnzafnUh0I6VKRAlTTw9GQR7aDNMaqPa0bGIG9zv8imcc2gLn+
         hYkw5yqB+FYXq3hp8IwBz4mQ/RSs4wzUvWJOEaB7cDwMwtGWAWiC5oBTbsQMCaU7JVht
         K0fg==
X-Gm-Message-State: ACrzQf3aaH8h+rLoQ2FxXD1uwdSvRg2Uj1WM+ccoVv14H4EYfl1ViKco
        bKnCergt1Y4qBiNcFhxxqXqU71x6gOA=
X-Google-Smtp-Source: AMsMyM7Jej9Nodd62uMhd58z1Uu9COK+ijvCNahg/Lb1V/8jqmcDNkny0gcvsSkPhYAn1qWAQdB6Aw==
X-Received: by 2002:a17:90b:3e8a:b0:20d:4632:e487 with SMTP id rj10-20020a17090b3e8a00b0020d4632e487mr44131338pjb.78.1666688762806;
        Tue, 25 Oct 2022 02:06:02 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id w184-20020a6282c1000000b0056bb21cd7basm998659pfd.51.2022.10.25.02.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:06:02 -0700 (PDT)
Message-ID: <84143b0c-139b-63c5-519f-8d4a44254976@gmail.com>
Date:   Tue, 25 Oct 2022 16:05:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Thanks
Content-Language: en-US
To:     M Hickford <mirth.hickford@gmail.com>, peff@peff.net
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
References: <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
 <20221025015116.4730-1-mirth.hickford@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221025015116.4730-1-mirth.hickford@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/22 08:51, M Hickford wrote:
> Thanks Jeff for your reply. This is helpful to understand the background.
> 
> (first message using git send-email, hopefully I followed the instructions correctly)

You messed up the thread (you broke it).

On every message showed on lore.kernel.org/git, there is reply
instructions at the bottom of the message's page. Follow it closely.

If you insisted on either using git-send-email(1) or mailto: link
to reply, you need to manually quote any portion of original message
you wish to give the context. Make sure every line of quoted text
starts with `> `.

Better yet, reply using "reply-all" button or key in your mail client.
However, make sure your email is text/plain (not HTML) and your mail
client doesn't mess up with whitespaces (convert tabs to spaces,
word wrapping).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

