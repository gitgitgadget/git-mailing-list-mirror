Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A68C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B954260C3F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 20:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhHCU5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhHCU5N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 16:57:13 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE81C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 13:57:01 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u10so329291oiw.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UISFD1ANLE/iBa3W2xN3EJZvOPoun5Og1CQkvgaugf0=;
        b=dEjTziDXCLzlgyyzcAYPiPo8H9uaKSHW9YblNhlPxtI+tRJcxuYMZyFyXj2c3JGU3z
         AG5Jth8eZ4LBiqHjvw3fllYc0YTflSObHOHg0+5ceTEIz3BEsxj6NYeAtUCl8rV17P8X
         +ajvHEtPB9YoMGovyzvEsqu5C7bwpqrfpVvw51ZgPnGGJhHYPKh4llXheZp3b3gimHQ2
         IhYjT2cc01gAU803NtDbHT8sqKw1Ck8X0lNhb9ME7vBZWL8RsXufTwQPEZwgs0cpQEpr
         cCG+8RwCOxO7rTsAiAigjgWyrmijy3wiXXiLekSU2E9IlmTvDFqvdIgXJDq8nR0usz9z
         58GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UISFD1ANLE/iBa3W2xN3EJZvOPoun5Og1CQkvgaugf0=;
        b=Yjnnt/75JkZjwwwkVumMf6tJnqnggd3zYt0vrn3lMYEzzngH/1NZLXTxxefSu1MJp+
         /+dygAVPAMnYOrbKXFbqX9MMcsmg3JoyQyBE1yzgS6P7JorztzTiT3BgUOL96+j5ZV1A
         mJzDI2foEe1nbOwmHGrHbW7/dIPADk3hsQVPyjod+xd6HdY7YbSIMRDWN0ZWNPSywHek
         7Jm0zgv5dmIzEaA4+szIHc88tKhGSdQSzKn8D3UXVw0DTXP3gEKfBCJzLLRh501Px1Tg
         PONzBus+/cd4VHx5v0gy8gIeJOlRu0eFrG656388z6WGxqtJesfzt3+nzbGOZ6QWSqRw
         Wkag==
X-Gm-Message-State: AOAM530RBpYjfEb/EzJAkLAg1Xa8OZbKuB9UWcZ80FiJSNmKceTz9YO0
        lQ0AY0dT2hiBWJ0DEGDlhYsF+A0qq112gY3lUoQ=
X-Google-Smtp-Source: ABdhPJwJJnxCyw2gVCCxa3QhW5iG9XBAaTEiN2/3kjjBwt7Oozv8uD9VbMnXcZih2OeX1uZPAfFPpJMVaFXoMJH63WI=
X-Received: by 2002:a05:6808:1390:: with SMTP id c16mr15695186oiw.123.1628024221030;
 Tue, 03 Aug 2021 13:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
 <YQmsJUe6hAMy/QGA@nand.local>
In-Reply-To: <YQmsJUe6hAMy/QGA@nand.local>
From:   Cameron Steffen <cam.steffen94@gmail.com>
Date:   Tue, 3 Aug 2021 15:56:49 -0500
Message-ID: <CAAVFnN=W27rdE1EH-joscyJEooAsDrdtPropVVaBYwhte=cPJA@mail.gmail.com>
Subject: Re: git revert --continue --no-verify
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`--no-verify` is an argument typically used with `git commit` in order
to skip the pre-commit hook. Since the pre-commit hook also runs on
`git revert --continue`, I expected to be able to use `--no-verify`.

On Tue, Aug 3, 2021 at 3:50 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Cameron,
>
> On Tue, Aug 03, 2021 at 02:17:07PM -0500, Cameron Steffen wrote:
> > Today I tried to run this command and I just got a help screen. I am
> > using 2.32.0.
> >
> > git revert --continue --no-verify
>
> I can't think of any sequencer commands that support a `--[no-]verify`
> argument. Did you mistake `--no-verify` for something else, like
> `--no-edit` or `--no-commit`?
>
> Thanks,
> Taylor
