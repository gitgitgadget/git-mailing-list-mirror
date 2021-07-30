Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1504C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA06260720
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhG3OPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhG3OPF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 10:15:05 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF597C06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 07:15:00 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j18so6517076ile.8
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5x/DC+CqR10Nb0GLbFr58G1msScz5t6Idwxq+gDjms8=;
        b=Cpvq110NBrCcYvrITuJm8uNn863eEfeTBhpKHqjCcjiGNRZnCL3SuMcbqDGEiOMz9X
         g9GdlmYEYAWbxK+QZwndmhVo0xIMULYp6djqptTychaK97h+tSvagcwhDp5JrHCsw7Uy
         Eo4NGjLZ3F8/2PCO/ZNoz3daKoi321MjRtVLBbnl/CEY08wnz6BFZn5+cSN7/o2zScu6
         TV8ADg1F073QRCfphyR6jVSa9DWyu0/CsXvgyU0FEgEtloJ1BK6Fp03XZxToDMLvfhJO
         G2mdO5IFppqrNjfjFHJTBzJL4JZUv6oVKwRuOjhjiOsZfC56lKw7tZXS17tf9wsF9GHR
         i2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5x/DC+CqR10Nb0GLbFr58G1msScz5t6Idwxq+gDjms8=;
        b=XAGQfxqrmmG1RPc7UL7hdyVySik+0M+Qwlns0Iv6N46/XHyQnX+0+KBJxqGKBUf/Uu
         yx0C/oMldxuPH+aTRcxLbEvLpPYRcyB/PsPMNQQINLiDABcvCCvD/59l97GDn/FHnSu2
         njBZxfHUqEYAUcKAKhhOAKp2CuLQR0Sz65SlfwJCX91fMzaUi08ZFy6aEh5kfcfNVvcn
         +O2OWhEI0OtKYoXfSDYsdG/cIMBavlpB0vDU/N/eLAmrHAKjfC3GeLZ4XBdVTNOoGMev
         k9oOlROEHw+HTBGBj7hvwWNWwKmpq0LX8wW+zEQeHwOMk5fYIgEPhouupSFRLcFpZ7JO
         Ke3Q==
X-Gm-Message-State: AOAM531xjdyxukiw64kxGKckuMp4BNdVIzS36u0Mh12lkrMIdNqvMWj7
        HWNmf3RaWHYKSC7LCB3SicEcUb8QLamjtSlLeEQ=
X-Google-Smtp-Source: ABdhPJx4h9DoVKblyqRMiKrRhCiURsm2Y0UQ6he21bIKSJAzbARW9FWESoCNG1e+jSXz6a9VA8r6d9dOI5fkxh9+K2M=
X-Received: by 2002:a92:ab0a:: with SMTP id v10mr51798ilh.17.1627654500206;
 Fri, 30 Jul 2021 07:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1007.git.1627561665.gitgitgadget@gmail.com>
 <5c5ec310b9230ee19bde4b3c8733b359d5218b32.1627561665.git.gitgitgadget@gmail.com>
 <xmqqzgu43kkz.fsf@gitster.g>
In-Reply-To: <xmqqzgu43kkz.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 30 Jul 2021 22:15:36 +0800
Message-ID: <CAOLTT8Tj_8ESALm16OV=XxO604Qq_8KKJWYvzA7T=c=92uSyZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=884:56=E5=86=99=E9=81=93=EF=BC=9A
>
> The patch is a bit hard to read, but I do not think this improves
> the root cause of the issue at all, which is that "do we need to
> delete the pseudoref?" decision is tied to and based on the presense
> of the custom message in the environment variable.
>

My original idea was to distinguish between cherry-pick calls by machines
(git-rebase--preserve-merges.sh) and cherry-pick calls by people through
an additional option "rebase-preserve-merges-mode".

> The original issue was that we declared (erroneously) that the
> presence of a custom message _means_ the caller is not a human but a
> sequencing machinery that wants to deal with what is done via the
> CHERRY_PICK_HEAD pseudoref itself, and your original issue was that
> when a human user has the custom message envirnoment (either on
> purpose or by mistake), the logic _misidentifies_ the call as if it
> is made from a sequencing machinery and we lose the CHERRY_PICK_HEAD
> pseudoref.  The root cause is mistaking the correlation (sequencing
> machinery uses the environment and it also does not want pseudoref)
> as the causation (presense of the environment means we should remove
> pseudoref).

Ok... Now I guess what you mean is to provide an option for git cherry-pick
to specifically delete "CHERRY_PICK_HEAD", and this options is "hidden",
it is not provided to users, it is only reserved for sequencing
machinery. In this
way, we separate print_advice() from deleting "CHERRY_PICK_HEAD".
Then in the future, GIT_CHERRY_PICK_HELP will be deleted.

Thanks,
--
ZheNing Hu
