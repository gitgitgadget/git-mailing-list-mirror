Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A71DF755
	for <git@vger.kernel.org>; Thu,  8 May 2025 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672306; cv=none; b=MxPHpN/DV4ug946GuLXVZr1p9hynE68qd0kI4qr4rllzDcbGUryIVaacfYNW/QJey+Q9WU3RMQjJLmcrSL7qgni5hyYRctIhu6g54tomakj+vnUaD4GAIRA9XF/tipiLgadUrrebfJaxyNjJad3ol/1lzb+deLwPBLM+oiD7BwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672306; c=relaxed/simple;
	bh=yq5JjPUWVtfx15i1PfjXnb3AywBYI1S8dzs/oiZhPw4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLR3Kt/5N8qKyIP1Ra/p3iaFOpArdnoEek1lQLFQXvL15mS1TA8ls2KWGja3G33RnJ59rRfvay6XvPansbcb1DBpxS3APO2FPDAbLJGwD5CAgrj8jkn3VFf5Q35ywGLIk5vm9EvtpfIe66VTIoO5i+qEz0/bs6lB1BoAe767VmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GteNWvD2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GteNWvD2"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5f720c717so197568885a.0
        for <git@vger.kernel.org>; Wed, 07 May 2025 19:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746672303; x=1747277103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1KFphz4Idhh0yrB+RLrkCePUT7QNxfSloVz3K761YU=;
        b=GteNWvD2I6OusmP3HP3vVgIa4tGkRx+3GzDTOENh+z8yIBi0kPRWC35yceXTxuXsvb
         I9cpbSO10ncEOhjlLkV4nr1++lwjG/KN9HHLtmIVHH66CDBa+O6orEjxW9mTXgcbcgmO
         NP0kqw1rN+T1oEEFgXEk2zjufmtxyVKcaijf5AWHqQv9znjCIUG7z55dl70NGJDCSsnN
         8vZqamBo0F7zYnm6lE+a4kfUg+JWEe0hOMpkCiOBRG3JszlT+v3zZ4MblLXTOrfo213I
         QKMZcHzqF6/gOJNzFoLmniUUpoR5dtXp/LzAzRTZZm6VPyTMzwFVxZx82FDtjJwU4OeM
         n/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746672303; x=1747277103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1KFphz4Idhh0yrB+RLrkCePUT7QNxfSloVz3K761YU=;
        b=DqoRURICvM0kTOGFPwEjNLDr0HKVkshejL5QWfRLiLjOfuJpX8lXjXoIp7qIyWDB9H
         kyQP0nz34eila1jQo32OSQfbvYIv5sZA+Z14oxjQimpGvdxU+tUigBesvAHxIIV4dMAa
         RgJJtPzDXd1aX6QthHQz8seH1+u0TPnJApmPRCwttdVx3OKnJnauuCDMP+lh2ycLGE3T
         ASvUyMJOxUbU5Hjh+0pA4cH3qQorzAtE5lTj8/vJVEMW2rbIm/lbtOnDQBvQv0rVB8Fa
         JmMJWhYn5HizmlREyGLc1ldCi1Jt9rsVO0gI3JCmx604xfBb7Wa140Rnpqtki+uhpCpk
         kz6A==
X-Gm-Message-State: AOJu0YxpoBO52ThVcxOdmaG9ujj3/aLbLEfQukv1Z3GXT2UKvxrrvMnX
	xs5EQ6FO8Zof/2bKrC0ZSJO5RC/Y4cQ1jFZZNJEzbpWrpRPac9zjwrTuzCtIT7fJ2uPr1wRzOCg
	9
X-Gm-Gg: ASbGncvykhpZVJx/6KB7EOagegLXB0c17zkewjVQYUQ0aMP1Aaop1AsIUS8wl5ybcbF
	6Z+SovPcxFMSqtTH8er93x4rX6bgtJA5uF9Vu4pqTT4RGtaVZwsoG3veOMfWvSF3ZlrCu3oBW2B
	pX/4izO7H9lunNEQ9d0NgqbyoG/LBtS2qjEryh9lzbJuTEa2u4GYHcH+0Qqbtg0GqfVUWU4d9pE
	43PlnRPSmo6a9V0Z5EYhD9s6+B3/zO2kpV18tPq3Dg2jE9jSa1LidUA33b4ML7t6/+PRqc1S+Rp
	IH0cctbRM+Uki0NN5YfAjVO2rdHAjH4u08TujioR19SGIGdik6gP7TMjWHaF+JDbcZOgTPgECzx
	Tf0BWo78LNMl1
X-Google-Smtp-Source: AGHT+IEdFMWEmGMCbYseaCnfaL03OR0rkIrhcHZ5xK3zCi49HFwxKQB5aafpkUuQL6b3RcerA/lTQw==
X-Received: by 2002:a05:620a:4250:b0:7c0:af6d:a52a with SMTP id af79cd13be357-7ccf999a808mr271606685a.26.1746672303333;
        Wed, 07 May 2025 19:45:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf751e730sm275250185a.9.2025.05.07.19.45.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 19:45:03 -0700 (PDT)
Date: Wed, 7 May 2025 22:45:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git Merge 2025 CFP deadline extended
Message-ID: <aBwaruCTGWEUx9ho@nand.local>
References: <aBwU8UdGx8bnZWdL@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBwU8UdGx8bnZWdL@nand.local>

On Wed, May 07, 2025 at 10:20:33PM -0400, Taylor Blau wrote:
> **The deadline has been extended to May 20, 2025 at 11:59 PM (UTC-7).**

...and just in case it's useful, here's a link to the CFP ;-)

    https://sessionize.com/git-merge-2025/

Thanks,
Taylor
