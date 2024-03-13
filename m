Received: from mariecurie.slightlybroken.com (mariecurie.slightlybroken.com [116.203.185.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FDD17588
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.185.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317646; cv=none; b=YWqM19HV887RR36ZE117Y4BuIe2WVnLIVxlsAns+eMCM8yyoE1wk+ScGrq5mFx7ve4XJ31EY4knQtkcVHoayIetXlYKNZF30EItZkjDPM/yMAxbqD5UdE38QT2n3rGPWkohcp6mZY2cbBsb6x+y6j6gvrw+EPB6b5YhrQoWfQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317646; c=relaxed/simple;
	bh=0u10uNbEskITDV6dtD5xcywxniZXL5MvoL0ZbsVh7pc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHN8lWts6Q3NGbAn7t9Ywq3dAQPFjLNVYybfhQPfFNSXo3HJ67S7SIHewSllzzG3vo/hqJogZnznur+NGXiBs82yr9gEl0XGyZxCZX98s65KAIemDVbJ9HHGOZCI4/FfyNWILsm8hxJOYoqSc42zul9xUKWvIyaDgzQ2UnunA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=labrat.space; spf=pass smtp.mailfrom=labrat.space; dkim=pass (2048-bit key) header.d=labrat.space header.i=@labrat.space header.b=ESZMVTia; arc=none smtp.client-ip=116.203.185.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=labrat.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labrat.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=labrat.space header.i=@labrat.space header.b="ESZMVTia"
Received: from labrat.space (46-127-146-24.dynamic.hispeed.ch [46.127.146.24])
	by mariecurie.slightlybroken.com (Postfix) with ESMTPSA id DDD59574D974
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 09:08:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=labrat.space;
	s=201904; t=1710317309;
	bh=0u10uNbEskITDV6dtD5xcywxniZXL5MvoL0ZbsVh7pc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:To:CC:Date:
	 Subject:Content-Type:Content-Disposition:Reply-To:In-Reply-To:
	 MIME-Version:Message-ID:References;
	b=ESZMVTiaSYcF1cQm8kcULJ0mpp3vWUySDxSbh7cICjR8/F1J9nByx/B/kCwGMAhX9
	 g23RN+pWKv/L71RI1y8xLQn4elcS7AznVdbzVkWiXsjie7OUubO+1jEAAw4C50CYQ5
	 rcrULYJFtyfsZG+kR+iBDglWLoLrRUS+T0LzCtPbCkRPIyCn4ZKlNkcn/YwSxrV4B8
	 1W1O6tJDXTTA8Tcbr2TE93y1BiUR7ob6C0iPzGb1eA45VEcrhStDLekLAyLGVwpyd2
	 tYz+/IPvN7N9keosUqfbeo2tD32l1GHxWKMYF/ktB3UZshZSkuneWbG1PgN8cSAWC7
	 RUhjLsJ9AFOcg==
Date: Wed, 13 Mar 2024 09:08:26 +0100
From: Reto <reto@labrat.space>
To: git@vger.kernel.org
Subject: Re: Proposal and Validation of Git Compile
Message-ID: <52ot6dibj4o5mhgsmxpa5r2hkllxrwwhf2azgkvtpaopldi2pg@5etkc4r3eunm>
Mail-Followup-To: git@vger.kernel.org
References: <CABCSMAeySCkg6A1R3PUwrHyWRKMKnBH3OGnd8OtX-OpsGoOTkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCSMAeySCkg6A1R3PUwrHyWRKMKnBH3OGnd8OtX-OpsGoOTkQ@mail.gmail.com>

On Tue, Mar 12, 2024 at 11:24:17PM -0400, Bhargav Vishnu wrote:
> - A large amount of similar duplicate codes are written by authors in
> different personal projects like utilities. These must be made reusable.
> Eg: Code on a gist is copied into every repository, why not create and use
> the gist itself as it also has versioning?

You are re-inventing the normal dependency packaging of the languages, poorly.
We already have language specific ways (npm, pip, cargo, go get...) for almost
all ecosystems. They have version controlled and checksumed dependency resolution
and are actually aware what's needed (binary vs source distribution, additional
deps etc).

I don't see why you'd want your version control system to do it, rather than
using what already exists.

"Code on a gist is copied into every repository" is what we call a library, so
package it up and pull it down with your favorite dependency management tool
during the project build.
