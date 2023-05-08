Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01026C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjEHWv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHWvz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:51:55 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DF586BA
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:51:54 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1ab1e956892so28526515ad.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683586314; x=1686178314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIuVy4KZOCwSdRYcLprItmQEXXsi6vHZ74ZrmLLysBI=;
        b=M3Iod/553SHCFcCN3i8BsKeBm8/+N2Ys8s8oN9p5YT+bRvWZjjolyfLWMpN+qKvBNv
         FSYTyfjZrwLjPer3I4fOEymP9NqD6RzxWpDVPcHA0VDPpHnvz+611WaKnPDokZnqSKD7
         5ybyilV4YZmxiB+T5fd2kcBeXgIBCtAM/hpOr5zMFr0mURT3XioDOwVQFNZ/yg1PSetV
         y2rztA9IgR5YP4TJ+Xf7JJFI4M+FERuO4WdHm5HWP0PBKmRH4LgqxkwjoJ4qWxS1hyTB
         NuunpzHaUb4LMRiMO/86mL5swNEmEtYF4AhTs7TowtcAeXoi/utIniWcWR44zDUb2FV5
         JUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683586314; x=1686178314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIuVy4KZOCwSdRYcLprItmQEXXsi6vHZ74ZrmLLysBI=;
        b=YVRj8PFGrnz0cSd3pWKBk/jbZxFzapXN2ljr7KID3UTq98/g99JjHeFC6XXzpzQyBk
         yuXlMRMY2LhVCJvRdAFXikqx8fDrlFQDlyu5AErln6/+QpCVVcXggJQBiiQjuASd1tTK
         UmzqCJOjRTnATfRRixyL9CYW3Moe9hBoFyWE/9Bg7y01grA4RvOCXa6VgmXTApYyI9fH
         PSV2jml+opH3f82dk9uOUh8H3+SJztc7/R0b3W5qsIfXBV7McGQAQg+s4puuXbxFi/nV
         dYRTmaXgzML3ZQAzgdCyJpQsrxoE4LL1aEXG8hFcvzqnimm3/67U+ixaJOhUtWm5a+/X
         EQCg==
X-Gm-Message-State: AC+VfDxSXrphL3le/NifU+6PEhpxI0YCJP+E7aacP510GdejoqeIY+vd
        e5KikTbunroQ4dH5Q7jlvYDPTEDdp1YknA==
X-Google-Smtp-Source: ACHHUZ68AC5VoX5YjIZWUUAXzqMu7px+PAz+7r5UMGIoVKjjQ+z6/We1mlAfz6vXF71npXcAkJck5Mv+cckgyA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:eb4b:b0:1ab:89c:3922 with SMTP id
 i11-20020a170902eb4b00b001ab089c3922mr4026442pli.12.1683586313858; Mon, 08
 May 2023 15:51:53 -0700 (PDT)
Date:   Mon, 08 May 2023 15:51:52 -0700
In-Reply-To: <4b2b0cfe15ca6b3c9058bc9cb6944ba05d60a228.1683113177.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683113177.git.ps@pks.im> <4b2b0cfe15ca6b3c9058bc9cb6944ba05d60a228.1683113177.git.ps@pks.im>
Message-ID: <kl6llehy1lo7.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 1/8] fetch: fix `--no-recurse-submodules` with
 multi-remote fetches
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When running `git fetch --no-recurse-submodules`, the exectation is that
> we don't fetch any submodules. And while this works for fetches of a
> single remote, it doesn't when fetching multiple remotes at once. The
> result is that we do recurse into submodules even though the user has
> explicitly asked us not to.
>
> This is because while we pass on `--recurse-submodules={yes,on-demand}`
> if specified by the user, we don't pass on `--no-recurse-submodules` to
> the subprocess spawned to perform the submodule fetch.
>
> Fix this by also forwarding this flag as expected.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fetch.c             |  2 ++
>  t/t5526-fetch-submodules.sh | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c310d89878..08d7fc7233 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1876,6 +1876,8 @@ static void add_options_to_argv(struct strvec *argv)
>  		strvec_push(argv, "--keep");
>  	if (recurse_submodules == RECURSE_SUBMODULES_ON)
>  		strvec_push(argv, "--recurse-submodules");
> +	else if (recurse_submodules == RECURSE_SUBMODULES_OFF)
> +		strvec_push(argv, "--no-recurse-submodules");
>  	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
>  		strvec_push(argv, "--recurse-submodules=on-demand");
>  	if (tags == TAGS_SET)

Makes sense.

I wondered for a bit whether this should have been checking
recurse_submodules_cli (the actual CLI flag) back in 386c076a86 (fetch
--negotiate-only: do not update submodules, 2022-01-18). I think this
current state is correct, though. After we have told the superproject
what submodule recursion mode to use, we want to continue using that
mode when recursing through submodules regardless of whether that mode
originally came from the CLI or config.

> +test_expect_success "fetch --all with --no-recurse-submodules only fetches superproject" '
> +	test_when_finished "git -C downstream remote remove second" &&
> +
> +	# We need to add a second remote, otherwise --all falls back to the
> +	# normal fetch-one case.
> +	git -C downstream remote add second .. &&
> +	git -C downstream fetch --all &&
> +
> +	add_submodule_commits &&
> +	add_superproject_commits &&
> +	old_commit=$(git rev-parse --short HEAD~) &&
> +	new_commit=$(git rev-parse --short HEAD) &&
> +
> +	git -C downstream fetch --all --no-recurse-submodules >actual.out 2>actual.err &&
> +
> +	cat >expect.out <<-EOF &&
> +	Fetching origin
> +	Fetching second
> +	EOF
> +
> +	cat >expect.err <<-EOF &&
> +	From $(test-tool path-utils real_path .)/.
> +	   $old_commit..$new_commit  super      -> origin/super
> +	From ..
> +	   $old_commit..$new_commit  super      -> second/super
> +	EOF
> +
> +	test_cmp expect.out actual.out &&
> +	test_cmp expect.err actual.err
> +'

The test looks okay, though is there a reason you didn't copy the style
of the previous test? It is nearly exactly what you want, I think, like
(untested)

  test_expect_success "fetch --all with --no-recurse-submodules only fetches superproject" '
    test_when_finished "rm -fr src_clone" &&
    git clone --recurse-submodules src src_clone &&
    (
      cd src_clone &&
      git remote add secondary ../src &&
      git config submodule.recurse true &&
      git config fetch.parallel 0 &&
      git fetch --all 2>../fetch-log
    ) &&
    grep "Fetching submodule" fetch-log >fetch-subs &&
    test_must_be_empty fetch-subs
  '

which has the handy benefit of not needing the test-tools invocation.
