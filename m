Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5215E1FE
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095237; cv=none; b=NI4iThM/W5zyvYIVEhXRGkrSm+bzxUQrR8AnFqKsmGeJcFH03ii7i9Qmr+mAy+pR+lrI17SRlhs5gq15T72klnP4xVj2tDGgwkf7ZYOi9bAvq4oydsGg5Xa2h5IwC96TBtNtXfhfbMl1s/Rlwa9F8pXkMlFSKzqxptrPeAEVn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095237; c=relaxed/simple;
	bh=Sob3gH9KWLkZdW2LDB1Ca1A2NfEHewO55Ym3mKRUBhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS0mMu/3RKm2hc1IFuZyxyVdaEbMx1nkSMudIBfC/n1p/jHHt97pr6yUqEYGy9YB02eo9XjiOzMIryZKwhc+YE+29YRhk0QtUYYAIOLL9+ScVNojNgZIx15SpZtTdjkY11PN19aDJsKKEDmYREhaAl6Hl/JTOp5tjp64ZyTIxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Veu+xYwS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Veu+xYwS"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so2602115b3a.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712095236; x=1712700036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dt/rhJilhQBeQdSTDymC5Q5FXal6uuQVXV2z1z2CpM=;
        b=Veu+xYwSKl3rY9Xo5Ah+cVUxz2j2YFMAm8Hk2uGTPCcqpaYaUOR3oKTaI309UZA6Xq
         Lh4+ROBD2Dkl2cM7UOZgBO99jtKl9NEV73p5RwIpNg8BqYCnf+FFMUXRR1hCnyIvjIRj
         W8ohtkwhhxl5AU3ifVjhPw4x1tdlO7DRWq5U2vLeF6fOqJWSiKDvv4dY+v1mMbcfhghu
         zBihKczOiwkW39n8cO+PU0g0N+sH1ffvvSzI5H6h1W5TohehmHXZoJne/OsabJGyROaN
         +AFksZKoNk3buAiR+cMesdARbsirtX3eRjoX5ppJicNpICnQrEXJM+uT1bhi2Jf5YE5X
         30/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712095236; x=1712700036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dt/rhJilhQBeQdSTDymC5Q5FXal6uuQVXV2z1z2CpM=;
        b=DslUI03Hnww2SyHcaVukdzHb7tGGD1CbpTfxVj8RsLN7Qo/RdIExenJImBXUljZux8
         DCDk1ed9CmAz5jV7Wd50I3d0LqGHc9SnBrvMk3bP6UvJlLxCNThqJJKK4y0rH/+1/S6t
         2o+VLW5c4gjCkp6hqfjFVIeGL/ajOsYfkDqaxgUCB2K6e1nJAM1yyobXnzhag+mFir8R
         nzqjNyZEKChig0vtkHke9qEZbEVZHr7jaaLlzxoFEFt+DQtPztNgqeBg07R/o0CHc93h
         PteyHMW9RAot4+JAXEBjzldjhw9T3TwG+HPZqlamDnB60IyJa9UZZ8dZW+PV4NHny7G8
         pEUA==
X-Gm-Message-State: AOJu0YxOgVjxhfFr5+wXJQQPImATBDtAa5htFO0vVUs9KKjzBZOCKOLy
	cdKfd7Pnn7x1pkh3hwzfLuGZ2nefQBVjwPZYO8ewK0eQItO/5HCYf/NKQa8G
X-Google-Smtp-Source: AGHT+IG/VOJfw3VrksbOhy+Qsc/BXL1Zq/fY0oIHrsciJHYon/tswkNwIywG29FqVCOpR2mS1uxdQw==
X-Received: by 2002:a05:6a20:4321:b0:1a3:c266:e7bd with SMTP id h33-20020a056a20432100b001a3c266e7bdmr1341117pzk.38.1712095235566;
        Tue, 02 Apr 2024 15:00:35 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id v16-20020a62a510000000b006ead6e28ee6sm10281912pfm.58.2024.04.02.15.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:00:35 -0700 (PDT)
Date: Wed, 3 Apr 2024 03:30:32 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] builtin/add: error out when passing untracked
 path with -u
Message-ID: <rrt3yuhd7sjhgqhra75w43dp2okrx5h4urqiyopxe4dmnwunnk@tifrkksvm3ak>
References: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
 <20240402213640.139682-7-shyamthakkar001@gmail.com>
 <xmqqh6gj305n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh6gj305n.fsf@gitster.g>

On Tue, 02 Apr 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
> > When passing untracked path with -u option, it silently succeeds.
> > There is no error message and the exit code is zero. This is
> > inconsistent with other instances of git commands where the expected
> > argument is a known path. In those other instances, we error out when
> > the path is not known.
> >
> > Fix this by passing a character array to add_files_to_cache() to
> > collect the pathspec matching information and report the error and
> > exit if a pathspec does not match any cache entry. Also add a testcase
> > to cover this scenario.
> >
> > Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> > ---
> >  builtin/add.c         | 11 ++++++++++-
> >  t/t2200-add-update.sh | 10 ++++++++++
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index dc4b42d0ad..88261b0f2b 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -370,6 +370,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >  	int add_new_files;
> >  	int require_pathspec;
> >  	char *seen = NULL;
> > +	char *ps_matched = NULL;
> >  	struct lock_file lock_file = LOCK_INIT;
> >  
> >  	git_config(add_config, NULL);
> > @@ -549,13 +550,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >  
> >  	begin_odb_transaction();
> >  
> > +	ps_matched = xcalloc(pathspec.nr, 1);
> >  	if (add_renormalize)
> >  		exit_status |= renormalize_tracked_files(&pathspec, flags);
> >  	else
> >  		exit_status |= add_files_to_cache(the_repository, prefix,
> > -						  &pathspec, NULL,
> > +						  &pathspec, ps_matched,
> >  						  include_sparse, flags);
> >  
> > +	if (take_worktree_changes && !add_renormalize &&
> > +	    report_path_error(ps_matched, &pathspec)) {
> > +		free(ps_matched);
> > +		exit(1);
> > +	}
> 
> Shouldn't we pay attention to ignore_add_errors?  The same comments
> about free'ing and exit code from the review on the previous step
> apply here, too.

Will update.

> Other than that, looking good.

Thanks.
