Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199142C855
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="U0Nc74am"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc02ab3cc9so606876a34.3
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 14:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704406942; x=1705011742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKMgsWWr9Krk7bKPxLVo54Q8YJqEICITioYS3HvC1EQ=;
        b=U0Nc74amEu7RmFO7ug8NYIBWENyTwRgWRAi/lqyBT3rUOKQheE+2PYCYhtT2reF6W0
         AmG/0tlFFD5dbz+p9vCsUUZp4a+HmE7UIal5aOWFYGI0oeYIfL5C1o/QQJ+rmCvA0QHk
         +4IzjiWepBZSP1LBA+7UFB2WirP6KqRIhCLNZjW5PdbSJvY49JapjWSXm1cY8E/FZLiq
         YlAZm7s7hV4RCCg7ko/yZxtj+csfPKEdkVu8kVtgQF0/EfELqHb2/rDz7y4vHo34ggFH
         3WxV6cux2ZcKkpEN4W80Cv3ELL78N2gPtSfx6eLoCAAbNAZUlUlBGQ6Z3Isk0UqpzKKN
         8G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704406942; x=1705011742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKMgsWWr9Krk7bKPxLVo54Q8YJqEICITioYS3HvC1EQ=;
        b=OcZTMXuOcaHix6oQEyBlorJedwGotYZoSTAu9XKT1tOax2R/xyWsr6xaf2VZweC7kr
         NwNdgYaWyoUnCqsuaRbYdS57ebYNHbCJzYQwgBjZeFWUab8OrvJo7PyBQmyBBYDDsENS
         RYLnnO8u1SH6Vs8dLq7n2zb2euc0DQkTL60S62SmKvJBcuTpiByn0oCEgvUKe51/asc9
         +Pgn1rcL7/pFB3i8TwbKBms5fK9sYk/BZwUoozD/kZ3t3MYiMbcTl9Kj03LsogAe2x9b
         kawa/oJMzmBjfqQ8SvibjRWKGVYQoqpZ3ZdbWSzyHrZi0um1vTTM6srDnmE73/WvMW6q
         B4AQ==
X-Gm-Message-State: AOJu0YxOtZezd7DZKBBbbGpkW7KU1vdh97O90kbxrPFMQJ7KP+dkIIQT
	YjkdLObNhQBFb7rHDfTD+KDEYU2zKTDL0yfVVqL87Jc7H3pQFg==
X-Google-Smtp-Source: AGHT+IENAINmMCPpkasraV3dDjEzsokv82DN/K5Tb+L0vIyHjCrfGdNcP9sWEIvlRAANbA9SAnzCdQ==
X-Received: by 2002:a05:6830:3a16:b0:6dc:7837:56e6 with SMTP id di22-20020a0568303a1600b006dc783756e6mr1390437otb.30.1704406942143;
        Thu, 04 Jan 2024 14:22:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j25-20020a37ef19000000b007816d94195esm126268qkk.54.2024.01.04.14.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:22:21 -0800 (PST)
Date: Thu, 4 Jan 2024 17:22:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <ZZcvnF8wcOYoA8Dd@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <20231212081238.GD1117953@coredump.intra.peff.net>
 <ZXxy1USjjjAbBi++@nand.local>
 <20231221111333.GE570888@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231221111333.GE570888@coredump.intra.peff.net>

On Thu, Dec 21, 2023 at 06:13:33AM -0500, Jeff King wrote:
> But that's not quite the whole story. There is still a CPU improvement
> in your series (1.2s vs 1.0s, a 20% speedup). And as I'd expect, a
> memory improvement from avoiding the extra book-keeping (almost 10%):
>
> >     Benchmark 1: single-pack reuse, pack.window=0
> >     354.224 MB (max RSS)
> >     Benchmark 4: multi-pack reuse, pack.window=10
> >     328.786 MB (max RSS)

I agree. And I expect that we'd see larger savings on larger, real-world
repositories (the numbers here are generated from a semi out-of-date
copy of git.git).

> So while it's a lot less code to just set the window size, I do think
> those improvements are worth it. And really, it's the same tradeoff we
> make for the single-pack case (i.e., one could argue that we
> could/should rip out the verbatim-reuse code entirely in favor of just
> tweaking the window size).

Definitely an interesting direction. One question that comes to mind is
whether or not we'd want to keep the "verbatim" reuse code around to
avoid adding objects to the packing list directly. That's a
non-negligible memory savings when generating large packs where we can
reuse large swaths of existing packs.

That seems like a topic for another day, though ;-). Not quite
left-over-bits, so maybe... #leftoverboulders?

Thanks,
Taylor
