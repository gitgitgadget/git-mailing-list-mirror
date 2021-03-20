Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8FC433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 03:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDA461933
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 03:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCTDIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 23:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhCTDIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 23:08:31 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B13C061761
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 20:08:20 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id i3so6874171oik.7
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i9ld966w41wt2K1EioosdUQe31n2oQ7V8nMtAGUm5WU=;
        b=sku6dbVmOoUmW76BgaOA5uZtD/jz/lJVlvL1WOugF5ghv8/K6TodeidASmB7oaoLWE
         nCXsjXRGX4mAS3uiL/uaq2POyiRe8NC8T0sGp/rExxINusLYggR8ZVRSMTaXPfyANVA3
         cPh4bLdRKkssRIfWmvbprpg4pxeb0VapRzs31LnONPdfiy9uRU0jRd20UiRVSHNujrkP
         uUWU5VC8BFbo9KQBy9lKx50XRHHD0+P24QZ6UmUM7uh9Qa8MSWzIHSEVBZWQSCyfpy+O
         F2el7nPTVvB1m2Bt6RcB4P2t45dqe+xFaeRbSfEjRCOw+uZrqESg5kDC0Clvi4B1rfmI
         e55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9ld966w41wt2K1EioosdUQe31n2oQ7V8nMtAGUm5WU=;
        b=PHAVxjtW7hYsImv8XzExSfzizJ6EuomdvjraIVs5zum7uND0QkY6epxwrO5aE/D1hS
         QUG2u1US7JI+g27lLL7GW55RWYJ8NkzPsAIRrSHMNB0nDiUf0FTmnWC06ai3L//l9cEU
         kDFR6uuCeI5TqaSbXWmBE/QtUiig+k28BFVLg3lewoIcVsEYjDc4xueusEwBWvZnphgB
         6v/t1ScT6NzjVnbttaXNllJFrkNPwGnY4DaTW+Jnyj4QDSDY5WAFYHphRS5cY1oh68sz
         lS3NJdG2stsu0dpuh203wUebIYDBk6WkJqwJNRD/22rHUPwQNvGvEtN699eiFgGNDQzm
         w/5w==
X-Gm-Message-State: AOAM533uuV8ZtKVhv1/RMISSHiPJdKBSZIGHAVKBPiWvQtpnV58Lx0Ak
        9SfdeLVrHtvrBZqJW4+7m40BTuTjk+WL3ZUfRpU=
X-Google-Smtp-Source: ABdhPJyiJOPZqtBCIM6q5yUV8BssoVbgLZ9dY9LlFV0AW/nsCvZ9e7QaSt/dcD2OoX6Us4BYGa3vTx3sSZw8JERsClw=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr3265207oia.44.1616209699691;
 Fri, 19 Mar 2021 20:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v6.git.1616047200968.gitgitgadget@gmail.com>
 <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com> <xmqqpmzvnnda.fsf@gitster.g>
In-Reply-To: <xmqqpmzvnnda.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 20 Mar 2021 11:08:08 +0800
Message-ID: <CAOLTT8S_76_rGab1_4jY9Y-ex5hY=UaSUBVPCnEauFCg4Ee3OQ@mail.gmail.com>
Subject: Re: [PATCH v7] format-patch: allow a non-integral version numbers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8820=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >     There is a small question: in the case of --reroll-count=3D<n>, "n"=
 is an
> >     integer, we output "n-1" in the patch instead of "m" specified by
> >     --previous-count=3D<m>,Should we switch the priority of these two: =
let "m"
> >     output?
>
> In principle, if the end-user can explicitly give an input that may
> (or may not) contradict what the code would automatically compute,
> we should treat the latter as a fallback default and use it only
> when the former is not given.  So, I would think the answer is "yes,
> we should use <m> and not <n>-1, if <m> is given".

I have always felt that this issue needs attention before,
Although this `previous-count` may have nothing to do with the patch
of this version, thank you for answering this doubt for me.
