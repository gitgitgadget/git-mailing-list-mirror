Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806621F404
	for <e@80x24.org>; Mon, 19 Mar 2018 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966783AbeCSQzd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 12:55:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35547 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935120AbeCSQzb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 12:55:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id r82so6504090wme.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=etsQ7tMR2SdLKmauy7Eb3ejHgfozWR5kOs/Xc9dwJDc=;
        b=EoeQ9iSDv/NEd0KEXkIOX5aYu7egrDwO+sQ3OykqinuNoI0ZHS2lOT2nMpgMu50MsS
         /VQHG4P4Q46KR/civ8CHPEY2dazdg9v2lqUN73XBvXGj7+VThjLRK3kSgOHnW9prPqSq
         61fMssPe+F2wOOHnE5NNgNlk5rYkG1IH0srHJvpMarkJQ8VwHntTuWmjFJhTeySscrrQ
         kJ/H865QL1qSpSaP3S3Y/17AraOJJ1KoQoaC37JRvAO5PC05E34xNofPH7faUoq1QLlZ
         qP9Be0s9T9cTL3vdoLoLuQY1/cw/iy0Tr6yd4V4XeVaVYGC3KxBt0joRAGY3CsG03ob3
         RgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=etsQ7tMR2SdLKmauy7Eb3ejHgfozWR5kOs/Xc9dwJDc=;
        b=nXhAbGPcao0YWEfWHwo17OcE3vhpqCzD69U2/Cc7d+C5N0zrUwFdynuNILYR1PfnFv
         8UfXg5Y0fYLqFoRjOtvjd/ZYeoP/yOD2iAQS/LEJ4MmqvrWxTEx4ozxk+/Uc0jVJgf/q
         DbKlxBiIOvBATNc9km+M/VZiU6ZjFWycSzvrDOXNpiERrYNURqPeNWe6E0V80U8bF4zl
         NKwYdUQOoDLcEVPQKpbCByb5OoymBRwE0Ep0O6R6bNbzp6TcxVrEMobHw38oWVeQNib+
         rIiy6iwHa7+of9hfZAhfI2wIQvJlE4H+i+95YhQ/hfZz/lf7TwBZ0EGotXzRNIJmF8gR
         OSjA==
X-Gm-Message-State: AElRT7Gm9uMinFzDy0aP7DdjX74nN6yx/ec4s2YoXKRxJ8DVGnagUDMv
        1mZX5zQ3V+5pmnkkRvhSOvs=
X-Google-Smtp-Source: AG47ELuJD9Z0nozVNmWLIR9UTM9jI6nqv9X1lvLYCmSRqDyj22Bk4cgkqBRhVkbtpbXPHRO8M9aYew==
X-Received: by 10.28.173.198 with SMTP id w189mr9848090wme.139.1521478530046;
        Mon, 19 Mar 2018 09:55:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n7sm531840wrg.20.2018.03.19.09.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 09:55:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: complete tags with git tag --delete/--verify
References: <20180318040135.30710-1-tmz@pobox.com>
Date:   Mon, 19 Mar 2018 09:55:29 -0700
In-Reply-To: <20180318040135.30710-1-tmz@pobox.com> (Todd Zullinger's message
        of "Sun, 18 Mar 2018 00:01:35 -0400")
Message-ID: <xmqqk1u8vwce.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Completion of tag names has worked for the short -d/-v options since
> 88e21dc746 ("Teach bash about completing arguments for git-tag",
> 2007-08-31).  The long options were not added to "git tag" until many
> years later, in c97eff5a95 ("git-tag: introduce long forms for the
> options", 2011-08-28).
>
> Extend tag name completion to --delete/--verify.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---

Thanks, makes sense.

>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6da95b8095..c7957f0a90 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2967,7 +2967,7 @@ _git_tag ()
>  	while [ $c -lt $cword ]; do
>  		i="${words[c]}"
>  		case "$i" in
> -		-d|-v)
> +		-d|--delete|-v|--verify)
>  			__gitcomp_direct "$(__git_tags "" "$cur" " ")"
>  			return
>  			;;
