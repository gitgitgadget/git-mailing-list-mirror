Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC0C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 22:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiD0W0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiD0W0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 18:26:16 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD96C2B189
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:23:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n1-20020a654881000000b003a367d46721so1468347pgs.4
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EcfgSqBqkjqRDGDNTU6KlIMH4oyyDOB8PDyr4kgAnQ8=;
        b=UAQxFVFjeOdoSyUByinHleaLtafP+w+mKbSzm1GHeiqiYsO/BPVNSM8CDD0wgGcQBO
         lvsgF0fuEW2mQZbpGcm/cZVY3XoJQ9R+ZZ0jdtl5YrbDG0ToESqRA/OxjoNePCSITE3D
         g8brqPuLGkNGfyKBzO3achNeksrUkFNT5sbsIBpyStw0rwFq7JKcHqAXsnDzYe/aMTu2
         9GqaXa3Pb0Ex3Ii230mfu3QEGxhISTzhe1XVJGoqMWoyIFAanBtuPm7FsGTCj14o3siy
         rsuyW9nTGIRZen5zgDe1eULRZpHS5XVGtFvXOiLXmrme9k7d3W1RJ1sO7k2SXIomH0f3
         oU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EcfgSqBqkjqRDGDNTU6KlIMH4oyyDOB8PDyr4kgAnQ8=;
        b=CGQsVML/j4gqnmT8DVAWTdr/Y3Uaqyv1ycOlFOhafv7akscf9S5FvJpLqV9adNlUhk
         eL9KW55XvY3tLBQ5WRYlzz6F+i2tzA0vgfCQ+QgjucNzIM+KueH5FmDBoGj/OwQ1vNg5
         saQuZ0qFizOJNbtM8/YR084fCFHFcfLqeLazpKbcVXkGcSproLd3809kzaLBr9y0Ca1e
         9CTw7fM90zdEm06kvgnRhew+k4Pd4w4Lt9HWKBkQndy4rZg9vdTIRdOFpP5B+f2fibt7
         w0OIMEl+Z04TFH+hsBndHgZF6Z56Kbjx739y2wj8zd3iirmvTzkO2O9csnJUo/NlpDRI
         cTEg==
X-Gm-Message-State: AOAM531mW4LHBUwIJlYfUWVUC6g4KtxmW/4WjUofi+d3lptcBqDM+/1e
        mHbrxkrltRru0e/X1eeVHbsBRwr5rlMM8g==
X-Google-Smtp-Source: ABdhPJyBCjahyxavRyXb0gOyN60KCFHq/Lpjxr4D6uj0/ZEqFzfH2mkpwUdCuWk5j8Y/SX9JXOXo7frZ97ogjA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:22c4:b0:15d:1ef1:6607 with SMTP
 id y4-20020a17090322c400b0015d1ef16607mr15950226plg.0.1651098184048; Wed, 27
 Apr 2022 15:23:04 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:23:01 -0700
In-Reply-To: <xmqqtuagvq4n.fsf@gitster.g>
Message-Id: <kl6lbkwmp3ne.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com>
 <pull.1258.v2.git.git.1650890741430.gitgitgadget@gmail.com>
 <xmqq35i1vx3y.fsf@gitster.g> <xmqqtuagvq4n.fsf@gitster.g>
Subject: Re: [PATCH v2] submodule--helper: fix initialization of warn_if_uninitialized
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Is this a fix we can protect from future breakge by adding a test or
>> tweaking an existing test?  It is kind of surprising if we did not
>> have any test that runs "git submodule update" in a superproject
>> with initialized and uninitialized submodule(s) and make sure only
>> the initialized ones are updated.  It may be the matter of examining
>> the warning output that is currently ignored in such a test, if
>> there is one.
>
> Here is a quick-and-dirty one I came up with.  The superproject
> "super" has a handful of submodules ("submodule" and "rebasing"
> being two of them), so the new tests clone the superproject and
> initializes only one submodule.  Then we see how "submodule update"
> with pathspec works with these two submodules (one initialied and
> the other not).  In another test, we see how "submodule update"
> without pathspec works.
>
> I'll queue this on top of your fix for now tentatively.  If nobody
> finds flaws in them, I'll just squash it in soonish before merging
> the whole thing for the maintenance track.
>
> Thanks.

Thanks for adding the tests!

>  t/t7406-submodule-update.sh | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git c/t/t7406-submodule-update.sh w/t/t7406-submodule-update.sh
> index 000e055811..43f779d751 100755
> --- c/t/t7406-submodule-update.sh
> +++ w/t/t7406-submodule-update.sh
> @@ -670,6 +670,39 @@ test_expect_success 'submodule update --init skips submodule with update=none' '
>  	)
>  '
>  
> +test_expect_success 'submodule update with pathspec warns against uninitialized ones' '
> +	test_when_finished "rm -fr selective" &&
> +	git clone super selective &&
> +	(
> +		cd selective &&
> +		git submodule init submodule &&
> +
> +		git submodule update submodule 2>err &&
> +		! grep "Submodule path .* not initialized" err &&
> +
> +		git submodule update rebasing 2>err &&
> +		grep "Submodule path .rebasing. not initialized" err &&
> +
> +		test_path_exists submodule/.git &&
> +		test_path_is_missing rebasing/.git
> +	)
> +
> +'
> +
> +test_expect_success 'submodule update without pathspec updates only initialized ones' '
> +	test_when_finished "rm -fr selective" &&
> +	git clone super selective &&
> +	(
> +		cd selective &&
> +		git submodule init submodule &&
> +		git submodule update 2>err &&
> +		test_path_exists submodule/.git &&
> +		test_path_is_missing rebasing/.git &&
> +		! grep "Submodule path .* not initialized" err
> +	)
> +
> +'
> +
>  test_expect_success 'submodule update continues after checkout error' '
>  	(cd super &&
>  	 git reset --hard HEAD &&

So we test that we only issue the warning when a pathspec is given, and
that we ignore uninitialized submodules when no pathspec is given. I
think this covers all of the cases, so this looks good, thanks!
