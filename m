Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DED11F406
	for <e@80x24.org>; Sun, 13 May 2018 23:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeEMXgu (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 19:36:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55653 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeEMXgt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 19:36:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id a8-v6so10447019wmg.5
        for <git@vger.kernel.org>; Sun, 13 May 2018 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0FboQiOl2lSfpATL3YcYS2SkTHYRfFBYlSGGYnb3RcE=;
        b=Z+iCNvJpXvDRQ1RfquSrbBmPksZwYwzfhwt/bZprJZ0H8lmbBzm3rme9HqO+8dhmyJ
         UE8sFsI6bV7OU5FUeKvkI+ZCkmFexqe67PajP4UcxjGrrLUiYKLLOys5dw4gg6+0/DJV
         x7IS683zfAQUm4frYXNpSNi8Iyq9TqX4EAZxARHpY31wKwWLOo8zV6sVdrgnqGho3O/c
         CS4z20t4nI1pTetTcSY+lN7fcbdnLTSKWb4WOgc6ZZY6u1jHGW4dol0B1yojlwzg6U+c
         ZXOXnO8vSaaOeHVDJVnrfEAVGHPECzxc3g0xnmuxxtrLm+k85uhY39tzaftauN1dIFUj
         gubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0FboQiOl2lSfpATL3YcYS2SkTHYRfFBYlSGGYnb3RcE=;
        b=oPes1ZCHb3ucF8P5cUmFGfO8IjalmCDkvg7onpgOomjNmYPobbeyJPTavHnRr3GUwi
         nfvxUD6uWrxdMuzM1W97Az2VK1pPk+q6/BD25q1MJMKZOkReDh52+G5PpwInqWbAkk+P
         RKFCwVIyEcUoy0ZhHOewybhJn/wp0kvoNoSC25Q/3Ifhn01NrnVmYBCrDNjMAxgsD2C1
         X+vBb1AYmsjLWXxxVgV0ysPIQUN8ONvTwBfziZ8CoFLgQnzeuAzPkM5skoKu2OCGnuM8
         oRyDUMmPs4PIMAVgzCA4ywb4PeQ7hVJA/ILgm7HHCVEG2GqWmB7a3sMSfplvzQ//hAM1
         VaMg==
X-Gm-Message-State: ALKqPwf8Dpheig08y9ufFvDc2feYBxeZgzxPJReZIXYqZwjXdvQCBGvR
        xakKh5BmG2RjriYSxpl9YIA=
X-Google-Smtp-Source: AB8JxZr0JY0mQ+HnMesZuVGhNp187nW0eHbNVVes1SFcTW4xTg3ugHh0RQBE2c2DuCJQOCbL2qRNQQ==
X-Received: by 2002:a1c:b4e:: with SMTP id 75-v6mr3509206wml.32.1526254608352;
        Sun, 13 May 2018 16:36:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 137-v6sm7636669wmk.38.2018.05.13.16.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 16:36:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/14] commit-slab: support shared commit-slab
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-3-pclouds@gmail.com>
Date:   Mon, 14 May 2018 08:36:47 +0900
In-Reply-To: <20180513055208.17952-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:51:56 +0200")
Message-ID: <xmqqa7t3dt68.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> define_shared_commit_slab() could be used in a header file to define a
> commit-slab. One of these C files must include commit-slab-impl.h and
> "call" implement_shared_commit_slab().
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  commit-slab-hdr.h  | 13 +++++++++++++
>  commit-slab-impl.h | 20 +++++++++++++-------
>  commit-slab.h      |  2 +-
>  3 files changed, 27 insertions(+), 8 deletions(-)

This, while it is a reasonable change, makes the big comment at the
end of commit-slab-impl.h out of sync with the reality, doesn't it?
implement_commit_slab() now takes three args, but the comment still
says the caller does not have to give the third one.

