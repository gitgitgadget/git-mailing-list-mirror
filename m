Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E08C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E6220659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruxrzREv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbgEMTpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387616AbgEMTpS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:45:18 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DBEC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:45:18 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x13so534397qvr.2
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgwD/QT6AjvfHTyC/h3lhWJ4eWLLxcTu1rzaqBdBCbU=;
        b=ruxrzREv3RvrWKz/NvjtBYSBNkpRrspMSZS8+ZxYEu/jduJLa/SUJs1y1xz9w8X0AJ
         WwtWYAze3/VARuoLiWUdMGVdyT+L+9jIALzJaEkMRt4Z/oEmE2LqKnTYBxAxYdPGgLjq
         agPGB/K48jgqQc02vxOdEDgp/PeXBxHuGeGNCztFluQfNyZzjEPJ/tvbwUJaZLtZYyi0
         qVvGXTKf9BYy6kE7obxT9MJJTnxjtL0mGizn87UxhmuT587+n2xEYE/tGxzBAeSJGrid
         XPivtak4BflySi67+9kNrjZTxkcG6Cz4EZ+iv45JjdLUO3ShxQYJyegweLqnFRX+gWtW
         lr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgwD/QT6AjvfHTyC/h3lhWJ4eWLLxcTu1rzaqBdBCbU=;
        b=UbQ6yv+6PjkiQfIDVkpwW1X9bxfy2dx9ZJfJ2lGnsg6ka8KOi0hbIyMsYhT1njAITk
         dIgIMjfVSvuEXtdrSwZJvdr7Rsh4agtQN26x7gJDvIwfQMT+WQaidsPq8vM+TsCfBakj
         Iv3l2J+wqxoRkILyFIenWLnA7qy630HQZi2ueH2L4ZvXlyNlFOcTHMduldPjc5SXqjE7
         R55SJkirtPw+XHySuSvjkKif7hJrh3yuAP2uYFd/3WKFbiTaS6+PhQKoBs88ls5XACHJ
         1jgmA6Laxmxgl0BtWCBo2WlPpJ+FIznImMTEDXWST+9wm2fUwsBCSs41fGgfxhnmuFlq
         6Paw==
X-Gm-Message-State: AOAM5315YRjU7+Sd1YV3v0iAjqaFb064ylgR92elgKA45/BEkT9a99sR
        mdPfDTrZuBkBT6OZCUn9KhNkAY2IW2iZ4nlfbhg=
X-Google-Smtp-Source: ABdhPJx3NRTA8MJ9a2QTm1Exgy7wIQCV7Ca+9SVsQ7wuyxalM+xyNQ6v9CkypKwDNEugEEH+iv357dgGR3LOgjZLMUs=
X-Received: by 2002:ad4:588b:: with SMTP id dz11mr1272573qvb.226.1589399117528;
 Wed, 13 May 2020 12:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <fa1b8032906c6042a0e5851f803ec0427922a1a5.1589302255.git.gitgitgadget@gmail.com>
 <xmqq3684c096.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq3684c096.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Thu, 14 May 2020 01:15:08 +0530
Message-ID: <CAKiG+9VXk1vdMM1amQK6pnHcn9H_93-3fkqgK4nwKf=GtrDGyg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ci: modification of main.yml to use cmake for
 vs-build job
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 2:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > Subject: Re: [PATCH v2 11/11] ci: modification of main.yml to use cmake for vs-build job
>
> Yay!
>
> > This patch modifies .github/workflows/main.yml to use CMake for
> > Visual Studio builds.
> > Modified the vs-test step to match windows-test step. This speeds
>
>         Teach .github/workflows/main.yml to use Cmake for VS builds.
>         Modify vs-test step to match windows-test step to speed up
>         the vs-test.
>
> > Changes:
> > The CMake script has been relocated to contib/buildsystems, so point
> > to the CMakeLists.txt in the invocation commands.
>
> This does not belong to the log message for this (or any for that
> matter) commit, no?  Up to this point, nothing in main.yml used
> CMake script from anywhere, and "has been relocated" is irrelevant.
>

Will remove this.

> And if we add CMake script to contrib/buildsystems/ from the
> beginning in [01/11], there won't be any "relocation" the readers of
> the log message of this step need to know about.
>
> > The generation command now uses the absolute paths for the generation
> > step.
>
> "now uses"?  Is that something the readers of the log message of
> this step need to know about, or is it "in contrast to an earlier
> attempt to add CMake script"?  If the latter, it only confuses the
> readers of our history, as most of them will not even know about an
> earlier attempt.

Will also remove this.

>
> Thanks.

Thank You,
Sibi Siddharthan
