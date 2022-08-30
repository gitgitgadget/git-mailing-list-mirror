Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77127ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 19:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiH3TJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 15:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiH3TJc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 15:09:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0257331C
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 12:09:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y141so12278097pfb.7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date;
        bh=0dTxzTer2Q7xTOe1ZLgqJtpSrpcqQONdgoNfBpL1cxQ=;
        b=fbk+bCw/bFnbUhbmblqwlpe/5nFFm/iwj5W+ukw0hz+yEJRKhnZcjTJ53ogdKDbM71
         DBEuIv3jTq0/kS4szAIGj8rih+MiDTmoLtZt1Q7hQcrUA7Li69g/D6ogUdcDlSudOMLc
         A21zL4ruOWnpkSUWIUXDJxRcNM9Ct4do5HwZH72t254OtdY6pw1Z7uCvGk28OYnanGf9
         obFHvBAMqtwUjXzxIlxJ+fRVXs8xihzwGae8TLd2bADjYk4PQIf55MMsdLy3OK3IvHwy
         oZpFzZizJbhpkLF9/g7Pa7ppdG00EQ9cc8Q0emdQwK1y/mXovYzKemQO28/8nZZksnff
         qw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=0dTxzTer2Q7xTOe1ZLgqJtpSrpcqQONdgoNfBpL1cxQ=;
        b=c3yAuyKDzcCDW8ezUHBTIwTkUoYPnzFcIyoeyXvxoJVlc7DqNvA3cajvDlnCjHl+yd
         bizDtNDZxrRtPYxCay/Y7Ds2Km5xhBnxaM5VpirHaTWMYVNkoKoTEPk82Wfy4dO8vUw1
         dw5+DR2MTW2KqkhnDDKhVwLgEsMIEqwTd3tN2+B3cJd9ogeeXijmAgKRXNPeB7Hiy+k4
         GaLdRouQWW2FMuIRg7oZMAu1bwQOQUQ+eOIwN2c1JoGh8B0worR6Ry7nac570/flcap+
         d0HaP3VyD4G8PqVApxpP4XP0Ui4aeAaKuadAfVmJzaLR0txUFUv2JXVNpVSjUG7YOSsH
         mC6Q==
X-Gm-Message-State: ACgBeo0V5zaMyWNr76LbGX/ZV4LU+S3+FWhb/8aCBtf0/WsTPn9W1EiB
        j8u0rZqpcoFijshWO+KSN5I=
X-Google-Smtp-Source: AA6agR7rSWsUfDZiHYYgXzWOQYet7q1dPjYMRUoqd8g6a9AwcoJZUJ4DrW4lEr0tP5YU+J4VHpgxLA==
X-Received: by 2002:a05:6a00:8cc:b0:52c:7ab5:2ce7 with SMTP id s12-20020a056a0008cc00b0052c7ab52ce7mr22310926pfu.28.1661886570982;
        Tue, 30 Aug 2022 12:09:30 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b001fb277223bdsm8836724pjc.2.2022.08.30.12.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 12:09:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] t3701: test the built-in `add -i` regardless of
 NO_PERL
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
        <54d25d991b09219f6992dc3e8c102ce1ccef6313.1661867664.git.gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 12:09:30 -0700
Message-ID: <xmqqo7w1k0ph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The built-in `git add --interactive` does not require Perl, therefore we
> can safely run these tests even when building with `NO_PERL=LetsDoThat`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3701-add-interactive.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

A companion to the previous step that is obvious and very much to
the point.  Looking good.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index b354fb39de8..8d16cd45821 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -7,9 +7,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>  
> -if ! test_have_prereq PERL
> +if test_have_prereq !ADD_I_USE_BUILTIN,!PERL
>  then
> -	skip_all='skipping add -i tests, perl not available'
> +	skip_all='skipping add -i (scripted) tests, perl not available'
>  	test_done
>  fi
