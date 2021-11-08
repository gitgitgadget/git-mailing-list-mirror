Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04E1C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 10:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A638B6120D
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 10:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbhKHKgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 05:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhKHKgV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 05:36:21 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB304C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 02:33:37 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id i6so30437226uae.6
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 02:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vqiV+Vg/sZulljf5IBfiqQM3NvLsrHr1QbKtlzalxPw=;
        b=ABOxXPYlVmRv4vD07MIsBfUD1A8N1NP2yWfe1dqb7cHptVZQMeRjrv9eNuXJBesAGE
         FMWd5e94QswzBJfV8J5Be0XL2xxLJO/EY5YUmTOQDH8ujUGG6p4GJ1ru6wFiyKk9Rx6j
         +nJW4i/VwMAG4n9TJZuJYYQ4ORAKPaA9C0ZT8a85/fir6KFl15dT6zl61KRjVzYiJ6+N
         eik3a3kfujdxAvKWADZ+qJvcVEG2fYvLj655ywdsqKRU5lVw942fr7aRbZPcJYpP7GTJ
         4i3aePDUxWGkEUifUozQ9TPPX/Q23u+g32U+ahhSW/QtUo3GHFxZc+ff0h+X6O7t47GA
         cMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vqiV+Vg/sZulljf5IBfiqQM3NvLsrHr1QbKtlzalxPw=;
        b=McHF1SuCzvQ86/6gN0ldztkGc7mwhC12arKuAvibtFtHNEL83O8Z71aRY68hmd6mwD
         ILrIxxLwm4Ocrv/XP0rCzszoIh7mbwL9cb6Oj2+STeX3jS/vm+dOE1NX8fgj/AhpW2Uz
         0OuUKF/wXYsdqazR/9sk9tl61AChmkA6gShW9ILe6AEK+/TyK7fYouRLRnt13YGAzwe7
         K4iNpZLIplmtGfSWn81n0sBp5org6cLyvU273rh8GHxHGP7xbf39bA7//U4T+dcCc4wC
         kSIFcLevN0fshbOKOCBLIPAxYCKXvGUt5wscJ7SSZPf3fn/2chT8m76B8yJFSs9T4Bh4
         tE0w==
X-Gm-Message-State: AOAM530bFevReSE2x1jbfKjRCQ/kSt9njBsf/uHD76JtrNmrU7qorFLk
        j3j//gPUxojqNj1iW5/A+SCtQDWglfgxjZL4aSvLuzkn/h9RUw==
X-Google-Smtp-Source: ABdhPJxdgPYHjjQGO03/lN6tHkBgJaa8sAoDI8U1dhOKR8jWV5TYAt8PX09lxldP6246mXK/OfvWpln8WAg2rXmlV84=
X-Received: by 2002:ab0:5928:: with SMTP id n37mr92370063uad.15.1636367616896;
 Mon, 08 Nov 2021 02:33:36 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8ry44vve.fsf@gitster.g>
In-Reply-To: <xmqq8ry44vve.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 8 Nov 2021 11:33:25 +0100
Message-ID: <CAFQ2z_P8QGvSs5zwyOcBsbBiq+-rXSJpXzgOwwi_eg1ZB6cSSA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #02; Wed, 3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 4, 2021 at 1:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).
..
> * hn/reftable (2021-10-08) 19 commits
>  - Add "test-tool dump-reftable" command.
>..

As this topic has no interaction with any other code in Git, leaving
it cooking in 'seen' for longer doesn't provide any extra test
assurances.

Is there something stopping this topic from graduating to next, and if so w=
hat?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
