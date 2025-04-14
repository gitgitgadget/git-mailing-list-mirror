Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE39479
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744594500; cv=none; b=p4OBhK0H0910MXEU47XbZ4hQklDEWpJoBz/8EEEBO3whslkPxVy0RHsxewnY5tWUnMTblYUE5e3PKqLV1ZrZBETwj42NnHA//uGijEZbXI5Q/8dshpLg55nkLpxOybU35EWRPGUd2vwEqEEzGDfVAjgYbxFHblsictY7eyIiFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744594500; c=relaxed/simple;
	bh=60f9u3H0+wSsbapt02PwMqGGkvQnfLjmlwnPCcZTrTw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbikWNynI7UwqkQfyt4Uh2sZPedB1ep5tQfDopcjlcsIY/XrfxxOKijzKTDcdIIlVhL2CSc3ppsM/jTQLKsPORkK0smIeVkQJlnGqAHZh8PuWsEiBmZexzddMSGe1HZyfQiZ7lOQnZsiFZrFeyxioWZgkR6BceejUiEkrMX/khE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VsdfrJJO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VsdfrJJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1F0C4CEDD;
	Mon, 14 Apr 2025 01:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744594500;
	bh=60f9u3H0+wSsbapt02PwMqGGkvQnfLjmlwnPCcZTrTw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=VsdfrJJOIHuNKUjgMazSgs63tz9+OQT7OFwNDxh0qwN6AJd6+m3JdBAM/AzsQdlhD
	 wztwS7YQn0i46K0pGImj5AhnH8oalIXpBOENF1BnGNTfIj2ONWyR2z4mLpYO2Cc8uN
	 5J7YdC5iiKvMLWZOVeQG2onEfqactyG2zwypZWdc=
Date: Sun, 13 Apr 2025 21:34:56 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: git@vger.kernel.org
Subject: Re: How to gpg signed email patches?
Message-ID: <20250413-dancing-acoustic-marten-cc7a7d@lemur>
References: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>

On Sun, Apr 13, 2025 at 07:17:26PM +0000, Klaus Frank wrote:
> how do I get "git send-email" to send the patches gpg signed?

You have to step back and ask what is the end-goal? Do you want
repudiation/attestation for your own patches, or do you want to be able to
verify that the patches sent to you by contributors are tamper-evident?

On the kernel side of things, we've been using patatt [1], which supports PGP,
SSH, and ed25519-signing of patches via a dedicated custom header, a-la DKIM.

[1] https://github.com/mricon/patatt/blob/main/README.rst

-K
