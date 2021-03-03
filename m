Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E3AC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53ED964EC4
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355255AbhCDAXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378493AbhCCTXh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 14:23:37 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC198C061764
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 11:22:55 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id f3so27204814oiw.13
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 11:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjIt7Cn8vKXBJZPTnmvcy+GzTCkOUDqbLYq6Rsq9HxY=;
        b=h7GFxx1fz3iIqiEhIxr7PZ83jsikAo7TOtb8o3of5OYw+p06NY5UgEZY1qNhPMVJQv
         NGknw79q/R4BO3NsjjtZT9BSPVFBS3E5/fpJj+icoy1+3HbSQMjgOHPsG/d1Eccl7AXC
         vmfPwiPDEXniZOGPuJ4wUvXZYnLVgGjXmi/v5YqKT67VvBqKD98A72uIKWhtV0II3lLB
         GVsBsBq1J9B0muSQtU9yc+qAPBNAM3kyJmba6LU8uAZ/5h//lwVGINSLzkWhqWHNqqn3
         W8hhvEPNKvXLcqM8EVIxoBQn1OdFjKkChqDv8snV9r8qu0FkFKGJ3382qlFkriBZIMUY
         V+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjIt7Cn8vKXBJZPTnmvcy+GzTCkOUDqbLYq6Rsq9HxY=;
        b=EFo++4SE//O7ESa5KLweC2o1dposTfgMG3gUjIF88I3861n6MGjNjIqgjGgZlMqfQr
         ZTLLFfyJzeALFxNSLtMxyOSzkqI1nAKWyAVUQ65krAIj7BVAleGMkgeTMrah1brup3re
         6JPr0YKE6Lcan9YoONoCr4uTjNzgTPp/XM5qdrbZYq2ao17VCv89yRvMaphkaUn5776o
         dXLIG0+azIfdHSxhj4ic7bn7ZnGLUO3W6de92uiMaSviq+T1ml7sVQj+vmxIlVvbIKFW
         DoOWukU6BVsBlypr88Sho60P1tAxSiXatlH9zithil69p2oSUL1dAesj1aqWXt3jiFje
         zdmA==
X-Gm-Message-State: AOAM531htooE6lrmM29mp3D9+gKorPO31Kip7PIh0Z/29g5mKEjYKq9w
        +GfEo+tfSAI86VGsxMHkODu1Pjk1lqSV40DmuQY=
X-Google-Smtp-Source: ABdhPJyB0De6NSLFkTBqiMTT/MplbAIfR2YaV+R9ewK6fvxmzodn7tT3aq3sCAjpObyveltrGOfMvhrErNAmahR5u4I=
X-Received: by 2002:aca:3285:: with SMTP id y127mr302939oiy.98.1614799375367;
 Wed, 03 Mar 2021 11:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-7-charvi077@gmail.com>
 <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
 <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com> <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
In-Reply-To: <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 4 Mar 2021 00:52:44 +0530
Message-ID: <CAPSFM5eF1c5--8nqiDQ0ZLwz7cnNxx_BahPHGCvqbnrYKkCf9A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 3 Mar 2021 at 13:48, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
[...]
> By the way, now that you explained in the other thread that "short"
> prefix-matching of "amend" and "reword" are allowed, I realize that
> the documentation doesn't mention it (or at least I don't remember
> reading it).
>

Yes, I admit it was not included. I will add it too.

> (Nevertheless, I still feel uncomfortable about supporting short
> prefix-matching in the initial implementation without any evidence
> that users will demand it, since we can't change that decision once
> it's in the hands of users.)
>

I am not sure about strong evidence but I tried to keep the major
points discussed earlier, as mentioned in the previous thread. Also I
think otherwise the short prefix will ease out / shorten the command
to prepare the "amend!" and also mirrors the commands in interactive
rebase.

> > > > +       When the commit log message begins with "squash! ..." (or "fixup! ..."
> > > > +       or "amend! ..."), and there is already a commit in the todo list that
> > >
> > > Should this also be mentioning `reword!`?
> >
> > No, as both `amend` and `reword` suboptions create "amend!" commit
> > only. I think it seems a bit confusing but I will try another attempt
> > to reword the document.
>
> Hmm, I see. So "reword!" is really just an "amend!" with only commit
> message but no patch content. That makes perfect sense from an
> implementation standpoint, but it makes me wonder if it would be
> easier for users to understand if it created a "reword!" commit which
> would be recognized as an alias of "amend!". (But maybe that's getting
> too confusing, and my musing should be ignored.)
>

Yes, we didn't choose to make "reword!" commit because if we do so
then again it would be expected to implicitly change 'pick' command to
'reword' in sequencer/ rebase to-do list when combined with 'git
rebase -- autosquash'. But here we are changing 'pick' to ' fixup -C'
to fulfill the working. So, we decided to create a variant of
'--fixup' and serve it as "amend!" commit.

> This also answers an unasked question I had regarding the duplicate
> "amend! amend!" check. I was wondering why it wasn't also checking for
> "reword! reword!".

Yes, it's true.

Thanks for the reveiws, I will add the above mentioned changes too.

Thanks and Regards,
Charvi
