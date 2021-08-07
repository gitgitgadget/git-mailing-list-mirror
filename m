Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C769CC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 16:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99ED660F02
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 16:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhHGQ3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhHGQ3l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 12:29:41 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7BC0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 09:29:23 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v24-20020a0568300918b02904f3d10c9742so9357908ott.4
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PlDFGXAy2bB/Lxg3Z+18dkEBqdYqO6hvIYzSipB48z8=;
        b=iojKmyWDL0ARiMHkTRCt/3vlp1xcNNw2Da+rd36PTjD/HcQapv73Uvk+Fo9Kw3cFT2
         1tXjILFD+YHzR2+l49ePv32LXnT8t0zvugfUfFipyqOXCLP7BnGQ5QivClV9E9cgzlwa
         cF73xXWZHA0f6DCaPeDWzwe1nN9D/JoLsbaAk8IgHB5AXofEnbXXhZigFyHVXCA52NJa
         1AzQq3ojCDjgWG0TNdeLxK/kqkAX42lid47c4hibW4DyMyPZYpiO4sbRD/d5PQwq8uh6
         h19afAYm+Oz6x7jFJWgGrleL8zWOfwoHECnSRqBf8TSAlrWg0Zeu3K1GaGkLtengxb5t
         Tjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PlDFGXAy2bB/Lxg3Z+18dkEBqdYqO6hvIYzSipB48z8=;
        b=bFVa1o3o1MbyywMkymbqqAF6VyGNSjknYcguA06KOUZjWhhb9MZ7Abn3dfwX0CBofF
         7GaQg1T/tHDMIPuK19TrNkvgCi/STcQNu4N0sU3/H5No4Cn4PiIj2SRaIL34BNDJ0KsK
         6i28X+PuEgki7OvScP4wdwL17yYcekP1NisV3pfgaTnhOhLdneWBVzL1eKRlsatH8TPD
         n6ssZOhuaRqHdHlAUFSkz+Z0PL0ljL4zS4LliN/jrVapdg9b2QI1Kidi3FHUYfJ2ymgZ
         eVFO2X8x1h3J+UcmJHA2AfbRrn4gTteE7x5XTaVhHENTkBa4lheJSvf+YjKIqdWtH3Fk
         U1fw==
X-Gm-Message-State: AOAM532N37Nt8sV1KD9zaLRc1jDEtXsu/tisokt2wWdYVTfmCEYaRX+c
        7rvZWcvaCK4rN0sAkBF6HblfwrOZnz4ZvCZeJwc=
X-Google-Smtp-Source: ABdhPJzOjz4X/kWA8Gup7fJB/47vSe9rP3fyBHWZRGAduYyGuX4cWF14DzrvDXIn9QQWi4BiFd9irVcBOUSMI7V8Hrk=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr11321391oti.316.1628353762589;
 Sat, 07 Aug 2021 09:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzgtuf6r0.fsf@gitster.g>
In-Reply-To: <xmqqzgtuf6r0.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 7 Aug 2021 10:29:11 -0600
Message-ID: <CABPp-BFOusrK6E6n91XSXcKP8kin-8RX8L_HXdKRjS790HkwHQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #03; Fri, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 6, 2021 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote:

> * jt/push-negotiation-fixes (2021-07-15) 3 commits
>  - fetch: die on invalid --negotiation-tip hash
>  - send-pack: fix push nego. when remote has refs
>  - send-pack: fix push.negotiate with remote helper
>
>  Bugfix for common ancestor negotiation recently introduced in "git
>  push" codepath.
>
>  Needs review.

I decided to take a look.  It appears both Emily and =C3=86var have
reviewed previously.  =C3=86var brought up some comments on v2 of patch 2,
but Jonathan responded to them all (and Peff chimed in as well), and
there has been no further response from =C3=86var leaving the impression to
me that Jonathan has replied to all feedback.

I'm not at all familiar with the protocol areas of the code, but I
tried to read over the patches too.  I think it'd have been a bit
easier to understand for someone unfamiliar with this area if there
were separate patches that introduced test_expect_failure showing the
particular failures being fixed, followed by fixes in subsequent
patches.  I also noticed a stray newline removal in patch 2.  Those
are pretty minor issues, though, and I didn't spot anything
substantial.
