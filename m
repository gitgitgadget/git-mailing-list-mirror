Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550816DEA7
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982511; cv=none; b=eoEJ13aQuyhkD9KghIdqS29Jimrcb6o+4/z1AwYkZIU+/S3jBc2wRCobm9tIYSqvbUw/CyeWb9JhGWalHKOC39HRHU1r++8UJTDAGEWMCum7bQt9ITvT2ZwRay6PxqBwLoJXvNih9vD5vb6Pd1EA8OUaUB++O1joKOh68KyB49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982511; c=relaxed/simple;
	bh=LUfVpHE7EQQ36Ou6EJ7D+JHlQcX/BQAyZZ73AijbCmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlCXZkNxeew51C+hA06GlXD+Y0F2Ae6nW/s5mDoLkB4zGxnlAuy8XG9ZmVgf7AZNY5RYqUpFmxBDLsvNHpbhzffgjZloXP7w0SDMKxTPWmaUPHl1gUHS6W2R2/29Mvr31u7DrALMAWN/2HSBIiRkCklppUPbpfx8BJxVINSYDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8tTokaN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8tTokaN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e4266673bbso967615ad.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713982509; x=1714587309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44oEB5Pqft6blVG0Ozwi2FLuu4OhGYunyLY/rNDzir4=;
        b=a8tTokaNs+oP8jh/bP7NFenfHxUsdbK0eo3xy7LfyZ2WrZ7f9o/LYbyhX/4Ak3KHyi
         uflgMFnuwFn/QSzAM4pfq+qXrBMd5+Jkg3Ezj3oPHVTOTGAJnU2H6zWOaMrt5KHoSaOB
         51HaKRfsFnH20Fx9mck3Dr154JnHXfCtvzRncPv1g1VMN66AKes2rwaal9MIkgv/ESab
         U/SC2hHiIkFc3Ac3m+mAfMuNB01kbiCTkit9qmWNVJbSne1Rk2uVv7gx+DOzkrNTj0Xz
         1QbgyIxwAqpJGBJkfCOTo88JTqItMPVbomDAOozZrXT1w3ScWfpqDc0QcLJXn6Lmq0FK
         03Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713982509; x=1714587309;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44oEB5Pqft6blVG0Ozwi2FLuu4OhGYunyLY/rNDzir4=;
        b=QqprJWt5z/4sZbFkfgP9ts14ewaSweb6TGbkVpASZgPWCWZTQ2YyM3KKFGewCCzkho
         ju5wTWpk52jRFI6KN9GjIYgMYmjMUcNfnO2jTjNuTgkVk+FraR+dPc1hQUnicBNRzqSG
         Gdye6NM029pSAA3bZeu7HBBYrlK8/36AX6BQwvtZ3TiUDxYhSJ6viIegcxux2tFJT9m7
         kgivdwf6O5opRAnpXBQ41HNcqyu6K9ZSJ5RWpKLyvdjQuI7CclEjq+YkybqgiBYu/vdy
         KGbVO5h1JaGizIvnV+8QBI5Mpn6dUXUiFvWfhKWQnJwlzncNeFZeXzZpzYV7E4UuOPJ4
         MUmw==
X-Gm-Message-State: AOJu0YxlkJQiTAFVrAqsSiaH+pKf2eebSHxpvIjonIen2/rdSA6/QLuU
	mpFe/q8h9QFMTlM5mtZNIZ+9nPe18SULGPg0Gej7ecUl9xttDsrHdi7KXaz0LsH8twjnK3MkSSd
	ePQ==
X-Google-Smtp-Source: AGHT+IEOgInobyt+4GqhdSO6aFdPwRSFPYW4iaDD7FdnQ/5Y9HPwAvFYbCYGvSVP4YtLy5osSJhQQg==
X-Received: by 2002:a17:903:40cf:b0:1e4:9c2f:d343 with SMTP id t15-20020a17090340cf00b001e49c2fd343mr4208633pld.7.1713982508594;
        Wed, 24 Apr 2024 11:15:08 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090332d000b001e0c568ae8fsm12168589plr.192.2024.04.24.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:15:07 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:15:03 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/2] ci: also define CXX environment variable
Message-ID: <4srqrveqk2f5wwrkfivzx7ipj6txgsohdtl76ybyvg6e2vrrcx@gglr37gka774>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
References: <cover.1709673020.git.steadmon@google.com>
 <cover.1712858920.git.steadmon@google.com>
 <e55b6912725fa478134c7a67a9e4aeab7dca2c57.1712858920.git.steadmon@google.com>
 <20240412042247.GA1077925@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412042247.GA1077925@coredump.intra.peff.net>

On 2024.04.12 00:22, Jeff King wrote:
> On Thu, Apr 11, 2024 at 11:14:24AM -0700, Josh Steadmon wrote:
> 
> > In a future commit, we will build the fuzzer executables as part of the
> > default 'make all' target, which requires a C++ compiler. If we do not
> > explicitly set CXX, it defaults to g++ on GitHub CI. However, this can
> > lead to incorrect feature detection when CC=clang, since the
> > 'detect-compiler' script only looks at CC. Fix the issue by always
> > setting CXX to match CC in our CI config.
> 
> Since you took my suggestion in patch 2, this "which requires a C++
> compiler" is no longer true, is it? And I don't think we'd even look at
> the CXX variable at all, since it's now FUZZ_CXX.
> 
> So this patch can just be dropped, I'd think.
> 
> -Peff

Done in V3.
