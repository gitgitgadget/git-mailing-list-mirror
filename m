Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259062641EE
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641210; cv=none; b=NlibF0F9SU8wbpSb+H18oLtZyoOxMhdK1WbVAT8xWhYdu5+kUbWI9yC7uuqmUgQTzJrCqWXJr3dYvRaLuPZ+QpwX/JGDXmWNnncId/AdNJcNS/S+ZLKYR8yrIXZHR+YLRye4UIQFv5CmiRoVBh+SwBJYiUa21fWO1M9chiHZ5nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641210; c=relaxed/simple;
	bh=A/HXZNS6zvwVU4VRRu7VGUYAOOWKSvTVOpZEH67Bq88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbAmT4VpSHd3zjm9qInc/9hMY37KNzSGEnRQndZ93jH3CM8fnpCnWbui8G29ldJljRdDcs8DMNjZmdL46BbzvYb8jyUKyaQjuXMiwDDfF69v57WwGqrslCdePBRkCzWpcBhbjcVAzS7RUx77w03psqg9DqWScMbX95Neos1uZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8hXz73z; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8hXz73z"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-62ea23446f4so567555eaf.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758641208; x=1759246008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tq8JAiNTQUEHy1lN91vUkcAbq5cD4Ku8psiR+bZB530=;
        b=E8hXz73zrYZWneNRz+yxOftBXif2kDdPQEaDvRqwBjZos5DF0IbpiNWEw+uNpW6WDQ
         YZHM3maHknjbViRwZQv7Q+kTQ+UcNSGOiYkjQiZLviOuJZna+fvG3wWH2vIAz6UPKg1X
         L3tNG5iVwE/DL0LO9DGMGshIgADs176zt8QDro/Pdeb6MUqCQCUO83OEIVX0mPyWqt9J
         X8JEgQUhqjKjaXDBAW4LecKgr3uyuYRpaXHEtSYtQQsKNRGzfWr4FXxi8LgvymDsQ1oY
         o6XecFTr0febbhHXpB7Aw2avRNtbVHgzx/j4jNxsOa/LMVM51oBokCuxKDPTA5DgaQeG
         tnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641208; x=1759246008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq8JAiNTQUEHy1lN91vUkcAbq5cD4Ku8psiR+bZB530=;
        b=eP8FJc2CyFCTfyI+EsSjwOcDBKlGrCgPuiEWIIgPTBT2Earus0GGA1JlkzaZuRaMXA
         Y3f4WD6jkJL/t86SDel1Axzpqs3oK4jjON3gTcIHWBaxGUiRg4hWU9nylzu+ECNMOZrI
         oIGGUu8s3Z1iGMWG3iJEZEjhROG/Gde8dRRwqG56woqj27EH6poDGSoAzsfYtstOycQS
         RoKAItjoFSdrTWDw/IRP7Q+0fCOqUo4Iym+cE28q1iNUVEI9QtnvdlTm4z8Zif7NYIGp
         82JTn52gOmWjIe/AUTjPcKan2k7MvbzIncp0ZSB4oB5CXOdigM7vCA47D51Q0ivN4C5c
         4yDQ==
X-Gm-Message-State: AOJu0YxQodcRPeNxqu3NsH84azdKVY2EZgOTxzLuCjYB6m1+4nvfF+U8
	ra4k0ybrGDpT7pLIPalZgl3vBjpr/A/fftr0QZPVPFTIVTeBy27mWkvl1udgkg==
X-Gm-Gg: ASbGncsQkOFT8usSLVdELE9e4HOoxrhfuaN1euAdgp5c+2NjGdHbTQWa+ZFSEiD1sHD
	Dpx3U3gtG7qGkmiXD3aLPcHlJJdYeomwlX6RRvGYplEmJ261VAbhjx6DKecJKEdFXZ2/2qsXrv+
	boYlLfqZiiDZOuqzfdzjQklcElDpU33AzNazIyjW/JGS0rUistJ81JOpNyuQkIRy0c4M/4RS0hD
	ff9bhESANQtaOsyIEE7A133qudDFQL3yTqRtWvj9D2qkmPiEct//LxA/ZPUo12YgSD2L3Yg5VBc
	FgWmWQguci4b7bh+3YsQF5ajdKp84AA92Pq2dfKkDPx+6bs9NqDgoeSUPvqOI2F6/aFMU0aw7mC
	X4SDoODN9geyfr8YW
X-Google-Smtp-Source: AGHT+IHRPiwq19NLjfs4zUTOHRqmg+BONbShENRKKG0H6brInGWC7iQkNFKKqMFITyJPmK8bVUTztg==
X-Received: by 2002:a05:6808:4f14:b0:43f:2ab7:345a with SMTP id 5614622812f47-43f2d402902mr1605072b6e.37.1758641207882;
        Tue, 23 Sep 2025 08:26:47 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43d5c67bbdcsm5932005b6e.7.2025.09.23.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:26:47 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:26:46 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 3/4] builtin/repo: add keyvalue format for stats
Message-ID: <5kwuxyttcnhe57hej3xfmaunbjmpu7og52ft2bb4uawjqq4lvb@s3zub5742v4e>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-4-jltobler@gmail.com>
 <aNJ8DIPI0v6Jhn5C@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJ8DIPI0v6Jhn5C@pks.im>

On 25/09/23 12:53PM, Patrick Steinhardt wrote:
> On Mon, Sep 22, 2025 at 09:56:59PM -0500, Justin Tobler wrote:
> > @@ -157,6 +160,8 @@ static int repo_info(int argc, const char **argv, const char *prefix,
> >  	};
> >  
> >  	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> > +	if (format == FORMAT_TABLE)
> > +		die(_("table format not supported"));
> 
> We can deduplicate this error message by saying "format '%s' not
> supported".
> 
> Other than that, let's fail closed and say `if (format !=
> FORMAT_KEYVALUE && format != FORMAT_NUL)`. Like this, we won't have to
> update the condition every time a new format is added, which is easy to
> forget.

That's fair. Will update.

> > @@ -286,6 +291,32 @@ static void stats_table_print(struct stats_table *table)
> >  	strbuf_release(&buf);
> >  }
> >  
> > +static void stats_print(struct stats *stats)
> 
> I think it would make sense to call this `stats_keyvalue_print()` to
> clearly distinguish it from `stats_table_print()`.

I adapt this same function in the next version to also print the NUL
format which is why I kept it generic. The NUL format is really still
just a key-format just with different delimiters. I'll change this in
the next version.

[snip]
> > @@ -376,8 +418,17 @@ static int repo_stats(int argc UNUSED, const char **argv UNUSED,
> >  	stats_count_references(&stats.refs, &refs);
> >  	stats_count_objects(&stats.objects, &refs, &revs);
> >  
> > -	stats_table_setup(&table, &stats);
> > -	stats_table_print(&table);
> > +	switch (format) {
> > +	case FORMAT_TABLE:
> > +		stats_table_setup(&table, &stats);
> > +		stats_table_print(&table);
> > +		break;
> > +	case FORMAT_KEYVALUE:
> > +		stats_print(&stats);
> > +		break;
> > +	default:
> > +		BUG("not a valid output format: %d", format);
> 
> Nit: it may be valid, but definitely not supported.

At this point, the only other valid option was handled above. This would
leave only invalid options. I think in the next version I'm just going
to combine patches 3 and 4 though to avoid this issue altogether though.

-Justin
