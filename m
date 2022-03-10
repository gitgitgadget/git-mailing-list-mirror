Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01D6C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 21:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbiCJVzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245598AbiCJVzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 16:55:16 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A729A194171
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:54:14 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x123-20020a626381000000b004f6fc50208eso4012699pfb.11
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dQF+dWIj/dsln5acb7KxXSF8fIesc3nQvZjmUAb6r8Q=;
        b=hJ1v74vAtSLu2WgEBXfXOwdiJSoVEULVkKnGrUsvOeU0XGrryd9mIU56UsxI3Kjw0l
         VMnGuUyUCsKBoBUAcU/pqQ4My41wYz6bMrrUc2vZfBVwZejz/0p6D0uTbz0CuvBt/8bU
         cmY6lOODFYOVmIJP0WH/mNMBYLZkXKtcpUCmkAHlNy0Jx1r4enKtrGL/qlx/q881IndU
         UXn+GzWfOiLWTaMtPsn0u2b7zcdcvwhMgubFdnFxypHWAtOHYMswQvDK2UE8nDTqfWQ1
         4hb7jQiFZE0cOzWpPG3Z5E2LMPfj1JTVpbx6i8y8KmwacrkkxoEbxJrQM2P+3ZM+724+
         S1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dQF+dWIj/dsln5acb7KxXSF8fIesc3nQvZjmUAb6r8Q=;
        b=tlMpTJ+FqTtDoafCMZMjLhSPuGAADK0O0/fEnUDUzgkv7A4i8cDURWFZ5y0rYZ9Uo6
         SXgCTgnra2jwmmQSewttxe/VUrsyw2hcx1q4j4riWugS5Cvv7x0cNNQJ5qRk4RcAVXRX
         obn1X6K2cRF6JW6frPKWYvAGnjdTB3bvXQrdhkcSXZIs2NoI3juYLcBOmNBHNp0aHjjo
         o9ym4CnX+KcurZmNrk67WIg4du0r5J9ATGy2PIts2MMyWC2pBn5NNka5puz0zCUKSVTq
         7HH5xmZRm/gS/v4dgL04GgjTzNqP9qMhQozNgVpkCCcYlIMus29omUIVjHzeet9Iv2p2
         ghAw==
X-Gm-Message-State: AOAM532nN5+AuV7cT37//9+/psTp9vrdzKa4QL/4BSYeFcUtsDJ9lWFH
        isrQEn6kIfTRh3xo3qXG/+CsBLaR4gtomA==
X-Google-Smtp-Source: ABdhPJxHvD0SDFzsYNuS3M0RoZYr2A46v0UB/sjRYbwRD3v5dbuOc3R/IXoU0m9ZSogsK8Htaecddh1wFlAcyQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP
 id oj1-20020a17090b4d8100b001bf8ce44f51mr254661pjb.0.1646949253857; Thu, 10
 Mar 2022 13:54:13 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:54:12 -0800
In-Reply-To: <20220310004423.2627181-3-emilyshaffer@google.com>
Message-Id: <kl6l7d91sccb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com> <20220310004423.2627181-3-emilyshaffer@google.com>
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
From:   Glen Choo <chooglen@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> index ee454f8126..99d5260b8e 100644
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c5d3fc3817..eda9ed550e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1839,6 +1839,11 @@ static int clone_submodule(struct module_clone_data *clone_data)
>  		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
>  				       error_strategy);
>  
> +	/*
> +	 * Teach the submodule that it's a submodule.
> +	 */
> +	git_config_set_in_file(p, "submodule.hasSuperproject", "true");
> +
>  	free(sm_alternate);
>  	free(error_strategy);

This git_config_set_* is superfluous - it sets the config in newly
cloned submodules..

>  
> @@ -2617,6 +2622,12 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
>  
>  	free(prefixed_path);
>  
> +	/*
> +	 * This entry point is always called from a submodule, so this is a
> +	 * good place to set a hint that this repo is a submodule.
> +	 */
> +	git_config_set("submodule.hasSuperproject", "true");
> +
>  	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
>  		return do_run_update_procedure(&update_data);
>  

but this is called over *all* submodules, so we're guaranteed to always
set the config if "git submodule update" isn't interrupted halfway.

I don't think we guarantee correctness if it is interrupted halfway e.g.
core.worktree can be unset if it is interrupted halfway (because
ensure-core-worktree is called adjacent to run-update-procedure, not
inside of update-clone).

So I think it's better to just drop the previous hunk - it will
disappear anyway in gc/submodule-update-part2.
