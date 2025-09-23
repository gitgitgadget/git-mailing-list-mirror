Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2E1E491B
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642932; cv=none; b=k6tb9m9jWO4rKqFev+bbVPzcZ4fBrFAjCZ65mhpicBxQSv0GkSwKkvaTU10+zzntbVLScelaGCyWseCmU29OnsffsNeTT0/SkC2SSHnhcXOpFW0GQzKjWxLVh4rJiyR/nAMO/WyDuMHziWygyLpjetuMJ4j6DPgGUKmWEyAAbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642932; c=relaxed/simple;
	bh=bepru5C8EHnOr5ZBxn6S40PptXfazMQPyAuf/SiQiiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3gNUMDU7rxAPTG7jWuiydBf8FFgr8MuX60BEx+OKR+D09byKYmhdO9GxmNoSa7sg47Of1YdFZxtc/lCMlODA39W7njurjaWYedvcWlUJIjMCLaJubggJ3k1ugCD5y9aRaSMzje0fUYyaqHLVeh0iPNLyv9ydgJBENZhJJJt0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea7sZ9Cr; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea7sZ9Cr"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-34207c1bdaeso1000576fac.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758642929; x=1759247729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OnARXywXNB3x+lmTzBQhnMw696Sz6+80VbSDl/7fpw=;
        b=ea7sZ9CrpGXwo8bjHWHNvNXyTDO2pnFi1YyDzNU2TN3OngBtW1Yea9TXaUIe6HlI32
         9eNPqYPnZ7s/gpjJ/6CJkHEiW+j1zZq6PKwFSqwBpj1x+8w90k5hYRP+Khmo5s6MLp4t
         EEGeUWd+2DWx5HzHCjBmquAip39D6J0h1lAkqgtiHr6VqYfjHWPD1V26nyumGcEpxcDJ
         ES6EeG8ngtaMjPQU1kGylNe31ssQejhLQcqizs+yEiClx/26Fko4H2rcUjXukLGHRdfw
         UUKSAlAvBcgt5DFmp9gisMLgcfBlt/LUAMjrwRmrL8PFbVqyQq1O8iTbfZZlkCtWcz81
         JIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642929; x=1759247729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OnARXywXNB3x+lmTzBQhnMw696Sz6+80VbSDl/7fpw=;
        b=n+dp/mFe4NdfQrlTQ2sqrdrGoQT4XfTY+wIvCC9x+a6TbIU8GwtM/Ucxs1Jd+hRw5I
         2VDSEXcbyGSGHUpZ+d0uVqZ5bnjxqVWBAeM14R4xsbmgDKdyHYS7QhdLeN8MRUgkel1v
         RPXfoGRVhc9w4ivw6Sjd0WsARyrAJiz624UXsVz0Dxe1C2+BJEG5r8UZn3GmjNlxFdO9
         Pu8dEt02C/pfxgzJ86NlsAKRPcGc2keMYsgNFo3kyqKM94p4dSqyOHd+ziPOmpeBX7mr
         NpCIEcdfyBRXLVZD/VnbcJNXrLlm0I6LB52EeqezrN0+P1KnD4zFiFbKr31kUcjwB7VA
         yqiw==
X-Gm-Message-State: AOJu0Yxdtw1J5eeqA9HRD8n+361UGvFdwnT7hnGaoN2JEKWnsM68QTMz
	CSxrNc1OXF3gMKnbpdH2DstYjJNrTIbnUgtj2aClny7iBOEaTuLQhU3fwfiZpQ==
X-Gm-Gg: ASbGnctP/NwZPKJeGaCEMjumyYDjdd1bkmbsoqx3INQH7T+S42G2ZosXNgf7BNYunEd
	CR1B2SZeW/usJVhqbLfWWOMNuCKt0LmEkP5Ea+5vriiGfwFJGcXh0G1AGjw/X3sToKJhH8SuRn6
	VZ8hpelySqBK+7nx96GqO6UPBcKKXT3ndj7FfRAYC2F8jVK5xAGNHthhhzhRyWJ4GQOxnrQbksc
	5+TQ5sycFjl8zDx9/BCIlVGGdCPb4gm88mN8Zr+cpkp+SM5HYn8GJPDgznxw5qtyYde6rGqLMUh
	cL9L/Gu7CAEFnEYt1vT2B2cnk8gYFGqA42+7BOyoB5G8hLeh5ou12V0AYsn5WuwAZ1EvcbRUFHo
	AmE/rLFbWMa1Nv5Vu
X-Google-Smtp-Source: AGHT+IGFRrN7IGW33pPVtqmkTOCf/cYM8YC+/H98u3VsXLQJStjwP1mdICEXTV7fii7L63Xxyq8+eQ==
X-Received: by 2002:a05:687c:3397:20b0:351:7530:5c54 with SMTP id 586e51a60fabf-351756d85ecmr771706fac.20.1758642928826;
        Tue, 23 Sep 2025 08:55:28 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-336e637e66csm9691157fac.31.2025.09.23.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:55:28 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:55:27 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] builtin/repo: introduce stats subcommand
Message-ID: <k6szjxs2rcthy3kj7h5rgzkmeezldjdkuewcqfu3yhuxcbnkw5@a32ezi6ytqgm>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-2-jltobler@gmail.com>
 <CAOLa=ZQHU8m-BLzD=uWx6e-FVcs-aDmrUp9qrU72_5E=CNQRNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQHU8m-BLzD=uWx6e-FVcs-aDmrUp9qrU72_5E=CNQRNg@mail.gmail.com>

On 25/09/23 11:22AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> [snip]
> 
> > diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> > index 209afd1b61..7762329551 100644
> > --- a/Documentation/git-repo.adoc
> > +++ b/Documentation/git-repo.adoc
> > @@ -9,6 +9,7 @@ SYNOPSIS
> >  --------
> >  [synopsis]
> >  git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
> > +git repo stats
> >
> >  DESCRIPTION
> >  -----------
> > @@ -43,6 +44,12 @@ supported:
> >  +
> >  `-z` is an alias for `--format=nul`.
> >
> > +stats::
> > +	Retrieve stats about the current repository. All references in the
> > +	repository are categorized and counted accordingly.
> > ++
> 
> Nit: Should we use bullet points for the information provided? As of
> this commit it is only references, but with time, this will grow, so
> would be nice to have a set of bullet points to understand the different
> information retrieved.

Ya, it was also suggested else where to do the same. Will update.

> > +The table output format may change and is not intended for machine parsing.
> > +
> >  INFO KEYS
> >  ---------
> >  In order to obtain a set of values from `git repo info`, you should provide
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index bbb0966f2d..15899dd74c 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -4,12 +4,15 @@
> >  #include "environment.h"
> >  #include "parse-options.h"
> >  #include "quote.h"
> > +#include "ref-filter.h"
> >  #include "refs.h"
> >  #include "strbuf.h"
> > +#include "string-list.h"
> >  #include "shallow.h"
> >
> >  static const char *const repo_usage[] = {
> >  	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
> > +	"git repo stats",
> >  	NULL
> >  };
> >
> > @@ -156,12 +159,160 @@ static int repo_info(int argc, const char **argv, const char *prefix,
> >  	return print_fields(argc, argv, repo, format);
> >  }
> >
> > +struct stats {
> > +	size_t branches;
> > +	size_t remotes;
> > +	size_t tags;
> > +	size_t others;
> 
> Maybe we can use a nested structure here, which would reflect the output
> table. That would be much nicer, as the code would grow, currently we
> know 'others' here refers to references, but with other fields coming
> in, this would no longer be obvious.

Will do.

> > +};
> > +
> > +struct stats_table {
> > +	struct string_list rows;
> > +
> > +	int name_col_width;
> > +	int value_col_width;
> 
> Can these be negative?

No, but the only usage of these values is in the format string used to
print each row and it requires an int. I'm not sure it makes sense to
cast in this situation.

> > +};
> > +
> 
> Nit: Could we add a comment about what this structure is and what it
> holds? I think it is sort of obvious, but would be nice to clarify.

Adding a comment doesn't hurt. Will do.

[snip]
> > +static int repo_stats(int argc UNUSED, const char **argv UNUSED,
> > +		      const char *prefix UNUSED, struct repository *repo UNUSED)
> > +{
> > +	struct ref_filter filter = REF_FILTER_INIT;
> > +	struct strvec ref_patterns = STRVEC_INIT;
> > +	struct stats_table table = { 0 };
> > +	struct ref_array refs = { 0 };
> > +	struct stats stats = { 0 };
> > +
> > +	filter.name_patterns = ref_patterns.v;
> > +	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);
> > +
> 
> I was wondering why we need the filter mechanism here, but seems like
> this is to obtain the type of the reference. This is setup automatically
> by the filter mechanism and so it's okay.
> 
> We could replicate the same using the ref iterator code. This would be a
> little more involved, but would remove the need to store all refs in a
> 'ref_array' and also the need to loop over references twice. But it
> doesn't really matter in this usecase I assume.

In a future series, I would like to add options that restrict the set of
references used when evaluating the repository. For this reason, I think
it makes sense to stick with filter_refs() here.

> > +	stats_count_references(&stats, &refs);
> > +
> > +	stats_table_setup(&table, &stats);
> > +	stats_table_print(&table);
> > +
> > +	string_list_clear(&table.rows, 1);
> > +	strvec_clear(&ref_patterns);
> 
> Huh. So `ref_patterns` is simply a dummy variable, I was wondering why
> we simply can't set `filter.name_patterns = NULL`. I see that it is
> because in `filter_pattern_match()` we do `if
> (!*filter->name_patterns)`. This is not a great interface for
> ref-filter. Perhaps we could add a precursor commit like:
> 
> diff --git a/ref-filter.c b/ref-filter.c
> index 520d2539c9..20284b5918 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2664,7 +2664,7 @@ static int match_name_as_path(const char
> **pattern, const char *refname,
>  /* Return 1 if the refname matches one of the patterns, otherwise 0. */
>  static int filter_pattern_match(struct ref_filter *filter, const char *refname)
>  {
> -	if (!*filter->name_patterns)
> +	if (!filter->name_patterns || !*filter->name_patterns)
>  		return 1; /* No pattern always matches */
>  	if (filter->match_as_path)
>  		return match_name_as_path(filter->name_patterns, refname,
> diff --git a/ref-filter.h b/ref-filter.h
> index f22ca94b49..44d9b481ad 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -109,6 +109,7 @@ struct ref_format {
>  #define REF_FILTER_INIT { \
>  	.points_at = OID_ARRAY_INIT, \
>  	.exclude = STRVEC_INIT, \
> +	.name_pattern = NULL, \
>  }
>  #define REF_FORMAT_INIT {             \
>  	.use_color = -1,              \

Ya, I actually already have this exact patch locally. :)

I considered sending it as part of this series, but opted to just use
the dummy vairable instead. It probably makes sense though to improve
the ref-filter interface though. I'll do so in the next version. 

Thanks for the review,
-Justin
