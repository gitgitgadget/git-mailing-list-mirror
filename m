Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B0C7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 18:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBXSYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 13:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXSYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 13:24:06 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100FC12F31
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 10:24:06 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so160251otv.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 10:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M6t6ehdjK+hhSC3Zr0ONVL4pEzrESa0wxuqNCBeNpj0=;
        b=DGDUqHhlmFx0gsMKPL1lgOQotqUwRhCrjKNG3DomxL1k820f6iC6WOUiomuLujw6K8
         r4/m6hpmjdltyrTx1UIIG1VbZPl2agZ9PZFqtg9AD7ojQMjww4mJSy3Y2+D1joNn9J1w
         7nIaBoXYLqemDUJRRoqnEZ02spq2EH4VaX6zja2MjIR1JJka+Ucve5OHBUsbh+YXUGvu
         MUvN7KuOsRBcZ6ZttbVetoLnrFLeBZaA49F9mMdHz4Al2zxxEcr/yK3FLHen/J2tKLyv
         zrXDRH4dH3qYMhI9tsMCmRLLw/eLPlmTo/j1dnpkuJty0SCh7/UwWkqG2BUJL3SaO0Gv
         tW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6t6ehdjK+hhSC3Zr0ONVL4pEzrESa0wxuqNCBeNpj0=;
        b=8RUJAiBKU1qizX0TonCZqdMTXeBxDtLPAtO5ORIgQVvY/Cv+nwOeyPCIXpaa52Qs27
         Xg5k6jVhPV1jv/vV2zU1VF2WkVTmosE2WYl+WGPJuADh5KNNC7o3+SxUsvQpeiHIReel
         W9mOVPwuu1JMSWzq2UvOZVn7PJ/A7jQQUWjc3KYlWk1N4F0YoW6r2ZNazFiMsuZsEmtu
         ixxpIfPNd8qexv6iwA8Lh3iScB9YlAO+MKTine84qjfWbAdcOgfdP8nJUwRYihxGcyVZ
         tQpR7VNlC+gO9/aSpVXFQvrJP4/dajyWPhmdijUsSc6mbvYMo4ESCaSvo5HkmKolyfjs
         JPXQ==
X-Gm-Message-State: AO0yUKXWbRAcuCpGFulvEHOqd1+GKE8yY2Cj/e90Ir0ASlk0RShIwRax
        qS7OsG3gQsiRB9hRPzfoPyysIPL+2rodQXPjbPU=
X-Google-Smtp-Source: AK7set8WU0nFnxJzGGeTzIHZnYU45KxMzGT8m7R1yp1v/uMM+zUMGZLcp1u3PRg4fTcGOWhUooyfVswT6Z7jsdsjiZQ=
X-Received: by 2002:a05:6830:712:b0:690:dd03:fd8a with SMTP id
 y18-20020a056830071200b00690dd03fd8amr1890453ots.2.1677263045379; Fri, 24 Feb
 2023 10:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230223053410.644503-2-alexhenrie24@gmail.com> <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
 <xmqqy1on0yla.fsf@gitster.g> <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
 <xmqqcz5z0wdb.fsf@gitster.g>
In-Reply-To: <xmqqcz5z0wdb.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 24 Feb 2023 11:23:49 -0700
Message-ID: <CAMMLpeSH1itopDuON=7ms_7Li7Qk+9dhzKjT5f7UE11posKK=g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 11:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > As Johannes pointed out, it's going to be confusing if
> > rebase.merges="" does not mean rebase.merges=false. It's also going to
> > be confusing if rebase.merges="" does not mean --rebase-merges="". The
> > only sane option I see is to drop --rebase-merges="", or to add a
> > deprecation warning now and drop it later.
>
> If we were doing anything, then I think the only sensible way
> forward is to warn and then drop long after everybody forgets about
> it.
>
> But does it really need to be changed?  I am perfectly happy to
> declare that those who wants to set rebase.merges to say false
> should set it to false (or no or 0), not an empty string.
>
> Also, "[rebase] merges = " in the configuration files does not have
> to mean the same thing as "--rebase-merges=" from the command line.
> Can't we just reserve that strange "--rebase-merges=" given from the
> command line to those who are already using it, without even
> advertising it in the documentation, document and encourage the
> longhand "--rebase-merges=no-rebase-cousins" from the command line
> and take only the  form that corresponds to it in the configuration
> file, i.e. "[rebase] merges = no-rebase-cousins".  We could even
> error out "[rebase] merges = " in the configuration file, as nobody
> is using such a configuration variable today.

The only way to truly make "[rebase] merges =" invalid is to print an
error message and die with that configuration. I think that would be
confusing too, especially since it's now looking like rebase.merges
needs to be a pure boolean and an independent rebase.cousins boolean
option is needed as well. However, if you think that that's better
than deprecating --rebase-merges="" with the plan to drop it long
after everybody forgets about it, then I'm happy to oblige. Just let
me know what is wanted.

-Alex
