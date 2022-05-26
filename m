Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E335BC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbiEZSxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiEZSxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:53:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A071994F4
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:53:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so4595086ejd.9
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qDTXtXfgNDqOnAe+sbZqESYTU8XWpYXMkNYkuOy03HM=;
        b=fEFAip7+2LFrgteuEZV8w8tKulUdIM40xAfcIDAPI7CGH1GO0IF2betni9HOdyFNnd
         l8BYLowewsvwW5PmAqDvQ21komX7NYePvk6UaezoS+s7G8GNN562N5UPB/fDiFMiyPPa
         RFQVhEFk6OwI1sGbvw50TNz+UqMP+XgfrDuhZAJdOIaeCGCinhJWYvLxPZ2QKQsy9jTZ
         BntbUj2cvQljhZiV7wViUztasfPGm+/tQiQ6sVtb+9MdOUjswPji9tlXLKXCwTJBua6o
         Rv4WKRPgGWKyeHSB//o572/T1I0Tm0XhatXGyrHL61Gglf2WPQrHQ7uAtCFY7jjM5p7l
         QOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qDTXtXfgNDqOnAe+sbZqESYTU8XWpYXMkNYkuOy03HM=;
        b=erGGbD9XDw9iMgOuV26+AVf8QzmbJlpaLpliLu5y+deCCxshixU80akYah0eihbkBF
         tkaQtI0XSv9ENO1HSpla8XjdFvlyorhB2d+9cDs2/Pu76+iopl+8oKgjE3wX6PZndrxa
         lRLLaYMWPUVikYxbz5lRH1V/oJrDoXkzSNqhJkroyRBLQ03KTeCIdeb/fMgFYUJ+0OJ9
         hZUiNdEZq3wj+8UDWAxjuyEu+d7DHC7ZCRxhIxt7i2FSjWCCQWIJ2FyFkdBA1Bv54iM1
         mnrvd9/p044oCPOxOvAFNNy6nhgNUrIqF2Bz8eYb1CPcdoOw3S0oCQZkqLtiX2Nxe7Kt
         SYhA==
X-Gm-Message-State: AOAM53142kou+xtsKFu+Dt9UCiEz8KDFzHDRmRRmA3u2iYOpP0GR7Lrq
        GYR23HokLXx1WuMI00DiNDz25ewsgT00aQ==
X-Google-Smtp-Source: ABdhPJworNP0FN6wQNN4tlZdL9qNds/MNcVjIDsKS6bIoK/jQrBoF5p4vl+K2THJCf27nqOPKZqm7g==
X-Received: by 2002:a17:907:2d2a:b0:6ff:11ed:7140 with SMTP id gs42-20020a1709072d2a00b006ff11ed7140mr8523353ejc.85.1653591220703;
        Thu, 26 May 2022 11:53:40 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b006f3ef214e16sm742477ejb.124.2022.05.26.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:53:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuIc7-000Fmy-MB;
        Thu, 26 May 2022 20:53:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: jc/http-clear-finished-pointer (was: What's cooking in git.git (May
 2022, #07; Wed, 25))
Date:   Thu, 26 May 2022 20:51:23 +0200
References: <xmqqzgj41ya2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqzgj41ya2.fsf@gitster.g>
Message-ID: <220526.86v8ts3z2k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> * jc/http-clear-finished-pointer (2022-05-24) 1 commit
>  - http.c: clear the 'finished' member once we are done with it
>
>  Meant to go with js/ci-gcc-12-fixes
>
>  Will merge to 'next'?
>  source: <xmqqczgqjr8y.fsf_-_@gitster.g>

The end of the proposed commit message says:

    [...]Clear the finished member before the control leaves the
    function, which has a side effect of unconfusing compilers like
    recent GCC 12 that is over-eager to warn against such an assignment.

I cannot reproduce this suppressing the warning as noted in past
exchanges, it's not affected by this "clear if we set it" pattern. It
needs to be unconditionally cleared.

So I don't think this actively makes anything worse, but I don't think
it's doing what you're expecting it to do either.
