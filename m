Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17614C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 22:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF905223C6
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 22:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKU2BaNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgKCWh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgKCWh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 17:37:28 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E2DC0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 14:37:27 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so9294210wrl.7
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 14:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UAk9vgOh+OcBelgrFFVYWSDA51HpfNqmPs+4oidzG2w=;
        b=NKU2BaNk9obJ10SYwUnGQww1wK1k1w9gastHToUkDGUSDLi6vKHy6WaxHq0je/vzxv
         p7suSphnCTHkhGweroZbwZjBFf1ASf5Px95/LaIRW7r3bcdzp6qDwP+ql+UIKsVeWraM
         9iH31N3PYZitbJb2OIHRfd27ddtwBTLfx7tFz889zvq76vSarwQKUk4Qfomql/5mS7FH
         rhvw601GlexXthGbbP8x7Ej0zivGLe7YIeRE8VIBGZ1764jojG21qFCS1Ky5ZosTsODS
         NOrJVZtNbfxtrJAgcz7TNm3Omz+76zCs+LjatE1hTuSLXF3BPS6nEzqs3qE+b8B7FPJs
         NgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UAk9vgOh+OcBelgrFFVYWSDA51HpfNqmPs+4oidzG2w=;
        b=i8U1XigtBDmqAh83xCuvZwtX1mR/Jr5RvbVYrEBYulCexJ+RNeSfmrNrA1woo30cW3
         AfTrLbqeBXdDggDbzko6+iC7n9wNtCVr1/8g5FAx9THM0yIhoc1sBWm+2FeCcWGRGFJL
         wBmh5U3Utr6fHhey0MV/Vq2MUYUTFYSARWWYfXWooF8bCCF/gYvVmT0QptUYkGwZ5Hos
         GEPIBF4kkErV96c9LcFHukO+PKN71K4MVvG18SiqQ6QYV+oTyvJ9EHD3kvU2BmT+cZkz
         MaWWUP/sW+BlOGvbRUGHw8OD68g+8uP20G+Jz/bHrM6mgrw/nIQK479/2GDnW9IXANzI
         Igew==
X-Gm-Message-State: AOAM532NVUleVW8U9f1x6a5N0EqKdCgapDSstDwnF1yTNY1SEoYklmWQ
        sDK2j9Yo0A1pGOR0TnMfxyKlh0EDxgShN7NWXno=
X-Google-Smtp-Source: ABdhPJyI0RnHGjdRb8D7JIGFseBwsfHiiBGHu5x1l7ghV63g/MKNHaNs4TBb28WhIiFbGb5cCvhCkkAkvhfY9cfjWto=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr1678702wrs.100.1604443045698;
 Tue, 03 Nov 2020 14:37:25 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0vbbep5.fsf@gitster.c.googlers.com> <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com> <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de> <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com> <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de>
 <xmqqh7qb3a3r.fsf@gitster.c.googlers.com> <CAMP44s3Tx1DdzD3fAOA+_3fLMK6Ew9GQAJWiRoA2KR156jiZBg@mail.gmail.com>
 <X6CQpfuhRkAwmMou@pug.qqx.org>
In-Reply-To: <X6CQpfuhRkAwmMou@pug.qqx.org>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 3 Nov 2020 16:37:14 -0600
Message-ID: <CAMP44s3w1uBgupT-K0FbR7Zjtp6+z0PfdbkGvnFX0SpA9qF1FQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 2, 2020 at 5:05 PM Aaron Schrab <aaron@schrab.com> wrote:

> The option that you consider to be invalid is definitely *my* preferred
> option. That Homebrew's git package installs the completion in a way
> that overrides that from the zsh package was a source of continual
> annoyance for me until I put in a long-term workaround for that (I had
> just been removing the symlink every time I noticed that it had been
> created by a new install of the git package).

You are probably a minority.

Just put the location of your desired completion in front of your fpath

  fpath=(/usr/share/zsh/functions/Completion/Unix $fpath)

> While the completion provided by git.git may be faster, the one from zsh
> is fast enough on the repositories that I generally work with.

There's no such thing as "fast enough" for most Git developers.

> At least
> with my configuration and the completion code currently shipped by
> Homobrew's git package there are at least a couple of things that seem
> to be quite broken.

If they are still broken in this version:
https://github.com/felipec/git-completion

Feel free to open an issue report.

> The one that generally caused me to notice that the wrong completion
> code was being used is that it doesn't provide completion for creating
> local branches to based off of remote ones; I'd previously thought that
> was just a missing feature, but looking into it a bit more now it looks
> like that **should** happen as long as I don't set
> GIT_COMPLETION_CHECKOUT_NO_GUESS=1.

That was a bug because somebody added a new function to the Bash
script and forgot to add it to the Zsh script.

I've sent the fix:

https://lore.kernel.org/git/20201028020712.442623-14-felipe.contreras@gmail.com/

> The other thing that seems to not work with the completion from git.git
> is completion of single-dash options. Although that may be more of a
> missing feature rather than something that's broken. Since there isn't
> any description for long options, I'd guess there wouldn't be for short
> options either; in which case there isn't really any point to trying to
> offer completion for those. But, having additional descriptions for
> options is one of my favorite features of zsh completion.

That's a feature request.

It may work at some point, but it would require a lot of work. In the
meantime you can simply use the default Zsh completion.

The point of the Zsh completion is to offer everything the Bash
completion offers. Which is clearly fine for most people, since that's
the completion most people use.

Cheers.

-- 
Felipe Contreras
