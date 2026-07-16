Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647733F4114
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191666; cv=none; b=RsMM4t0eulIBJtNUOp3U7Tte9AIx6rroaT1ct/Qez5RlJTxA3CMyGi1VQqCbbczA8JH7XF7kSJCa4YPNaClZkQqoG8akd26oFuke9C2EF9ysVzEONTgMRnJInN0gREIViOVpoqY13SDCkiBGVgDLVBSkH6IuFZh3BEIABq5RDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191666; c=relaxed/simple;
	bh=xGJ7GmshI1kRNSqlovLPi1Mfc4i2ig2DU+Alrf8qET0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4fY1QZs0S9fgpaolcwR+VBge3qKQ/aTIplYzoFBVsKkUcjZ/gc2jGmR+eQF2IHDACIDxDL2s+iZ8LNJZC8ojA94KKtzY2dcyaEdQaMRoTbjsYnnYwtHHXE+V8P188W2s4tBGpu7MBvwpMjJyupI2n5rE3ajGv2cRHCtp5HdgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.87] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id AFA153F123;
	Thu, 16 Jul 2026 10:47:28 +0200 (CEST)
Message-ID: <a2676ec6-39d5-4220-8549-10a17daec668@hogyros.de>
Date: Thu, 16 Jul 2026 17:47:25 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] compat/posix: introduce writev(3p) wrapper
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, "brian m. carlson"
 <sandals@crustytoothpaste.net>,
 "Randall S. Becker" <randall.becker@nexbridge.ca>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
 <20260716-pks-reintroduce-writev-v1-1-ea9038c884bc@pks.im>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260716-pks-reintroduce-writev-v1-1-ea9038c884bc@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> +		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
> +		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {

That feels like it could overflow.

    Simon
