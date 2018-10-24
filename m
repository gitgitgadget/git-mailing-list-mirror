Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461DC1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeJXMXA (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 08:23:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56220 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeJXMW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 08:22:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id s10-v6so1710264wmc.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 20:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J2hF0EoOIUgS9+WmnKxFgPtQw6FuD3ZG9FfuE4aM9so=;
        b=jtwVNtJcyW+bbtbddEPJPQS41nBHRLLg4A65rh5eQn+tekXzXCup8jJ0rv7tJdosMR
         zgNoABoIANsrpXZx2Lncn9TQAyRCwO09Q9iofOb/DcZjROoWXub45jBt6jtB+QKdCYH3
         e955PDYL6rHvWBPmSwjicIebi/T0GFSN/KsqWeea/3oHrDQHtb0PuVnhqwGVxMXQDjfK
         a/F73T/xTtVbSa7L7Ic0+l6QpraqKbtkx8rF78GeutNxy0NxbLg+7Du/bHNqb9/GeICP
         jZxSc56sh369pW8WL3IGAyVAdi1uoVtsUUy3CTSQP3CQ4Gy402o9ctTA9b3omRmB1Qv7
         tNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J2hF0EoOIUgS9+WmnKxFgPtQw6FuD3ZG9FfuE4aM9so=;
        b=IquoACVftkm5a/1cVpis1EShJTYEIJhy2HRgmNIQQonD63OG90jLVQ+ddZF38KrHx5
         ulewsRXPw5AKaRBUmM/lqEDUjZCkYdNP8iu7rCSCppN87ehQtbNBZWHYmhNYzWbtoxhL
         meiiAIDFfgulsw2nQ7zccT2pr2emnIOMdyAF342tS/uoeGAv+MJG/pscJyIrYurSmFOv
         baqS1uC8bxTQLpmYbNCkBwIxVVEFVLpkFw4/mrmr9NCipCDMtmaXbAFCsANt2saMJhdH
         e3WIkgEgPOab7ny1UnzGkzODexDc/W/uU97Q7v03GterI+drt+aR706UJZJMUB5hv28I
         v4pg==
X-Gm-Message-State: AGRZ1gK/Y+TWTjQ+bAHbX2yEdWwV/bWmwRlBOE9P1UT9wECyC5FD74ZR
        ebqQ3QDhOyw3/FPBnqLlQJs=
X-Google-Smtp-Source: AJdET5cHKgK145/MndbUmz/43b5tCABto/DsxXOBPSBqOfwxjVJ4ox3QYAYkQx+CmvymUXjlPkszGw==
X-Received: by 2002:a1c:85d0:: with SMTP id h199-v6mr714034wmd.127.1540353401082;
        Tue, 23 Oct 2018 20:56:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l5-v6sm2549714wrt.43.2018.10.23.20.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 20:56:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] repack -ad: prune the list of shallow commits
References: <pull.9.v2.git.gitgitgadget@gmail.com>
        <pull.9.v3.git.gitgitgadget@gmail.com>
        <1f9ff57d52a72e3795ac4a924e23a64b91b1f83e.1540245934.git.gitgitgadget@gmail.com>
Date:   Wed, 24 Oct 2018 12:56:39 +0900
In-Reply-To: <1f9ff57d52a72e3795ac4a924e23a64b91b1f83e.1540245934.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 22 Oct 2018
        15:05:40 -0700 (PDT)")
Message-ID: <xmqqin1sov48.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/repack.c b/builtin/repack.c
> index c6a7943d5..9217fc832 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -549,6 +549,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		if (!po_args.quiet && isatty(2))
>  			opts |= PRUNE_PACKED_VERBOSE;
>  		prune_packed_objects(opts);
> +
> +		if (!keep_unreachable &&
> +		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
> +		     unpack_unreachable) &&
> +		    is_repository_shallow(the_repository))
> +			prune_shallow(0, 1);

The logic looks correct (and the reasoning behind it, which was
explained in the log message, was sound).  prune_shallow(0, 1)
however is not easily understandable.

There are only two callsites of this function after these three
patches, and the areas of the code that have these calls are in
relatively quiescent parts in the whole tree, so it shouldn't be too
distracting to do an update to make the function take a flag word,
so that we can make callsites more immediately obvious, i.e.

	prune_shallow(PRUNE_SHALLOW_QUICK)

It of course can be left as a low-hanging fruit loose-end.

> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 2d0031703..777c9d1dc 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -186,7 +186,7 @@ EOF
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure '.git/shallow is edited by repack' '
> +test_expect_success '.git/shallow is edited by repack' '
>  	git init shallow-server &&
>  	test_commit -C shallow-server A &&
>  	test_commit -C shallow-server B &&
