Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB8DC77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 18:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346429AbjD1Sht (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjD1Shr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 14:37:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58F71BEB
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:37:46 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1a682ad2f8cso1433735ad.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682707066; x=1685299066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmzlYXkhweXduzJ5aXH7WzeCrYv5my3YSWToSHOLwIE=;
        b=x5yluZRBgwZVaCscgbV1zeQGOSOx5ZiU42TXvqt49Sdk/QrxhDe1sXzoM9hpbe+I2D
         S0GlehNXdnjBfeibyBaJlaz5lzlyAOUGCh02Mwn8u/I79xi5L9bAPxnCsuwpxAcN7WuQ
         qTd3GFhBR0p7AI+moVuwZRt8rHmofuRDnKxleQe5Q7/AcyD6au6aVTy7gEZTnn1r14EB
         0oEcj/BZuB2dnDvnW+I++drj6XutF6zhlkAVEFfCAV6S/WrV0+EL+W4W37I+erojgwP0
         nt2EQVCP1jw9SQZwtVEe5PBZsQKcRS/Pi0sg0SRh6zht+cwwAtsJZtrdLu2O+2o7NHYL
         vtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707066; x=1685299066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmzlYXkhweXduzJ5aXH7WzeCrYv5my3YSWToSHOLwIE=;
        b=CiOQIE3EDYObm9Dj4yAMVEFrl1HhlPBxRD/zxvw3mF1h7CK9ENgzSDcnEhzUpOnOMd
         4CAdfLYk8+iwlS+RTWj+vRYEu8XcpyCH6akCZh8IxOOU3k+kETnnLnXDsA9DRv2yoGRI
         jeBZ2dKcpozFTCGhDijRibB9hfD6y6xnVN9JvABGArh9BxPBAaEsIJkRAJPFYTsPh5ZM
         Y4XYnkxJ4C3e0s0+Pe2xOd0EtY4wyWKhbfVZvFZ9333kpDPDAdtvnp6eEyrmjKAlodTO
         DAGZxDQ0HF9gvg7I9fo+UEGa0olRKDX5mXvLzF5zhjN9SQgZpGtSUenHd7Cg5eU4EDzC
         8Ahg==
X-Gm-Message-State: AC+VfDxqeN4kkLJHb2l2Z4oDe7WTrx1Wz1upsTT1vSOHdgAU14U3SvX/
        22iyt+QDdHaFMecSS2zhSi76sbwcPBukxQ==
X-Google-Smtp-Source: ACHHUZ5I7ZozLFzXD4aEn+/qf2d96sdv9lt+3Q9OdMIUZ1YtAG5joDDelmCWUg5xXSRUPdJqpfxtIFaaVVcDfg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:728d:b0:1a0:1f4e:a890 with SMTP
 id d13-20020a170902728d00b001a01f4ea890mr1910748pll.1.1682707066413; Fri, 28
 Apr 2023 11:37:46 -0700 (PDT)
Date:   Fri, 28 Apr 2023 11:37:44 -0700
In-Reply-To: <b548d96db7052dc2cb664922fa2003fe068843cf.1682702058.git.steadmon@google.com>
Mime-Version: 1.0
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
 <b548d96db7052dc2cb664922fa2003fe068843cf.1682702058.git.steadmon@google.com>
Message-ID: <kl6lbkj73laf.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2] setup: trace bare repository setups
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
> index 11c15a48aa..993f5bdc7d 100755
> --- a/t/t0035-safe-bare-repository.sh
> +++ b/t/t0035-safe-bare-repository.sh
> @@ -7,13 +7,24 @@ TEST_PASSES_SANITIZE_LEAK=true
>  
>  pwd="$(pwd)"
>  
> -expect_accepted () {
> -	git "$@" rev-parse --git-dir
> +expect_accepted_implicit () {
> +	test_when_finished 'rm "$pwd/trace.perf"' &&
> +	GIT_TRACE2_PERF="$pwd/trace.perf" git "$@" rev-parse --git-dir &&
> +	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
> +}
> +
> +expect_accepted_explicit () {
> +	test_when_finished 'rm "$pwd/trace.perf"' &&
> +	GIT_DIR="$1" GIT_TRACE2_PERF="$pwd/trace.perf" git rev-parse --git-dir &&
> +	! grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
>  }

(Not new in v2) This wasn't obvious to me at first, but

  grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"

looks like it's asserting that we trace that the bare repository is
$pwd, but it's actually only asserting that is starts with $pwd. If it
might trip up other reasers, a comment here would be helpful.

> @@ -21,13 +32,9 @@ test_expect_success 'setup bare repo in worktree' '
>  	git init --bare outer-repo/bare-repo
>  '
>  
> -test_expect_success 'safe.bareRepository unset' '
> -	expect_accepted -C outer-repo/bare-repo
> -'
> -

I found this surprising; I thought it was quite valuable to test the
default behavior. I'd prefer to keep this test.

Perhaps there was a miscommunication? You mentioned:

  Actually, explicitly setting the variable here is equivalent to the
  following test case, so I'll just remove this one.

which is true, but I think Junio meant _un_setting the variable,
something like:

  test_expect_success 'safe.bareRepository unset' '
+   test_unconfig --global safe.bareRepository &&
    expect_accepted -C outer-repo/bare-repo
  '
