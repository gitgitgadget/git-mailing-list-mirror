Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CDEC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB34F613D2
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbhDEX3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 19:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbhDEX3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 19:29:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D39C06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 16:29:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so19008189ejc.4
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlmjfAEDD5mo6aV6Q8uZRH21Bz4bsyEsWirWgYK88Rk=;
        b=M7cqPNiuMvOwvJOp/HgBixnZPgZ41Wg/9GYFf6TkE6vW3bokbmXQ0fiv2yejKPIf2s
         +sqA55+8t7CnGalznE5znbfRdZpY6X0GaU0kvOZ/faxxiDGmQ7/kTx7MK6PKAWDcsenm
         vmUdWGNIqqI4Bs+SWiDbuSt9OuPLEdUk9xNleL5zjgXN4o9oQngZlGGbvAeJr0VSHieh
         Pdl0f8bWIP+qD1p1SbqX871V5niVTDr++GrnwVsjLIMPrC3df0RdEus5OCXuU/BEhEm0
         jcokFUqIC6UD9MF1DrpiXceJzL1jaHY+91cGVjEx8XJN5ygqLeDp4tn3hXEwx1nSRzax
         Pn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlmjfAEDD5mo6aV6Q8uZRH21Bz4bsyEsWirWgYK88Rk=;
        b=MZy4eUcpH5rhgwuVHIekTvjke/A67vv1zHp+OkJIlt703PZJlYSVjg2Tsk200jUIr+
         p4UUmw9lTscWgKW1lQWYdfdV96tPcyWhUnWngTeauuk+EYuAdPg7gWGvX/ctRcREoGcz
         Onjg0A1m83w0c/Z+th30Nz3/F3u/+QpYGpNTuYt2+5LAkcd5NXVYnURKak4eVppsXFFy
         Icx+CAYwLVLYVcY/AIr22xgGI6MmuAsDb6YjSQ0sgbOW1nuRmZSJ2C8PUflEj5Ubexw8
         n8HpqdgE0RLrwW3IYUbbWTMNiYzofXshO9mkSSIbCM9OfnKWGhAHUArAryK0//ek0A3l
         vhTw==
X-Gm-Message-State: AOAM5333DRnWDsBaEuYFD6DHZDsfOSb/gr/aYrGxSzLaR/ftZaiqhJMS
        5yll6a9vou3UNx5NeNdDx78VZQdEIBYoQaYCVJUUgQ==
X-Google-Smtp-Source: ABdhPJz2fhy1Q6wziHc7E30ouUFl3siEDQ3CxVIflKL9/UVit+XX3y9sCwDwT8zdcYx/vSjuS+/Og6bfGo516LmZs+0=
X-Received: by 2002:a17:906:2dda:: with SMTP id h26mr30851429eji.163.1617665365837;
 Mon, 05 Apr 2021 16:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210403013410.32064-1-jerry@skydio.com> <20210403013410.32064-2-jerry@skydio.com>
 <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
 <xmqqy2e00zaf.fsf@gitster.g> <xmqq1rbq276g.fsf@gitster.g> <CAMKO5CtCk_sJsFFiKKFR1wCSyY226CbxPtN6=p6JRzocSuv8jQ@mail.gmail.com>
 <xmqqy2dw4bh3.fsf@gitster.g>
In-Reply-To: <xmqqy2dw4bh3.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Mon, 5 Apr 2021 16:29:15 -0700
Message-ID: <CAMKO5CuYE1VA2h2zDo-b77WQDgj1LriwifruziPA30Yb7uS=6A@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-apply: Allow simultaneous --cached and --3way options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 5, 2021 at 3:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > I can see what you mean about the user safety issue. However,
> > my specific use case (see cover letter) involves an index that does not
> > match HEAD, and wouldn't be possible at all if we forced the index to
> > match HEAD. Furthermore git-apply --cached even without --3way
> > doesn't force the index to match HEAD either, so why force it now?
>
> Primarily because we tend to be extra careful before mergy operation
> than any other operation.  Especially without --3way, apply (with or
> without --cached/--index) is extra careful to make itself all-or-none
> operation to be safe, so that there is no mixed mess that requires
> manual intervention (which would further increase the risk of mistakes).
>
> It is OK to introduce a new option to allow a dirty index, and your
> tool can pass that option when it calls "apply --cached --3way", but
> it would be safe to require a clean index (it does not matter how
> dirty the working tree is ;-) by default.
>
Sure adding the staged files will definitely clobber whatever the user
had in the cache at stage 0. This will probably be unexpected. But
the normal invocation of --3way also does this without warning, since
it touches the cache as well. It just seems odd to me to be adding a safety
check on some paths that aren't there on other very similar ones. Maybe
another option would be to add a very stern warning for users of --3way?

Unrelatedly would you have context on why --3way falls back on 3way
rather than trying 3way first then falling back on apply_fragments if
blobs don't exist? I see some cases where the normal patch application
will succeed but apply the patch incorrectly, while 3way will apply the
patch correctly. In these cases it's impossible for the user to force 3way.
Are there downsides to 3way that aren't solved by falling back on
apply_fragments?
