Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6E2C433EF
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FB061A10
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhJCMXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 08:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCMXF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 08:23:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD22C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 05:21:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m21so13880069pgu.13
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=zkshK63+LeOuqi/kT3qLs1DX5+mDno+wMAVNJTjd2oQ=;
        b=XiRZX7jC/Kek5ZcFrXYI8gDLKk4ojQpSdeJjApbqlxF85xB8Yi65Y07v1HQIB92QDx
         Jo+VnCg8XJjdncSIC0zlko+xt/UNp64YODqIoia0zzd3pUlcLQ8D7fnaVUxURZeHNKtH
         H1T0rorNjKgTCCL860w/YC5BzyRwrdkaRJdIUE45ZSVLvPdpOWcQtglfSTcZF+wWk8ro
         6poElEcKOeR9Vei7yxzbPJ6frUG8Gy8sjhzOIQ1QwrEb5NW6DuxcHmmaMIB1YJqKRO7f
         +DwXLW+2099qpO0R8Gokn/FXk4qQ1FPEaRbXTN/is40z2/4GzgBL5GC/0kV8Xc1GW6yf
         boCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=zkshK63+LeOuqi/kT3qLs1DX5+mDno+wMAVNJTjd2oQ=;
        b=Ug/UrAIZMf2qTkdJYSeraTs98jO68Z+LW7ure6lr/s410FBYqdRvtI6H8oxfR2mab7
         lj6gK1yV6YpzYRpWForrXXpVI/Jo4Ace0+HrN0AymnPe0WO2IRdmqiHg5oYAxJpyr+XH
         cPlcu2ODJWanv+2GJ34r4q4oP+6EJ+zq9xHqzDZRY5rsINHNpCk+HgrFuBTXmwO2F20b
         smF3KWftkrRMCnUNtd8ul6uxVi+6QfMFaNUVpt+htJQLkfx+qLrBFbH30UO5ZcnHx3xq
         fg3qTpa5m66SIQtmpdlyfn0sU4P54gqOoe2pbShiONypm5I+MvU/wl/nab91XJCBe0dv
         fY7w==
X-Gm-Message-State: AOAM532eOzHH8FweBwZZ6R1h69h7HqKX5tqnXpE/TqNv2PezgbZxfGLd
        NNOxabw0qAr8bG/1sFjGG28=
X-Google-Smtp-Source: ABdhPJygMPuejs93BMYrSnqJYxaAI9m8cQ5bL92rR1LV0gK3Ye8T32U3sM4FpU3sC0AmN8lio7/tEA==
X-Received: by 2002:a63:950f:: with SMTP id p15mr6459674pgd.265.1633263677696;
        Sun, 03 Oct 2021 05:21:17 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.146])
        by smtp.gmail.com with ESMTPSA id f33sm3744213pjk.42.2021.10.03.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 05:21:17 -0700 (PDT)
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
 <20210916103241.62376-6-raykar.ath@gmail.com> <xmqqk0jbcgqy.fsf@gitster.g>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v2 5/8] submodule: move core cmd_update() logic to C
Date:   Sun, 03 Oct 2021 16:08:37 +0530
In-reply-to: <xmqqk0jbcgqy.fsf@gitster.g>
Message-ID: <m2mtnqi9jj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:
>
> It seems that this step does too many things in one step and makes
> it harder than necessary for readers to understand what is going on.
>
> For example, as far as I can see, the change to optionally allow
> passing superprefix to init_submodule() can be made without anything
> else in this step (i.e. "we allow superprefix from the parameter to
> override what get_super_prefix() would give us, but at this step,
> everybody passes NULL and the behaviour is unchanged" would be one
> such step), later to be followed by a change that involves passing a
> non-NULL value there, and it would become a lot easier to see who
> passes a non-NULL super prefix, what value is passed and for what
> purpose, with such an organization.
>
> A 650+ lines single patch like this buries the details and forces
> the readers to disect them out.  The change that teaches
> run_update_command() to instead use capture_command() and gives the
> error message to its callers may be another example of what may be
> better done as an independent step before tying the whole thing
> together.
>
> It is larger than what I comfortably can spend my time on while
> tending patches from other topics, so I'll skip reviewing this step
> for now.
>
> Thanks.

Understood. Apologies for the lack of updates on this topic, I will work
on organising this patch (and this series) better. I've taken a note of
the conflicts with other topics as well.

I don't mind the other topics being prioritized over this one. At the
moment I am not too confident about being able to quickly iterate over
this series. I'll try my best anyway.
