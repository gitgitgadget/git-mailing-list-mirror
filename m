Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA029B79B
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590947; cv=pass; b=hlPF3N7loKS3vZfivVNmlH3LhOzLdhKV3O0noK7Fy2TDdKb6hFmbwhdHkoAo8cGP8MABl1evtW0A00XFB6U0OtcsMHiybhWQM7nsrMTYTTvjkzL5yKgxXBnEN//2baeTXLDKnhX6+Sgt8FCMjfwOA6ytONFlE7dC794IK0D7dSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590947; c=relaxed/simple;
	bh=PutRclPF0xuPSxo5JLjg3sz+qNNUmEmHN7a/80QQ8f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cs6oluM5ITRbtTH/9nE7m47CfZYO5tQATidQAq1eA3drEepYklm+lyfJ5zl8y41WiDAK+yrZvYQfb3UxlErOoSaZJ9semMPwzOaMf+nPgDdwB4Zx3f7cfkm6KQIcgqgqKpHdvZHOKY2x9g3iOQMfHsxvYfe2KQ0T/vs0ZsBsehE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WXhTym6h; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WXhTym6h"
ARC-Seal: i=1; a=rsa-sha256; t=1771590933; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d7ATtN1+jYlu1XyIwP+Es3kre1IZlHG/d09s0b2P+aWyqo4btJegmVIkxqdmVljHyPgjEhhIri4zYXdt5l0mP8Q0yQwFTUF/aEs4KV0n7/Jao0jj4nJAzpBGEm74G7ZDYvC0moUjM1cw1J2jjuMMJ3ltpGGlwRDA3n6oBIXALM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771590933; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K69RLh6yWcgD8c1bOsXeOYDikkwrDg9ssyeVz1Zg1Vw=; 
	b=b6tO90/ICFA+BYW/9Szek/TaE/PP+Pn9XGFhuUHWxNTsTHAbJHovcz5BX+LLIRN81rjOj5quOUud6u9Rcp+/PXJT5zkSuaiEC9lVjvm6+4rqrcErgL7sEjEAR/rNtkU8X7j9vHceoo4pmbLgQWWhEG87oehd3ykfeoEZeuEBRRE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771590933;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=K69RLh6yWcgD8c1bOsXeOYDikkwrDg9ssyeVz1Zg1Vw=;
	b=WXhTym6hJ1Qcvqvlp6Jr8TlOzBhfC5a/t7nbmkGG3SeaujByhd8V60vpuCzBFRHl
	aX8l/p1Yf2S8QPy1bJFQSgO/R8h8bgWeHeT9IIsKRl35Uq4Ve32G/ibfDNgjZDaHbiX
	YbenYoRm272WAFAus/yH6dsVbJizwVXq6J1SW0iw=
Received: by mx.zohomail.com with SMTPS id 1771590932572642.189226603507;
	Fri, 20 Feb 2026 04:35:32 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/8] hook: add internal state alloc/free callbacks
In-Reply-To: <xmqq4inc2yom.fsf@gitster.g>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-2-adrian.ratiu@collabora.com>
 <xmqq4inc2yom.fsf@gitster.g>
Date: Fri, 20 Feb 2026 14:35:29 +0200
Message-ID: <87ldgny4mm.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 19 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> +	/*
>> +	 * Ensure cb_data copy and free functions are either provided together,
>> +	 * or neither one is provided.
>> +	 */
>> +	if ((options->feed_pipe_cb_data_alloc && !options->feed_pipe_cb_data_free) ||
>> +	    (!options->feed_pipe_cb_data_alloc && options->feed_pipe_cb_data_free))
>> +		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");
>
> A way to avoid being repetitious may be to say
>
> 	if (!!options->feed_pipe_cb_data_alloc != !!options->feed_pipe_cb_data_free)
>
> or
>
> 	if (!!options->feed_pipe_cb_data_alloc ^ !!options->feed_pipe_cb_data_free)
>
> but it (especially the latter) might be a bit too cute for some
> people's taste.

Thanks for suggesting this. I was actually thinking of ways to simplify
this and the double negation didn't occur to me. Will do in v3.
