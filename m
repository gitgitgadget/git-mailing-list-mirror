Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2C27B51C
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420015; cv=none; b=bkF/WXSxEcSC916vtBUCn9KW5dPOuouczQ6LgPOUmvEmzJjUn5OtQ2jOI+OcwqXsuV8k/DceL+JdQghZ8N3iFsCYsPwBtvC60hZX9H+xfwf42Q6jEYw7eypeUf6leFlthej9emsyejC0M/qErMIrQuVqB55n4pRmZt+0DfR/UrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420015; c=relaxed/simple;
	bh=mVwtlFYuB0QVPAXVIf3NPd7HqBWDlgSItvWJyDCEcFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpKAYo8yWbMX7TcT7Mv76HqWzKECkOyeBw//dnVT2yyuCNbx8YmRwwTVgZm78GyGCNhtNyiS/IuoUmm/dNaBeox8P4zpN5/isElm31LZAkmEeJ5uTNWy0PqvQ0sQ0un5nAEXKjFLKqxCNHuxF6IvawPDtSP2t7H2HqPXtfQIREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ey6zZsuQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ey6zZsuQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231f61dc510so29495ad.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747420013; x=1748024813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSKRiVXPn3tRLx6qCNg42KbHz8JzODothOdq49x/ryM=;
        b=ey6zZsuQlCAHb/woRTNHY37/Jot6gBN8EfFOFn6eVEA/d/om1QTjInm+ikr5NrxsTJ
         Ui13P3tX3ch5QJO25AkJhNzdsuYK5sNF/G2+Zitms4FBniIjqvcw6GQIQNnq019YznZN
         PrL8kXj9/yIIFtK5S7xaJun035O2RUaFV7WLbf7bNnWVB77vvCQNlLxgYkMCYiE+bOzQ
         /cGaLcwvKvJykFptHkg/BXUIGS8jAeHoLXMtHhUFP9TW1qBEG6X+gzVVO0SvVXqJrAHg
         3azxLgOP7M5p8Y8pczucdAnbVN9dDjVTQ7/BUn8+oPYumHRpxQPXLCs2tqWnmMoblEH4
         KXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747420013; x=1748024813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSKRiVXPn3tRLx6qCNg42KbHz8JzODothOdq49x/ryM=;
        b=eqGvzEWVV6PyGnFzQMh3rg0hQ+o++R/de8Ygsi0w2ZdanE1/cjTZJhmlyiAGvj3Dxf
         y8oD6NsB4VKnR+yYLtX+bHa8SFLbEJP5S6a8eNIGiwVngQQdSY7Ch6R6LR5Msbcl/eMF
         hI0tg1bpnUV1k+QYxuPO8Rye+nZpKR4M6T5G0Qs8hAQNs0eRg4dAmZ0A/Ey4NofymE+6
         dM+/YrnDRmzFn0KNFmMf4s7GeEPWLH+fJEbcRHCLVl8+lANObp9OT2a7qSdE9JHfsU62
         7PLAHjRJSvE8W9drCxc8n1KcWwsWP/egKVItvgl1LGj6H3cS3yL8JwKva2FK+2AbLfis
         Hzkw==
X-Gm-Message-State: AOJu0YyohnqT+QosbLIge8X1RUXxmznestBvm0MPQ7iUXWG1oP0zBNkQ
	QHM3oQgDJP+fvzgQKBSicwr54nPbQkXc+dzGGm09tbPEbeB6OhqLq1DkGcjy0o1BYXbjQ7EnzsC
	4RHaughKH
X-Gm-Gg: ASbGncvdFPrHUwCnLg2Gzrz1wjRZd6iHzU90MkbkOFz1Wj0xk15K9JefarGwLEtdlh1
	Cg1KR0YnmgdzO1akgrBRcXNvBsq1ATtgg7MAl4rEmnjEZVnyRt4dOKRRsohWt3cUXLP4ZrqgYiN
	vgIQqhSU4EveIzd2Wcrb79RdsCGJOpB1hAUFSz79RQyEnR+9bJGY8xu6XbaoeNmJtQ+6B6vUZ/A
	SIT5GjrwmuaxVMpHXEJVU5EgxPe6ua/Gwmmshpl2TER+3ckU2sBtCyk28tWUdUkOMu+qserWcTj
	LO4gHsbncuF1r0T2g79Gu07pVAxN4pxLK+BVf3KjCJ2PlxuMEZ0Fe0uG4aI=
X-Google-Smtp-Source: AGHT+IHHWYg3Z7I8bRmx259D1Qu+FB/HKB3N0FDg0O1p53GtWmBx35VQbv4rPCqj9qDEZRma91Bf2g==
X-Received: by 2002:a17:902:f684:b0:231:d7cf:cf18 with SMTP id d9443c01a7336-231ffe4c9e5mr145575ad.1.1747420013097;
        Fri, 16 May 2025 11:26:53 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8ff7:6c9:7fc9:b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e9748csm17388375ad.158.2025.05.16.11.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:26:52 -0700 (PDT)
Date: Fri, 16 May 2025 11:26:46 -0700
From: Emily Shaffer <nasamuffin@google.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] cmd_psuh: Prefer repo_config for config lookup
Message-ID: <aCeDZgaNWPbDV0Ra@google.com>
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <20250416061450.25695-5-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416061450.25695-5-jayatheerthkulkarni2005@gmail.com>

On Wed, Apr 16, 2025 at 11:44:50AM +0530, K Jayatheerth wrote:
> 
> This commit updates cmd_psuh to use repo_config and
> repo_config_get_string_tmp for retrieving the user.name config
> variable. This is a more robust and correct approach than using the
> global git_config functions because:
> 
> git_config uses the global configuration, ignoring any
> repository-specific settings (e.g., in .git/config). repo_config
> loads the configuration specific to the repository,
> ensuring that the correct settings are used.
> 
> repo_config_get_string_tmp retrieves configuration values
> relative to the repository, respecting any local overrides.
> 
> This change ensures that cmd_psuh correctly reads the
> user.name setting that applies to the current repository,
> rather than relying on globalsettings that might be
> incorrect or misleading. It also demonstrates the correct way
> to access repository-specific configuration within Git commands.

This commit message is a really good start! I like that you're pointing
out there's a real bug in using global config and ignoring repo-local
config. Although I'm not sure that it's actually accurate... but it is
true that git_config() is now an outdated way to access config, since it
assumes the_repository instead of passing the `repo` variable that was
provided to cmd_psuh.

> 
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 52 ++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index ed6dcc1fc6..688240ce8b 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -325,26 +325,48 @@ on the command line, including the name of our command. (If `prefix` is empty
>  for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
>  helpful. So what other context can we get?
>  
> -Add a line to `#include "config.h"`. Then, add the following bits to the
> -function body:
> +Add a line to `#include "config.h"` and `#include "repository.h"`. 
> +Then, add the following bits to the function body:
>  
>  ----
> -	const char *cfg_name;
> +#include "builtin.h"
> +#include "gettext.h"
> +#include "config.h"
> +#include "repository.h"  
>  
> -...
> +int cmd_psuh(int argc, const char **argv, 
> +			const char *prefix, struct repository *repo)
> +{
> +    const char *cfg_name;
> +
> +    printf(Q_("Your args (there is %d):\n",
> +              "Your args (there are %d):\n",
> +              argc),
> +           argc);
>  
> -	git_config(git_default_config, NULL);
> -	if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
> -		printf(_("No name is found in config\n"));
> -	else
> -		printf(_("Your name: %s\n"), cfg_name);
> +    for (int i = 0; i < argc; i++) {
> +        printf("%d: %s\n", i, argv[i]);
> +    }
> +
> +    printf(_("Your current working directory:\n<top-level>%s%s\n"),
> +           prefix ? "/" : "", prefix ? prefix : "");
> +
> +    repo_config(repo, git_default_config, NULL);
> +
> +    if (repo_config_get_string_tmp(repo, "user.name", &cfg_name))
> +        printf(_("No name is found in config\n"));
> +    else
> +        printf(_("Your name: %s\n"), cfg_name);
> +
> +    return 0;
> +}

I'd prefer to see this stick to the prior formula of including only
small chunks of the function, rather than a full function you can copy
and paste. Because this is a tutorial, and the goal is for learners to
understand each section of code as they add it, not just for them to
paste it into their editor and hit run.

So, I don't think it's necessary for you to add the rest of the function
here in the process of switching to repo_config from git_config.


Generally, I find the changes to update the code snippets
unobjectionable and don't have a problem with the added prose
beyond a couple nits. But as I assume you sent this series as a way to
learn more about the codebase, definitely please revisit your commit
messages to align their style with the rest of the codebase.

But I think with the stuff I called out taken into account in v2, this
series is good. Thanks for the effort to update it. I'd also like to
update github.com/nasamuffin/git/tree/psuh once this series lands, if
you can point me to a branch of yours with the sample code I can pull
from :)

(Or, as we discussed when I sent this doc in the first place, does it
make sense for a branch with the sample code to be maintained
only-best-effort on git/git itself?)

 - Emily

>
>  ----
>  
> -`git_config()` will grab the configuration from config files known to Git and
> -apply standard precedence rules. `git_config_get_string_tmp()` will look up
> +`repo_config()` will grab the configuration from config files known to Git and
> +apply standard precedence rules. `repo_config_get_string_tmp()` will look up
>  a specific key ("user.name") and give you the value. There are a number of
>  single-key lookup functions like this one; you can see them all (and more info
> -about how to use `git_config()`) in `Documentation/technical/api-config.adoc`.
> +about how to use `repo_config()`) in `Documentation/technical/api-config.adoc`.
>  
>  You should see that the name printed matches the one you see when you run:
>  
> @@ -377,7 +399,7 @@ status_init_config(&s, git_status_config);
>  ----
>  
>  But as we drill down, we can find that `status_init_config()` wraps a call
> -to `git_config()`. Let's modify the code we wrote in the previous commit.
> +to `repo_config()`. Let's modify the code we wrote in the previous commit.
>  
>  Be sure to include the header to allow you to use `struct wt_status`:
>  
> @@ -393,8 +415,8 @@ prepare it, and print its contents:
>  
>  ...
>  
> -	wt_status_prepare(the_repository, &status);
> -	git_config(git_default_config, &status);
> +	wt_status_prepare(repo, &status);
> +	repo_config(repo, git_default_config, &status);
>  
>  ...
>  
> -- 
> 2.49.GIT
> 
> 
