Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09761156F3C
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496559; cv=none; b=nUpk/2lRTrQ76yxx/aUMPMXBIWv5L0G7JmRYEESseyLiCpAt76FEzVCW14SPkp8QpnopCrqNB1anCiluXnz+sZYyBjXfWmqbEoz6viCePyQM/TXWXKJuxZPJ4MuU+wSBKNPP3d/diJNfghd1LorqNi5KkOlFE6VF/SjpYzI5bZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496559; c=relaxed/simple;
	bh=2dhm3Rsecd4iPXR4XCU7gZbh+NNX6lZf3jP0ef+09Bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bLolqOKgcABhX2/Mqzd81A0JQMJ1jDPHaJjNL4tDonlsacBQfhKZoDtbA95C2gPSGSZHX3zMW0chmLstzg1eiLX7nRwmFfgQGumScJ+UfJUxmhGs3VlHwd8gupjvIALoBUidcaB55ml41KxSH3FYQFbD3CO+A+w8w3K/C3vfUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d4rqmiu1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oz0wNllH; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d4rqmiu1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oz0wNllH"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EDFA81140371;
	Mon,  9 Jun 2025 15:15:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Jun 2025 15:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749496555; x=1749582955; bh=wQh7+kbTpe
	+abn1oQxJakjdyB4feSImEhnwqS+wTTUM=; b=d4rqmiu13ovLFJ8i5MVhbwoZqa
	D7bidPyfSlyxMMf47Mq13V76f0LBe0YwALocixZKEsB8ndpNa3/xNqncbUJpuNbA
	HsjHdfuvWl23By3+T+qCv/TaSIrtphEneEPob69yRsRMVjxdrNOyoZ35j/HH4JbP
	7xYUzRNGJcxHRCTlL/G2PF6FL98+1sfQWQW2GsfWkSzxQt16w/1pnsNVgny49lst
	fuIzGT1w9e7yoVpBHJpXKhcp6vQMGuaLyfVCV38RAYeia6AMyLxHUt/cOObI2Hwy
	rMmijmsGB8mptAOnqFat9gqTNC4LLMPYUThaL2HNHJWnNEtOs8cGf5+XgP9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749496555; x=1749582955; bh=wQh7+kbTpe+abn1oQxJakjdyB4feSImEhnw
	qS+wTTUM=; b=oz0wNllH408MbXQN+mz1C+k1Ikt2fiNstFOkQHk7NUZKqNFLorw
	Nk7FkVwCZJYxmbWexp86W5HnZbkU28Qrk/W0kld0U1H/aFIEEcagCSqixGrbvAhb
	F5rF7TOHNfE5xj6Tcizz7T1g7f1jWLIEJ9YrgjOW4YyTEnhYOoK+CWg7A1imtND3
	JT5Zr5CND31jipEf+BL2zGjga51DH84+b9OdWM6NqTcimrYpbexfG1M5jx3sp2jh
	eunW3lXwF7dIZ2/SFH4S0pvb5hfguS4S03a+BQUzL3tMVIs+RVR5q77k0XbVBw9J
	sJ4siPSx9kIMjlczbR1CnsIRdyZY4AE+iwQ==
X-ME-Sender: <xms:6zJHaPVxFO07BS0-1qqBkofJz_fPZ8ZyQAzFmZo3QSLjsbcNipqvGQ>
    <xme:6zJHaHm_6Bt8yO6kTsaq7zNJ22LISU9lF_zStrOGDjXq45Z6wlySZnPU5fyI5ROzH
    pea0By36D-QN5VT8A>
X-ME-Received: <xmr:6zJHaLaUDGcDtgJrItlBdHdHcxjXYpD7vfUEhYx79APwI49o1ROre-Q6dtXRJCeGBLMA3IzXE0beF_IIKyR8xhznmtxZ1Pknaqfb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeljedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6zJHaKVBol5RXqtRCkCOdHImEyRftqkmUNAM9fGadslPFFOXjBO53g>
    <xmx:6zJHaJn1b-iIKfZAx_WDCbC_5XVkLyD7K6qkD6_FI_MfArvF_op8Yg>
    <xmx:6zJHaHekRSZI_qqG_1QwxMRpGykC0CrmAorfnVpidU-yxpmHrv5CXw>
    <xmx:6zJHaDGCux_zRR-z1s4og-eifbzmevPFzsB90-dQ4ROmJlHGMJoI8A>
    <xmx:6zJHaLjVMKON2ocmfEaQ_oCDNMFq0qxmlmaoDau72cM57gEUuIdXqVp5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 15:15:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao
 <ziyao@disroot.org>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v16 03/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
In-Reply-To: <PN3PR01MB9597E68428E7483061E39A63B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 9 Jun 2025 07:20:34 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597E68428E7483061E39A63B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 09 Jun 2025 12:15:53 -0700
Message-ID: <xmqqzfegpvyu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
>  					goto bail;
> -				}
>  			} else {
>  				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
>  				goto bail;

Outside the theme of this step (read: I am only leaving a mental
note as potential #leftoverbits; I do not want to see this fixed as
part of this step) and probably outside the theme of this series,
but srvc->host is probably copy-and-paste-bug for srvc->auth_method
I would think.
