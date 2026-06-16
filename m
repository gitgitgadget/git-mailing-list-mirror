Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545E37188A
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615324; cv=none; b=IQiFhA5lo16Olj2CBQ2SbjtFPDwGvMjE1emxgXIV4qCuouMTFjTxOBOLHQlAQala3O53Ac8E4C9xRcsVbp8vRtS/obrvVURcULU6OHOMTXKIheEOr4bw667rzTM4FRbeHPsRRdYYwaoMV9cs6sipe4YE0WKjXry09WPRnGOgjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615324; c=relaxed/simple;
	bh=+b30QoxSbKtODoa6oD8PxEDdwy6IbRKOF6OrlSYSt8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQ32kXKVQSXoiCGC6XIQ9FPgF4OvtjdOlsAcDGllE1tk7F9TNDm/TWgBeP/hwwX3MUo9bUiJdRBtB0ayu6fKUnKddBgFENwsaQfmK6XDoaT7rVN0hH4DrGgAXfhGleEJLnQB/+nMZ9SELSdi3Bma93VpmLrjHPFbiOHCcaFw62g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptjUQDcD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptjUQDcD"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bebde89cfd3so561273166b.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781615319; x=1782220119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FeBaxAxKaTZwjZuWAEaky2i05uuslR2Pw76tdrYIRqE=;
        b=ptjUQDcDO7362+VoqtXHJ6n+OHiiKJL7KPqMzO+7hyoL3543WVxlSUyEmZRodfJwHd
         05+y0Uam5KxiNgNWLXXy7hfb7ZgNvjebbn6faTdTn3vGylrebCLPr7xm/ppUB+Nrr1lh
         ASumGL2rx1dgfGxXmrvOXVW7JZpX0kDYBLHm12x7QkThEg3MdG6CPupfNDMkYrjT9m12
         XKs/x2nbJYtKwgAXZOA8pixG/txaJx9boL1CcvSV8QO0kUYBVSgm97FkCn7uYZybfbli
         Dq27tpZ7gGV6JpefDPXQKN37BlFS3u/MP/L8wUgFhRMDecnBS+/MRlRCN+eiV1LSZdmb
         oRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615319; x=1782220119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeBaxAxKaTZwjZuWAEaky2i05uuslR2Pw76tdrYIRqE=;
        b=lewG6Grlno1UPOcz/w5YFFGKLDERXyeg4pUmieYWZWAGp+k0MCh9dpW3jyl/Ohmfsn
         ZeXOkR0OnPYV0ffG/btQQRzVlb0tRwBIOHsa/WXEpdrKe/a3TLxg33ipvfa0QxDhHwFW
         jAwfvfUgEWsAuQ3rFxW2892ARXW3RUH6uPp+bK/taRbgGm39tsjOJXAR6BhfOMjLknLx
         5F3/jy4ZzA+alFOnj2i51VZ6thafOt9h6eGaXc4HWgXV/pwPCElqcGSRZTIem6q6rxHj
         JInxF4iIlEfBziNPiebMCv2EO00NEOL+RkyyzdUXWIP/yAOI1Q5eDZg7SJI1eUWsMsZN
         E6Fw==
X-Forwarded-Encrypted: i=1; AFNElJ+KvDl9YnSiETWlMSnYV99wpt6ZZX7C6yLoGq3e9EfYEWb0HvldLspMSBKx06vPy/ivRXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0hCn1cEAtua5so33aZethGoKPYV+deWE9hECHQp9B8o63mFi
	xML++lYP85q6KA3e61QKlNprvfgG8ufVGM9sw/XiLt0xJlzS20Ybmi9l
X-Gm-Gg: Acq92OFISlO3SL3JEb6BWRQjEZ4ae9q0IdwqZ7EVDYZmO8i19AYnZD6ZjUdqme540OK
	pjWc5ObBImDlcxbdmPsL0Pkj1vJJtSoPU7ZQSzLs69W6Hvuia7rMC5KuDd+tTov+iPJGKAEWOf6
	hRn6xwbXzi0HuXWhEN8MOoZS2WaFJ4pHox9TA5fkhCyRO7vKbOIsnkY1xnbW6PMnI9/f7UcBFTJ
	BK0MaU3wOfiPS5AZ4k0Ws14TXGq/0R6iRzX+KyJLCyy85IxB7BdGpsIZt3hvHZaZyjaAfR+q3eu
	qggXEh89mesanoqbFvsHUJBwOURURRPLMcbJJPjU5O2emuNJRhnCjVJirLzfQQK8K6sQhAapz4u
	2FZFTAkunV/LS8ogfbMJLsY+3hzknAjdhoPm0ie1PzGDubjJDMw1zOm2KWsct548laurNhiaSBt
	JTIjPPqo+B1+NrNzfYGiCSASH3xUy++70WM7cL+AqFvY7nk06aMBaU2erPz2K0lgBc6eaBrawfH
	BHotMCiOS4=
X-Received: by 2002:a17:907:3f11:b0:bed:a213:a89b with SMTP id a640c23a62f3a-c043d7b4ff6mr190636866b.37.1781615318814;
        Tue, 16 Jun 2026 06:08:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6? ([2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb83428a8sm656473466b.44.2026.06.16.06.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 06:08:37 -0700 (PDT)
Message-ID: <0077b1ae-3c85-4b34-a0ac-766395157c4f@gmail.com>
Date: Tue, 16 Jun 2026 14:08:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC Patch v5 2/4] rev-parse: use append_formatted_path() for
 path formatting
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, lucasseikioshiro@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com, a3205153416@gmail.com
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-3-jayatheerthkulkarni2005@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260616044953.184806-3-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/06/2026 05:49, K Jayatheerth wrote:
> -static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
> +static void print_path(const char *path, const char *prefix,
> +		       enum path_format arg_path_format, enum path_format def_format)
>   {
> -	char *cwd = NULL;
> -	/*
> -	 * We don't ever produce a relative path if prefix is NULL, so set the
> -	 * prefix to the current directory so that we can produce a relative
> -	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
> -	 * we want an absolute path unless the two share a common prefix, so don't
> -	 * set it in that case, since doing so causes a relative path to always
> -	 * be produced if possible.
> -	 */
> -	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
> -		prefix = cwd = xgetcwd();
> -	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
> -		puts(path);
> -	} else if (format == FORMAT_RELATIVE ||
> -		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
> -		/*
> -		 * In order for relative_path to work as expected, we need to
> -		 * make sure that both paths are absolute paths.  If we don't,
> -		 * we can end up with an unexpected absolute path that the user
> -		 * didn't want.
> -		 */
> -		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
> -		if (!is_absolute_path(path)) {
> -			strbuf_realpath_forgiving(&realbuf, path,  1);
> -			path = realbuf.buf;
> -		}
> -		if (!is_absolute_path(prefix)) {
> -			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
> -			prefix = prefixbuf.buf;
> -		}
> -		puts(relative_path(path, prefix, &buf));
> -		strbuf_release(&buf);
> -		strbuf_release(&realbuf);
> -		strbuf_release(&prefixbuf);
> -	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
> -		struct strbuf buf = STRBUF_INIT;
> -		puts(relative_path(path, prefix, &buf));
> -		strbuf_release(&buf);
> -	} else {
> -		struct strbuf buf = STRBUF_INIT;
> -		strbuf_realpath_forgiving(&buf, path, 1);
> -		puts(buf.buf);
> -		strbuf_release(&buf);
> -	}
> -	free(cwd);
> +	struct strbuf sb = STRBUF_INIT;
> +	/* If the user didn't explicitly specify a format, fallback to the path-specific default. */
> +	enum path_format fmt = (arg_path_format != PATH_FORMAT_DEFAULT) ? arg_path_format : def_format;
> +
> +	append_formatted_path(&sb, path, prefix, fmt);
> +	puts(sb.buf);
> +
> +	strbuf_release(&sb);
>   }
>   
>   int cmd_rev_parse(int argc,
> @@ -717,7 +661,7 @@ int cmd_rev_parse(int argc,
>   	const char *name = NULL;
>   	struct strbuf buf = STRBUF_INIT;
>   	int seen_end_of_options = 0;
> -	enum format_type format = FORMAT_DEFAULT;
> +	enum path_format arg_path_format = PATH_FORMAT_DEFAULT;

This is the source of the api wart I referred to in the previous patch. 
Could we keep the existing enums and convert them into the appropriate 
PATH_FORMAT_* flag in print_path() above? I think we already have the 
logic to do that in the existing code. That would mean that other users 
of append_formatted_path() don't have to worry about the extra flag.

Thanks

Phillip

>   
>   	show_usage_if_asked(argc, argv, builtin_rev_parse_usage);
>   
> @@ -797,8 +741,8 @@ int cmd_rev_parse(int argc,
>   					die(_("--git-path requires an argument"));
>   				print_path(repo_git_path_replace(the_repository, &buf,
>   								 "%s", argv[i + 1]), prefix,
> -						format,
> -						DEFAULT_RELATIVE_IF_SHARED);
> +						arg_path_format,
> +						PATH_FORMAT_RELATIVE_IF_SHARED);
>   				i++;
>   				continue;
>   			}
> @@ -820,9 +764,9 @@ int cmd_rev_parse(int argc,
>   				if (!arg)
>   					die(_("--path-format requires an argument"));
>   				if (!strcmp(arg, "absolute")) {
> -					format = FORMAT_CANONICAL;
> +					arg_path_format = PATH_FORMAT_CANONICAL;
>   				} else if (!strcmp(arg, "relative")) {
> -					format = FORMAT_RELATIVE;
> +					arg_path_format = PATH_FORMAT_RELATIVE;
>   				} else {
>   					die(_("unknown argument to --path-format: %s"), arg);
>   				}
> @@ -985,7 +929,7 @@ int cmd_rev_parse(int argc,
>   			if (!strcmp(arg, "--show-toplevel")) {
>   				const char *work_tree = repo_get_work_tree(the_repository);
>   				if (work_tree)
> -					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
> +					print_path(work_tree, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
>   				else
>   					die(_("this operation must be run in a work tree"));
>   				continue;
> @@ -993,7 +937,7 @@ int cmd_rev_parse(int argc,
>   			if (!strcmp(arg, "--show-superproject-working-tree")) {
>   				struct strbuf superproject = STRBUF_INIT;
>   				if (get_superproject_working_tree(&superproject))
> -					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
> +					print_path(superproject.buf, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
>   				strbuf_release(&superproject);
>   				continue;
>   			}
> @@ -1028,18 +972,18 @@ int cmd_rev_parse(int argc,
>   				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
>   				char *cwd;
>   				int len;
> -				enum format_type wanted = format;
> +				enum path_format wanted = arg_path_format;
>   				if (arg[2] == 'g') {	/* --git-dir */
>   					if (gitdir) {
> -						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
> +						print_path(gitdir, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
>   						continue;
>   					}
>   					if (!prefix) {
> -						print_path(".git", prefix, format, DEFAULT_UNMODIFIED);
> +						print_path(".git", prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
>   						continue;
>   					}
>   				} else {		/* --absolute-git-dir */
> -					wanted = FORMAT_CANONICAL;
> +					wanted = PATH_FORMAT_CANONICAL;
>   					if (!gitdir && !prefix)
>   						gitdir = ".git";
>   					if (gitdir) {
> @@ -1055,11 +999,11 @@ int cmd_rev_parse(int argc,
>   				strbuf_reset(&buf);
>   				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] != '/' ? "/" : "");
>   				free(cwd);
> -				print_path(buf.buf, prefix, wanted, DEFAULT_CANONICAL);
> +				print_path(buf.buf, prefix, wanted, PATH_FORMAT_CANONICAL);
>   				continue;
>   			}
>   			if (!strcmp(arg, "--git-common-dir")) {
> -				print_path(repo_get_common_dir(the_repository), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
> +				print_path(repo_get_common_dir(the_repository), prefix, arg_path_format, PATH_FORMAT_RELATIVE_IF_SHARED);
>   				continue;
>   			}
>   			if (!strcmp(arg, "--is-inside-git-dir")) {
> @@ -1089,7 +1033,7 @@ int cmd_rev_parse(int argc,
>   				if (the_repository->index->split_index) {
>   					const struct object_id *oid = &the_repository->index->split_index->base_oid;
>   					const char *path = repo_git_path_replace(the_repository, &buf, "sharedindex.%s", oid_to_hex(oid));
> -					print_path(path, prefix, format, DEFAULT_RELATIVE);
> +					print_path(path, prefix, arg_path_format, PATH_FORMAT_RELATIVE);
>   				}
>   				continue;
>   			}

