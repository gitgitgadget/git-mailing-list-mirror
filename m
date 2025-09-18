Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8460B8A
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207996; cv=none; b=VYeHAQYuLuB/3qxGt6tARE0L6zMcld3WxcHV4P0qfGHgXFAlfWb4khML/zCdgH5Q+FC+j6U3fbkFFfrf95DRdltq7jNoLxRxuURgVD4xbNd88Nk/TAGHohcB2NHjXNkU1ZxQ3phzUpNmltpYDPRyxdf7G0uOEP3XXeEcKk+bKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207996; c=relaxed/simple;
	bh=bF4QcGg4E94vUHBVYEAfPzquJOemT220mwk8Bw4+h9Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SNCG3TRNLazgjy4vc8v6unncw+SHAy536lO6hF1etzPvmuR8OsL0Bkk4tYK4dkxHJecjlMiqTAXNj3GOz9ore9pgRJJu1yKU+v94oiGH2Q2n0/jh7e1KyqUnyeTQliD9u72Yyj0iFEUZgH6T1Bj1mnhdehuQspJxqSt7BprN064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnEOHbII; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnEOHbII"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso7619315e9.3
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207992; x=1758812792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2spIBkgdzqOPOnqQ9WGkRgpnP9QIwhZj/lXJuAHBDs=;
        b=lnEOHbII/qm6mQ4m3JYTg7alMhmu27c9ttepw1p4vZkvi7fawL9Vju4sILv11rhLs0
         9eSPVMwEEldUH9fu86MBuxWXELrXIVQTV2SNfn9tka6YBO+yPTnF8uhQNzBLOTIB4ZuS
         N4SDGj2lMwrzLW+8X3zri5CCxj+awzlingoaeVeFrwSE1JSOFUUpLqLHcThx184S7aXw
         FkUrMST8RWXiY1szp6Fsld/nNQE0yJ0jC8nh0XWOVxMpCqcdeVNzPKu5xBuuWN+V3btu
         /6qdbQjo2WGqOjKJcFBeF1ksypIvn6IhFuyeMtU8k6KAztmlFFgVRFzrV4ZIVBPsIXsD
         mLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207992; x=1758812792;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2spIBkgdzqOPOnqQ9WGkRgpnP9QIwhZj/lXJuAHBDs=;
        b=srtY+IZeLhG+EwfoNvEnTZmTLvLmvjchgwnbJR7jFGfPllOz3ao4P1hwwavid2hX5e
         m8G68+t9kxVV2QGuA551C8RlNtQMea42Z/IfD9mnFKGfNmtREtIO+yw6gPr7V3wATXLE
         tv8vAw9BgXJnQAZk2l9R0hLaUGQZTS9umf38npbOQS+3VvXmBAPpxCj914hmun+u0G67
         FR4O8IIOLdKZKUUknKzzpB7tZwfMrct3GrxTzmuC6XUmQb7Dt6qkKNFelq6N71gnK2t9
         lxtGTXfRF7nmptCEP6oEkIeNQkoEy+oykni5soBgOe3CPDvjZgdC/yFYhLMYMaLo4YLE
         QEew==
X-Forwarded-Encrypted: i=1; AJvYcCWq49Mrru+DiMaE+6lPn0BaCQ5raMuYWguQ3NeSzyOE8fU5RLavht+3SmmelFDeqcdei5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlbV50/uuh3AsxSZPABMHmZJj1dzPC+YIJc/rNBSWXdrJ8Ew7
	lIkMighyxpJ95IA7Ve+930diSpDT6gpBBESFA9m5AF5Q8N7cjyJ0M79N
X-Gm-Gg: ASbGncu62raBFyreNMGVchJYBo3+J6T5MjCfBxiYaYlGWIeAAp9ons3slAGIF55JhVq
	5Vn3JCjGUxhcriAmM+wUHXOpTXE+EwhvoLZ6PZ3zf0zmHsYBkQcVBEoI+X1gNp3THUKC1K8wj3o
	PVSeGgiZVzbkK3s5jm2ywLSmOcy+XcKhQazLmYAB3/iykKShk0JQvA8evLnuHRcxK5nV1WMtKug
	BkNnqeXhnhQhj+o6gBjB7OBoNU+vtBLi0x5s52MZwnDuR/YNaaiwbIITJ9JS1/Bi0Y5sxNMQEnU
	qhdUeYACnNtmE63xaK0dWvFeIVngPcYiSAwwQMlWWz+iwV6IFoq5M0heqxzfdS1xAFm+BK/MuIr
	FQrByMOqiXfrPfDxSA4fcxp2PiuO0MtNJTxUibvMfABdrknwXzGfbapCvW3DKUWiK4i4guXimKV
	Ubn8chEpeauual1A3G7w==
X-Google-Smtp-Source: AGHT+IFOZNyRPJkhwsSHV12u1gX+p0pnybZaBwduW8RNxmOhTdnsBtowofV3RD+wQA8UeDwFl8WLaQ==
X-Received: by 2002:a05:600c:3109:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-46205cc8423mr53850975e9.20.1758207992183;
        Thu, 18 Sep 2025 08:06:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7460sm4076964f8f.31.2025.09.18.08.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:06:30 -0700 (PDT)
Message-ID: <5629352c-2505-4254-8d47-d63f3430ceff@gmail.com>
Date: Thu, 18 Sep 2025 16:06:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/4] initial branch: give hints after switching the
 default name
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1757518141.git.phillip.wood@dunelm.org.uk>
 <xmqqikhhdpd7.fsf_-_@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqikhhdpd7.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/09/2025 17:18, Junio C Hamano wrote:
> It is likely that those who came to Git after 3.0 switched the
> default initial branch name to 'main' would still try to follow
> tutorials that were written before 3.0 happened and with the
> assumption that the tool would call the initial branch 'master'.
> 
> To help these new users after 3.0 boundary, let's retain one part of
> the hint we will be giving before the default changes, namely, how
> to rename the branch an unconfigured Git has created just once.
> 
> We do this without telling them how to permanently configure the
> default name of the initial branch, and that design choice is very
> much deliberate.  The whole point of switching the default name was
> because we did not want to force individual users to configure their
> default branch name but while the hard wired default was 'master',
> they _had_ to configure it away from 'master' in order to conform to
> the recent norm, and a hint that tells them how to do so is useful.
> 
> But once the default is renamed to 'main', that no longer is true.
> A narrower audience who are new users that follow an instruction
> that assumes the initial branch name is 'master' would only need to
> learn "here is how to change the branch name to match the tutorial
> you are following in the repository you created for practice", and
> "here is how you keep creating repositories with the first branch
> with a name everybody hates" is unnecessary.
> 
> It also needs to be noted that the advise token to squelch the
> message is the same advice.defaultBranchName as before, which is
> also very much deliberate.  The users who do have that configured
> are those who _have_ been using Git since before 3.0, and they are
> not the target audience for the new advice message.  Reusing the
> same advise token ensures that they do not have to turn the message
> off.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   * With simplified tests, thanks to Phillip's help.

This looks good. The only thing I wondered about was whether we should
keep

-test_expect_success !WITH_BREAKING_CHANGES 'advice on unconfigured init.defaultBranch' '
+test_expect_success 'advice on unconfigured init.defaultBranch' '
  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
  		init unconfigured-default-branch-name 2>err &&

in t0001-init.sh from the previous version as we're still printing some
advice.

Thanks

Phillip

> 
>   advice.c      |  2 --
>   advice.h      |  4 +---
>   refs.c        | 12 ++++++++++--
>   t/test-lib.sh | 10 +++++++---
>   4 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/advice.c b/advice.c
> index 48c49ee414..e5f0ff8449 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -51,9 +51,7 @@ static struct {
>   	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
>   	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
>   	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
> -#ifndef WITH_BREAKING_CHANGES
>   	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
> -#endif /* WITH_BREAKING_CHANGES */
>   	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
>   	[ADVICE_DIVERGING]				= { "diverging" },
>   	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
> diff --git a/advice.h b/advice.h
> index fc1dc87204..8def280688 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -18,9 +18,7 @@ enum advice_type {
>   	ADVICE_AM_WORK_DIR,
>   	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
>   	ADVICE_COMMIT_BEFORE_MERGE,
> -#ifndef WITH_BREAKING_CHANGES
> -	ADVICE_DEFAULT_BRANCH_NAME,
> -#endif /* WITH_BREAKING_CHANGES */
> +	ADVICE_DEFAULT_BRANCH_NAME, /* To be retired sometime after Git 3.0 */
>   	ADVICE_DETACHED_HEAD,
>   	ADVICE_DIVERGING,
>   	ADVICE_FETCH_SET_HEAD_WARN,
> diff --git a/refs.c b/refs.c
> index 149a8d1cec..f15366bfce 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -641,9 +641,17 @@ static const char default_branch_name_advice[] = N_(
>   "\n"
>   "\tgit branch -m <name>\n"
>   );
> +#else
> +static const char default_branch_name_advice[] = N_(
> +"Using '%s' as the name for the initial branch since Git 3.0.\n"
> +"If you expected Git to create 'master', the just-created\n"
> +"branch can be renamed via this command:\n"
> +"\n"
> +"\tgit branch -m master\n"
> +);
>   #endif /* WITH_BREAKING_CHANGES */
>   
> -char *repo_default_branch_name(struct repository *r, MAYBE_UNUSED int quiet)
> +char *repo_default_branch_name(struct repository *r, int quiet)
>   {
>   	const char *config_key = "init.defaultbranch";
>   	const char *config_display_key = "init.defaultBranch";
> @@ -660,10 +668,10 @@ char *repo_default_branch_name(struct repository *r, MAYBE_UNUSED int quiet)
>   		ret = xstrdup("main");
>   #else
>   		ret = xstrdup("master");
> +#endif /* WITH_BREAKING_CHANGES */
>   		if (!quiet)
>   			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
>   					  _(default_branch_name_advice), ret);
> -#endif /* WITH_BREAKING_CHANGES */
>   	}
>   
>   	full_ref = xstrfmt("refs/heads/%s", ret);
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index b191954c3c..562f950fb0 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -127,13 +127,17 @@ then
>   	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
>   fi
>   
> +# Explicitly set the default branch name for testing, to squelch hints
> +# from "git init" during the transition period.  Should be removed
> +# after we decide to remove ADVICE_DEFAULT_BRANCH_NAME
>   if test -z "$WITH_BREAKING_CHANGES"
>   then
> -	# Explicitly set the default branch name for testing, to avoid the
> -	# transitory "git init" warning under --verbose.
>   	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
> -	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +else
> +	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=main}
>   fi
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
>   
>   ################################################################
>   # It appears that people try to run tests without building...

