Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A28142C4EA
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360550; cv=none; b=Oih27JMuWoVQZS98sKCIPX2i0ugtD5N4ns963uKUbA9dkssSARiE2JqwpfqLYoePtU9hCxio6XZcsiJGYa/dw8ynOAAznkUF8eurhrqkKdAwmcVvxJWJUuPjfPXEpAEnK6wOv7onfsm3wfLZ+BLD1VJ8bCG5m+Hlwv6+rf4b6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360550; c=relaxed/simple;
	bh=B2zQkedxYvbfo38Ll+vPFoEgV0piY4O5D6Y2AYAQGZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFG6cOCbNheDmOpMQPEFbXezXRh+Q5jHkWnaxy1A8LCCcnIu8IarngwXiFXt0aF7i/zfRGn19RC2c1iA9i4NUvsCO1HZIXDMm+2fRBJ5veWFGCXGeLmYLULfDfq+zyyj9gkFLvilrBCR+0m198SPlqXOl3XN6+PvnLaP9JIzj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=V1gUh8Pd; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="V1gUh8Pd"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66843304cbaso2244926d50.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785360548; x=1785965348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B2zQkedxYvbfo38Ll+vPFoEgV0piY4O5D6Y2AYAQGZc=;
        b=V1gUh8Pd6AdyW/GrHkuQ+Z7bahNL7fH7B8iKyDa1CPplaMX+w7eB8Iz9wv6w7bcrLq
         faWNywyaC/vynIvOkj1i0OzI5xqUMrbORiHBMa5C0G2wZDpSM4wz0EZa2h0oWJYRoWUp
         lZ5SHmpKtRBlL72B5DikujvRHlY4Db2dEkYL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785360548; x=1785965348;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B2zQkedxYvbfo38Ll+vPFoEgV0piY4O5D6Y2AYAQGZc=;
        b=LD3tbDccJFGcWrYaMI42PUDbuHXvHSI4SSNK4MXBljBSZ+USBK4mzOdGDaTW66CqLw
         9jTYqIKWkXI/QvVSqKlN4Pur+IPtXVuyAZg0YTibSp75Zr2BmYkIrK1LuT5U0ujz4YLH
         mkFOzSBfHgThQr1xJLtP90CnNuwaCqXuVNjLP0AKTMB3ICepuscrk9JZM7t64N6GuG5e
         JgVwXB5YATFOMx+OM5ITjsdoWoGc9K6WialD+K/yVAsKU+CDxb/x0lFivXkq8xF1wNVr
         Izw4C7KAegGnoFP0Q5lyQ1m0YnEMVwymjNpqttg9FfsHthUn4mSTT1io1BAXOeCmKGlf
         NiUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpiiL3ul22zbS96aidMtTMxioZHgg89x8o0Cfq+fZIAkXXMu3xuyzZpKivL6cfJMsd2/yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNj7oJRS0HdJQQueox0vE0CUduWupbca+6U9fMUkhAdZmY1pZ1
	IqVHVV8WsweY3oIJn5UkiOATzmPqmpMd1qmXIFz2+uZQu0wl8yzmwJ2zmNVCJvqTOpYZg3ABUm7
	xErQ2haI=
X-Gm-Gg: AR+sD13lNWCHm9EATm0AdAXQsi+D1HIlyLYz9LEv4+trd97Mb4+JxHLXX3McxIZJYQ0
	ASNhvMBaSxNP0F7KvEDZAoSk8VSIzk0u+2Qo1EVPeSF1qsYgOQhbdmcv+dkTrZ1aslNCtVOBNld
	omXTKrZV3Fo3UzwuincOM0ACGZE3JW9XnA4buzPpeLreZ46QP84dGSpQ3lcfkigeDSNmjvujyGp
	e0ZUDEAYVPmwlROUJPQjt8TZy5oNzK3Kog5swohGXw9cqyIpygF0dM/zANdRpaVdrdLyRmTDis8
	1p+ZVtGTtKgmTuVuerN8GwYCuBzo+uegya9tKliAoYgK4xWZlzA6SDhtfQqK1t9vkwRA0eRn+kx
	riI9q62cWJOcZKSKKgJ0w1wtlkeKfvpAUcCNxtd7U0FVpXC4Q+qQ1wv6c+BK2dQn4lj/PGGMOb0
	zFjoB/BIJymGYxYGM7b8M4wG8ZIGr31Tmi2593ZjrrKbJhRVbkjrCEz0nPxtR7pNErVxexnaKra
	Y9BBDsLqkc9gTYemgYPC24U3qPHRZm8dzz0Znad63IQVXaWUK3Kjj4RbQ==
X-Received: by 2002:a05:690e:bc7:b0:667:dc6d:736b with SMTP id 956f58d0204a3-6692b7d7982mr228102d50.32.1785360548365;
        Wed, 29 Jul 2026 14:29:08 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c53027esm68092d50.0.2026.07.29.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:29:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:29:04 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: friel@openai.com
Cc: gitster@pobox.com, git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
	stolee@gmail.com, ps@pks.im, jonathantanmy@fastmail.com
Subject: Re: [RFC PATCH] index-pack: optionally allow duplicate objects
Message-ID: <ampwoImYYKeYzkw7@com-79390>
References: <xmqqtspho7tk.fsf@gitster.g>
 <20260729211716.40166-1-friel@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729211716.40166-1-friel@openai.com>

On Wed, Jul 29, 2026 at 02:17:16PM -0700, friel@openai.com wrote:
> From: Friel <friel@openai.com>
>
> On Wed, Jul 29, 2026 at 01:32:39PM -0700, Junio C Hamano wrote:
>
> > I can live with such an extension as long as we teach the receiving
> > end to deduplicate the extra copy.
>
> That makes sense. We don't want packs containing duplicate objects to
> become a persistent source of duplicate objects in other repositories.
>
> For our server, duplicate objects would be an exceptional consequence of
> an optimization, not normal operation. We have not seen duplicates in
> practice yet. But preventing them imposes a cost on every upload-pack
> request even when duplicates are rare.

To Junio's point about "these cannot go forever unchecked", I agree, and
I think this is an important internal detail which I may not have made
clear. We don't expect to send packs containing duplicate objects as a
general case, but this patch and my series are a defensive measure to
make sure clients don't immediately choke on them.

> I'll talk with Taylor about whether the client should repack when it
> detects duplicates, or whether Git already has a way to mark such a pack
> as dirty for reuse or retransmission until it has been cleaned up.
> The intent would be to pay that cost only when duplicates actually
> occur.

Let me think a little bit more about this. It would be a shame to have
to repack the entirety of the pack when there are only a few (or zero)
duplicate object entries. But if we can efficiently pluck them out of the stream
when fetching/cloning, that may be worthwhile.

FWIW, (and I'm biased, but) I still think the series this patch is based
on is worth picking up. I think it makes sense to have better support
when we *do* happen to see duplicate objects (e.g., to recover the only
good copy of some object you have, similar to Peff's argument quoted
earlier in the thread).

But "better support" can coexist with "...you still shouldn't do this".

> In all humility, thank you for reviewing and considering the RFC PATCH.
> I'm still getting acquainted with mailing list and the history of Git,
> and I'm happy to have Taylor & Ted's help.

Thanks for saying that. Welcome to the list :-).

Thanks,
Taylor
