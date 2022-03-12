Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD52C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 10:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiCLK24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 05:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiCLK2r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 05:28:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6231ED4C1
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 02:27:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b15so9660029edn.4
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 02:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCQ+fPu61Qbe14JdT7Ez34XJPkzHWAC7ArvIKrA6kes=;
        b=hPaGK18VFk+Jjd54mImQFuuwdxB3Ktjra8MDkupOeVZ1m453xQxZuVM/kCvVhwGyNL
         BrY+316E4toWNohOTRuOiGmoju0VZE9eanzAJbgSG50PZMhWbOaUJm4OnM8wiw2fdbDq
         8DI9iaGw3mL2aNF9hqoslFXPk092XegEq3CDTx2Rtdb6R/+Kr14djM499zB08FXC1KRR
         N7eONLtdoixkhnvxTKdCOUN87KO/dRBD1Iv1e4Qq8Ov3S77JkHlTHC806hPUBLesVXaJ
         YUyGXvsyyWAoQCnq9VfPmmn4V04yWdhIMWwH3xej+gK4iSjk7XpmKC3TzPcaMe/dm9m0
         ShvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCQ+fPu61Qbe14JdT7Ez34XJPkzHWAC7ArvIKrA6kes=;
        b=T9xldNvmJOD9HPCtjxyN+81oEQEfai22P9F0jVLqNTvKiCVQs2GHy3K8OlDt2adejz
         IcwHadbsmZP8u9EDu2HndQ5ZUDRFOP3L0F0rSfumBjPdV3xRRgJiUb54wGrL+vmV5xG9
         9GhdOblZEKIotCcuBVa4j658nI1xcWDd4ED5LIQjx4h3NefXB6CuAAV9OEoyGLwY3D3C
         V0lAN2AJq39UKUgYTr0ebWdkWNgITRdoBd60v8REk805aQdyECeZrObSFWXtWBScA5zC
         ZFIiYcsDImdlskeyhFY/JTIZdQsv5NJGUv2AAsaluKHnLFbZPsvL5Cd9P9qcsAUqPvfN
         bZRQ==
X-Gm-Message-State: AOAM533SlCqu19eahQnumnyuQ70xl4MSyD02jlIDD0bUlTqH+f6EUkAA
        12oA4HOlYXrhZSdT26cd7lChpOExHj3JyMIWX8Q=
X-Google-Smtp-Source: ABdhPJwHZWkIlBmdOTCfl25hO0PeSgpM4J2HA9itc8dTMBMLxpNqg7otz9i8Ms3pB1yBUxSmTX7RN8tMvLAhySdR7L8=
X-Received: by 2002:a05:6402:3492:b0:416:cb5f:dc68 with SMTP id
 v18-20020a056402349200b00416cb5fdc68mr7808491edc.261.1647080856254; Sat, 12
 Mar 2022 02:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20220224054720.23996-1-shivam828787@gmail.com>
 <20220312062126.31988-1-shivam828787@gmail.com> <d13532cb-4f7d-d211-ff5c-26f90bd1c859@kdbg.org>
In-Reply-To: <d13532cb-4f7d-d211-ff5c-26f90bd1c859@kdbg.org>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Sat, 12 Mar 2022 15:57:22 +0530
Message-ID: <CAC316V4okGw37-mBeprtvHX_g4==DXLsTpuYY5rdFDrV0H-PEg@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v3 0/2] avoid pipes with Git on LHS
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Taylor Blau <me@ttaylorr.com>, kaartic.sivaraam@gmail.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This round addresses all my comments. Thanks!
>
Thanks, this series really helped me learn how code reviewing works here :).
looking forward to picking other tasks.

Thanks,
Shubham
