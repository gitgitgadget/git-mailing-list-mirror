Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DD4C6FA99
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 13:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCFNXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 08:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCFNXK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 08:23:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBBC21A0A
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 05:23:08 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j11so12629971lfg.13
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 05:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678108987;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+ufuaoFnlnA4olb7nmvFBnLd9JAntQ0geCwXLozq+E=;
        b=RkHw7jNuiILeczh9mUQMM6h5pbfUMqo2bA5MYEqCYo98MJ2Q5uVLTIDY48hkH+ZjAh
         NnTYIknoDMkRp2WA+qy9cW5MKFqAC6JZ2KbUCV16Uu3PGYcP4aCxRneI1SSZOkN1ciTb
         xEKoMTbEHW/0wBrW8KJ2Jr5vj93lWWTSD8x+w4yt71ICXVE3aR/qRuczEnOQQIVXpYxr
         KNCV8ux0PAQjAWKsTWcbqHGvjuKO57Llz9jRYyzfw3vKuGQX92jj3/yb5vsZFZw0ei4Y
         Mbx/laFKkUPi618xOycpiqnpRxu58TtZjqa6UchURujdtzaR/CfsuudZED7DSg3kY6Tf
         YsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678108987;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+ufuaoFnlnA4olb7nmvFBnLd9JAntQ0geCwXLozq+E=;
        b=rn8BvMtzLceuHAZzRsmLxiDaI7X4jxUj6SVZujdXYJ4LE4JgrjmezjQIz9ZByH879I
         9rGdId+IsAUWFno3Dst6Lz8wMw9GHlD7hvtAs9BIWGB2wiEGt2UE/573d5bsYzvnWGxp
         BXiHoKhGH/zA6eeIpuUdJQC10K9ZmLSMhCvB/1WpBbHP0AAQRuDmJWAPTtDln8RqiKou
         vOXXH+TOheaAC0yvvoiV0g6sNMPQgozR5ZZY0Wq5RveQIlRaMDnTHBqHzQN5eb/tvcAM
         a4QT+6Tt8YY6I31s276LGTh/yRIIJjVs46HkcgSck7utmplI6oY8j8ijdzpJr7oYc1bg
         vvAA==
X-Gm-Message-State: AO0yUKW1r13qy/45dse/SUPAU1srTh23qHAi2eb5F7yY7uSWJ1Smm2se
        2+ESCn4slxsax8OnDgKHIZolrGkeC+Y=
X-Google-Smtp-Source: AK7set84u6FzY0vopJ+95Fo9HZEwMTa3joFEAPZ0qxAvqNliOWmd/HRs3JKiTFbyu8PttylOkXJIcw==
X-Received: by 2002:a05:6512:102b:b0:4d8:56f2:6053 with SMTP id r11-20020a056512102b00b004d856f26053mr2834452lfr.18.1678108986741;
        Mon, 06 Mar 2023 05:23:06 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w9-20020ac24429000000b004b4cbc942a3sm1645309lfl.127.2023.03.06.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 05:23:06 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com,
        calvinwan@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a
 config option for --rebase-merges
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
        <20230305050709.68736-1-alexhenrie24@gmail.com>
        <87ilff2xsl.fsf@osv.gnss.ru>
        <CAMMLpeSowxoJgPOt84Dos8BVKU=y=M+Ph0xaGe6UTxwwE5zsXQ@mail.gmail.com>
        <87ttyyn71f.fsf@osv.gnss.ru>
        <CAMMLpeTUykcgdijRPEiBJHH1xz50s=aPK_hi=FJv6C3=cj4XEg@mail.gmail.com>
Date:   Mon, 06 Mar 2023 16:23:05 +0300
In-Reply-To: <CAMMLpeTUykcgdijRPEiBJHH1xz50s=aPK_hi=FJv6C3=cj4XEg@mail.gmail.com>
        (Alex Henrie's message of "Sun, 5 Mar 2023 17:02:42 -0700")
Message-ID: <87h6uy8152.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

[...]

>> > so it seems fine to advertise them to users.
>>
>> --no-rebase-merges is fine, but then you don't advertise it anyway.
>
> I am not sure what you mean by this. The first patch of the series
> adds documentation and a test for --no-rebase-merges, so I am
> advertising it.

Ah, yes, you do it there, and that's fine with me.

I meant only the part where you suggest --rebase-merges instead of
--rebase-merges="". I have no nitpicks about any other parts of the
series.

> Or are you saying that I /should/ advertise neither --no-rebase-merges
> nor --rebase-merges without an argument, because you think
> --rebase-merges=off and --rebase-merges=on would be better?

No, --no-rebase-merges is fine as far as I'm concerned.

Thanks,
-- Sergey
