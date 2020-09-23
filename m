Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA78C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 10:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BACD21BE5
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 10:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3EKBfBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIWKY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 06:24:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C14C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 03:24:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so20370818wrn.13
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=80e52a8RTzkk90sLEZgYRxkqLI7vjGuuYCYZ367mkGc=;
        b=L3EKBfBep5InfR3wjBNrgCH7Ib3VWx0TqfjtbAfwpaxNQpnXxkEPp8w6VPMKhHefAf
         rZo+UodBJ2HVzLvEaBMIKURq/6xq5DhTE9dR9bqtj4HQCsbP6OlGgbM4nTfEfC5kzXqe
         3vNwT3v20TQgTefre4OQTtXfq/BfwIWVulWdO9LhQBwHJ0UzHMfaBxms/tDVX27gAE6h
         oLFCIdYbuvYFBwpZEydo9gr/uNANiZ0ie151s3ZNNf8rRmxVkShIpMCo+NnEdtFVtVRl
         y5IjdvPHKbPKNf4+LzOEbpq3eIbn8YdzV8FroiA2VDGOlsekK6BkKp+BYZH99fA81HC/
         itYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=80e52a8RTzkk90sLEZgYRxkqLI7vjGuuYCYZ367mkGc=;
        b=DLe25153eX67+hJurFwlMdy20cwmXsgkR09g0/8w/gvXqxk2cv+mnW7Sd6Gt71JT4b
         UeWfO7lxL39H8rdNEkdB7b2VspxRQdHMPikzIYgjMIpohyHkgeBkLJverqQB7cv4WMqO
         ig7c+H6AzAMuoYDK3p7QkMcXXqhxx3PXa2NcxRWnfJ3Xy+2itXgkofLodeZbYi9P3U5k
         DG7SWx1h/2KcNTNnEZSshVs7ehFBOePMGnvGit7nAj0AnngR+12AxK/CUgxP8Pye2rFm
         CKDV6YQ0wxidnFGPMMWq4igZE3xBaa+G0f+9LY44Zg2QvGwVss1+T0up8yVHQZjn9XJ5
         5y7A==
X-Gm-Message-State: AOAM531BbeO9eVjm5myLQyXsxs4NIa7SQesiAzT21FiNnuEBTQ88YDcR
        bGJDZ0pyrZgbsVN/NQj9/VavhsVPSb4=
X-Google-Smtp-Source: ABdhPJwa6h5xibc6ATK/2H3BlBDJ8rnotVgujS5eDubOIPRHln4og//8uJqRdH6JCE5NaxveqRkkKw==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr31927wru.248.1600856667289;
        Wed, 23 Sep 2020 03:24:27 -0700 (PDT)
Received: from [192.168.1.201] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.googlemail.com with ESMTPSA id 97sm31753050wrm.15.2020.09.23.03.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 03:24:26 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] t, doc: update tests, reference for
 "--force-if-includes"
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
References: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
 <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
 <20200923073022.61293-4-shrinidhi.kaushik@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <65574677-faad-f13c-810f-68e0d07479b1@gmail.com>
Date:   Wed, 23 Sep 2020 11:24:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923073022.61293-4-shrinidhi.kaushik@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi

On 23/09/2020 08:30, Srinidhi Kaushik wrote:
> Update test cases for the new option, and document its usage
> and update related references.
> 
>   - t/t5533-push-cas.sh:
>     Update test cases for "compare-and-swap" when used along with
>     "--force-if-includes" helps mitigate overwrites when remote
>     ref are updated in the background.
> 
>   - Documentation:
>     Add reference for the new option, configuration setting
>     ("push.useForceIfIncludes") and advise messages.
> 
> Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
> ---
>   Documentation/config/advice.txt |  9 ++++--
>   Documentation/config/push.txt   |  6 ++++
>   Documentation/git-push.txt      | 26 +++++++++++++++-
>   t/t5533-push-cas.sh             | 53 +++++++++++++++++++++++++++++++++
>   4 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index bdd37c3eaa..acbd0c09aa 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -10,9 +10,8 @@ advice.*::
>   		that the check is disabled.
>   	pushUpdateRejected::
>   		Set this variable to 'false' if you want to disable
> -		'pushNonFFCurrent',
> -		'pushNonFFMatching', 'pushAlreadyExists',
> -		'pushFetchFirst', and 'pushNeedsForce'
> +		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
> +		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
>   		simultaneously.
>   	pushNonFFCurrent::
>   		Advice shown when linkgit:git-push[1] fails due to a
> @@ -41,6 +40,10 @@ advice.*::
>   		we can still suggest that the user push to either
>   		refs/heads/* or refs/tags/* based on the type of the
>   		source object.
> +	pushRefNeedsUpdate::
> +		Shown when linkgit:git-push[1] rejects a forced update of
> +		a branch when its remote-tracking ref has updates that we
> +		do not have locally.
>   	statusAheadBehind::
>   		Shown when linkgit:git-status[1] computes the ahead/behind
>   		counts for a local ref compared to its remote tracking ref,
> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index f5e5b38c68..fd981f7808 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -114,3 +114,9 @@ push.recurseSubmodules::
>   	specifying '--recurse-submodules=check|on-demand|no'.
>   	If not set, 'no' is used by default, unless 'submodule.recurse' is
>   	set (in which case a 'true' value means 'on-demand').
> +
> +push.useForceIfIncludes::
> +	If set to "true", it is equivalent to specifying
> +	"--force-if-includes" as an option to linkgit:git-push[1]

I think we normally use backquotes for option names in the documentation 
so this would be `--force-if-includes`

> +	in the command line. Adding "--no-force-if-includes" at the
> +	time of push overrides this configuration setting.
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 3b8053447e..706380d263 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>   	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
>   	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
>   	   [--[no-]signed|--signed=(true|false|if-asked)]
> -	   [--force-with-lease[=<refname>[:<expect>]]]
> +	   [--force-with-lease[=<refname>[:<expect>]] [--force-if-includes]]
>   	   [--no-verify] [<repository> [<refspec>...]]
>   
>   DESCRIPTION
> @@ -320,6 +320,14 @@ seen and are willing to overwrite, then rewrite history, and finally
>   force push changes to `master` if the remote version is still at
>   `base`, regardless of what your local `remotes/origin/master` has been
>   updated to in the background.
> ++
> +Alternatively, specifying "--force-if-includes" an an ancillary option
> +along with "--force-with-lease[=<refname>]" (i.e., without saying what
> +exact commit the ref on the remote side must be pointing at, or which
> +refs on the remote side are being protected) at the time of "push" will
> +verify if updates from the remote-tracking refs that may have been
> +implicitly updated in the background are integrated locally before
> +allowing a forced update.
>   
>   -f::
>   --force::
> @@ -341,6 +349,22 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
>   origin +master` to force a push to the `master` branch). See the
>   `<refspec>...` section above for details.
>   
> +--[no-]force-if-includes::
> +	Force an update only if the tip of the remote-tracking ref
> +	has been integrated locally.
> ++
> +This option enables a check that verifies if the tip of the
> +remote-tracking ref is reachable from one of the "reflog" entries of
> +the local branch based in it for a rewrite. The check ensures that any
> +updates from the remote have been incorporated locally by rejecting the
> +forced update if that is not the case.
> ++
> +If the option is passed without specifying "--force-with-lease", or
> +specified along with "--force-with-lease=<refname>:<expect>", it is
> +a "no-op".
> ++
> +Specifying "--no-force-if-includes" disables this behavior.
> +
>   --repo=<repository>::
>   	This option is equivalent to the <repository> argument. If both
>   	are specified, the command-line argument takes precedence.
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index 0b0eb1d025..620d101f50 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -256,4 +256,57 @@ test_expect_success 'background updates of REMOTE can be mitigated with a non-up
>   	)
>   '

It's great to see a couple of tests, however I think it would be useful 
to have some more - one to check that we do not force when the remote is 
rewound and a couple to show that we do force when we should. In 
particular we should still force if we `pull --rebase` and then rewrite 
the local history using `rebase -i` so that the remote ref is no longer 
an ancestor of the local HEAD.

Best Wishes

Phillip

> +test_expect_success 'background updates of REMOTE can be mitigated with "--force-if-includes"' '
> +	rm -rf src dst &&
> +	git init --bare src.bare &&
> +	test_when_finished "rm -rf src.bare" &&
> +	git clone --no-local src.bare dst &&
> +	test_when_finished "rm -rf dst" &&
> +	(
> +		cd dst &&
> +		test_commit G &&
> +		git push origin master:master
> +	) &&
> +	git clone --no-local src.bare dst2 &&
> +	test_when_finished "rm -rf dst2" &&
> +	(
> +		cd dst2 &&
> +		test_commit H &&
> +		git push
> +	) &&
> +	(
> +		cd dst &&
> +		test_commit I &&
> +		git fetch origin &&
> +		test_must_fail git push --force-with-lease --force-if-includes origin
> +	)
> +'
> +
> +test_expect_success 'background updates of REMOTE can be mitigated with "push.useForceIfIncludes"' '
> +	rm -rf src dst &&
> +	git init --bare src.bare &&
> +	test_when_finished "rm -rf src.bare" &&
> +	git clone --no-local src.bare dst &&
> +	test_when_finished "rm -rf dst" &&
> +	(
> +		cd dst &&
> +		test_commit G &&
> +		git push origin master:master
> +	) &&
> +	git clone --no-local src.bare dst2 &&
> +	test_when_finished "rm -rf dst2" &&
> +	(
> +		cd dst2 &&
> +		test_commit H &&
> +		git push
> +	) &&
> +	(
> +		cd dst &&
> +		test_commit I &&
> +		git fetch origin &&
> +		git config --local push.useForceIfIncludes "true" &&
> +		test_must_fail git push --force-with-lease origin
> +	)
> +'
> +
>   test_done
> 

