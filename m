Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC50C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 13:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBZNIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 08:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjBZNIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 08:08:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D9C174
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 05:08:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l1so3479553pjt.2
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKPB2C6nu0hVoe3E4TAQ6puKzkQKDQcb2MeJGwYdhTs=;
        b=dH3NUgVYZ5S1wtgyeA9Z59mbb1qR4DBodLwBUkU447lOgWzn9tHwvnt0o5W+mdVkX+
         GuocP8Fz3WLbYl/qggkV8mOn9BDDvIdhyQ4+u0/GetoN/vM93eyuQ43R+iT18CIgkAah
         PnHigq+JsNHrs26rI2VmZhtSK0XtPZl44eIDjDuraufer5gKiRXYMk+NTHHlz2KukrLc
         w+2eBR1C9kW7OgiMr8Tb0DJLexemnK2E2jfYHZy5xq+rtKnC1/DqW7tkMXMETgdp0qdU
         iZ1NEfWKaqbwtUDkg5uIkDuRZ0AlixGn9aXb7Tm0uLGaCHQfTSDqlMiQDyUou/Wv+zuB
         hu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKPB2C6nu0hVoe3E4TAQ6puKzkQKDQcb2MeJGwYdhTs=;
        b=C+1Xz443hBX0dRZTbXFeLCsyDM6QmTeBgzgDl2Fyu3pVaQaFhLPsWMmEQ6tCJ5dpp1
         QFQ0w402edWmYoP7QuMZtGX/vYz7Sn60uqpKi9lgDrq5lB5R5PaGB9gog/xTx6NGRafx
         Hhe4daPAYMDvwtRiPOUlSA9DuxEOZ4pfBi5KytyVcCWaG3fkU3I2nzqwZXQmme4OPACc
         hjBUyNDCcbBALosILmDMnzb0lFNZbwUxkaHYxshn469C0Bf7e8GSZL4kOAMI5HAt0gMj
         p6lvcqqhgVdAYuR8VK9hJlmuq8d4GP+XZkK3pDVTW5dxs8Qcnr6snO71fyLK7AcJU81T
         SPhw==
X-Gm-Message-State: AO0yUKXS0jxszHzi/PEdMOnDztT5Q8znw0l4FDJebcybdMXcxM1Am7mM
        YOe//svMt11P3Cg4tEHLmzU=
X-Google-Smtp-Source: AK7set/Q2MtuxI1lTw9wI8yl0YDQPXgMk07QwIrVQo8mgYITgD2mVgvQ306MpM4m5DQfaIp2Q1vYmQ==
X-Received: by 2002:a05:6a20:2446:b0:cc:9f39:8b75 with SMTP id t6-20020a056a20244600b000cc9f398b75mr7978907pzc.44.1677416882870;
        Sun, 26 Feb 2023 05:08:02 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id p21-20020aa78615000000b005abbe54afcdsm2478369pfn.37.2023.02.26.05.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 05:08:02 -0800 (PST)
Message-ID: <71eaa98e-3c24-9b4e-9526-550cd7d5a420@gmail.com>
Date:   Sun, 26 Feb 2023 20:07:58 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] MyFirstContribution: add note about SMTP server config
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, nasamuffin@google.com
References: <20230222011317.97943-1-gvivan6@gmail.com>
 <20230223082759.36021-1-gvivan6@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230223082759.36021-1-gvivan6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/23 15:27, Vivan Garg wrote:
> @@ -1001,7 +1001,9 @@ typical `git` install. You may need to install this additional package; there
>  are a number of resources online to help you do so. You will also need to
>  determine the right way to configure it to use your SMTP server; again, as this
>  configuration can change significantly based on your system and email setup, it
> -is out of scope for the context of this tutorial.
> +is out of scope for the context of this tutorial. The relevant settings can be 
> +found under the 'sendemail' section of Git's configuration file. (see 
> +linkgit:git-config[1]).
>  

Personally said, besides above, I'd like to also add "Instructions
on how to set up sending email with git send-email can be found at
https://git-send-email.io".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

