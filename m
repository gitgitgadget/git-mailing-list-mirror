Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A639156F45
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632621; cv=none; b=dgRz+p0vpYsN2H/fTS1McgpLxS0v9WWVNh5VanBq4bXPLhXV/La6L5uDBkGEl/zu2uzVXYyBq2ypHiLzFrAqZS1h0MpGQOqmhoMJ2DuJfTipRp1U2zhuJv+DsMFjCYyBz1ipmj59ZEKGRWocDMip9DkGGSSWJR03HE/cGntDbVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632621; c=relaxed/simple;
	bh=iupL/YtSfAWbmCNDvOlwTXmmtcFc66OwyqBJrV+H+Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGxECTXkn8ahERz3aJ+cNEHioCNqDHE42m2a5+g8i9FFSvF4SGPTwQTU559EWDlmg8GyfOA+IF7SbQeIWaY68R/x1s0mYDEZDmOC3qO3dBhBzy++5oSSVwkeTJjwPb9ccqd2MuAuV59V+U+1ANy7tgI/My5JP+qbipAL8dHrNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=lxXpHMLF; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="lxXpHMLF"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e951dfcbc5bso1172104276.3
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757632618; x=1758237418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgJ7bSivVsGJXqOdM/bPEbLSWrKQaVRZQB1ZLsYG44A=;
        b=lxXpHMLFMiyt2SWCRuJcGzaWQJuCkEzXtkkc1RL1qUsxodksN+9I1xbIslA+7F46u6
         HLHL0tfS9tSWapMpXNDtcoRgQw7IRDiTdsJDfOCu6St6zVEL8CAuC43oyBlFsLnUOhz7
         DhDu9CacydeAG06ccH1uH4FmeeD1WNo2sx798eepNtflGLrjLm8xqHSs2a3QW1mxsIO8
         HvrnImb3Agl754pEEfmkDQLwFYDn1YXkAIFmXDJUhTKt6sKOsLsgjqZkOw+FvVSZb6vM
         vUUem7EesK+HXCNOQi7hWzURMEy6+J+j2cQmIK0VJdT18sTXP2GQ5SZFoNENfi9EnoPE
         GclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757632618; x=1758237418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgJ7bSivVsGJXqOdM/bPEbLSWrKQaVRZQB1ZLsYG44A=;
        b=Wc/m4KfY80zkQzOs+FX7OWAagnAHtLifF2Yh8svUBmG00Hvnem8LX8+C8JxHhFibQY
         xlT5e1o6PuzZkALmOZMHhpwMPXOledmQn79lQ8K8MG068I9e4aioikGejcjtoH0ugCpG
         SKoobZCPjqRJ2ys7taX6pA+onL86gJLVLOPoFeZ6CbfyouGBFFAXDuoh/oKFXWKwJ96Y
         68YQ+8cduvVjaCtt9hKQT/K4iQ5WO/k8d6SJEBrRU/I6DORcKZ5NERrkuhnHYmgvJrm6
         VeZkN9kWhxUYs/nb7aZZe/Ds2Krd5qTN9khV+vihH8UaruzWTKocql0RQk7I+H/8YeX4
         kTvA==
X-Gm-Message-State: AOJu0Yx+vVIZ48WidB2A09D9ng1uEO+4mR9USQ17zVX0+g23FQik7YVA
	790RbdOvzdUKdoe+QtiPih43w7M+srbkcv3zGEqL4LmJb2AWhqRc+BFFSXHMv2mJyyc=
X-Gm-Gg: ASbGncuEr6stZQOIB0L3s3zYcan5hmv3RvS/nFcWNhplUpYZHkoSYBvplpM7zr5Hxl0
	TOEO4tviCFHN3EsKd93yFGZhfP3KysBuq10fUsx41PWfydzHwvHcfDQ8Ovff1SqG/ratG/wEScb
	Rd7MQehR8MQOtCrgu8Cnnw+wSPqGeD9H1nXeNOV74lRCRsGmFA8C99/DTBUbBW95Zz51aTJ2ijJ
	PQ4iOLI7oDmrcSfHY9P308Zlem05GBCBA2u+BZ5eCtx+DZgwtPP/lL0iORbnzxpMQS+QQP8WyG6
	qzCuJSpbz7ZltcZU75EPaICUrnZ6aNh5dQOZZ+cHv4Eacun8gGnA+A0cIUvMoFhgr3yzPz4En5r
	owXLW2zc3KMKoQj7sNRUhG29yjH4LVk1iRo2FFK37igd/A/BJRsyl6r0RCF45hXXGI8VxqMGDM+
	wXg//GX9bJJ4vwIZqULb/ZiP6Eyw==
X-Google-Smtp-Source: AGHT+IHnwL+YohGof2pyXrVCGQMDDDsz5EUVqPwBdO9FtQ24O79u/GD3iR0ScyBRBxyK9o7X0Vp64w==
X-Received: by 2002:a05:690e:154f:10b0:600:f8c2:2264 with SMTP id 956f58d0204a3-6271e757025mr953812d50.7.1757632618525;
        Thu, 11 Sep 2025 16:16:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-ea3cf21282csm872697276.19.2025.09.11.16.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:16:57 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:16:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/16] odb: move list of packfiles into `struct
 packfile_store`
Message-ID: <aMNYaPSnf6JP7bNj@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-2-d10623355e9f@pks.im>
 <aKz0/WNu/GRYh3/W@nand.local>
 <aLav4UAcfQjvNzMF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLav4UAcfQjvNzMF@pks.im>

On Tue, Sep 02, 2025 at 10:50:41AM +0200, Patrick Steinhardt wrote:
> > > diff --git a/packfile.c b/packfile.c
> > > index 8fbf1cfc2d..6478e4cc30 100644
> > > --- a/packfile.c
> > > +++ b/packfile.c
> > > @@ -278,7 +278,7 @@ static int unuse_one_window(struct packed_git *current)
> > >
> > >  	if (current)
> > >  		scan_windows(current, &lru_p, &lru_w, &lru_l);
> > > -	for (p = current->repo->objects->packed_git; p; p = p->next)
> > > +	for (p = current->repo->objects->packfiles->packs; p; p = p->next)
> >
> > Not a huge deal, but I do find "current->repo->objects->packfiles->packs"
> > to be a bit unfortunate. I wonder if we should rename "packs" to "head"
> > or "list_head" or similar since it's clear from
> > "current->repo->objects->packfiles" that this is a list of packfiles.
>
> I'd like to keep this part as-is for now if you don't mind. This is
> mostly because I've got a follow-up patch series that _does_ introduce
> `head` as part of making the `->next` pointer go away.

I'm OK with that approach provided that you have a plan to introduce
"head" here ;-).

> > > @@ -2344,5 +2339,23 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
> > >
> > >  void packfile_store_free(struct packfile_store *store)
> > >  {
> > > +	packfile_store_close(store);
> >
> > Seeing a call to packfile_store_close() here was a little surprising to
> > me. The code that you are moving has a comment that says:
> >
> >    * `close_object_store()` only closes the packfiles, but doesn't free
> >    * them. We thus have to do this manually.
> >
> > , so I would have expected to preserve that behavior.
>
> This behaviour is preserved though. Calling `packfile_store_close()`
> does not free the packfiles, it only closes them. And we continue to
> call `packfile_store_close()` in `close_object_store()`, so nothing
> changes.
>
> The only change in behaviour is that we now also know to close packfiles
> when freeing the packfile store.

Why is that change necessary? I am not trying to be overly pedantic
here, but as you note above this code is extremely fragile, so I am
trying to avoid any changes that are not strictly necessary.

Thanks,
Taylor
