Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B25C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424CC20657
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4Sm2ium"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391880AbgJPSch (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391877AbgJPScK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 14:32:10 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930FBC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 11:32:10 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id de3so1488616qvb.5
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WrYoIHeFBNpbP+v3hntg0DZX9sB2N3YqgRDDxPICiI=;
        b=J4Sm2ium9Ko/qfNYfBiSFtLGLzi5d6qf7KssvAlnr7m1QKLZO+MTfnPAvEKgkU65V1
         WpQG7BKyo+KF12CS/NZxuq+ITWQEIeEIoStF93MawYOwPu9KRdlUsPA92B0mfXPNeEgJ
         zjIxxXbWg4GoM8Da9ATxhZ/pEfDYX5lrknVVjCwTNI3oVpE3sQN84HkiayJKsLgKS0AU
         rPJvUkgm1QKJM7VfpB+4LlPHDPpR79XMZdAJRbvL0t14lHkjxAtMhFTprpi/QI2Tea54
         SuqsE2UlrtSDD5zkJvobUKLD5dnM3qgxZ3co9wVkvSXKKJePsaMT9HPXg6hw9+aSWqgS
         VUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WrYoIHeFBNpbP+v3hntg0DZX9sB2N3YqgRDDxPICiI=;
        b=uYu9C5jPCnkrek+DzD2LJonnK67Hx0DTRGi1WsV+lKO5t9Dmyc7WNuLlILxqgjFYI5
         so8OschJ95kb699YrcEfIK3W/57+ZQPG1di4uRPdarDOJ+ZA9qvs+G3NF/lX3As/j+uE
         gi1i7Xm4KBOLd8hgyAh5/9j4mlprCDh4Cn/Sh/7bojH2L3rjXM9kmxOPr4TTIDBl6YwE
         gEGThxRFsBtEYJL1LV7ZVS4LT1cpTZ+cThK/HQjTRfnRiYB31vPV7IAvxpP8exnF1GX0
         rcitaSUiyJcXLxyrHPQ6spMhPdsMMYaMNsEkyjPcX0nmUDpYsJdJfrc/VmOr6ppXxwNw
         +8Jg==
X-Gm-Message-State: AOAM532jVnxOOWGUJAN8mNOsfnlePj/WUFwSvqFbt/HzlLq2oerrP2ES
        ygI+pAWqpPyKF0IP/BRS9GkUwOsSxreJw5p+NAl/sZ36Hy4=
X-Google-Smtp-Source: ABdhPJxXAAzjV1feK50ZoBz9vjvXGjyNLVks9d1uimnsCsuRlJ3codJraV0DMm+w4q9uiRXvyal9HoUw8KiaKsZh4YU=
X-Received: by 2002:a0c:a601:: with SMTP id s1mr5263576qva.57.1602873129052;
 Fri, 16 Oct 2020 11:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAES5DXRFu7yaM3TggA7p9Yot-E2O1SmpmT+B6ddZmHgRmCmuNw@mail.gmail.com>
In-Reply-To: <CAES5DXRFu7yaM3TggA7p9Yot-E2O1SmpmT+B6ddZmHgRmCmuNw@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 16 Oct 2020 11:31:57 -0700
Message-ID: <CAJoAoZkQkemd4Zp7Qmnn7f++KjAa8_h=VgMLNMUTNvckNLG85w@mail.gmail.com>
Subject: Re: [New, Outreachy] Introduction
To:     Caleb Tillman <caleb.tillman@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 11:16 AM Caleb Tillman <caleb.tillman@gmail.com> wrote:
>
> Hi,
>
> I am an Outreachy applicant interested in open source development.
Welcome!

> I
> have started reading through docs for this project, and noticed that
> many of the tests in t/ that are marked as expected to succeed are
> failing.  Is this normal and to be expected, or is there I chance I
> messed something up in the build phase.

That shouldn't happen. It's possible you're missing a dependency or
something - if you post a paste link to some of the test failures in
IRC I'm sure we can help you figure out what's going on.

>
> Also, for my microproject I was considering replacing some of the
> calls to 'test' in t/ with their debug-friendly helper functions.
> There seem to still be a lot of files that would qualify. Is this
> particular microproject still desired?

Yes, that is still desired! Looking forward to the patch(es).

 - Emily
