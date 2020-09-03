Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34B5C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E719208FE
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQa2seNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgICTWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgICTWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 15:22:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD669C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 12:22:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x14so4369929wrl.12
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlPU40rLIAsbLr4pwMi32tlPn3eGsXje7jR0+FzH8J0=;
        b=CQa2seNaA/9DOH2fjU9mUokuEdm9bYqt/Z0J9gJFFlyOfW5qT+7RMq6ixa0KYuDdHO
         VR9NweqddFcf/hLM/vLaBgTaYpGT9dDAK729Lk4vU5TgxNJJICnKcSBjqf62CbjRCthS
         QKvSSKrHDQ9wzP+AVV2y8jh1Ewn+bzQS7FM0oxkdJM46pbMQQttT3uGXQYCFiD5MnsYP
         9K18dHvJhD2G+KgYwJdTwTHlr/ha0+rxKTx6v8m1MDBa7oPb6vSJNt+a12rfJYeMJN4a
         feco/qPvB05AMdvTRynWflegpaIW0FoRr+hJOu35/2bxTl4pAx+/Z7+lzcW15BqyFTBd
         fpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlPU40rLIAsbLr4pwMi32tlPn3eGsXje7jR0+FzH8J0=;
        b=cs2MPN2heA5OY1UmXv/Cm9PRlxqqk/81aZpGiZxm3qhthhq8e04k9q4ncZwmBpn8N7
         jtQAhIbEcb86sMFhn3DofiicZUUoibDsjw3nusGxgOL/a6lwirvYZqGdELdIoMYZLQ3E
         D2PoSdFAAyF8Z7rVW2lV2bSJwFzgpFvOjm8M0MOVs9j31OhgPxD6rmdbqkjAnPhbelR4
         LvfLqvvIMUFXO2eoEPuyElL6zQJ345daPgWxRhNd6tAjDd94dXLujoKEDnORzEQXikBd
         XvASogbxTh1j8XRlpIR9G5AcCYb8ZhSEyvEnCKCLDbmOB8fmhh7bMsr4ZuEbW29oo+0I
         AmGw==
X-Gm-Message-State: AOAM532cSO4/IN7wxGwbyv7ti34TFGIhLtP7fnS381MsSjBoJ3q2oFwZ
        82PSEoEZEEmNRMu1fzW4nko9om2LIi/A+Co4y/tjkqvn
X-Google-Smtp-Source: ABdhPJzo5WUvm3BY4wEEK6c/ZKm9v3okJW79Orgpiq/3RQ2e+ZF3TyfVBbwZNH+IsD4KNM/j5LR8+Etkqcri4kYu6fs=
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr3841372wrh.192.1599160955504;
 Thu, 03 Sep 2020 12:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
 <xmqqa6y6ah8h.fsf@gitster.c.googlers.com> <CAPUEspjKcQgLvVrJ2GroqYydNPksEziMgyceN-CFBFVgtngMuA@mail.gmail.com>
In-Reply-To: <CAPUEspjKcQgLvVrJ2GroqYydNPksEziMgyceN-CFBFVgtngMuA@mail.gmail.com>
From:   Victor Toni <victor.toni@gmail.com>
Date:   Thu, 3 Sep 2020 21:22:06 +0200
Message-ID: <CAG0OSgf9FsOpfOH+ErRTzMT333yDyZNthM8+7X3eRp=apRwJZg@mail.gmail.com>
Subject: Re: Aborting git rebase --edit-todo
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Now we have the "drop" verb, the latter interpretation becomes
> > possible without making it impossible for the user to express the
> > former.
>
> and for people that would like to enforce the use of the drop verb
> there is configuration that prevents deleted lines to "silently"
> dropping commits since 5a5445d878 (rebase-interactive: warn if commit
> is dropped with `rebase --edit-todo', 2020-01-28) :
>
>   rebase.missingCommitsCheck
>

Didn't know about that one, will add it right away to my .gitconfig. Thanks.

> AFAIK the correct "signal" to abort is to instruct your editor to exit
> with non zero (ex: in vi using <esc>:cq), but agree it could be
> confusing or "inconsistent" and might be worth adding it a message at
> the footer
>

This sounds easier than it might be. On some machines I have (Git for)
Windows and use a "regular" text editor which I guess I would have to
kill to make it exit in a way to be recognized by git.
Even when using Linux I never needed to make my editor exit with a non
zero code. From a coding perspective this might work, from a usability
perspective I really don't like it.

Victor
