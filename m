Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7305AECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiIAQzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiIAQzP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:55:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8A2408C
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:55:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso6126059pjv.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=LxQUylCKQ5QHVCnXBaN1mwhZVp4P2sP9CfRRs4S9XxA=;
        b=fUIHw1pXd4Zg7i0xQMZiJF0qft9mM9HyOi3IgFg51ixZhg2dgtf8Tzs7AMQxYV+t2C
         d8ixpzMkfAWAiLuXbtzfXGjZn2M8+JDydYV9pnyI42wrQtuilRkqUSSlh+OMVUQQzkm3
         ZIWicn4oioeEIum+lZEo678lsB3UOMUklhFA+TqVPhUKhkTw2x1pG/TyX7d0EZLAv96p
         SeECOV+oy48sBjbUcpsy2UcOoyCTxAKnoiwdM1dMpwmdyaJPMkKHOdS7JClO0/DoUKim
         Qk9Hc49kheG5i7SwxHiysJooubg9H72QIGk9AA5zbjrVq8Ee7wxGCYYIyItgfGTsbUbE
         0m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=LxQUylCKQ5QHVCnXBaN1mwhZVp4P2sP9CfRRs4S9XxA=;
        b=zfxXGB/eEjyIBgI5DsJCAW5Vx1qxkrgQ9AHW30bQU9IEwgvcM8WSQfdEEKoCzCitYF
         8BDDAjoEtuIwmzKbszsHOjdrOTlu+r5wKA2lcewKLl98023XnsiCjETcuWhHaiuFAm6n
         JUuP6lD3AzZ2d8H83N9bITnT1d/LUXQ20d/zyf7VLsUklUPgdyexEXxKdzWZzGdrA1uM
         bv5cLtYIeZRPgssi69mLpeSnmW8urUJnlSwRRhmeoJ+upLrkvrkgWoxkYUkZEymKOzW1
         xZyR/m52ItiORKakq4UrccwNlZSxEszEmqCck8F95umqnXeMDwLYFJMyD65XypgYCPWk
         Zmhg==
X-Gm-Message-State: ACgBeo3MIKrT+ZUp4w3zcXrvfO4Lb8dTh4xkAndNUN/te2rXPIt3QHbM
        LIlQHe7IXm1ZiOyKUBZGRma7yky/kpE=
X-Google-Smtp-Source: AA6agR6+dVzMNfpzuH43wD0TOEZI9PF7/htJsk/5hwJIZy2QOAnaD7xj3UY84zPs5AS3EjD35BO9vw==
X-Received: by 2002:a17:902:7596:b0:170:a235:b737 with SMTP id j22-20020a170902759600b00170a235b737mr32071679pll.118.1662051313104;
        Thu, 01 Sep 2022 09:55:13 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m15-20020a170902bb8f00b00172dda377fesm13927945pls.260.2022.09.01.09.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:55:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 3/3] add -p: ignore dirty submodules
References: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
        <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
        <47943b603b1f2330b36a3050fe7463bca6eeddef.1662046939.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 09:55:12 -0700
In-Reply-To: <47943b603b1f2330b36a3050fe7463bca6eeddef.1662046939.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 01 Sep 2022
        15:42:19 +0000")
Message-ID: <xmqqv8q79gr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Thanks to alwyas running `diff-index` and `diff-files` with the

"always".  If I do not forget I'll amend before merging it to 'seen'.

Thanks.
