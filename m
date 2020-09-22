Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D4FC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF862371F
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 21:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2yWx3uN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIVVct (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 17:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIVVct (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 17:32:49 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840C7C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 14:32:49 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z13so21346252iom.8
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFTuFob0t3+2k6WAK/ln7A6nlTQYr5S9uEBzKkq26kw=;
        b=u2yWx3uNq1QoWe8qGQuowAgdHkP+OAe/LMOs31C0ySxtsocaMcHvWBescb4hyW+nRT
         sjIiSDyFjF/T2HQ7ExINQKZz4WuOaS114iSDwVHl75VUbP8XuVd6JRPds7UUIOD9DmYN
         Kf5uYysVIMnKC++sJYJjMyM0OA2H3Mxe2POPGfqxTX3bvqVX4042ZzLBDT4Y0beQM2co
         J8gF4N99YpAIwTjuM3Lu1P1bPx3UWHKBky+uS/PKh0tpEyqEeR1N7PWzlk+x4wMxEezE
         9ogZU/4/IwZ3yidpA42LH5VHFX7esTWPk80HtrNe+itfItEAMfoF4QrNSxrnq+Vrp9MC
         rlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFTuFob0t3+2k6WAK/ln7A6nlTQYr5S9uEBzKkq26kw=;
        b=g4JZiCvBlIC8UR/5U6U8DS47d6WaEWsO+3TZOmyssQsFBAUKKGIWLII2iV0NsRFd1q
         I/NbNuKG2nYREA2At7GtYN6JBiCcuufWf3SWs7XsL6gzws1dqWVJ2D121H+w3Y8qXOC3
         M+PQ3AEfY0iQc0+4m11Y/fyMVaHYSxR/6IKMYDraTlfQjkcCF6/XDyI80fkCY0oEFiQ8
         fsnFlB2wZg0OlW0GKM9kOOPzjiQ6Qsjuehd75+t9jMl9uDYD4AkvVG+70TQ2SesQkc1o
         AjfMSCidvmHYNbGXEggt7ZrwN3zyJcUgJH5oTsACX6Lc1sLco85UZPTfIlsEErI4J+mo
         dTLA==
X-Gm-Message-State: AOAM531l38O8/LBfea6lU85b8oIK8UkOraJbl5YoiziDAIz3j1tlX4nL
        V8DxXUAGznSogbCgSRuksoZPYfoExNlsVE7ZNK0=
X-Google-Smtp-Source: ABdhPJyouTfAdhzU8DG9niQhexfMI3qJWYsH0fQSKeXL/yzMAGEl0gvVirRtrVJuvkoREXcWRTaif9o90cTCyPa2wNU=
X-Received: by 2002:a6b:db1a:: with SMTP id t26mr5132586ioc.152.1600810368757;
 Tue, 22 Sep 2020 14:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200922193407.23931C0613CF@lindbergh.monkeyblade.net>
 <CAD2jYq_-yOgVDd8280+T1E1hT1r0DfN1xFN6V0Hz_v7wnsENpQ@mail.gmail.com> <20200922212404.GA547416@coredump.intra.peff.net>
In-Reply-To: <20200922212404.GA547416@coredump.intra.peff.net>
From:   Ilan Biala <ilanbiala@gmail.com>
Date:   Tue, 22 Sep 2020 17:32:12 -0400
Message-ID: <CAD2jYq8OtHUpfUZyXC_+FHew45XEtgty3H-XF_2e30mb6kCCmw@mail.gmail.com>
Subject: Re: git diff --name-only --submodule=diff combination does not work
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I expected adding --submodule=diff to add all the filenames in
submodules that were modified, but the output just shows the submodule
folder name, not all the files within the submodule that were
modified.

On Tue, Sep 22, 2020 at 5:24 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 22, 2020 at 04:56:45PM -0400, Ilan Biala wrote:
>
> > I've been running into issues with using the --name-only and
> > --submodule=diff flags together in Git 2.27.0. Is this a known bug?
>
> What did you expect it to do, and what did it do instead?
>
> I'm not very familiar with the --submodule flag, but it looks like it
> only impacts "--patch" output. E.g., in git.git (with the submodule
> actually populated):
>
>   $ git log --oneline --submodule=diff -p sha1collisiondetection
>   4125f78222 sha1dc: update from upstream
>   Submodule sha1collisiondetection 16033998da..855827c583:
>     > Detect endianess on HP-UX
>   07a20f569b Makefile: fix unaligned loads in sha1dc with UBSan
>   Submodule sha1collisiondetection 232357eb2e..16033998da:
>     > Shorter version of force aligned access.
>     > Add compiler option to force aligned access even for Intel CPUs.
>   23e37f8e9d sha1dc: update from upstream
>   Submodule sha1collisiondetection 19d97bf5af..232357eb2e:
>     > Merge pull request #45 from avar/aix-big-endian-detection
>     > sha1c: fix a trivial spelling error
>   86cfd61e6b sha1dc: optionally use sha1collisiondetection as a submodule
>   Submodule sha1collisiondetection 0000000000...19d97bf5af (new submodule)
>
>   $ git log --oneline --submodule=log --raw sha1collisiondetection
>   4125f78222 sha1dc: update from upstream
>   :160000 160000 16033998da 855827c583 M  sha1collisiondetection
>   07a20f569b Makefile: fix unaligned loads in sha1dc with UBSan
>   :160000 160000 232357eb2e 16033998da M  sha1collisiondetection
>   23e37f8e9d sha1dc: update from upstream
>   :160000 160000 19d97bf5af 232357eb2e M  sha1collisiondetection
>   86cfd61e6b sha1dc: optionally use sha1collisiondetection as a submodule
>   :000000 160000 0000000000 19d97bf5af A  sha1collisiondetection
>
> -Peff
