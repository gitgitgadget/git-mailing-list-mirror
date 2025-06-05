Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF420298E
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110405; cv=none; b=eBvoLU72r8WVczBfqtZd/0K7eKRFTDACXm/FkGi+wEulMGlqHjA7VeTbU9WQJbY13fHaffiX++tZEgWswGDUw025GjZN2CYsnSCHWWMHXXtGvu/22bbiOfkDBk7AU8u78GcqlmQ72abbN2rCvuQjl1Qlpe9IYpft9wnoo43rIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110405; c=relaxed/simple;
	bh=DPHjFJ7jBxiF1JddYvbBs+UbT0/34BGhx8KbNB7RFSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+JM48KNf9mWdoGNBX06r+06EA3W5BSp2emZ86r16HkCLPr/YDxqQamOrENsbqSNdP+aBLk3/ISivPF8HAmKFJgTTmhtoac9SSTO05Z5sOCaTHeCwWvaZAK+fdNvBUTbZidX5jzxF1Wq+o+GpQweApa/UPj2dus4/lLuqtpMWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=A4RiU/Ml; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="A4RiU/Ml"
Received: (qmail 17380 invoked by uid 109); 5 Jun 2025 08:00:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DPHjFJ7jBxiF1JddYvbBs+UbT0/34BGhx8KbNB7RFSg=; b=A4RiU/Ml9EBtnaLHpDkWpW+M2J9ODfLhq+EEeIfUDF7P/bT/y3D9wCo6kuFY0vRLSoL09528mpM9M5pijGuZgt8ZiC4DN0xRpnc+k37ZursTSOw24Um4rdEpNKVUmxIhPqOvU88pvx20NrQZ0sW2A3Qdc3cYcUdC3EHvxzHRTzITMvpTp0WucBTIPaVjgB5DHZsgjl68md6qH7SliWmSttttIre382QwobFnvRyBZraQVB/qIh4U4tTWSVIcrtZHjuFNNjn/ijxJ2YHZB7txW9XbSLIJIHKUELDFKD9+WwPUbvDJDMUehZce/a73lYCD/xFbXt/kiVWKWZdu+bI83Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Jun 2025 08:00:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21623 invoked by uid 111); 5 Jun 2025 08:00:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 04:00:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 04:00:02 -0400
From: Jeff King <peff@peff.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v12 02/10] imap-send: add support for OAuth2.0
 authentication
Message-ID: <20250605080002.GA2998537@coredump.intra.peff.net>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D1C148578224A02B9773B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PN3PR01MB9597D1C148578224A02B9773B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Mon, Jun 02, 2025 at 04:29:33PM +0530, Aditya Garg wrote:

> @@ -1405,7 +1558,11 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
>  
>  	server_fill_credential(srvc, cred);
>  	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
> -	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
> +
> +	if (!srvc->auth_method ||
> +	    strcmp(srvc->auth_method, "XOAUTH2") ||
> +	    strcmp(srvc->auth_method, "OAUTHBEARER"))
> +		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);

Coverity complains that this "if" will always be true, since one of the
strcmp() calls must return non-zero (srvc->auth_method cannot match both
strings!).

I'm not sure what the logic is supposed to be here. If we are matching
either string, it should be !strcmp() for both. If we want to match
neither, then it should be &&, not ||.

-Peff
