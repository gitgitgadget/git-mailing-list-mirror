Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3061F453
	for <e@80x24.org>; Mon, 22 Oct 2018 05:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeJVOQe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 10:16:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54406 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeJVOQe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 10:16:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so8891844wma.4
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 22:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8gG1Laqe+MDYt7m7xeA5UoThNGvyHBcD6SZYFG8gieA=;
        b=dav6wsrOEskfgUzYkRjbRHwwBkkzd0afOXXjR6nmdr8Sm2OGd+57qmlvg10tGUro/8
         j01m40y3BqzdThVRGrt/ITMAl3sSTplsBqovd/Lbajk9HBQMrk6vPrFO3MZaIRtmPF1z
         p9QIHUCH48cnW+hm/3Yfp0Q/pTLeFe3vi7DSKroltR64OJMHJINEJvuzO7ngudJcDGus
         sQSR3twqOLbOu9vSdfms5qxEVD21n5SkI92rmSf88dM/1gWzqbc3d6pKvcBgYJcqWQ1a
         EH+q4vCareChBPOp3rJkiQXNPSCmi7Gnuh+TEiYf1PUxbXSJgcahvSVlnpXG/XyBI1i4
         8U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8gG1Laqe+MDYt7m7xeA5UoThNGvyHBcD6SZYFG8gieA=;
        b=XSIYJzcVpjw5mBzCLCNlPulvAYnG5YEhQaZGOj53YocYkn84wYVlaEEM3yRhXg0SVl
         rjyX2/6Ju0m1T6yT0CbmiqrpKw7bMGm9O3O0Ao42hO18X4un79Tx1alQGxAXZICGbQq3
         t4RlGxTekDz3YLg23JrL0+R1bIbYNTSGe38ja8RFBoPpKJZXQ8ZS9/axR9iaMW2atUuU
         gQMKqhQtY+UqEycoerysK9SbhgJkMs/1AncrWfWkDIYMLc53KeYwoxwg9R5VXoKxHTj6
         a3/EdG/5k6IhT60F2OWVUTLkTT2m4JUteNwGbxoksA4LkvAycqDNCOUJZZsknWopcqJp
         GUyw==
X-Gm-Message-State: ABuFfohJ5H5+LoeKogTUIb5M5T7gUnWuVid6tAjGxI3TxCi0LdOJu3T0
        iHhQyG4lv74QOc6EHwWc5rNzt1plzto=
X-Google-Smtp-Source: ACcGV60XLwEBVBW/I5rfiZeHcN+jDTre2B93qEsp5G0oX3jZH+V205jx29OeBglgMOwMlmvJfwP3+Q==
X-Received: by 2002:a1c:1804:: with SMTP id 4-v6mr13895039wmy.29.1540187969641;
        Sun, 21 Oct 2018 22:59:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a18sm21177834wrx.55.2018.10.21.22.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 22:59:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH 3/3] xdiff: use compat's MIN instead
References: <20181022053605.81048-1-carenas@gmail.com>
        <20181022053605.81048-4-carenas@gmail.com>
Date:   Mon, 22 Oct 2018 14:59:27 +0900
In-Reply-To: <20181022053605.81048-4-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 21 Oct 2018 22:36:05 -0700")
Message-ID: <xmqqsh0yv7wg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  xdiff/xdiffi.c     | 2 +-
>  xdiff/xemit.c      | 6 +++---
>  xdiff/xhistogram.c | 6 +++---
>  xdiff/xmacros.h    | 4 +---
>  xdiff/xprepare.c   | 2 +-
>  5 files changed, 9 insertions(+), 11 deletions(-)

As this is a borrowed code, I'd rather not do this, especially do so
only for MIN so that people who update this need to be aware that
they can say MIN() but still have to say XDL_MAX().

> -
> -#define XDL_MIN(a, b) ((a) < (b) ? (a): (b))
>  #define XDL_MAX(a, b) ((a) > (b) ? (a): (b))

