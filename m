Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55DBC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 09:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CDB60F6B
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 09:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhHaJpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhHaJpt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 05:45:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6457C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 02:44:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c6so1155811pjv.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 02:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wz0EhXWbd+Brqg+5P+9epurNZ8iEV4V4KmstkZpED4=;
        b=FEE/dO3dot6RfAQ8/yu/k/cqQu0UeByD5R77JX3P4hsrn1ZCXW8YVuPzDu82pOR0Sv
         3doSMvG8bTdd9QO5pgxLrkzbHR0K8qb5sCDJ79wlv2QwFkLZ6GWJyQUl5xkPf423BFvx
         XfhSlc6D3/ZXQ7kZCBczwRnFQh/N8mdFTMdQUDNNTdINSUbrLBum5pqh+l0JSBoogfSJ
         qMZeHDZO6AqpCemnmke9oo7bQTOn3QKiFt+/mBJktOYhHm1+lQ39msUAB4Zyy1k37PAB
         pgt3SmqDWAHiSswnimEaqd9T6vOAYiY8KnfaLeyIiR7LCchos/JuzntjoPNIU2h5vE4e
         eyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wz0EhXWbd+Brqg+5P+9epurNZ8iEV4V4KmstkZpED4=;
        b=NwrRR12MMxC9ECTW3dVtWVv/uiz9MvKTgYBcyfids7aNI5U7qOLGjuyD1VFL/ky2Am
         IKBCjajOBC0inGSyxxs65wE4tzkmkc2ZcKZ7hyKtGvuId57KXhx12dqzNOzDqZZiPfNd
         uoAc1g+gFZgoYPGuPjIkLX0+2UctcDc+sxN1e5hfuAsHGNqY7viv/c2J0NmOqIYxJjRY
         ZoXcqWwwSGFQT7Rgh6xAMlUSvEX5Lop2PTDBqCKnBEUtuJ677iAvcB17WFgsa9i0jmNm
         UF48rbX4+RXP87/x6Y373TYOOzWcJdWgfwlGnXnlwYM2QwzZxs/BwUARcsHbzhqRbNC6
         SO+Q==
X-Gm-Message-State: AOAM530ZPFRGSBHRJPxLRzoALzCQZSjg2OH4dZmggAWfxwlDR6i9DTAl
        +nnufUx4DG1vNue5n0rikT4o3y8X0DqX4zLRsXS52Air9A==
X-Google-Smtp-Source: ABdhPJzrYtJaCqJDSGEcWbxcmKm4ZdPGL2RHEngAYSt1vmnYB/rNxfXiM5WUGDGVI9oziWzSKJNfJXbBrYCrAi/N8DQ=
X-Received: by 2002:a17:90a:31b:: with SMTP id 27mr3647807pje.6.1630403094126;
 Tue, 31 Aug 2021 02:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
 <YS0tNoAa/0VQe1OW@coredump.intra.peff.net> <CANXojczR1hMrzz7t0P6AkqL3kjdk+NzBKyCQnm-9cWFbULifow@mail.gmail.com>
 <YS3VLh8SFvpDZy84@coredump.intra.peff.net>
In-Reply-To: <YS3VLh8SFvpDZy84@coredump.intra.peff.net>
From:   Stef Bon <stefbon@gmail.com>
Date:   Tue, 31 Aug 2021 11:44:43 +0200
Message-ID: <CANXojcxF8V2RR=xMLrwcpwa=R8fvhsn2Wj=pnthXNnvxX7YLxQ@mail.gmail.com>
Subject: Re: Exec upload-pack on remote with what parameters to get direntries.
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Op di 31 aug. 2021 om 09:07 schreef Jeff King <peff@peff.net>:
>
> On Tue, Aug 31, 2021 at 08:38:39AM +0200, Stef Bon wrote:
>

> You might also set GIT_TRACE_PACKET=1 in your environment and try
> running some Git commands. They will show you what's being said on the
> wire, up until the packfile is sent (decoding the packfile itself is a
> whole other story).
>

Yes that will give me the insight I need.
I will come back when it comes to decoding the packfile.

Thanks,
Stef
