Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D613DC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhLGRtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhLGRtw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:49:52 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F4C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:46:22 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so9035821pfx.21
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EgN9vuZsMAFIoJE5AlNCG2cFDr/rWehkURk/axs43bo=;
        b=SNn/rAxTymvA8oZGeJ1sO8HnAhEJ2+mUYZk9CUeLyfGVB3uQ1mwdHPCMIQUR9Vwm8o
         x5lcrr2boAQbP1SFhKeCU5FjDuZ03llOd1ot2purdQj9dmm2hLiIlpe6EqP/dVem5kKS
         Ugc2bkyM29PgeHvtdjbk3UyQR4fHye04I9AL4EKsF6s3kA1ADKSjHbKA5xHRN//ON0B+
         KqpUHVimD06ZGl+QQJKXZjsAaa+LgDrVxgKaT0N/LKLOp7FvGduSfD3dRBncDIxo6BWs
         YL0sJWXAN3BitJhBopAmWXGZ3yedL8Z8UukfVF/x9DOuqqnBZ3bHQr8iQckHpOnuMr9L
         Tqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EgN9vuZsMAFIoJE5AlNCG2cFDr/rWehkURk/axs43bo=;
        b=7FJuK6y9R2nk2SxhK1d4VCJ21Xte1Wv8CeTttkoTRcPulR8p8OQ/5iqM+bSsLmL15u
         BujgLEEqVyIm/f001S07acIiLYOBdGmCn7ukld4pu8vxeMnt/Mc6wC+Hg/CaKichfCRf
         nIBLV9WUZN4qCGb9MAseWSRycLTcLqszx2EBEw0sBnClg6JE4+jt0fqWHLXlEUtXhTeb
         4dzmCDKM+z+yMZk35DaqWWQEjch6bKsbH0XaErS1Efc7XFKZZVlTTlYy0/MooYLTsbrm
         GGnTZBPkc/kJWxi2q3wKwtRPYC47X+0y+IhZn8mf5KS2u28QKAu1zUibX2Gu9Qn9IOou
         D/6A==
X-Gm-Message-State: AOAM531wg5iSV3v8Nxp9fl7Ww42N+A1mv+gXjS5zHuwNJN7unc0qqOnO
        y16FDgWXPmin7IY/EDiMnaoblhBAH+/GUJ6qyLZZ
X-Google-Smtp-Source: ABdhPJxahVLJaclUhF8qTKHeuvrf9Oc5l08+41qhsCd62hVesDisQqOyh+OI6EzU53nJzksqaFKdR7ktj6r5PATtBUwO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8e48:0:b0:4a7:fe01:5971 with
 SMTP id d8-20020aa78e48000000b004a7fe015971mr631389pfr.20.1638899181765; Tue,
 07 Dec 2021 09:46:21 -0800 (PST)
Date:   Tue,  7 Dec 2021 09:46:17 -0800
In-Reply-To: <211206.86zgpdpmyy.gmgdl@evledraar.gmail.com>
Message-Id: <20211207174617.1118046-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <211206.86zgpdpmyy.gmgdl@evledraar.gmail.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: Re: [PATCH v5 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, chooglen@google.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I read through this and came up with the below as a proposed squash-in
> just while reading through it. These may or may not help. Changes:
> 
>  * There was some needless "$(pwd)" in the tests

Ah, thanks for catching that.

>  * Inlining the "remote_urls" in the struct makes its management easier;
>    and the free/NULL checks just check .nr now, and string_list_clear() can be
>    unconditional.

I don't think we can do this - nr might still be 0 after a scan if we
don't have remote URLs for some reason, so we still need to distinguish
between not-scanned and scanned-with-zero-URLs.

>  * Created a include_by_remote_url() function. Makes the overall diff smaller
>    since you don't need to add braces to everything in include_condition_is_true()

Ah, good idea. I'll do this.

> Other comments (not related to the below):
> 
>  * It would be nice if e.g. the "includeIf.hasconfig:remote.*.url globs" test
>    were split up by condition, but maybe that's a hassle (would need a small helper).
> 
>    Just something that would have helped while hacking on this, i.e. now most of it
>    was an all-or-nothing failure & peek at the trace output

What do you mean by condition? There seems to only be one condition
(whether the URL is there or not), unless you were thinking of smaller
subdivisions.

>  * Your last test appears to entirely forbid recursion. I.e. we die if you include config
>    which in turn tries to use this include mechanism, right?
> 
>    That's probably wise, and it is explicitly documented.
> 
>    But as far as the documentation about this being a forward-compatible facility, do we
>    think that this limitation would apply to any future config key? I.e. if I include based
>    on "user.email" nothing in that to-be-included can set user.email?
> 
>    That's probably OK, just wondering. In any case it can always be expanded later on.

We can decide later what the future facility will be, but I envision
that we will not allow included files to set config that can affect any
include directives in use. So, for example, if I have a user.email-based
include, none of my config-conditionally included files can set user.email.
