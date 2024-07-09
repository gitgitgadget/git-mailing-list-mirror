Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2214F9C5
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720564275; cv=none; b=EhpWcVqDrw7BCH/PYQ+PxPZSAQVTSuIQOZuAuE6L1c9jhshqc3r8qO6IpzPT1g8J1eXE2RKi1riyFSqaAHOw+UtlRoi6JxtMWpO+32uSm+HhkIVyF7l7A1KHpoU83p37A8TLOMvO4iM636DMUJpUfPqdBlU1f39tSWrgB9jCTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720564275; c=relaxed/simple;
	bh=6cs0c8ZJqycGZNER7Fe+1+fL1MiDr/LFPIbz/gfRiAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHEpukyznqgq5EtM2I0aDZshtcW4DDjrZOFu6QRNMc48sI3Gnm3WsCIGcf+oBfelnb4LYdXbEdkemZWgGLrjhlpoAkZbMaguYDouN2Q0p8EjS6ewCj8TB5usio3LdAo3mZL1wN2AaRi6xf9wN/vY3Z3jEIEe/c2cbpoCag1gn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My31EYcn; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My31EYcn"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d91e390601so2573457b6e.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720564273; x=1721169073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffIE6qEbV16zY975HNlCvsAWK87z/fpVaK+y9PUGiXE=;
        b=My31EYcnBBmoy3PRYU7lWYTAMtJQvqCEyfplBIU6Y0t9xW3A2G14Vewj+zhrtaHb2b
         nLqRx33+2P1dcFCP/kv6G1aNAnIvoMzwxQ57J/p7oGgIfKmUZCAziWI0YPw+++wlaXZ9
         4VP9Aplp3pO4+Aj21cT8wxFmdN+svy4DmIpXPWuk+Zjpmx0PufT/WjE6edXhEcNE+GzN
         MtHjFVUAFPp1HDCF9awa7i+eKKVz/RtOSuvbhXz6fH7Of2J2FUcFq0ak3KV83egLyBGG
         LvJ6EgTzSXM46zWRvlBiLWrhMWzyycV/bKt/NXqiFZ9vBk0o1W3xu6gmZyQ+7paFUxzW
         hw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720564273; x=1721169073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffIE6qEbV16zY975HNlCvsAWK87z/fpVaK+y9PUGiXE=;
        b=Q+DjkQ0S0lFpLq2soHDgpvasVOtbffW2lvI1ANUkj5tSjYNpB9STkSazVr6E4xspKy
         5gdIAWSZYpsGlk79W2DYviYmuS4KsL0ghWsmx6XgNwMFFVwsCig8xXR/QkK5G2puLtD2
         XbE5SFbAKtyILmWXBWbyJbiyToPzzRYRPTmlV2p8xFSnyfBVop22O2MtZKZgC8tXTurk
         8XrHy/6EjOr7I656t4QfbKwDzY1to15TVfSXrc2fO39cXsf+kG45NRvOLecb2RqPyZUS
         nvrnUnF3hLsz/jrHor2P8prDIQ6Jx/M2Himqgw9kMM+RyufCZUHxDpJllBU4I6v6Je7w
         Fi5w==
X-Gm-Message-State: AOJu0YwiGiChA22nG2Uvy5hWlq4UCo5BJ7+JzEkjXsC0M7qoj1/30a6G
	ox+XfHi5N6msBD9cJFHODrAe8CMtKN7/4sdPDlbwIntI9Bwzkn1o
X-Google-Smtp-Source: AGHT+IEEVw1iTH38gIBgoUzHCe/pP+fYUa2owqAO1G316l7Xan0Hdd2NrsZXeekKXtGlR6rXTnTPUg==
X-Received: by 2002:a05:6808:211a:b0:3d9:34e7:cc8e with SMTP id 5614622812f47-3d93c055a88mr4298829b6e.15.1720564272888;
        Tue, 09 Jul 2024 15:31:12 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93ad24f69sm577963b6e.26.2024.07.09.15.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:31:12 -0700 (PDT)
Date: Tue, 9 Jul 2024 17:30:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v9 5/9] builtin/refs: add verify subcommand
Message-ID: <eekcci7aeucp2srdotwdghfitinp7s6quc545ktlaif7kpucah@3vpegal5lsdd>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
 <Zo0up3jKBHy-6GRh@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0up3jKBHy-6GRh@ArchLinux>

On 24/07/09 08:35PM, shejialuo wrote:
> Introduce a new subcommand "verify" in git-refs(1) to allow the user to
> check the reference database consistency.

The next patch in the series uses `git-refs verify` to when running
git-fsck(1). It might be worth mentioning here that this is also
intended as the entry point for fscking refs.

> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
[snip]
> @@ -58,15 +63,54 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
>  	return err;
>  }
>  
> +static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
> +{
> +	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
> +	const char * const verify_usage[] = {
> +		REFS_VERIFY_USAGE,
> +		NULL,
> +	};
> +	unsigned int verbose = 0, strict = 0;
> +	struct option options[] = {
> +		OPT__VERBOSE(&verbose, N_("be verbose")),
> +		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
> +		OPT_END(),
> +	};
> +	int ret = 0;

nit: Being that we always assign a value to `ret`, defaulting here to 
zero is redundant.

> +
> +	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
> +	if (argc)
> +		usage(_("too many arguments"));
> +
> +	if (verbose)
> +		fsck_refs_options.verbose_refs = 1;
> +	if (strict)
> +		fsck_refs_options.strict = 1;
> +
> +	git_config(git_fsck_config, &fsck_refs_options);
> +	prepare_repo_settings(the_repository);
> +
> +	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
> +
> +	/*
> +	 * Explicitly free the allocated array and "oid_skiplist"

s/oid_skiplist/skip_oids

I think we forgot to update this comment after the variable was renamed
in a previous patch version.

> +	 */
> +	free(fsck_refs_options.msg_type);
> +	oidset_clear(&fsck_refs_options.skip_oids);
> +	return ret;
> +}
> +
>  int cmd_refs(int argc, const char **argv, const char *prefix)
>  {
>  	const char * const refs_usage[] = {
>  		REFS_MIGRATE_USAGE,
> +		REFS_VERIFY_USAGE,
>  		NULL,
>  	};
>  	parse_opt_subcommand_fn *fn = NULL;
>  	struct option opts[] = {
>  		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
> +		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
>  		OPT_END(),
>  	};
>  
> -- 
> 2.45.2
> 
