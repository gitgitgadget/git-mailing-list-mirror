Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D8745D9
	for <git@vger.kernel.org>; Mon,  6 May 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025942; cv=none; b=eiI1LB+98i054fdlQfhSUMudwVev/8SMeqhOg/2CHf1h8HkD04OGhl9pGRoyE8sKhoaS4OKN/s9p6T2k+UWA+BKp5e9ijgTBgd/hq5z6YmSDloCs2ec3WsfGmBIYwX0E71P9gkRX+3RCugAteRgLU8sBNMRiaPGEEU+1v7ZVxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025942; c=relaxed/simple;
	bh=UPyM3t9iAc5EkiRMub2IaA7m7noFHv8VY0LDbIJFLxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9JSUV1hIpu/Ee/BAZOPmF3Iz8bOqSBiIgCI3oqK4goIJN6E35sI3AfWgXm2kBghnUoLp76AxK+gZjxvMqbb4VcP8bmcaUjaViFJ+SHNIZdsDHutbdeOxK7GbEjWj5FJscw3Rw2pvqgaVOS5DWVMnZBr3AnwfMRyPipICOMr57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=m9ULttt7; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m9ULttt7"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f04ec17bacso885317a34.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715025940; x=1715630740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPyM3t9iAc5EkiRMub2IaA7m7noFHv8VY0LDbIJFLxE=;
        b=m9ULttt7Wsu52wTNbETBj1zMZi5V6f+LP5A+HdL9yi051iA/6wdubdTgaVnRwCvJA3
         sDGPqB4O+3YKmqB5rFbiMtAOyquRSNMojqwY/1iWhrl4w5G19QM416unJcUS5R/BYYhx
         S9YFoSaUwcvED6mlibmoQ7o0HgoV66vndjiVLWbvkeI1jNXLoAh6jcEIHICBwQWPJi7g
         vwf2fqyXaoa8p3YW8mwMtm5oPm8flj3+m2eUjce5r+qj35E6MFO0eGwxa0KL4vo0FOPp
         ksQ+7Ne3KJxtE9u6BsLpWNUg/f+WkCpDe3qIaUIqYjf/7+vuhOpVnkHf1C4mtCSKzHZC
         zgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025940; x=1715630740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPyM3t9iAc5EkiRMub2IaA7m7noFHv8VY0LDbIJFLxE=;
        b=Z4PXkBLPaLsdJfB8dtgonQooXqWIi4AFJo0sW9USv1P995nREBJ7P+kPpsGU75lR+S
         L3JNA0HcJCCFyQPRwi1FQth8V58PctQApPf6AwMnpckiUG4gKRmq3B8ZIrJMlt/ednvR
         MWKYdRytX5YP1PfNH1+FtNFzDftABCpow4LrcdIZG64gqIz8vDL0tJUuXXPyW0TjuQO5
         jNoQvZVN2u7mRbMK+t0iZ6ohY6LrNDLRVCZw09TYai7/rAUqJxZBRfYy2CmZR9KaoyhV
         N0e9XS5omZxsX+KrPyu55Kvs8Fa6I/+dA6gDqsUVItDlmdkYWcbY3NS9532EhgF3G6yd
         mOJA==
X-Gm-Message-State: AOJu0Yw1pw7K7P+BF31m7sVvf+oJ95TppjOkU5z3+0AoiRINGDT928hh
	zpQlTNwNfFpR6yEiRKlZzBazXX/eOx4NJGyWFmS7JI6yoJ3X6OYiNTz+TMlJtJU=
X-Google-Smtp-Source: AGHT+IGMaQfxgnv+C935fy0RQULh92//2yxbunDULsU5mdwVXrhVrfVVjkjKppycyo4o/f2PJnLaHA==
X-Received: by 2002:a05:6830:3110:b0:6f0:4da7:bf62 with SMTP id b16-20020a056830311000b006f04da7bf62mr5976847ots.5.1715025939877;
        Mon, 06 May 2024 13:05:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ou7-20020a05620a620700b00790f6f8b03csm4171557qkn.55.2024.05.06.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:05:39 -0700 (PDT)
Date: Mon, 6 May 2024 16:05:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/23] pack-bitmap-write.c: select pseudo-merge commits
Message-ID: <Zjk4EqblA5M6BbFV@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <12b432e3a8adcda6228beae2b41b2363a6ce82a0.1714422410.git.me@ttaylorr.com>
 <ZjjEo8XU5hPPQSYf@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjjEo8XU5hPPQSYf@tanuki>

On Mon, May 06, 2024 at 01:53:07PM +0200, Patrick Steinhardt wrote:
> I think the same is true for most of the other parts of the docs here,
> as well. We explain what those configs do, but basically leave the
> reader on their own to figure out what the real-world consequences are
> and why they would even want to configure those in the first place.

I think that's a fair point, and I'm in the same boat as you are to a
large extent. I have an idea of what these settings do and why you
might want to set them, but since there is no real-world deployment of
this series, I don't have any solid guidelines on when you
should/shouldn't set these settings.

My hope is that there are enough knobs to tweak here that anyone
deploying this feature could find a configuration that works for them.

But I'll try and add some general guidance on why you would want to
change certain settings, etc.

Thanks,
Taylor
