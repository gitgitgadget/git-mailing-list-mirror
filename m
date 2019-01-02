Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549DF1F6A9
	for <e@80x24.org>; Wed,  2 Jan 2019 23:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfABXja (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 18:39:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38584 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfABXja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 18:39:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so29041790wml.3
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A0OqEkUBf6dtq6Q4XHBIqrvP/t+8bFxcQlNq+OBQNDA=;
        b=veCBEK7TpBsjC+VoqFCwNlnHmH7XKaz7uKtP8vWZZYif91XGGL7Hwe2/O8z0GQaa6z
         c9SwVZgxbpqv6vzuExS3xXU872MlzkcXLIyMCj3lHnRUcDaR4+FkV33ApYL1/bSgyYDx
         +xpUKtL5ImybDwrQh9jSLTGP3XSrtmGZeUTt6CX0pJNWr8KE+nQvsYRICK6c/nhPs88O
         q7DcIj8IRC3HjjsBSI2Z+5ca5q1oSFpuMRYTAxNTBsNkq08gmnc+QhpJVJK5Sr+gHpWh
         Xo6DJMHU87bVSxA1eO/2ulAfKK/tdFkO25GFsyiwfB0QiBkEzkHA0m3udceCBvGcHT5i
         BunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A0OqEkUBf6dtq6Q4XHBIqrvP/t+8bFxcQlNq+OBQNDA=;
        b=HUblrnLimItNUWCVOaRsDIPQf7NvLbtCY4HvTnBLL6t18mxUzVCX/cBXrOa9uS0jvX
         HTcXNdQaKXrFVPSXCJXMhEW3K2BiMhKIjV9oyqLgT/+jIz4rZSovG7gf0zOyPvS0z5vl
         IXF14txpYYeN4POKYUBxgezNYCtZZE0MDpd4BFg5MSjviaFnqo+bOGGMDvCcBdIRT2tJ
         wcRYioKbO1tluOYeB5A2w5F+fTeOzPtAtCqub/msXQkBSS7/fSQ768TMvnIrELEXKpdm
         sOkPocLoG2ZDo6AxsLgm+iCk27cP8aoUjYoO/e94LndCcFkgMf7dd3m2vJuOh3RJYyhj
         M5jw==
X-Gm-Message-State: AJcUukfyRX8EJR+avOql+T1649D5HGDfARIcDG8aJc5diPX0wMzdmS2L
        0fSMqYiq6ZHrtfwUVVvRQMU=
X-Google-Smtp-Source: AFSGD/WezfY4PhYuM6k3RfXnhHDqiTNcivRezmGZTgc7ZEKzPnt+VtU/Gu0p2wU7YoGdazsxVlM3VA==
X-Received: by 2002:a1c:cc2:: with SMTP id 185mr38143377wmm.1.1546472367108;
        Wed, 02 Jan 2019 15:39:27 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l14sm111114503wrp.55.2019.01.02.15.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 15:39:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 8/8] checkout: introduce checkout.overlayMode config
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181220134820.21810-1-t.gummerer@gmail.com>
        <20181220134820.21810-9-t.gummerer@gmail.com>
Date:   Wed, 02 Jan 2019 15:39:25 -0800
In-Reply-To: <20181220134820.21810-9-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Thu, 20 Dec 2018 13:48:20 +0000")
Message-ID: <xmqqo98yiq8i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> In the previous patch we introduced a new no-overlay mode for git
> checkout.  Some users (such as the author of this commit) may want to
> have this mode turned on by default as it matches their mental model
> more closely.  Make that possible by introducing a new config option
> to that extend.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  Documentation/config/checkout.txt |  7 +++++++
>  builtin/checkout.c                |  8 +++++++-
>  t/t2025-checkout-no-overlay.sh    | 10 ++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
> index c4118fa196..53f917e15e 100644
> --- a/Documentation/config/checkout.txt
> +++ b/Documentation/config/checkout.txt
> @@ -21,3 +21,10 @@ checkout.optimizeNewBranch::
>  	will not update the skip-worktree bit in the index nor add/remove
>  	files in the working directory to reflect the current sparse checkout
>  	settings nor will it show the local changes.
> +
> +checkout.overlayMode::
> +	In the default overlay mode files `git checkout` never
> +	removes files from the index or the working tree.

Technically the above "never removes" is incorrect.

	$ mv COPYING 1 && mkdir COPYING && mv 1 COPYING/COPYING
	$ git add COPYING
	$ git checkout HEAD COPYING

would remove COPYING/1 from the index and from the working tree to
make room.

Because I think that a bit of white lie like what you wrote would
help readers understand the key point of "overlay or not overlay"
better than an overly precise description of the reason why the
removal in the above three-liner case is the right thing to do, I
think the text in the patch is good enough at least for now, but I'd
mention it in case somebody else can think of a better phrasing to
covey the same key point without being technically incorrect.

Thanks.
