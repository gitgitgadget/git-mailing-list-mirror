Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC811E25F9
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759961109; cv=none; b=EzTgXrdMeBaPAb/fy9qvyewgniCU7bqDE6QDcmXbgKD8llEXVYBO72aPxFAXEfxKAjHIAOMimSBMmZSo2+xh8Eq0uuvUYSiFmdW4H4obpxjPTzlB4YsUNHOnxVSR5kmG1n+QQjZhQ2n/6QPHaMQQP/A85dx8hnj+5GomFMretds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759961109; c=relaxed/simple;
	bh=ALMsOK8+2dSfBRhnWyjcWEvJo4J5eKPIJPNWoze1IdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss7eWzS2tjQHpK9QDR8CCsPkf60c3PHdFpS9pbxTRK+wN87QZQMz2wwgTC538RZbD++psFmWNGU/ADunTYwHehMgmQ38qtB/u62cfTJ51hrToUanFh3UErkdbmhke08+jQu0XjYiFSnQo3fqOIajpq6lJewU4X2LIS1pmu93nZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ktS4Kwqu; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ktS4Kwqu"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-90926724bceso24573439f.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759961106; x=1760565906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlO907U+PJCDdNdqvKs1bRjrHB0A/ZgIg3gVB6kkNGQ=;
        b=ktS4KwquYUqstZGgb9cHgoZV2p4a19nob2+x+flXuiRHAGMrqtI5A1LcwDv8epQnR+
         BlQefw3wR54ylO2ZxVdvPUXilxez/RK9ZF5tYiIJ6FMm+Ac5u8+3o38bCrCTWVo0O3il
         XmfjTy3/9L0zVOi0ZGOKY2e3zMMQRuAzJ3SpwhxM2/1sxvBQsW840+PGY6e26DNYmNjX
         Foz4VmXJe6CLeV4r2122qcPYxJ9JyKJorKeJY+lN3qYqXseACqZl/pGii00coZJ8y+Ct
         QpfQqEFuFkHBTGIeB50Z92gQHmhorEYmlcDWChoSP0I7WP1pIX8LkuaLjveTMSJPuiOz
         ar/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759961106; x=1760565906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlO907U+PJCDdNdqvKs1bRjrHB0A/ZgIg3gVB6kkNGQ=;
        b=AR0rJevhqGpNy1Gc+DeEXScsNhEPpTgZjCqNvM08eECvadlFmcIt3/3+adeopZ5xVj
         HrQ+zfu6RSi6g3Bj1X1GK50JAMxSqKlKWsUjaq8g1ybTtRWIp7tvt8Sty2pdwAtFoN7g
         S0rgVjE51mGG9LhqF1deWQ/msw90GQyNOHEzuVP/xacDB1N9g/jCohfGkuyBIadcdXlF
         6WK+qFa3THgEmqC2JVhk8KSMwHEDyMafUHLh+b0mmQM6oGkwYy3DOxIvrQ0KX2AFuBUB
         7ZVZJixW1mzE6izTp3xaENdNoKD6bVvMrK8yn1mqLD1c015mOG+S8uoaT+GtNFHjfmqN
         5dQA==
X-Forwarded-Encrypted: i=1; AJvYcCVp0EVf1sUYY95znrsj+g3hFl6nuAIJhFOg8mu6U7hUF3mfjd7ntaaS47yHGAvMHPeK9ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzysMs8V6Z8z8tNSx/BO75Tn29/g0zQPgH/hCA6hAnXIU3IlTR3
	cPDTuiLM2ghac6t2PY/bHLIUOH6pFVWs2WvN7Nb4zZ9NMQMTqH91b2/6mA8GUZJBTj1g/CVybpP
	t4wsBj9+f9A==
X-Gm-Gg: ASbGncveaUE0vvL63V8Yt3xPzSs2kiSVpj8T0hJV/vHExExWDZJuFxIwW665epX46H4
	YNzQDW8qc6PZ0kmiSdJJSuiElTvyxuzsEe4POAbk77l3R3oL4yHuuRxnIFmP5ZyIpAeuWpyu7n7
	fGTNmUE/77W+Ell3d+MS03ebit6dYqWAABDRfZ2XzGTVPuDMtKlMeZy/TfYmmbEyC45Uei/87n8
	1nG6+/lxOd5co84wLcbXhd7lJ4pmUeBhzYur+e78VPOuk05OtG9QaxbNDv4Hpu82yTJN3bjSN9Z
	WTUCokiLLRs5FAE5ib3C1VJ8WvxjU8rRjBYyKwvJ0wiEQSfBwweExgmYGp0ES/zDHL36jPYbQmJ
	2hXyohflEgQ4mN2nU1AwBFptrR/RODFScBwTt0DXIfG9ykxg/3p1iKaHqhtnsgisAXlEPNzO/lv
	VMh0qW+zk36Vfu85zEoq8ZlmZ+x33PlYDFVCdmOU5EBFvXcl4Z2Q==
X-Google-Smtp-Source: AGHT+IH822WCn/QUDM3ZLLuxFw9yoUfMVeNDd/O0gDbpQg4eUHlhLzZQe2BPfYePHZZcJWO8Jf+IQQ==
X-Received: by 2002:a05:6602:26c8:b0:887:131c:dada with SMTP id ca18e2360f4ac-93bd18a1eafmr603062439f.5.1759961106485;
        Wed, 08 Oct 2025 15:05:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93bdb306b65sm33163839f.16.2025.10.08.15.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 15:05:05 -0700 (PDT)
Date: Wed, 8 Oct 2025 18:05:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ben Knoble <ben.knoble@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aObgEGjcou06nP68@nand.local>
References: <aN5-n_ArhQqaQZgt@pks.im>
 <D59D0576-63C9-4144-B49E-54D43A80E0B0@gmail.com>
 <aOTrBAXhKF4iYzQB@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOTrBAXhKF4iYzQB@pks.im>

On Tue, Oct 07, 2025 at 12:27:16PM +0200, Patrick Steinhardt wrote:
> Yeah, it's definitely my goal here to do exactly that: reach out to
> folks and take everyone's input into account. Once we've got it, propose
> a timeline.
>
> I guess as part of that initial communication with the stakeholders we
> can also mention that the current plan is to release roughly towards the
> end of next year, which may help to put things into perspective.

I am not sure what our proposal would be other than max(proposed_dates),
clamped to some reasonable range that we are comfortable with so as not
to delay the transition to use SHA-256 by default too far into the
future.

I think a more interesting question is:

 - What do we do for implementations that do not have a roadmap, or
   whose roadmap is too far into the future?

 - What do we do for implementations that have a roadmap, have a date
   that is palatable to the project, but end up slipping and are unable
   to meet that date?

I generally agree that we have to draw a line in the sand *somewhere*,
but I don't think we should be so inflexible as to say "if you don't
have SHA-256 done by X date, you are out of luck". Of course, if the
amended timeline is too far beyond the initial deadline that's one case.
But if someone is a release cycle or so behind, I think it's reasonable
that the project should be flexible enough to accommodate that.

Thanks,
Taylor
