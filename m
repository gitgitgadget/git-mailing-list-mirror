Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3EC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54E060F8F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhHDAU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhHDAUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:20:23 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF7C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 17:20:11 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v9-20020a9d60490000b02904f06fc590dbso155535otj.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATxY/S3gUzXN3QSYjiafs67zvSbb+M9i38xzdwea8Go=;
        b=nGY7p1R2h6yTmYPT76DGRmkC/PZgHPuPNtEp7Cz5CcYvuzOtmR1wiQezHCQaTfACUG
         hShia/U8rPVO02CsPnIlTC8RnSxWxQtlmlJFtTp5fyT8YXQnlCN8eP3E5qrpH5NnH4MK
         3WfUKsntxIKlSs7Mu56RCnaNHC/2uhHMebrA3QpWdij5azvywkfYnrR60QPYupJGuAba
         3DylwOP8sTQ2oK7wYBigrkNfRU86lmoCWLCw000ijCiYH3s2BTth9WYZ+r27oKkrnYwl
         F1xcVWxmESudMo5ugqZIJssRrBnptBORAHbfa9IUoRdBVlgkwx2RccVz1+Ck53pDsAYA
         TKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATxY/S3gUzXN3QSYjiafs67zvSbb+M9i38xzdwea8Go=;
        b=qUp0g4GOyGH9P1LRdiSrB82WSivI1JSsCuKGRioNRKu0ZU0Us3O+QmMm3JlltsHJ2o
         r6bvqK3vOy1ewzt8CfIor6Lz/L6oXp2qWzTKTnoPhLII2fciH5BBAmvT9nGjyPJAsEq5
         L8LFzh/vzihFIrbpg3M7BSpw6j0+xH+Q0lQFJpNqr/CzCk+Vd11lMrFG3goV4uflNrU0
         XUb0k9MDyHOwibVGpbyvrwJVB7jg9RSYghYfVzNVsL5vqG2fuusgskr+tX6IK3qmTiRf
         ngMEwl8nKn2WpPmy0c7ZWKgBvtPgcuvBjqlmenzV6XEAPBsh64zRut8kF9+7lt+ofuY8
         bDTA==
X-Gm-Message-State: AOAM531DgZtE/d45lVyWZu/5H3MfhRaEkaDM0a0PFrlr1sDgmciSB4kF
        iUvERJSqqjK3OpvuYOy+QDWv1miJJTCWafCM/0U=
X-Google-Smtp-Source: ABdhPJzB+RpKowpByBOMhG6cCzkvoE3SCwGIGdfpVEtJ2lMMMaaIHzohDJKB3LYfTu/B/qC28ZKsPnYvmQs3xIrLBlU=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr16840658ots.162.1628036410704;
 Tue, 03 Aug 2021 17:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <c1d056f0794ddcb0400901228b370b3bb5dfc0da.1628004920.git.gitgitgadget@gmail.com>
 <xmqqr1farrqg.fsf@gitster.g>
In-Reply-To: <xmqqr1farrqg.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 18:19:59 -0600
Message-ID: <CABPp-BFYxCZtvvX9-5MiDO-CUd2suY77JdrCiLkmkbeiVk08uQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] Documentation: edit awkward references to `git merge-recursive`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 6:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -355,8 +355,8 @@ See also INCOMPATIBLE OPTIONS below.
> >  -s <strategy>::
> >  --strategy=<strategy>::
> >       Use the given merge strategy.
> > -     If there is no `-s` option 'git merge-recursive' is used
> > -     instead.  This implies --merge.
> > +     If there is no `-s` option the `recursive` strategy is the
> > +     default. This implies --merge.
>
> We can depart from the original even more to make it shorter and
> more readable, I think.
>
>     Use the given merge strategy, instead of the default
>     `recursive`.  This implies `--merge`.
>
> But the above is readable enough already, so I'll queue it as-is.

I'm making multiple tweaks already for Eric and Dscho, so I'll include
this in the re-roll.
