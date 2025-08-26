Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3E30F55C
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202340; cv=none; b=Slez5bd2ylu8gQ1s9tOj2McvmUTa3vZbalf0k3Q2rplZT8pzgd7tTq/PM+AhgElW8+E2QwMnssGw+SOuzmZt47Q55gFVC085TBFY6Cr4Bx4uRpzwvmQrVEJyFmlo/KSVTszKkW9te2NG03KyKjIpSB+KkL4zTLigSk26QEcvw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202340; c=relaxed/simple;
	bh=6fDFIL7R+H1wW/w8K36wse9WvY5TYYTAi9sH8TMR6wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwoadEIAvbQ4joua12PMOx4OPspMbHYC0PtYmqSv6dzHJP12/uSXKOIuincuFlQKwaTTrnHHQaPmhHXmU3S/XRjI+N0kXHH73ZuF4wXzKDBycR/Sx84lYomvD1v8EB26liMQ4RaLJEjs2eQ1Xgcbp4pwGtsZAOnhiv4w8dBPcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxXmhDgr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxXmhDgr"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso43367935e9.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756202337; x=1756807137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XEnRl8I5yLTUiN3wXtFkaGJyVc5FvPO8bk2kZspATMk=;
        b=TxXmhDgrD7RuIXFAGV6m2VsP1ZfahmY//GFb/JAhYFEfgnt7Ea/ZGOcIhElnS1tHL3
         W+6G9D8oPx3LEBQdmjfX/xJcUesjYmWBLEvWHVd9z7imQmGPbKwIDRjd+JRdLdJ3mNCV
         pRmMDB8ue7cx43jkKeOVJ6K3ijiAJQd1Cq1ZTArFqG72+I8gchymUJBIYkqn3ahIKYSB
         2GwSfvnOUBPUO2rLXaU18687gVvgCNB1p390BOuT8bDffWxogdX0KheubzlhB7yU60in
         +5LE4Q4BuQH5XO/zQtW+lww65zsYdg/uK7R9p7gf4+xsgovqw7xTi0Uehiry2CKySICp
         8eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202337; x=1756807137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEnRl8I5yLTUiN3wXtFkaGJyVc5FvPO8bk2kZspATMk=;
        b=nAHZ8ocyMn0yTiKnRcpd4oMG/B/3cHCQa0oT3XuWJmV87nEovOZVSkI6CK8H1abTb3
         sEpPhE42AQYcZs1O1JsVqqGzO6BWcqKCtZI+c30ev7xurvg5zDnvzj+Rz9KYPz3N1AaJ
         Uim55Tb16bIs51yHoJ1EWdIjlmho+fE1PAhMr21pBvCFEEArxudCNy5Zu7hqRl9H38h1
         Ak6j8HQxtVWaPun9edlqi/JUosKDDQmifF5/jfBWy9fWHXLf2qjNHG33qAqMUkAMMBQz
         6TLpd7KFZPpKCO3jkidofluBG5knqYOnyIpfKtsLcz9GEaIUxfin6A3kzVns3bpP/r3v
         f/og==
X-Forwarded-Encrypted: i=1; AJvYcCVDbQaPldlh5Q/cpr5vJxr2oDB/HgBkYWkaII//p9DU2Mu2WY3ZpZnIGNROPLzX62kNdJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYbyunMKmUiWgK+bd7oYCA19/3f3Kvlh8xF8tXtmGc8oE4ibc4
	0VOGOe5iyeh01GPcIkG3Hq8T7lLxBB/goLhqIRA9knISd6cUjKr9zpuTNnWdVg==
X-Gm-Gg: ASbGnctN8jBTjyJWVIJ1Dd8OIQiFIO6Q57kw8tmIkO/NJDjkw5VGuubhYcuzQTbbaeq
	JKzKXr5e0R97oiDNfwXGQD4mPsYfXn7KaE3cq84vq5ZDaDtaHoeT4fqajoymrPAFCiAid5sypBV
	lpYWJBHaowfGcLhBURXtzn8/10/HM/Bi2GOOiAfmge7OvxOGv5iph+jUFpO/vP6TfqnTu6K3uSF
	8Oy6/1A4fQrkisrcsmXkPw2NJVLdDAO7VUm/xNZp5eyjCX32NwInemDU6UZXwOonyHq64WF0NOG
	iXr4RGkAOvZybbittXB6FY+FvONSsRBMuRz3aP/8MJgVLFheRlpgLChOEYzEQq64d2VGZ0n1bt1
	i7zq7KMcGDABWNkpYANMXbqWGvqCWdUwJ/rb3MHSVjSTKz2Dvqnr6pqi/+Q1SmrB9fcqIFAMnQA
	eJnw==
X-Google-Smtp-Source: AGHT+IGOybDXaDsbagjUPkzmvP1U3pdLFQOClB7pJlUC/21Md3j4Mwx3eKzwkyKqaROzO0x9b/P3dA==
X-Received: by 2002:a05:600c:1f8f:b0:45b:47e1:ef6a with SMTP id 5b1f17b1804b1-45b517e9d25mr109439425e9.37.1756202337096;
        Tue, 26 Aug 2025 02:58:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57444b2fsm148848615e9.5.2025.08.26.02.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:58:56 -0700 (PDT)
Message-ID: <0a574b62-273e-4519-855f-66c554cd93c7@gmail.com>
Date: Tue, 26 Aug 2025 10:58:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rename default branch from 'master' to 'main' in refs and
 test scripts
To: Wing Huang via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Wing Huang <huangsen365@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
References: <pull.1961.git.1756183921623.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1961.git.1756183921623.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2025 05:52, Wing Huang via GitGitGadget wrote:
> From: Wing Huang <huangsen365@gmail.com>
> 
> Signed-off-by: Wing Huang <huangsen365@gmail.com>
> 
> 	modified:   refs.c
> 	modified:   remote.c
> 	modified:   t/test-lib.sh
> ---
>      rename default branch from 'master' to 'main' in refs and test scripts
>      
>      This patch updates Git's default branch name from 'master' to 'main' to
>      align with modern naming conventions adopted across the industry.

Thank you for your interest in this. We're currently planning to change 
the default branch name when Git 3.0 is released as documented in 
Documentation/BreakingChanges.adoc. I've actually been working on some 
patches to do that at [1] which are almost ready to submit.

>       * refs.c: Update hardcoded default branch name to 'main'

Once we've done that we can also remove the advice about setting a 
default branch name.

>       * remote.c: Update fallback branch name for remote operations

I think we want to keep the fallback to "master" but check for "main" 
first. Otherwise we'll stop finding the default branch where the remote 
is still using master.

>       * t/test-lib.sh: Update test suite default to 'main'

GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME is intended to aid the transition 
from master to main, once the branch name is changed it can be removed 
(with a little bit of work).

Thanks

Phillip

[1] 
https://github.com/git/git/compare/master...phillipwood:git:initial-branch-is-main

>      Compatibility notes:
>      
>       * Existing repositories are unaffected
>       * Users can still set init.defaultBranch=master if preferred
>       * The change only applies to new git init operations when no explicit
>         branch name is configured
>      
>      This follows the precedent set when init.defaultBranch configuration was
>      introduced in Git 2.28, which already acknowledged the community's move
>      toward more inclusive default branch names.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1961%2Fhuangsen365%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1961/huangsen365/master-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1961
> 
>   refs.c        | 2 +-
>   remote.c      | 2 +-
>   t/test-lib.sh | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 4ff55cf24f6..929e9ce60c6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -653,7 +653,7 @@ char *repo_default_branch_name(struct repository *r, int quiet)
>   		die(_("could not retrieve `%s`"), config_display_key);
>   
>   	if (!ret) {
> -		ret = xstrdup("master");
> +		ret = xstrdup("main");
>   		if (!quiet)
>   			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
>   					  _(default_branch_name_advice), ret);
> diff --git a/remote.c b/remote.c
> index 81d8fc017e1..ffc4089a1c2 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2379,7 +2379,7 @@ struct ref *guess_remote_head(const struct ref *head,
>   			return copy_ref(r);
>   
>   		/* Fall back to the hard-coded historical default */
> -		r = find_ref_by_name(refs, "refs/heads/master");
> +		r = find_ref_by_name(refs, "refs/heads/main");
>   		if (r && oideq(&r->old_oid, &head->old_oid))
>   			return copy_ref(r);
>   	}
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 621cd31ae1d..4e273a6e94d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -129,7 +129,7 @@ fi
>   
>   # Explicitly set the default branch name for testing, to avoid the
>   # transitory "git init" warning under --verbose.
> -: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
> +: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=main}
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
>   ################################################################
> 
> base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3

