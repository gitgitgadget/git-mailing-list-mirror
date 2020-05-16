Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A42C433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6542074D
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acrC841F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEPLEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEPLEI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:04:08 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847CC061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:04:08 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id k4so1746665uaq.10
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zP1erzppfcucrVpQUt2e4UK+n/juXWLcMbl7ICHO6N4=;
        b=acrC841FP4HVKEW+CaqUeuY5mo3IgBUzSJxAfYQx81A2YLIvNv/E2PvkKc3cxRcZPL
         CnrFIHk2c/D0ebB+gwAo2zoSpyojmZqrChNpRI/foLuhyuL3WfWuxWqK4+Wq1SX+6Gls
         vhV3WncY96tQTuFuUvCF/f9xt1jVguBfHoGwzK79badDTFxmysdXvVh/1LV42d30zvhZ
         SaXOZOs53fnCxps/JZAVDIjr5AXNsGiZuCTSogUGPGhGeuy20bZbkxtziu/1HMoypOE9
         JmijTAc/58teuFGGXlQ4/2lVjBZvEDJ9EVJj3dpPueKE4Qxc7CAqxKLVqv9ovAl4cKdw
         7vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP1erzppfcucrVpQUt2e4UK+n/juXWLcMbl7ICHO6N4=;
        b=B0goOgcFKbvwJFwyyWO7L8R/e2IMeNNvGQIUan4iRwyNa/4MyIYqYz//ViU7yFDM94
         tfgUacrW28dzwr1e/AgbAFXdNFC3vWnu+mFUsGycMV2L6hGVfbPWogg2P8B5HZGeDvAc
         WSqxGG0QgGhzKmJywPa87cUUJblPXrq44/JzkEJPjizVU2VMl1fmUZrIiMi5KT23h32r
         O5EmlJq+w2HDU9YpgG4kF4OalZqX/V2tgVovfkz5wqFlNGuACxPbq4Kfxej2gcm25ZCd
         d1JcV6l9N6FfTvMWPrNMTgDbdPwhyYv3bv0Iy42iXu7qeKsq5eR9w4sRgSguw3SXfAMc
         JFZg==
X-Gm-Message-State: AOAM531lRSPnqVtEj62FaEji7N4LijmTuCotxSGAto6NoWR86gOWq3g+
        YwdEJcMNKwRzsH5mD+nDZvVFxoC+3UrKqvDoKL0=
X-Google-Smtp-Source: ABdhPJz2ZRJVjtnpOeiIRlMJ1fPABz+eBoYBqJYJCSqNyK8ndFQVtkYyfbxmgEpfJzDJw5zgS5t8c8ploRXQV7C5Kl8=
X-Received: by 2002:ab0:544a:: with SMTP id o10mr5713057uaa.15.1589627047645;
 Sat, 16 May 2020 04:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-24-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-24-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:03:56 +0200
Message-ID: <CAN0heSrMrXE2g4LaZ4A71CxGteVfE2RfsT6WyGzmfFSHFKjATQ@mail.gmail.com>
Subject: Re: [PATCH 23/44] setup: set the_repository's hash algo when checking format
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> When we're checking the repository's format, set the hash algorithm at
> the same time.  This ensures that we perform a suitable initialization
> early enough to avoid confusing any parts of the code.  If we defer
> until later, we can end up with portions of the code which are confused
> about the hash algorithm, resulting in segfaults.

This doesn't make a difference as long as you just use SHA-1, right?
That is, this isn't a bug in the first half of this series nor in
v2.27-rc0 as long as you stick to SHA-1?


> --- a/setup.c
> +++ b/setup.c
> @@ -1273,6 +1273,7 @@ void check_repository_format(struct repository_format *fmt)
>                 fmt = &repo_fmt;
>         check_repository_format_gently(get_git_dir(), fmt, NULL);
>         startup_info->have_repository = 1;
> +       repo_set_hash_algo(the_repository, fmt->hash_algo);
>         clear_repository_format(&repo_fmt);
>  }

Martin
