Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06F2C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BB161002
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhGLUyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhGLUyS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:54:18 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22C6C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:51:29 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so19462733otf.9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KX0xddX+lT73zq2sy63hiBZQI4x0vX7u7jnJvoNhl8o=;
        b=pCqCUO3L4UHIeSdiVX5PFl1KyyeUgfSRfJ7sD2PO5KJyXyzhWTjE5lEZrsk9zIXXAe
         4mx+V+pcz0YhmRJ5e641qXodvN7eOhif3EZyG/MesnhWnTfbkUg518c8bsnO0W85B9vi
         vujjXU3EukS8dmR1W+YbxcGGotW4Ih5yowdHWXqcXGXNFLzaYJ6or8Oy+Ji8/fURberI
         lCbdXici8RZwhXhQ2y+iBaDoEbrd52z5sxS+RwxNGNRiblDd3dbuS1CsV+htVZ6ZtAM7
         3cMYfPh4/GTt+SRicnrWWYJLiU/8bpy6yKrtPISFBKgi0oMbIyMLfCx/BA98oUzsgO3N
         nwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KX0xddX+lT73zq2sy63hiBZQI4x0vX7u7jnJvoNhl8o=;
        b=J486kPCCqac6T0oHuZe8WeyKkBomZA1Kohff++oFXt3UPhkVc3rRPK5FJ+qC1c9yRD
         QfCfzR+1gQBlSUOUcxEkTR5IfNsSY6ycQRufoGhqAQBHxJX/Nmttqvgjx2iVyed7YCpE
         1U4I2UrHbZFGCUk6a8GZoklzJ6vQWaYNPyK65vDd8RYdwSfDaKkdyif3jinzO8T1iYl8
         /zRejv9WQ971m/3LK6Wc7+SKxbQQ4iVBKkdY4yCc74R93XBdH15JeyBRtDKZlGtOfyY9
         wCsScg2TpnuFRigRW1900/olPv60HdIKZCaU1wpeT5jAJ8vMoJWoOkrHPqdFtISjEn7h
         pEWg==
X-Gm-Message-State: AOAM533PvPqUMbwiyKEPsAXygy4+owiKkVveSsgzpJirilFA1yfGJ8HG
        OeJKTrvEf98al19hOAoiP2iPua5pYM7Op/kG+XI=
X-Google-Smtp-Source: ABdhPJyxMmyR+6Ns68joKkKOubuX8Wtl9FwLdqVwGldDWh8JpXtLY2vY6ghhFK+JHUkCNKCcKvCZH8xANspIC1890+U=
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr676229otp.316.1626123089129;
 Mon, 12 Jul 2021 13:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com> <xmqqpmvn5ukj.fsf@gitster.g>
 <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
 <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
 <CAMMLpeSBgURtX+MKbABKdmFuuoTA-Dw3h8uONwNeiP5aqcnfpA@mail.gmail.com> <xmqq8s2b489p.fsf@gitster.g>
In-Reply-To: <xmqq8s2b489p.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Jul 2021 13:51:18 -0700
Message-ID: <CABPp-BH+LPbfdgixvSEGpLxwCHHSK99PFmE3q04jPZjLaqr5Xg@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 12:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Sorry, I misspoke. I was thinking of the case where fast-forwarding is
> > impossible.
>
> When we cannot fast-forward (i.e. we have our own development that
> is not in the tip of their history),
>
>  --ff-only would cause the operation fail
>  --ff would become no-op (as it merely allows fast-forwarding)
>  --no-ff would become no-op (as it merely forbids fast-forwarding)
>
> and the latter two case, we'd either merge or rebase (with possibly
> specified mode like --preserve-merges).  I thought the current
> documentation is already fairly clear on this point?

git pull's --no-ff is documented to "create a merge commit in all
cases", and thus as worded, seems incompatible with rebasing to me.
Treating --no-ff as a no-op when we cannot fast-forward (i.e. allowing
rebasing to happen) could be seen as a backwards incompatible change
at this point.

Having --ff be compatible with rebasing works because the end result
will be the same as described in the existing documentation.

> > If fast-forwarding is possible, --ff-only already effectively
> > implies --no-rebase, and we might want to make that explicit in
> > the documentation.
>
> When we fast-forward (i.e. their history is descendant from ours,
> and the user did not give --no-ff), it does not matter if it is done
> using the merge backend, the rebase backend, or by the "git pull"
> wrapper. The end user does not care.  The end result is that the tip
> of the branch now points at the tip of the history we pulled from
> the other side and that is all what matters.
>
> So, from that point of view, I do not think we want to say rebase or
> merge or anything else for such a case in the documentation.

All three of --ff, --no-ff, and --ff-only come from
Documentation/merge-options.txt and are shared between git-merge and
git-pull.  The description of each of those items mentions "merges" or
"merging" at least once in every sentence.
