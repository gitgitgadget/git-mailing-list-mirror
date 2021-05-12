Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8EC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915EA613F3
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhELI6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhELI6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 04:58:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527E0C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:57:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s20so28328315ejr.9
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KiMG8XftnpzS+GyvXsllkOtYjAkX0YDji4kIby5h9tI=;
        b=txeNjVcIYC26Dfs21rVyXqqHfUr+DImuUV+8D6hCeqv5wXWHhMYCZg8cuRy9eZL58f
         mfbEKf7RW1xF5c7Gr+qD6M+LasKlRDDlioIHG74jeL4vo+Ec1ILQH0hrwQ8EhzSHMeIx
         HCDbMTPzzx4qJTb5RIMG8UfQwW8ysEQjiIbF/g9h/Zr5KDTeIhSkdRcxxPQ5/VJf3sPI
         DNIBIPfBLcIajWRHVHwLAZd3EDqMhn/UkVkcVo2qYGLVdJrnV+zG8gMVoANzNdYEC6e6
         X4GIJZaY0YSsSezdWNFX5/Nkwp7lV/wg9+sFaGbm0Cfzu2KLhxQLi3kEPUr+E8/3grkQ
         ESuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KiMG8XftnpzS+GyvXsllkOtYjAkX0YDji4kIby5h9tI=;
        b=RfVO3VuduE0jeoKTvgsOxtXyktqfI78kFmJviHxEACumFwa/fPJyW/6emCVJ/2xSK5
         0WlPvfc58TTJ7HLrR2xvNaiqD8R8pY8IrSyrOB/dszGnaGayfDmckaQnLMjfYVOM5lF3
         dSNDdv2rRlR7h1nSZUjXTCU1rLjSfra4EquZKz5GoEjmE0rO/4Ge520Zpayt+ALF3Q42
         erctLtwUwM5pCBX1B89Be7yWDREciQm4M+J6wpPbs0jJvO8dS1FAy2yttOjwDuKDFR4P
         sGXd+nyjxHmJlYqmhIgccLUn/GwhBlhpwvchineYRktC1xBHepFG1TzeV303bmiPmTog
         ek4A==
X-Gm-Message-State: AOAM531srrvshhNG2zdnUPN2g8r7e2OovSV0trnAMtx5fqA3Zyp2C7a6
        eWpogYPoHQwSJqzna8PWHNI=
X-Google-Smtp-Source: ABdhPJxK6zojxx/lS8PvAirtfoCfzOYr/KkAetbWXaQEdmY6rvhXAFrQgyRGFRIiFCY2HHfVBhOdLA==
X-Received: by 2002:a17:906:2b0c:: with SMTP id a12mr36247282ejg.473.1620809846860;
        Wed, 12 May 2021 01:57:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o3sm17337975edr.84.2021.05.12.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:57:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        felipe.contreras@gmail.com, gitster@pobox.com, stefanmoch@mail.de
Subject: Re: [PATCH v2] Writing down mail list etiquette.
Date:   Wed, 12 May 2021 10:45:39 +0200
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-2-dwh@linuxprogrammer.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210512031821.6498-2-dwh@linuxprogrammer.org>
Message-ID: <871ractjm1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 11 2021, Dave Huseby wrote:

> After violating a few unspoken etiquette rules that were spotted by
> Christian Couder <christian.couder@gmail.com>, Filipe Contreras
> <felipe.contreras@gmail.com> suggested that somebody write a guide.
> Since I was the latest cause of this perenial discussion, I took it upon
> myself to learn from my mistakes and document the fixes.
>
> Thanks to Junio <gitster@pobox.com> for providing links to similar
> discussions in the past and Stefan Moch <stefanmoch@mail.de> for
> pointing out where the related documentation already existed in the
> tree.

Improvements in this area are most needed, so thanks for working on
this.

We should not have a new file describing this though, we already cover
the content you're adding here partially in
Documentation/SubmittingPatches, and some more in
Documentation/MyFirstContribution.txt (e.g. a passing mention of
in-reply-to etiquette), with this applied we'd have discussion of these
related topics in three places.

I had some rough WIP patches to update Documentation/SubmittingPatches
to address some of what you're adding here, which I've discarded, but I
submitted some related patches just now as [1].

As you can see from that topic we e.g. already have MUA-specific tips in
Documentation/SubmittingPatches, your addition of a section discussing
mutt's config here is another thing we'd be duplicating/unnecessarily
splitting across multiple places.

I do think it's going to be hard to update SubmittingPatches, for
example it has a long section going on about the specific format of
patches to craft for the ML, as if anyone's using anything other than
git-format-patch these days (it was written before that existed/was as
established).

I suspect though that any suggestion to simply remove most/all of that
for simplicity will probably be met with (IMO unwarranted resistance),
which is why I gave up on this the other day before even submitting
patches to the ML.

But regardless of that, the post-image after your patch of having
another place we discuss the same/related topic would be worse, we
really should have one canonical guide, so your patch(es) should be
amending/splitting Documentation/SubmittingPatches, not duplicating it.

1. https://lore.kernel.org/git/cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com/
