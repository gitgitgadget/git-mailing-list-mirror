Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09518B489
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125558; cv=none; b=MnqN1viGjdZ5ubiA7PbILAkYh1WDP0WGf7eeJLfmZWL903lsi5i2r2X6+n56WcEzRbzELuSSQySeeDYMqB9zlxpRPZ9ybUpoUJTvSxR+mRZwjA7lErKyhy+KDR1LCnIczFk0yeiOfsc6qN5m9hUzpKLrA11GMgLAh4Bl5aRFg4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125558; c=relaxed/simple;
	bh=4g3vL1+scuaPw4JuPdq8d+VjP7lDtrKkMBRKVjw91SQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kGM7DJZL6DXLv4Ccb/I+pSgTGFukytIYfXqQlPfTCqtgIcn+wu4pSxBs7XRQ4Mu3bZjvqZU4C+PRrWm3+YwsUicT0K4jS0VDlDOsKnPDlt2mnDse7X7X+c95hAol1ZYzx+B1BEZjlNKIAUEsRd4eUmtuN/4M6Ue4t64WL6qeNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QQRcl+SP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QQRcl+SP"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723125553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rk/u1OTwMcPzUQDcSz6PA0/VkPlKXOyTFH2dVFw/X88=;
	b=QQRcl+SP6niCBMBj7gByedQo6f3Jb32zVrISw/plf2CyXcZkVR0I1VTxGFTCZtdnVBiEGd
	4yKstpojkuQrsU7sfxwb0bZ9RmcbQ/h140RtENVvaWcr1JL7RW7cF6juYbTMm+dhM1kGJi
	3U/t/sGG6xk999li+FzYbD2nUyl827znFSbIm6bM9MLnjS0xQdGS6Z+LEN+7tTXqGFPz2o
	BRV1XCd7hYgqUvoJSAVGtnVLhJ8jhVyFDPKSzWUg58fNPKtiK1rUiYxLKu8Xn3gxnkK0YZ
	kEhCBrjjjJxVVhORSwoxVU3Hlvg30XVmCm47yKxAJkyJzCQiuczNfHktN65zkw==
Date: Thu, 08 Aug 2024 15:59:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
 calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
 emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
In-Reply-To: <ZrSxLU-7rmlvdTHC@zx2c4.com>
References: <cover.1723054623.git.steadmon@google.com>
 <ZrSxLU-7rmlvdTHC@zx2c4.com>
Message-ID: <9fbe5ca8bf133db8f614c0e90ac5fccb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-08 13:51, Jason A. Donenfeld wrote:
> Cgit maintainer here...
> 
> On Wed, Aug 07, 2024 at 11:21:25AM -0700, Josh Steadmon wrote:
>> * bikeshedding on the name (yes, really). There is an active, 
>> unrelated
>>   CGit project [4] that we only recently became aware of. We 
>> originally
>>   took the name "cgit" because at $DAYJOB we sometimes refer to 
>> git.git
>>   as "cgit" to distinguish it from jgit [5].
> 
> Indeed, please find something else. Cgit is a real project, used by
> many, such as git.kernel.org, and it'll turn into a real hassle for 
> both
> of us if there's ambiguity and confusion.

Totally agreed, naming it cgit-rs makes pretty much no sense.

> What about libgit-rs? Or even libgit3, where the rustness of it is
> simply an implementation detail, so the name won't feel dated 15 years
> from now when everything is written in Rust anyway and -rs is so 2020s?

Well, there are still very active commercial projects written in COBOL
or Clipper, for example, so I wouldn't go as far as _everything_ being
written in Rust at some point.
