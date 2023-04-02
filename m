Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A32C76196
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 18:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjDBSmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBSmB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 14:42:01 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C92102
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 11:41:58 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id n125so32388147ybg.7
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680460918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/w5Z/vSD4+x9ZS3bzca7h06vp0QN+7kR91eTPEup3RI=;
        b=nxQi+vTZjpcYYlukMDh08o4Ngi222TY8v18Ccb8NrkHCC7q+Zvc+R1TfBZBO4GkoaT
         8kziwY6LuSLpoRmXPYZBQIsY7CVTDdc8NLQtbNzjsiFblNKSdnTDCVgvw+WYy4L2vDKL
         MWxK91F//Wv88niWdz3G/CtOfhXMGXYx9f1QoInrM70YRRh1kNvIp+/P0DXs/bxHcOZ5
         Hc/4oFJLQemjSwq2dfJHdneagH/azEgItWXTTibbexoldoyU3Hckh3ZitLuN69dqYvus
         JPPIAYjftAcnYcNpK8n0AG2ReyUzsI6fbs1AnDlyKSPRShf9AvD6nFB0o6GMXkMT/GI4
         Co0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680460918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/w5Z/vSD4+x9ZS3bzca7h06vp0QN+7kR91eTPEup3RI=;
        b=EUY7KrBAfTiLnSYCWdCJLPH2kSxefJ4O+fviy1PWl/nVQj8y8xRXll4yV5Ujfr4CJW
         dx5XcHIc5Lj4E8HnkC8Koa/JbsRvMVBYxJ1trqR/ztzzYCphMKsSnQr3UHFXGwsOT1+S
         NiwbDwtDDtdu0KXxswu25MpOC14zhWnSaYfFNHOL5ui1rmy6BivkoKQR6CpN3RmSXDbz
         b/KCjSwiGNeR9MVSMb4IUNeUNZOnwHx5y7tH92U5R3QzR7eqB2gJLp9OWmoBiZJZqmha
         nvUpZBMaXko9ZTn8gxuIxavZW/dIaifEFRrOvJzpJcoFvyyA9Irn8aULBKN05cu2nwIG
         0yqQ==
X-Gm-Message-State: AAQBX9ecWfNmpL6h1WApR8cc/R2lo0SVicRPc+gMfjVj/guTtDJA/o0C
        TPP0nabeoa5leqBH8caVjQjc5ZPiPf6Kvogm8nwt0n087Rs=
X-Google-Smtp-Source: AKy350YKBLuAXR0hVsBEji+lvwOeFp0x21zhHFuKWgvq8Spc4it/iBb2Z6wTgeVkQ6n7yNCZJqQmi4JIsGnqLs3gYjM=
X-Received: by 2002:a05:6902:70d:b0:b45:5cbe:48b3 with SMTP id
 k13-20020a056902070d00b00b455cbe48b3mr21846474ybt.0.1680460918081; Sun, 02
 Apr 2023 11:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFFOgCUs9d6wJDf3p-+8UkzXRSymCgBctGt+rP+k0CzZPp2LJw@mail.gmail.com>
In-Reply-To: <CAFFOgCUs9d6wJDf3p-+8UkzXRSymCgBctGt+rP+k0CzZPp2LJw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 2 Apr 2023 13:41:46 -0500
Message-ID: <CAMP44s0ujDcosdU2yDz-o7G8aCswEkpTP=Bfnjgt+5p=D4iHJw@mail.gmail.com>
Subject: Re: Revision ref '@{push}' not resolved as documented
To:     Alexandre Garnier <zigarn@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2023 at 10:41=E2=80=AFAM Alexandre Garnier <zigarn@gmail.com=
> wrote:

> # Push is done with the expected remote, and only then the ref can be res=
olved
> $ git push
> Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
> To ../myfork.git
> * [new branch] mybranch -> mybranch
> $ git rev-parse --symbolic-full-name @{push}
> refs/remotes/myfork/mybranch
>
> So it means the branch has to exist in the remote to resolve '@{push}'
> as a symbolic ref?

It has to exist as a ref.

This is not just for @{push}, same with @{upstream}:

% git config branch.master.merge refs/heads/foobar

Now `master@{upstream}` doesn't work.

> I think I remember that a few years ago the example was working as-is
> without the need to push.

You don't need to push, you can fetch, but the remote ref has to
exist, and I think it has always been that way.

Cheers.

--=20
Felipe Contreras
