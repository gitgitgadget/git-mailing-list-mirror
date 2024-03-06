Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A11AAB9
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761628; cv=none; b=smecjZY7RgckQHNvP6xIxuoqCZKeLvEI/oQgPvDmAK2ETmdmQJVdhZZPYBdQ9xtsx18XPAE9pGDDpbMFh7xWdDofTOtkcaUZuSuNiq/8flkQ5iJno7bjB9cb5CyDChcg3p1m8YRZZZyR/F4At57JPQ0cL9DiXylmrrEPBg/bmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761628; c=relaxed/simple;
	bh=Lmmgewmppzg2DSB4toucI6F6iNXnHxxjG9lqHqpejXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk8Kal/J89Sa7crJruzFUjQBZ0Iv7BW64l4Paf9dv8pRYOS5OInlw0KqJjeKRfaQ80t9Kg9k49a2JQldCczxM9Hw0Bwj7yAAh5tTEfJlGhIc3nrAXlA94UojLl6WUzpe0Xl8AWc6KSp0n44fQkoqdf6XuovhnGl1rYA0mlosvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+Qdx1UO; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+Qdx1UO"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so149555a12.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 13:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709761626; x=1710366426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn1r3sKCj2wGTqRxKWFjaHz6vGiN0kDbK3eWF/T168U=;
        b=r+Qdx1UOROkYvw2TnN/NeieTX72wwoeJLcFDt+c+FarxanGw5KkIm0Rsh3APyROrdJ
         ZVi78qNRijUKQwwtP0l9ec76o40XV0bx67abItJsk7Kt99TXEpy9n5rXrK46L++SV14H
         K+19PwB8Y5SwFR8LjJkGQDK1Xi3LRm4/ZnQVLsoMXSHKyBQqWgNdkO3YK2n8TZSdsXuk
         ZVNddl/WN20B2qPnF+JAhHmAEWCdELGdjouIBM1xfetwQgk/kK1kxjFm1rFYExysieOn
         3jjaRUOgZFnEtPQhvM6Sle6KAzyhr4OSqp+6PH1yBBhqSncHV2+RHndgIpaculGHOSBd
         8bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709761626; x=1710366426;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qn1r3sKCj2wGTqRxKWFjaHz6vGiN0kDbK3eWF/T168U=;
        b=M9f7iUgkyO7lO8r+/iRBU5/SOY50+pmU+FqHb0s4YN2hvErl4fJDM84a0RmdcDEPc7
         yq2FJgx//TBaqXTYRmLLdK3+b073b2D5uKtS88//Atq8Yxkxb8jPw8u3RRtDf+NDUuOP
         53JtkZqeIBU13AEL1tRJPdyUv6nGiTsOK/EC6N3zqvRmrH76xjGzTlpMCbztitktQRNv
         cSffJ7PMKgzDE11f+wFe68r4RtmruBvpfn3ULiRZpkzWieZ+91JJMbIulZxwLX/3JZVu
         gVjeTeOsNx0OHxzoBIVWm7H7QXFJMfv4N3EOMRqHM/AAtN9xhkBxLFzKap/lqZUldL7A
         bx5A==
X-Gm-Message-State: AOJu0YyoitsWaxIYAhIJpQ6eVsZQp/dHmoDirxlHBs7sTCwXG6RVx5Ob
	s2twXdgfjGfOswiGWQ/LwCjIk62v9BoYd/3YjKZuv+qzsFt/7hJEZxV9pNZJ+A==
X-Google-Smtp-Source: AGHT+IFAmTD4MBX8+WaPIFU0WLmCvgE+sx4EVQS4eCI5C8ap3M/5ga0jnSA3O0phJhCDifSqlwMRNA==
X-Received: by 2002:a17:90a:8c0c:b0:29b:2d64:68e8 with SMTP id a12-20020a17090a8c0c00b0029b2d6468e8mr12370463pjo.6.1709761626167;
        Wed, 06 Mar 2024 13:47:06 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:aefa:12c6:f136:7bbe])
        by smtp.gmail.com with ESMTPSA id gb1-20020a17090b060100b0029aef43b860sm195121pjb.57.2024.03.06.13.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:47:05 -0800 (PST)
Date: Wed, 6 Mar 2024 13:47:00 -0800
From: Josh Steadmon <steadmon@google.com>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 4/4] trace2: remove unneeded calls to generate
 'def_param' set
Message-ID: <ZejkVOVQBZhLVfHW@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
 <e8528715ebf97c12622c2e73f914ab4228a0927c.1709566808.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8528715ebf97c12622c2e73f914ab4228a0927c.1709566808.git.gitgitgadget@gmail.com>

On 2024.03.04 15:40, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhostetler@github.com>
> 
> Now that "trace2_cmd_name()" implicitly calls "trace2_cmd_list_config()"
> and "trace2_cmd_list_env_vars()", we don't need to explicitly call them.
> 
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  git.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/git.c b/git.c
> index 7068a184b0a..a769d72ab8f 100644
> --- a/git.c
> +++ b/git.c
> @@ -373,8 +373,6 @@ static int handle_alias(int *argcp, const char ***argv)
>  			strvec_pushv(&child.args, (*argv) + 1);
>  
>  			trace2_cmd_alias(alias_command, child.args.v);
> -			trace2_cmd_list_config();
> -			trace2_cmd_list_env_vars();
>  			trace2_cmd_name("_run_shell_alias_");
>  
>  			ret = run_command(&child);
> @@ -411,8 +409,6 @@ static int handle_alias(int *argcp, const char ***argv)
>  		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);
>  
>  		trace2_cmd_alias(alias_command, new_argv);
> -		trace2_cmd_list_config();
> -		trace2_cmd_list_env_vars();
>  
>  		*argv = new_argv;
>  		*argcp += count - 1;
> @@ -462,8 +458,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  
>  	trace_argv_printf(argv, "trace: built-in: git");
>  	trace2_cmd_name(p->cmd);
> -	trace2_cmd_list_config();
> -	trace2_cmd_list_env_vars();
>  
>  	validate_cache_entries(the_repository->index);
>  	status = p->fn(argc, argv, prefix);
> -- 
> gitgitgadget
> 

I'd personally prefer to see this squashed into Patch 3, but I don't
feel too strongly about it. Either way, the series LGTM.

Reviewed-by: Josh Steadmon <steadmon@google.com>
