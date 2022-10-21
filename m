Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37F0C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 14:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJUOnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJUOnV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 10:43:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7299327FA82
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 07:43:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m15so6643808edb.13
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e6XAf+Irxiyfzq6wPsYWlFlBy9SW+r/OEHkcbKWzezE=;
        b=Cc/RTV1/aWTXcjyXv5dl3VW4snmyt7A+H4Wq4Zg0HWlTB6BeOT2Qf31+xcWrE4Uze7
         jyBXVRtOPJ60vSb0X3XZ4H+0YmJKc4rf6TgBzmqPtQPqlod1BWkLfEQmZDBjeIgUmGjW
         hPwfV23JcIpFUgZrxBGEySTFkYqNKvLrC+P0PvssLxMBMvJt84Kor+rjLvLksnOP49G1
         vmuOEYHvO30gu3fIGlSlPwIO8FQMovxtj1ZqfrWu+FCaPhoYquRVSHQqTISRShyl1LSk
         QCc1inUhLHlga4LF7pFb12271ay7Yxih4i9pRICAiBNztbG4QjOg+id7DRtlpC2s0Faz
         PcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6XAf+Irxiyfzq6wPsYWlFlBy9SW+r/OEHkcbKWzezE=;
        b=voKDsjH1LXY6mXuzEqB6VuS1m7MXPEdj1I5FGKU85AO4/bnHfTflypl0KArDSDvx8S
         W6SiEPT+Kqu1j5WkcSOudvExr5pHtPW99/xAkEX6QKrlwfcn7i5nyqQVjN0m/QcCPI4L
         HNbRyiPVaGakZseCKHic4a/2dkHCZJd3GquNPg0PnOWZk0b7qq24lQF+079z9k4kv235
         viPaWmNggbWVyMMxmUbSv+V4j0T43rKoNOjS9pq35GxkZnSQFz/2TL86mYHbwPNcno/+
         fxnMpP+0jCGMZIgoCa1vJ0Uwv4kjWeG4RplLDrTAsfixCEbxSnx+2y48Em4f7HSKdziT
         /XDQ==
X-Gm-Message-State: ACrzQf17unN0gthOLCEYeaAuZUMc1XQeOT10ErYKpW6AMmHL4YMGuAhS
        Kq7c9hxOPDbwu8UFuPa083E=
X-Google-Smtp-Source: AMsMyM7D5YC0I+S3U/0hNQW+YaUcT75HHblceq6iz6bFhzt6Ce4RNJsoK7D3QYUBrACe7+Fdh0yRLA==
X-Received: by 2002:a17:907:703:b0:78e:25be:5455 with SMTP id xb3-20020a170907070300b0078e25be5455mr15492311ejb.630.1666363398995;
        Fri, 21 Oct 2022 07:43:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d2-20020a056402078200b00459091c44b3sm13835356edy.3.2022.10.21.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:43:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oltEx-0072KS-0F;
        Fri, 21 Oct 2022 16:43:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 2/9] cmake: chmod +x the bin-wrappers/* &
 SCRIPT_{SH,PERL} & git-p4
Date:   Fri, 21 Oct 2022 16:43:07 +0200
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <patch-2.9-2c1d194e590-20221021T091013Z-avarab@gmail.com>
 <0fda0e54-0432-7690-74a7-3d1a59923e0c@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <0fda0e54-0432-7690-74a7-3d1a59923e0c@dunelm.org.uk>
Message-ID: <221021.86czalfda4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 21 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 21/10/2022 10:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
>> index fd0c6ef4971..464c41a1fdf 100644
>> --- a/contrib/buildsystems/CMakeLists.txt
>> +++ b/contrib/buildsystems/CMakeLists.txt
>> @@ -836,6 +836,7 @@ foreach(script ${git_shell_scripts})
>>   	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
>>   	string(REPLACE "@@PAGER_ENV@@" "LESS=3DFRX LV=3D-c" content "${conten=
t}")
>>   	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
>> +	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/${script})
>
> I think it would be nicer to add a write_script function
>
> function(write_script path content)
>        file(WRITE ${path} ${content})
>        file(CHMOD ${path} FILE_PERMISSIONS OWNER_READ OWNER_WRITE
>        OWNER_EXECUTE)
> endfunction()
>
> and then do
>
> -       file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
> +       write_script(${CMAKE_BINARY_DIR}/${script} "${content}")
>
> rather than executing chmod each time

Thanks, I'll use that. It looks much nicer.
