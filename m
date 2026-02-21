Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC98A932
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771701373; cv=none; b=kq4/7n0hiJS7jy1NNSVbh2wu+TzFos9ojyDwCQaluw4/vQf39NfkWc2jidbgUGlF/qF2bkYTgXJ3PmGN0vp6DmZERiTPijwhXG3TbYZgnlSa/EWSF4lvAvMZI4Zatz9ey0Mwg93f/bHjnjzQ3XeHgGjP1h5YIHfhkPLingqKIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771701373; c=relaxed/simple;
	bh=dEzJYWUNgclBRzV5PYi6yYkD9YrKQ3Wf3kumyP37SPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4dtAA6+fdoPdHosg6mzlDPBun0MsgW1t9e3wNBarH24dylZEH+NhlDwoM8KUS86iTIXCBbaM+J9TWP1bdUTxkn2DmDjUu/41HumMpt2tzaIh+JOrZ3AmVSMfb1GAkRTukVYxLc0SCiKEYfjTMSt5ZawpU4fdeJKqqs41UyoK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=BF30u84H; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="BF30u84H"
Date: Sat, 21 Feb 2026 20:16:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771701369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KneG296ttnmbW3QWzjjp+zKEOQ/Zys7EwFMg6p47Xa8=;
	b=BF30u84HbaskNm8pzMWQYXyN+Fkg+IfaajArV9z4HOVSCLNbuI7ILVpBGdPO4f/JLCSMVo
	SYrzci36MoPvGe7N2q4RQY0SbIkE8N7O12PQUj/JF9lElcowg9jj60hXJq1zyJF2ySMVuI
	q8f42JXJ6HIVwTZ1j1Uvl3ISf1SLuyANpHCbexPG0ph4y7Wlol3vtsgAkP6xKjhhOf4NRE
	mLEfYmG+ndveEhJLmasqKsgP+vduGUbcvTWBLB9zm7OqaOvKqOBNmUMhNKc9YAoZPNUJTe
	3QKfEzevEHsYjS1V+j3bKzmKP9gsrxr6Z/xG43ShXMGc0jv14ymBD8HFbz6PuA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [RFC PATCH] format-patch: better commit list for cover letter
Message-ID: <aZoB1ddjgfzJll6B@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=509; i=mroik@delayed.space;
 h=from:subject:message-id; bh=dEzJYWUNgclBRzV5PYi6yYkD9YrKQ3Wf3kumyP37SPw=;
 b=kA0DAAoBSHl+oZwZvtEByyZiAGmaBFCjwbs/6cPjGIwcbc7UwJl71paPTr8KlYSWMW21SbHQW
 4kCMwQAAQoAHRYhBP8rLfsrSlLCbCzJtkh5fqGcGb7RBQJpmgRQAAoJEEh5fqGcGb7R84IP/A2Z
 tJ2D4cnE5cXGd8Nk4z5mMlG10mu2onWf2+Awayz42bE5cG53kzCwxMjCA6RJc95K72m9BVBuAVK
 347yPDCx5BuWDhFs0M59XR6VWMmI53blIDPRY/F8b59z9PgId0ck8LoUTV8wNgfTilGFR6emkm8
 kBmOcaV3F59w8zQpn5Cxi+xh40c2ylTTgvJfVLqzwD7xy807CzBC5RAeaywrVqGG7/eGmZ5PEPx
 TIr0djV2h+AnsmSAUJYSRAlNFKBDW2YYDTVdzrwfd5PejKM13oDb2csod6I2HWfct2lHPDE+77u
 gOUtdB3ucJ2mH+HsSp6kU5Xr9blqFEBGzPDjln5c1YdM2EbkEvbYNqzqFahnNpDjWqxfLKaSzce
 zaKjVV+VI7j0f2l/xdInDOUvjoolPHE1NiztM4u5jLqGq6wh7lsB4J/E58NGTPLzaesja6isfdk
 GU2Aw2kWuZS0t75Cih922LGByIaIQACHOr446dJCR/5wm96wesc+hYwOb9iMUxHcRjE7qTgp/Y/
 BSIg/hbAT7NW0hRA7Ie2JJj4j9EzRz4mFE0NbmhxD7s7rcKQ+8C2gy1uaLsiajsp1c3zYN7JopK
 LBtHrD7fUuDTUecRzWv4210UIA0geKbQwzkNeTdivXrFb1vRrboCtz0GmuXc9XwXTMEdbvAk0Tc
 bEC3r
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260220230633.132213-1-mroik@delayed.space>
 <xmqqldgmu25h.fsf@gitster.g>
 <aZk9QlH2PDugXKrh@exploit>
 <xmqqh5ratzc6.fsf@gitster.g>
 <xmqqcy1ytz0y.fsf@gitster.g>
 <aZnOyYGzOByayPFK@exploit>
 <xmqqh5rarohf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5rarohf.fsf@gitster.g>
X-Spamd-Bar: -

On Sat, Feb 21, 2026 at 09:33:00AM -0800, Junio C Hamano wrote:
> When adding a configuration, never assume that the setting the user
> chooses is good for that user 100% of the time.  You'd need a way
> from the command line to override a configured value.
> 
> Not having a command line option does defeat the point of adding a
> configuration, which can even be used for a setting that is good for
> the user only 80% of the time.

Good point. I will start working on this in the following week.
