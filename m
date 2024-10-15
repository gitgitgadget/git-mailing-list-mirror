Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06A16EBE8
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014682; cv=none; b=Wvo4RC8aVCGasXufrWIDdQjiTY8g468anXk0tJoYcdkJ5tg1W2DUdhyxc47OMvO94Bng3abIwGw/Hw+yTqj759hI8Dp96nER0kS8M2SUxObhzOBOw6bxBbRNONQRZI45XK56IyxXvkn7Cpgbc04dBXlVk+vXIbWA0Vnk4qpQW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014682; c=relaxed/simple;
	bh=Mn1/ltmfaGsDoAVzw6kztLG4tClWzv7J3c4kCu9Yxfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/9UB6Cacw7vf3ZedChelp3SbMv6yeApRDH9JFODDdVGzoQm197gHXWuYqwPkVxgTd1of4aNGbg4bZjVr54QINeJYuS6AB9j/veK8mCYoKRLyfqVcISU1BiPQf2tvRGDfMOH9gVbd4bJguLj/dzGhvAkKTdwiPVh+W8bAgQEgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=CxD0qvjc; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="CxD0qvjc"
Date: Tue, 15 Oct 2024 19:51:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729014678;
	bh=Mn1/ltmfaGsDoAVzw6kztLG4tClWzv7J3c4kCu9Yxfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=CxD0qvjcbkGCoZj+uxFhjUJfaFGh6aYevZXG/3aQY5DUWAXYxC0ygMOXNI/kwMA3l
	 8vwvJITGFic4/Zaij2D+outTgR80utmLeMp6QosPo5V7YLheP5NE+1knBXBa/iUr1q
	 MmCdQcfyZTxyPkNdWzMq9RbQdVukSyFFlyO5xCwRl5j7TAIVtON/A0E6K2WSNI/ewl
	 VgGQTzxV7YlpvGZgpZZPy92y0JWzdQ7YtFOU5HrE22SlSycNFMRlx/cA5JWz+rla+c
	 RXyw7DlarCUW2Lz+HQlV8vuZ0AT4WhmOPx/jVav+FB2xq2BE9e82glWPiYtRt7P6HL
	 H/2xRu2HONKPg==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <2j4vvyo2nthifofp3susoq5qmbyoocht7pjw6bzrxoffuui2ca@pbpxtwnyrr66>
Mail-Followup-To: Eric Sunshine <sunshine@sunshineco.com>, 
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <CAPig+cSGzgfa+0MbRD10vktmx3O3v3q_TremWs7dANrwALf2Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSGzgfa+0MbRD10vktmx3O3v3q_TremWs7dANrwALf2Fg@mail.gmail.com>

On 2024-10-15 13:20, Eric Sunshine wrote:
> t/test-lib-functions.sh has a handy nongit() function for running a
> command in a non-Git directory:
> 
>     nongit git shortlog --author=author <log 2>out

Ah, nice, I'll be using that instead, then.

> By the way, what is the purpose of capturing output to file "out"?
> That file is never consulted.

Oh, my bad, that was a leftover from local testing.

> Also, can the original crash be reproduced without having to invoke
> the additional `git log`? In my tests, this is sufficient:
> 
>     echo | nongit git shortlog --author=author

Yeah, same as above. I'll take that into account for the next version,
thanks!

Thinking more about this, any opinion on the specific test for --author?
It is a succinct test but also relies on the fact that it "just happens"
to be one of the flags handled in parse_revision_opt(). In fact, any
such flag (even non-existing ones, like "--foo") would crash shortlog
right now. I'm wondering whether there's a more universal way of testing
this.

-- 
Wolf
