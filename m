Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4793FC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 14:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiJUOSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiJUOSU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 10:18:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B28B27CFDA
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 07:18:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so4999403wrp.10
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRXsts8s2jQS3H3ZeRNDo5dIeQr11PoI5Izg3LEoqp4=;
        b=HTF8THU6Cj2JI75I8N5z2lVjfuiN/B2Bv2yUSHF4z1hPOKwse1DxJI3sVJIS7ijBOW
         7HLLlcpCqSAwEA++gOFr1UirC48wQ6M+QHksMZLy4+yr58aBjdkJL04xNEMDuMDI3LB6
         ccquM0mLF4IoI1NhiNhXKoFR+PbY3MartEzTPoNl8etrE0XaNghtvf1nGvpLtm0h23xK
         jKTcaRJ+JnOEqndR7FTZJ2WTmdzXcmoYZu1LP5bfvBnIAjvpzAaheGH6Qj5Wu7l9LfHU
         ruN6TOe/INTz1tA9o0MOJsnLQrZoGo0PKL/y6MPWLBgQ1kVfBwkry6qhImDliG7/vsb2
         p8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRXsts8s2jQS3H3ZeRNDo5dIeQr11PoI5Izg3LEoqp4=;
        b=6/SxX9Td4kbbOoNwXiDPDGAjONMzWCSLMetH1ElCdS8E2hj1Pr3NSeXY8ozHCP/vjf
         fWByR36PSLhVQcNPReOS7h+I51XYq5X/YqepN/i58NDVyCSr9RSBB8Th41fmbFbSn4WR
         XsL2BRSbFZNS7oxBGj/qzKl788AGjUOVHAEn/zanjwrdeRgG0G4lpe1Y2FKd1fX7F/We
         u0MYFLk2ZS8UJ4yqN9EKjjrt+tvdTs/X5YRkjbxdrGa7NrkpQr3hx8nHln4lAl+K4jhY
         4FSy4oZvjAQ/zZfvTL6fAWlqUkWl2DNIf1MLBodUyZC1Dor9vQfDmXi9a9upNhVXLRIV
         ZScA==
X-Gm-Message-State: ACrzQf26xB/4d2JFYHTJunQibmGSwzqRZwbQsDtYWgmi50unEAEBosMT
        0GmHJWh1j92OWsSOR0c6Fig=
X-Google-Smtp-Source: AMsMyM6xVGF6Hce5qavrFd7PgHkqFo8qNHbAItWytAW7swX7S28xmhCCMy1PWKvjiMPooXhdhRE6CQ==
X-Received: by 2002:a5d:4e05:0:b0:234:bb21:e529 with SMTP id p5-20020a5d4e05000000b00234bb21e529mr7593049wrt.417.1666361897541;
        Fri, 21 Oct 2022 07:18:17 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c4ed300b003c409244bb0sm3219834wmq.6.2022.10.21.07.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 07:18:17 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0fda0e54-0432-7690-74a7-3d1a59923e0c@dunelm.org.uk>
Date:   Fri, 21 Oct 2022 15:18:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/9] cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL}
 & git-p4
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <patch-2.9-2c1d194e590-20221021T091013Z-avarab@gmail.com>
In-Reply-To: <patch-2.9-2c1d194e590-20221021T091013Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 21/10/2022 10:44, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index fd0c6ef4971..464c41a1fdf 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -836,6 +836,7 @@ foreach(script ${git_shell_scripts})
>   	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
>   	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
>   	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
> +	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/${script})

I think it would be nicer to add a write_script function

function(write_script path content)
        file(WRITE ${path} ${content})
        file(CHMOD ${path} FILE_PERMISSIONS OWNER_READ OWNER_WRITE 
OWNER_EXECUTE)
endfunction()

and then do

-       file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+       write_script(${CMAKE_BINARY_DIR}/${script} "${content}")

rather than executing chmod each time

Best Wishes

Phillip
