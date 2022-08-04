Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB53C19F2C
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 07:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiHDHtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 03:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiHDHtp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 03:49:45 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F5361D9D
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 00:49:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w3so8603310edc.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=zgqnuWpvg4NlwTmNFwbz1J9/hmIC6t6yQS6akYl/CEU=;
        b=fddeUCVfAsu2awFfsc3j9RuAoSSvDTAqejuHDnpcfdXEBnercN0BrubqGp0AvNrJMj
         4lcev6J5jIrS5QZSKEDxtmPmME5ItTIFCxQTJWJSki+elb8dCTyCBcYOPDO+sXJJ/zwQ
         5CHIZcaRbY5jB8/8rXa2k8zZGGHreS5Xg+j4hb6VwaFBrxRfblRP9rkrh/uNs/zZX58m
         8bUvvVuB0Djq76NUiYA3JqbisDMckOZqJ39y93EgJh1o2qjkfTmnxpcL0T8z99+ukPfC
         +dNJncoT68ujIOtpP9RWELOx5zk7LkAIATyKw/TYbVhrQ6Sohga4ISlIioRhzoZxrSWh
         eCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zgqnuWpvg4NlwTmNFwbz1J9/hmIC6t6yQS6akYl/CEU=;
        b=N8FSnSyTa4Jvp7OLzktJXirnzAH1wiJb9Cqr58nGvU0GxsU224wf5zg1UVoYmWZeWz
         imUuZudTsNDDH1hS4XyOJidxAtGC/QI2LRHa8f61fx56vpc99C0PJkxlxJ5ivKyXf5sD
         wH3odWG8XTniWH0vr0Rpf3VSuYlDtxMHayX0M+u4nvO+kDv8hVZWJyXdkjMezv1Jaa42
         qKHbb13Ug/Uvpai4RHp9n2Ys7vAAV36u/TalpEURMaFUhlHpo6OzGoe6g2iy3Nb8Vg4c
         i10rUY4wd4NqKqnUy/gFP4bwg6eNzewejreHr4qHj5uT2jK+A+rnB5LEIYQs02RjkbFA
         Lkeg==
X-Gm-Message-State: ACgBeo3c1sLGmZuAfBoyynhiuej82wC/7+dFdddY2veOj1dIhxp93z0u
        RcxIb0SJDetkW5dQD5+mCVuuK3SXlEA=
X-Google-Smtp-Source: AA6agR7DXfUupsGJJCVBlKUEpad8Bp9ofC/mkGnMiqO0r5cyKBYkxIQ1GhHQmOoNQ/TyFmM5pVJBEQ==
X-Received: by 2002:a05:6402:298d:b0:43e:7fe2:290f with SMTP id eq13-20020a056402298d00b0043e7fe2290fmr713694edb.311.1659599383359;
        Thu, 04 Aug 2022 00:49:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170907778600b007307d099ed7sm46701ejc.121.2022.08.04.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:49:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJVby-009fvs-0N;
        Thu, 04 Aug 2022 09:49:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] gc: add tests for --cruft and friends
Date:   Thu, 04 Aug 2022 09:48:24 +0200
References: <20220803205721.3686361-1-emilyshaffer@google.com>
 <20220803205721.3686361-2-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220803205721.3686361-2-emilyshaffer@google.com>
Message-ID: <220804.86a68ke9d5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 03 2022, Emily Shaffer wrote:

> In 5b92477f89 (builtin/gc.c: conditionally avoid pruning objects via
> loose, 2022-05-20) gc learned to respect '--cruft' and 'gc.cruftPacks'.
> '--cruft' is exercised in t5329-pack-objects-cruft.sh, but in a way that
> doesn't check whether a lone gc run generates these cruft packs.
> 'gc.cruftPacks' is never exercised.
>
> Add some tests to exercise these options to gc in the gc test suite.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  t/t6500-gc.sh | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index cd6c53360d..e4c2c3583d 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -202,6 +202,42 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
>  	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
>  '
>  
> +test_expect_success 'gc --cruft generates a cruft pack' '
> +	git init crufts &&
> +	test_when_finished "rm -fr crufts" &&

Let's "test_when_finished" first, then "git init", the point is to clean
up the directory if we fail.

> +	(
> +		cd crufts &&
> +		test_commit base &&
> +
> +		test_commit --no-tag foo &&
> +		test_commit --no-tag bar &&
> +		git reset HEAD^^ &&
> +
> +		git gc --cruft &&
> +
> +		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
> +		test_path_is_file .git/objects/pack/$cruft.pack
> +	)
> +'

...this...

> +test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
> +	git init crufts &&
> +	test_when_finished "rm -fr crufts" &&
> +	(
> +		cd crufts &&
> +		test_commit base &&
> +
> +		test_commit --no-tag foo &&
> +		test_commit --no-tag bar &&
> +		git reset HEAD^^ &&
> +
> +		git -c gc.cruftPacks=true gc &&
> +
> +		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
> +		test_path_is_file .git/objects/pack/$cruft.pack
> +	)
> +'
> +

...whole thing seems to be copy/pasted aside from the git options.

If so let's factor this into a trivial helper that invokes git "$@",
then call it with "gc --cruft" and "-c ..."?
