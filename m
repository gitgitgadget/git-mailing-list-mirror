Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC943280A5B
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474805; cv=none; b=WULGxj0qR8cnpDtf1Vz23TWL2vIi9nrJrI1OphstaLW3Utu6S136NRufopdfgzp546zHvM/mv2lRDESMGWzHAw94HpPRA1UN2bKe5bJr1IKdpan17qucQ3jPsXBdxE38MWhLkCxOMo39zI4WG9PTKFbUxH83M7u1o9WYQye3jOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474805; c=relaxed/simple;
	bh=bwKRG3KXqlnxoB5UhFlJnNxC/Mi7sAPHx+oCqGLJ1cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umjXpYzvQwYXEy0pddn5PKI5RIyCFX0RilMdSOeXxCjkE86IGfiLpkeXix+GHi9QYKgqbNe/WljhmHpb8l0A1jWQlg4FDhOSQpDyox8n+U6F9344N4DZAN5YF/3B6J/v7iBTZHF7O0p0WZs6Jol/5PRY+0dKcGd3kC9qjLj2gXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cikm4E/8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cikm4E/8"
Received: (qmail 29214 invoked by uid 106); 2 Mar 2026 18:06:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bwKRG3KXqlnxoB5UhFlJnNxC/Mi7sAPHx+oCqGLJ1cQ=; b=cikm4E/8E1ZvJ44EOKSs3YfIdalnNc8C0VUFhb5OnpP9/uhB+Tcb5gTd7jVanasglTPtN3yhyRpXLZfqUeJgF2Pugp37lM8lTHUDpqbV3oBDXhM6dKs2WwRv+WRCfMI9DSaeZgSq0K3DmAKeWvOZOtVztgtClWC4HP06QMMPExFp+6v8ov/XScTxLudgrABT5HnEyDbX1OfAsSJ9fZEIuDMByXsCYNEfFKNZnFvt91TT7kDk2YVvuf6gZVUiuRckR8uX9X9Tg+b+MGoXezlpEtFT7DV7bmjACEjh0SzgHvFUHZbpjfQiziPzJjsqmzcPDo5Bm/i+1Uik0V1ybsVuBA==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Mar 2026 18:06:42 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 333934 invoked by uid 111); 2 Mar 2026 18:06:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2026 13:06:43 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Mar 2026 13:06:42 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/4] for-each-repo: simplify passing of parameters
Message-ID: <20260302180642.GE28275@coredump.intra.peff.net>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <f6582e94026eb933dff6fa895775c52ebf32409a.1772465805.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6582e94026eb933dff6fa895775c52ebf32409a.1772465805.git.gitgitgadget@gmail.com>

On Mon, Mar 02, 2026 at 03:36:45PM +0000, Derrick Stolee via GitGitGadget wrote:

> This change simplifies the code somewhat from its original
> implementation.

Yeah, I think this is worth doing.

-Peff
