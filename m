Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273C8C433E6
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E978322512
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgLWX4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 18:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgLWX4x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 18:56:53 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FE1C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:56:13 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n42so524670ota.12
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0etxNN3HorBPdkdjRbKVnFrDqzTQ81SckVkHLNBN0zU=;
        b=m0Tw7Ud00GLzfzgPK8KNH3t+hhST0EFSJFmFw5tOJQehRbtBIW7zudNrp8I7SctTWw
         7HV6DAdSpwpueD4fU+xu7N1bAbxk3yvZcsQtyHYK67hHRgA3Phx0dosb3ksaDvBSIvcU
         /dxTOws6Vl2MenRgeBoBAdCzWNSoo6/i1CNw4O6s9bJQVa68pDplPplFzWMbuqhl5lwI
         GyXjlA3MprT+o5Ntr4c3epEZ5uiBeJ3wThn6U3Fa0TboZefcL+p+B4tq+BfZvGdeGks9
         d8vbzl3ImJwLQU9KfVoW4TklE+BqXCnqHai4dztOOxz/zNUMx+LFnI+1bemlZoL8WS+S
         xZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0etxNN3HorBPdkdjRbKVnFrDqzTQ81SckVkHLNBN0zU=;
        b=jEXHUaU6936uSjDkIn6TpqTTHy/R8cdSk62xfYEy3yMdWed0psFyS050DjSQiddZ1v
         nIS2W5TPDLOxSsA2LjA+3+rHmzlVjkuvAE9xx6zLtTKnGLDk8mk6tMN169b1LoxNfvTQ
         TPQ1kdLzsfoIiEsisuZS7zzg4l2ZjxwraIJu1kOYycZaEFNR9qrMQMZC0ns7xmLQnVAM
         s0IhgjcunHvzGjkOhfkV0ReyUwYHYOpFgbCckfAb1hX6TsxYQy+M4zsR8yCry97Yf0Dg
         ULjURq++I1F8AcZ5o/frYKs02kkADAW++B4w52E65IpJxHku8a10iajLNnBOj2rVQzUf
         2Hzg==
X-Gm-Message-State: AOAM5334BV16VaDp4uuvfLD4iLDpDRmGIw07xrkKwd4zmty+DBSvUc4n
        LNudfsz5z8VApC3OxGfNTORT9xYHrY/m3G23Mqs=
X-Google-Smtp-Source: ABdhPJymxZ+P2vDAtsZvgT8gmYha389UXtqMaSnztqVj1Q34hd3dsIf4BPsNQZHAHi9ZkebwIwl35uB/tZoef+OVmic=
X-Received: by 2002:a9d:6642:: with SMTP id q2mr21009646otm.172.1608767771948;
 Wed, 23 Dec 2020 15:56:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
 <pull.820.v5.git.1608609498.gitgitgadget@gmail.com> <xmqq1rfijpyf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rfijpyf.fsf@gitster.c.googlers.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Wed, 23 Dec 2020 23:56:01 +0000
Message-ID: <CAN8Z4-VQJsXWmJPNg0Fdu98csK7ZQ0yDNzxPqRhsbuw9CUJjnw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] negative-refspec: fix segfault on : refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is this something we want to merge into the 2.29 maint branch?
It is a segfault for anyone pushing with matching refspecs on 2.29
At what point does git stop patching bugs in the maint branch?

--Nipunn


--Nipunn

On Tue, Dec 22, 2020 at 6:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Update since Patch series V4
> >
> >  * Squashed in Junio's patch to handle non-master named branches
> >  * Explicitly use test_unconfig
> >
> > Appreciate the reviews from Junio and Eric! Happy Holidays!
> >
> > Nipunn Koorapati (2):
> >   negative-refspec: fix segfault on : refspec
> >   negative-refspec: improve comment on query_matches_negative_refspec
>
> Thanks, will replace.  Happy holidays to you, too.
