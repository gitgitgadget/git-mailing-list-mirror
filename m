Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57D25776
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288288; cv=none; b=e7SOJbCsTBm4g2CslxzOQPENHAXrQ3hUcA1eA91cJ8gclNVBKm/mspktK7ydGbW6gY27oLJuFs+uF6daRKB1S4JL0/JRZ0K/CodZ/jC4sRbCh9H1mcJpJ9kIPJpFPwe/kkXzdbyqwlIlKjtup7rYioxWncqCARvtV6UjWf+LHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288288; c=relaxed/simple;
	bh=ZMzYBXdbuo+TDokPHKPLpLz3Yj7tCuvcZQMkqdClquU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdHTPMFFJadLNPVyf/6i8S6jgEMrdGv29iIYUiknaBW9jsb6KvXZwq0DKEEbL0MNeANxhpEo6QDXUS5RsXMJcypEGW5QOJZrwPicSIpHOoVZoUjtcfGPpBftGxm/6GT6e7C1qzllGhXj2bRdM+7vRP/FYs8cNrZiyNzrYvMx1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=SnP/uMIJ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="SnP/uMIJ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7dc6fbf3e86so16109187b3.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781288286; x=1781893086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YeaahjCDrv0pkpODu9lu47TFIXZ9TgsfrXoQjvvNkHo=;
        b=SnP/uMIJInosawxwOb1svoDOEk45cu/E2c1X3emRaqLcRtdJvPJAwQKb4EHWXC0Un3
         VFIZ/vbOVBwUU9o+4g/XwFLCRDgr4OBkhqL85Cx86hCmVEheHBI8mZkEYwUnQTVBS4nn
         YLaWsD9MOBSWgHx3OSWewVO2Ma3LsfqFtM9qV7DKbvAIj7JWNHAj/FL6Ybtqkhpcn1qa
         V1KiDEAxpcrLd+HZAlWWnMmbJUt/rxOJfOEXFo22jR6M0XOsGiQ6sAmTPGZr/5gGBurI
         YR2ycrqBofQ2qDSCRAVgsIa3MjhiNQ3C7xjctTQnT9EvRoPUkK03cD/9MXfOH9wT8UsO
         tIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781288286; x=1781893086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeaahjCDrv0pkpODu9lu47TFIXZ9TgsfrXoQjvvNkHo=;
        b=ScreNccUOy8NO9Gk/B+CdwnDSB6PfCo0yLGOZgNE6VC2KYaDqIlwTwiWG0fYKifAtC
         NakjTnws/kI3OtdKXhBEp5pCmLxCP7aRfTCcKfaAyxo7OFGsx7aljhGYD2S4nfF4XpZS
         ei0CL7ZxGfcNObedAfIB7l3BUI1uZ8FXees2d0IxELadhqywMMfdxy6qU3X+suAMCZia
         gxkNaz/9OA4GOOE0Rpf/4J4pMhNYvRFFplyA9Sk7etnw07gMDAjI0q65Bg+R6L6w/bgU
         44Re/T6zgqwzjdnU2hkcpn7ndqR16eRhIHCA5j/hUSgEUYDCrWgo4N+vWD7nA83XCC+2
         8mOw==
X-Forwarded-Encrypted: i=1; AFNElJ9Haq8esdv66neB5Ulz6nRkZ7SlJGm8wdmcKLZJzMMmhTh3+Fpu18FE4HbtIXR6Xmdra7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2XToOBEfTsdIVJnE7gN+fZR/6e7ZAVohVucEeIjygaywsQxhf
	BqmH16JgDeT2wJifNjdT0kqxpui51IvsRyednwKzRehe+BTkbSsya4288VlY61op/x8=
X-Gm-Gg: Acq92OFqzK7EVU0Emn8P1Hq+CEcQ7mvjpS9z/myJ1z5QfFtplvpbRFpvZYivNrGks+g
	Yh/Z6ihbnbmB4Un20pFtNwGbIWZ13QsPifZIbChL50BUkoE7no7T7tDb/C7ZEVnStjSBOc3jJyV
	V8b+le4VkecZTJCEKUow/Ti5EKeV3tn6TN+BqMLoSF+bUrtJh3XyCoClpAokUqlemPRy9vqJgjc
	LslhgDIeJQ4MWMc1PncYbCXV5MXz4XKbI9uoNK7hMpyYQ1LMek2pOlZisZ7F8g4RXHGBqwlkvH3
	HnxBANfNgWqjK7NsN1XEbZfdSbJULfNh2+xc2nZisBy48aQN5so0tnHGOSWu0GBZ2fmMAa8Hznw
	ox592IKdlgd8lk3uEYPj60sQEdYe4p4A7em2K+xfYZrPpUpJdA+zuKdFsHXa134qI+RKsAhOuxT
	bw/JpNXcPPhuWI0oU4Z91ZrxIn2bcV4QeD+gMIwFpWUvzilvyTGqXbz6SoI6ijcnvPj2Mx3PBXL
	BzE7KAmAjqaqBDHUntyjCA5znNpY0BSaBNSFBTIwvDdwq2ittlTIcpg0s1Fnpbcl5q0QNbXOj1w
	HlZ4BHmkz6OmlXrJ
X-Received: by 2002:a05:690c:ec7:b0:7bd:73f3:7a70 with SMTP id 00721157ae682-7f7b8523999mr38185377b3.32.1781288285957;
        Fri, 12 Jun 2026 11:18:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f76e994903sm13421697b3.20.2026.06.12.11.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:18:05 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:18:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 06/16] midx: support custom `--base` for incremental
 MIDX writes
Message-ID: <aixNXOxfPZnAVLgK@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
 <1bbb387d6b6204045d97882fd8775dbff12dedbb.1779206240.git.me@ttaylorr.com>
 <aiuaf3fKJ6kIITrf@szeder.dev>
 <xmqqqzmbj3mb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqqzmbj3mb.fsf@gitster.g>

On Fri, Jun 12, 2026 at 06:21:48AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
> >> +	layer="$(git multi-pack-index write --bitmap --incremental \
> >> +		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&
> >
> > There is no 'nth_line' helper function in this test script.
>
> Good eyes.  It has been there in the file next door t5335 since
> February, but not available here in t5334.

Good spotting indeed. Fortunately or unfortunately for us, pulling on
this thread revealed a bit of a rabbit hole. Patches forthcoming..

Thanks,
Taylor
