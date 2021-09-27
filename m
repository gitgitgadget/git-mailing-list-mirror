Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E140C433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 02:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1660561100
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 02:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhI0C75 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 26 Sep 2021 22:59:57 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:39515 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhI0C74 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 22:59:56 -0400
Received: by mail-ed1-f51.google.com with SMTP id x7so48374216edd.6
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 19:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8L/YWP2ZImQ03t6yWC++DXCK5111vk2BMbbEnTQ+gk=;
        b=f6ZF3qp4C1gyADE0bgAxFKBdVkpSIEEMAoRvIMOxnXL2F5QOwBNuWSM8WsYRf3vIDi
         bUtWMItobi02xovJEvAxUf/UWKeGIBpgsGiMxNwiMZbUqO/N4DQZs5F2hP1WaUhBcZ6a
         YFVJIrxeF1svngOto/ZUh5kwrOI7+mhcDud3vkQ9ARSoumRa2B3fsrvnFG5vpM2M3ME0
         apUOuq/m334Lc++oHBKfM2Ba409jJ5i6dNmla/HxzvRenF/sQGVC3VTOBAeTO5ZdHPTo
         6yWZAcg/T2EAuPVq6elUDQX/gNbSVIuqQydL2OhEzFVNeqjcJM8SQUWV52sPIhBmSir0
         i+9g==
X-Gm-Message-State: AOAM531Nm3O+kCfsQ6T5/zgiMsVt25P0OvMoRC1cMvmLavz55r19C+3p
        mPxQPc3ZIlRO7pQGagex94wCMNp6YeHA39Y/bfDuhf6j0xY=
X-Google-Smtp-Source: ABdhPJys8s5PFCv/e1snQtGC0jZZ+R6aL6wpDQKM6wccWFdLbKqtwJbTCztR7+pZcCP5E0puY2SkiEaKvFxshmS9Koc=
X-Received: by 2002:aa7:df92:: with SMTP id b18mr20120216edy.47.1632711498524;
 Sun, 26 Sep 2021 19:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210923065251.21363-1-carenas@gmail.com> <20210926100512.58924-1-carenas@gmail.com>
 <20210926100512.58924-2-carenas@gmail.com>
In-Reply-To: <20210926100512.58924-2-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Sep 2021 22:58:07 -0400
Message-ID: <CAPig+cRUUZ68B5saQbFor9f+URkHmEJJsB9mXefKWexDYOfj+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lazyload.h: fix warnings about mismatching
 function pointer types
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 26, 2021 at 6:05 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Here, GCC warns about every use of the INIT_PROC_ADDR macro, for example:
>
> In file included from compat/mingw.c:8:
> [...]
> (message wrapper for convenience). Insert a cast to keep the compiler
> happy. A cast is fine in these cases because they are generic function
> pointer values that have been looked up in a DLL.

s/wrapper/wrapped/

> Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
