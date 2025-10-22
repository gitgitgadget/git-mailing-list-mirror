Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BD2857C7
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124542; cv=none; b=WMImq369O3Qa6iFhnbU1FjpE7aaekgqxQiFThjPgTvjb1E9NDGKwSomWhSDO89nkBevvBrUM3TFYjVXJvvWLQdJsi1kEBYoPF6MVk7NBrD8c5rNIhQ0JvrB2ZqIhAUzZTu0515QZ0LYi4eCMCCCxFoSp84alscI9mrvOuPB5Vaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124542; c=relaxed/simple;
	bh=BGVdMYACo/o65GyqnUCNUrcpmhOW+iUxpACSgmUpCJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXrw9Uj7dEHh9chpsZLodNp+WPOamSMAzIkycNjlohMMb6hMzAFXKJOuwUo+dFtJZ1pFvJBK0Otfu6B4/Kkw4q9a4IEw/fdgDbeRwVMN7Zqxo4iDfr4LHlA/5SSvXmvY2dUSncGNli1aCWbB+w5BxIwbW2YqTYH0M79QFMBoQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CMQ2Q6Op; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CMQ2Q6Op"
Received: (qmail 303108 invoked by uid 109); 22 Oct 2025 09:15:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BGVdMYACo/o65GyqnUCNUrcpmhOW+iUxpACSgmUpCJI=; b=CMQ2Q6OpeiZ7rV3QrS5RP9QozOXkJJXA977sW6DQDx38iutswc6rXCbRkp340LDHiOTs21X37IybBppJJDawptZGYIJpH7HRqoDMTDAJkwcZIzfRc9uSNKVSTFYkMw99FPu8Lj0CND1U+0vpFQ8xgpsfQ+Z4I9xqQ/Zzk2SlJGooC+u0WjVJHAOAegEer+us17NwOVZU9NSkLAVXJlYZQTG1IMLi/HUyrAPxIV4HMRkTZG50igUa1S71ScCiUecetmotM9KxxVc/k41c5VUrkj+VAr+T0dMrT5dtqxBw2MITl7CR6NVgABxqNHrevfvHWCxMngQgqCIMOsOuUxyelw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Oct 2025 09:15:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 472285 invoked by uid 111); 22 Oct 2025 09:15:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Oct 2025 05:15:39 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Oct 2025 05:15:38 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>,
	git <git@vger.kernel.org>
Subject: Re: No config option for `git diff --stat` to always show the full
 file path and name (without .../ abbreviations)
Message-ID: <20251022091538.GD853931@coredump.intra.peff.net>
References: <a6ce209d120ca6acf0f5dd04521cb96ac1337a54.camel@aegee.org>
 <20251021081422.GE259661@coredump.intra.peff.net>
 <xmqqtszswbwq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtszswbwq.fsf@gitster.g>

On Tue, Oct 21, 2025 at 07:46:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Anyway, one more possible hack: you can set COLUMNS if you want to
> > pretend you have a really big terminal. I.e., "export COLUMNS=200" would
> > probably do what you want without any new Git feature.
> 
> ;-)
> 
> Isn't that the exact purpose of that environment variable?  It feels
> a bit unfair to the variable to call it a hack.

Yes, though I think OP wanted something that would work for every
invocation of git, without having to pass it explicitly (otherwise they
could just use "--stat=200"). Setting COLUMNS=200 sounds like a risky
proposition if you run other programs besides Git.

-Peff
