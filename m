Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD169C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiG1Xep (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiG1Xeb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:34:31 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02387AB31
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:34:04 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z5so3857009yba.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiP2+3vMDL2IafwUAq/I2WKq11//Qn9F3y0OxMwfQvY=;
        b=qyqDwuo8AnTZnPvQ1N6vHFWtsYMe2+Hlu+SmREWKlxBhj+73s4W6Q6UNnMI2nwLuIa
         VSmzjqX3eV+0IMZdyMZA4p3YQ/2Iq1NdmtTefQZDPXFM6aiCKg5RzcwBypmMxK/RoBrR
         6759wawpgTDh9HDHqh/4r89GynQKIbECiwH5Jmi9fjaCLbfV3vUMQcCcIs6J7AMGfPC6
         TF8gy1hYuIvrHHV1TS1TpNdJ4tXTwnkADOb3fO6mFPhGSWME789E6y+CoOCkJu21tFdq
         Rgm713fj6PKMqUtpQOff4+liUcuZheClbg4zFWP+4sD/GzLLtywWV5IZ9YjtsvXWbchl
         tIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiP2+3vMDL2IafwUAq/I2WKq11//Qn9F3y0OxMwfQvY=;
        b=z4FBwe46mz3MjRs6sH+KQ3pIbZNHi5Q85zCesWD2dIryqiPv8yah1mNHZ/7a0qr3CN
         PchQhGMDJwnDfcUN0/jm/dRVgmnpF5PQr+sqPnBL9vnb9hfiXnoNPqeNuwUKtqG8rnz9
         krRsZoHCQNM80CPoJV/dB1NoPA6dn5C+vXBHoxoiIHSNx1zZbQvZbZpgNPvAI8GaAyJ5
         u4EG/ptZObehZltBUb9joGj+6eGSFzpVt6Dl5MaHEi6fngFZtNzPybfOaX6JMXv4vCAG
         39b2ql7E4wH3nOZ71STZrApiD9ZuUUW5R8ErpmddIRWNWBS1w7J7C0Pkm1p1C0CmQsei
         xAkA==
X-Gm-Message-State: ACgBeo0AJOBC76K9SkjefpDatMoXt4HTJn8XJGD9P87Wv561NGIxVK+J
        8boMusZmyJ75oxPFahck/9nPFugd43WOu3NqhqL7EFwP
X-Google-Smtp-Source: AA6agR5SGAWbV9Q221wnpyX1jzf3RxIyKCzILVR2AfAcyeq8g3DIKnvjaf1Z5+01u2Qh6lhkeR2osw0fhCkYAZOVHrY=
X-Received: by 2002:a25:6ed5:0:b0:669:8b84:bb57 with SMTP id
 j204-20020a256ed5000000b006698b84bb57mr709532ybc.227.1659051244013; Thu, 28
 Jul 2022 16:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
 <xmqq35ems49j.fsf@gitster.g> <CAGTqyRzfeh4HLbXUCb3Zv=bWNoBmvBU5QB=N2g2d0=y+NEToag@mail.gmail.com>
 <xmqqpmhpb08p.fsf@gitster.g>
In-Reply-To: <xmqqpmhpb08p.fsf@gitster.g>
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Thu, 28 Jul 2022 19:33:28 -0400
Message-ID: <CAGTqyRxTF=7PYCZm=xynQc2v55v-iim5iut9GxgT66E-Sqpiqg@mail.gmail.com>
Subject: Re: [PATCH] git-prompt: show 'CONFLICT' indicator at command prompt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 28, 2022 at 1:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Justin Donnelly <justinrdonnelly@gmail.com> writes:
>
> >> It is unusual to subject our unsuspecting users to new features in a
> >> way that is done by this patch.  A more usual practice, I think, is
> >> to tell the users that they can set GIT_PS1_INCLUDECONFLICTSTATE to
> >> "yes" if they want to opt in, and trigger the new feature only to
> >> them.  Later, we may decide that the feature is useful and widely
> >> apprlicable enough, at which time it may be turned on by default and
> >> tell the users to set GIT_PS1_INCLUDECONFLICTSTATE to "no" if they
> >> do not want to see it.  But one step at a time.
> >>
> >
> > I see that most of the state indicators are disabled by default, so it
> > makes sense to be consistent. Should I make a variable with 'yes'/'no'
> > values, or set/unset? 'yes'/'no' has the benefit that if the default
> > is later changed, existing setups will continue to work. Set/unset
> > makes it harder to change the default later ...
>
> As you said, "an environment variable that is set triggers the
> feature" is harder to transition.  Starting from a clear Boolean is
> probably easy to see what is going on, and that is why I suggested
> doing that way.
>
> Ones that are "if set, enabled" can be corrected later when needed,
> e.g. GIT_PS1_FROTZ may enable the feature FROTZ when the environment
> is set, but when we introduce two or more ways to do FROTZ thing
> (e.g. in addition to always do FROTZ, which may be the original
> design of "an environment that is set triggers the feature", we may
> add "automatically enable FROTZ only under this and that
> condition"), we may say "when set to 'auto', do the auto-FROTZ, and
> when set to 'yes', do FROTZ as we have always done.  When set to any
> other value, warn and then do FROTZ").  But let's leave them outside
> the scope of the topic.
>

Thanks. I'll incorporate these suggestions into a re-roll.
