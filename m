Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2141FC433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0EC82076D
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BI1OiZuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgGMTeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMTeH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:34:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A828CC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:34:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so13409155qkc.6
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DJW0YZrbFdcoYZiVvi90P4iffuVP9sGLXAx6RFRHBEQ=;
        b=BI1OiZuEeeO5mljjKx3FhFyhZUYB4a8hiP1nPBL79I6jmEhs8Z40QgLh7ZMfjJLGmH
         vtYzJDQdTPf97bZ1/PNpTh/PbfBpP1AXjWtdnuyCC+SNTVmvmnAjh4tIaCENzy7rEFHR
         ubp9RduaUFqZi8VivsQxdf8Vkkt1SS5CT2STQuMghscot9k9TWZt6IILgESOg6vuaOdj
         IG6R7c/xh9eMW01hZz/RkgXsFbvFhE3clxVcPD5ZcgoeJIPuolqiwXnCTeMkcs8bbrMc
         po5TVTXjW8PygKNxV1dsZcdUOQ/P9GrKUGdd6L1rsv1uDg0dWGfEo00dbBo0GNXQ7goO
         Hekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DJW0YZrbFdcoYZiVvi90P4iffuVP9sGLXAx6RFRHBEQ=;
        b=A61R+gSLCiS3BlowWJDGoBkddXcZdh5Hsrt9JHnHMuHcspFo/OG5lBg/3OrI8t2u7+
         aUyfn39la7+Rg452XyPkeEzpNZMsQ1wz8S91V9JkYUEiS8qSHQiP+oTEZ61SQpJILARE
         6wRF9MRFe38pRTuq+CWtmteQx2XL6qI2fWeC/b3tm2t149OUNb8zb1fEb8Z7gxTnqgwd
         eph28IeIvSP6Ghe3KqvATB9NgALb8sPY7nBn3S40RwBNAQeMpi0DBxZ5oKhv+m9CZbb6
         gAEDQx2d5V2hL7H098ezjb6HAIWQ8xbFcjGtq5XOy6yc+1UoxUEHlYbZvf/bjBIoF3Zd
         Y3Lg==
X-Gm-Message-State: AOAM5328KlmfTUGbWYm4uHcyJbZSmjxEN3M0Y/EPTjhZsPjtiZ1hy/vQ
        WWTSIb6n0KoMPSWm1mZxxi7pRQ==
X-Google-Smtp-Source: ABdhPJwtcF+XnHz1iJo9YKjC7B0RHzjF8HlLdA+U5EOPJ2/UpzJMVl9BI5hbtXZXcH7moLUJQY/Sfg==
X-Received: by 2002:a37:9e92:: with SMTP id h140mr1217814qke.46.1594668846775;
        Mon, 13 Jul 2020 12:34:06 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7dfb:38dc:7c85:86a3])
        by smtp.gmail.com with ESMTPSA id i57sm21837862qte.75.2020.07.13.12.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:34:06 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:34:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] setup: warn if extensions exist on old format
Message-ID: <20200713193405.GC77607@syl.lan>
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 07:20:51PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Prior to 14c7fa269e4 (check_repository_format_gently(): refuse extensions
> for old repositories, 2020-06-05), Git was honoring configured
> extensions, even if core.repositoryFormatVersion was 0 (or unset). This
> was incorrect, and is now fixed.
>
> The issue now is that users who relied on that previously bad behavior
> will upgrade to the next version of Git and suddently be in a bad
> situation. In particular, users of the 'git sparse-checkout' builting
> will rely on the extensions.worktreeConfig for the core.sparseCheckout
> and core.sparseCheckoutCone config options. Without that extension,
> these users will suddenly have repositories stop acting like a sparse
> repo.
>
> What is worse is that a user will be confronted with the following
> error if they try to run 'git sparse-checkout init' again:
>
> 	warning: unable to upgrade repository format from 0 to 1
>
> This is because the logic in 14c7fa269e4 refuses to upgrae repos when

s/upgrae/upgrade

> the version is unset but extensions exist.

I'm not sure that I want to get into a discussion about whether or not
this logic is right while -rc0 is already out, but it seems like
14c7fa269e4 could be tweaked to be a little more tolerant of this case.

On the other hand, I think that the approach here is perfectly sensible,
absent of a more invasive change to the logic in 14c7fa269e4.

> While it is important to correct this improper behavior, create a
> warning so users in this situation can correct themselves without too
> much guesswork. By creating a warning in
> check_repository_format_gently(), we can alert the user if they have a
> ocnfigured extension but not a configured repository version.

s/ocnfigured/configured

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     setup: warn if extensions exist on old format
>
>     This is based on xl/upgrade-repo-format.
>
>     Can this be considered for v2.28.0-rc1? I think this is an important
>     shift in behavior that will disrupt many users if they upgrade without
>     it!

I would be happy to see something like this in -rc1, unless Junio has
reservations about making this change at this point in the release cycle
(I do not have any such concerns).

>     If not this warning or change, then how else can we help users who are
>     in this situation? How can we save those who adopted the sparse-checkout
>     builtin in recent versions from terrible post-upgrade headaches?
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-674%2Fderrickstolee%2Fsparse-checkout-warning-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-674/derrickstolee/sparse-checkout-warning-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/674
>
>  setup.c                            | 5 +++++
>  t/t1091-sparse-checkout-builtin.sh | 9 +++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/setup.c b/setup.c
> index eb066db6d8..6ff6c54d39 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -542,6 +542,11 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
>  		}
>  	}
>
> +	if (candidate->version == 0 && candidate->has_extensions) {
> +		warning(_("some extensions are enabled, but core.repositoryFormatVersion=0"));
> +		warning(_("if you intended to use extensions, run 'git config core.repositoryFormatVersion 1'"));
> +	}
> +
>  	return 0;
>  }
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 88cdde255c..d249428f44 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -68,6 +68,15 @@ test_expect_success 'git sparse-checkout init' '
>  	check_files repo a
>  '
>
> +test_expect_success 'warning about core.repositoryFormatVersion' '
> +	test_when_finished git -C repo config core.repositoryFormatVersion 1 &&
> +	git -C repo status 2>err &&
> +	test_must_be_empty err &&
> +	git -C repo config --local core.repositoryFormatVersion 0 &&

I don't think it's that difficult to see that this patch is correct, but
it might be worth testing this for the case that
'core.repositoryFormatVersion' is unset, too.

> +	git -C repo status 2>err &&
> +	test_i18ngrep "some extensions are enabled, but core.repositoryFormatVersion=0" err
> +'
> +
>  test_expect_success 'git sparse-checkout list after init' '
>  	git -C repo sparse-checkout list >actual &&
>  	cat >expect <<-\EOF &&
>
> base-commit: 14c7fa269e42df4133edd9ae7763b678ed6594cd
> --
> gitgitgadget

Thanks,
Taylor
