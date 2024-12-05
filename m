Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3441E492
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428262; cv=none; b=jv8exw5T62YH3/LLV1ygLFmJQ7PEpuVOMtKfcSL2Q9yURQcsEJpSu6OCeh7s32jW9eUnQf7lywg/mzWYP6DtnDlIrsRxDt8eTn3RopThCGmPM8BkOOToUI+f1STM56A5NZn1khVcmT3qgxld8RT+Qf5akxGyfRyLsKa2ESkJoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428262; c=relaxed/simple;
	bh=1kAoqW7BTyiG8TwoD+oQDaeny5cbpmZ+hb+ny8H3EHY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svl2wdP6JZBm9fZXE+jEPPYdjraVJXez7uLi3h0kBsqgwzZqMYi0ka/8gEar6Rp3/PMGpua/JLmlm3tTwjw52aQvVcL6av/Ph2B/othbya4a01dH+Nu94B/xgHeWdomd1E59Kql1w7UmIf/CXmnHtWuQtRxPiS9aJT+ljBhvmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjvIQR4V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjvIQR4V"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2154dc36907so29325ad.0
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733428260; x=1734033060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CSUQ4UVDPZgJkxhql9rzztvLLKUSp0z4z1BtACvVT+E=;
        b=PjvIQR4VwEpWbm1DdgxSAPprzrMapDjUxKjmYDfk4NW9B557pzgGcCuAb1/Taz7ruj
         h+LU//cItO5P+LP7/WALVL8ADb1GqceWt1dHCuqFR4CW/i0EpQsKdFizQGeIijOPVurf
         FV2o7d4F/wGIsX6hkjEkyxSfeeIzdc3InG8h5kHbeOMTQfiWGt2K3KIlZ2gR3E2FEmGD
         qhBZSGj6O+/ByVJMZSz87fJRqfOuX4kUA2LUVsK7exOFK8iku8ZnWDBLbJj8fsl/wxxb
         /7NIvPLywjYkl9rpyHL5/2XmMfsk+gHALuGaAWkxz0eVPuFnD57BIpOFbV6RveZd7+N7
         BMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733428260; x=1734033060;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSUQ4UVDPZgJkxhql9rzztvLLKUSp0z4z1BtACvVT+E=;
        b=MxaIJRBzVad+tRAsUQovNGmXgrW9lyDjpEmqCfeV31vJd1p7//41KfJapu/yBj/9br
         feSIvFVvIOf0qzFdG+MGVGJcbG2rGc+ekXK+3Hveu+bT0sKHbWhRSBtr+t6g5xhqz3cg
         vqIqbL5zNsRvfqVoRnSVvB+gjelG7o91wQ3ArPDreXZQPrs1JfyWyNLJxVZGEFsIvkMR
         yDqfaQw2r9xp1VrIb6sy9I0HzInP1XQ//X9S9UjwRSB8Pqfq2xVWGuov5gFm6Arlfw4S
         nFSMbBswIZUwwBb+HFJ9kBBaRiGboF4qfMdYfxN0A4Ru+AzS76dXm1kV5nnrJLbNKwMb
         Expg==
X-Forwarded-Encrypted: i=1; AJvYcCV8BJdDnrgqWZEPOHM/Z2ihLCQbMj9gTmIPSNlSnKl+GeWcXccd9yzUI30/GzSBLUajRdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRbjEgnLuMEzsDua60tDETLXQm/LORTxDJCPJVq57wqHK1XXMc
	oy6FXem52oVVGZJ4BhNfc5BV0+gKO72ZH6h6+rSMEPBKyUDOlHCgfpJtOTPg/g==
X-Gm-Gg: ASbGncte3e+VYab4ZYXfF5hnJH1VpNYUz68QaUO2N1fzgpAPW3XjK5uk9wdigCY1l0i
	vyQ+61KqWAXdIhP1kOA3PXl+U/iMQxfUylliPScT2/XqJK7OUurip6VhbKVzV/w0LBrslbidZuU
	yWIAYRgh4MO1VdIVy45uQ09yd1zAA3v+5hm8VAUxiOnTcotO9iK9BJLAP/RE2crECpAnVelcGpx
	gZ1fGQJZlD2eEH89vwjgtfXSz0o+vVmxfZ2ht6mQ5olJrMK
X-Google-Smtp-Source: AGHT+IH/Fytswlj3Ulvq3EKfQ2fgRC5H59oVl/jax1z/Avn2LqdN4cds9w0xbteT3qWNMW88X0Y1GA==
X-Received: by 2002:a17:903:2bcc:b0:215:b182:ba44 with SMTP id d9443c01a7336-216138d6e94mr213265ad.27.1733428260061;
        Thu, 05 Dec 2024 11:51:00 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:80c2:988f:e15c:5983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f15csm16167585ad.76.2024.12.05.11.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:50:59 -0800 (PST)
Date: Thu, 5 Dec 2024 11:50:54 -0800
From: Josh Steadmon <steadmon@google.com>
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org, 
	phillip.wood@dunelm.org.uk, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com, 
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, jonathantanmy@google.com
Subject: Re: [PATCH v15 09/10] fetch: set remote/HEAD if it does not exist
Message-ID: <444kgiknevb3kwtypjjc2glryaav27t5fafgyzqq5257w7o4pf@4fngcyfmvfcp>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, jonathantanmy@google.com
References: <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241122123138.66960-1-bence@ferdinandy.com>
 <20241122123138.66960-10-bence@ferdinandy.com>
 <wmu5ld4xsfjz2tpp54jmxqroma423t5nn2jh3q5gq2wswr6fkm@vrlhigyuxfzu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wmu5ld4xsfjz2tpp54jmxqroma423t5nn2jh3q5gq2wswr6fkm@vrlhigyuxfzu>

On 2024.12.05 10:58, Josh Steadmon wrote:
> On 2024.11.22 13:28, Bence Ferdinandy wrote:
> > When cloning a repository remote/HEAD is created, but when the user
> > creates a repository with git init, and later adds a remote, remote/HEAD
> > is only created if the user explicitly runs a variant of "remote
> > set-head". Attempt to set remote/HEAD during fetch, if the user does not
> > have it already set. Silently ignore any errors.
> > 
> > Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> 
> At $DAYJOB, we noticed that this breaks `git fetch --tags`, although I
> haven't had a chance to figure out what causes the error just yet.
> 
> I was able to bisect down to this commit using Jonathan Tan's
> reproduction script:
> 
> rm -rf test_tag_1 test_tag_2
> GIT=~/git/bin-wrappers/git
> mkdir test_tag_1 && cd test_tag_1
> REMOTE=$(pwd)
> $GIT init .
> touch foo.txt
> $GIT add foo.txt
> $GIT commit foo.txt -m "commit one"
> $GIT tag foo
> cd ..
> mkdir test_tag_2 && cd test_tag_2
> $GIT init .
> echo fetch --tags
> $GIT fetch --tags "file://$REMOTE"
> echo regular fetch
> $GIT fetch "file://$REMOTE" 'refs/tags/*:refs/tags/*'
> $GIT --version
> 
> 
> Prior to this change, the first `$GIT fetch --tags "file://$REMOTE"`
> fetches the `foo` tag; with this change, it does not.


FWIW, moving this:

@@ -1643,6 +1703,8 @@ static int do_fetch(struct transport *transport,
                                    "refs/tags/");
        }

+       strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+

to just above the prior `if` block fixes our issue and doesn't break any
tests. However, I'm not sure yet why the order of ref_prefixes should
matter here.
