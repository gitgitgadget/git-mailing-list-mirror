Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7095C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjATPcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjATPcT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:32:19 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D5510416
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:32:18 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id y18so5832731ljk.11
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyaWz6gzp6EouS+9/7lIrDB4K+8TPblQxAj0ivlSUbI=;
        b=LluYtjvG1vFXVnqlyIRyxy8xgv2gKWrvkdo0A+i1mgQFk5Am2LBGsg0r5bD/5Cn5yt
         pgTQuYAHLkYkL1DK0mnLPo/wgTtTPJBoh9g3LjY36kDdNMlWnWuODsXUjNLx1pCpJPV5
         OaxmQVljnD3wTYOKGk+g4Kgs0F3BDowDf+SeupyBrRgDGzDV2MMZ2RS0M9YEBgGxb/ng
         LFh2NR6YgjLrPjc3g9/rYPpTOzV174xs/Y1V59Nilx3amTmvIwCWqisWaT5u+Na8jeSe
         c89DHxda+vQ7GnpKNTBYnb01g+v6ZCA7V/Nk/LZtjdRlWh/aKSH54PYjpLuvmUHJIKql
         CysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyaWz6gzp6EouS+9/7lIrDB4K+8TPblQxAj0ivlSUbI=;
        b=mp0EZZVAZKmF0jbYvET8QhomcpYiJ//1Ayx+PFCJI+0SPcJWvpnKyU0Rty3Ig1zWO/
         /b18A56WenSZQHwvMp4lA54QabrxqW2F0r0XQ2tENj6FQ/KMrtBlzLYvu16tIZCrXzLS
         pqdgKGexWdBrC40Jx1JdcdC9r1Aiiu8WPZwRF/rajVEkrnkB/sHuaQ7PHk94YLnyluSK
         +qCuKU2TmUZtfN1URaOlGG526VVmQfgFr+EMwzKstNpC9EggdBjuEnj+ZEaqkfUON2k6
         Z2bAKEtem+ey1eEX2mwMtWiz5pvcgAotsUXQVb1yf5CjJ9Ox3ti9pDPDS8tnwJWpcpze
         152A==
X-Gm-Message-State: AFqh2kqMRWmtfMYlJmBgiw1PckloIsXrFX05GzrnmE6Ik+qSZxl4YL4H
        ElfjSVppoSorK8mNLNIeSJYxs8WOVesqPwcWr6Lq9E8u
X-Google-Smtp-Source: AMrXdXsT7DCn3RtzNQVMvHbrdP8WfjdBIIeaQgqMOoPOQXhX00haftIX/EHoB3upnmxNMtx7+LpMQRxZR4XNj11rIoU=
X-Received: by 2002:a2e:9842:0:b0:289:c64d:cba2 with SMTP id
 e2-20020a2e9842000000b00289c64dcba2mr1380336ljj.325.1674228736309; Fri, 20
 Jan 2023 07:32:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
 <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com> <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
 <CAN0heSo8cqNqhx9+AJZJS2rwJxBG_HZjhgxQZf8nw5t82NDXBg@mail.gmail.com>
In-Reply-To: <CAN0heSo8cqNqhx9+AJZJS2rwJxBG_HZjhgxQZf8nw5t82NDXBg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jan 2023 07:32:04 -0800
Message-ID: <CABPp-BHjcD=sa5ACorrzSmcGNrksQ-Jr0Z2MVptOJjWcN=h4Rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rebase: remove completely useless -C option
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 1:55 AM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> On Fri, 20 Jan 2023 at 06:27, Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > As per the git-apply documentation for the `-C` option:
> >     Ensure at least <n> lines of surrounding context match...When fewer
> >     lines of surrounding context exist they all must match.
> >
> > The fact that format-patch was not passed a -U option to increase the
> > number of context lines meant that there would still only be 3 lines of
> > context to match on.  So, anyone attempting to use this option in
> > git-rebase would just be spinning their wheels and wasting time.  I was
> > one such user a number of years ago.
>
> I suppose someone might have something like GIT_DIFF_OPTS=3D"--unified=3D=
20"
> meaning they would actually have more context for their `-C` to act on.
> So I guess there is a chance that someone somewhere has actually been
> able to make use of `git rebase -C` after all? I'm not really arguing
> either way -- just noting the possibility, as remote as it may be.
>
> Martin

Ah, good point.  And combined with Junio's point that -C is apparently
about reducing rather than increasing context, I should just drop the
patch.
