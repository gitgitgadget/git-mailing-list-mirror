Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2766FC433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 19:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbhLWTIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 14:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbhLWTIM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 14:08:12 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE28C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:08:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b4-20020a17090a6e0400b001b179d36a57so6169371pjk.6
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KXDe0LTkM7ilPAOLhSTkvW/Ar1kL7lzgqbIum+UWR1E=;
        b=PT/5UZC4iPVbRR/je3H5a0pY1p14ueuu/9w194/XbCd15A9cV3FYiiOAQN2UAqeJNy
         3qBXg1xztDRx2HTGv9qCamgPcQwNNnbM/xuaHmHqfqUIy8TPume8euZVaOk8Gi0jMQ8U
         7AE0G+xO2iZZ0LfjZtXJV/whH7IMSsU/pfIKl3uxsvxhAK1IYm3U054cfivpzpnmMvmL
         K4xzpbpIMZsJW185MiTgyGdh8jisbSM8GLxik+GZRfQOj8HS2XiHGT1++nwodvDkBbWP
         bxzDVV8PaOshpEFEFyy6JM4YJafLPzgH2I1htkDhvhUozdiK6a7qQMxsJlbbzGdiZgbx
         U1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KXDe0LTkM7ilPAOLhSTkvW/Ar1kL7lzgqbIum+UWR1E=;
        b=wCSNmItEV6zH7e6WY+DUgDlQhxfvL1SG+RNVyQppzb6XBw4qfLZSI2tvu0Cd4oV9Ng
         0oOm93vV3380NZv6LorBo9lE/S1u3lDzajPz5woZg/XHsvH+P/vgn4rAfEorpFpX2SIf
         dOsLej31574dPBMkqtWQ7RYBwg/m19RbriIW04QGlzOAcXoAOnzzMkcBf5ol1x8lkzW6
         MuUAw4M6etQ9lZvK4OnL9FRNKQC2XxDGgGQ3bSzwJDAaoAPoU9u1l7iLt6awL5pg8PLr
         RYgjUAc4DksOYxeaLAilT1NTZirn/D6UL7E16oq3RmFcZXnwKJm5iOW5/W4+KA39820g
         E7vQ==
X-Gm-Message-State: AOAM53328ROd4ggUa9mHdC8qgkKp/YcoGLY5BnP1Vi2p0ITGNaNwQByk
        38DTRZGmRz/NAJhokZ/NXwkBc9lmmw00eEZ5h8QS
X-Google-Smtp-Source: ABdhPJzegYGE//s67/Vhqr9xvMW6Hr4hI2npKoTTU1ClvmvdqYMgMvSR8F53u0/A7GQoOua+unv5ehkLmxX2KWf44nuM
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:43c6:: with SMTP id
 q189mr3237244pga.424.1640286491423; Thu, 23 Dec 2021 11:08:11 -0800 (PST)
Date:   Thu, 23 Dec 2021 11:08:08 -0800
In-Reply-To: <20211222001134.28933-4-chooglen@google.com>
Message-Id: <20211223190808.1285008-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211222001134.28933-4-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: Re: [PATCH v3 3/3] builtin/fetch: die on --negotiate-only and --recurse-submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> The previous commit ignores the value of --recurse-submodules if
> --negotiate-only is given. Since non "no" values of --recurse-submodules
> are not supported with --negotiate-only, make cmd_fetch() check for
> this invalid combination and die.
> 
> This is unlikely to affect internal usage of --negotiate-only, but it
> may be helpful for users. We may also want to discourage users from
> using --negotiate-only altogether because it was not intended for them.

All 3 patches look good, and I'm happy if they were merged as-is.

Having said that, I would delete the last sentence - I envision that
other tools may want to use --negotiate-only to be able to better query
a Git server.

> @@ -75,6 +75,7 @@ static struct transport *gtransport;
>  static struct transport *gsecondary;
>  static const char *submodule_prefix = "";
>  static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static int recurse_submodules_explicit = RECURSE_SUBMODULES_DEFAULT;

I would call this "recurse_submodules_cli" as a config variable could
also be considered explicit.

But again, you can consider all these suggestions as optional.
