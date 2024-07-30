Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A28F183CCD
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355803; cv=none; b=LOTAxYdJYOc8PSkigA8QXrLwi5ZAdLRDLlXCKUIJSVxCgYQ76yx+cXMcSRAi74ocII9WxkH/1l1umz59gpOvGXRmaePA3ZuiemzdyHY2s+9DxNLPuNjhcULSBVE7u1zWwPnj0GHefZBAmmX9s5O8oyPWnTQtUk8k7EAIsH4+5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355803; c=relaxed/simple;
	bh=+cwddhgDJX1jE/AGxx85Vv9cSyIPPBnVOqH/MO6l7gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDecPY85eEu3l4SLqWitlk5BQvBfBTTB85/d+09CfQbLfNBySHkArB/yHoS10CG7CtDPaCxIOP1VjZcdzfo5IDCmk5mybDNFRCuBoLDQVTG+BWSN7v9mq+thrhOAg0Up5ngX3A6nR2SxKg4ulz0QGvmNIJGDJKVFJFu3d4/D8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4g2W459; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4g2W459"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d333d57cdso3229894b3a.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722355802; x=1722960602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfSImKNcoXzf62xex4/rWSqDoNqM2CQ3zu7gIfGjkmU=;
        b=F4g2W459iUKo5gUqU1ewiQ970KxNIsYjuIg3sSt/f4M2pu3tm0d+mk19g1r7VBfLao
         H2YMKNdNjZ8I74hsAPVGTZWW4hHtLd92pZ7SzoP8/c44vqZBWNboV31jk6q33kznO5nK
         y6KnRKSwwfJSNdUK7x8tjBlIbNKBtNalrCytUlgLZlITu675MIWEzqsZaOzNABGaeht6
         un/OlXaeBLVeow+Xi13vksvO3ySqZ1hDd4x9XcRJ2HO2Md930q9rRWNbkM4D1Oi24X24
         TBCjtcocRRGRz2MIfEcMpz6+6S41gblHQKmyZ8t31huhSSvKuwTsm0pQ0jdRRt+ZeC+q
         zjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722355802; x=1722960602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfSImKNcoXzf62xex4/rWSqDoNqM2CQ3zu7gIfGjkmU=;
        b=VZ3qbOLF8OAJES44+o2c3gbnQ644JR6OfCKvYeIyeK+00YaWs+FC4xrTdQ45b06UbT
         RVGTCKZHZrqIQm2wMSKIuGbZX8d1otT0NCQ3t2Qtr/1z+WKXLDXB4ciu8OG4Ra5VgBCm
         wGk4fQgQ1/FnsU2ErhY/R570rAmmjOMc4+naE0IYLt9xk4LRl/f7ZnCVSts14zdJQK9V
         nBbHT8dvxsjtPMfR1jij0V/kptseROohkhREcUo4LrTVNkXFz3CChvIjbbx6eJamuqpE
         qi0AmQyRAKTOnHeFKKoso5B+F7/Jih/kLvYrPAw+FSmd5thhczzBSyBArxZol4i1nkDP
         GNvQ==
X-Gm-Message-State: AOJu0YxNbx5qp9AZxPawCGntZVTlkrFb+V/AEHGS4S40KNPXVSjG1/cb
	Xd/y7LGdTbmnkMv9x2vAAjDAVFsJ4GCZDGtZChW/+rQfdqtzL4v1uIsDQw==
X-Google-Smtp-Source: AGHT+IExuYfOJRSDA4B4XotxMTyvno25vYj2fLkDzO/VO720bLKaBGp/1k12xcGDsgYvLAtZKlfwvw==
X-Received: by 2002:a05:6a00:8592:b0:702:3e36:b7c4 with SMTP id d2e1a72fcca58-70ece9eb510mr9626446b3a.5.1722355801497;
        Tue, 30 Jul 2024 09:10:01 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7c71897sm7784195a12.16.2024.07.30.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:10:01 -0700 (PDT)
Date: Wed, 31 Jul 2024 00:10:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 08/10] files-backend: add unified interface for
 refs scanning
Message-ID: <ZqkQbjtDFawIwlvf@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYw-k-MzhPTNRf@ArchLinux>
 <Zqik73qynJvOLctw@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqik73qynJvOLctw@tanuki>

> > +	iter = dir_iterator_begin(sb.buf, 0);
> > +
> > +	if (!iter) {
> > +		ret = error_errno("cannot open directory %s", sb.buf);
> > +		goto out;
> > +	}
> 
> The error message should probably be marked as translatable. Also, I'd
> personally remove the newline between `iter = ...` and the error check
> as those are a logical unit.
> 

Yes, I will improve this in the next version.

> > +			for (size_t i = 0; fsck_refs_fns[i]; i++) {
> > +				if (fsck_refs_fns[i](o, gitdir, refs_check_dir, iter))
> > +					ret = -1;
> > +			}
> > +		} else {
> > +			ret = error(_("unexpected file type for '%s'"),
> > +				    iter->basename);
> 
> Instead of printing this as an error directly, shouldn't we report it
> via the `fsck_refs_report` interface?
> 

Yes, exactly we should use this interface. I accidentally ignored this.
Thanks.

> > +out:
> > +	strbuf_release(&sb);
> > +	return ret;
> > +}
> > +
> > +static int files_fsck_refs(struct ref_store *ref_store,
> > +			   struct fsck_options *o)
> > +{
> > +	files_fsck_refs_fn fsck_refs_fns[]= {
> > +		NULL
> 
> The last member should also end with a comma.
> 

I will improve this in the next version.

> > +	};
> > +
> > +	if (o->verbose)
> > +		fprintf_ln(stderr, "Checking references consistency");
> > +
> > +	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fns);
> > +
> 
> This newline should be removed.
> 

OK.

> > +}
> > +
> >  static int files_fsck(struct ref_store *ref_store,
> >  		      struct fsck_options *o)
> >  {
> >  	struct files_ref_store *refs =
> >  		files_downcast(ref_store, REF_STORE_READ, "fsck");
> >  
> > -	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
> > +	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o) |
> > +	       files_fsck_refs(ref_store, o);
> 
> I'd think we should first check loose files and then continue to check
> the packed ref store. That's really only a gut feeling though, and I
> cannot exactly say why that feels more natural.
> 

It would feel more natural. Because packed-ref will point to the
loose ref. So we should first check the loose refs. For example. If a
regular ref is bad, we will first report the problem. And suppose the
packed-ref have recorded this regular ref. When checking packed-ref, we
could not check the regular ref itself. We only need to check one thing.

  Whether the pointee exists under the "refs/" directory.

And we do not need to check regular ref again because we have checked in
the loose refs part.

> Patrick
