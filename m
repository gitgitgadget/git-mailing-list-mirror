Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8D01F462
	for <e@80x24.org>; Fri, 26 Jul 2019 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfGZNPP (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 09:15:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41335 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGZNPO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 09:15:14 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so100533486ioj.8
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mljrp+JEYoi5FajjVF4tyhY6gm07S/o3sUcUM7blGFA=;
        b=fVR5w9NhccEpBtUnjNd6kybli10V1C0F5wMY+YzzQbKDAMlUfB6V4qW9jRSW5eTDwB
         e/Z7QevudcxjTdySMFDGmwHofZuD7VDvbsmvjbVoTdu6Lq7YncgCo5h6b816/CFDIUgu
         DARrPAf+4rBiCA3hpwhjYUv+3sBUvtjXYIXyn7mXYw/iTVCpwo/HKcySI4LQxn8f5R6h
         lyAcMCb0W2KmyR0v9COEYOHjym83pLPc1a3h3EfI2RxFhTfOH13LQ3QHQYR7i0kZdTFP
         3VT0Hmv4NT123eQ0Uyw8J6qKkvEWkMrGGiWRgmCuiAHIdXZOj0iDRYCflHtWLdM4KZpc
         7ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mljrp+JEYoi5FajjVF4tyhY6gm07S/o3sUcUM7blGFA=;
        b=Y3s8/PA2GDAqrSH/YuewvvyC127PWuq77hL91EJr0tX7WJBVygy9ouyX5JZEHQLMEC
         wDHrbbZVx7ISRZCrghstrSZtx9fxhkNij2KHlZPKAj3iP8QNafdbn39rOm1oAUKl+Bt1
         ODl4gA9+UWSkgMAXCPh4o161oEteewTUjbJoVB/oNaCEFgQOezu4RmLpbgAVSUWTaH1f
         4emRx4Ndtr+V3NRW8XlaC5vlBIj8c/V7N5fb2PYHQ7HOomqhdJbcYLmf83poVW3fIHcK
         wWQP8BvG0qsNyc8wp0gR/ZIYH2GrCoMsAfoz0+64iFd5bRWxbyjOqiJX8pPV4+P1j8i0
         Cjzw==
X-Gm-Message-State: APjAAAVSPid6t04gDSjmtoxb18Vlj6ov2x4l4npx/K12YkrZeh9bQQeD
        3qcvuYTv5J4q0+Dc/1SnrDrJOgy8PBBCUpX0zy0=
X-Google-Smtp-Source: APXvYqz7ZE4cmlI5igyblDzRx+0UyhUfxUCOcPVW1zgiyhoOlLFieGwq9oMQGgY/1twORsu+KsJxycii98ng9wJQuYU=
X-Received: by 2002:a02:bb05:: with SMTP id y5mr93741561jan.93.1564146913513;
 Fri, 26 Jul 2019 06:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190721194052.15440-1-carenas@gmail.com> <20190724151415.3698-4-avarab@gmail.com>
In-Reply-To: <20190724151415.3698-4-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 26 Jul 2019 06:15:02 -0700
Message-ID: <CAPUEspiCFup4wvNwOA+egiAjkUEPgU+YnU8x2DfKhdbqTdOV3w@mail.gmail.com>
Subject: Re: [PATCH 3/3] grep: stop using a custom JIT stack with PCRE v1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

since this moves PCRE1 out of the JIT fast path, introduces the
regression where git grep will abort if there is binary data or non
UTF-8 text in the repository/log and should be IMHO hold out until a
fix for that can be merged.

this also needs additional changes to better support NO_LIBPCRE1_JIT,
patch to follow

Carlo
