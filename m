Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030D190675
	for <git@vger.kernel.org>; Wed, 29 May 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000547; cv=none; b=juAq90P0yy8QPIhWx6XhHgSk+vm+PzkopmkwPKly/l28AbUEo6UgicndXC9XpFQ5rtNTxb08WbWNo2l1kR9ic0oPjxuNFIeOSIGENWiPx7yngMznA3WIwBeCb5SOj/WiB0+Zx39QSZPZ60OyX8FSkfry4vsyk234PEk5nZ9eUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000547; c=relaxed/simple;
	bh=waXCyw9tru6EsHEnY9PCUQ5AT8A6+n7dtukSiAzv3UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkT0QwhdPrXWcQwGCtTScNTvsJPsuMjflWp8cXn5xmhY9G04ZuTSBM4/FN4Q5ulnB5STsLT0jL6dmyGCC8yGV4K52orf4Fz9v2s0MGgou3gCzeSp3DMXLltWVFRqP7UY5mAbKWIqjYq7FLtqdvNSgrmbMiEqOoWBqCPWYUXeDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nrDtl5+a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nrDtl5+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB0C113CC;
	Wed, 29 May 2024 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717000547;
	bh=waXCyw9tru6EsHEnY9PCUQ5AT8A6+n7dtukSiAzv3UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrDtl5+aOpf+Cq6wOrxIF6bQn99MmCD/7pvHtQfFDMoYGZq3kZ+AU7d0V6oLzkEj+
	 NYZFJnOp4gdVUurlj/E9+3fM9MYBpuZ36Pofh+TdimljDfQXMQQQId9UJtAy9/SKqE
	 q6lj59VhKw9IG7adCBM4BuPwQ1++W1YgS0CaYXf0=
Date: Wed, 29 May 2024 12:35:44 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Stefan Metzmacher <metze@samba.org>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Subject: Re: safe.directory wildcards
Message-ID: <20240529-rough-skunk-of-glamour-edcc8b@meerkat>
References: <715163c3-8d59-46ef-81bf-1dda10e6570c@samba.org>
 <xmqqplt4zjw7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplt4zjw7.fsf@gitster.g>

On Wed, May 29, 2024 at 09:02:16AM GMT, Junio C Hamano wrote:
> When safe.directory was introduced in v2.30.3 timeframe, 8959555c
> (setup_git_directory(): add an owner check for the top-level
> directory, 2022-03-02), it only allowed specific opt-out
> directories.  Immediately after an embargoed release that included
> the change, 0f85c4a3 (setup: opt-out of check with safe.directory=*,
> 2022-04-13) was done as a response to loosen the check so that a
> single '*' can be used to say "I trust all repositories" for folks
> who host too many repositories to list individually.
> 
> Let's further allow people to say "everything under this hierarchy
> is deemed safe" by specifying such a leading directory with "/*"
> appended to it.

I welcome this change, too!

Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K
