Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CB3D9534
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265252; cv=none; b=G4i2jGXGo0NnceJs3FEw+zNfx4VyfjNZOzJuH4lD2NO3c0ggjOHDp6FeJvs+YFzjP4S2NZbA+pzMiuYTqAWQG8+DTPG4tMxH2l3YrikrghvBUKvh9HM3dsgQ1hcjJUXM6TkGkIeVQEWnbgHu/ERwJ9HQU9pppoIIQXdp7nk+rOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265252; c=relaxed/simple;
	bh=EIyg2pVLSWB49WYyKB1fKxE2UJW9U4jXZtgrJ7muzEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc3XjeU3dShUfFJBwHylkdohEpIdH3ARD3KEptkVDCG+WlePkf3sI5owBxbCRO5fhtz2XGeGgWQVEgOPFWC/lrZdavLzpYDkDPR0+J75fp9oIPdoWB/qG+ARrM6rstTwa/v4ih/B0LWegzkFcsdpdA0epDrTO8COBCsL5fTgjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1ki/R1o; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1ki/R1o"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aae244ef49so150268eaf.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785265232; x=1785870032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftHt5FVyaUlSk1nwq4WkVfcaev3wH6uAn5XqZq0iDiU=;
        b=L1ki/R1o9ZXqadUvr9eTpQ+RK1EN8NeGQZ/a/4g8DyOhCeFsxqUow8yup2Q8SGzvLR
         iHewZoSrAOsxfdcWZgQClBKm+kbhehmNTF2CYWS2nlV7FhsWxWWw1ZHScl4AQFS0XIAM
         6vkNZre6xwGs867zQmWciXTCNAum9GVRxRE7tKQNJamdu5ShNtp43vDniU13x9c0AEgr
         tKKLDsZew14axIz1WcTCwMrago9/axY+D9F1e9wRhe1UeCbW0LC74iBED8snpWqfJH7T
         1nOZ7ZnMh933hHirPq2aVzcNVg5Swjlh+UM/5AUoxsPAxmw1WCQN3uHSRYuObTRv2Gb7
         +IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265232; x=1785870032;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftHt5FVyaUlSk1nwq4WkVfcaev3wH6uAn5XqZq0iDiU=;
        b=qOM+6pIeo3yEuazsCokHIAXctmxmX4By/IF/7ijr5r6WysV15g14DKvL5/U+Xgsr/W
         pRhJdvRfvlfMVP0XYVXV+o94uW0Hqgm8TXFTqRoUGvjuLwP4u5VK+p/4MgeTnRHZ4hob
         KxkRrEbGFVvN4BrvUM2jVVnFCJhgWXOXA6zfqlb0qOphcy6gosJBa6oOH+CO1OFo4HmM
         a9TqvliDj+diqTTTSO6WFdd+7qLeE8gPidpbIFmyjzavL9+qg4g5wtg4IV9VaEUq99H0
         ET9Onb8JeTMwmTa0wJjJt6z+xezUBzzPG6uZvuzcNbDEgHn/AxXutqmOT1l+Xp8Kla1T
         l28g==
X-Gm-Message-State: AOJu0YyprpMtsgk2b3bhuXP81CMVnMo+D8/Rnm3LWgZPnc4cA6lBCwQJ
	ieJaMVRnssRfDPhN8OXSsehH5qLwK4S04jSX8GKG8UC5hRb4cO5nXV/d
X-Gm-Gg: AR+sD11c6efohwZN/ZWuegz3kzTb4hjBLIi61/VBKQh+nPuOyHKaZC/kI0C22DIsPYx
	1ABqX0yiMfab0BwH/s0eiImX8eP/vdMfrJ1GJnkquIHhtgnNw/hsT1BjMFgqXnZDxsr4XgMdpIm
	aLRNMqyvo8PmMrU77RmYBR61QglcS8oK0S7+yyz4qxdl5VjBxwjqQHKiJBavXqzL60NxCk/ydmH
	hVC3VNw2kj3iTdmvjM4w/sPV9EmZvsqxiT180MTZBPuYB34d0Cgm5HhxIprjfFYgqMGQbP/1X0M
	iaD/RPN0qzMhUND0SIz+blVrPnIXojZm7AP0NpNH8v9Yc6kiHSwLoJ+q2Jnp8Ikti0uHdQqV7Oj
	ujgU88IUw831hiToZI7p36E4Uf3YUcF/N533NkYB5tqj5hdvcSqZTjEiZlS1wO3gloTPfiUw=
X-Received: by 2002:a05:6820:f007:b0:6a3:7a25:c084 with SMTP id 006d021491bc7-6ac96de16ecmr1866737eaf.69.1785265232270;
        Tue, 28 Jul 2026 12:00:32 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aca5254057sm211606eaf.4.2026.07.28.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:00:31 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:00:29 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 4/7] repo: add path.hooks with absolute and relative
 suffix formatting
Message-ID: <amjjMwAHSbkQgtPb@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-5-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726104343.16933-5-jayatheerthkulkarni2005@gmail.com>

On 26/07/26 04:13PM, K Jayatheerth wrote:
> External tool integrations and validation systems need a stable way to
> identify where the repository hooks are stored. Currently, this involves
> relying on `git rev-parse --git-path hooks` or querying `core.hooksPath`
> manually.

Similar to the comment in the previous patch, "External tool
intergations and validation systems" seems overly specific IMO. Also,
"need" is a bit strongly worded as I'm sure its not a requirement for
every external script/tool.

> Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
> `git repo info`. This allows tools to discover the active hooks location
> natively, ensuring proper resolution regardless of whether Git is using
> the standard `.git/hooks` structure or a custom `core.hooksPath` setup.

Per hooks path documentation:

  The path can be either absolute or relative. A relative path is taken
  as relative to the directory where the hooks are run.
  
  ...

  You  can also disable all hooks entirely by setting core.hooksPath to
  /dev/null.

Should we handle this /dev/null case specially? It looks like:

  $ git -c core.hooksPath=/dev/null rev-parse --git-path hooks

just prints '/dev/null'. I do wonder if this makes much sense though in
context of the relative path version of this key. From some quick
testing, it appears the git-rev-parse(1) version of this option always
prints the absolute path if that is what is configured (it appears to
ignore --path-format). Maybe we should just special case /dev/null and
return an empty string? I'm not entirely sure what the best route is
here though.

-Justin
