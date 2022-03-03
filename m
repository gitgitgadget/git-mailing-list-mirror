Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EC4C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 17:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiCCRf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 12:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCCRfy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 12:35:54 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24708B77
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 09:35:08 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t187so852953pgb.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0/0Rj+Jyrza3OAu9Zr3KfTZPh49/eACW3nuOdEKPBs=;
        b=TVEP/iWEH9CU1Bgvyo4oRME6E2+0/nG4oaHAKDwY/Ou5ZwBFzNe4P3/t183Hrr54f+
         1YjKSXhHnUZxOj9H6PYblHQ+2k0tHcik0TJXfcrWBuR4ZGlXuVBlqOuYTLXzALYPW6ee
         61j86ViiLjTGjogw525yZqDLq4Oxf5BtOMrRTIPIUUDrheXdmUoZAiyL7M058JETplCY
         xR/+GEKAv7188q2/7bcnvKKwPF2yzDjF+574QHh4FAh6t3mIzgLiX1150ZQ2pnZvOvfa
         fejjIrlyTLbDqceylxL9D8bVCinJ804osSvMflP5A9oNmFcKTZA56IBh2ptiFUemYTG+
         l71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0/0Rj+Jyrza3OAu9Zr3KfTZPh49/eACW3nuOdEKPBs=;
        b=XCSdF+DfyhVuS6oLF5V5HAnkFGMEq4bcnSVYHdRGSkl0Zvt7QqFV5DTV2Dd7mGsRR7
         1on57jhzrr+B5CKFQC/w3bTz0oBLlzzSEaHeG4wBbDLBCkSJanJdPJs4Qt5RPNXoITZS
         CNsgfQvdS1ks7w+kOzmBhE2Xu2HhKbdx8MBLal+H4i8j4tFU03SNMSX/k1fyKSk0o57j
         KbAdLfGsg8tmbg70Q/LmwusX9S15pjxc8Hvb9cBK/V5yvkUr0jxWmyXj8ku8ckaq4a1x
         FY98Q+dKlL4q5vvq4awxKpzjUHHXHPksGR21EAeNdN2Nc38cwyEdKOVULoGGhqIoSSV3
         WJWg==
X-Gm-Message-State: AOAM531uu0ZuVYIPoqMUXETdW3kwEArHhsC2MFCiPQalhk0QXBs4bPp7
        ObIBa8K7AiRPr4f2vzzV15I=
X-Google-Smtp-Source: ABdhPJyGUwN43besny2F8sV3yMNQhsAIXbY2paitID4PVipVl5V45xFAJAoblpByqC3fBpBIxIdjKw==
X-Received: by 2002:a65:56cb:0:b0:378:82ed:d74 with SMTP id w11-20020a6556cb000000b0037882ed0d74mr20283938pgs.491.1646328907372;
        Thu, 03 Mar 2022 09:35:07 -0800 (PST)
Received: from localhost.localdomain ([2409:4061:2bc3:d84b:3104:479d:1deb:cf55])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004f38e426e3csm3153231pfw.201.2022.03.03.09.35.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 09:35:06 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Thu,  3 Mar 2022 23:04:56 +0530
Message-Id: <20220303173456.3773-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <nycvar.QRO.7.76.6.2203012024210.11118@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2203012024210.11118@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> And since Abhradeep is a new contributor, I found it important to steer
> the direction toward sound advice that they can use over and over again
> over the course of their career: whenever possible, prefer static checks
> over runtime ones.

Thanks Johannes for the advice. I will always remember it ^^

> Of course, if we can convince Coccinelle (together with Python) to give us
> the static check, we might very well be able to port more of
> `parse_options_check()` from runtime checks to static ones, which would be
> a clear win.
>
> If that is possible, we could save ourselves a lot of time by skipping (2)
> altogether.
>
> And as I said, Julia's advice looked really good. If only I wasn't
> desperately short on time, I would have given it a try because it sounds
> not only fun but also very, very useful in Git's context.

Since Junio and you both have an interest in Coccinelle, if you allow,
I want to look into it.

Thanks :)
