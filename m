Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68637E
	for <git@vger.kernel.org>; Wed,  1 May 2024 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590601; cv=none; b=t8RJVxlG7BNqp7hT993DX2uPSaHKFiWq9ZlOQGbJlkCS5apr9VMwJK6M7IoeNO64XtmFC4PTQqcPHmsl7GxkQ/oqYBtpMPwyuZUEHL0NldkN2swYVU1Zps64EVtHG3k+Va4F1q5ep5Rwnhkt1r9BhoDTsW5pe759F5yir+0DoM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590601; c=relaxed/simple;
	bh=M0W5fyTIGA0vXRnV+QJFVOFbhQldplP9SeJuTJEjQJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2zzGt4X0t29BAw40VB1Pl4kQ0UPTQ9CYWg/uJupD/z60l5awasHJR3Nwipklo8fzv15TplTmkMHom1PMCbvtMKnP59keftROVqeMS1vyZyKWbwDQlqBHehofyAl9S/K573gyTvMD8s+NGOPrBJkQVeNUWo+sDNS1UBvM8rtG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdaqgTB/; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdaqgTB/"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c74ff209f6so4549224b6e.0
        for <git@vger.kernel.org>; Wed, 01 May 2024 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714590599; x=1715195399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1hzKYZt+PW+0ofG479GZfauaXQ8YhlW47x2o4Lw+/o=;
        b=VdaqgTB/e0UK6srElUWvQAX0p0r/pNYwPsimAF+wDhYjsMXnJLXhVwgjwk7gwOL0fi
         X7YnHa0PUSAgOayX8r5lLw/z3oJzyGv3Y0sJJmu2WIsS/xi0q5HtfpgFrw2pUyUwrRxu
         MfmBbMdXj+C+HUyso81cPxqc5V1CncR1OKBgHDfmiAGwmG9YT/ru9OHbqz/L6yhKCIEj
         15aMPFirFBtsDR8TYu3fjrrTI4VrHhaEZIySv9jot6/jsjCWffcF5ukKY03A0s48q5TU
         ha3AE0ZekxzX0OUDXHVIuUU/jC7yylgajUD/sx1ru/rPlJKRakAPSw6iHh66haPwjyRk
         2a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714590599; x=1715195399;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1hzKYZt+PW+0ofG479GZfauaXQ8YhlW47x2o4Lw+/o=;
        b=CkwloURdg3j3+f1d++PMIOeHCr3ME0dn+JUbqRzQGTsTGMxrjymQTRsAPlvjwCDhNV
         HbaLB+xhnQXWqCFTSH8DsZe7WYocgdgYo7zmtdxiL82VzPaI5og50tqkyVigO1Ng2AHB
         r2ht/0fP3ux/8T95NUG5E9s/TT4rO6ttjIbiOTtl9gxpl0uN0pdWxBgIzjpPSpmXb1NL
         NBFOMYalCW4OAzUsKoS/S+aPRt2b78z7bXcxkVJDaQvlnjQ8OlYQ3aYk61syIP9YeTa6
         tWu6D4T5PtoDmwI+oZDnqJGre0w8fiUz1pCEnYGQo0GXULbbXl7gxXIo6DcArZZPWGUF
         LqoA==
X-Gm-Message-State: AOJu0YyDOVXQQ1fSA5rjGvq0Sa8Cfc0PhOue/j90juuMZn805dMp9Bco
	26a6rJOtT9Wvfbia9PbgBn+wWj+RUEg4esKkFikXN5gu9DlSz0WS
X-Google-Smtp-Source: AGHT+IHhE3eld3iRDvlC4+6fZYb7w8R1/k5+XS6BwU69upaDKQ6hFR4ni3ic2PhKQXhTrD6LFOsOlA==
X-Received: by 2002:a05:6808:3949:b0:3c8:45e1:fef0 with SMTP id en9-20020a056808394900b003c845e1fef0mr3456396oib.22.1714590599208;
        Wed, 01 May 2024 12:09:59 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id k3-20020a544403000000b003c86d4e9911sm782133oiw.7.2024.05.01.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:09:58 -0700 (PDT)
Date: Wed, 1 May 2024 14:08:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Toru Okugawa <castor.4bit@gmail.com>
Subject: Re: [PATCH] rev-parse: document how --is-* options work outside a
 repository
Message-ID: <zpttzdifoac5rcr2mzm353gdhuk52rqvtnldnxylnnzkplz2wp@fc6yrw74vatv>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>, Toru Okugawa <castor.4bit@gmail.com>
References: <xmqqplu54fbg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplu54fbg.fsf@gitster.g>

On 24/05/01 10:22AM, Junio C Hamano wrote:
> When "git rev-parse" is run with the "--is-inside-work-tree" option
> and friends outside a Git repository, the command exits with a
> non-zero status and says "fatal: not a repository".  While it is not
> wrong per-se, in the sense that it is useless to learn if we are
> inside or outside a working tree in the first place when we are not
> even in a repository , it could be argued that they should emit

s/repository ,/repository,/

> "false" and exit with status 0, as they cannot possibly be "true".
> 
> As the current behaviour has been with us for a decade or more
> since it was introduced in Git 1.5.3 timeframe, it is too late to
> change it.
> 
> And arguably, the current behaviour is easier to use if you want to
> distinguish among three states, i.e.,
> 
>  (1) the cwd is not controlled by Git at all
>  (2) the cwd is inside a working tree
>  (3) the cwd is not inside a working tree (e.g., .git/hooks/)
> 
> with a single invocation of the command by doing
> 
>     if inout=$(git rev-parse --is-inside-work-tree)
>     then
>         case "$inout" in
>         true)   : in a working tree ;;
>         false)  : not in a working tree ;;
>         esac
>     else
>         : not in a repository
>     fi
> 
> So, let's document clearly that the command will die() when run
> outside a repository in general, unless in some special cases like
> when the command is in the --parseopt mode.
> 
> While at it, update the introductory text that makes it sound as if
> the primary operating mode is the only operating mode of the
> command, which was written long before we added "--parseopt" and
> "--sq-quote" modes.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  This time with a properly formatted, proposed log message.
> 
>  * Doc update.
> 
>  Documentation/git-rev-parse.txt | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index f9d5a35fa0..04fe7b941c 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -18,8 +18,15 @@ Many Git porcelainish commands take a mixture of flags
>  (i.e. parameters that begin with a dash '-') and parameters
>  meant for the underlying 'git rev-list' command they use internally
>  and flags and parameters for the other commands they use
> -downstream of 'git rev-list'.  This command is used to
> -distinguish between them.
> +downstream of 'git rev-list'.  The primary purpose of this command
> +is to allow calling programs to distinguish between them.  There are
> +a few other operation modes that have noting to do with the above

s/noting/nothing/

> +"help parse command line options".
> +
> +Unless otherwise specified, most of the options and operation modes
> +require you to run this command inside a git repository or a working
> +tree that is under control of a git repository, and will give you a

s/control/the control/

> +fatal error otherwise.

Thanks for the clarification. Noticed a couple small grammar/spelling
issues but otherwise looks good :)

-Justin
