Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA6C433DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 05:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A2E20729
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 05:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwfmXtX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHIFes (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 01:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHIFes (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 01:34:48 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AE0C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 22:34:48 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a65so4782516otc.8
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 22:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++wUam+t84b7hab/pgsLqwpRKE2N63KBjIaFEkq0APM=;
        b=OwfmXtX806jRH11cQJUouK74QF8Iwj6+2x9t8ZL5TeyVo/yrwzd1KTcNc/gUfQn57G
         aMlptcZFXirDhoKxDdOGopmuDuQfvgnSJeMbjHawS6rRr9r0NaKkjZMHavRSCePUtNP1
         TXW4AJ6UI1b5na2LNaIgAvbv2gdtLgIA3D9BzAU5fN/llGuLejJbTZ4MO+hRJmbZp0+Q
         alElHtGVWPGNPYToHoF0pEFv1r+XCoGlqJWJ9Bzhxd1/XZ4fGf1cO7b8qFf5HNGcM4EN
         7lckpVuBq+X5ibBUzudwn/pj2kqjhEyyw3agUek3+zNe1edbrXKjtdZVXuAvq/0YT1m4
         fyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++wUam+t84b7hab/pgsLqwpRKE2N63KBjIaFEkq0APM=;
        b=o2igVAvo7veSnVLIPyaaCabndqhPXuwlbVkNcIxeYjEdEzrga+ZfvJi57klWBGm6fs
         baWB1fxgd2h5zAM80S+iTGrFDJZZSgHm7s7UUUONfPOKfEfnKJOYHXmVBdHLv8kBTNTN
         2MzTQjK5lQp0hFXWRj8PccG9IuyUM0wjjEASCmM9CVkhNxyxf4wylNrBpOcKz512WGtB
         N4Ksd7odFpWjVdZZUKA4+/piRbdHAeQXIC6E6MJmGT9fEhBU0Jo6RJ2AcnmH3BAThrJJ
         T7pA+jDyUeXjfzGwfIRsp8u+QS5Ln6GQzvj3QJRSfqLVXd5q53U2xLww0u13GrQIwWs1
         4RIw==
X-Gm-Message-State: AOAM533C63dAKyIPVZyNjFh6Lp40tGOS+32wKeVOXL75121otD7DGXI9
        ytt3XTV1IP/FgP0FTE+BFUBjAsZU+nc25tmMoy0=
X-Google-Smtp-Source: ABdhPJy19pTQ8P79ZYm6aCl1hwGVIzobj4lKL6czwSwx60mQTL4a8tgAVUME9KJF7w4AytSDsYwAjWJc9xQt5yqW/Nk=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr19047548otn.162.1596951287662;
 Sat, 08 Aug 2020 22:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
 <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com> <9ce80f2f943278fcb8ef46fd1a9507d832657246.1596906081.git.gitgitgadget@gmail.com>
 <CAPig+cTgYv+UJauyL_o5AeYeCS=aKi_PS4VZ0Q6yH7bZk+Vg=w@mail.gmail.com>
In-Reply-To: <CAPig+cTgYv+UJauyL_o5AeYeCS=aKi_PS4VZ0Q6yH7bZk+Vg=w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 Aug 2020 22:34:36 -0700
Message-ID: <CABPp-BGJwFKKrmVG_oV3Q7nNY_7mcqC9BZBsPSGosNiW+0mkTA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] t6416, t6422: fix incorrect untracked file count
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 8, 2020 at 8:12 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, Aug 8, 2020 at 1:01 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Apparently I don't know how to count untracked files, and since the tests
> > in question were marked as test_expect_failure, no one every noticed it
> > until know.  Correct the count, as these tests clearly creates three
> > untracked files ('out', 'err', and 'file_count').
>
> s/every/ever/
> s/know/now/
> s/creates/create/

Wow, that's a pretty high typo density; how embarrassing.  Thanks for
pointing out the fixes; I'll include them in the next reroll.
