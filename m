Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1485FC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 11:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B7260F91
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 11:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhG1Ldz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 07:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbhG1Ldz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 07:33:55 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3234C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 04:33:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r18so2612389iot.4
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ZoMXW1d5RWIsxpb14SvKURH5eV6M5dVbGZmkswYhTo=;
        b=IDngx4An9G3Zu2ubUd6PI83mDv5zbO5oJn/EDMQMbYnRUM8S1VV7IfbO3w0MAipZhw
         oWGxjrR0ihmD/OdNGKsQXlW5z6UvEa8DU4teMZULs6KcBinbGpFXJhPm1sysITcw//8L
         JoC5tGVrYLgh98I1yrk/9kXAXJWHb5E3+dPOdaiiZqnkSa2pD4yndJ8U3lRU+MR7kiCR
         qzhqnj61VT0fEqoAJiTxHV0KLaojAIcLSntZ9HiBHTU2pMnVLZfMpjmy/c1TSiLVq+OM
         T4vfbzNhV8aVNq/WTglcY8SlLHnwNhAwd2S2xhUdhHuAk/QWRkiQ4EOQvJs2pveY5v1t
         GOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ZoMXW1d5RWIsxpb14SvKURH5eV6M5dVbGZmkswYhTo=;
        b=pAtdAZTuxox7zTR4eopmSZ8mjlg38rYZUSGI31Yp74SOCqnvdq/yXp2jEInSZ04URA
         UA7Q3FqAoASObokno92SedljhIqe1jEzGZd/U9+5LeIyPTbvYb5buUFirdJ2U8zB+NAR
         Tx17pKgDSlFMdsRPJQkzT556ugmHvbn8g0vFErRfEtckgaCMYQNfoY6TsPVKrH2vs3yz
         zvRJoXFJqYll5KI89Du2lGfDkyEm/GPKXcVP793M4Z4Hy7O/Xcw2Dtpz5gF7WVO+cBWp
         56igIpyLZnY4f5Ddzt9qOG7CF2Soffj9zfnc+B5cj6op+XHTveIPM5WJMGsad7R8PtWO
         cZtw==
X-Gm-Message-State: AOAM532L4LAx83XHuxRP2ZLdTZTfc1lov1rrq6VfSxU5KwGQvJ3J0l2I
        6Ku5ays0Nb51EqrYPuU2t4JEkVRnSNr/CUAmRDM=
X-Google-Smtp-Source: ABdhPJz7wlHHkj/M1OKLwxv/aFfeZY19dKLHpvVwB9r7HF08pCYN71fD4lzqqPiMFRe/Z9rC1ZO8pjxA4jaJ9/Gk44M=
X-Received: by 2002:a05:6638:33a6:: with SMTP id h38mr26113875jav.130.1627472032298;
 Wed, 28 Jul 2021 04:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
 <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com> <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
 <xmqq1r7jebbf.fsf@gitster.g> <xmqqtukfcvzv.fsf@gitster.g>
In-Reply-To: <xmqqtukfcvzv.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 28 Jul 2021 19:34:25 +0800
Message-ID: <CAOLTT8SR86q+q37traSpk7iWEzAaGTtZzAWrck+0LnqgSefKRA@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:00=E5=86=99=E9=81=93=EF=BC=9A

> Otherwise we can allocate a new bit in the structure, have relevant
> callers set it, and teach cherry-pick an unadvertised command line
> option that sets the bit, and use that option only from
> git-rebase--preserve-merges when it makes a call to cherry-pick.
> When "rebase -p" is either retired or rewritten in C, we can retire
> the option from cherry-pick.
>

Just use a PARSE_OPT_HIDDEN cannot prevent the user from using
the option... Is there a better way?

--
ZheNing Hu
