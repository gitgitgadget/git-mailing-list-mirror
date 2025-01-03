Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4514D2B7
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735891108; cv=none; b=UMyS2Knfur8KrQ3JoOBRSpJLrZUY4CqZc/1FTpiDY76hIMqYvY1WPcOj8z5Ynqo2IHyytcwp9Zfn7ira1fYS4Q0U8EIdSMWC51H2yO4z8RkHXmrohiEgeXBmgt+1l/aYcLnbVouCk+/Du7KxWWhJnEawapnDZLYoMr5Isv6xbu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735891108; c=relaxed/simple;
	bh=1/HBYi7KrMf/udnbM8texL/pKpVWcDKuxQV44BZ8OqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f8266SOiATGEM0/ailz7lCwhnHq8OkzGQFCVYj98AqLZhN99Wb+KII21nG/lnqjYkX90sXH6l0wFPZnpfkMp7mcjAM0/ow/7Rb/Dqp5O0lK2bumc9v9nLOZx3IuKbZWFR7DtoF8xEA+aPVfG89bYzHYpUi2By1y+NyCrFaf162c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nwOW3md+; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nwOW3md+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1735891100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jrCE9kW+KImuxHjOjepWEVT7pa8dqC072VTwR3vDTCA=;
	b=nwOW3md+NNN7p5hfoXCgc0t0CFJKjfzvxP4TG6eUOUY1l8cLaTocIg4EbVEaeR34Hig6Kn
	xtwqWXuEL0WUx4heHTZkmX/bR69NmOPC+/Dgmwrs3l7ekTTVvSyLvVjee5aZ2xzrf4y620
	IOEvJuzsGFVDVNvNKWwRa3Ov76KcWdU=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: How to use Meson (was: [PATCH 00/10] meson: wire up missing
 HTML documentation])
In-Reply-To: <Z26ygb_4-DP7Ufab@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
 <87wmfqfwh1.fsf@iotcl.com> <Z26ygb_4-DP7Ufab@pks.im>
Date: Fri, 03 Jan 2025 08:58:00 +0100
Message-ID: <874j2gl46v.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> I don't really think it makes sense to explicitly point out every
> option that we have. We already document how to discover and set
> options, and from hereon it follows that you can wire up docs by
> running for example `meson setup -Ddocs=man ..`. It's just another
> option, and as such it can be discovered by running `meson configure`.

This is something I wasn't aware of. Because I'm used to the Makefile
workflow and I'm not familiar with Meson, I didn't expect it to work
like that.

> The benefit of this is that it cannot grow stale like the build options
> in our Makefile. These may or may not have documentation, and may or may
> not be stale. With Meson, every build option is listed explicitly, has
> documentation and is discoverable via `meson configure`.

That's awesome, and I totally I agree we use the benefit of this
self-documenting feature of Meson. Again, I didn't know about that. It's
more of a me-problem than with your code.

> Yup, you are always expected to set up the top-level source directory,
> not any of the subdirectories. The build instructions are then processed
> linearly in Meson, so variables declared before a call to `subdir()`
> would be accessible in the subdirectory, as well.

With Makefiles I can build individual targets (like `make docs`), or run
`make` in the docs/ subdir, is something like that also possible with
Meson? Or are you always configuring what to build in `meson configure`
and building all that with `meson compile`?

-- 
Toon
