Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D722CC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 16:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJTQiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJTQiB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 12:38:01 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB57558C2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 09:38:00 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id 137so9890iou.9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 09:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guR+kni8dGQgaNhFrA/myjE33tO7Xk9EtnFgFAJzGns=;
        b=drsWZ2ef5OrXAoBKATDqeNOMsrGKlYqur/74pKbB8D8p5s2JVJnsg4Sc/d8q+MbjzT
         C1EFjwsKe8MXFeJkVV/FmQdu8fkvbn2srm8TMvNHiZ4NBY4mIsCqBJshREuDGKgaAC60
         fDM5yRYSvVt6DdePR6/7zdKNA1jiSxgKd71L5GLYqsKUG4kKfULorWERHMyVElGzfgmA
         S53M+CbFA1AjmZmV+qmH6hx+Vtpw1Rt64E5DftzJOkzmBEauTlhzPO4JjsftHk5OJpe5
         5xCtu7u1NFDNs+YPgTA0Fa4ZDr4ao0Ny2Rc09nEXXVUkBvE7wU2AjgUuYFZYxd4ppQtz
         zZtg==
X-Gm-Message-State: ACrzQf0B7POYzrnplg5GZ+hs+yiOthkhzFppeBydHf5+I89DbIWwaFmt
        /WNnkAvGYUo9XzmP1YHUq5mmt6dpwFSd7IHcq/8=
X-Google-Smtp-Source: AMsMyM5TDuEdPRhgx1ONz7yLnLGhz8Zuqtx05PEj8gCysEbFwmcZ/vsVz36+2buYoSDvOAsZ6i+h8lJIqeLknglcOco=
X-Received: by 2002:a05:6638:3f0d:b0:363:ba76:7397 with SMTP id
 ck13-20020a0566383f0d00b00363ba767397mr10570396jab.177.1666283879478; Thu, 20
 Oct 2022 09:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com> <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqo7u9wyt7.fsf@gitster.g> <xmqq8rlamq29.fsf@gitster.g>
In-Reply-To: <xmqq8rlamq29.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 20 Oct 2022 12:37:48 -0400
Message-ID: <CAPig+cRkQLyy8X7y=1jhrVwYERk5ucagAfJkTAOPNODofiZr1g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 12:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> So here is my "panda-see-panda-do" attempt.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] ci: use DC_SHA1=1 on osx-clang job for CI
>
> All other jobs were using the default DC_SHA1 (which is a
> recommended practice), but the default for macOS jobs being Apple's
> common crypt, we didn't catch recent breakage soon enough.

"recent breakage" is quite vague and probably won't help future
readers understand what this is actually fixing. Possible
improvements: (1) a prose description of the breakage; (2) the actual
compiler error message; (3) a pointer[1] to the email reporting the
problem. One or more of the above improvements to the commit message
would help future readers.

[1]: https://lore.kernel.org/git/kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com/

> We may want to give similar diversity for Linux jobs so that some of
> them build with other implementations of SHA-1, but let's start
> small and fill only the immediate need.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 1b0cc2b57d..5a115704cb 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -259,6 +259,8 @@ macos-latest)
>                 MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
>         else
>                 MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
> +               MAKEFLAGS="$MAKEFLAGS NO_APPLE_COMMON_CRYPTO=NoThanks"
> +               MAKEFLAGS="$MAKEFLAGS DC_SHA1=1 NO_OPENSSL=1"
>         fi
>         ;;
>  esac
