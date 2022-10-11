Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C5C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 08:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJKI2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 04:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKI2G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 04:28:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9AB83072
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 01:27:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a26so29748480ejc.4
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m7OxnNl1yETPmSMS3oB4YRMoD83Oec3ZlBtEBOLC2TQ=;
        b=Z2EjWT0d+I6iXSPgcqnYnHtWn0Q+zSmFpK8RgNYUw7h+/VfUxftOYfC7xxOJthCsrV
         Y12/qAjfyt4qN9sRAgFLYX4vaJbtFlfyIW48t8BdfR9XlIBtLnY7WHdGMYiEvm59Co0B
         n0PspW15ng8CfiFhG7Iitx19ObXBXxJcUf0hRorZzVe5X3nocs/hlwNdTiNZEI2T6UOt
         CdcbN4HxRMOaBEr7cy9+SSAzBEQfwTK6+GisxqYUxMxwhuf2rODNtTA3YICunlu6mkDZ
         32ZGRg4T5/lJvWgZPW7oMLT3CQrvkFnD4j+0Odun35h5TAssMTrQdQrkdv370noJ0LpS
         dvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7OxnNl1yETPmSMS3oB4YRMoD83Oec3ZlBtEBOLC2TQ=;
        b=djEIRTvNDGdZLYBLs2JjuG5fO8RzfFrv+8HEibtcqCAlndl/992ri4CDxT5IcPpdDu
         Mb2WuHVZboyAorie4ODJZMKrf7gh+BqnvbdeA9vw/1cc2G1m/UUngY3kUkdXDGNfA2xg
         TGHcWjlhFTB9NIJc/22LRcMwc5P7MIf1R6DdQwXI/RNbW60OablcIPUW/+GvXTde73oh
         i3p6zTPIuHXPgpg4N5lCi8uyAXhAIOB5yyEGtB70tRM07KNFPiXu0w5od2ve8fJfUA0G
         2gTgtQ5pF6NM7pmUPHopUOXI19x6VG0P9W1jKfV6gHZRz5iJftf6yov5AckIks9r8V+5
         8mpQ==
X-Gm-Message-State: ACrzQf0sNMugj//KJ3FBdr7BJ/Ezg9CR92H/O0LOjEBEeC/6KYhAumZd
        2H52+U6B86Iry6XlMlvD0dE=
X-Google-Smtp-Source: AMsMyM4JPJvTxIR+8Ow45lAcr6AbPiDIkLG9cVJm1u3xLJGHR3AY0qGJCExO40dh0gn6aGXXK9O5cg==
X-Received: by 2002:a17:906:dc89:b0:78d:5616:4c24 with SMTP id cs9-20020a170906dc8900b0078d56164c24mr15557192ejc.118.1665476876765;
        Tue, 11 Oct 2022 01:27:56 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y6-20020a170906070600b00764a76d5888sm6515849ejb.27.2022.10.11.01.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 01:27:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiAcF-003lka-1B;
        Tue, 11 Oct 2022 10:27:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] ci: add address and undefined sanitizer tasks
Date:   Tue, 11 Oct 2022 10:23:31 +0200
References: <xmqq8rlo62ih.fsf@gitster.g> <xmqqpmezxl9p.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqpmezxl9p.fsf@gitster.g>
Message-ID: <221011.86fsfupxx0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 10 2022, Junio C Hamano wrote:

> The signal of "passed with asan, but not ubsan" (or vice versa) is
> not that useful in practice, run both santizers in a single task.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Range-diff against v1:
> 1:  04a9dc5439 ! 1:  cbf0d80ab1 ci: add address and undefined sanitizer tasks
>     @@ Metadata
>       ## Commit message ##
>          ci: add address and undefined sanitizer tasks
>      
>     +    The signal of "passed with asan, but not ubsan" (or vice versa) is
>     +    not that useful in practice, run both santizers in a single task.
>     +
>     +    Helped-by: Jeff King <peff@peff.net>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>      
>       ## .github/workflows/main.yml ##
>     @@ .github/workflows/main.yml: jobs:
>                 - jobname: linux-leaks
>                   cc: gcc
>                   pool: ubuntu-latest
>     -+          - jobname: linux-address
>     -+            cc: gcc
>     -+            pool: ubuntu-latest
>     -+          - jobname: linux-undefined
>     ++          - jobname: linux-sanitize
>      +            cc: gcc
>      +            pool: ubuntu-latest
>           env:
>     @@ ci/lib.sh: linux-leaks)
>       	export GIT_TEST_PASSING_SANITIZE_LEAK=true
>       	export GIT_TEST_SANITIZE_LEAK_LOG=true
>       	;;
>     -+linux-address | linux-undefined)
>     -+	export SANITIZE=${jobname#linux-}
>     ++linux-sanitize)
>     ++	export SANITIZE=address,undefined
>      +	;;
>       esac
>       
>
>  .github/workflows/main.yml | 3 +++
>  ci/lib.sh                  | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 831f4df56c..92d27db0b9 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -251,6 +251,9 @@ jobs:
>            - jobname: linux-leaks
>              cc: gcc
>              pool: ubuntu-latest
> +          - jobname: linux-sanitize
> +            cc: gcc
> +            pool: ubuntu-latest
>      env:
>        CC: ${{matrix.vector.cc}}
>        CC_PACKAGE: ${{matrix.vector.cc_package}}
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 1b0cc2b57d..c9c4982e21 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -278,6 +278,9 @@ linux-leaks)
>  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
>  	export GIT_TEST_SANITIZE_LEAK_LOG=true
>  	;;
> +linux-sanitize)
> +	export SANITIZE=address,undefined
> +	;;
>  esac
>  
>  MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"

This LGTM, and all looks a bit familiar, even down to Jeff having the
same feedback on the v1:
https://lore.kernel.org/git/patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com/
:)

FWIW I had a re-roll ready for that, but was waiting for the dust to
settle on failures. As soon as we were SANITIZE=address clean (which 2x
commits broke in quick succession) we had the scalar SANITIZE=undefined
failure, and then the release.

But this works too. It's the same as what I've had queued up locally,
except the job name is different, which was in response to other
feedback in the original thread:

https://github.com/git/git/compare/master...avar:git:avar/ci-add-SANITIZE%3Daddress-and-SANITIZE%3Dundefined-2

