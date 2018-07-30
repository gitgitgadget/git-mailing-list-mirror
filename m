Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043B31F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeG3T0i (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:26:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55589 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeG3T0i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:26:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so265032wmc.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZO6QEssL9ti4SbGfAEQrmyOwCkA9Pp0cfTxURn/d+Dk=;
        b=MOSEk2/rPV2GU6gEouQ5yRYEljfWWKp2InBjlPMNFqeqwwxbGVWEUhELvxIDKYOaGd
         yjmfKfwcWwSNuQFTeeuX3n7jbwiQfOYFtSkbqNsRugm9peZ00mVjmjQOs826VVLo8N/F
         jYkaW9lGFHWu9/A3jjEyABehBhyARK01EoFEuu98UakKz5uZ5CHXeg3R88qnPKEO1mMU
         zBx/b8BLXRYE+qrLDISvJjUNjm3w8CH1nyao62bmAqEpyGdxAsBhJQMHrxrUjOxNqFD3
         w0aIzaKUcin+4wDdrj4VEu2o8yDed3nBXoSW+joDRXlxgddPWR4ubRXmmRA+sCcuiCIq
         Cxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZO6QEssL9ti4SbGfAEQrmyOwCkA9Pp0cfTxURn/d+Dk=;
        b=Fa9Pi9+NThtyE0f24Jb4MI3j4HxYJVUDNeRSpeSWnZ7Tfd2zApVztPPoPjuSre9yiv
         BWsz0BbdtXu2HU1S7yG9qm7wvpTOLVCtFyc2wLtPUbHHgUn39a5Ym+hagGwqB5ZNxz/+
         V7Z8d120JYdIyK5+FdM9syZ4O5zl7ALWylMeWExRtZdsISSYX+BR9LtZ3oQz2f67awSt
         sVoHYyvj4bGEyeHxoYyshBuDS/24D5MrAkmQ/qEsZ4rMdQ5B/5l7BDtjqFfq4ur+eIZV
         qozcWVeKe9bWmJqfPys7Ot0eOS+g0c/rFyklpMxveHnKBnha9JSz/iXqO2+MvT7V4U4R
         b63Q==
X-Gm-Message-State: AOUpUlGaQqXYexxzqCz+ggiCDN2NDWHt5mxV4ZMv7GixrqAcis5ecMga
        1zrlZnxOR8ldk/8g5zqcv4A=
X-Google-Smtp-Source: AAOMgpdh8x00qRWTJ3Jk0Hepn0DBEtSJ6qUrUJ4UO0uC5VtTkHWhlNDV+GlJLat/m/Be+DO29PHb3w==
X-Received: by 2002:a1c:369c:: with SMTP id y28-v6mr195163wmh.34.1532973031609;
        Mon, 30 Jul 2018 10:50:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v130-v6sm204220wme.13.2018.07.30.10.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:50:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 00/11] rerere: handle nested conflicts
References: <20180605215219.28783-1-t.gummerer@gmail.com>
        <20180714214443.7184-1-t.gummerer@gmail.com>
Date:   Mon, 30 Jul 2018 10:50:30 -0700
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 14 Jul 2018 22:44:32 +0100")
Message-ID: <xmqqpnz4hau1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Thomas Gummerer (11):
>   rerere: unify error messages when read_cache fails
>   rerere: lowercase error messages
>   rerere: wrap paths in output in sq
>   rerere: mark strings for translation
>   rerere: add documentation for conflict normalization
>   rerere: fix crash when conflict goes unresolved
>   rerere: only return whether a path has conflicts or not
>   rerere: factor out handle_conflict function
>   rerere: return strbuf from handle path
>   rerere: teach rerere to handle nested conflicts
>   rerere: recalculate conflict ID when unresolved conflict is committed

Even though I am not certain about the last two steps, everything
before them looked trivially correct and good changes (well, the
"strbuf" one's goodness obviously depends on the goodness of the
last two, which are helped by it).

Sorry for taking so long before getting to the series.
