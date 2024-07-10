Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340221E488
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614736; cv=none; b=R7WQYfdYoNM8zrSQR2h5TCUmyAijaAcFDwc1S2gFE/jJLHuZwVJ/dAB+NadSZAZQSGUHOFNxH6NDVlhhBfASfFGk6uH0HnuLyR8w7WsWxG8TSIDWNy11sArCYW0L6OuW9klO33XLJqua13u3tVXkBbu0ZSN4ibffAks1liVwPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614736; c=relaxed/simple;
	bh=BtcjR05hq3sb3vnXgBT3yBh3hdwBTOFUsPFGxLaHmJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U04ppcwO6JBm3uCYASPb52P3cgOEMUFWEXbuueMNM2HYguCN4lNazdagt191yhyEWDCxS03aGboRHYtnk6j2kJV9iNletGqnMlqGxRq9U84tJewrgNxhmUsg4OcoCaRRblGvwXL/sJLSKiLWriq+x0LfVbeztpbKcGa3Ie+uqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB41U9yz; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB41U9yz"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70448cae1e0so440212a34.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720614734; x=1721219534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVLiQ/jfq1LBbyuXEFvlzY7c+KZ5DFzdqgV/Co3mNVU=;
        b=FB41U9yzk6kn0BCdo5oVOJvV/gtTfLW//SxkCYE4Aee3pnvXYbJayJ63WI0CT7wPh2
         1nJrF0XGlboTibxKur343qjsHF6/MCSimVlbGu+BtBwmWFLGK7PLnoqcFKiG+avjMf4P
         MB2eLXxC/Mclm/ZdJn4wE8WtJ5qKLl8ezma2sXaINYoggiIF6tn7lD2E63hFIVSeEaz9
         jzQe73LhpxqueLXFoq4LeibgpDTFqQqz/PvwasrjmXyDu1oqIiqMWJ0xUJBlmCAVc6/K
         QQXZMnYJYiBRXT1j8UrJEW7hk3o1YFEjRvm3M3eseZBsa92mbB3GSDQdWA04OzwI5bS4
         CJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614734; x=1721219534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVLiQ/jfq1LBbyuXEFvlzY7c+KZ5DFzdqgV/Co3mNVU=;
        b=ipYpzpnzvW+VOKWwaq0HIBDL+respqCg3iUVfco6tJDeYCyg73+RYVRugHL4np9MGl
         BYMdQCJL5ByrJQaXXMLp2R9JptMABZQUpKCLr9tRlIKGzpmG04/IYEs/qLNjBiQGo/7i
         5Wy0lD1yQYEu1nDVe6UVOWPFG8SmjxNqXJayEx3DxJGMXnXjH4H9N0KW8XcuJvqNQTG+
         KDsu1Pnz4Y6kvmRSo83+ZBOIbh6tlvYeHWIR6Gsn3tTOAGimwxffcZoazzzlf6r1O9ZQ
         kkRXxCUPHKnDICFV0NcNN0DcD0V8SFOuvT6khn5pzsFHmwqpJBLtKEKHgYz22OPHFd73
         Nb0A==
X-Gm-Message-State: AOJu0Yzsi7TbEb3P4e/+jWCB4FAqpWdkP6EmGrHVirDb5fYK2gjzFS6Y
	rp5x+5ukZdCPBNfQNJjkKy2S+7thGxcrRhcb+lstkJ35uwRqW1JZIhYdGA==
X-Google-Smtp-Source: AGHT+IGYyVu0Usmf1+p0df5ENQAmMxiH23v90sLEWpOTvK5aHS1r5s21TYvb8RgvxumLxlwvuJp6/g==
X-Received: by 2002:a05:6870:c110:b0:24f:cabc:4f6b with SMTP id 586e51a60fabf-25eae764c84mr4315725fac.8.1720614734198;
        Wed, 10 Jul 2024 05:32:14 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439e74f2sm3649223b3a.205.2024.07.10.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:32:13 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:32:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v9 5/9] builtin/refs: add verify subcommand
Message-ID: <Zo5_TzJuc6VBdZar@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
 <Zo0up3jKBHy-6GRh@ArchLinux>
 <eekcci7aeucp2srdotwdghfitinp7s6quc545ktlaif7kpucah@3vpegal5lsdd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eekcci7aeucp2srdotwdghfitinp7s6quc545ktlaif7kpucah@3vpegal5lsdd>

On Tue, Jul 09, 2024 at 05:30:42PM -0500, Justin Tobler wrote:
> On 24/07/09 08:35PM, shejialuo wrote:
> > Introduce a new subcommand "verify" in git-refs(1) to allow the user to
> > check the reference database consistency.
> 
> The next patch in the series uses `git-refs verify` to when running
> git-fsck(1). It might be worth mentioning here that this is also
> intended as the entry point for fscking refs.
> 

Yes, I will improve the commit message, in the next patch.

> > 
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> [snip]
> > @@ -58,15 +63,54 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
> >  	return err;
> >  }
> >  
> > +static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
> > +{
> > +	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
> > +	const char * const verify_usage[] = {
> > +		REFS_VERIFY_USAGE,
> > +		NULL,
> > +	};
> > +	unsigned int verbose = 0, strict = 0;
> > +	struct option options[] = {
> > +		OPT__VERBOSE(&verbose, N_("be verbose")),
> > +		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
> > +		OPT_END(),
> > +	};
> > +	int ret = 0;
> 
> nit: Being that we always assign a value to `ret`, defaulting here to 
> zero is redundant.
> 

I agree.

> > +
> > +	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
> > +	if (argc)
> > +		usage(_("too many arguments"));
> > +
> > +	if (verbose)
> > +		fsck_refs_options.verbose_refs = 1;
> > +	if (strict)
> > +		fsck_refs_options.strict = 1;
> > +
> > +	git_config(git_fsck_config, &fsck_refs_options);
> > +	prepare_repo_settings(the_repository);
> > +
> > +	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
> > +
> > +	/*
> > +	 * Explicitly free the allocated array and "oid_skiplist"
> 
> s/oid_skiplist/skip_oids
> 
> I think we forgot to update this comment after the variable was renamed
> in a previous patch version.
> 

Yes, thanks for you remind. I have just forgotten here.

