Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE972777FC
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034465; cv=none; b=jjFxunzRAWfI6uv7/Bn0IyDd51nXc7TDoaB4TFjf28uY9MFFAK0vt6w9HoCq3NuQHxwtSzT1M1dAxRqk0+z5uxfJYy9hYXJh92L7yLeKvzLmKcbDbGaSw/HaSRoC7D8C0oudmcZ8Hconpr4PjsV96FVikUOLOVfNJ4JasDsTF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034465; c=relaxed/simple;
	bh=ykoklXp4dESSrqAuR6CO7q8d59sDrKi3S5TsRoOclWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0upQICxq4JyGsfdTymcGd5SjaOE7D2Rm5UfNFt0BQ+czrU+uL2savlxBEYUeTOLHR39yGnaugOUk5cftVc8Ygr4D31DniI79F/hj+Z9NZ60lzZ+VB9RAzfdEDTK+5pTTz9Sq8M4Fxza9IBOMNHptE2nh51K80Pks3juovPvFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Sy7AGXLT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Sy7AGXLT"
Received: (qmail 292083 invoked by uid 109); 21 Oct 2025 08:14:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ykoklXp4dESSrqAuR6CO7q8d59sDrKi3S5TsRoOclWE=; b=Sy7AGXLT8hXigR8dl7wmXMjqlXvRFWU6Zefu898pzSoHZs1Y5BdCkLq2x4NddspXUv0hoa5SytAVTlIuIZFU7hS4l9Cxm+dzn2Lr1oIpEDY0P+j94He94Kd3MQJjqm3XZZIh5YJVnowg3n+YTPz2okvmOWCXavPY8OPiHMRVOQfj9AMzvgdqGTq77UlYIUiZI5xF4AJ1Qnr6cbOdQ1VfOnAdXLlU2rcMa9UUazUr+f6ry5oDX/mhKkbvlgxM/mVCtq/y5zSV/QfhsEiFD/G6i06LHoFAeewhbH4JAK7XM7WLmr9k2iW/Dh9L8PiLbLo0fW6wM/lcaeZQDVg2sXx4sw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Oct 2025 08:14:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 455095 invoked by uid 111); 21 Oct 2025 08:14:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Oct 2025 04:14:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 21 Oct 2025 04:14:22 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>
Cc: git <git@vger.kernel.org>
Subject: Re: No config option for `git diff --stat` to always show the full
 file path and name (without .../ abbreviations)
Message-ID: <20251021081422.GE259661@coredump.intra.peff.net>
References: <a6ce209d120ca6acf0f5dd04521cb96ac1337a54.camel@aegee.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6ce209d120ca6acf0f5dd04521cb96ac1337a54.camel@aegee.org>

On Sun, Oct 19, 2025 at 09:46:10PM +0300, Дилян Палаузов wrote:

> * Please either alter the option `diff.statGraphWidth` to enlarge the
> available space (broader than the terminal width), or add an option to
> `git config` to set the available space for `--stat`.  This option
> should eventually allow always to print the full path and filenames.

It does seem funny that we have config options for 2 out of 3 of the
numbers you can specify via --stat. So adding diff.statTotalWidth or
something would make sense to me. I'd guess nobody has asked for it yet
because it defaults to the terminal width, so a static config option
risks overflowing your terminal if it's too high. On the other hand, if
we are going to show it in a pager anyway, they usually support
horizontal scrolling. And I guess it's all a matter of preference.

Anyway, one more possible hack: you can set COLUMNS if you want to
pretend you have a really big terminal. I.e., "export COLUMNS=200" would
probably do what you want without any new Git feature.

-Peff
