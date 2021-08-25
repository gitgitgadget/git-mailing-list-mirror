Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74950C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BC26112D
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbhHYPzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbhHYPzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 11:55:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE4C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 08:54:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m26so133974pff.3
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AX0U4vkAJIIuyBuIgDHjjt3ZViD9OZx8sECDADsitKA=;
        b=r00ffDPF/ezgi8kAOMcwnOIxQP0XWY0b7rWiGY1wYI/E9YjZzoFeblxDRST373p7aU
         Py5/FrjFMq6nc9kPYm904b+sG+xYDlxy9jW4WPXRTvQZE0IMsqSkBz0FqX3v5unMDWCY
         ipi5Ln4mUt1GEzvxj20JuD6xBmBIuGXubcL89piMwvWLU6pOYma7R5CMLnIlRoVI0EKW
         Zi2/xxzBN8Sn/drP1oxmjB7ZDNMXDsfAkJzPUUjn9NMDbIai2HvdYKtDNL9f2/1E5mDU
         v8SZAtGXESFPTMLubu1RciMBjIU4TEc+uNryuR2/rIUzcnetAeHYRnjAc4eW0hIj5n73
         toHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AX0U4vkAJIIuyBuIgDHjjt3ZViD9OZx8sECDADsitKA=;
        b=Oc+sThfxprduos9DPz63eUlIlvxnE7GHZBFWHLz6/2g4tghEuNhRoCwBO6YgYcCbej
         HZf95fqOHGqYAv5BCgMWnRkvdjVbkMVW8ceIGpH5p5sCXHUBY9VRt41AWT1rdbCTgH2s
         Odgb9Q3HgiCxw/449HPhHsFW5Oo0oxVPbzo3bAegE9nFMpyJLpcKBEw7whOHQBPfoh5j
         DDq5qXmPtr325DsgKGGWQTBK/dp4WMXziSQ8VIDEWFGDqTvnki59i1lwtD58olQunKLv
         e0sPS7el9cmM5j5pADSaucLM/5KBN7xcRmHz+Y221z1QpsHcS+OdAWjG9E3k1qoJVGkD
         17AQ==
X-Gm-Message-State: AOAM532LvxNyOGTeyOdxG9XTsSJDVRvZ/EfPBXCLYsRjL7do1pMoZIbY
        o4yusdRGZbz+zpDN3Okt4WHgsBqTI8U0VUqjd3I=
X-Google-Smtp-Source: ABdhPJzPhVCj+68hr0FH/Us0u5AqecDZr70HDc9YqyluXeOAiRfHJI6j0IbJzvEkXqTobQ1vhX0qDZ1X87+hgpsGJrY=
X-Received: by 2002:a63:ff51:: with SMTP id s17mr42796901pgk.415.1629906855752;
 Wed, 25 Aug 2021 08:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
In-Reply-To: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 25 Aug 2021 17:54:04 +0200
Message-ID: <CAN0heSoxE8zjzbYqRY6zvva=GEXEWx1k8FGhJMCf6N=pEcpZFw@mail.gmail.com>
Subject: Re: How to interactively rebase-and-reword nth commit?
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Konstantin,

On Wed, 25 Aug 2021 at 16:07, Konstantin Kharlamov <hi-angel@yandex.ru> wrote:
> I'm almost happy with `rebase-at`, except I don't know of any way to make it work
> with `reword` git action. You see, "rewording a commit" requires to run EDITOR twice:
> first to substitute `pick` with `reword`, and then to actually edit the commit
> message. But since EDITOR was substituted with sed, the 2nd run won't give you an
> actual editor to change the commit message.

I think GIT_SEQUENCE_EDITOR is for pretty much exactly such a use-case:

  This environment variable overrides the configured Git editor when
  editing the todo list of an interactive rebase. See also git-
  rebase(1) and the sequence.editor option in git-config(1).

Does that help, by not stomping on EDITOR/GIT_EDITOR?

Martin
