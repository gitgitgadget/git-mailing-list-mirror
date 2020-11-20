Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840C3C5519F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 12:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1BA22255
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 12:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqMjaJKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgKTMeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 07:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgKTMea (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:30 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E48C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 04:34:30 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id u22so3252515qtw.4
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YgCdMtQ4BCCy7QjeQllBc7qarTLJ34I1FyvzACd70b8=;
        b=QqMjaJKTyJxMdOxAxiLBWeESEGqz9k/Xg70HL1V4b62X1E9LtcGYG9j3BV8oz9TH3j
         eOjD6VdoST0toxRDYXdoeEBE2lPOnsWw06YAydUazvjL+/dzuAx6kBeQICYLQjIA9SM1
         imC0LAhbU9ti9WKE6XmpLdPZwWjacks3+JHU5bibMuSoUKTshRjOlmjk7MUPVekGyL31
         uqFbfWXNwD1xFGMbvYBvcbiXPb+I9rFnKoRRMHJzpM+JHJFQcNxfS2mXly7VGqB5kWnV
         7CHFxJZFoM4EgXkSfe6NIXOoWpa/pcXITtl5t5rLoAdUOgB9AaBidc9Zb+WxUUrk/qWM
         +A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YgCdMtQ4BCCy7QjeQllBc7qarTLJ34I1FyvzACd70b8=;
        b=oq0swvFM7uXiO6UqeacoI6yu5bsytbqQx/9p47E9lWhgvxYPEfcBD8xj21cexGfQOJ
         L9HxJyzLLutEpyEoYpwnlh7PLgYEbI1B0UAiHEWVAUoiadIxHCs1I5m29lGdSOK1jY6J
         MlYqlUELvqgtIKMDR+IVhmpeZT+UpFcibHh8IBUO4oDX1sFoFB3sxcswjkmgOp4VI4tu
         TM/Y4dQyGAA1zVFmRMApYtNSoWiv97yVR/k9Zb8jnB9mPOJot8Yw4xPNY362CWC9U7wx
         k4A5TExLV4gC2LuP8CjIkb4cUx9R1+zFEkW6x5S6krksGYCMTBhlsORbiHzajwUN+NMU
         nJDA==
X-Gm-Message-State: AOAM531NjButvMzMyNtTf7ti7FyJfja4cC/6yjDS3IfEKJQOFpUUpmUq
        FEcVJsW4shS2ZSumbUL9C2w/7DCWq8FjQHehszk=
X-Google-Smtp-Source: ABdhPJwltKTXXTcIZJzKp7OxThus9gnr8LQfAz1OsrYTYtQkNx8g9njEW9GmsXzNX1L9nKF0AmavSDSXSkxZ0ys2QIU=
X-Received: by 2002:ac8:6b4c:: with SMTP id x12mr16295335qts.359.1605875669408;
 Fri, 20 Nov 2020 04:34:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
 <pull.790.v4.git.1605819390.gitgitgadget@gmail.com> <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
 <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com>
 <CAGHpTBKHmdjqrz1ABdGUUz7AwcixU_VBy1DQzybpFizqVo8C7A@mail.gmail.com> <87sg94pa45.fsf@evledraar.gmail.com>
In-Reply-To: <87sg94pa45.fsf@evledraar.gmail.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Fri, 20 Nov 2020 14:34:19 +0200
Message-ID: <CAGHpTB+LzXTNp3UGia6bdEDqV=mjAY+JQkO3aeUmddhYa1xajw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hooks: allow input from stdin for commit-related hooks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 12:59 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Nov 20 2020, Orgad Shaneh wrote:
>
> > Can you suggest an alternative way to determine if I can accept user
> > input from the console or not?
>
> Like Eric noted in his reply I can't think of a way to do that
> particular thing reliably either, and agree with his comments that if
> such a way is found / some aspect of this change is kept having this
> explanation in the patch/commit message is really helpful.

I'll reword.

> I think what you're trying to do here isn't a good fit for most git
> workflows. Instead of trying to interactively compose a commit message
> why not change the commit template to start with e.g.:
>
>     # You must replace XXX with an issue number here!:
>     Issue #XXX:
>
> That gives the user the same thing to fill out, but in their editor
> instead of via some terminal/GUI prompt. They need to write the rest of
> the commit message anyway in the editor, so even if you could why open
> up two UIs?

We do have a template. The hook pops a listbox with all the open issues
assigned to the user, which he/she can easily pick from, instead of
searching for them in the browser and copying the issue id. This is only
done if the user doesn't write an issue in the commit message.

> Projects that have these conventions also typically settle on just not
> trying to solve this problem on the client-side, but e.g. having a
> pre-receive hook that does the validation, or do it via CI / before a
> merge to master happens etc.

We have validation on the server too. The hook is there for convenience.

- Orgad
