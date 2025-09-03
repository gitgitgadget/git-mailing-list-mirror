Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9378928EA56
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918261; cv=none; b=ORKbalZY6/sWEAGoSAGMRlCFDOV1RJfS9+s3R0PMHyJJX+xsX9auuNF91Zu3K4yE9ILBffaPhtDe+scn8FayRWRRB1/d+/2nueBglw8EJfEfbwFqZrVDtVKxxL/u6BxRI7vjNU5xyxnct4rvYhlMU/79pA3TTGgbJmIb5HrrSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918261; c=relaxed/simple;
	bh=mqwiuX1m6P6goG50uhxMzWhLiKvCovdqtrTMDqLzd6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkIFkH/euPgGra9hUrR4zVBSbFu+MwhTn3jLAmdzXogzebqCdpXUF0E9uW+sZk/ggoXm7Kr2DeVjN7BCRxiLdQLzCfsYw8OUj3+TNsBtuEmCvHgZwv3gQH7sdcrcJ0VFMEuad6goEJnFhx3zltuB5LrqayR5KCzRIKAPOGvMXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRHcXyzQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRHcXyzQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24cb39fbd90so1511155ad.3
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756918260; x=1757523060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb8t6CnSxBC7dY/p54NIYACXZn6KsYrK8qa/3zOmX6o=;
        b=hRHcXyzQmQJkmJyzIYWZCZDRhJP8M56EszV7ar1xPl57xb0xYv+mkqNm6JmN7DNnN6
         mAhkSlvV2ICpXCdy8n3cDhB/d9Jd5aZHBqox7tHb8H7/47JwVE5NHrKRS8Eigh9JcrC9
         InW084CljUR3v55j7mfFHAzB0SI15bWJUuC05A9cAEXLLJCvVoGmA3LoMFetvCINySD4
         36m8rRN2VAQQwFCEK+rcQyipCfymUxZGEvPvFHMzu9UAX9w3IAfK20oCHsyZjEkE0KA9
         /lhTo1rXPOIY5KFd+fnc7SoELyWPPD2dRazVkd5ZD0AZpWGHeQFO4Es64AZxdMQJ+aUX
         nkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918260; x=1757523060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb8t6CnSxBC7dY/p54NIYACXZn6KsYrK8qa/3zOmX6o=;
        b=WyCMVkiwKRUD0CCFt+5e8ek1Y53n0zmVf/Kj6xdYE7G/b5ICtgJrK3hdk9fhzrn0yM
         DQLR4qXkpIPoiei0rxg9YOxnLaYJE8FlzngSKG1Z1UcXgBvdV55VAmOCjbstblXNJuRo
         35e7swO1sSLP2jb2H18PmAvN8dNGN0i4H1iZg9ZtEASSHfjyvpcijv4jqn4/Y+VZfV1C
         Us6Q/9vRowmgSgIiLiErVu+vb/Vt4SupZg1Yk9ByYtjI5KK0/ff8K6KO/HvRzkCoJJpJ
         emqXHXTOum9X2YNjLREf7St3cUDx2bCDcHcREl1gYgtyJLwMtIdYzZ59L+u0rwpzjhU/
         frig==
X-Forwarded-Encrypted: i=1; AJvYcCXYZCHrh3pi165GI/9W08cYSzUzF4UG30WnsdcmFLPL8NTuaOwhoj7OwVXaEMwbJ4/crOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNfKpHE5pIXmL2zgvpjd7MdramZ97aevcEYr0+3Cx7Zg/RZL7
	wTEXVe+4xmXCFvXIzxx7RCBM/VDHaBveazPr9jV8fkd0Q/mDkAdBL7I+ZnjKXw==
X-Gm-Gg: ASbGnctXFPRS0WdEMAN+7vohuSXaJOl2A31FVP66nwdvUx2caiz+RjY7ZYf/LWSpnWE
	aMTXi7a0jd5AwUlWPssDoOteKR8ZQGl2u3Y/ZwpD9GePgS5n54qLWceWAiGIEYLmxvHam24FQcU
	2AH1MGny9wVDc5D12bZMWqjgc0NFEEMxDU1hzGq9mxNGzZU3XyY0GlmE1ABdYzTN6v6rzGiDNBm
	CBL4DXaOosUTpZN4IrFb509LzV15Qp/98PCH96nsCFrTSYF7CRcotzi4KixX/5FgNJlLfYMvczu
	oZnfddTmBbhf/lrhpRenLxrkyVDBFgpjoBTpcVOk3YbsXHYdMX+Jf/NBRYIzhhWY2lOLJ1aSYLP
	nFecFlT2w9kUZEARFeg==
X-Google-Smtp-Source: AGHT+IHqH38WN2PtOJ/Wteq9SAp15YBnbyA4cxcck+2i/UnfugSnt/hlKrjavZmI8jaevN4JFHsJXQ==
X-Received: by 2002:a17:903:2c06:b0:248:aa0d:bb25 with SMTP id d9443c01a7336-24944a2393bmr196436565ad.14.1756918259555;
        Wed, 03 Sep 2025 09:50:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24b14e1b097sm53858095ad.21.2025.09.03.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:50:58 -0700 (PDT)
Date: Thu, 4 Sep 2025 00:51:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	jltobler@gmail.com
Subject: Re: [PATCH v2 2/5] refs/reftable: add fsck check for checking the
 table name
Message-ID: <aLhx-HdIMCB3c2WK@ArchLinux>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
 <20250902-228-reftable-introduce-consistency-checks-v2-2-4f96b3834779@gmail.com>
 <aLf3MaKHZSQfnBlT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLf3MaKHZSQfnBlT@pks.im>

On Wed, Sep 03, 2025 at 10:07:13AM +0200, Patrick Steinhardt wrote:

[snip]

> > +static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
> >  			    struct worktree *wt UNUSED)
> >  {
> > -	return 0;
> > +	struct reftable_ref_store *refs;
> > +	struct strmap_entry *entry;
> > +	struct hashmap_iter iter;
> > +	int ret = 0;
> > +
> > +	refs = reftable_be_downcast(ref_store, REF_STORE_READ, "fsck");
> > +
> > +	if (o->verbose)
> > +		fprintf_ln(stderr, _("Checking references consistency"));
> 
> This line is duplicate across both backends, right? Maybe it's something
> that we can do in the generic logic?
> 

That's right, it is duplicate. If we want to remove this, we need to do
this in the "builtin/refs.c". But I wonder whether we should do this in
the first place. Should we rather add more detailed information just
like the following code for packed backend?

    if (o->verbose)
        fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);

Instead of just using

    Checking references consistency

Could we use

    Checking reftable references consistency

However, I also feel strange about above, :)

[snip]

> > +/* Represents an individual error encountered during the FSCK checks. */
> > +struct reftable_fsck_info {
> > +	enum reftable_fsck_error error;
> > +	const char *msg;
> > +	const char *path;
> > +};
> 
> I wonder whether it should be the reftable library that decides on the
> severity of each generated finding.
> 

That's an interesting question. Let's inspect how Git handles the
severity. When defining the fsck message id, we need to specify its
severity like the following shows, this happens at compile time:

    FUNC(BAD_REFERENT_NAME, ERROR)

And we could set the configuration "fsck.[message id]=" to change the
fsck message severity.

Then let's think if reftable library decides the severity. It means that
we need to use the API from reftable library to update
"fsck_option->msg_type" at the runtime. And it is bad because the fsck
infrastructure would be highly coupled with the reftable library.

So, I don't think it's a good idea for reftable library to choose the
severity. Instead, reftable library should just provide users with error
types and let the users decide the severity.

Thanks,
Jialuo
