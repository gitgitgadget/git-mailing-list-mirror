Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43C7BB1A
	for <git@vger.kernel.org>; Tue, 21 May 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298031; cv=none; b=BoWJ16DKmaSx6uvRAQ2yUhUwJmjDtyYqpZiBcVeMACQ+2Ne3eg1zof8MfRX9q3BtfkQarFiKKOsgO9Ix8dimwcl3Tq/EcyIrKNqyJ67nitVZ0gbRdi3KkMzzbXZfj6RoL/bdNMIXWPZ/9Z8qAsA/pTz2DZRnHwza2OkY1oZlalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298031; c=relaxed/simple;
	bh=AxJ2S1/JRsExCB6cw1ofoDn2phXOkvsbx79qvMsizeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNDn9WJWM5MTit+LCkBjqc/lIcJ5qi60xTsSRw7knCA6xu46TmRRqzs6uOkjSopAvEYMrsjjuh3hDpsOvTZiagD9ay3lOlCKwsiO6aasJYSIwm/AmeOTTqb2Izxs6vNAa4tC8ajeGU4GCUCaGNEBcJh+mA2uHOp09Zyc2hVmesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xOacWdKR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xOacWdKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53156C2BD11;
	Tue, 21 May 2024 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716298029;
	bh=AxJ2S1/JRsExCB6cw1ofoDn2phXOkvsbx79qvMsizeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xOacWdKR9Wn33F+ODmfm1nOIEXH0SOVkxxJtB2kstDaQKA4kumk97ScYRd6CGe2kQ
	 0yCBe3wL9sNgwySR635RyLJGbRRUs+pF0iX3W7EAm1h8z9xj/n/O2qqN8akvB5IrHt
	 l35u4pt4B4IGrigj28JzSL50ymdKUVZF36hrxis4=
Date: Tue, 21 May 2024 09:27:03 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Ondrej Pohorelsky <opohorel@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: git-daemon doesn't work as expected in v2.45.1 and friends
Message-ID: <20240521-evasive-mindful-stoat-c58b31@meerkat>
References: <CA+B51BGonS2DDTBQ2RsipW4Cyg5pRv0U71RAN9M1pcPjACtJ4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+B51BGonS2DDTBQ2RsipW4Cyg5pRv0U71RAN9M1pcPjACtJ4A@mail.gmail.com>

On Mon, May 20, 2024 at 10:21:23AM GMT, Ondrej Pohorelsky wrote:
> Is there a way to make git-daemon hosted repositories safe to clone,
> without specifying safe.directory in git config? AFAIK this is widely
> used feature of Git not only by the end users, but also quite a lot of
> tests rely on it.

I would say more -- this is very broken and needs to be rolled back. Running
git-daemon as a different user is the recommended setup for read-only
deployments.

-K
