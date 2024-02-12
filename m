Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68914CDE1
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773754; cv=none; b=P7wuWCZFukCA3dTtIYNvDoNDyyxls1x7i07XhgKEkxHlsjNQa1+2y0o4KY1NgeeMIjqb+nw+3id78vuR/5Kv8q2GzHht6mXWRZnuT2HzsW7VQNCJpmN9NPZGRf1ZunNhdzUe6E01NsuVEsmPH7EIFvUiKnjDOOAWhVp/3q5ZLBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773754; c=relaxed/simple;
	bh=MkJKWfJUjRymzXhJ63r+eND6M/ab08aYC3Yua7V2L4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOja8yVILzTrvyZJXgN7Pti7cEV7WkPx/wU2tIDB9dnkZq/ZeTD8+ZHGTWPoH87dzT5+y0vdE3nAgCEsPMiqGS5ihx0HQe8mmjhRR1rgzfdnCbEKIfJlJkxNShtaDeW6hR1Sr34VTOiESMsRMT3GFIXbw8sPBdZfzLeqWMrEgYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkYkILXz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkYkILXz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d746856d85so27407035ad.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 13:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773752; x=1708378552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDPe93cK8YUHbrkgCrqsa7762HqSVzDp84VT1RRa+Ds=;
        b=vkYkILXzRwK74AEKpPBiuwJ7g3Zcc1UEDmbCXyfWTXu8BDT2dv2RcoN/y1ZF0aTcge
         Lava0VVUYrJ4Y/fyGMAZmhYtJ8ZTu4d2dDQZy1stTyFm4h7m2AA/kpdCe4evAqf2kOPH
         1QefxY0YlqRirhrNMj3pUG7GcMM/4YDZP7TGFhfaJwBvGGEutsZbbhPr7o5nE1jproX+
         nLugyV23LN9f3apNPDsw4UA2pVQz1BzxUOIQrxelJ6kTRtYjmXgLcnnZGHkaNRglGtD0
         AAdUYAheonWdILqpFs+dzjagspBMqT94UHWw5eVo6YYxvEwCDNObv8KvHauFQqqEG7l+
         1K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773752; x=1708378552;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDPe93cK8YUHbrkgCrqsa7762HqSVzDp84VT1RRa+Ds=;
        b=jydSCciPKJ1p8gnMc9OjbbNkdT6Ythmh3/mrrGpViuiCOy+SIh3S5fYHixwyyXRUwH
         o3GMAn4ea4qq/cMI5GVyGZexGhumlw6FCHqYpCGQRZGC5qrugHrfmm3PivaWpsHJzY9H
         hfkOSD4YhfGVjk44BJJ0doKI4thGPYliO23eLVvbsTOSedUkPcnElKCNXlSj7yjx1wuA
         M3chw3mtZClYQA443x8RgO8JIVbn8Q9Yf+t5h108L12Xx1ErDyduyCJcQxdB71+a7l3b
         2kvBWPWwe/gahKuom1b86OYKd/i0Uqplz2S2MPWpBNmONYzMU8vPW5Co7rJQhKuMNeaf
         fOdw==
X-Gm-Message-State: AOJu0Ywp/t3sJqGG/nQZUIO/JeiJQVm0gZgkHIcGr21fnNGevW15zaZK
	JpJGrzq/ikFRuh510H5YhFZ9O5ESHSxHoCAjQ5L8BN7qu7g09yT7XWqv0VNV2w==
X-Google-Smtp-Source: AGHT+IF7ezYbjMMpkUDhwUq4ybVac1turUA3RN1DBMQyFQTHJuglF7b3OF+uIIDS7hEwwYVAsCgiMQ==
X-Received: by 2002:a17:903:1208:b0:1d9:b789:b1b9 with SMTP id l8-20020a170903120800b001d9b789b1b9mr9834514plh.40.1707773751993;
        Mon, 12 Feb 2024 13:35:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfV4euoQ/diHBMwTrjHk5nHsgaVgzq8PutAdPI+3gh3oYO3iw6y2T8Il2kVPB8i4r/fzPJy879oRv2D9sFOnohkTVmcc6CRFd7JONWb/tD39Iax1hs7/CJGKqZieCPSV4+c+j4Yv4r8ULM/4fyIUIVOL/qZcM=
Received: from google.com ([2620:15c:2d3:204:5bb3:9725:3d2f:4438])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902d04a00b001da2951a788sm774277pll.304.2024.02.12.13.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 13:35:51 -0800 (PST)
Date: Mon, 12 Feb 2024 13:35:41 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 2/6] test-tool run-command testsuite: get shell
 from env
Message-ID: <ZcqPLR95C0PJPWH_@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <c8448406d71151714e89893208c46b8a4c369cb5.1706921262.git.steadmon@google.com>
 <xmqqle7w6lkt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqle7w6lkt.fsf@gitster.g>

On 2024.02.07 12:55, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > When running tests through `test-tool run-command testsuite`, we
> > currently hardcode `sh` as the command interpreter. As discussed in [1],
> > this is incorrect, and we should be using the shell set in
> > TEST_SHELL_PATH instead.
> >
> > Add a shell_path field in struct testsuite so that we can pass this to
> > the task runner callback. If this is non-null, we'll use it as the
> > argv[0] of the subprocess. Otherwise, we'll just execute the test
> > program directly.
> 
> That sounds nice in theory, but ...
> 
> > When setting up the struct testsuite in testsuite(), use the value
> > of TEST_SHELL_PATH if it's set, otherwise default to `sh`.
> 
> ... this done in the testsuite() function, doesn't suite.shell_path
> always gets some non-NULL value?  Perhaps in a later step we will
> add a mechanism to allow suite.shell_path to be NULL when we know
> we are running an executable, or something?
> 
> Leaving readers in a bit of suspense may, especially in a series
> that is short like this, be a good technique to entice them to keep
> reading, perhaps, but anyway, if that is what is intended, a simple
> "this feature is not used in this step, but we will take advantage
> of it soon in a later step" would be a good idea.

Reworded in V3.
