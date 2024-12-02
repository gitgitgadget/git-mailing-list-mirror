Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F01DED63
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173209; cv=none; b=is15GKNumrQSqe9SDtjwk4DIFyzjMX8IHeJu4O8HcbEZyNlGNEgHoJQYjaSHl/yXhExMWAq40xibjUX+Gt2QT52znNPlG4Hx6PB8Fiu9sDIFEWOsvR726bR5tCbjPlCIk3kzT2HzkTuyf1J6fK7vF/lEA53uDoCOD1eQ/5JV/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173209; c=relaxed/simple;
	bh=VSSQkDOdHDp0reLPOo6HRa9j0T9ICthjh3tPlqk88TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoDYs2jrxehM4oqvEn2OJ7bVFkfrZo/MKWJTc9aNkjgoV8R/cldPs6+UAkgbOKwXMmQwSIcQzr/ZF0cg4UV5B38Qv0FyGL0+mHGjVviu/Ne421y6z1Uv8CkJ2Gh6a0XwUmEdXwWKK6SVSPluw9MXz1KlwyjQSDXNiIBU/OcZ5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XQc7DQJ2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XQc7DQJ2"
Received: (qmail 16726 invoked by uid 109); 2 Dec 2024 21:00:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=VSSQkDOdHDp0reLPOo6HRa9j0T9ICthjh3tPlqk88TM=; b=XQc7DQJ2ZedUPPHdll+QijkMhI6J6mIqWD83kgIgXGHqtDbrqZ8LufZCK7lesM2x67zh9Ra5A6dJkxadScnAW4zHATaSQaaQHTMKBcqsVEY7ucil7gtVXqbhJbO+rzz/Hh8Rpa0XrlkoGZWZrcV0ROW30eKX+PTWu0sdVbitUFReOj7QS98QBNJr0xrs1UyVASfn09yCqqoLPFvM2vyn7ilcvh6yQ6QJ9elCo8n++78awAnN6GH5qj3BKzNi/ymGDX0TORGQKaiyYejQ4LnbTvJSelNt9LXm80Gsghz69o0256laGOZWcqlgp3uJoyH52618SHXMXPH3r73dFSDXew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Dec 2024 21:00:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26378 invoked by uid 111); 2 Dec 2024 21:00:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2024 16:00:06 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Dec 2024 16:00:06 -0500
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, git@jowil.de
Subject: Re: [PATCH 3/4] t5604: do not expect that HEAD is a valid tagname
Message-ID: <20241202210006.GE776185@coredump.intra.peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-4-gitster@pobox.com>
 <477f0dbd-60ed-4f73-b945-cdbdaf9f510a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <477f0dbd-60ed-4f73-b945-cdbdaf9f510a@app.fastmail.com>

On Mon, Dec 02, 2024 at 01:19:56PM +0100, Kristoffer Haugsbakk wrote:

> On Mon, Dec 2, 2024, at 08:07, Junio C Hamano wrote:
> > 09116a1c (refs: loosen over-strict "format" check, 2011-11-16)
> 
> Nit/confusion: the abbreviated hash is only eight hexes long.  I’m used to it
> being 11 for this project?

It's not a fixed size. Long ago, the rule was "enough to be unique, but
at least 7 (or whatever you set core.abbrev to)". These days that "7" is
scaled based on the number of objects in the repo. See e6c587c733
(abbrev: auto size the default abbreviation, 2016-09-30).

So I'd expect 10 digits in a fresh clone of git.git. It's possible Junio
has set core.abbrev to something fixed, though.

> Does the age of the commit matter?

Nope, it shouldn't.

-Peff
