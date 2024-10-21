Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8B1990C8
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547844; cv=none; b=lcKN4AjxcTODUz7XQkkBVx/Ex4z/0RI0UFRX2L6LmpKg8K3GW+P2LCPOAQAwY3EzOIV1QA5SL3T9E12BnBzYYMf1AqWGZrmn0Djuwx+Re5YYsrHD8z+GEq5767cSrkzd/1gvx+0vhmI/9HwDxEI5nP8pqv+MXhKGBWfTR0cNpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547844; c=relaxed/simple;
	bh=L5XZqh1cOOgxRKL1n3nZQQakygNcQFEOdy8bgcMNzTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4RUHqaVZU38jnKEzG3LMb9PFvIttQ5+eNAOBHdyhff+L9zMnc7VijQCrV6ZfazkSV581ufxjIJgRbfIqvAvNE2YO28iyWnT8eauLo4UUz/k47D6zsoNTM0wzFf2Ei8yKii1WEcnRpo6SRfJ2kJskWtSpzor17GbkfSsWG3N8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0lQazrgJ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0lQazrgJ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e5cec98cceso26624667b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729547842; x=1730152642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZWgEKD1UfO7XjF+tKGdBA9TLW0lwbAnHhvDk7rEe8E=;
        b=0lQazrgJtW5M6FPvIf2P4RJpqYCoKoeE4mAFJkb9M/vpxVYOFSRID11d/CxougqkHT
         5N4+WV0M5Axh0egR24QzU0RGvJdWISxcYNatapvn1Q/HOc0xgLbvbXAWt9sY22OC7h9q
         ZgarB4cm95wlEhVar/x+xj/sHClS58xlfeR98VzLu4ne0y6ha/U7R6xPJZRM0xnezvCI
         So6czBW5izNOJ+VyUgvOXEqEpuhClThkLe41Io6CrwqabjsWzmucqTFfr5BTs0H5Cx/Z
         jlNrgvbBL+DyYMxLjse7Iq86SlVIh0bB1VQ/K7q/KdiNk/0h5HUjXe+bAd+t/wr2oDq2
         KbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729547842; x=1730152642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZWgEKD1UfO7XjF+tKGdBA9TLW0lwbAnHhvDk7rEe8E=;
        b=qFYrw5Fh/bqs6OMAJZ6V9N22z6FTjDKzlRgI402yEYGP78vpo9O6ZCpun2RZe+itKZ
         dmDsR2OPGPH+a8DskFRRwoJYO0u0cPLMuQHhDs1uWRrPGGZv9j2RWbS6GY6+xoWEOcRR
         krRlEQFUseGIkIE6awlqCIXRBpE2zw7IwKyGcHlJqYo0BNBbEdWtIi+SjQEfVx9T4BKK
         kRx6fnHwDwoK2gzSQ8mGVqhfQHmhUk10PIemANeNNpqq43v07JLRsnaH3Sdy2mBVP4yz
         4bsVDGBax60MVHftZ3KkaKfIEKp/cM6jHTGIjm/T4WgkUhpmd2SURoLZjp4AHH0qxgDt
         6KeA==
X-Forwarded-Encrypted: i=1; AJvYcCXA+uHMQ53bgsjYeaAVqQS7aDdGyK26BOnYmqDHyOV5Sjl5L2lU8gukLBZSYiDNX7azfj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/GnNuDzbjEmcoKCWdVIlEy6rttglScjthMHErtd5JCBD0Id6
	LemGP9iTqDQFfs3aKRYbAgAtUM89JGnqXZRzerUxSayYqSdCJijA5XBKrSUI/Bw=
X-Google-Smtp-Source: AGHT+IEYuIkXHfg8AeAXmbUMcc9gyzjYT+irZ2xCVNGv7Pm4iBeT29R+wQ4H7eMnJStyO/dxH5eN1A==
X-Received: by 2002:a05:690c:2892:b0:6d6:aa50:9267 with SMTP id 00721157ae682-6e7d82d7110mr4551227b3.39.1729547842398;
        Mon, 21 Oct 2024 14:57:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5912sm8357647b3.12.2024.10.21.14.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:57:22 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:57:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: David Gstir <david@sigma-star.at>, git@vger.kernel.org,
	Richard Weinberger <richard@sigma-star.at>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: disable lookahead on error
Message-ID: <ZxbOQXNn7Y5v2MPB@nand.local>
References: <771C9C4E-45F1-4F71-B3A9-4E8E4A9CAC1F@sigma-star.at>
 <Zw22sTxyWCbczZy8@nand.local>
 <0eaf6c1c-7205-4897-ba19-e5ba03194012@web.de>
 <7a51a68e-5f9d-4444-a568-9ca180bc4c6b@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a51a68e-5f9d-4444-a568-9ca180bc4c6b@web.de>

On Sun, Oct 20, 2024 at 01:02:32PM +0200, René Scharfe wrote:
> ---
>  grep.c          | 30 ++++++++++++++++++++----------
>  t/t7810-grep.sh |  9 +++++++++
>  2 files changed, 29 insertions(+), 10 deletions(-)

Thanks, René. The patch looks good to me, but it would be nice to hear
from David who could confirm that it fixes the issue on his end as well.

Thanks,
Taylor
