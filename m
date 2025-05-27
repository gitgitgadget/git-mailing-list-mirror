Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358862DCBF0
	for <git@vger.kernel.org>; Tue, 27 May 2025 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375432; cv=none; b=KwnrOWAuDODIH7fxpofKKD6dHVTYaO/uSh8wN2+j/GUDsgOF12p9AZqxI/mIc4J9RuNyMLHfK59hVvRa71FG6FKwzuOnOyyS+fA0EUhuZNBGcgPWPkG8JOlnIgU7itMb+lUH91L8ams60xhaQEM2oPEyMbHZiS6BQUBaaodW4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375432; c=relaxed/simple;
	bh=3pHhqHjO2NKeY7tagHOE2BLm1FtxLiYntoVxDY83KIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyZFbsG8SbA7XgddaY/dTr34FQO+ZzU4bXGYyTkqXNRGk/MLcfdI0aHNyfBKkfZMD4nFL4OxCqtQvHRlJu1Xs3lML+nsMVlot8YcZZpocXsKqh6eiHv8JEdZD5pYPukkZPi5BKbsB4DGEFympsyKPhHtzHJ59SCRXVx16JiDhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs5nI1id; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs5nI1id"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2d522f699bcso1424663fac.2
        for <git@vger.kernel.org>; Tue, 27 May 2025 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748375430; x=1748980230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFPgRFINe9PDmbys2c7xyZXBg5uEKJK2ToZ8qlDN2rc=;
        b=Vs5nI1idOc4qmICPEuYIrsFen6qoZsobpA3AH41e+wDr9QIUj0U3X9xHvwTWJx8Gmd
         7z2wHA/YH8qpAVMYQ4nhwqffJkdqehyXUH10xyaimtck/KqFLyddBygSqlaDXFV2JhE2
         IqAjmbXj/XP3CGTyedcvvzsgHWBrqQJ6XUUQ2mViQuoXvr2hPHSHpJukveCbdN6nJl1C
         OOe9RFCfjvBKU70GeD3xv5dprSJzEn80deQpOQrJh3qOm3/bWCGBhUlAioqVRJ44ECEs
         kjlmTsaKx/jlKAR6t087JZhuIiO0fr8nhXs9xmfHex+Kfq4cssCHjRnPF3Xef3Y07KaR
         49RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748375430; x=1748980230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFPgRFINe9PDmbys2c7xyZXBg5uEKJK2ToZ8qlDN2rc=;
        b=cckdKiDOIzGrYbgDc/zGI1InwHiyTQDgjzc4XAqGMWnepYawBt0ykI0vwTrk3x7mPc
         ggF1KIfwwwXmdn75Unf1unBFveKZ06NUZ4UY8dH9rhG4/eJDhPHZelimmxnc7un6c80t
         W+UUDIhp0kBl7x2DNlAActUKGpAXxz/MfnP1fnRejcxCto1tf9AxKYfyNiObj7BorLqX
         hxxHJ+t68Alu0NQ+5SQTSqN7VjjykIrtpfLHggErm/V6tJpZm0F2sjaz5qGfvx0GFEQG
         9XFRFfE50mRdYbwc8dHc5pkP8sxFMSJCh4Dy18FaZs9adGwMufFiUAs9JOhpcq8wcN54
         M0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXkE6uGDbVhXNJ/JJi/JMxe68xDNYDaD7TUqH+m80S5WYB+Zx4MYdH04vqMG4KzPVQdQtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKrHDbOavlUTiGDjxguNwbQWgodbEnMPX8IEFZ3mWfRBRkQlk
	Jhn196LiJpNV38Q0IRsiOiyVNKbCBcIK7mp7ZE9J8b+wiZjM/3N6Nsux
X-Gm-Gg: ASbGncva4HiCFlmMfA9M2TU2J3mhzR7X5xAP8+6j95oF8JRLXGRAtgTyfFtOGBDapD2
	8pi0JfPd5PXaOZ/EfkGgsF4UzErc2mgyR8Dm4CwNBDa0jpTAhgQDyxRmJ6dfjhyhqmAQqbJeVw5
	HRIMSpS9CumfgmngVX88TyJYNMPv/B7Nc8Y0n06qkrDXXdV7HSS18+LAhdndKJOZum9hUkeM554
	nwMlACks2qvfPWwB9LZW7g/uBHOxzbliZcBaQsDXSS9TFwUopYBvJWNXr6vwJD2kuCls810FchT
	SSIiFnvVaSOATHfVTewYscgCrVseCzYrRIO28Q7gh2Ee
X-Google-Smtp-Source: AGHT+IEYMBXY0jWAdDCTxkJkcw41kmMvHVZtO3nj4hbDCSd48xgRH6emfXA4fHhdtjI9KtfOF3HsOw==
X-Received: by 2002:a05:6870:71cb:b0:296:b568:7901 with SMTP id 586e51a60fabf-2e861e36c4dmr6919091fac.16.1748375429950;
        Tue, 27 May 2025 12:50:29 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2e3c0aa6fdbsm5460711fac.37.2025.05.27.12.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 12:50:29 -0700 (PDT)
Date: Tue, 27 May 2025 14:45:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (May 2025, #07; Fri, 23)
Message-ID: <shpx4piigp5sqgpbzx4vdgu4zdn7z3ykxhu2cdyjh5vpr6zbqb@rf2sxg6hukpd>
References: <xmqqtt5au523.fsf@gitster.g>
 <aDV0jwaQ2DlcM0lZ@pks.im>
 <xmqqtt56ov4k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt56ov4k.fsf@gitster.g>

On 25/05/27 09:50AM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > I think the only outstanding discussion is whether to name things
> > `odb_alternate` or `odb_source` [1]. In case others agree that
> > `odb_source` is a better name I'm happy to revise, but if not I'd rather
> > keep it as-is.
> 
> The model in which the term "alternates" was born is "A repository
> has its own object directory, the primary one, and in addition it
> can borrow from zero or more alternate object directories that are
> used by other repositories".  The presence of the primary makes the
> word "alternate" meaningful.
> 
> Is the model now "A repository has one object store, which consists
> of one or more X, all of which are equals"?  If there is no primary
> that is more special than others, then calling X an "alternate" may
> indeed sound funny, although (1) I do not find it terribly confusing
> and (2) I do not find "source" much better, either.

My understanding is that the object store still has a primary X and zero
or more alternative X. The idea is that eventually, with pluggable ODBs,
X can be a different backend/provider instead of just being "files". If
this is the case, calling X an "alternate" would mean we have a primary
"alternate" and potentially a set of "alternate" alternates.

This sounds a bit odd and doesn't quite match what I would intuitively
expect. But, I also don't find it super confusing either.

> The names we use to call the collection and the underlying
> implementations of the collection in the reference world
> unfortunately does not quite help to guide us, as we do not take two
> implementations and compose into one unified view, which is what we
> are doing in the object store.  Hmmm...

Similar to references, I still think of a pluggable ODB as a "backend".
The main difference being that with references there is only a single
backend active ("file" or "reftables") at a time, while for the object
store there could be multiple.

-Justin

> We call pathspec elements given on the command line collectively a
> pathspec.  "Object store elements like loose object directories and
> packfiles form the object store"?  That may be a mouthful.  I dunno.
