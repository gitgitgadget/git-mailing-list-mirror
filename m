Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9316DC6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 19:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBXT4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBXT4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 14:56:32 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D7C16AC3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:56:31 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id be35so206231oib.4
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E4IfdZhxXtpsHLKQAMe3FU1OuarMbq+fePVCIgkvlOs=;
        b=YCPpsaQ5Sw82pRIGmZ4sQLsjCmjOCqYMoY5IEHYnctDXqHkThkAcgwae3DsZjr5T+Q
         t5MZrjXh9SUuOb5XoCWalhprnkMsRV1pO4YhbPKRSVWWpcqOdBmhXaA7ZbZggvoWWrwf
         rvXcskPQMfdqyrh0Y0UC1rN1DcmMxHxMLwgzW5RJr67UzQ6QoCQ/BNARtXkAq+EUyZgz
         ebmPNG0V1js0z2mc4gBsOU6KXDgU2K1TVZKTzt4f95lSQ0ELUAXsc4XCo9s2B6GBQevb
         iERjyFpYgjxnIFz1l20YGTHGJSj3qb5NLMnvZEAD2wy8Rsc8jIxExQCuO5GT5aCu5rKN
         pQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4IfdZhxXtpsHLKQAMe3FU1OuarMbq+fePVCIgkvlOs=;
        b=XKB/dEZza/FrNaeieU5s6nCLM9yIMhyqhMdKD8WIQXUwyevp0WHSVQFZmecS03Ih4B
         nwCQ653a/G0t2Yxsvf9n/GIEaFC6buYoEb5Y3QeYIsPUGvQ4IPWbqRBzpDZJnREP7mLi
         OfV28mFknxNIo3rdbD9I/RgWRYMl8UOMxHvU7sdpQMKlz/oHpHBVuWoKR1wmh08jlY7A
         WQ3AzHcoWdn1cgcqj0IN1zOG/fZV7ySf/owiZ01CBg/jQF4Ue3CZ5ih/+zDhHFal60I9
         MGVbfjV3ttxatQQP4XZwsMxtvPMAZGB2ruo4YSXy0rRFYXeDdgMQUx5QUFpBGRcNZGYy
         IR1A==
X-Gm-Message-State: AO0yUKWhBrWAEGBYIxmerc0Jl00GQHnRjkh1Kq9mUmo6Q4rnA5AeH9nI
        KZweKs/cQFvGC+iM6Cq39CQL375Z69oFpI0zq9E=
X-Google-Smtp-Source: AK7set8uaSn1q1y66ckwMJDpfFHxEqRW7VbOTrBHJPCOAGTHYlnLex6eIyEJdDq7cpZ/YS2CmSrIevqms5jSfjRovWM=
X-Received: by 2002:a05:6808:abc:b0:378:30dc:ae5b with SMTP id
 r28-20020a0568080abc00b0037830dcae5bmr1510718oij.5.1677268591148; Fri, 24 Feb
 2023 11:56:31 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230223053410.644503-2-alexhenrie24@gmail.com> <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
 <xmqqy1on0yla.fsf@gitster.g> <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
 <xmqqcz5z0wdb.fsf@gitster.g> <CAMMLpeSH1itopDuON=7ms_7Li7Qk+9dhzKjT5f7UE11posKK=g@mail.gmail.com>
 <xmqq8rgm29fw.fsf@gitster.g> <CAMMLpeTvyYgGNBQWtRBg3ZNuXeCMxiem-5LAdu0ex7XCuf0wAA@mail.gmail.com>
 <xmqqpm9yzxky.fsf@gitster.g> <2b28155d-f82d-06b8-2df9-135608c6bf63@dunelm.org.uk>
In-Reply-To: <2b28155d-f82d-06b8-2df9-135608c6bf63@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 24 Feb 2023 12:56:14 -0700
Message-ID: <CAMMLpeQgY5Noyu4HMsi0LDOBktSURpZHybqwbFnqf5sGwmD=9g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 12:24 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 24/02/2023 19:13, Junio C Hamano wrote:
> > Alex Henrie <alexhenrie24@gmail.com> writes:
> >
> >> Phillip is concerned about people and scripts assuming that
> >> --rebase-merges is equivalent to --rebase-merges=no-rebase-cousins,
> >> see [1].
> >
> > Isn't that already broken when you introduce rebase.merges
> > configuration?
>
> Scripts using --rebase-merges are not broken by the introduction of
> rebase.merges so long as we follow our usual convention of always
> allowing the commandline to override the config (i.e. --rebase-merges is
> always equivalent to --rebase-merges=no-rebase-cousins). I don't really
> understand why Alex is suggesting splitting the config into two based on
> my comments.

I was thinking that it would be less surprising to users if the option
that broke the no-rebase-cousins assumption had "cousins" in its name.
I should have stopped to think that that wouldn't really address your
concern because regardless of what the option is named, it could still
result in surprising behavior. I apologize for the unhelpful
suggestion.

> > People and scripts are already relying on the lack
> > of rebase-merges to flatten, and script writers will be surprised to
> > receive a "bug report" complaining that their script does not work
> > when the users set rebase.merges to anything but no.
>
> That is true.

In addition to specifying --no-rebase-merges rather than assuming it,
shouldn't the "usual convention" for writing scripts also include
being explicit about --rebase-merges=rebase-cousins or
--rebase-merges=no-rebase-cousins? And if that is the case, is it
really much of a loss to let rebase.merges=rebase-cousins override
--rebase-merges without an argument?

-Alex
