Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D78C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E9D64E11
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhAaU1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhAaUZc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:25:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11F3C061574
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:24:51 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p20so1757552ejb.6
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=E4644rUWNsM3pbZ1TbxGMbo0fCT1Z5DYq6I8GDF3NNo=;
        b=JdcRk+alh7IBLD2OuwLgDXz39cytRfeuDU8brX6JGP9mqFQyR8tbLxMxTxdmvW5OOg
         G0XuX3hOJHW11Px3FIoQXXq2KuQyCwwU0l+lW+hgWqQdl2DNb+hMwpycO97HnCkEQU5I
         fKg0Pn0XBhnm0PLPh0tE5qkDiAorYYd6chNUrOCDaeNnm9scd52EdwwFIk08RWQ2qscq
         1tpV7BurtTW/hgX2keI3dD4ocGBiqyvp6oMzeSo/tXulFOwtVDwRhvxU+7QeNdD51OaS
         FYpH7o80b2BmKafZJat8yX6iK/tiEw2lHR94Pxxs410WL0e+TUZUuxiG9ye1GFTKr5rS
         DGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=E4644rUWNsM3pbZ1TbxGMbo0fCT1Z5DYq6I8GDF3NNo=;
        b=s65PtmxTEWg1MvyxlggWt4SOET8t8WCgbwoAA1yxdGQduKazWw4NAgnW3xqvZNcXWV
         1jtEUM9hJjb8LnAPJsjRRT50PktwMhx0wVUBPXi1tjmBkLRdDLIn0HcpCY2h+gaQ5KCl
         2+aHuIUL37U8vPY/4rxbAU9gkAAoTIYBVzpaa6EvMtiIqTckYE1I3GkkpV6UhWbmAmDB
         c3lFzmBqyK/Iiizx0FpIQKRAbsLkeLlDcxBoUJb2jp/Xxv3PvSpFMO6jNVibNspqilvQ
         jGOat8KiDHFS/05YHxMvWDS7yrhqtZhjE7ZbwVIi7weWUBWakx6dzHZZvKhMlBPMP+At
         Bytg==
X-Gm-Message-State: AOAM531hWIBqqpj4d18PN5wCI6Qogn1qI2IbmryxIosCZcM2wogDPYSB
        nJSM/4NJdAlGTEeQkmD3WZ0=
X-Google-Smtp-Source: ABdhPJzObQIB2odNoJ9nv/ju7lWH6tBKWDNckgYUGgy4mmx5UPtv3JwJKC9POJsb63+cq10r9Tf/pg==
X-Received: by 2002:a17:906:1d1a:: with SMTP id n26mr14847817ejh.481.1612124690707;
        Sun, 31 Jan 2021 12:24:50 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id cw8sm2331075ejc.82.2021.01.31.12.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 12:24:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH 2/6] doc hash-function-transition: use SHA-1 and SHA-256
 consistently
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
 <62ca087d4ebaa5f3a7efba6a2865e89284fcd98d.1612093734.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <62ca087d4ebaa5f3a7efba6a2865e89284fcd98d.1612093734.git.gitgitgadget@gmail.com>
Date:   Sun, 31 Jan 2021 21:24:49 +0100
Message-ID: <87wnvsonvy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 31 2021, Thomas Ackermann via GitGitGadget wrote:

> From: Thomas Ackermann <th.acker@arcor.de>
>
> use SHA-1 and SHA-256 instead of sha1 and sha256  when referring to the hash type

Aside from the comment I had on 1/6, this looks good to me.
