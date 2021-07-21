Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2971FC07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046EF610A7
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhGTXea (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 19:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhGTXe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 19:34:28 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A630DC061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:15:05 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so516440otf.9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+W+5MEuagzG8ESa6Vlr1Nj7QxWNzk7Qg3B1ZEappiI=;
        b=rjulukCpk5eYK3YPOae+sbkABaCAPdROXddWjH9CNk3PLYpEWR5H2+05vaRfsgqgu/
         r+A89lc5RhGyHZExaUA7pdGQxP90beQqZxH0BRhvWLqNsZTEyC+LzZAy3oWbom5eN6Kk
         x/VzGy9d9GgySIbgKlHNXvNff++sWD7Lgkq8LlarXAfY2GG/9wbdwcWal072m1qIMCh0
         DckrAUbk1vSFhS6G/j8Nhk1qjbn2KGdhQb7UADibvoMIrRZc8rcyjSp3B7n88Ryd5mec
         u0p/Ija7d95ne21vH2dc6XTqnenDn/bnQTU2cALDKtJKzHGeF16Tb9pRgY51JeSyIcb/
         hFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+W+5MEuagzG8ESa6Vlr1Nj7QxWNzk7Qg3B1ZEappiI=;
        b=r9popy9+/1Cim3uorhnC7grIBtwHWyTCe/ML7Hbq8NT+n7N3ZPYeYXRnr7cO89+bMi
         YcUrVpP/ws/RzU9QJT0oJBfELWSPKttXLgKQoKGpMlLFOtiEp87SIAtfS8WOPFVs0AEi
         o3ZAWpYd2ej4uSATOXAUHj1hU2FtG/ZwnguAOOYbhZDT/zXPGtRKeHoLoUSCe4R9X5Do
         Fos3dUNlBRaGEhR6huhYulzAp8j/v5LDzzg8a0Ja0L7pKD6OcGJ0Ena6bzoV+cfKJa+e
         62i77OvxUZRHFMnOuibaKWAq61JMf6JPiqG2M/wDlRw2XgYXXD50s4sbEuxJo8RSNG5u
         s6mw==
X-Gm-Message-State: AOAM533YC6NClks7ederMSWaS8lhoIXMwKHnrHHx4X5rmdFc4DKUVkLI
        op122HMHFRl4kUFtPmHx7iV9psVpSSCT3GZrz+8=
X-Google-Smtp-Source: ABdhPJwN2qDaisKQp/FFgCkFiJoFd9D/oPFESAFaqrv31lPm+XIG0zlVSC0ovGE6injPvTvxCDryHnnE59KHE4U8q6A=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr24425969otd.345.1626826505038;
 Tue, 20 Jul 2021 17:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <3d9ff69198e5a604b124bf861df4d6ecf6eb661e.1626536508.git.gitgitgadget@gmail.com>
 <xmqqwnpkftjv.fsf@gitster.g>
In-Reply-To: <xmqqwnpkftjv.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Jul 2021 17:14:54 -0700
Message-ID: <CABPp-BE334GU9fuMOKRNK+f5jqv=r2P7gQ5tOhtVLe1gtmNCqw@mail.gmail.com>
Subject: Re: [PATCH 5/9] pull: ensure --rebase overrides ability to ff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 4:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Now that the handling of fast-forward-only in combination with rebases
> > has been moved before the merge-vs-rebase logic, we have an unnecessary
> > special fast-forward case left within the rebase logic.
>
> It is correct to say that we could call run_rebase() and it will do
> the right thing, even when can_ff is true, in this codepath.
>
> But I am not sure if you want to do this as a part of this series.

It turns out my commit message was wrong, and so was the patch.  My
changes did have a functional change, substituting one form of
submodule breakage with another.

I'll replace this with a patch that fixes the submodule issue.  (When
--ff-only is specified, we should not rebase submodules.  We should
fast-forward both the parent module and the submodules.)
