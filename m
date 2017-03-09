Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAC520135
	for <e@80x24.org>; Thu,  9 Mar 2017 02:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbdCICGp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 21:06:45 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34398 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbdCICGn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 21:06:43 -0500
Received: by mail-pg0-f53.google.com with SMTP id 77so20042048pgc.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 18:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=891R25T4Fn5W6Qa5jknMiQo54Sx0nppnaq6hHCrpGWw=;
        b=Kvkegj98rzYQ7toQRCKFcar9YDMyR6SbB7uVd6+vFAuMRW4FsU9O9i8H/TQzDJM/0M
         q3z0vMio8QqNLCVwT/htCGQ68lKBdl0xTnpeszB0k8tVo/n6NaAsW3YEx+mKrccSTsBH
         l1FH8obvKuuBu9KuM1UaHgWkovCtf9EFq+HKFDmMD5TSb4HLN3tbSShXFyBw7665ytRV
         pj8u6c4h1DsdKAYruL42W3lRy7Rh0arHN9QDLXPEQGr1MarozVpKHT4tOYn7hsubhg7Q
         sOorJo/n9UOINP2fZ41XqSoVZRDplTl6gN2Cg/CBp7k2OmsFZxkn08GV659EVEzg7qAR
         WiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=891R25T4Fn5W6Qa5jknMiQo54Sx0nppnaq6hHCrpGWw=;
        b=fyAMilT7V+Xi6usmdf2ZcnSv7xvk2wBXXW0n5nZRQPPmkBNaeINAqyNoenhLKfa2SD
         2TxESw1FLiHXonXYK2C8fv+UQHJJgDLpQ8AYEdKZbjm2xgE+DYQgPXRX6NvssHbwuJ5N
         p8bCm5US/HGWY+RvR0by6e3k9fyNW0ofsYkdhMODqD7hIBVlV93IWlIwxni/ObNLcp7/
         kveIXDcG2S2jOWMdElA6ec56Gl0GpiAY7UFVwIbbZ4c8kosHc8oViy1Y7i3kHt1W9qbV
         ulO7FQnSzRVlO1+aljBuZqbfCOBTDFnS2SOcGrUGe5G5BIR4KU+URYKVj0y86kl30+O1
         nzBA==
X-Gm-Message-State: AMke39k2T0omloh+e/73j3U1qL8uUVPd5FdKiT5EZcPJm6OpORjOht/LxOJcd4b4P6ptgEZTgRRab5NVlgRcb+KN
X-Received: by 10.84.128.74 with SMTP id 68mr13398015pla.111.1489024571807;
 Wed, 08 Mar 2017 17:56:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 17:56:11 -0800 (PST)
In-Reply-To: <20170309012345.180702-4-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com> <20170309012345.180702-1-bmwill@google.com>
 <20170309012345.180702-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 17:56:11 -0800
Message-ID: <CAGZ79kZG+Y+AtYYxeE5hmsNxfwmNp1h7aKAem=JD3yiKB6STPw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] submodule deinit: use most reliable url
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 5:23 PM, Brandon Williams <bmwill@google.com> wrote:
> The user could have configured the submodule to have a different URL
> from the one in the superproject's config.  To account for this read
> what the submodule has configured for remote.origin.url and use that
> instead.

When reading this commit message, I first thought this is an unrelated
bug fix. However it is not unrelated. In a later patch you introduce a mode
where submodule.<name>.url may not exist in .git/config any more,
(there may be a .existence flag instead?) such that url="", which is
obviously a bad UI:

    Submodule '$name' (<empty string>) unregistered for path '$displaypath'"

Like the first patch of this series, we could have a helper function
"git submodule--helper url <name>" that figures out how to get the URL:
1) Look into that GIT_DIR
2) if non-existent check .git/config for the URL or
3) fall back to .gitmodules?

Instead of having such a helper, we directly look into that first option
hoping it exists, however it doesn't have to:

  git submodule init <ps>
  # no command in between
  git submodule deinit <ps>
  # submodule was not cloned yet, but we still test positive for
    > # Remove the .git/config entries (unless the user already did it)
    > if test -n "$(git config --get-regexp submodule."$name\.")"

I am not sure if there is an easy way out here.

Thinking about the name for such a url helper lookup, I wonder if
we want to have

    git submodule--helper show-url <name>

as potentially we end up having this issue for a lot
of different things (e.g. submodule.<name>.shallow = (true,false),
or in case the submodule is cloned you can give the actual depth
as an integral number), so maybe we'd want to introduce one
layer of indirection

    git submodule--helper ask-property \
       (is-active/URL/depth/size/..) <name>

So with that said, I wonder if we also want to ease up:

    GIT_DIR="$(git rev-parse --git-path modules/$name

to be

    GIT_DIR=$(git submodule--helper show-git-dir $name)

>                 then
>                         # Remove the whole section so we have a clean state when
>                         # the user later decides to init this submodule again
> -                       url=$(git config submodule."$name".url)
> +                       url=$(GIT_DIR="$(git rev-parse --git-path modules/$name)" git config remote.origin.url)

In the submodule helper we have get_default_remote(), which we do not
have in shell
(which we seemed to have in shell?), so maybe it's worth not using origin here,
although I guess it is rare that the original remote is named other than origin.

>                         git config --remove-section submodule."$name" 2>/dev/null &&
>                         say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
>                 fi
> --
> 2.12.0.246.ga2ecc84866-goog
>

Thanks,
Stefan
