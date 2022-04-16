Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F4AC4321E
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiDPCKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiDPCJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:09:35 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11942E0B4
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:07:03 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cp8so3895341qtb.6
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0iKh/QrfO5p5boSvPEjR+cENgp0eqkWHaY1MiWyp1IM=;
        b=3emfenAf0F5o6A3MIkT3O1IL3rZunuzfLfzAikrc4qoDoJkDLbM+nBo4xdQm2dcO63
         kF4lSmTmnejkbXY6KUOsOamRJKYq/mK/o5fV7mPWW2j9X34DDAwVQUiWCLPJ620OJGwY
         Pmel1IX0OPJLuRz9lUhueuOYF+uzPxm5wPY38jUA4DRIdvKXFHUTt/NSYH+QWL947QNj
         1/h4k0GHe6sDjEhR+yo8vjCyrW+RKRHZXAo62uyoMPMydPxLg1brXZ67Ad/CLfs9Lo4E
         KWGDxs/ts6S1YAer0uD3dgtg1ipRdEeMWt5dZ1F3f535a4VtkijN5U/hHR7DJMxun2kQ
         0JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0iKh/QrfO5p5boSvPEjR+cENgp0eqkWHaY1MiWyp1IM=;
        b=ffpP/nARYGnpuU5NW1tXP+g+I/TsQ6uskPewwW6yFzH44o+BJFjyn2/cZ4mjrcIpSX
         lIvPknKnsV1mied+M94Nw1r8ReVHJpD06eD1eDDLafnqhavFXdEUyaG8F43h1gLKjBFn
         jAyqkxm0igvrghJ7xOHAi5x02RoG8nHwIVYOsSLW4UEGQzIA2lhLEGyHrWT3H6ZxUyC6
         KQi5fNlhS9vc1WDOCOt/9DNGSRHSCrQJQtHT+C14VswutEPYvm2kIju0binJ+EeF8rs8
         MZGYGNrEhAoBk2sxlw8CUeqSnQyoXr5DHVmMSguRxn3idbXSP96/OnTFE8S75U44kBeF
         IhxQ==
X-Gm-Message-State: AOAM532S7QLZch/0j8bhNfPJgifJLMyFKvpDZss7tfC0QZdUxEX4D4IV
        djIBRjn9z+/w+wJ+gIyr+ffQzBItTg4H8AjY
X-Google-Smtp-Source: ABdhPJzpj60acBpFSLfsJYVyXt47AX6q8Zg7J4xISoN5M93cdSy0NzWqDLp+bKlmJnMfiP0eMAeUJA==
X-Received: by 2002:a05:6638:13c6:b0:326:7f21:be60 with SMTP id i6-20020a05663813c600b003267f21be60mr665770jaj.218.1650070807657;
        Fri, 15 Apr 2022 18:00:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r13-20020a6bfc0d000000b00649e7a72afcsm3600272ioh.29.2022.04.15.18.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:00:07 -0700 (PDT)
Date:   Fri, 15 Apr 2022 21:00:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <YloVFn0SC/SF33b3@nand.local>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnfs4kud.fsf@gitster.g>
 <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqh76ucdg6.fsf@gitster.g>
 <kl6l5yn99ahv.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6l5yn99ahv.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 04:45:32PM -0700, Glen Choo wrote:
> However, this case shows that --git-dir won't work at all with "git
> init", and I wouldn't be surprised if there are other breakages hiding
> just out of plain sight. This worries me a lot more, and I think
> disabling bare repo detection wholesale might be a nonstarter.
>
> I wonder if all we need to do is make setup.c a little smarter - we
> recognize bare repos, but *only* if they are contained in a directory
> named `.git/`. This should fix "git init" I think, because even though
> we'd ignore "./ (bare)", we'd recognize `../.git/` and we get the right
> behavior again.
>
> I haven't tested it yet, but this proposal sounds like it has quite a
> few merits to me:
>
> - Easy to explain.
> - Easy rationalization ("We used to be quite cavalier about detecting
>   bare repos, but now we're being more strict by default").
> - Fixes the embedded bare repo problem (since we don't allow .git).
> - No-op and neglible performance hit for non-bare repo users, even if
>   they occasionally run "git" inside ".git".
>
> As with the original proposal of "ignore bare repos altogether", this
> will still be a headache for bare repo users (unless they don't mind
> renaming their bare repo directory to ".git"), so this behavior needs to
> be configurable, but perhaps the fallout is small enough that this
> could be a safe default.

I think you are underestimating the fallout, at least if I'm
understanding your proposal correctly.

Is the proposal to only detect bare repositories that are called `.git`?
I think that's what you're suggesting, though can't we just as easily
embed a bare repository named ".git" in a clone as long as its not in
the root directory?

But like I said in an earlier message, I think that this is vastly
underestimating the number of legitimate repositories that are stored as
bare repos on disk (not embedded in a non-bare repo, nor named ".git").

Thanks,
Taylor
