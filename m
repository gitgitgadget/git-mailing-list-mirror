Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B7C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478F464F10
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 08:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhCDImF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 03:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhCDIlv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 03:41:51 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B83C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 00:41:10 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o10so18469282pgg.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 00:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mt9HmswZpV94PFHin0kCn2EId1OftXzYwEyi8sX+Oys=;
        b=nI9LQ61oUlayc1GkpYvbs2dbfTj0HIqabxyeoPoeQrP8/3S9w5B5EVi/vdIlocSh/z
         ChXYbecn9UdvQ4+jp0CdfHLRxazxbgxo0yW4zj1C7lB9VDOIbS6+WdNkMLc55vEjDfA2
         EkgrmIY3e0jf3v9g1iUUEcKT7oEQ6PBYqnqBve5C+mEGU28DhCTvRwWfyA0AWsxxDL0P
         JWKFqZiw/JSdqcsmsExiV78hpxLjUANAV4TgpkjyEtg/agsHMnjKkK5kiuPN3DCc17Ya
         7geJYyRaPX7s94oJsawg7spEC5sEz7i1/FU6jWFHxiMaA3Y6RU4OkvJY+QTet0oaag+T
         X5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mt9HmswZpV94PFHin0kCn2EId1OftXzYwEyi8sX+Oys=;
        b=cfIGj3Sz2cJR2hhsuS+bRVB/N9sJfo9wKj+yJlqqkjOJYXDKm8fg2MHNriATnHgnkb
         0FLH0riKa4gCeYLqH4VRDt2txKtzJrqRBjVLn6foV6xHcp98vo82+skXxCHQBb4k6ZYn
         AG/DBMsdg+J1RT4+wl6PTcEreX7+YeklSztmXKC2G8ICniR8JGm2HNGXAYlwVsgYw5mp
         Brw4w213VEOsfP5PZ1hxanQdZrWBJdsDdv5dAy0e9ld0juqDri30dPEZPIpix2UCCXxA
         5RdLx4iDromxzRHm7Ll4V4qXu2NqMyRjElhBsPMpi/eB3HPSyhXwLCcDzfO/YsvBaFnR
         cBcg==
X-Gm-Message-State: AOAM530pa3JOIneFNL0w4+NUXr1TrC9lxS9LkJYXSyl/cYaqaUaFYuMb
        JbF2Mgk3qN5WFSwnpG9ofe4=
X-Google-Smtp-Source: ABdhPJwxSO/SVE9O4oSjVu5EdA/kTCfhbwkVAdlJvMwrVLglb3JUJSc9AB5KRTW/OS36TVF9YpIlJQ==
X-Received: by 2002:aa7:80c6:0:b029:1b6:92ae:a199 with SMTP id a6-20020aa780c60000b02901b692aea199mr2732175pfn.71.1614847270062;
        Thu, 04 Mar 2021 00:41:10 -0800 (PST)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id z4sm25995414pgv.73.2021.03.04.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 00:41:09 -0800 (PST)
Date:   Thu, 4 Mar 2021 00:41:06 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] format-patch: allow a non-integral version numbers
Message-ID: <YECdIhDKZY2y+msX@generichostname>
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
 <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com>
 <YD9Qv/sTDmOE9jlq@generichostname>
 <xmqqpn0fg2ls.fsf@gitster.c.googlers.com>
 <CAOLTT8RdXC+KQNupU1TQdPh-tQO+syd6WJe85GzieE3uWt2ibA@mail.gmail.com>
 <CAPig+cTncEC4njnu+FB9tKwu20xi_UuL4TWW3_zD3drD3fyrHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTncEC4njnu+FB9tKwu20xi_UuL4TWW3_zD3drD3fyrHw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, Mar 03, 2021 at 10:27:25PM -0500, Eric Sunshine wrote:
> I'm not outright opposed to supporting non-numeric, non-integer
> reroll-counts, but I also don't see a big need for it. As mentioned
> earlier, Denton is the only person I recall who sends fractional
> re-rolls, so it's not obvious that there is a big advantage to adding
> such support and complicating the code just for one person.

Although it is quite rare, I'm definitely not the only one who's done
it. A cursory search on the list reveals a few examples from people
other than me:

* https://lore.kernel.org/git/20180308224458.5730-1-szeder.dev@gmail.com/
* https://lore.kernel.org/git/20190706162114.21169-1-szeder.dev@gmail.com/
* https://lore.kernel.org/git/20180225134015.26964-1-szeder.dev@gmail.com/
* https://lore.kernel.org/git/1435350166-7122-1-git-send-email-Matthieu.Moy@imag.fr/
* https://lore.kernel.org/git/574DED66.6050008@web.de/
