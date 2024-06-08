Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E44C65
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717846355; cv=none; b=kbhzi5dnKvqMmnLSvXVBUVHpy4u4iv0sDU7bTA9+NBGNvDIu07l48PW1jF32i3kIYscLUqYvMZLhxjKhwxz5GfVCPcgJXRquULFJyl6KxPQuMkj6fUTBgwhBec+2gry9ZhZja486H9p2BKE2SXBpHisCiqwSO8Ol+OVe9pB0ZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717846355; c=relaxed/simple;
	bh=McYkSe5hPkOZD5nUDwoDYlUpX66kyi4I/vrR4o1wnik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuKhb+P1rC5LdC+KWGOUANBvZDQlvGcnNk49nRnJTc1PGc9vrS5Iy4KPTK4NaoQm5m+vXMggZ4cgMtubBIQeG9SFtn4+fdk+K59u5iWyEx9a6ZfUf74XJPKhFrbK35RdbEQz1HzcUJ9jso0vy//p4hWuqIny1uM2/2TO6gzs9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9035 invoked by uid 109); 8 Jun 2024 11:32:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 11:32:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29870 invoked by uid 111); 8 Jun 2024 11:32:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 07:32:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 07:32:31 -0400
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] credential: clear expired c->credential, unify secret
 clearing
Message-ID: <20240608113231.GD2966571@coredump.intra.peff.net>
References: <20240606183516.4077896-2-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606183516.4077896-2-aplattner@nvidia.com>

On Thu, Jun 06, 2024 at 11:35:16AM -0700, Aaron Plattner wrote:

> v3: I reverted the behavior change to credential_reject() and just unified
> everything to use credential_clear_secrets() instead. We can rework
> credential_reject() in a later change if we decide to. So the only behavior
> change now should be the expiration case in credential_fill()
> 
> I also updated some of the comments in credential.h to mention the new struct
> fields.

Thanks, this one looks great to me.

> Thanks for your patience with this series, everyone!

Likewise!

-Peff
