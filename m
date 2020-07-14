Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72728C433E7
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A3920656
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 21:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuDWDYwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgGNVi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgGNVi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 17:38:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D2C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 14:38:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o8so973922wmh.4
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=o506WyDq+1RP/99vBfKl7tR0ErbpkZC6jp/HhLIC2+s=;
        b=VuDWDYwXlio9f1Nbe8rGi2/bNdK5PKAXfI4o9xdZg7yXtBt85refjtEC8tW4FmaisH
         HtRTLUVwHQfxup5zVvFyg6+fxrfe/PHVmiVNYkSQfWBXojyfU+2QfKmXJTjYG10zGgA2
         SFOdAFpzbRKTqFaRBHqea+8kkMHagSe23tgeCo1U2WbUfUlO7AciqLPoYhTGsSKAXr9n
         q/F/eBZ57kMqtuX+BC/B32+mEtIlOWWRK1RgbLAksplg202J+qFe79vGgBs2B3JUQiQ8
         Ev/9VrWd4GMkuT5ZBsboVo3rRaZ9+hunxrjL2ucLj35At7FrqJNjvf0igG91rnW9H56Q
         Vsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=o506WyDq+1RP/99vBfKl7tR0ErbpkZC6jp/HhLIC2+s=;
        b=cXr8oKTCvnhPxZkqmPbJv9a9OEzHW7r2Rwx6MpFgLUl+ECxzIsVxcrGZYf01e32jvE
         vhafkysXQ2mCm7Qw7XH/iNzVVjPUKWnvbx03nwJt24mtow7y/TOiFABtUtSaN+sF2jr0
         CUAsZmKPx9eahB4g8ROcvz5O/CAX1OEUr/9HMT6u8gXchpqTG2idiBXufyzhRQ6dIG7b
         5u/9unihbbpkGE5HnDdcS255evGtBhPXt9dbQOZs9/rnfYvzGyrMOmTNFoKyueBnqe8d
         yI4Whq3R42pE3LUCTS/i4t7+pZrTKB94dg5lk9a5gyMsQdo0w0iTFazy5D66O6BDjjOe
         VxoQ==
X-Gm-Message-State: AOAM531cZyrGPeJQLdg1rAVfIOPd3R3lGeNZSv7pT5iRVv3xzp5b97Zp
        Oq/koSjt91kIGnt2dXnuWUCKF9JpK1uYtyvJXbaf+1iQBN4=
X-Google-Smtp-Source: ABdhPJxPClDNRsWmKpJ7o6KackO8+/3+dTGm4zGsiGPQTCuulmzx5vbBy26gQ4jIYoVd5syJViPPHvHNSe9YwWx/WZw=
X-Received: by 2002:a1c:6006:: with SMTP id u6mr5420816wmb.111.1594759098270;
 Tue, 14 Jul 2020 13:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <CABXAcUxw5EA6jPB93C-Cfg-tycLMQSKUgrLkLXSQUZPHeEva9Q@mail.gmail.com>
In-Reply-To: <CABXAcUxw5EA6jPB93C-Cfg-tycLMQSKUgrLkLXSQUZPHeEva9Q@mail.gmail.com>
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Tue, 14 Jul 2020 13:38:07 -0700
Message-ID: <CABXAcUzvZgHwsfL8VaevnDeyyce_5sWtd2istA55CgnzFE1Z6A@mail.gmail.com>
Subject: Re: 'git rev-parse --show-toplevel' errors out with per-worktree configs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> IOW, this works:
> git clone <url> non-bare
> (cd non-bare && git worktree add -b master2 ../wtree1 master)
> (cd wtree1 && git rev-parse --show-toplevel)
>
> This does not:
> git clone -c extensions.worktreeConfig=true <url> bare.git
> (cd bare.git && git worktree add -b master2 ../wtree2 master)
> (cd wtree2 && git rev-parse --show-toplevel)
>

Sorry, I mixed up my examples.

This works:
git clone -c extensions.worktreeConfig=true <url> non-bare
(cd non-bare && git worktree add -b master2 ../wtree1 master)
(cd wtree1 && git rev-parse --show-toplevel)

This does not:
git clone -c extensions.worktreeConfig=true --mirror <url> bare.git
(cd bare.git && git worktree add -b master2 ../wtree2 master)
(cd wtree2 && git rev-parse --show-toplevel)
