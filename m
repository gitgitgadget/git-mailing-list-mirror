Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1F41A91
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055869; cv=none; b=Al2a87qWqpcniJP9ip2T57JvkuQTMpmS0VoD5s9vGbtVMs7F4+CoZvn07t+olDhGuhuCAvtKP+WZJu4BhSLk/7zefiGFsBKLJ94NLDFWGBelIqwa8wO3/3zPdVY1i8s1k+NUVKG6Z4yDMgPzKPNyiEZs7T0Gr2FK4MIXjivRJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055869; c=relaxed/simple;
	bh=NtXtxlz5AZ7TG0/xltymD8z2SdZyX8JSfsDhGwl/wYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMKGPtlYhmlXLQM7yZ6YLOdXQK6EcaRIeE5GVVLXhTrnv2Es+iEotW/UWAI7wYBuDQ7e/sGDeBo8gpMvYbBfgwQLB8NKiPIFGcqQtCef63trcFhXH3M92aHnwthdH6xdGcqrRiFcJWfqK/LZK7Qi69oR+wKYrmopJ9MEcdlrLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIkR3tPK; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIkR3tPK"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2330f85c2ebso703986fac.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714055867; x=1714660667; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSr6DxNb7T7AYBZ5pONOE03ZGCEFxiBhYUHktG1K/84=;
        b=WIkR3tPKM4Tzoy2XmXNXZitgmB9FEzmkNfELNtdUVWwWA9i5LKjx5Fc58LxPGOe8DY
         g+hGd40BKGezOZDm0ZOxAeK8pSumi5mWuWbPeljxxrmazi3wY8PgefNH0b00/syHsfer
         o0fsi2OYcba2ZkG+spwWDMPgaNi8690ICWIKBYy+7xfjkVrn1tQwuag+qTkd3gaMIkop
         CFspow5DFtcqp50EZhs/m58baUhtNPVvWe6Cz3kIpUBpgnkzvOa/Fhq+KThSYgpDGkJY
         3CI/CWaeI2ijOO3ih9Zk5SEdzMhNfkTLkTKS+MjehCorGqfGSgqKZyqLjEna1L6vwkRf
         Sstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714055867; x=1714660667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSr6DxNb7T7AYBZ5pONOE03ZGCEFxiBhYUHktG1K/84=;
        b=qB6MlFfaeB0VJ47qwBYItkOcID2+IhY5E74WQCC7uN05yrwlotJCdBU1eze21jJTuv
         uHeZqzjP6e9P/Xe7CrWVIxTlhQd9cY9MwNJX4tYCYRf4hdnP/gc8JRjPx6gcDI3BMfWb
         uoU3JjY61DhjEzPaer7gKbzV9i+uRhWEbBqyNZ2LBVYy+fVD1LtaqPjxJB/qpwiupm4Y
         XZJaEzb5K1j+JiAVWstUphVQiFgP+1VIm2MPCYJOw9lsoVeWFCbKNpWWYTHaXVdkHE19
         JIFecfSV57jkzFe0TDb9DTnPc+kPYP7LAhHxQpxogU4noQmfYcfDdBNvXmT6q5NewEt6
         WQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCXCOpwnlCNmCJdlApqyp83NM7I1iV9xJVUTFoOWPr54hdOxOdGi+DqjmZroDQNzOsXrDNKwjMFMIVNRuePn14NVHKtg
X-Gm-Message-State: AOJu0YzXua5cT6LepWc/bkafIfLi8D51GoYSS1oETOE6SAxp1cj0sHzw
	xYn1y47OpTVo4kHi2JMVaCNerLenzQs10WUrP7yC8zRhqUUWFw8hYEng0qUJ
X-Google-Smtp-Source: AGHT+IG/CqIcbkOdeRSLDlca5x1Yb3Y/qgnzlSdqXPucneARtuSkX3qdhUWbqv2hU3K6n0dnmQiQ2w==
X-Received: by 2002:a05:6870:40cf:b0:233:a2c:470e with SMTP id l15-20020a05687040cf00b002330a2c470emr6053949oal.57.1714055867409;
        Thu, 25 Apr 2024 07:37:47 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id pq4-20020a0568709c8400b002349fc4cdedsm3259821oab.49.2024.04.25.07.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:37:46 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:36:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Roland Hieber <rhi@pengutronix.de>, Junio C Hamano <gitster@pobox.com>, 
	Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] completion: add 'symbolic-ref'
Message-ID: <mg33zswrxwxrlbzcvxyssxpqty5qxbezw43rwwnkepskne6fmh@3fypf2gskbyh>
Mail-Followup-To: Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Roland Hieber <rhi@pengutronix.de>, Junio C Hamano <gitster@pobox.com>, 
	Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <20240425101845.708554-1-rhi@pengutronix.de>
 <4ea09a34-bd62-434e-b893-8e3780aa915f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ea09a34-bd62-434e-b893-8e3780aa915f@app.fastmail.com>

On 24/04/25 12:45PM, Kristoffer Haugsbakk wrote:
> On Thu, Apr 25, 2024, at 12:18, Roland Hieber wrote:
> > Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> > ---
> > PATCH v3:
> >  - make use of __gitcomp_builtin instead of hard-coded options, and add
> >    a test for it (thanks to Patrick Steinhardt)
> >  - add empty line between test cases (thanks to Patrick Steinhardt)
> >
> > PATCH v2: https://lore.kernel.org/git/20240424215019.268208-1-rhi@pengutronix.de
> >  - no changes
> >
> > PATCH v1:
> > https://lore.kernel.org/git/20240424210549.256256-1-rhi@pengutronix.de/
> 
> You can use `git format-patch
> --in-reply-to='20240424215019.268208-1-rhi@pengutronix.de'` in order to
> link v3 to v2 (or rather: you can use that for a possible v4 (points to
> v3)).
> 
> (I was going to link to SubmittingPatches here but I didn’t find a
> mention of it there. Apparently I misremembered.)

There is a section in the MyFirstContribution docs that mentions it
briefly:

https://git-scm.com/docs/MyFirstContribution#v2-git-send-email

-Justin
