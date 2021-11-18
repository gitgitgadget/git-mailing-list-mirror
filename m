Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C03C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3315A61B1E
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbhKRIBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244066AbhKRIBN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 03:01:13 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76EC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 23:58:12 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id y5so11747162ual.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 23:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9R+5FhCmgM+4jBSdRkPs/VX3PQtN9Y+RLpwb4rJT00o=;
        b=dEUjEa3Z/QEzS3lGG664e7ng8jXqM93o7GUUHdjxjD9F6aeKL39TMwEDHA2+NfJbZH
         1759rtb75EkmBvuGm0zrsCYnb1+SKWSzUptLnwG/aVM1+1uH3J2UiOjLp+frOLMDUHr3
         Q+1dEd2tRLlHmTYUX32lD0V6iqZ2iUz3Ou81c8b7Cv7TPnV28jKkt1S+fUz8btZL+gJY
         ZrkaByj7PBl5sdXFjGVvbaH4N+8LupXpk80j4rbflDv2PGZEpQmDcyhqiTipBsImru5M
         zPNd8OcxRyeRYTAat/ZTicgm4dwbt916DH7HHX+o6a+N28f24rm+Vw3JaCqxP9geLWWA
         lX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9R+5FhCmgM+4jBSdRkPs/VX3PQtN9Y+RLpwb4rJT00o=;
        b=5H7LcgaUvMOxgH0MWMyJ4KfYwWV1cYjLoB2o9OY8kSr+qzVHKmpvbSLtWdHDUL1GIe
         qbKaIqiqg4x2TVDOwSID/wPDA6kv2ZPA991erC0JqQlMkqvWCJDVuD6RFgWmw6aWCN0w
         ya3BCGV2CefsYNTfhMPTv5n1JZgR9wR6455XrXP5284NEy/lsi1mfG6es6qjCIzmvSoY
         222RlQQjFm/whXw0OdFOQjkUMWSaMpxO2wZ/ajXe6I9RrtfE9zVghVALwcStbXo9CKcV
         DKMW3sT84VAvmwKPdcwburxC5LHOBPebiTAY1HArg7YvuhssHRe3S8lctvD4oEy9s4wN
         NOlg==
X-Gm-Message-State: AOAM531VjlkZRFz0ZNzfm+HR8Simz99tmNRIFs32d5QerusjkVoj3sdj
        IWFeTC9/RH1gjFyf5daBLIiJcfXBEo7qof3SjGs=
X-Google-Smtp-Source: ABdhPJxfhhJ0isfOtomwaCIlX0ykpU3iedl44mHRHPoMi8lL+S34YFYernK872rLdEMPdks7ajWKBv4PXpvqMt30yCo=
X-Received: by 2002:ab0:3b12:: with SMTP id n18mr2728950uaw.2.1637222291509;
 Wed, 17 Nov 2021 23:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20211005063936.588874-1-mh@glandium.org> <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
 <20211118030255.jscp2zda4p2ewact@glandium.org> <CAPUEspg-5+YdfTJ6zi9hdDqF=KV2LJFCtqmECSss9Kfpn6sGrQ@mail.gmail.com>
 <20211118053415.4axljmr4s6kmqmms@glandium.org>
In-Reply-To: <20211118053415.4axljmr4s6kmqmms@glandium.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 17 Nov 2021 23:58:00 -0800
Message-ID: <CAPUEsphf0d90HGg64j=jZnt-Xuhs_bwmeOyoUnmzesp_k2c4JA@mail.gmail.com>
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on msys2
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 9:34 PM Mike Hommey <mh@glandium.org> wrote:
> On Wed, Nov 17, 2021 at 08:51:06PM -0800, Carlo Arenas wrote:
> > It is not in 2.34; only in the git for windows fork, but agree is
> > needed if you are building master with a newish mingw
>
> Err, I did mean 2.34.0.windows.1. My working workaround is to build with
> -D_POSIX_THREAD_SAFE_FUNCTIONS=200112L.

that is strange, building main/2.34.0.windows.1 works for me both in a
mingw64 shell and the git for windows sdk, and the PR[1] worked as
well when applied to 2.34/master that uses a git for windows sdk for
building it and that would had failed without it as you reported.

what version `pacman -q | grep pthread` of the winpthreads library do
you have?, anything else peculiar about your build environment that
you could think of?

that define and the setting in git-compat-util.h should have
equivalent effect in your mingw headers; what does the relevant
(almost at the bottom, where the problematic functions are defined)
part of /mingw64/x86_64-w64-mingw32/include/time.h say?

Carlo

[1] https://github.com/git/git/pull/1142
