Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8261F09A5
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786174921; cv=none; b=HHKFn9WhmAaglXgYJctyT9cYBbOSL1eb2fFCHCJtVIX2VNBQF7urnk5qC6pjFBUXZyH4UvCC99htJjEm5PWsItv2rvSD9IMOqe9PheouHIh/GuNVPFmxrTLVwoIOx6eDg36GLjq7mGnBrrcG8hzE3SCGEUWWG4mO9P0gZ9IYTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786174921; c=relaxed/simple;
	bh=3S31eMoQBRT1NTfvEjn1Jb6ngmIxWHY/pGQq0gAbC30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mou6l1r8env0si8YVy3PcWWHYBS+eyTOcZZDea0lrL/sc2289Ep5gTtbyWlA8njjPZ1heKadcGUqaO0mpMKKld8+o/lPw9+6asQl5B7jTJ7B4gtcXcMcA47adjm3CYZpt0Q4VwEmtz8m8LFnPHAVEWfA2QiewABuT3qAQbRFZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TkbIrKN2; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TkbIrKN2"
Received: (qmail 10142 invoked by uid 106); 8 Aug 2026 07:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3S31eMoQBRT1NTfvEjn1Jb6ngmIxWHY/pGQq0gAbC30=; b=TkbIrKN257IWupIuNl45pJc5HH1UbVhHOmyDvOKXCgoqotGVhxbfIBvGugFrDErXPBVkP+iaWaGAVMSg6KcUY4xjnCIEYQDzkUC/VPu0BxTFUL4HoZ6D62eza7CXq6Somp3zjHxjC+zjH8uN/eDnibFjFGJ0WSzYEURPPdUj2o2Sf5mk9yvuL9gRcrQk9N0SgnM9a03eIN7ITDQnaP7aQifaAF6B9XnaszHQwgpSIq8y9jfmyyYkscuMYs1X8tOib9TsqDxMgwziKPvLSMiQfwxTG9zWp+bc1RHcnh4Rtq5TRQcrS5K6xRPRT6rZ8URM8mwX5+RpeIV/XtmC+lEeAg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Aug 2026 07:41:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20773 invoked by uid 111); 8 Aug 2026 07:42:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Aug 2026 03:42:02 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Aug 2026 03:41:57 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, karthik.188@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH GSoC v6 00/10] cat-file: extend remote-object-info to
 support %(objecttype)
Message-ID: <20260808074157.GA2915582@coredump.intra.peff.net>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>

On Sat, Aug 08, 2026 at 02:02:15AM +0200, Pablo Sabater wrote:

> Changes in v6:
> - Fixed static analysis CI fail with two forward declarations.

Sorry, these were my fault. The forward declarations are obviously the
right solution.

-Peff
