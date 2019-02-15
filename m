Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FCD31F453
	for <e@80x24.org>; Fri, 15 Feb 2019 22:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391924AbfBOWiT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 17:38:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43579 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390411AbfBOWiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 17:38:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so11882689wrv.10
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 14:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=F82OgR9jBtcVgpDdRCh2VH+QzQa7Y650hb51i0Kfs04=;
        b=rs9vPl2ElhXFjMvxr75sNS9SqSsZVMnvAbxWO91i9ozFPUOjdMEk9lEAGriQlwaWVd
         1CPe+/aPAeaIXXdNTS8krz12KtMt+WF13NOIjv7rAGFKjKnsmRINkJSH/tIaaWugCaBM
         yRgsHf5xppBZHEkAUFbRZSaJFQaJWCsfsDLUJDAApvzf576vBf8lVTbP4HDn111RUvFw
         pfwj8mYhzCvi3FG+NyZyIfC9Lnhw4cdnmW8hqozFIEihmTuw8E2XthHreRZt+LJHeVHk
         dHkBxffMVjeCD2IGVCbPvaVtUCoBI5UKC//91JzgIaI24TderoT4MvMmCteihETok3Im
         8cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=F82OgR9jBtcVgpDdRCh2VH+QzQa7Y650hb51i0Kfs04=;
        b=G12k26GGa51+7AxkhZkKrcq4t3/cLyurgeX2avmBCqE7ee6koef1TgYJJ3mOLXjqVU
         tF3vlw2OzzW76QWMUJK8K2cEB2HEyLjwwVY0/SV9tjMYGjKRbOW105mJdcqIfaNr2vKy
         MsOFuk0RivEW0IoExRvzVgr4CN3+G332j3+y7nfGxREO0gmMpX7M/VUSeIGUZTwvGJa4
         ATmMZ5Ie7p5xzpkAU66JsAxLYdwh/uHC50Q8xxnPyd+ul3ahNP+MsHxCin+9G9EGo6uy
         /mW7rvfpz0CzaZtHUUPl+4UEnRRAgtWvJIo9A2eFEx923SFHEIPE8dFYkgmevkBsvtI4
         dy9g==
X-Gm-Message-State: AHQUAuZkAp5uNkcdkGX93wdzIRtyxOsu+iAusBIpkknTP86fwmdhQJBK
        kZGOj0DyO3m5ZE8eAeb42MgWWYoT
X-Google-Smtp-Source: AHgI3IYUFh9iMw+XApuzTOja2ppaxCU7FpOFgj23yrfSXoHA79nWIsU44/pGBTf/C9Ni5GpC3BSJSw==
X-Received: by 2002:adf:f543:: with SMTP id j3mr8026640wrp.220.1550270296479;
        Fri, 15 Feb 2019 14:38:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w22sm6534022wmc.9.2019.02.15.14.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 14:38:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 06/19] checkout: move 'confict_style' and 'dwim_..' to checkout_opts
References: <20190130094831.10420-1-pclouds@gmail.com>
        <20190208090401.14793-1-pclouds@gmail.com>
        <20190208090401.14793-7-pclouds@gmail.com>
Date:   Fri, 15 Feb 2019 14:38:15 -0800
In-Reply-To: <20190208090401.14793-7-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 8 Feb 2019 16:03:48 +0700")
Message-ID: <xmqqva1k4qzs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> These local variables are referenced by struct option[]. This struct
> will soon be broken down, moved away and we can't rely on local
> variables anymore. Move these two to struct checkout_opts in
> preparation for that.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

Up to this point all patches made sense to me.  Thanks for working
on this.
