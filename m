Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB063546D0
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392780; cv=none; b=ctCvAgKmHr7XIeYjCO8Xnc8MVKhWl0mEvMYFqFYoEiaTtrtxJMGX4gU5lZolRXq1WqjQob/j7iOc3YugUnUPfMV4tIhUuZT/VMNXbO2VyJ+/rojhhDTNPrxL5GnRVW2nGnqHEZ+Lkj5vVHHYV7XJ5mLBI4agvKT4lAuHNpR5vfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392780; c=relaxed/simple;
	bh=p7fsNA8VxbLBKA75YRs891mQaZC+U+xDKjta/5J4Eto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kJCUMw1tNVQk5kUk4J73dsBCo+sTzPrPKIdRgHfPq3MC19gRZDHv6EXdJwWn2oHujflk1vRc+VIGaC2uK+BSx2G3vc6F82zj/9qLj0EE5iT3S7MrII3T3KCo8ih+0Ai+PR8dtmkewYset+znkAuPPT12fBdJXrhs/vRezx0vahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=APWIuhoK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fxj090zY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="APWIuhoK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxj090zY"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 10CB6EC0215;
	Tue,  2 Jun 2026 05:32:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 02 Jun 2026 05:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780392777; x=1780479177; bh=H7TB7ABetw
	ytN2admxZY2nylyjEMybqj4SeIBKcXNQ4=; b=APWIuhoKdfpbHiG+XnHrmVFa4i
	OmNke7UeQ6IfnFY7g/gH/rTa4lklrgu12TO/XeaE00DMvxBL+jLFHf7IF3sJG87Z
	+HD0xwbSVx78Q5cpGhjj9T3mfoNp+cEYMw+76r+5LMFklEySP9bYajMliCizyzX9
	BToC2L1jQNLI+z/TXSZJJaLr8b4MqWRzpuBHhYsym/+i1pnKHuTytAmTZQ5YrOKD
	3klb5y9KS1GO16SEv47HQEKnqcBENmAUfuB8BEv5MQaQSG3CL6n54MrWmwjeu7mP
	Vh+T+TjA0ZVXc890sLli0yJWj5OycyMM1sOhlwhNtQterIKMyLNAJX8j8ShQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780392777; x=1780479177; bh=H7TB7ABetwytN2admxZY2nylyjEMybqj4Se
	IBKcXNQ4=; b=fxj090zY16GDvkkpFazzaDp8QbM3hzxOptUfMwgbnwyvkjYPiYr
	5kKhIig54SVgqvVAEK6yhp7qM8jEtPnGJS8BSZlQh7gnSX+jBzLPqCWvFmcHVCFn
	0ZfLVEOXiuBYYqoEUyyZ+WuRl5LSEvu+21o1T7pdt1GFZoFBw9QttLeLJKLrG4w1
	jPLw0qSWA5ZCuOcrrCDexE2YNs3Bv43lfuZLQTVAMxslHf5nYQ7OZEJWe3oUbn7o
	iP3UaaT90u7iO33FoVd1v6xqtKeVv7HrQumbFgMz/D6zjioxBL7AIbHQu8IsnOne
	6glSakOvzezJ7YhrKQP1ymotKE0ysIRCbRg==
X-ME-Sender: <xms:SKMeauEhpMsOM0PeP9ayl5jwQfn0VnrdweK38VcD-WBK0k-QwAF6_Q>
    <xme:SKMeamyKkDYCk-4wAi6dWamsxdg4E2f6bR825rJkvrbGeb0tKfZvqgHa302gLxTpj
    DZzc0QGefL1c9ENitYA7AJPN_joeKAIkxmiv3MExW2iHRbGv0V4>
X-ME-Received: <xmr:SKMealgA9o9-bwfqWqx7Uar_08xbmAKs-y0rFhac7gocR86K-ZJmSQvMcxagcNl7TzMh9Kl-PETErHlQEyM4U-EkuHGQZe7GkNY8>
X-ME-Proxy-Cause: dmFkZTFG5iwnH7/3r5rhm8ZJsTS3GIh6MCzlRPo4wBzjyGgdvnUJixrPxCbVbcZ9dBN5t6
    XoSiW18u4Pji9SlxxuKzPoqjuS522CTL2QXAyoCy77Om8VEjAlJcWjxrXNpzhEkavCk59x
    dZ7d0KcGgNVsk2p6p811ErRWo3sWB+VM8r6SCD9Pb7L3ySkQv6dnpMxX1TgLo7Qyobkl1b
    ulRMSk5FgjanpmhTnKsuAzTYbXzsVidKSC2IyN+Zh0+RtbIRl2Ce6LaNjWgeaLexU3MUMq
    gjwA8zd6Sb6AsKjcdMRn19g0lI95kISUVAIl8M+ulfxVaU+luwldHniFZJRGxiyOFeuQOJ
    kjQsYwqU4swPkbBdkOd5ussOi1tJB7qCZj8FEHjnRgQVhHa6V6lS/YLbkJCZ566aMXmjMU
    72vwzdm5ht0dcSVtjSYvkhiJ+ueLk4/FPpsrMg99IgHj30bPQKMQ7L72YTkePo3zb97t7j
    vl99YoDZ7Ds26YZqqRIW677f4H5ahbGYnn1jMgsnkGrkmx1kM4ZnZXqS+79tuniqoiXOt3
    UuBCZQgUNNRzuzAcrsWnzouJ0tWSMUiiYH9ExAHUIS4IG3A9smsSbRUVeLtOivXrso3wOb
    sCahOGAJ49dS3pomxl4DdGz/K+EttSTnOUYb12zmP8gcDLzUAld/0UlwsZbQ
X-ME-Proxy: <xmx:SKMeahy599mbuO_hQ3ClelQqOYd7fwvVHDw5pAzaehVtkU5guzW9wA>
    <xmx:SKMeaoJ0-rYK3YJJHxSd41LNRM1GPMbdL96vlPzYmAEBsOLaSUC7-w>
    <xmx:SKMeaoTouRuffrmUOmre0UEWAUinPkWxLNERuP1rUoRB2GqLlZdOdg>
    <xmx:SKMeagqikRQkznAFThqBFLDQGkZ6ToPd6hXcu_mjrDfSjkOPzVr_Gg>
    <xmx:SaMealHXWYNFP_lDCbAfJFjKqoghX8_95PHJycMPBnj0NKmHuVfs0m9j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:32:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] t/lib-git-p4: silence output when killing p4d and
 its watchdog
In-Reply-To: <20260602-pks-t7527-fix-tap-output-v1-3-db3da2a1b137@pks.im>
	(Patrick Steinhardt's message of "Tue, 02 Jun 2026 10:54:29 +0200")
References: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
	<20260602-pks-t7527-fix-tap-output-v1-3-db3da2a1b137@pks.im>
Date: Tue, 02 Jun 2026 18:32:55 +0900
Message-ID: <xmqqecipxp6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>  stop_p4d_and_watchdog () {
>  	kill -9 $p4d_pid $watchdog_pid
> +	wait $p4d $watchdog_pid 2>/dev/null
>  }

Shoudln't we be waiting on $p4d_pid (not $p4d)...

> @@ -175,7 +176,7 @@ retry_until_success () {
>  
>  stop_and_cleanup_p4d () {
>  	kill -9 $p4d_pid $watchdog_pid
> -	wait $p4d_pid
> +	wait $p4d_pid $watchdog_pid 2>/dev/null
>  	rm -rf "$db" "$cli" "$pidfile"
>  }

... like we do here?
