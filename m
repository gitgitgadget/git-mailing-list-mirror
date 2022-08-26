Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C45DECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 16:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbiHZQhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiHZQhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 12:37:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE10ADF084
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:37:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r69so1853255pgr.2
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=X/dMavF5FOQ3Jt5MblcLCCersNkNgGnrUvcwP1hUoDI=;
        b=ZENbEKaaIl9eeYCYXBMq8dgzhxVptsJ4Q3hrApDK6+C5/E3yEHSmrDBxcFa64Av7TK
         nmWduV6prj9oErlhd0tuy1dG3Xr6KkY+yrz7ZOc3+u37+Bcsljxv0C9sgHd2dp4nmYrB
         HZbyvRZ1FgmP6+za8i81fkKSvmS6qnW49aVmYZ/yzxs511Da27OBCgxezwZJsxrHTzKC
         jjcg/Ug//6o95Izj6FJO3Ai0sCMh7igDZelmAQWuAvYMCJ+Kotonp6mGUEuteGgVb0Ph
         S9r0ive2IPTr2akvmwLgJPUebIo8BqToHH6Cj6Br+9n1i5jMZ138vr1byWTR+/Dr4dzA
         NYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=X/dMavF5FOQ3Jt5MblcLCCersNkNgGnrUvcwP1hUoDI=;
        b=fWTbT/rPIRBy4IwAAijUyYr81dZylTmMvfGJ1Jy/xpfe5edxhFTAWFdtpdvrJ8lpwB
         4E0yYXGsOueSnoEoLswpuhGvWK5WalRU2Q8LOzC8eepnxefshY5ZA2GCt6Tx6s4qncBi
         sHEgi8C+IJ31eKIZBGBCdeha+nfX41GX3Fe+Tc7JxKHcPx6NNqjP+KBG2DLdVMh6RF6P
         zWxfcMqLjgimcA56MVPGdu4jkPk8gGjDAQcI4ajjvnK1xv33SNIg/JCuU4j3BbKZNuBS
         bYlVxpa1pG5cJwhKgwNDI6+s8ZRplY6ckwwugK9zg98EPNobfccZlLF0qvV3R/eMh0nf
         gbcA==
X-Gm-Message-State: ACgBeo0rKT8hdQ4Bz9hZz5x7JByqPPrlqtx5c1qa0WnsjEXpNBH/vbvY
        ARHpOg0BcpVHC9kXMyZzUmRBqk9yUVk=
X-Google-Smtp-Source: AA6agR4r7dprS75TF+m+2D0VDdg5VqcbEcOx9UZmJrMZ7dkI0MRVxJ6HBqkmtwXesW/CLbj3pBwTag==
X-Received: by 2002:a05:6a02:205:b0:41b:96dc:bb2a with SMTP id bh5-20020a056a02020500b0041b96dcbb2amr3906446pgb.116.1661531838293;
        Fri, 26 Aug 2022 09:37:18 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e10-20020a656bca000000b0042a713dd68csm1646509pgw.53.2022.08.26.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:37:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] annotating unused function parameters
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
        <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
        <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com>
        <220819.868rnk54ju.gmgdl@evledraar.gmail.com>
        <YwCtkwjWdJVHHZV0@coredump.intra.peff.net>
        <220825.86edx44lzh.gmgdl@evledraar.gmail.com>
        <Ywhx6LLe6YcS/2xf@coredump.intra.peff.net>
Date:   Fri, 26 Aug 2022 09:37:17 -0700
In-Reply-To: <Ywhx6LLe6YcS/2xf@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 26 Aug 2022 03:10:32 -0400")
Message-ID: <xmqqpmgnyn9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> No, but the farther away you go from the edit-compile-run cycle, the
> more painful warnings become. Catching them immediately and fully has
> real value, as it means the cost of correcting them is lower. So all
> things being equal, I think we should prefer universal solutions when
> they're available (and for example compiler errors over say, coccinelle
> or other analysis tools).

Thanks for saying it so succinctly.  Making compiler errors less
useful only to please Coccinelle is putting our priority wrong.

> Ugh. Yeah, that is really unfortunate. I much prefer the parenthesized
> syntax, but if we can't find a way to unconfuse third-party parsing,
> then switching is probably the least-bad solution.

Or have third-party fix the parsing ;-)  Until then, perhaps we have
to live with a suboptimal syntax.

Thanks.
