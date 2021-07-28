Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EECC4320A
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139296101C
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 16:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhG1QeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 12:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhG1QeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 12:34:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49373C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 09:34:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e21so3352513pla.5
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWqjt/awGr7dpHnms1Va4rMr5rXfhs4Reyu6r0bCTlw=;
        b=NKEgKuU1CSI81oT9nsiNRKIeMvFfNIdEfYWZOt4l5FT2oOKwOjs5N7x/InjB2PvEnG
         2E+WRontE775cRZYnTjcEGbQFqH4FXR0hIRUDVU5k+6kf2IsaOWpfWO9qoOjw7eJYcyY
         1B5n/X4HNJy6AVpHIbl4cATDqBTzlDjPHBADt2aYrZUKVo8B7HIdmAjCoOYnh8WO4BoX
         dhRyjl33Dr4Ow6eMlBcMPajOoHUBOOntg8797hjLr0+hHeSsruOKn6yj8y0l6wngPpda
         t+as8Jxvksykvbd6DKaPAt3f+qKZ5z8ZegTx6cgzz/lC9MXR/opoyTFlEd9gnGnNv+1o
         IlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWqjt/awGr7dpHnms1Va4rMr5rXfhs4Reyu6r0bCTlw=;
        b=qFf/hbbzjA42AU8HUGK+KSdOgtNC1OnhheR1teWNug7W1crExyL05ALx0SqQa7KLXU
         Dp/zMOhFKtRsXKYiKzgmz3shk0FJUiHlMUCMXX6l4gdWVJjGTUuP2OExSDbVkrqv8O6k
         hd2nZBj5TNyIOllqfJkGWIVcr2ZjoTd3yrhlJUEEs9Clel7FigAsb3CRmtxdTCo7H2su
         lgFTpuBPBC6CSaIpB59dGfXqRpNs59LL1aYAXQARdRU4S4oc6AiBi0+c9QVYMoWWSFKi
         OvuBwaFxdUXc/2T6g0osAoXJrg1v8/LJQ3mibh7ttpQ8gUjogc/cvYbr3fvd56j3pyWM
         sdgg==
X-Gm-Message-State: AOAM533mQTqZFZ1/jfdKOromZxIYNWZF0Z0Pn3SzlkSUehySo22PWOSq
        ccWGC5dRmPKNhN9PB4jnSA/jYQzm3vXOsjGGJ0JelELO
X-Google-Smtp-Source: ABdhPJx2Kt2AP2EmVArohlOTqXN5pfb78emqRbhdBdxohOTaXXO/Sc3fi/C9CmiW6SHHFZaGtXLxlP1Q6QOgtw6oxcU=
X-Received: by 2002:a63:6784:: with SMTP id b126mr588147pgc.421.1627490045819;
 Wed, 28 Jul 2021 09:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
In-Reply-To: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
From:   Daniel Knittl-Frank <knittl89@googlemail.com>
Date:   Wed, 28 Jul 2021 18:33:54 +0200
Message-ID: <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
Subject: Re: Using two-dot range notation in `git rebase`?
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

    git log upstream..HEAD

gives you all commits reachable from "HEAD", but not reachable from
"upstream". If you want to rebase this range and copy it onto newbase,
you'd run

    git rebase --onto newbase upstream

This will take the commits upstream..HEAD (the HEAD argument is
implicit), and you end up with

    newbase-.....-HEAD

containing all commits from (the previous) "HEAD" up to (but
excluding) "upstream". If "newbase" and "upstream" are identical, the
command can be simplified to `git rebase newbase`.

Maybe I'm misunderstanding the problem? Can you give an example of
`git rebase --onto newbase upstream branch` not working as expected?

Regards
Daniel

On Wed, Jul 28, 2021 at 5:38 PM Philip Oakley <philipoakley@iee.email> wrote:
>
> Is there a reasonable way to use the two-dot range notation in git
> rebase, particularly in an  --onto situation?
>
> In my case I have a short series that depends on both some existing Git
> for Windows (GfW) patches (`main` branch), and some patches now in
> `git/master`. I'm now able to rebase it onto the GfW `shears/master`
> branch which contains both sets of patches (and one that was in the last
> git release).
>
> It felt that it ought to be possible to use a simple two dot range to
> extract my series, rather than identifying the individual end points in
> a similar manner to that used in the description"set of commits .. shown
> by `git log <upstream>..HEAD`".
>
> Or is this something that could be a project?
> --
>
> Philip
>
>


-- 
typed with http://neo-layout.org
