Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB4DC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhLPV5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhLPV5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:57:54 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F304C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 13:57:54 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id f13-20020a17090a664d00b001b10156c751so320679pjm.9
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 13:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mRW2bKxaNQOfHJbawx0S61gswICKCVKu/YCKWhS5ljs=;
        b=hWffpIksBjcCVToMzbfxOUIFfYJGj6NKqe5XWqWpdVnueLtD5awzS7NagJI00N/uPC
         qR/WGGDN0f3R6MnR9tgm5rcMyzBwwNSvH97WW0ufbXtonhywR2QhwgLrNMmT8bH52IjJ
         0zbwEJNssCeeEP7goa2Ts3E7Wc+JiuiYxWUbU43NPjc+nBDQoPr41YF3SJLMgf7hPaBe
         Rwzi0uDr8G79dvrqDxq2sZ0uyvGJISqVBTHSpqwFWEq9H9LT+OgtcupdqPIsfvfdSF0q
         QZkifoOFXKj7HEJHAALw6f3tvqTmbHx8U1nQKiOD588uBdW/Shuj2XOa1vWN/xAGRQ0B
         eu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mRW2bKxaNQOfHJbawx0S61gswICKCVKu/YCKWhS5ljs=;
        b=xPQtAY5h+KnBrwvVsjgITEP4HZiiyIEKCpZV2YDeGBPotRHW/JfwHG26bruM8VTUie
         Ftv9gUJnOE7wxsy7kz7NBo0WK1RGBo2O0n9w0taRDpwwGrLkkcbms4/kNIxU0SNfutUr
         dh0Ia2Xk3w6LHcvrt90wl7BGrIkM8UPzrJuxMLnyjauEIYCumZIIfEkV23Tl1dQWKewb
         AsVrHazH+wyDCNStSZfaIMMZpiHd6GQpRdRsZz/vDs8UHnFzYu7qiEJsCDvlW0r/qy6R
         l9hGSIq5q4RdGoAr/kUdpf83ZUezxoiyyIcZWdEWHX95bgE23Cs1kVj9LtaG501xDJHK
         Cnvw==
X-Gm-Message-State: AOAM533wImNZ9r7MGaGcjuENWjz1p6Aig6Za7I9hgcqT9do3HfkvWfTI
        cyiQuMvguHFR5JLfieAmwZ8eS0rQvZj81Q==
X-Google-Smtp-Source: ABdhPJwF3TxHRvUzZGSJOBwCrCwBa/cv8cR/3zT1F0kcVfApTqSmw+zJZb+IGXIsIXBzYjTlLMYwU3NE6cSFUg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f24a:b0:141:c6fc:2e18 with SMTP
 id j10-20020a170902f24a00b00141c6fc2e18mr154744plc.55.1639691873643; Thu, 16
 Dec 2021 13:57:53 -0800 (PST)
Date:   Thu, 16 Dec 2021 13:57:51 -0800
In-Reply-To: <cover.1639509048.git.jonathantanmy@google.com>
Message-Id: <kl6lfsqs8b6o.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1639509048.git.jonathantanmy@google.com>
Subject: Re: [PATCH v7 0/2] Conditional config includes based on remote URL
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks, everyone, for your comments. I've followed Glen's code
> suggestion and Junio's documentation suggestion, as you can see in the
> range-diff.
>
> Jonathan Tan (2):
>   config: make git_config_include() static
>   config: include file if remote URL matches a glob
>
>  Documentation/config.txt |  27 ++++++++
>  config.c                 | 132 ++++++++++++++++++++++++++++++++++++---
>  config.h                 |  46 ++++----------
>  t/t1300-config.sh        | 118 ++++++++++++++++++++++++++++++++++
>  4 files changed, 282 insertions(+), 41 deletions(-)
>
> Range-diff against v6:
> 1:  b2dcae03ed = 1:  b2dcae03ed config: make git_config_include() static
> 2:  de2be06818 ! 2:  7c70089074 config: include file if remote URL matches a glob
>     @@ Documentation/config.txt: all branches that begin with `foo/`. This is useful if
>      +Files included by this option (directly or indirectly) are not allowed
>      +to contain remote URLs.
>      ++
>     -+This keyword is designed to be forwards compatible with a naming
>     -+scheme that supports more variable-based include conditions, but
>     -+currently Git only supports the exact keyword described above.
>     ++Note that unlike other includeIf conditions, resolving this condition
>     ++relies on information that is not yet known at the point of reading the
>     ++condition. A typical use case is this option being present as a
>     ++system-level or global-level config, and the remote URL being in a
>     ++local-level config; hence the need to scan ahead when resolving this
>     ++condition. In order to avoid the chicken-and-egg problem in which
>     ++potentially-included files can affect whether such files are potentially
>     ++included, Git breaks the cycle by prohibiting these files from affecting
>     ++the resolution of these conditions (thus, prohibiting them from
>     ++declaring remote URLs).
>     +++
>     ++As for the naming of this keyword, it is for forwards compatibiliy with
>     ++a naming scheme that supports more variable-based include conditions,
>     ++but currently Git only supports the exact keyword described above.
>      +
>       A few more notes on matching via `gitdir` and `gitdir/i`:
>       
>     @@ config.c: static int git_config_include(const char *var, const char *value, void
>      +		if (inc->opts->unconditional_remote_url)
>      +			inc->fn = forbid_remote_url;
>       		ret = handle_path_include(value, inc);
>     -+		if (inc->opts->unconditional_remote_url)
>     -+			inc->fn = old_fn;
>     ++		inc->fn = old_fn;
>      +	}
>       
>       	return ret;
> -- 
> 2.34.1.173.g76aa8bc2d0-goog

The implementation looks good, and I think that the precedent we are
setting with "hasconfig:" is pretty well captured on this thread. 

This looks good to me, though I'm not an expert in this area, so it
would be good for others to chime in.

Reviewed-by: Glen Choo <chooglen@google.com>
