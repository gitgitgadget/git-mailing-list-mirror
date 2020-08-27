Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97600C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 16:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D002087E
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 16:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9vshEMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgH0Q2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgH0Q2E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 12:28:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82E8C06121B
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 09:28:04 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k2so4906037ots.4
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eotGbj+3DEOY+yj0U5IVmFSuIX0BiCrwrz4XhQ23ivc=;
        b=f9vshEMxzEgL612vwxNNH0NfeAlePsPjtyE9ClGHP4kv820/eMIC03m+bDqzjnfr2O
         3Czjjcz6GwwOBvKICNOvk59ZnGacS9asAlgDV62zU1OLVQnFnEx52U14se666rZdE3Z4
         nwRBBCChuwj2v9OZUpJ/C5imTz9Dkm/0TCb/88PY0l7nBmvxGkaPt1X/EMnRfyJkacSE
         bhfuu3UTmeMQzAwyep3Oz1G0pAp2MCZYCgMHp7jOyAxvZ5xL396VesUzqI+ymuxjeQfM
         VbgfQaQKDglEjVxxXzIJm7FQUJKnTHkhclBHKZfOnN/2gt49jvOrbpku58rRCob8e54/
         Nb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eotGbj+3DEOY+yj0U5IVmFSuIX0BiCrwrz4XhQ23ivc=;
        b=rSnDnkL6AcgAGUV8awIXUZhuUFdl2bczhgZFhhI6Y9aplxKcA6SotVpiHMb/Eho6fV
         zTU8c7dMAS0N16XKc/NPWBQDdwRJf9eoQ7YbmKSQlFK7fk+KQnJgExGJ8JqLzjBmUTXL
         YbKHpNctjeACAV/XJSx6apOASHxpKXm9Gi/Yaayx9zv5RvMywIqdlb/UIGT/ri6Oz2Uk
         4MBhrrBf28uCGp34Fu4M+hwevlzTEKzN0a4WTmeW8bEjxAtr1cRdZqZCaikou9CfqEu1
         eB/XE4EL0i3vYSWXsHfVacWXA9/LMvkpelkZm84UQDP4uN1eWISEPk7iKHJ9i8Gs9ES/
         9JjA==
X-Gm-Message-State: AOAM5334DGpnsZ+b2ORWHviAXsRsPQ8T/D5Lf68ZdP5eMEG2g3hRJ5Ct
        mfxUcWW0KYVu9etBlWE/UYkB24jvyDJHiNvNPROaoAdGTms=
X-Google-Smtp-Source: ABdhPJzAab8Silg8MApFHn2L8RYFe0KWPYIOS1LEhW/JuZcPOwu9Xw2sExCmSnaWeq6ET/kikoNLV26qgE5BluuT2eo=
X-Received: by 2002:a9d:813:: with SMTP id 19mr14342368oty.345.1598545683941;
 Thu, 27 Aug 2020 09:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
 <xmqq7dtlt080.fsf@gitster.c.googlers.com> <xmqq3649szs8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq3649szs8.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Aug 2020 09:27:52 -0700
Message-ID: <CABPp-BF=ydfHE2XqN4L9qfeAg3AZL9yNJhs4rykGj0baT1Eh6g@mail.gmail.com>
Subject: Re: post-checkout hook aborts rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tom Rutherford <tmrutherford@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 26, 2020 at 5:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > ...  If "git rebase" or whatever
> > command wanted to place files and the index into some state by using
> > "git checkout" command, and if the post-checkout hook mucked with
> > the state in such a way that contradicts with what the "git rebase"
> > command wanted them to be in, it is not surprising the hook's behavior
> > broke "git rebase"'s operation.
>
> Having said all that, I actually think that "rebase" shouldn't be
> invoking "git checkout" (and its equivalent) internally when
> switching to a specific version, in such a way that it would trigger
> any end-user specified hooks and allow them to muck with the working
> tree and the index state.
>
> I haven't checked the actual implementation of "git rebase" for
> quite some time to be sure, but we have lower-level plumbing
> commands that are not affected by the end-user hooks for exactly
> that kind of "build higher-level commands by synthesis of
> lower-level machinery", and it is very possible that what we are
> looking at is actually a bug that needs to be fixed.  I dunno.
>
> Thanks.

Yes, and I think we should also make rebase stop invoking "git commit" too.
