Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91702367B92
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814685; cv=none; b=LirWeWEixdBgp7za1+fBQ/ZN8msJeNkWAxxvjXRNw3XcIAxifEcO/6gof4tdudjDfxUa855FyNC4IMBClJQR3LEHu5xxPHxCiCklix2qH8lKd41pjy46Cp2i59ab5IJTmtp9rmZetyV96QHoEL9eShD4tdVlVpMtW1zpuv9bb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814685; c=relaxed/simple;
	bh=0AaclvKCvRYnlx74We87TTZ9pw4GbwbLQlO248Rq0ps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lGyR6mrMJNYB1GvXiBTf/E9t+JzjRCyJHH43uW06Lmt2skDLb90b+V/81bM9tgaU8QvZzdD4YcjgXg4+yo1+AiIguBbKZxDIpUZyI104VuHxHGGY+GUkNdq87eK3QbA4UD5itEdj26K/i3e/h9B+uIerVMGufsKqorh9Cz21KZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hb82JHAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqT4TrtU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hb82JHAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqT4TrtU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id ACE37EC0245;
	Mon,  7 Sep 2026 16:58:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 07 Sep 2026 16:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788814682; x=1788901082; bh=aLHeMiDTQ6
	7aUuxYfNo3hGVlZ54GBGSATRfYrogjLYk=; b=hb82JHAHPjMdHJcqjVAm9xiP/7
	gBVYBtHpQE0IQyh846PncJCOTWMWGHjF+0sgiLD1wJ0eqjLMJuL72xDYrzGWwD3d
	kBADjUaZNJdQwu/obXpIYyqnlq+Vz7MZ1DvgiIPh4WbgvovykKc0OFmSpGWYa+Da
	fhocNlR8PWwDhwn8l58s3V8T9lMM0kM5s80RXedrOAtTFhXcZYXI/dNG4lKZPBTx
	y12XnJwblVhoGhnY/8eyF911klh51Tn5S3t+E3LH6e5AWV1fYQSHPXsmtGXgm1Bs
	9FWRuuZyRXDd+jY9QtLwhZ1oEHHwfTQt/EWwhSjB1av7X7d4K8fF6ef1Lbiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788814682; x=1788901082; bh=aLHeMiDTQ67aUuxYfNo3hGVlZ54GBGSATRf
	YrogjLYk=; b=GqT4TrtUBXCw+J3oVTvwIE+lgdxJlPC0ykS4yALy7j+POAfLsln
	kI5B1rsmc5I5TX4gVcrXdbKg3gjcDkP8woec4rk5EItyqfDuk5HkMRjQPpooXsGf
	sfIuRFPyesosDIl2jekvP1QTXtzo81DIxXhaCJMIa47QFhN+7UW7EG8lJd+qIS7L
	5PyvuolmRiWDlW7Y7KndiMFx/3Jta649egzXfXS2vABP3CEF9B7+bGsyxAd+Cu8g
	G1wOG6r8DUp0SEIOPZ33TSVhsh6qx1zzBUWVT/TNIACSQ9Jhjapb6vnR9xKzcA34
	0TRm72K4r7ZVthUxlRVyZoN2cQj14/hHG8Q==
X-ME-Sender: <xms:WiWfaiIDBycZxtt4XVuBoIXr_u-N012E4UmagRSd0fHTvKcQ_1LEdw>
    <xme:WiWfaq1P1NgGaGeu_jSESHxa6-8sW9vbvKS-lut261cv7MHG2t1TUACgT7pX0luvr
    ui49k23BMDP8k2fRORfhL-R5VOTT_C4dDiIIGyK7K2zVYo_gwZbsaw>
X-ME-Received: <xmr:WiWfag4vLNP6vGSiZskn80AlcrYDTB4RwSPS9ldz40JzWaS6qLa9t-Ox8k2czOH3V-hXy6u5ChvDIgIPwGKm3jOmXE07xuHNmkP7>
X-ME-Proxy-Cause: dmFkZTGEzHr3U5NmtwU5E01plZLrDKdz5RgWB8tcF/xo31L8y8HyR9feRezPIOHDZg01wu
    Wlsx2qFBAjmVLMDOayeh3xpeV9L59Bht8PlTU/ZHMui18D3sGtAu7IspFOUBBrmJR0FwXp
    hon6TeCrpR8q0X2zry4y11yAt0FTrZJVKN7CePIgw24Ss6VAAq9vHI4uTh/7sfPZj6NOEX
    xxp+6UuRKYkr+XVIWMsuQU29A/r5nLlkCrvHr/pnXtn06YNXez2Xsj8SwhavrYls5Y3PEW
    6fZ6OxasoMQaE+P0WC4Gaiy5S/4pUC66vP61jSHGdUv0PyYCp2zdcDNvUhCHeXit+i4tZL
    5jI7CoZtW9B0hx9wjfioaRG3lQRmhBwjTvELjt44wAF0W0t8pJJFW79EIkE+HVMguhlyy9
    0ufhQYJqQtGPnwfVOCc84bqFLuZ4mmLjQELCxSXRen/pKk1stKUz5vcCQT38WhW+NYjvkO
    WUzwz5LEhgyGhoRnp0NHEn1k+WXhqQlfF/uC/YEvK9QWHNS7kh+ldUX/W0OZC+h85K8Zp+
    CCEhSWPcXB4pDx+rFdQWE9lJl9BMuMJBntpw+ioSEe79BrIlE/bIh59apKxsqrP+GdbS1Y
    sz1y/p7slebd/+1XnkNj0z33+bxWOWmph9Puhyq0NkA7uqOmeDnQkdlbw6WQ
X-ME-Proxy: <xmx:WiWfar_8S3Ox67gnz8kcO8lphCV6w5KlNhH6XHTODzQOUq_AJJBoKw>
    <xmx:WiWfavWSXHJrA0-il2ttwbf4ZN7HqBk1lgkidV3oWpVIddvUMiDLyQ>
    <xmx:WiWfamqrt1uJprR12qXbgTUoolmaZcWa1yVNIt8c42sUJVq7PbmUbA>
    <xmx:WiWfahn2eZYfL3h2st2bmAWscw87G9sE9jNyqoAywDbBT9o5hnNePQ>
    <xmx:WiWfanHupeotQrjv1SozoR3Vyf3iqTTL0qkqLSST8CjUSPjqDvUcJPdQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 16:58:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v7 4/4] hook: introduce the receive-report hook
In-Reply-To: <20260904-758-introduce-hook-v7-4-6c66f0a3a572@gmail.com>
	(Karthik Nayak's message of "Fri, 04 Sep 2026 23:28:52 +0200")
References: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
	<20260904-758-introduce-hook-v7-4-6c66f0a3a572@gmail.com>
Date: Mon, 07 Sep 2026 13:58:00 -0700
Message-ID: <xmqq7bkw3hk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -2469,6 +2510,12 @@ static void report(struct command *commands, const struct strbuf *unpack_status,
>  
>  	generate_report(&buf, commands, unpack_status, version);
>  
> +	if (run_receive_report_hook(&buf)) {
> +		strbuf_reset(&buf);
> +		override_cmds_error(commands, "receive-report hook failed");
> +		generate_report(&buf, commands, unpack_status, false);
> +	}

Hmph, what does 'false' mean here?  Didn't you mean to use the same
"version" like you used in the previous call in the preimage?


