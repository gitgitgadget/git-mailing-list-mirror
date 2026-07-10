Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001583C1093
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667330; cv=none; b=ImWRVxlsE5HAKceUNmSU34Bj6rhRWPuOQ18o7Zu01VAS7NAWbUkdY9hIDTs45mVKM06fNFDhfBd8cadOevqxkMuJ7zyVb21io5BJSiUSGSfHCSTp9Sdp7/wDyJnwTW/3iH8GeCxxkkyIvDZ7/uNhLFg7AQI3Qp/JwG3p1uWjv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667330; c=relaxed/simple;
	bh=s8O6Pr8OEDcPnRYEpuCFOwlWjL7kSem9YtE8Fq8SgTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0nGfQ83mHifF3cbNnJPiJr+7T0e4jGAW/QcYM3S/DOqlIMN8jFZEzuKrQvF+GXKGnxpmvZAn5QIvNF1CNCglvxCyr/Jq8nlI/Ek7isedCe5buVYXg0jQriZKP2vFUAL3GgFQzso5fLHPIvbFBq4SNJVGRc4zXzt/CcWSu0bTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AP1EY+D8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bwV3kYq1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AP1EY+D8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bwV3kYq1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FEDBEC0182;
	Fri, 10 Jul 2026 03:08:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 10 Jul 2026 03:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783667328; x=1783753728; bh=16Gs22oUV8
	bKJVODy9FECkhZ2jWEJgQqLNb6AY9Qtv4=; b=AP1EY+D8fEF6BdjWNWZcPfxzNu
	1bgq47QtD8oWGGgZ1ofXOqqg2c6jgO0tbhJ+Nv36Vy0oloZKVMogzTafoGWtlDSN
	JG+U4rSjXw86CgGSoTNO1RzIleMQUMaFy3AuovBwHQNsikOblHcSs9Y4vXLHgRKx
	J68sCrUUSMqz72DvoL1X201eksAE2Fu9IOXLcMpFXKM0Wo+OtmIVoJOLHpQsKK3N
	UoDyR0uexSX5ZuE29kPwki+Ldnwh6L8eQaqM+UGOkWCrfuAjaV18BsHJqhTG9oAw
	5z99lFkTTTizW8YlXpLv6iiomEcqN7PrC0o+iBIZrNhiapIMoQD5090lBMWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783667328; x=1783753728; bh=16Gs22oUV8bKJVODy9FECkhZ2jWEJgQqLNb
	6AY9Qtv4=; b=bwV3kYq1bjI/XdBN/iaxjskWYeH3jqCuSD71GFj/qdp03e03obX
	eqLtA9+BH2O0BhAEER0NU47BwnFpnZqClfodBLF1hVjOyx+CJLJCR0WTZGY1asft
	1A6jORVo/C4tXj2FAlb6gF+ZEFLmLLu8L6LL5CzVEF53JDyHk41boOEBYh55nHY4
	LADKMdM31D1dppMzd0oOUYyFnn7KeU3evTAbT617O6Xn4Pz6LA+RQGt7AGhLQoYk
	St4GeQ0kTN4SA7ZbZQsGbv41lgMLg425XET4umZ5yeaiQr6KiX5LpE5o2jsU1NIf
	AgOpBkH5AthkkxXDbN5N9A3EqPPeJLT0Jdw==
X-ME-Sender: <xms:f5pQaj6U2QGBJJY_JO5OWwtiTpq9eRqxkEv_vGZOGEA7yMau0Y8ElA>
    <xme:f5pQau5xj4rLcVgTDFOM-1j3cotN1h1VGD4H8JxwdLNM9S5F3WD2Plc5GaQ3Utjoe
    _6n0W0EmuLI9e-5m6bLOyolNUlOPvzUchGAg3vKDf9KYY3GGK-F>
X-ME-Received: <xmr:f5pQaoFMIH8GJ0hRTTNA49wt-QTKCWPVsPBpKfCWuuTwGK7wqnSP0-9EsXqovaXLD6Q8ne7ZKnw1a1BfrxKukBMTmBB3fEelr6wh3E_JKT-P2g>
X-ME-Proxy-Cause: dmFkZTEGzWF0KumW2c+ke85oX0TErXRs9sqhW8ursPvJjv+whhfnVn3GAZczbwBG6Ays9X
    YucgkxvtFpJhiMajQeeOC1jFUVacskPLHdU0EI7R1tXz/jLkBV51LNuJfguqn8i/GsZ6JN
    SvmM5YX3du48dcK6cntyvi4AWMrXgRJpom6tv8SJKB1LaP1bk7n+CwOo2A+lP7/ZepUtef
    P0BnMVuyZQjp32LQ4EXVJTeniQF37BY8sYdAqNfdWDRt/GAdBpKT6b6GeIRhXS61bedCS8
    /lcvPzebmnYRGnYpXNfbRglNbhO+0bz9Tnv0NKfEKgiwEUNWpv9IfOLtxF6Scrqvm5iGmC
    HS8e3ZFrZ+omMCyoTf0kMliZtBP6KZpopfU/ePkUclTqTfPxQjFlYRezIBPxBawNYVg5X6
    8PEkyNC+Lw1m9ETf2C0ASD2Adytq43p16iYHR0AuMTsmPEt7NOeyIudbFiwz9voJ/VTgjC
    Hk7dmR3Pg1SSgCWUB9bfATClDCsKUuyS68LxMbfFMP35SGjCf2doQRsTlwGzbgJh8FW1SR
    fEnxpgP8PpqP1PmE3hYZqYnFiJF0JadmgC1kGer8cYOIzmwM51Pm9MVSqr1jLHkyMnXFMx
    c2EGrWCxFqUnV8VZUsqFh+5j6XIJ2noYRA/9yV63XWUGmRsU+S9E7JRsoy8g
X-ME-Proxy: <xmx:f5pQavTBQrIaTWUsVL5548e3SLT4eEztO22DSE7ew-oJmzkVwcS3tA>
    <xmx:gJpQaptKZC9HkY5oYsGcfKcwKCAFQuQpPLt0LjKkwHQTsVJOOMv_FA>
    <xmx:gJpQamzxNhcTAUgy9ZBsztldfTA27kIeSFTvjFgXMNlcZS4s-bioTA>
    <xmx:gJpQar6FcFI7rNQx7KcKEiOeqSlF0Obuysrm_2PmwOWAKwZZyNsfKw>
    <xmx:gJpQahojbzbgo-c-1XPuq6Bioso0Ncnsb9Xg8OPMV3b1GnTTxiUyQsz0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 03:08:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e83070c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 07:08:47 +0000 (UTC)
Date: Fri, 10 Jul 2026 09:08:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] pack-bitmap: allow aborting iteration of bitmapped
 objects
Message-ID: <alCafO91ZtFdikPg@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-3-82fe014b12b3@pks.im>
 <alAAN6_ZqLj9tlgV@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alAAN6_ZqLj9tlgV@denethor>

On Thu, Jul 09, 2026 at 03:19:52PM -0500, Justin Tobler wrote:
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index ea5eab4cf8..8ff92c5272 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1909,7 +1909,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
> >  		return 0;
> >  
> >  	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
> > -	return 1;
> > +	return 0;
> 
> I wonder why this was even returning 1 to begin with? As you mentioned,
> the return value appears to be ignored anyways. I'm assuming it was
> signal that an object entry was created?

The function is only called from a single location, and the return value
was completely ignored until this commit. It has always been this way
since the function was originally introduced in 6b8fda2db1
(pack-objects: use bitmaps when packing objects, 2013-12-21), so it
never seemed to have any purpose. The commit message doesn't mention
anything either.

> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index 8f63003709..02818b81c6 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -486,7 +486,7 @@ static int show_object_fast(
> >  	void *payload UNUSED)
> >  {
> >  	fprintf(stdout, "%s\n", oid_to_hex(oid));
> > -	return 1;
> > +	return 0;
> 
> Also curious about this one too. It probably doesn't matter though.

Likewise, this was introduced in aa32939fea (rev-list: add bitmap mode
to speed up object lists, 2013-12-21), and the return value wasn't ever
used for anything.

Patrick
