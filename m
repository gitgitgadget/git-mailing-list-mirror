Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30A1BBBDD
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808843; cv=none; b=upPVjl7wGU5JZ7mUByy7/Waqk5IWHz6Li4ORWsUSziUw1uv6HjLk6dQib6ztQSq09Rp7JukfnQqGlP2W3YhMR3M2zUmCLCCM+4Ryb2tS5CqzP8xIPbQYun4FmeQewY0/ImUQpuWroKpkJ0aFoaUhxG9qepe+1gaq0jvte1Fmzas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808843; c=relaxed/simple;
	bh=jecXMqraqP1UExd+08g+EClUlb0l67k3uzoq80Y0EiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4yMRejuhZ9CATJoTX77BuWQBumDEmtNuVpIzrIQlYU/ePJ1VpBiEvAZsJQmOvUhsJcHy2OixZ9d+Eax605ESn/SNcaYM+dMB4kErpUqNjhgAsUaQDQG75c6Hnlyf2+SCPm0CMMm7p5LdMwZ2OxcLLZqEudM+xCclJSQEnEGkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0mZMF2Kg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0mZMF2Kg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b3d1a77bbso33425ad.0
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727808841; x=1728413641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGBdeoOjCeEtDzaBcLGYXwFHssddbgVWB5F4BTSGy7s=;
        b=0mZMF2Kg4eAzReSCYqt9QaQWko8ayMfL+HmJOoxQGYfLvL1o5XEPpRbgG7Vh0u64tq
         Yu6olS7UPpZBu65bvmKHiexZ+WczOCet2Lj7S6g+r2TRTxvOtTHyhERhBXWHU2IimC8q
         RU0PL8eZqgI5y3EVLsiUFnmVeLNZIHbgHmMyeQBRUCsNeN+U424cB/VXPLW4shUd/3uG
         XAAT1Hxs5LktbsD2rPBII2vbIC9mTih59oUNKAH1On17o00weTYJtOZx2zOHc1K9vaiX
         7artCxGrtq5a8ncP844s6ZJ8kXw3z1QbTutz6Y9/gHuQ66xceyiSPg5CizZFpePUTaYT
         L/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808841; x=1728413641;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGBdeoOjCeEtDzaBcLGYXwFHssddbgVWB5F4BTSGy7s=;
        b=pqWJYJtv4ir2mrlxfiI2kG0lSW+4nrolPUxWW5DHOfeX3FXCXKFXIsfmITx0nmRrA0
         zk6mt/4AoRiWVzOp39JZHldYVTyiNSHuQkZF5dgadattXoBmMZBLAm8ZSaMXFPwmJR8x
         /KuqF4lnPWtVTDWo4yv2DnDDMujL5qDlytf7jdNQhHPPsT3zaea0FpeG3cOrkcIp12e5
         I002grpBrz+x/13e/oW6MR3QOCQz3e9sjfyISQ0N/WXXCjJxTJ69qQSsYhVuHYpSZdKI
         Wm9j1H8/vGcjifMWPNany5c3n3MnSwTc/lnV/blaYHU1+3pUesrC/bRkAVzY2iiubUcJ
         tIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhirp2Or/B9pLSlmOu7wojAECg0UyiTel1pU7ZzetemYJpNDYh2B5EDEQadeCyukOYUKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdZAg43U3cvJQwKfdirNLTMD2Z6nnCFTqbU/2/DU2GoJ42+s2
	ebOjq1T8T3qzlVZV0Y5LdLeCneg+mIdGRuWTz9wSdDn/hBtDKLEgl7ew5HmakA==
X-Google-Smtp-Source: AGHT+IHlRFrWBTTFvx7xDbvv9ATGnjxX4Y7yVYRrBjApyNufuG1wFehRP+tQzips5f7zefiMhB8P5Q==
X-Received: by 2002:a17:902:c2c4:b0:20b:b48d:6ae with SMTP id d9443c01a7336-20bc6f5c01cmr275535ad.13.1727808841067;
        Tue, 01 Oct 2024 11:54:01 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c94b:f43:9eb5:7d8b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db292ac7sm7552838a12.7.2024.10.01.11.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:53:59 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:53:54 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, James Liu <james@jamesliu.io>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <joxzwkbi4uqyb6d67e24ivfvb54ev5ciqgvuxgxh4nntonjwqa@az3xgiiqg4x7>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, James Liu <james@jamesliu.io>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
 <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
 <20240927040752.GA567671@coredump.intra.peff.net>
 <c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>
 <xmqqjzes2s5y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzes2s5y.fsf@gitster.g>

On 2024.10.01 00:34, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > On 2024.09.27 00:07, Jeff King wrote:
> >> On Tue, Sep 24, 2024 at 07:33:08AM +0200, Patrick Steinhardt wrote:
> >> 
> >> > +test_expect_success 'ref transaction: many concurrent writers' '
> >> > +	test_when_finished "rm -rf repo" &&
> >> > +	git init repo &&
> >> > +	(
> >> > +		cd repo &&
> >> > +		# Set a high timeout such that a busy CI machine will not abort
> >> > +		# early. 10 seconds should hopefully be ample of time to make
> >> > +		# this non-flaky.
> >> > +		git config set reftable.lockTimeout 10000 &&
> >> ...
> >
> > We're seeing repeated failures from this test case with ASan enabled.
> > Unfortunately, we've only been able to reproduce this on our
> > $DAYJOB-specific build system. I haven't been able to get it to fail
> > using just the upstream Makefile so far. I'll keep trying to find a way
> > to reproduce this.
> >
> > FWIW, we're not getting I/O errors, we see the following:
> > fatal: update_ref failed for ref 'refs/heads/branch-20': cannot lock references
> >
> > We tried increasing the timeout in the test to 2 minutes (up from 10s),
> > but it didn't fix the failures.
> 
> Thanks for a report, and please keep digging ;-).
> 
> Is your build, like Peff's, for Windows, or your variant of Linux?
> 
> Thanks.

It's our internal Debian-based variant of Linux. Sorry for not
specifying earlier.
