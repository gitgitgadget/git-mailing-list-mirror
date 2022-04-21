Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7095EC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 23:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392522AbiDUXIr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Apr 2022 19:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392472AbiDUXIq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 19:08:46 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525D43395
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 16:05:55 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id bi49so3018527vkb.10
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 16:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zSU3xZcUwZW76m5zwU3/0LP4LYVVEYMi5PeUa8VLTQk=;
        b=ZXmd72EjD4wXHyqyWk1v2Ay8g/hVqNEFUj1CtKM0Hsc9WL0rPPfY9gDoVLrCEZ/Qy4
         /G3dEZoC0I5FtGyGAFxE1aeUDKTJfxaW5ubC04ZRVnsQA6KzpBKl/uhM2zZfPeMClS63
         kk192OiVjGhBtl42t+s0Hr1xsfLK1fAhyUEPpBBlyDcB/dFGBIy8cVnvLILIIeUkEkhr
         LHoDtJDbilgOo3uxqPnofS2lfh5KAgUCpYAqyPPvegzys0w6rQCMq/0xUC54no5akx4f
         mVrstPXcnk08WQMAzOvNKOnD9YLd+rOnN/vZIsFRLre0xeoDmLh7zNhl+Jl+XxqC7FOo
         zxNg==
X-Gm-Message-State: AOAM5334qN2ZDLzv9ZicL9Zv7T+fpaclzops7XnIkfQJcP1KL9Aw/Ldk
        2Pb8UFftih/TSWYPDEPNmyk1G7XDi4O3ZaRrk1IUgzkcr7HHbg==
X-Google-Smtp-Source: ABdhPJyzKJRahnzOrpvoVMP9s3oHMQzv8wUVFzueY3x+XrqUO8hy6ECgVqTrsZkbzM8ENuXdRMxPHgMcxsLrdEZQbxo=
X-Received: by 2002:a05:6122:49d:b0:348:f44e:3219 with SMTP id
 o29-20020a056122049d00b00348f44e3219mr738731vkn.19.1650582354238; Thu, 21 Apr
 2022 16:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220421225515.6316-1-carenas@gmail.com>
In-Reply-To: <20220421225515.6316-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Apr 2022 19:05:43 -0400
Message-ID: <CAPig+cT+KWZNYYCWEoc5Wk4Kp_aQw1m48Tks62CAe2EaYJnc+A@mail.gmail.com>
Subject: Re: [PATCH] ci: make perforce installation optional in macOS
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 6:55 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Using brew to install perforce has several documented[1,2,3,4] edge
> cases that make it fail periodically, so if problems were found while
> installing it, just continue without it.
>
> This means that until the problem is solved all perforce tests will be
> skipped in macOS, but they are still most likely covered by the other
> unaffected runs and will be covered again once the issue solves itself.
>
> 1 0eb3671ed96 (ci(osx): use new location of the `perforce` cask, 2019-10-23)
> 2 5ed9fc3fc86 (ci: prevent `perforce` from being quarantined, 2020-02-27)
> 3 3831132ace6 (ci/install-depends: attempt to fix "brew cask" stuff, 2021-01-14)
> 4 https://lore.kernel.org/git/cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com/
> ---
> This is based on master and can merge upwards except with seen where it
> conflicts with the recently added ab/ci-osx-loosen-package-requirement
> which it is meant to replace.
>
> A successful sample run when merged with master available in :
>
>   https://github.com/carenas/git/actions/runs/2204519374
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> @@ -43,7 +43,7 @@ macos-latest)
> -       brew install homebrew/cask/perforce
> +       brew install homebrew/cask/perforce || true

You do get a vaguely alarming error message[1] with the solution
implemented by this patch:

    ci/install-dependencies.sh: line 81: type: p4d: not found

However, that's an unrelated and existing minor mistake (outside of
the scope of this fix, probably). It should be using `command -v`
rather than `type` in the couple conditionals at the bottom of the
script.

[1]: https://github.com/carenas/git/runs/6119943232?check_suite_focus=true#step:3:116
