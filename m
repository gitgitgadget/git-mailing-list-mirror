Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9020ED
	for <git@vger.kernel.org>; Sat, 25 May 2024 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716607353; cv=none; b=SKgRfsgKT6AWNnp59NZHWD/ZQk3aRz7wIAOjEswcpHYIaAJCWzp+dPd1NBbGC0nQntPdIL+2RdMSUO7kzENtg7lhyaS6V5A7oRVi3JvPnIo8WuWspKMD41x/ZiQzZz9Zon42JAfjpWRRKwzTR0uluE4sURtc60ubBVkz+XZWeFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716607353; c=relaxed/simple;
	bh=tzFfNtJoULC3Ec7S9jcpszUY+ngbZUqU46p5v5b4vXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCc/TUd7ZQHMGM1i1IWBzLyO0KYoR8CcM+LX8zzo1xn3uyn2gmXh/0XTOH2s4qBDExpyjzQXgKOaOBNcDnomE5MFRvON3AQyQ1oBxoMtnmKE9S5wMgjHQbDQpY31E0Jg/CQ6OLVq1Toxmjowxs4d1THOVJOAaSMt825kYpHkJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3880 invoked by uid 109); 25 May 2024 03:22:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 May 2024 03:22:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15372 invoked by uid 111); 25 May 2024 03:22:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 May 2024 23:22:33 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 May 2024 23:22:29 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 11/24] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <20240525032229.GA1890223@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
 <180072ce84868265acfda8c1adf375e39a3b7610.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <180072ce84868265acfda8c1adf375e39a3b7610.1716499565.git.me@ttaylorr.com>

On Thu, May 23, 2024 at 05:26:42PM -0400, Taylor Blau wrote:

> +static uint32_t pseudo_merge_group_size(const struct pseudo_merge_group *group,
> +					const struct pseudo_merge_matches *matches,
> +					uint32_t i)
> +{
> +	double C = 0.0f;

This version mostly drops the "f" from floating point constants, since
they're now doubles. But this one doesn't.

I don't think it really matters in practice (the number obviously fits
in a float, and then it ends up as a double in the variable), so it's
really just a style / readability question.

Not worth a re-roll IMHO.

-Peff
