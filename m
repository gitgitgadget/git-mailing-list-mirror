Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0638D6B3
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177570; cv=none; b=ihSclg6ZQpEF8RFA4U/P6S1eWSElaHJ1INdgBJtrgUmSnddOMABCUeoMAKM0BKIOD7fSb3b2IcFbi3SHiRQ4zM47KvvZcQEbKgJ8pXgJGKEV4HbWiaQZJWwVPl92VU6vPOfVzJytbu8RJrTw+dosMMwfhwVHORcsOfmUU2MDQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177570; c=relaxed/simple;
	bh=3BAZ9paNidPbRgpmPscKzE7ZhSNG+CDKbSEbiB5eVgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMz65nYPZ15Qf4RgTM4zSUZy+MqSxrfHgB474CwlqoEpCunkZPU7n/peYu+XPNDC83WHbpfFAQI7Oklhrje27/kAc19Rca9X9NHqPRua/znzosw0UHqg2ivQW4q8d4D6g9cAhKSQZalwNhRgW7Uc4cpTCprriBoGlxOlxjWb6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=lgtgBsWw; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="lgtgBsWw"
Date: Tue, 10 Mar 2026 22:19:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773177567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECuSJ1GdO3wmugJek55ofVk453v/rYV7cd+dVvTE/v8=;
	b=lgtgBsWwr5ceT7f4eFJMi+CdIfi0u2pYeR/4zVp61VqtoJG+mO8qyPmOQRSUJpw+ixwDbt
	dK+qsBEVq6Ta8GSQQyJp497VU71sdJ/pXmzg4A3M8ItXRJG5a3H7H8avb0/A5a1wNgaZ3I
	VMiETs90+3f4ngwyFnu2Msga49hHEXGWe6Jj6xm4NHbYKU162xsCZ3VinKdppE1GiW92DJ
	TbdHn2Gb96j4CQrQpSbbDXEkty1uvaA5Zo5kg4Ke+/Izye/xc3WlIeaZ9eXsKICOrDzr2p
	82E5boobg28qlBrXQdqGoGoXlViS8wwIHCPPZYwIFco7W9wBmVUSaCzOXBLyKQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 4/5] format-patch: add commitListFormat config
Message-ID: <abCKBXo8vKgv-8RG@exploit>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <c522f47e5b574c0c889c40284c71c36158b6bb6e.1772839973.git.mroik@delayed.space>
 <6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com>
X-Spamd-Bar: --

On Tue, Mar 10, 2026 at 02:34:01PM +0000, Phillip Wood wrote:
> It is unusual for an empty config value to mean something different from it
> not being set. The reason for this is that it allows
> 
>     git -c config.key some-command
> 
> to act as though config.key was not set.
> 
> Perhaps we should use the value "default" to generate a default format. It
> would be nice to support a default format on the commandline as well.

If nothing is passed it defaults to "shortlog", it wouldn't make sense
to call it "default". But I agree, accepting a value as set but without
passing anything to it can create some issues when interacting from cli.
