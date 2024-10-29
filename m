Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058120ADE8
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240360; cv=none; b=NxPdy6Wa0AW33c20xV1n2jzFhpUdkodNdoKGcX3u1f/4CN74ZVLVhJmGg1U8cEvwnkyLkIP/Smz0OuqlYNeXVtp5dA56hGpdvr0DOFdpOj1E2X7AHnA+CLs6L9m9Emf4EFDKrkZdbw2EJYygQNe774fQIAH3Eauom6mPajlru7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240360; c=relaxed/simple;
	bh=ekfwp1eEH8SAz6g8LBX0KepvIN6fV2WJO9VBfHF4E0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEYkoqkA+7Vlpm18PFGzbWy0RF4wzGUAgXMnG9Lhy+UXxTgcn6nP/wEuIef29NWKZLcJqKNu6PmIvYLFrEVOxE0lrFwDkg+B3L5Kyyo5UvBSHE62yyJ4UrG+L94XE6w3ZrocyRLcF+E99+xorDP57IFKbwKz8PD5mJxaKOXZWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zb0pqYHL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zb0pqYHL"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbd550b648so43762206d6.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730240357; x=1730845157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=627RpEAoHjMlDliN5h6Pe1sqVWrJsu6yIO4jINTTybo=;
        b=zb0pqYHLpDqHbdXCMB+CgMeuROqWH1oCdSH1BTo9k3sXWsMwHAmF0znNUGLJBCY7it
         iL+vIp6S4XVZNYUAyqXbBKJ/9tFSQ88lufLMsSiLLEAwofMqUWjBy+kniN23Ug3PwR/4
         KPmJM8Kwowb0oIX7mZF0Vp9o6/DMlt1AqWoPsxsZV3w2JcaBM1BqIhE4MQnFc+K0E6gu
         +kNaJ+tBrWAshI7BoXz9U239votcFPwEnnFqkQSJOYeDtDOiIZbcQ2rjSeeJvPGJOuEd
         Dh4ZOLJqOcypNHmTwkXGbgQC0n14OngGZpCF8hskVUXxgtQvxWkG5CzB3rOWJKLQPijN
         R0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730240357; x=1730845157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=627RpEAoHjMlDliN5h6Pe1sqVWrJsu6yIO4jINTTybo=;
        b=T9T6Vv+PtdnsIOh9Jq6JvEhgOTyvT2aYqdA+5FGkcqW3u/8NoatzGcyi5vMFZtBWfd
         zgwKm/FNXpk9bXP1aRpyCdYLmHH6nfxaZejKMbYR2nNmGItlZIisQ8S1UFW34YiCjXGD
         6SCljAU/9NEyzfnHsFHMBk5LdoEa1ctRrObWf0e/Y4TGQq0qi2RUFcTe9O3PyZVTiPD1
         TWrWD7FeyzGFWqlPgA2tWh95yw4EF40lGFByOWOQU/tVpuDiCdQOS2xg+lXFRuhS5oDi
         P7rZmlWQuOw4A65g102TswhpN6ce5TnLIDGhltxKfeC9BQw34Pyt9+1SPd9010bqiQmT
         CRHQ==
X-Gm-Message-State: AOJu0YxUIaN+wM18SiOERgGramYZKEhkbIi5jXzblWx3u/x4KS8L82Rf
	YDh9mL4LkGJHGFr/bLzTjwiDf1LcHOIFwO9YAV56ajZCjxIZYQ5alRoU52LFUvo=
X-Google-Smtp-Source: AGHT+IHxvwUmg39U79E0fljIXvoumsegJMPBzc0ZoAb7dEuNIWjfFAL1EFWGaoSavxEXj90BPLdswg==
X-Received: by 2002:a05:6214:4a07:b0:6cd:f2ae:5b49 with SMTP id 6a1803df08f44-6d1856f7eb1mr221580966d6.24.1730240357559;
        Tue, 29 Oct 2024 15:19:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f572sm46005516d6.20.2024.10.29.15.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 15:19:17 -0700 (PDT)
Date: Tue, 29 Oct 2024 18:19:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: Re: [PATCH v2 0/3] Documentation/git-bundle.txt: promote --all for
 full backup
Message-ID: <ZyFfYkOC7aic4L5x@nand.local>
References: <cover.1729451376.git.code@khaugsbakk.name>
 <cover.1730234365.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730234365.git.code@khaugsbakk.name>

On Tue, Oct 29, 2024 at 09:41:43PM +0100, kristofferhaugsbakk@fastmail.com wrote:
> Kristoffer Haugsbakk (3):
>   Documentation/git-bundle.txt: mention full backup example
>   Documentation/git-bundle.txt: mention --all in spec. refs
>   Documentation/git-bundle.txt: discuss naïve backups
>
>  Documentation/git-bundle.txt | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

This new version looks quite good to me, thanks for working on it! It
would be nice to get some feedback from other reviewers on the list, but
absent of that I think that this one is ready to start merging down.

Thanks,
Taylor
