Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF87C4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 23:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiLAXY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiLAXYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 18:24:25 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B8311820
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 15:24:24 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g10so3091658plo.11
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 15:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7RSUfMW9AbUoV5IreJk0WFHtWVEmTYSDcqO/ZWvVy4=;
        b=iVWM//tMaevmuYALWAZNGRjAqdzJ7L+PRHlyloK8VBZ0b8t7VHBXTpNvmstiw0CYdH
         FU35C1zBcJ0Piny7cPhEQG144iddRaO0Jr1sfUE3IRCIy+aUEemMqxncz2sKMq1zzNDC
         0UEN0E8SUp8m4BUljZMd9qvwBEIsPeeOuV+wf+ewNkA1RIlVsPSnx3TSdo6MNFYnFoeQ
         /YTY4R02DgLK+Bp1DnANkn0yQRfNzNRkseYChwQDoMHN4NmdswXJoM7tQSR2aNzFbfNU
         TZCslwHUJ24uHhiftUvo0ZAWz0wJqPaXv2li0UM/OUQJMwWzpQ7hchLY3davP32YvNEr
         graw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7RSUfMW9AbUoV5IreJk0WFHtWVEmTYSDcqO/ZWvVy4=;
        b=RUfSMkKxT/UrdiiasSEvIRvoxe7VpsgmOqOFexrv84s49dSboNhqbw71TuMEgoW3Km
         8ne04LcK15Lgg6tA8y193xrBbeAEYz+na/2xeQ0H9JO5U1Accqw8TaR9hZLZAkTte5u6
         U3iSo99pL5mkGQV2bb72E9osHOSLUHrlgufszEeoc1Elr1iYFV0vx2azDFHBugB7S2yM
         bsdoAYGolyU306zdxE1IT2wfsfjJfCmjnLV65b7+74DR0Wq9UWhIsCxmunINwLUHbB74
         q9MG7n252+W6Y4wmvXTCLOSIUboZewXnqIiP2QcPmyKpDdwfEWvA3nAVlDI4as/IAgX6
         LwNQ==
X-Gm-Message-State: ANoB5pmpXmtTOqlCW8/q23jrEXfFFKLRPfFAXRliBBSdfUxpbn49kGeF
        qqcS5807wEGs7BA1XJFYCuM=
X-Google-Smtp-Source: AA0mqf55sSMDigxz6ec7/4ZFxX1FvFqadmHCn1X+frGTvySuCYuIoKgm78VM/N5w0xdk7LQsr3aEzQ==
X-Received: by 2002:a17:90a:440b:b0:219:886b:9155 with SMTP id s11-20020a17090a440b00b00219886b9155mr1093534pjg.167.1669937064036;
        Thu, 01 Dec 2022 15:24:24 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y16-20020a63ce10000000b0047696938911sm3045165pgf.74.2022.12.01.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:24:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4205: don't exit test script on failure
References: <c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de>
        <221202.86edtihgga.gmgdl@evledraar.gmail.com>
Date:   Fri, 02 Dec 2022 08:24:23 +0900
In-Reply-To: <221202.86edtihgga.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 02 Dec 2022 00:05:45 +0100")
Message-ID: <xmqqr0xir9lk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> This is also 6/6 in this series to submit a bunch of these sorts of
> issues, which I submitted back in July:
> https://lore.kernel.org/git/cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com/

Such a comment is the least productive, I am afraid.

When the series originally did not get any traction would have been
a good time to ask others for reviews to push it forward, but not in
a thread of other people.

Thanks.
