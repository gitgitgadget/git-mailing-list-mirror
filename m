Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E426C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 02:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjELCJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 22:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjELCJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 22:09:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594845276
        for <git@vger.kernel.org>; Thu, 11 May 2023 19:09:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so6352077e87.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 19:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683857365; x=1686449365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xorROiSMmM9He5fRCK+PAgKOwj6MvB4Nx1mM7zNj/w=;
        b=llTyVPvApEPA7+wlCX/pkPPD27p4ahEymgmH3ZjYk3Gxf+wN8w1IC7wqTiys/rOtSB
         6UugljtzJoPbsxaIuNDRgWVgE7pzTi2li1REpiH4MWQRD93tkN44O1WdsJ6PukJYGoZS
         cMe1Je8rZmYn8Wh3mVKna1kF7bsbNa6FGFeAVfIlEo7eSad7deVRXxpJOWxdTt/xoGE6
         9PQmJqDPry8WXuZkZbsDXlAH90tcWDsqMBG/H/IQRQeovq3fNPXVJGKuyL47BmAiJPL0
         /jhwqScL/Hu/2OuOfGNKPJ1A8YATPwNiHtjgPOi1xsgWUzaIJAIKpA4KUweqle1eM61i
         ggZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683857365; x=1686449365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xorROiSMmM9He5fRCK+PAgKOwj6MvB4Nx1mM7zNj/w=;
        b=TdJFj5gAw267dtpWG7cH3aAy9K7pQ1inkajPsZg2h1AIBOsa4N17IhI70gfCd8E/c/
         kpyek20f8ugXjRNHb7wobZMZ0ohVEWxARRps8G7UV44Q6JZqwgJ/6RxG6prmyzdjo2gJ
         ErirEvVnppOck4Tfhd9hOx/mWB56ZgJPhpw4ya3p3h9zlAK95j0r6PVN4qt5GysfZytv
         zFgyBA4ANalN1Hry2Zku3GOcmt2t/vswUbhvgltiQEQI/6u2eHHaAX8CJL/2APflcT0q
         /N77fcioi4Hy/Cc/SNC6tGLk8e4lzvf0gY2xrwSpyrVjZqtCsCxb7BcxJhehtxs4ZUSV
         SBRA==
X-Gm-Message-State: AC+VfDx2tDqA6weu93YYD6qAj1DR/gxbmkdmBNAehPvKOZhroCSe8s/+
        prUvy0Vh/MRiaouqdH9Wv+FHtuBK129+C5viXFjFtYXQ9dQ=
X-Google-Smtp-Source: ACHHUZ5cnWG+CnbVoHzu5UyOQYBEtxJqcE78knxiFO86q4cqJJrrSQQjXjEL5bXXTIAHkyk9xt8pZDBIVOMhtt18qVk=
X-Received: by 2002:ac2:5285:0:b0:4f2:6857:1d98 with SMTP id
 q5-20020ac25285000000b004f268571d98mr1255037lfm.48.1683857365308; Thu, 11 May
 2023 19:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <44a4027b240289605f4c40b9121ee6615e9759f7.1683431153.git.gitgitgadget@gmail.com>
 <20230511172401.934633-1-calvinwan@google.com> <20230511183143.GA1978320@coredump.intra.peff.net>
In-Reply-To: <20230511183143.GA1978320@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 May 2023 19:08:00 -0700
Message-ID: <CABPp-BEVWS2atggSNC16bQ3FxvNxU-76+o3B5QF+2opiwOLfgQ@mail.gmail.com>
Subject: Re: [PATCH 23/24] hash-ll, hashmap: move oidhash() to hash-ll
To:     Jeff King <peff@peff.net>
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 11:31=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Thu, May 11, 2023 at 05:24:01PM +0000, Calvin Wan wrote:
>
> > > Note that there's a small but
> > > important change to khash.h in this patch as well to allow this move,
> > > which is easy to overlook.
> >
> > Can you go into a bit more detail as to how this change allows the move=
?
> > (An example of the concatenation would probably be sufficient)
>
> Even after finding the hunk, I have to admit I scratched my head at what
> was going on.
>
> The answer is that object-store-ll.h now uses "struct kh_odb_path_map"
> instead of a typedef'd kh_odb_path_map. Using the typedef is the way
> that the khash library intends to work (and the only way it provides),
> but does not match our usual Git style. In other users of the khash
> library, we just bend to their will and use the typedef typedef (which
> we have to, because it does not even name the struct type directly!).
>
> But we can't do that here, because object-store-ll.h does not include
> khash.h, so must forward declare the struct (actually, we do not even do
> that, but it is legal to just refer to it as a pointer). But the
> compiler only understands what we are doing if the "struct" keyword is
> present.
>
> So I think the solution here is reasonable, but I actually think it
> would make sense to pull it out into its own patch, with a rationale
> like:
>
>   khash.h lets you instantiate custom hash types that map between two
>   types. These are defined as a struct, as you might expect, and khash
>   typedef's that to kh_foo_t. But it declares the struct anonymously,
>   which doesn't give a name to the struct type itself; there is no
>   "struct kh_foo". This has two small downsides:
>
>     - when using khash, we declare "kh_foo_t *the_foo".  This is
>       unlike our usual naming style, which is "struct kh_foo *the_foo".
>
>     - you can't forward-declare a typedef of an unnamed struct type in
>       C. So we might do something like this in a header file:
>
>          struct kh_foo;
>          struct bar {
>                  struct kh_foo *the_foo;
>          };
>
>       to avoid having to include the header that defines the real
>       kh_foo. But that doesn't work with the typedef'd name. Without the
>       "struct" keyword, the compiler doesn't know we mean that kh_foo is
>       a type.
>
>    So let's always give khash structs the name that matches our
>    conventions ("struct kh_foo" to match "kh_foo_t"). We'll keep doing
>    the typedef to retain compatibility with existing callers.
>
> The "you can't do this in C" is all off the top of my head. I think it's
> correct, but there may be a clever way to do it that I don't know of.
> Though even there is, I think "make khash more like our usual
> conventions" is a good thing by itself.

Oh, wow, I was about to type up an explanation to Calvin, but you did
so in even greater detail.  Sweet.

And sure, I'd be happy to split this out into a separate patch and
steal the commit message.  I think you deserve Co-author, though,
given it's only a 1-line code change versus the 20 line commit message
you wrote...
