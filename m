Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40818C388F9
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 00:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6AEE22240
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 00:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoSTXuxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKTAfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 19:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgKTAfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 19:35:06 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E3C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 16:35:06 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c198so6957826wmd.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 16:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENDQnME8JUp5WSnTTzcQDl4NQlZTLBHL960I1KsPuPQ=;
        b=WoSTXuxzCT0y5weuXqPv7X3J/PfGegKjaB6Q1BLiX01U1azNjVTV2BHw8XnX4TZp0X
         N8UC1z9yoR7iwJ7IiKnJZ8aT0DjrK1MVli1owcQE36EgRNEbzZEJKhn/2PM+jjdqH4vT
         T18oPQJuMWcElUZv/W0DrzS2WN0O5AGpwZjOA7SCmsUB+j38LxrwSlCHT7BbpTXcN2gU
         4Oe2rNy25D6lyn804w1fN473X1O0Py2mIUcLdx5mOBLf6Dc9Tg8xoN+ZFew134DSNQg3
         ET3SEaun0FtmecZ5qM5yodjja7Vb8v2eh972UOCL3Yt5RAJAi0MLtIRTprv6QjMwrbxE
         TxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENDQnME8JUp5WSnTTzcQDl4NQlZTLBHL960I1KsPuPQ=;
        b=sRVSAqJGX4+vaO59JuGO1tc3Lx0hOtC0XpNGgWYFzkiMIdVvx2kDr/m9oWoi644qyG
         H7IpIw/KDgysIM/IHV6B2pZEyvIXSxZE2Xtc6m17zYYB8aoPd1pZwW8qhOHw1tTgqQDI
         TJst4K4ttSKTOgkPHG0ItAYpskxmMM9ttiTcM79nw5StcKxyVocVHz7g9NQMVI3yzvkI
         MWVDTSDevM3EIoga5E0oLxGM/4RzHDFmZKPtz4sl/olQRuqaqbjXcKa9lZxwfA0rxWhC
         Wi692rXMVObdQKueH3QrmXAbi3co9AtCkqbgotQMTMUL2ky+rLO8jzmukihe3WdXk+qF
         szlg==
X-Gm-Message-State: AOAM530Jnhj7iqjmCU0g03WddTr0zvB/zMkbLheK3nD/03H9K5PXpg2s
        52MPM7eYdF0CzaBwGeiwByBsoERWIQAIXHPiJAk=
X-Google-Smtp-Source: ABdhPJwroM6zQXqRlrvCCiWQMR7ME5wtvdMA9V+1fG7CZIw5i0IYuI9ABZCElx9mT2nc3wwWxvFl57kqjL/DoBIB4W0=
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr7409798wma.100.1605832505128;
 Thu, 19 Nov 2020 16:35:05 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu> <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu> <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
 <20201115034649.GC3985404@mit.edu> <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
 <20201119133705.7q7yghymvvo7zeq4@chatter.i7.local> <CA+sFfMdHrapy2o8D53dpqA5b+a88VLOX126daLcC8Sash4rq3A@mail.gmail.com>
In-Reply-To: <CA+sFfMdHrapy2o8D53dpqA5b+a88VLOX126daLcC8Sash4rq3A@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 19 Nov 2020 18:34:54 -0600
Message-ID: <CAMP44s2XXq5+uZLfrWs_yvrcuKYv2ta849PQ_w1ZqHKFsPZ6Ew@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     Brandon Casey <drafnel@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Lukasz Niemier <Lukasz.Niemier@kobil.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 3:29 PM Brandon Casey <drafnel@gmail.com> wrote:
> On Thu, Nov 19, 2020 at 5:37 AM Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:

> > To my knowledge, there are no concrete plans to change anything at this
> > time. All recent work was to remove any special-case treatment of
> > "master" as the default branch name, so people are free to use any
> > configuration they like.
>
> Glad to hear that. That doesn't seem to be the perspective that others
> have in this discussion thread though, especially since Theodore Ts'o
> referred to "...the "master" -> "main" migration" in his comment that
> I quoted above.

Let me try to clarify to you.

At this precise moment the name of the branch is "master", and will
continue to be until a concrete plan to change it is put forward.

However, the momentum is there to change the default name. So, if the
camp in favor of the change keeps pushing forward, finishes all the
necessary work, and puts a plan in place--which will probably include
a precautionary warning--the name will likely be eventually changed.
It's only a matter of when.

Since there's many agendas: a) get the name changed as soon as
possible, b) change the name, but do it properly and take as long as
is indeed, c) change the name, but not necessarily to "main", and d)
do not change the name; what you are seeing is probably a clash of
many agendas and no clarity from the project.

Moreover, once the plan is set in motion, and many users are notified
of things upcoming change, I suspect there will be a backlash, and the
"decision" might be reconsidered.

So, even though things are not set in stone, and the dust has not yet
settled, the move towards a change away from the default branch name
"master" is currently happening.

Cheers.

-- 
Felipe Contreras
