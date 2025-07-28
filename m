Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3F282EB
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722808; cv=none; b=ABeVntwx5hAhlQW+gBp4G7e+YIxTz6HQtKkk0c1g/IkzQFY2tQBTzdJgVLzHmYgs6cPis4qwTTGtGqqUJ7ZSGYTw2W8rnqqfFh0NJ9dcCSfcU4YZ00shanzI6Gm6SR10gFm240gBSPF1nagdp8X8X+1COYqDiZb37Fxc00cjFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722808; c=relaxed/simple;
	bh=km0/zUSmjynfIlCOQPFCB3toFb/lGnwiTfRpr6iY67U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8R2bJKp5DqeVo7+L2WCk4KY5Mqpz0jnkxDdsv9Ko+kjXlkd3mJJyXb7fTd4HIkGBdyHwbjqoHxhKotcjq+/9YQyZ9tKqyqXgJYLlA/PAS+eQWL1WiYHaZs99+Wo2BJXE7TgK3tJlHPxjQ9JaJC/LZpWauCHFDxo2e78PBK3RPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNt56PUw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNt56PUw"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so7485676a12.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753722805; x=1754327605; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tNsOL+x7yYEHXvcyMmy6VEYYfX0HHSTpN7vH0A0/7Ow=;
        b=eNt56PUwUav9Lvag3AP/e8MWxRx2AD1JSUs+bvZB5lkE3hG6v09rGg2skM6zm7m78m
         W91nLd3WAQn1C1atFJuhcvipms8HMNqIfZymU9xIfe46rY6Q2OgISxeVLP7WrMKdxXww
         7OsqR6Uj0j6xJnYiEpwCimiiwERMQttA5c4Tn7GNFWTk4Og3Xp6CHs0dcfXpysbGQgND
         5Afz7amiJIKP2rEWil7HyicNfedjoUMcrA6uE5GoUsIZ1Cva0wLZe2VhXRaGlyLHQRZZ
         wmR/rw8OBPIqbRVhSMKbugpry01w46h+F2ZXZdfcGtwSxF3gu1Cq+lCbt7B27J2F+5kD
         SdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753722805; x=1754327605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNsOL+x7yYEHXvcyMmy6VEYYfX0HHSTpN7vH0A0/7Ow=;
        b=FmT4NfBnN3n9/Xam75K7jo9oVonTigwRaO8Ip8ic9kLD/xWdPxxGlVUbaefGyvV+QD
         bAXSrisWtLRY6Xi9qzo0XaICFGIPhVbWMp4Ecj1XytepJw/oR9p+iBtkabQc5M1dv+wb
         lkbSVyU+pvN2dp/EP/bnMk+HP+PPNjGVZ4jXcLRh5uMt+dLC5cH4mHYu0x8tomfhZzrI
         8xGmNfXKn1yzTeNNXjJ1zFhh44XGJuWwNPxj+uJ+zAsjjbtBsoDcfbRx0zd4TdmHeGoI
         FFTUruv90c/MwsaV3oS95LAJ5ZNLCAnz1Kukdyh/tUsBTE+FtJPvTWA4XarGkeQJVSrq
         exmg==
X-Gm-Message-State: AOJu0YxGfC6qBUHM5enVq17ULrarubCjtKGMGwlfP4amnGxCK6f2pJXE
	N6Q3OVI4T4ynSvRQR+a3/NzgCKsFEdeh+mpxbPzPmEml8w8SSTZVU5ltfKVWAQ==
X-Gm-Gg: ASbGncvmpOWv4X0HO/CU8q7+eMjLDfMA100Xp5GBBwSoCNkw1RHGo2PDcPl/MDj9x6G
	rmQBiccX/nWHZTE+iaeBd1n/0EOH5rBP+5oLMiXJbVZCWpbUHsLE265oCbF8/KpPUdgubRAd0n7
	eW5umh3X6KV7Nr5JNy9JxnWxOXqwtbxNnmjGdYesBqK4DW3Ijv1ZsxcnWAxdFpA8iwztPi1B+eH
	oa6go0wCiaxWHMA9Kf3E5aM3aOnroRFTTTwYQFyQndFIXMbeAjANfbYbAnRQ1+zVGYkq5PQ9p6X
	sVmydWXJbXRt9MwV0VbQuSrce3Gnwmg1ncSfbbs4dVOvVY35zWinC7O4lxWe3OLiDQrtzhzRTJf
	2FlDPWrkzcz/Alhcyv5BsZnIFteMUunjrlZ823tiZdUbv5cEXYXGY6SE=
X-Google-Smtp-Source: AGHT+IGd5b9xDVESlvRQcbGgnkKvDow3jyjglvtLsrhNP1RJAdC4a3n3R4A6hOLEyicF6eA5l9leeg==
X-Received: by 2002:a17:907:d06:b0:ae0:cadc:e745 with SMTP id a640c23a62f3a-af619a05b58mr1278327266b.40.1753722804659;
        Mon, 28 Jul 2025 10:13:24 -0700 (PDT)
Received: from localhost (92-249-246-243.pool.digikabel.hu. [92.249.246.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a63aecsm450537866b.85.2025.07.28.10.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 10:13:24 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:13:23 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Nelson Benitez Leon via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Nelson Benitez Leon <nbenitezl@gmail.com>
Subject: Re: [PATCH] completion: new config var to use --sort in for-each-ref
Message-ID: <aIevs9Y9/0AlzzhP@szeder.dev>
References: <pull.1946.git.1753627773304.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1946.git.1753627773304.gitgitgadget@gmail.com>

On Sun, Jul 27, 2025 at 02:49:33PM +0000, Nelson Benitez Leon via GitGitGadget wrote:
> From: =?UTF-8?q?Nelson=20Ben=C3=ADtez=20Le=C3=B3n?= <nbenitezl@gmail.com>
> 
> Currently when completing refs, e.g. by doing "git checkout <TAB>", all
> refs are shown in alphabetical order, this is an implicit ordering and
> cannot be changed.
> 
> This commit will make the sort criteria to now be explicit, mandated by
> a new config var which will be used for the --sort=<val> of for-each-ref

But why would you want to use any other ordering?!

> This new config var will have a default value of alphabetical order,
> so Git's default behaviour remains unchanged.
> 
> Also add '-o nosort' to 'complete' to disable its default alphabetical
> ordering so our new explicit ordering prevails.
> 
> Signed-off-by: Nelson Benítez León <nbenitezl@gmail.com>
> ---
>     completion: new config var to use --sort in for-each-ref
>     
>     Hi, I'm submitting a patch for the Bash completion script, to be able to
>     change the default implicit alphabetical ordering used when returning
>     refs e.g. when doing "git checkout "
>     
>     I wanted the completed refs to be sorted by "recently worked on", I
>     achieve it by using committer date field in descending order i.e.
>     --sort="-committerdate" because that shows on top the branches that have
>     recently been worked on.

Ah, that's why :)
This would be a good addition to the log message, and perhaps a
sufficient justification for the proposed change.

> The completion script does not allow to set a
>     custom sort order, so we're stuck with the default alphabetical one, so
>     I'm sending a patch which adds a new config var where the user can set
>     their desired custom sort criteria.
>     
>     I've not added tests because I'm not familiar with the test machinery,
>     hopefully this is still useful.
>     
>     I'd also like to ask the Git audience about their preference for
>     changing the default sort value in a future patch:
>     
>      1. stay the same (alphabetical order)
>      2. change it to show recently worked on branches first (like me)
>     
>     I people agree 2. is more useful then we can change it in a follow-up
>     patch.
>     
>     Regards,
>     
>     PD. I previously sent this to the mailing list but resulted in a bad
>     formatted email because I use Gmail (and I don't want to activate 2FA
>     authentication just for this) so I'm sending this time through
>     GitGitGadget and incorporating some fixes from review comments I got,
>     like adapting commit message to 72 chars wide.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1946%2Fnbenitez%2Fbash_completion_explicit_sort-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1946/nbenitez/bash_completion_explicit_sort-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1946
> 
>  contrib/completion/git-completion.bash | 56 +++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e3d88b06721..59964a8056e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -80,12 +80,37 @@
>  #     When set, uses for-each-ref '--ignore-case' to find refs that match
>  #     case insensitively, even on systems with case sensitive file systems
>  #     (e.g., completing tag name "FOO" on "git checkout f<TAB>").
> +#
> +#   GIT_COMPLETION_REFS_SORT_BY_FIELDNAME
> +#
> +#     Fieldname string to use for --sort option of for-each-ref. If empty or
> +#     not defined it defaults to "refname" which is the same default git uses
> +#     when no --sort option is provided. Some example values:
> +#       '-committerdate' to descending sort by committer date
> +#       '-version:refname' to descending sort by refname interpreted as version
> +#       More info and examples: https://git-scm.com/docs/git-for-each-ref#_field_names

This approach allows only one sort key to be specified, although 'git
for-each-ref' supports more by accepting multiple --sort options.

>  case "$COMP_WORDBREAKS" in
>  *:*) : great ;;
>  *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
>  esac
>  
> +# Reads and validates GIT_COMPLETION_REFS_SORT_BY_FIELDNAME configuration var,
> +# returning the content of it when it's valid, or if not valid or is empty or
> +# not defined, then it returns the documented default i.e. 'refname'.
> +__git_get_sort_by_fieldname ()
> +{
> +	if [ -n "${GIT_COMPLETION_REFS_SORT_BY_FIELDNAME-}" ]; then
> +		# Validate by using a regex pattern which only allows a set
> +		# of characters that may appear in a --sort expression
> +        if [[ "$GIT_COMPLETION_REFS_SORT_BY_FIELDNAME" =~ ^[a-zA-Z0-9%:=*(),_\ -]+$ ]]; then
> +            echo "$GIT_COMPLETION_REFS_SORT_BY_FIELDNAME"
> +            return
> +        fi
> +	fi
> +	echo 'refname'

Printing the sort key to the function's stdout requires that it's
called in a command substitution.  Forking a subshell for a command
substitution is very expensive on Windows, therefore we should try to
avoid that in new helper functions, if possible.

Please consider returning the sort key in a particular variable that
is specified as local in the function's callers.  See __git_decode()
for an example.

> +}
> +
>  # Discovers the path to the git repository taking any '--git-dir=<path>' and
>  # '-C <path>' options into account and stores it in the $__git_repo_path
>  # variable.
> @@ -751,7 +776,9 @@ __git_heads ()
>  {
>  	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
>  
> -	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
> +	local sortby=$(__git_get_sort_by_fieldname)
> +
> +	__git for-each-ref --sort="$sortby" --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
>  			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>  			"refs/heads/$cur_*" "refs/heads/$cur_*/**"
>  }
> @@ -765,7 +792,9 @@ __git_remote_heads ()
>  {
>  	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
>  
> -	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
> +	local sortby=$(__git_get_sort_by_fieldname)
> +
> +	__git for-each-ref --sort="$sortby" --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
>  			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>  			"refs/remotes/$cur_*" "refs/remotes/$cur_*/**"
>  }
> @@ -776,7 +805,9 @@ __git_tags ()
>  {
>  	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
>  
> -	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
> +	local sortby=$(__git_get_sort_by_fieldname)
> +
> +	__git for-each-ref --sort="$sortby" --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
>  			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>  			"refs/tags/$cur_*" "refs/tags/$cur_*/**"
>  }
> @@ -818,7 +849,9 @@ __git_dwim_remote_heads ()
>  		}
>  	}
>  	'
> -	__git for-each-ref --format='%(refname)' refs/remotes/ |
> +	local sortby=$(__git_get_sort_by_fieldname)
> +
> +	__git for-each-ref --sort="$sortby" --format='%(refname)' refs/remotes/ |
>  		PFX="$pfx" SFX="$sfx" CUR_="$cur_" \
>  			IGNORE_CASE=${GIT_COMPLETION_IGNORE_CASE+1} \
>  			REMOTES="$(__git_remotes | sort -r)" awk "$awk_script" |
> @@ -847,6 +880,7 @@ __git_refs ()
>  	local match="${4-}"
>  	local umatch="${4-}"
>  	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
> +	local sortby=$(__git_get_sort_by_fieldname)
>  
>  	__git_find_repo_path
>  	dir="$__git_repo_path"
> @@ -905,7 +939,8 @@ __git_refs ()
>  				"refs/remotes/$match*" "refs/remotes/$match*/**")
>  			;;
>  		esac
> -		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
> +		__git_dir="$dir" __git for-each-ref --sort="$sortby" \
> +			--format="$fer_pfx%($format)$sfx" \
>  			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>  			"${refs[@]}"
>  		if [ -n "$track" ]; then
> @@ -929,7 +964,8 @@ __git_refs ()
>  			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
>  			esac
>  			local strip="$(__git_count_path_components "refs/remotes/$remote")"
> -			__git for-each-ref --format="$fer_pfx%(refname:strip=$strip)$sfx" \
> +			__git for-each-ref --sort="$sortby" \
> +				--format="$fer_pfx%(refname:strip=$strip)$sfx" \
>  				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>  				"refs/remotes/$remote/$match*" \
>  				"refs/remotes/$remote/$match*/**"
> @@ -2861,7 +2897,8 @@ __git_complete_config_variable_value ()
>  	remote.*.push)
>  		local remote="${varname#remote.}"
>  		remote="${remote%.push}"
> -		__gitcomp_nl "$(__git for-each-ref \
> +		local sortby=$(__git_get_sort_by_fieldname)
> +		__gitcomp_nl "$(__git for-each-ref --sort="$sortby" \
>  			--format='%(refname):%(refname)' refs/heads)" "" "$cur_"
>  		return
>  		;;
> @@ -3983,8 +4020,9 @@ ___git_complete ()
>  {
>  	local wrapper="__git_wrap${2}"
>  	eval "$wrapper () { __git_func_wrap $2 ; }"
> -	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
> -		|| complete -o default -o nospace -F $wrapper $1
> +	complete -o bashdefault -o default -o nospace -o nosort \
> +		-F $wrapper $1 2>/dev/null \
> +		|| complete -o default -o nospace -o nosort -F $wrapper $1

This is problematic, because it turns off sorting for all completion
invocations, but in many cases we do need Bash to do the sorting for
us:

  - Subcommands and --options still hard-coded in the completion
    script are usually listed in arbitrary order.
  - Subcommands and --options listed programmatically by the
    parse-options machinery are listed in the order they are specified
    in the C source files (which tends to be the order that makes most
    sense for the help output).
  - Some completion functions list possible completion words from
    multiple sources.

I'm afraid that any change that leaves these cases unsorted is
unacceptable.

>  }
>  
>  # Setup the completion for git commands
> 
> base-commit: e4ef0485fd78fcb05866ea78df35796b904e4a8e
> -- 
> gitgitgadget
> 
