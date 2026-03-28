Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7FE1448E0
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774664760; cv=none; b=YRoLniMuSJu7vW3h1tLD1h3BXZmOosWg3lYaBrBe4TYMggM4sHNCB9SKKWHFFMDbd5bPJLMznoXMLHupI8A30enyNTBNP3EeuLL2Mo1j87IlcOMcGiI0g7xu1w0tPlt4wGlp5l3fPk/eNc5vXqQ+ODFmSYHmg56VCGUwJp/u2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774664760; c=relaxed/simple;
	bh=mh0EcFZy5o2rQhy4ZFpSw6xgShvR/j9/IbvBqFY8vLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzzSQ2dK/DEO/jB/0n1uweVOZM2eurY3WMSc7Ilp/k26kJFBhx3xhwf96fBJTUgOzmTCrN3TwNDcVZmeAD2P1qIFLfP3yPDqDh/RI1ezAUXeRDDmxShxtCJuTZROl7ywArJeyOZkZJpk08sNLZKtMgoR4HEBBy3gtVexfVu/oX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fjLwH4zbLz9tnq;
	Sat, 28 Mar 2026 03:25:51 +0100 (CET)
Message-ID: <c5ad8e2e-c361-4f75-b557-2e7dc119ac01@opperschaap.net>
Date: Fri, 27 Mar 2026 22:25:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] connect: Add support for per-remote and per-namespace
 SSH options
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
 Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Bence Ferdinandy <bence@ferdinandy.com>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <20260326233739.2911354-4-wesleys@opperschaap.net>
 <20260327214559.GA599365@coredump.intra.peff.net>
 <a4a03bae-b987-4b21-a7fd-fbdb9d832430@opperschaap.net>
 <20260328020327.GB621762@coredump.intra.peff.net>
Content-Language: en-US
From: Wesley <wesleys@opperschaap.net>
In-Reply-To: <20260328020327.GB621762@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 22:03, Jeff King wrote:
> On Fri, Mar 27, 2026 at 08:43:07PM -0400, Wesley wrote:
> 
igured in one local repo, then yes, it will always apply the config.
> 
> If you really want per-connection config, I'm still not quite convinced
> that you aren't better off defining host sections in your ssh config.
> That covers all options that ssh knows about (not just ones we teach Git
> about), and you can still apply it automatically from ~/.gitconfig using
> insteadOf. Something like:
> 
>    git config --global foo.example.com:foo/.insteadOf example.com:foo/
> 
> and then defining a foo.example.com block in your ~/.ssh/config.

This is where it breaks in my mind. I'm configuring ssh to configure git.

Btw, I'm assuming you meant:

     git config --global url.foo.example.com:foo/.insteadOf example.com:foo/

I never took this approach with ssh identity files. I'll have a look at 
this approach see how it works. The submitted patch approach has served 
me over a number of years, albeit not directly in C. I just store the 
config in git and I don't need to worry about ssh anymore.

Cheers,
Wesley

-- 
Wesley

Why not both?
