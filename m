Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4522C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13A420656
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1JhOXw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgAGT1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:27:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43703 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGT1K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:27:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so1092708oth.10
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 11:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXIZVUD6hrbFwGce0woNIYlEdgPKZCcYlaws6z9uRdM=;
        b=j1JhOXw14Y8FpvQ5auFtbjVozdtqLp6xJOx9BilzAbKNMxf7/ln92IhW09WNPbCZLb
         CS3n80hYDlMxFv4itus7Jtil2T1HS5WIv9BvvQuTLXdGvnxcAanl7IvF7bytpnYlMnFx
         4hf5TwzIfLuWKOz0FRvveh+2ZwdTli/fELdTVb/4fZmtxRh8bvGGVP0gPIDe8NId36ou
         2/N0wgPBTklT5naE3PLgxEG8ZKubq4lhciKp7o8SOGN5nIignS28XFZTnUQ07eHAULm+
         22ocFn947gtu1SiR1SwayHWJNwUxHrw2h/6cYDkdWg7vWFQ3WIG7QZGOduJ4yjj213hL
         HuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXIZVUD6hrbFwGce0woNIYlEdgPKZCcYlaws6z9uRdM=;
        b=EVaHglLQjEBCYplXQ8xfVCayLF8C7bvnmkr9eIZ8Q2k7HU4JOH4Jr9mLbvD7B9+ob9
         oYaSNF6VIYqCwB/oc057Y3kZ2R+sjAiGfFcdtBeMWt8961QNof445KTQjCKBcGET5oaz
         Pb3CoxVw61yjX+SEVMn21C4zH4Gg5CXJUxlHe2/I3Ch2OwECZwMQ2aCvgq52pRNsSne0
         /nY72dG6bgWrbLH5Fib89rmP0VrTk3lccPx58v+GWvhiwQU+liS8/jjXFfCyMGilWw57
         trHPcLAzk1PN955wfD7fwvTUzZZJTRPRIzRorFvwG/a+O7jRDpYmpWpsAXMHtTLgBnPH
         givg==
X-Gm-Message-State: APjAAAVByNdZ6uruJOYcsvUevknTnEk3/CBCFk4H2Hao2uLfWuAqHVvR
        7UwZ9jLQlI+T29/elAWLuijjMoNUiVs6IMWc+A0=
X-Google-Smtp-Source: APXvYqxO7sc6MCFmU9JILRuZfUFU3x5kdgrhBqfLhHMqmbKa2v5pUcoHm0ETag0BjVmuXAuCx8HVdJXIq4ArE1+20ac=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr1414916otp.316.1578425229571;
 Tue, 07 Jan 2020 11:27:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com> <1df11f0b5105b1f602fdd723e0f74565e436faba.1577217299.git.gitgitgadget@gmail.com>
 <8f2fa083-114a-011f-1480-ae0ebd67d814@gmail.com>
In-Reply-To: <8f2fa083-114a-011f-1480-ae0ebd67d814@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Jan 2020 11:26:58 -0800
Message-ID: <CABPp-BEoTb6LVXThEM4zoKxVOnzBNs7y-Mk+oFbb6BUzCo3RHg@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] rebase: add an --am option
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, Jan 7, 2020 at 6:43 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 24/12/2019 19:54, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Currently, this option doesn't do anything except error out if any
> > options requiring the interactive-backend are also passed.  However,
> > when we make the default backend configurable later in this series, this
> > flag will provide a way to override the config setting.
>
> I wonder if we really want to add a new option that we know we don't
> want to keep in the long term. Could we not just default to the
> interactive backend and fallback to the am backend if the user passes
> any of the am-based options on the commandline? i.e. reverse the current
> situation of defaulting to the am backend and selecting the interactive
> backend when the user passes certain options.

Good question.  For context, this option served a few purposes:
  * Providing an escape hatch during the transition in case the merge
backend doesn't handle everything the am one does in our first
attempts (i.e. similar to how we allowed using the scripted rebase
even after providing a built-in one).
  * Makes the documentation much more concise and clear (being able to
specify that various flags "imply --am" is simple, whereas removing
the flag makes me feel I need the full description of --am in each of
the few places a flag that would have implied it).
  * Provides an easy way to make the plethora of am-specific rebase
tests use the am-backend.

However, I thought of this option before Junio suggested a
rebase.backend config setting, so we could just rely on that instead.
Thus, getting rid of the "--am" flag in detail would mean:
  * I need to redo the test changes in this series to use "-c
rebase.backend=am" instead of "--am"
  * It will be slightly harder for users to use the escape hatch in
one-off cases during the transition
  * We need to figure out the right way to reword the documentation

The first two are pretty minor, so that probably means I just need to
come up with some good wording for the documentation (suggestions
welcome...)


Elijah
