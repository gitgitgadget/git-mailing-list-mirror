Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA626137F
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535495; cv=none; b=lQ2fDk72lEegRgk1xnW2snaWkS8vWY373hqKmzm766LnTLtZsZKGO9pxwC0HoQ49vGXN5vC+K76qJ++yZas9PVYKvqRMsv8UpSs7Zm4xmeV1k+LIhqfi96HdFratB1WKlytxY4F5zE1F4geyEAvtkOkYpVgG9KyYdbSclfCixk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535495; c=relaxed/simple;
	bh=iq57G/SNVLuzoDMzYPp4SpfT5MwhJLwcP0s60Wlp0uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MclsBdHkRJGI5+xzLdG9ey6tP0tjpFP1Rm89aIU4bQD3K6olZhDLE23ygATq5CYfvTHRWgs6Cti/ePTduPu9jLfs8TrW0MyIvVVMo07fwIXazgAw3+9e11R07FqL3EIGbZfPbZLYwxseGo4g0vIxrOkCPb1NFDp5/g6St4fVAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTpVdniy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTpVdniy"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f6ca9a3425so17517237b3.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739535493; x=1740140293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqYUsAYrt2RL4UEJrQ1vZ6pyQyW37rW1SS+svS/5yvo=;
        b=aTpVdniyYC99jYZqPN6lLlSReZVw+OCO0JNoXCSVSMDS7LkMspCTBEMRTMzz8HyzMZ
         RLezHG0FNa59woq4pYg+c1j1iqTy99x9BZRXEPxf0l/lmlYHF705C4Xzn5p/UZq0DJtd
         Xa8rQGpY4XOlPZwCq9bo0ELNWDUaUq1hHOc2hqpKF/lt5EPcdDfq0tUFBeoCBh2no1iz
         cfveIlCH28pSR3ONngQmFp11a5kIe5892+IhWs127pTXRzK/6zEYRrLD5eP6kkh9k4Z0
         VOiNzkjQoCLteCfMLDcn5nOFqWOldAiw3gxiz888C+2hUXQiUpNwnrc2eGCXN1sz0NXX
         cPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535493; x=1740140293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqYUsAYrt2RL4UEJrQ1vZ6pyQyW37rW1SS+svS/5yvo=;
        b=OOcYJny7HQainLfFBTSkX11ZhJ4PgAeCnijIySoAbiQ9Ym75VB5381ywj+MzlHeUsd
         5LVupMWbXCHiHg2kk9qWcUunjFNIgOxCSYOZleYOYBHLD/orfKOCU1IsDGsE7irue1dx
         wKY54L8QkBxiHTi3lBFo/6vSPvKV4Z5CuUAx+2V5O3MM3aRBx3seE45O1AUe+l6rtCFi
         qDpcvktgpWS0pls9dziDBIf9Nw4Fbl95eVOOyJJVS7Q5RmyPhsxDtdEAoN4pCqESjNcy
         B0FgMKsXUT5j1+m/fFuEnWTjVpJzK5wrufN3Ldoe8E/dANw5LVR0lSphQImYgSaVJ1KQ
         98lA==
X-Gm-Message-State: AOJu0YweEi5FlTb6nNo0Lz0t0QkaMq2EplSdhL0Rd2BEo4mVP0z2oIyJ
	1c04XJx/x7TYnydFGY74ynL5z3orXvz0bEDBiS77Pg0wVxT/GQHi
X-Gm-Gg: ASbGncs0/7YHTAzsPId+YHldv6xmfk9hEGRV7xpHj1mhhZznqZaupZzHXe/WKqoSnhx
	TxB7YFijUBJ8B388Ay2L1vTV2YPCz4q1DmY4CR6i+gYjHqa1yWJUALGVm+OwK0VQYjIlBw4aSR2
	G2ph5pivqnNJAOAaSrioWzcXmeMgWs01rkK5oLLAXf4qusBA12Lyw+cF8/8YN8j6BzN7HV/I2TO
	Hvn2uVIVKCLSWfvnZmT7wg/YgVaOuO0ze0EIem6hKu+a7C8hgDS0B62rLwdufE/BCBPjw==
X-Google-Smtp-Source: AGHT+IGciq0DLVpz9xoiPEdqpDfuAR55aLEYG61YS0tlExW5zbwRlWafIynsL8qFxtP0yqUrO5TwUQ==
X-Received: by 2002:a05:690c:6389:b0:6f9:a7d3:cec1 with SMTP id 00721157ae682-6fb1f5b885fmr109607127b3.9.1739535493153;
        Fri, 14 Feb 2025 04:18:13 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fb3619be11sm7284327b3.83.2025.02.14.04.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:18:12 -0800 (PST)
Date: Fri, 14 Feb 2025 20:20:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 2/8] builtin/refs: get worktrees without reading head
 information
Message-ID: <Z6809gl2Hk73zZJ1@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
 <Z67L_lmCd6NNXpWZ@ArchLinux>
 <CAOLa=ZS3w3KkEoQksXZtLYCT6BJVs6o2+nmpVUapbnqVA4zfng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS3w3KkEoQksXZtLYCT6BJVs6o2+nmpVUapbnqVA4zfng@mail.gmail.com>

On Fri, Feb 14, 2025 at 01:19:53AM -0800, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > In "packed-backend.c", there are some functions such as "create_snapshot"
> > and "next_record" which would check the correctness of the content of
> > the "packed-ref" file. When anything is bad, the program will die.
> >
> > It may seem that we have nothing relevant to above feature, because we
> > are going to read and parse the raw "packed-ref" file without creating
> > the snapshot and using the ref iterator to check the consistency.
> >
> > However, when using "get_worktrees" in "builtin/refs", we would parse
> > the "HEAD" information. If the referent of the "HEAD" is inside the
> > "packed-ref", we will call "create_snapshot" function to parse the
> > "packed-ref" to get the information. No matter whether the entry of
> > "HEAD" in "packed-ref" is correct, "create_snapshot" would call
> > "verify_buffer_safe" to check whether there is a newline in the last
> > line of the file. If not, the program will die.
> >
> 
> Nit: while the second paragraph above makes sense in the context of what
> we're trying to achieve in this patch series. It doesn't make much sense
> for this patch in isolation. Perhaps we want to give some more context
> around what we're trying to solve for in the upcoming patches and hence
> how it hinders that.
> 

Indeed, I think we should add this paragraph. We need to tell the
context about the motivation.

> > Although this behavior has no harm for the program, it will
> > short-circuit the program. When the users execute "git refs verify" or
> > "git fsck", we should avoid reading the head information, which may
> > execute the read operation in packed backend with stricter checks to die
> > the program. Instead, we should continue to check other parts of the
> > "packed-refs" file completely.
> >
> > Fortunately, in 465a22b338 (worktree: skip reading HEAD when repairing
> > worktrees, 2023-12-29), we have introduced a function
> > "get_worktrees_internal" which allows us to get worktrees without
> > reading head information.
> >
> > Create a new exposed function "get_worktrees_without_reading_head", then
> > replace the "get_worktrees" in "builtin/refs" with the new created
> > function.
> >
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  builtin/refs.c | 2 +-
> >  worktree.c     | 5 +++++
> >  worktree.h     | 6 ++++++
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/refs.c b/builtin/refs.c
> > index a29f195834..55ff5dae11 100644
> > --- a/builtin/refs.c
> > +++ b/builtin/refs.c
> > @@ -88,7 +88,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
> >  	git_config(git_fsck_config, &fsck_refs_options);
> >  	prepare_repo_settings(the_repository);
> >
> > -	worktrees = get_worktrees();
> > +	worktrees = get_worktrees_without_reading_head();
> >  	for (size_t i = 0; worktrees[i]; i++)
> >  		ret |= refs_fsck(get_worktree_ref_store(worktrees[i]),
> >  				 &fsck_refs_options, worktrees[i]);
> > diff --git a/worktree.c b/worktree.c
> > index 248bbb39d4..89b7d86cef 100644
> > --- a/worktree.c
> > +++ b/worktree.c
> > @@ -175,6 +175,11 @@ struct worktree **get_worktrees(void)
> >  	return get_worktrees_internal(0);
> >  }
> >
> > +struct worktree **get_worktrees_without_reading_head(void)
> > +{
> > +	return get_worktrees_internal(1);
> > +}
> > +
> >  const char *get_worktree_git_dir(const struct worktree *wt)
> >  {
> >  	if (!wt)
> > diff --git a/worktree.h b/worktree.h
> > index 38145df80f..1ba4a161a0 100644
> > --- a/worktree.h
> > +++ b/worktree.h
> > @@ -30,6 +30,12 @@ struct worktree {
> >   */
> >  struct worktree **get_worktrees(void);
> >
> > +/*
> > + * Like `get_worktrees`, but does not read HEAD. This is useful when checking
> > + * the consistency, as reading HEAD may not be necessary.
> 
> Checking what consistency? We should be a bit more verbose here. You can
> mention that skipping HEAD allows to get the worktree without worrying
> about failures pertaining to parsing the HEAD ref.
> 

Good idea, I will improve this in the next version.

> > + */
> > +struct worktree **get_worktrees_without_reading_head(void);
> > +
> >  /*
> >   * Returns 1 if linked worktrees exist, 0 otherwise.
> >   */
> > --
> > 2.48.1


