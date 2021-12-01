Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC88C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 21:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbhLAV3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhLAV3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 16:29:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C75C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 13:26:15 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y12so107380385eda.12
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 13:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CZ5Q/9qtKx+bByfjIgOm6WCQ8wVwcVXal9vRltBFgo8=;
        b=icQDDS2pLGotsJZpdIftlhlkfWUP8agA/MjXUWSbUbkh7wlDw11I5saE8jWUkG0o3Y
         Ac6DZ4gEemBDyoiSftntJVDovo2v9245po8e+qWaDam4dunlpJXAJJ51yaP6L5nI+hji
         Je1mvNuO4bpvimxT1KeMSvd6eT1C/xYGw9Xm1HFuj5o/HK8WK8FGRbB7Lq7iTocRjlC7
         uq1FVKOv+zUMxE2tjarSh5tKsThi84W5wsuw7lBsaxEZKEmNSwbzcb7D4IMkhlKhXnx5
         DkYfKDdM9NZ5nuFiLqJJ1GWlRyWBuoEx8sJ3MddV+zy8CYkwq7Plz0rid/yV8bu6tY+X
         Ee9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CZ5Q/9qtKx+bByfjIgOm6WCQ8wVwcVXal9vRltBFgo8=;
        b=R0njNcoXJpQwQBMjM6esyZQ8HGwCl1mFVT1M/LFQByCH2Ag3aoJmLXeKIcCa7YV4iM
         TnZoNqaRHVXX4f28HkKbEgu11B27IOTk7CVfxU/l0vqcsA+5ZtriVuGg3hhKl/cmIq+6
         zaoifMvdP+DZynYv6RERNWE4SiAAakQTO1IbcOlX/Q7EdSl8luaUjYvJ+jMPiPgy1Bbl
         vozp5BBajrBhAETICvytOU8NS4ZqsT21Qz52zOAWMclRYMNHoL/QbmgjhTQ3wTxQbynO
         x6wKO8UB8IFfwR4NbzLu0GIcGQcHu1xb8Ns86SYInpbqNk1p08UVH5JGCQDqvJI6aa7K
         ofBw==
X-Gm-Message-State: AOAM530Pl84nIRM5iv7+YeYF3392hmywYuOQtppXqHyEHyGaSa/sKQh6
        PtSoWOxfWmws6h0R7IsLpus=
X-Google-Smtp-Source: ABdhPJxPrm48UJjFuZw7Y6sNJYG+mnngFyDQzyrlvsPohuSppWdzcgBlGzYzvgnNxuC5s3lLz+SYhw==
X-Received: by 2002:a05:6402:4382:: with SMTP id o2mr11649773edc.143.1638393974040;
        Wed, 01 Dec 2021 13:26:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hr17sm441578ejc.57.2021.12.01.13.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:26:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msX7E-001PyN-RB;
        Wed, 01 Dec 2021 22:26:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: Re: [PATCH v3 3/3] vimdiff: integrate layout tests in the unit
 tests framework ('t' folder)
Date:   Wed, 01 Dec 2021 22:25:15 +0100
References: <20211130204333.174967-1-greenfoo@u92.eu>
 <20211130204333.174967-4-greenfoo@u92.eu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211130204333.174967-4-greenfoo@u92.eu>
Message-ID: <211201.86ilw89fuz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Fernando Ramos wrote:

> Create a new test case file for the different available merge tools.
> Right now it only tests the 'mergetool.vimdiff.layout' options. Other
> merge tools might be interested in adding their own tests here too.
>
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  mergetools/vimdiff        |  2 +-
>  t/t7609-mergetool--lib.sh | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100755 t/t7609-mergetool--lib.sh
>
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 8614253ef1..5085e4ad0e 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -552,6 +552,7 @@ merge_cmd_help() {
>  	esac
>  
>  	return 0
> +
>  }
>  
>  
> @@ -594,4 +595,3 @@ if test -n "$GIT_MERGETOOL_VIMDIFF_UNITTESTS"
>  then
>  	run_unit_tests
>  fi
> -

Stray unrelated whitespace changes...

> diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
> new file mode 100755
> index 0000000000..35cc287124
> --- /dev/null
> +++ b/t/t7609-mergetool--lib.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +
> +test_description='git mergetool
> +
> +Testing basic merge tools options'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

You don't seem to need this particular boilerplate, no?

> +
> +. ./test-lib.sh
> +
> +test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
> +	GIT_MERGETOOL_VIMDIFF_UNITTESTS=1 bash $GIT_BUILD_DIR/mergetools/vimdiff

Don't use "bash", or if you do there should be appropriate prereqs to
check whether bash is there etc. See some existing tests that really do
mean to use it.
