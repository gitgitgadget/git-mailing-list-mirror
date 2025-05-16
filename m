Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52781278E7F
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419178; cv=none; b=QZSUAIrioBO6g+I9JsWL4euTqvZNZKWMClv02183iA4hAbqpAyJgRXtjIJSv6YYnKMDTa+F4QJYxvuzO3xa+Mbvy07u+h9kHSgYyX57q+zjnhR41VT3awi0RK0x70xU33vdHFfG4LgdoSu1McBcm3xjyLeKPxCdtF2wvvCEg4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419178; c=relaxed/simple;
	bh=hSrCnj6hyWIUtFI6pnqDt7Qbk/R+7NyGuUNV3lZz6Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWkViHt8IUgtImtqSDTIRYDT+6Zu2JKIHsaFLKaMur4uM2Zcu2eetP7KoFKlFz8mlMSzm66yxlhvkhBUu3JL5zdJPhc6TZtQTGGiFIOh/joK0cyNNy+89jzd7dZPtMkrFU4PMvTlgKNu9+0QjJrzWy83yQX6zVxp2EerGI2Qpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqJQi5cf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqJQi5cf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231f61dc510so26745ad.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747419176; x=1748023976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYIJm2q9Yp2zD8GIKkON4+609O1mUpe2xgodUE4VVIU=;
        b=FqJQi5cf/YFIqK6O4RBm3CCplLp5vSownZ7ceEab3hPpOiPLHL6qQoxAGkEfoQw7pW
         te1stHeFqpIN1++G1tiIOjlrJz8BzpgzSTmkJ1wDnfjh49SqRvuYYncwUVer0w5x7PdI
         nUc2UhnQ+rySiRvceVj+AJq3/usZHpr7ZkesU9gOmVWtUV+HZC/gCMbakHj9yX3x4JFa
         Yd4+Y22M4KUSaxSxACTg19SZ/dkbwGO4fD4V+pHa/2uu/Qfq8zbrosUOL7j3HCtw9RDg
         N1t+NyV1dcW7KxCqnYja0/A39sgwsgxAdYqVtVJiavbmyFSl1HjQ1Yw/bBQQwb3BxZc6
         MlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419176; x=1748023976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYIJm2q9Yp2zD8GIKkON4+609O1mUpe2xgodUE4VVIU=;
        b=WKiMkeg8gIXN7orIUVOFDMPeLPjfzOQmbbUeRSRyAdeq619Cww5tUedwdm4L7/ryJ2
         JKxkhjgW1cMFTjsC4COIrRiO9KmmIZDJr+HuwLiWvGrw6UoqA4YMcJ7vMjWSOtzkUPM1
         cKS6V+hMyWaZdsQ8zlUSfDz/Ci8XCCMxlbp3abCHttTigKBo0WQHqhwgITtnZABsL4z2
         VL3puxA1W5TUzUFPznHzxRU1Uyvs01KIyTG+r201gTc1D0omJrF0KZluhCRicOGIYWoE
         8CrX7eSHEipf5T2yAnkbUbehB3gfgzzbAz4nnq7kFwMijCLZq2eJJt5kFvQKVfhCtECU
         RIEw==
X-Gm-Message-State: AOJu0YylCrj987llRBZEvwHXHxWo5aZTwZ7kSeMNLhgf8+oXnhUAIyYb
	8NULT67tLnw1bNKzeH7IUJv+i5VtiF5HxZE2/0aO0v1zkvmSDenJyZZFT0r2vcfn/OOzxjJd0iV
	z8HKs9vRb
X-Gm-Gg: ASbGncsqNvGmTZKMDq80gzvN+wUZfc8wl7bdQC7T8oHMbVK6uVQ+lkr5DxDl9vU8aZU
	tYCX6wU2DbotQvKQ+AItYzcCUM1ERiyf1AxlWK2TlyIxtAZJLfBNmqlXCJVN5+xZrD8EfTfZ9Hh
	kSSFdV9igNDB+OQ5vu5LLeFw24z6Vq545xWe3GRb9U+KSgqL7YvwDOfBfmvTPO5b5oTL+xAtBdx
	LXBMqgL+72pVyP7OVtfhnSAC19SYcV8F81WJDdXgrj7s/pB2qCEqm3LhNKLVfmgHjRZhTxTKeQT
	6aiC8/sEMC1TL7vTDqigndwc7QqVw25S22V8AL/9MGlzmf2h
X-Google-Smtp-Source: AGHT+IGLs9Yxa/HtzfSxaS0ZXKFtCdu8QpDi4fSUheyEHOD1vLb5A+llEUFpdJm4DL6TQ59VkzWDkw==
X-Received: by 2002:a17:902:dacd:b0:231:c851:9453 with SMTP id d9443c01a7336-231ffdc5ademr155175ad.24.1747419176222;
        Fri, 16 May 2025 11:12:56 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8ff7:6c9:7fc9:b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebac32sm17259405ad.170.2025.05.16.11.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:55 -0700 (PDT)
Date: Fri, 16 May 2025 11:12:50 -0700
From: Emily Shaffer <nasamuffin@google.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Docs: Add cmd_psuh with repo and UNUSED removal
Message-ID: <aCeAIqwvEVOdrsMg@google.com>
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <20250416061450.25695-4-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416061450.25695-4-jayatheerthkulkarni2005@gmail.com>

On Wed, Apr 16, 2025 at 11:44:49AM +0530, K Jayatheerth wrote:
> 
> This commit improves the `cmd_psuh` documentation example by:
> 
> Correcting the function signature to include struct repository *repo.
> Makes the signature accurate and consistent with typical Git built-in
> commands.
> 
> Removing the `UNUSED` macros from the `cmd_psuh` function arguments
> (argc, argv, prefix, repo). This is done because the example now
> uses these arguments.
> 
> Showing how to access the repository's Git directory (repo->gitdir)
> within the cmd_psuh function. This provides a practical example of
> how to use the repo argument and repository-related information.
> 
> Keeps your existing printf() calls in place.
> This lets the users see the arguments which is given to the function.
> 
> This enhanced example provides a more complete illustration of
> Adding a Git built-in command and use the repository argument.

As I said for the prior patch, please revise the commit message; we
don't need the line by line description of what you're doing in the diff
below as we can read the diff :)

The important part is pointing out that the codebase has moved on to
require UNUSED and passing around a repository object, and that it's
interesting for newbies to see what's inside of `repo` in this learning
exercise.

> 
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index b463d42f63..ed6dcc1fc6 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -158,7 +158,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
>  in order to keep the declarations alphabetically sorted:
>  
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix);
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
>  ----
>  
>  Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
> @@ -174,7 +174,8 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
>  should also do so when writing your user-facing commands in the future.
>  
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix)
> +int cmd_psuh(int argc UNUSED, const char **argv UNUSED, 
> +			const char *prefix UNUSED, struct repository *repo UNUSED)
>  {
>  	printf(_("Pony saying hello goes here.\n"));
>  	return 0;
> @@ -287,10 +288,14 @@ on the reference implementation linked at the top of this document.
>  It's probably useful to do at least something besides printing out a string.
>  Let's start by having a look at everything we get.
>  
> -Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
> +Modify your `cmd_psuh` implementation to dump the args you're passed
> +and removing the UNUSED macro from them, keeping

"Modify ... and removing" mixes up tenses. Better to say,

Modify your `cmd_psuh` implementation to dump the args you're passed,
keeping existing `printf()` calls in place; because the args are now
used, remove the `UNUSED` macro from them:

>  existing `printf()` calls in place:
>  
>  ----
> +int cmd_psuh(int argc, const char **argv, 
> +			const char *prefix, struct repository *repo)
> +{
>  	int i;
>  
>  	...
> @@ -305,6 +310,14 @@ existing `printf()` calls in place:
>  	printf(_("Your current working directory:\n<top-level>%s%s\n"),
>  	       prefix ? "/" : "", prefix ? prefix : "");
>  
> +	if (repo && repo->gitdir) {
> +        printf(_("Git directory: %s\n"), repo->gitdir);
> +    } else {
> +        printf(_("No Git directory found.\n"));
> +    }

Your whitespace is wonky here, Git uses tabs, not spaces. Double check
it, please :)

> +
> +	...
> +}
>  ----
>  
>  Build and try it. As you may expect, there's pretty much just whatever we give
> -- 
> 2.49.GIT
> 
> 
