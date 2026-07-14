Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A951012C534
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994312; cv=none; b=kGAV+B8MFDbKR7b7pvm3G9VS42hgJVLDd8a44puMLa/YydMuFtv9cujDNuGggrvCdmMh3sIChqYHriybC0XtEs+dBKrdZ/eMSNHXvErYIYeqkSeBnRT1mQ8IA90Zbh07d+9DiKgCool7QZfSGEAm15NDOSOKuvA1F1F0Zx0+bT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994312; c=relaxed/simple;
	bh=udgcb6DJP9bP+1lLYWQXjldbM1GO4t89WkglsZetncM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv9MuzplyxUUe8wIqmCIxy7BpaPY75901TDrlFaKO30Vc1NlTmUcIo7wHiW87cfzYfwDJgyiW3rYdMWtyXIrApjE+GPxMRwJ2bKpyRN003w+0V6zhlAa9kcohKQUEC+bfeO1Af91o0FO2OE0NVDRCm7OL7YpWNZY1DGnEy7mytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=PXGjGjzH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="PXGjGjzH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92af0bc912aso43778285a.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783994309; x=1784599109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=udgcb6DJP9bP+1lLYWQXjldbM1GO4t89WkglsZetncM=;
        b=PXGjGjzHSdhcyM22HTVuFdd0f4xFWjD1rZWy4xWIurwKAYv4FjxtaOQUhPrdE2nZ/6
         dm0rjvWnsNfWlWwNJcJzvnIxIcBvEq4B/xAcI3lWaaO8LbYt7ZIvIVKPhLYsJfW+KQFL
         8bkxL2yg7E2QAk89w4uap+SrpwwFb/sO9fFTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783994309; x=1784599109;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udgcb6DJP9bP+1lLYWQXjldbM1GO4t89WkglsZetncM=;
        b=pJ9XVIIbc+cgmiE0gb9ut/2BItd98ijWOzel/9rIocM96fGN4cTdfE6630gjAqDsTc
         vzJmbwPyi9sKPmsnW5S2o8mVMGjAnO6zqm6nJJxHfxVX3J6h0c9N9HQRXnJifE0/5l4V
         4r6UF1HvX2hNbVCsjLK9rU35bW9kNesUjlP69AcLL63FkQ8PX2KAZoSEgLHwzfoncWzE
         wi4kEQm6lCVP5yvXrdHWfrkgpnLMUW/ohG5HzMzUe2eP85ZR4P6v2c2CARhczYVQdZ1X
         6sxnci4TV6zlcOxwLbqh2GxVzTDj0MwVl1HJ2CitZpCEHsHEhU/H1qUJI/TUOrPfhBhD
         srYw==
X-Gm-Message-State: AOJu0Yx4QSXL4zKpwiUcsJv3F3FPRehf74ifnZStVRYqubD1yxxWOEDL
	6QIdGXCnEvxIkBHvFb7UhH5FAhEsdciGWnayFSdMxauGe/PCgfSrh+3Q3hfy1kzs8KRBqiQRN6h
	kBlEq0H4=
X-Gm-Gg: AfdE7cmtgTsAjxuYsXCztEX0/tyRfpNv3tUm+L7asUabaPqxo7lJKTPacKtC+d3GPue
	pAbRtuppkStRJn2DY6uCXSauG+eMQAcV80RDkdQ58cYuE+El3ZSSyDARX24i86T/BEQoiVop6xV
	nXy9ceDndVaWpUlZTvbodTp57Lv38RDWVjebVLBNWGTqymHLLcgOAcj2aOi8akMFOfhCjqSLOLP
	kFwgVKB2N+d/LW/gCXOAiq6xGIsgOljORLi530EfnLs0ZEJuN2K/iWv9Z9x/dvO8jpPoR0XxjtG
	rsmFg3Auepv5lsKtHQqkfjqlVtcE5eR6FT00JyDBtz/4xBxHqC4B9REWC7hMGl6LyuGjI/bz36h
	XwEFT/hEW+HgdSd+ZC1BQZ0PcCPRZxAhQE9Z5tAssfLhUuWA4VuVPUx9Dby0cjT3w+Lc5NnbtcL
	UmnOgCwgmMXWphTIa97Ql5BhrsrydeZc3SPtzbmPA3oMEzA6dTciQfvkfEtdJRZaJX/c1KzZXhr
	j7fScI=
X-Received: by 2002:a05:620a:2948:b0:92e:6199:9fc7 with SMTP id af79cd13be357-92ef2be0bbfmr877501785a.4.1783994309356;
        Mon, 13 Jul 2026 18:58:29 -0700 (PDT)
Received: from com-76773 ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6a77csm1319534585a.45.2026.07.13.18.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 18:58:28 -0700 (PDT)
Date: Mon, 13 Jul 2026 18:58:24 -0700
From: Ted Nyman <tnyman@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
Message-ID: <alWXwAGWgXSXoRJv@com-76773>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVn-QmK3K91_tkH@com-76773>
 <xmqqse5mv10a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse5mv10a.fsf@gitster.g>

> While that does sound like a safe and correct approach, stepping
> back briefly, would it not be wasteful for the second process to
> download the same packfile that the first has already started
> downloading?

Yes. If two fetches overlap, the second download is redundant.

> Are there better ways for these processes to coordinate with each
> other? Instead of appending to the file, what if the second process
> uses a predictable temporary name (which we already use) to open a
> new file with O_CREAT | O_EXCL to avoid this redundant work?

Using the existing pack-<hash>.pack.temp name with O_CREAT | O_EXCL
would prevent concurrent writes, but EEXIST alone would not
distinguish an in-progress download from one left by an earlier
failed or interrupted invocation. The existing .pack.temp name is not
covered by the tmp_* pruning path, so simply waiting for it to
disappear could leave a fetch stuck after a crash.

The waiting case would also need a complete handoff. If the first
process finishes, the second would need to notice the installed pack
and account for the expected index-pack result and keep state. If the
first process fails and removes its temporary file, the second would
need to retry as the downloader. That is possible, but introduces
cross-process coordination and a timeout policy in http-fetch.

The unique tempfile preserves the existing "download, index, then
install" behavior for each invocation and fixes both the
concurrent-append and EOF-resume failures. Avoiding the duplicate
transfer would be useful for large packs, but I would prefer to keep
that as a follow-up unless you think it is necessary for this
correctness fix.

Thanks,
Ted
