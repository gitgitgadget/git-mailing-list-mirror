Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE37C433F5
	for <git@archiver.kernel.org>; Sun,  2 Oct 2022 15:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJBPnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Oct 2022 11:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJBPnU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2022 11:43:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E1E3FEEC
        for <git@vger.kernel.org>; Sun,  2 Oct 2022 08:43:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gf8so5463980pjb.5
        for <git@vger.kernel.org>; Sun, 02 Oct 2022 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=y9EQ72ZOEMRBIncORdd+YZ3wV/1Ytzx8BPYWeHg+rr4=;
        b=GxH3mM72/KmOwM2ZA1gYw5Y1J6OM81JMwZSizL1RS2W7JJgAzEf4WcYaEspOYHJYX0
         gVfa0vmGFsfsMVQC8mbmPAgQDEfbKAsPKqP1csdiKHOiCtBhrzcEYGpZTTdNEd1QtH+3
         M99od0pQVjfzpnFDmTqlu140PBXRHdKfOLWeVPE979mk64OmJ/Sp9sKmWjMF0T8s9DsK
         g7++F/KPwSeHeGKgNyNdBKTfquKq+8dNROeDiLpk8eG7JVI4ChWNkTbxPV31u7krsdl5
         7vrN1FvFakqe/s5YNY1EB4iCa+61ianv4DVV618/NDwQC96FhJKb9TzXupvDNrjAntp1
         C1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=y9EQ72ZOEMRBIncORdd+YZ3wV/1Ytzx8BPYWeHg+rr4=;
        b=NfICChnFMh4qVJ0mmMgTN6NY0BgqGucD8Ubfv8qf3IR3R/mt+0hhiy9qzaarRtKD4l
         iZJok904ybMAPErgX+DdcuPHntdK1uB1YiYZ5wmCJldY8KbpYaLgL7z9ywdd/xomGkAt
         joDVT9lk0Lkl38r2LsT4JRCbYbReLB3Fuz/5tr1gmUkkiDR/W08As85XMuw0l1zeThTx
         9UnvwoZG0MZtmSaAdBmDIuiXqMN8kzrsmsfUcrcNZ7xF9rUQauLTz3o13hYeQqU+JodG
         hytpuSCpI4Pe/jirJMCxaqHTzivj/ddzBMzzG7MP0Wm8siXEDZncQ1pBZuLXXsvMPR3S
         IZ8w==
X-Gm-Message-State: ACrzQf2JFM3vN8dVjOhvC5WbnqgY67SSNdErph/V00o3duSVYChAJNrA
        +yG3vH27SixwcN8HV6VW8bw=
X-Google-Smtp-Source: AMsMyM5x61ptFw1W3pf4ac4kTyIIMLU+1N/lnLuIjZLhS8wJ6g/gi7GTVUH67B5LYwm7iBrltMUjvg==
X-Received: by 2002:a17:903:2441:b0:178:4f51:1f78 with SMTP id l1-20020a170903244100b001784f511f78mr17613337pls.82.1664725389250;
        Sun, 02 Oct 2022 08:43:09 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b14-20020aa78ece000000b00560c9048569sm1581172pfr.67.2022.10.02.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 08:43:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git l10n discussion group <git-l10n@googlegroups.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>, Emir SARI <emir_sari@icloud.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Hubert Bossot <hbossot@profideo.com>,
        =?utf-8?Q?J?= =?utf-8?Q?ean-No=C3=ABl?= Avila 
        <jn.avila@free.fr>, Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.38.0 round 3
References: <20221002095152.24431-1-worldhello.net@gmail.com>
Date:   Sun, 02 Oct 2022 08:43:08 -0700
In-Reply-To: <20221002095152.24431-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 2 Oct 2022 17:51:52 +0800")
Message-ID: <xmqqy1tyxmcz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.38.0.
>
> The following changes since commit bcd6bc478adc4951d57ec597c44b12ee74bc88fb:
>
>   Git 2.38-rc2 (2022-09-27 11:25:52 -0700)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.38.0-rnd3
>
> for you to fetch changes up to dedb2883ce5670401ccd2a18e47d6dae2bc798ab:
>
>   l10n: zh_TW.po: Git 2.38.0, round 3 (2022-10-01 19:10:41 +0800)

Thanks, will do.
