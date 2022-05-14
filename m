Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1450AC433F5
	for <git@archiver.kernel.org>; Sat, 14 May 2022 14:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiENOgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiENOga (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 10:36:30 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94AA220D9
        for <git@vger.kernel.org>; Sat, 14 May 2022 07:36:28 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id i186so11207050vsc.9
        for <git@vger.kernel.org>; Sat, 14 May 2022 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yumUcDl2a415gTPjX2xaj+MNBckkfMbOgEFJ8Tf9Awo=;
        b=nQN3LI4X6BTYxQjieMS832VEfw90jX/WY965iybPnedKIAV+9A4FYAsemVFcKbpsqH
         OyH8wXrGGjVJcLRC82ynMXhWZgjzRt63psPEZIvsjM4BDZF6/n2gizf3EZ/ieN2Drn3Y
         FIqdKvPH3pDPlX7mmP1L58+/6U9kVT3dI04PBth1S5bCPnNHkC6EclmZpKMAe3tBG9RW
         IrIIsvsEAUg8nKxfCbdeW2RjIVBaPhevg6Rr3ar0cBTAyMolTdEsdhVoN488dL641baC
         ujzKPPJZ+7HhdAuB2EWTueT3TNrQdozmesWL3dGCcaf5BFRl2s9jPf05KDyLl2/K9SLz
         DXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yumUcDl2a415gTPjX2xaj+MNBckkfMbOgEFJ8Tf9Awo=;
        b=z5P6C4SHarVEw6Ohr/F4jr6EDw0KzCBbE3JdxPfF6d6uWyaygBPC2Jf2vszJXAZUUX
         wiIxyEUvxB/Kpe1IUnnxjhEpxPyurDWRA4VNZz+NvOQtmSg1mGHM/L5KlBtz5Gz0J8RA
         6nKHoIzq10N3zDFbzuUZY1Kdyve9vt8KbYRIUwd1+NU43F/u35Ncox9uhtHgBTtytdnD
         eFd904GDq+CpN/mwiNrSJzpKasqzKpdDJSbhLH/R2nce9urbR8al84zt6a5i8vPEknJa
         HREXCHCpZpSVx7LODZLBARvqezsej8cLzOWIsWvqRmaouLdnqtBfm42GCWm5cYatAtm+
         jJ+w==
X-Gm-Message-State: AOAM5333A/9M35Zd7yOtVop8uzGTVLVK3ZnxPDG2K0+uNAY5isIrJ0lD
        ho3+R2HAtQASxdChXtoZNQQSKcWwPf+5cbz/HSm+B/E5
X-Google-Smtp-Source: ABdhPJyz58RypO3Ix4CrH71UgOYWvykWBIBjxXBoqCcplPKf8qBgDp3+sNWrektriKBNeMJz3oGw3647cxDN3Joutsc=
X-Received: by 2002:a67:d303:0:b0:32d:3d07:17c4 with SMTP id
 a3-20020a67d303000000b0032d3d0717c4mr3877225vsj.52.1652538987708; Sat, 14 May
 2022 07:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220510174616.18629-1-carenas@gmail.com> <20220513010020.55361-1-carenas@gmail.com>
 <20220513010020.55361-4-carenas@gmail.com> <xmqqee0ycjos.fsf@gitster.g>
In-Reply-To: <xmqqee0ycjos.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 14 May 2022 07:36:16 -0700
Message-ID: <CAPUEspj1JTG2Ujuk4O6ogo6qEQEwe-2aHF8J95xjX+OpY4cenQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] t0034: add negative tests and allow git init to
 mostly work under sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2022 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Heh.  I am a bit surprised that double sudo would become a separate
> prerequisite,

It is because it goes away in the optional patch 4, since it won't be
needed anymore after that.
Also, it shared the same test with the other 2 workarounds which moved
into their own (one as you suggested is more of a statement of policy
that says, git trusts the developer and doesn't check if --git-dir or
--worktree (or equivalent means to explicitly identify those parts of
your repository) are used.

and the other, was always "special" since it was documented as an
indicator of what to do which could be considered a least privilege
marker as well.

without the optional patch that brings it back, root MUST indicate
through its use of that (or other "workarounds") that he really meant
to access a directory owned by root, and will instead defalt (when
appropriate) to use the id of the user that invoked sudo, which has
(normally) less privilege.

> of a new part of SUDO prerequisite.  After all
> we expect from SUDO prerequisite quite a lot (e.g. most sane
> installatios facing end-users will futz with $PATH, but we require
> not to do so to satisfy the SUDO prereq) and it is already very
> narrowly targetted to a throw-away CI environment whose sudo
> basically lets us do anything.

just because I didn't want this to become a bigger change that it was already
indeed I'd been "cutting" it since the very beginning, by first
dropping DOAS support and then avoiding moving things around so it
could be easy to backport.

I think I can provide a version of it that might be able to work with
less restrictions that it currently has, but that would get us into
the "test framework integration" that was specifically punted as well.

Carlo
