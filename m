Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9334A33
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272887; cv=none; b=QcZ0QnmQQtvTFfs2JxxwwBge5dVU/PC2X0OcLJM/83GE9nvJxWrzdRUSuPZOXKd1lKHmhenhhaxaBBpSBzJB/vyBfCtJgmpykM3zU6fF/0IWOnFWlm4fhHSK9U0Tjx/njTCFicSNZ0qFs8wic/8v+iNBU4mjw0zbV68Kest8CZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272887; c=relaxed/simple;
	bh=e17v3cwcXDXbo7q+QxzvkKmbo1F5qvVS70lMFXchC10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb6XZxvMNgDRMWFEl4ayPgbljROhocqgFyheDVxtgCWsxEbumdsCT0u4K53RQSLjSNAs92f3Egjlap9ha4hHFmqpzdam8wR29y8BggnR8lHbyr21xbXTwmDsEp0wPEuKeokpBEwsSRSmgdgrVCL90nmFEbXpZYqgpJ5dy9JptMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=m6XustHu; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m6XustHu"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-475086185easo20019161cf.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741272884; x=1741877684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yqRVr9qn+/hjbbLFAhPxnJLIyNIw26bahPAOGzdzWi8=;
        b=m6XustHuKgRXc3F7/DJ/NQcrvQ0zCp3eIDcd4iESHr9zzZ2/Gvm2ddl+ZPNJzqqNp+
         lY/w8uXkmpE42StIk7P/ulzRLPu5zmqASJrVtZo9j7yxoXNnYjeJmJ+eqLHVrdOb39Zx
         QhlD4rj5Vsr4MwydZmCUeFVzmIRHBXFz+RkUr50qY3aBMtq11sYSoFvHeZt/s15+c0JA
         LH6WWFYeOaZilVYq1QiX5Jz2tE0Apwgl8QuAH3YiezKcd6UCFtIbk8KS4OKWYT5gCamb
         Y5Ao6f5FKQntDR9awBaVAZuK6LfN7cVXwehoaQfGd5dpAGZIN/EJlq7x4QvcEQsf9h2k
         iDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741272884; x=1741877684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqRVr9qn+/hjbbLFAhPxnJLIyNIw26bahPAOGzdzWi8=;
        b=fEr3R6BHNB0x2OVXwFwYEvub0IwhorfGjFg7BAM5OPS7FflTE5WknyUv4ILdnqm1pB
         tyt8qvDP/xmWt1gfbrIoKwXP5CGJT3byHttsqenkEf3hV0LzT9Q+vXL1aelZGK6tKzBB
         3IPrUsGFW7C5aPuA8xPxPUOsl1RSO3hCcG59+qemTVPkLgmYxpEQrT7uHm/cJvkW4k1r
         oTYjmPQZX3dVjKz1S0ALUV4r8TWnLtb1WNfPog9PcAieZVGi6y9VTvjxRyBfSU31AOd6
         zXx4HmgIbTMoQdsCkQVHlRGbCMv909Fh+ayjU/Y0wHsZ2bLNlZCgtgvvCrof473aBhKK
         psRw==
X-Gm-Message-State: AOJu0YxDHxjJY4ln9UWcJIC554FFDRxHoaexbsSuCO5K9TjA+m2NSk/g
	vHtjxl2/FGud1VjhoQdIePAK2XP2Jor6nMfCKre1fXyT99u5KdyWTDk2UACExjk=
X-Gm-Gg: ASbGncsEsCgrvL4oOgjlmxpcqBvLqDdz98JClSOyq9e9j5empgxCvgOEjjEyGZc33u1
	xGgfB+19MGLJjmIrfabX28BUl72WUrzEYiZTsdAu1DAb1Dcds++Ss4m9bxu/TIJWTBXPAUijy8h
	h5ndUlOHALyGfjOo8oSWsPJNNhwjRcEuuIjwkkUj2tOYBCH3bu/Y4MpX1bo+UyQladISMnEG2TU
	ILunXCVucnaBkHCUJyLp7HXi9oFc+YBIeraPChrQrtTNhfP4+9DQcukKO81W92JN4ot4+HWe8lM
	NNAGv/Oyj9Qu7Y0uiMyNV+PVdNz5+uRL/xuLsgDnIXrquUNu1f2Uk3CWWfoyURP9aulkvg4q9E+
	AHJYVBpufJ/PNUkKv
X-Google-Smtp-Source: AGHT+IEIduOnAUUv8Ia+1kqcky1ePlRiti+pao0mhC6FC6ScOmEIFvUw9MLKkOHSBQKoLZJ379Wpdw==
X-Received: by 2002:ac8:5952:0:b0:46e:2d0b:e1bf with SMTP id d75a77b69052e-4751a55823dmr46708701cf.11.1741272884334;
        Thu, 06 Mar 2025 06:54:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4751d9a516esm8273451cf.34.2025.03.06.06.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:54:44 -0800 (PST)
Date: Thu, 6 Mar 2025 09:54:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	SURA <surak8806@gmail.com>
Subject: Re: [PATCH 2/2] refs.c: unify '--exclude' behavior between files and
 packed backends
Message-ID: <Z8m3Mo+3l0IxzyOH@nand.local>
References: <cover.1741223981.git.me@ttaylorr.com>
 <7e6a5e020bad14b782a8c85518289220579fae64.1741223981.git.me@ttaylorr.com>
 <Z8lhKT2KuM3VJ7d-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8lhKT2KuM3VJ7d-@pks.im>

On Thu, Mar 06, 2025 at 09:47:37AM +0100, Patrick Steinhardt wrote:
> On Wed, Mar 05, 2025 at 08:19:53PM -0500, Taylor Blau wrote:
>
> Nit: I'd reword the commit subject to not only talk about "files" and
> "packed" backends. Or maybe not mention the backend at all, as it is the
> same bug for every backend that implements excludes. Something like
> "refs: stop matching non-directory prefixes in exclude patterns", for
> example.

Fair enough.

> > diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
> > index fd58260a24..d955cf9541 100755
> > --- a/t/t1419-exclude-refs.sh
> > +++ b/t/t1419-exclude-refs.sh
> > @@ -101,7 +101,7 @@ test_expect_success 'adjacent, non-overlapping excluded regions' '
> >
> >  test_expect_success 'overlapping excluded regions' '
> >  	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual 2>perf &&
> > -	for_each_ref refs/heads/foo refs/heads/quux >expect &&
> > +	for_each_ref refs/heads/bar refs/heads/foo refs/heads/quux >expect &&
> >
> >  	test_cmp expect actual &&
> >  	assert_jumps 1 perf
>
> I was wondering whether this still tests the right thing. But the ranges
> still are overlapping, as "refs/heads" and "refs/heads/baz" are. So
> judging by the test description it seems to still do what's advertised.

That's not quite true. for_each_ref__exclude treats its first argument
as the positive half of the query, and the remaining arguments as
exclusions. So the only excluded regions here are "refs/heads/ba" and
"refs/heads/baz", which were overlapping prior to this patch but aren't
anymore.

So this test isn't quite doing what it says it is anymore, and should
really be called "non-directory excluded regions" or similar. But we
should still have a separate test that does cover excluded regions,
which needs a new layer underneath some hirearchy, e.g., having
"refs/heads/bar/x/..." and "refs/heads/bar" as the excluded regions.

I adjusted those and will push out a new version with the results
shortly. Thanks for reading closely.

Thanks,
Taylor
