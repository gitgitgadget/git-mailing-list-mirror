Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB4C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 19:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350902AbhKXTJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbhKXTJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 14:09:37 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE20C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 11:06:27 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 84so2254035vkc.6
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z+CU1+RZn0VK/2bjenZ202lMIpckPgKtlQqM4xGsc/0=;
        b=p9EEYJH1J4kFEt+n+19NFrII4HDcw3Q7ej9obSX95016cFRvW42i815+0gp00g9nqa
         wVlAiOTBfObTFRkpg6rxJjAe8uFe9yaZg5/yuIhi3BmeiHs83HmVis1NxfmtnS3/9+JK
         w4ip5R7lgLYFuCm8ipQq4Kl5uyj9O1ti/QJ3Vz7gV+6DOaUqgkURfyA54tbyT+o5fl3P
         RQ7RURaELZZiJJfwRr7KjxDF/FnF5VNHPoSKYBSa+hgoHiaa2oscV2ix+5+QTrP9cw82
         KZni2KNDl/Y0pCMJb67NnAI7ZHjZ8Xr55l926Wax9cX60UvHsEngRXBNWxmtgpC1SW2d
         eNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z+CU1+RZn0VK/2bjenZ202lMIpckPgKtlQqM4xGsc/0=;
        b=687/pvBnJOGC09obZgLpBkG1vARL3xHV8jandRDzkQVOqWiAM28DQSuWfrnO74F3Qz
         z2ZkFg+wG12T1Rv2YdLBEu7Zty/cKLbOFh/IyJghuY9pkeAYzIQO5NXwneeJYNRm44FG
         zrmo0s0/G/nT65bh9obVoe9kcUgBCcFD+J8lWVEdW54R29CEJKC9p7iyMemcqqehWVhO
         z7KSkhj1UrCP/WVdK4703wFBl6QIpAYoW0cSmebVUQhatbHb/I5CVH2FXh1DhsUmQgD/
         5TSaoZyMkX7R57RTdWk68gsRg4TSxxk1/eoCxqm96jg4eTGgpmJ4t8JSmw86+o6+ghbu
         R6+Q==
X-Gm-Message-State: AOAM530Tbx11Ov6+k14uF52g8awE3kJHGSTZ8ODxVs1VrjAmpuS3la8y
        FFqfEQwfN+WImApNgCbD8XWfdSTdwUa70q4GsvZCeA==
X-Google-Smtp-Source: ABdhPJyS+OQjABpjScLETnbTNxlwZO+iqqZYq1IHWTRHGePei1RAnZpyJFi1ExgGUtbC/yAFn0RpBGWHHmdw9RvYiR0=
X-Received: by 2002:a1f:aa48:: with SMTP id t69mr29555076vke.2.1637780785775;
 Wed, 24 Nov 2021 11:06:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
 <xmqq35nnddw7.fsf@gitster.g> <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
 <xmqqczmqajdk.fsf@gitster.g> <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
 <xmqqzgpu7grv.fsf@gitster.g> <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
 <xmqqpmqp2xmz.fsf@gitster.g>
In-Reply-To: <xmqqpmqp2xmz.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 24 Nov 2021 20:06:14 +0100
Message-ID: <CAFQ2z_PqgwYy+RxQm7d7WDQYvQQ2vVE0cXHdDKNwQJm3Xc+NFw@mail.gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 7:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> >> ...  Doesn't the ref backend already ensure that
> >> the message is not an incomplete line?  If you feed a single
> >> complete line when updating, I do not think the backend should add
> >> any extra LF relative to the given message:
> >
> > But it does, currently. As of
> >
> >   commit 523fa69c36744ae6779e38614cb9bfb2be552923
> >   Author: Junio C Hamano <gitster@pobox.com>
> >   ..
> >   - We expect that a reflog message consists of a single line.  The
> >        file format used by the files backend may add a LF after the
> >
> > it is the job of the files ref backend to add a LF, and the input to
> > the ref backend is a string without trailing LF. But the files backend
> > then produces that message with a LF, when reading back the data, eg.
>
> Ah, perhaps our confusion comes from the fact that I view the ref
> API as a whole and do not draw a fine line of distinction between
> the "ref API implementation common across backends" vs "what ref
> files backend does".  But as the implementor of one backend, you
> obviously have to care.

Having the read function return something different than what the
write gets still seems odd to me.
How about having copy_reflog_msg() trim trailing space and then always add =
LF?

The files backend can assert that the string ends in LF, and doesn't
need to add LF itself.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
