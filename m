Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511F35A2B2
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608322; cv=none; b=qRZ0VdfIxxeKms7GlMXKtKIxUkWsBkTdzTYbanwiXbu9lCzZ090VADq7MLyZPKk2axI07kpZmDQSY3Vx6ox3o1D2AUaEP+MjAdcF/VbdRAjE6bzDcJWYWlTxQtwLfXh2BKdUbmnNDCXORPXyXHf5paPBzsibsfb6VAXHo+6PjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608322; c=relaxed/simple;
	bh=KsbjODXeC2/wjkbmowaa7qyhuFjO3HIB2saT2DxTkgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4cCiRxiO1itel+9JUdNqhJN/2MILM7MKgrb4NxIxpgpg9mLo3qofENU3awrRX4z8yW7TVil99ktMh/tne1mTUIwPXeMDjIPDNfikSXWxWPVJksiZJwM3sD9wNzzdgOgQBmhuT+m3XbUhXVJeltsSdE0P/ZX09AW0c/JKEi39Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCQq1l7F; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCQq1l7F"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6218b52be5cso263645eaf.0
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757608320; x=1758213120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcDBJDQy6Mbfp1rpG5J5/EOxYNfd+Jb4w/F077jx3hA=;
        b=dCQq1l7FzMlJ85eX2h1e73R4U7pgCH/r8FiAJ+dAj1R4NBcdFz5EYonUAwyG4mUpmf
         OertO2hbQ6vaLZXwIHS4f/cDr5u1SvotNLnRRSQh8Rq1HnGyDRABR/btCy1iHxNY8X++
         Go7Te0Liyw8U4a8PkFP0UCB3qezTyV00qwvNMKMV+dXQZkMoNB9zkxC49s6U69IJ+5TJ
         /bpoDUDNxN4aRjF5ydkcVsls4MxICm0NzMUOprgp0+BODQZ3hTDZGQKK/1A9qDqbHMa5
         o/WIGqLfeXueJosUSkTR91HVpmG8SGrTX5LU7CILiGoMV+6jLwqjKxuIx8kM8K2r5AoV
         KyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757608320; x=1758213120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcDBJDQy6Mbfp1rpG5J5/EOxYNfd+Jb4w/F077jx3hA=;
        b=d4/PBLPxdwXwT+mfV2C5QDG79PMSv73ggaL+ky96Lprw1TWH5pu87FtdfLmFHmjoff
         D3HdR/pYAK/2tC/FKABpQEeGJ7FB5Umo5skybtybuARjJXB7OKPyigX3vOUCwMdo8/Qg
         XBGtozb0GqdRaucMgG4fBzKyF9M+muprkaukn5oFncJdFZgwylPAFaLEOyY+aK2YAvEX
         LX7zVg3oD3QpH9WG5y3PKUtx55pq7iqEZBV4spsBB4yRT4TmxrfhspQwh1REkB7W6H2U
         bt4kgJVlqMVuu7jCxwVYy9rTVt//iLAZ/Zu7Gr5Y/MZvgzyQX/4IVnPB9XzGXj5doNCh
         6b0A==
X-Gm-Message-State: AOJu0YzBtQFLkKcftDt91hjXFJ3+fhE80vdL96x3hDkScLz+6/HCbeTf
	79MPzmzCu9cZCVeZx+9Sff0AsFJaoKBazBoJMi4ZpkiZHHC5805tk/DQ93FG5w==
X-Gm-Gg: ASbGncsWvnHf2sBRXkVAvg3ZSNaBCw+dxXkRarMhQganI9/AeL99SUvHgPQYR8Mve0h
	OyO7AYZsvtvNqD64T+V98Ntrf9Oc9b7v87jP0ygDUD4BFZYTkBxqzFfHrf3TOG+v7BUfc38ed8v
	tyds210PSaRrr/522UupkRNhzvotY2NseOOAT1ji0oX5BEC0WVShUHpiwNS4n3suDPlO8w33+nR
	4Q2chBhvohRw7k5ERGYO7H5bjkrxyfhYN/He38EgsYDwS+f9mEtRr5iEZmdVA8ApnKXGPAWUdYr
	4mIBjEjonkdxBUfyn8Oem0DaOCzcgNR8s0fRDVUqdv+58Qw+eL4lAa0hQRIysRHZudtgAOSnh68
	m+rmcAcXnAm4vugOOft3bmHNKk+4=
X-Google-Smtp-Source: AGHT+IG6Pz8pyzSqaQPa4wO8YCD5adlKopIHZFrLlm00+ZxSHItd0EofdSs65xOxNL3I7cVy39/5hQ==
X-Received: by 2002:a05:6820:810:b0:621:7129:8ce with SMTP id 006d021491bc7-621bec7cd4amr119820eaf.2.1757608319753;
        Thu, 11 Sep 2025 09:31:59 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-621b7d7412csm138169eaf.24.2025.09.11.09.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:31:58 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:31:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb: add transaction interface
Message-ID: <hav2bes4mf2ivxfbuh3qyznqjm4jm4uycu3kae42c7ijknw3fy@le6ejgco2bgv>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-7-jltobler@gmail.com>
 <aMJu9LOAEa1NWsF0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMJu9LOAEa1NWsF0@pks.im>

On 25/09/11 08:40AM, Patrick Steinhardt wrote:
> On Tue, Sep 09, 2025 at 02:11:34PM -0500, Justin Tobler wrote:
> > diff --git a/object-file.c b/object-file.c
> > index 91fddfc4984..aff6c6c6dbb 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1623,7 +1623,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
> >  		struct odb_transaction *transaction = NULL;
> >  
> >  		if (!the_repository->objects->transaction)
> > -			transaction = begin_odb_transaction(the_repository->objects);
> > +			transaction = odb_transaction_begin(the_repository->objects);
> >  
> >  		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
> >  						      oid, fd,
> 
> This function is a bit of an outlier, as it is weird that we call
> `odb_transaction_begin()` instead of the specific function.
> 
> But "object-file.c" currently contains two different parts: logic that
> is related to reading and writing objects in general, and logic that
> provides the actual object source implementation. This will be split up
> eventually once we carve out the actual "files" backend, so meanwhile we
> have to live with this seemingly-unclean separation of concerns.

Ya, this one is a bit strange indeed. Writing a blob directly to a
packfile is done via index_blob_packfile_transaction() and currently
requires a transaction. Concerns regarding how exactly an object is
written should probably be transparently be handled by source.

In this case, writing a blob directly to a packfile should probably be
eventually moved down a layer behind the ODB object write interface.
Especially now that index_blob_packfile_transaction() is really just an
internal detail to the files object source and not part of the generic
transactional interface.

> > @@ -1971,7 +1971,7 @@ int read_loose_object(struct repository *repo,
> >  	return ret;
> >  }
> >  
> > -struct odb_transaction *begin_odb_transaction(struct object_database *odb)
> > +struct odb_transaction *object_file_transaction_begin(struct object_database *odb)
> >  {
> >  	if (odb->transaction)
> >  		BUG("ODB transaction already started");
> 
> I would have expected that this function now gets as input an `struct
> odb_source` instead of the whole object database. After all, the ODB
> layer is the one coordinating the sources and managing which sources to
> tap into for a specific use case. But the actual business logic to read
> or write objects should then be handled on the source level, shouldn't
> it?

Good point, I'll update this in the next version.

> > @@ -1982,7 +1982,7 @@ struct odb_transaction *begin_odb_transaction(struct object_database *odb)
> >  	return odb->transaction;
> >  }
> >  
> > -void end_odb_transaction(struct odb_transaction *transaction)
> > +void object_file_transaction_end(struct odb_transaction *transaction)
> >  {
> >  	flush_loose_object_transaction(transaction);
> >  	flush_packfile_transaction(transaction);
> 
> Shouldn't this also be called `object_file_transaction_commit()` to
> match the ODB layer?

Ya, its probably best to be consistent here. Will update.

> > diff --git a/odb.c b/odb.c
> > index 2a92a018c42..2cd954a1040 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -1051,3 +1051,13 @@ void odb_clear(struct object_database *o)
> >  	hashmap_clear(&o->pack_map);
> >  	string_list_clear(&o->submodule_source_paths, 0);
> >  }
> > +
> > +struct odb_transaction *odb_transaction_begin(struct object_database *odb)
> > +{
> > +	return object_file_transaction_begin(odb);
> > +}
> 
> So with the above, I would expect that we pick the source to create the
> transaction for here and then call `object_file_transaction_begin()` on
> that source. Eventually, once we have pluggable object databases, we
> would then not call `object_file_transaction_start()` directly anymore,
> but instead we'd call e.g. `source->backend.transaction_start()`.

Yup, I figure we will eventually have a function table for each source
that maps the corresponding operations similar to how its done for
reference backends.

> > diff --git a/odb.h b/odb.h
> > index a89b2143909..c7725b3df00 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -185,6 +185,9 @@ struct object_database {
> >  struct object_database *odb_new(struct repository *repo);
> >  void odb_clear(struct object_database *o);
> >  
> > +struct odb_transaction *odb_transaction_begin(struct object_database *odb);
> > +void odb_transaction_commit(struct odb_transaction *transaction);
> 
> Let's add some documentation here what these functions do and why you'd
> want to use them.

Will do.

Thanks for the review,
-Justin
