Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA211DA23
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429433; cv=none; b=rj1ACMuZ94VPSLKv+3efIdEJRjJwaXY2JwcOIcfsz8hq3jWY9iQQaqRdDheYbVahnnLnMRPn6LpKl8Ik44dDZMzsR5KHiC17lhoqarzY5mQNIuMrGF2zeR/KDDHwY8eWx8eEMJjPhrHO7AiHpJkpin4iPFNt9cJLXrW4b41Xky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429433; c=relaxed/simple;
	bh=zs61NPX9C859Dh7NzAnjC29y5/J3qX1hSMm6HIm+7B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5SHd4ZRWVkGPZ6El0NvAyJdBwjOl44PChrbZ5Y+oY5rO2zrKiRgqMSpjNzteKTCc8qDVbCph25CymACOlRVKDRms7hq9DDpMqCH1z8zMmvZ6aEU8H1nJrThhXNoaHPBaBGIFJ44+05/Idqp0dxNdynlwYYVT3lvubyXb0UPi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=RkPnbAh4; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="RkPnbAh4"
Date: Fri, 13 Mar 2026 20:17:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773429423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs61NPX9C859Dh7NzAnjC29y5/J3qX1hSMm6HIm+7B0=;
	b=RkPnbAh4dMfzWD5K+Ajuv/eDmd+YIDunJcTyrmM57tqlmXQVa4bg/D+sDlyBT0eNbGNr82
	HM2j/0FYpc/W2zDgiDaCSWydLJa0QnxL/LIKkxaDxlgiYvEXku7R040+uQO+nhX7fQJRS8
	ECXTcoA3c50Vhvu91cGUrxQ43Qyev3tPzxKT1ZB9drwXXA41Nr2MVQeiQzIQTONc7DKEPT
	Z9W0Ne3o3nDjuS70P/qGvFS53U/tX04tGvZgA0sFlWu2zBUgCsanOgJy9vCLJkimaMqBqp
	hwyz+u+C+mYbl6hyfTtstiAhIwM91Cyvb9Y9Wdw4i6WYoKDg5QLmS5/3DX2xtg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Bert Wesarg <bert.wesarg@googlemail.com>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v8 2/4] format-patch: add ability to use alt cover format
Message-ID: <abRTEXspvX_z0usP@exploit>
References: <cover.1772839973.git.mroik@delayed.space>
 <cover.1773331753.git.mroik@delayed.space>
 <225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
 <xmqq5x71gfci.fsf@gitster.g>
 <abLw6vUUh36zFK4n@exploit2>
 <xmqqjyvhez96.fsf@gitster.g>
 <1759c2fe-6e7a-41b6-9869-97544870ebef@gmail.com>
 <xmqqqzpn63yn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzpn63yn.fsf@gitster.g>
X-Spamd-Bar: -

On Fri, Mar 13, 2026 at 10:20:48AM -0700, Junio C Hamano wrote:
> I do not mind a sort of DWIM similar to "log --pretty=format:%s";
> technically, "git log --prefix" requires the "format:" prefix when
> using a custom format (i.e., not the canned "short", "fuller", etc.)
> but we DWIM when the string appears to use %-interpolation.

Then we can move towards keeping the "log:" prefix but
allowing for it to be dropped when %-interpolation occurs, just like
--pretty does.

Something to point out, --pretty does a very simple check (it seems to
check only for the presence of '%'). This does indeed catch typos
related to preset formats like "short", "full", etc... but it doesn't
catch typos in format-strings.
"an%" is an accepted format-string even without the prefix despite not
doing any substitution.

Maybe there should be a function, to be used as a check, that parses the
string and checks whether the format-string should be accepted.
This could be an improvement for a future patch.
