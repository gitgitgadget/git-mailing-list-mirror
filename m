Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84C3939C1
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789308850; cv=none; b=Keo5wyq0i2bWmkR3WoWFpsBTxAoYr3s2L6UuTRej6tQ3b5Et9xPu7T/FKHXrmprCDgWymiN6+KScvnlxTYD6aBv7rHDjlCKRVwJtTZ0Pnh/ga0m9r5OpPg9jNPSA7UWAzcn6xTRD3R2YKKVfp9sIQZLfzDxM53+Up+MyrNHAqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789308850; c=relaxed/simple;
	bh=qHWaRflvSvpgrxR/xi9XHcIS3mUADYOMnPru6rRYHW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlYDRTVFpmYQArIB7X1obuk2giUcUEdHxLraZ5GYpyVdvE2VwQjRbyP/kMQqaU/wAc4POHXcave657wvaea297SuMwkHVADGrqZ9iNXuwUV0Pn55RnfRY+ZUVIFttZzeCiPlwZaMsST5qBFU1wFRXtwZHobmBOHqVCSflBduiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EzMfmFjp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EU8I5FGw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EzMfmFjp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EU8I5FGw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D131140008F;
	Sun, 13 Sep 2026 10:14:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 13 Sep 2026 10:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789308847;
	 x=1789395247; bh=BJix5kat3oB6A+kg4hWFaix8d8zagEZqRU8Ds5uQnfg=; b=
	EzMfmFjp3uDxrGdlJzdp/iip9JpOC4CisDbPmKOZtLw1sBZMtAyCOaUuEAg5x+8S
	9PeHZdUTQN1z6QxI5rbJykv/yQ4ieukO2kqVE5+KYbBqeF6YESkzofONeGh47udt
	/2XoZiAYV6TucgRchK8z4bxn0519j0nCNwtBzGC0eZ3oyXtmaNkTYvIplKsqEYy9
	mBA0fqrYyjUHlgmnRhanc00+HfnBY2dHaT2PsXj7Z/0qK3oa9Sr9ouAYslZVJeCK
	9ZbljBxs3Arr72F7cWAIk6MOGi8IB0OhOKExFCWjP+UKsN8SzhXLOPZZHEdAfqzk
	qyGXmAP+0JrPxukvJwMdaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789308847; x=
	1789395247; bh=BJix5kat3oB6A+kg4hWFaix8d8zagEZqRU8Ds5uQnfg=; b=E
	U8I5FGw+fS4LKXD5G8zdntneWLLJlPpniNJCaSw1zZ6M+9lYA9i8zTxgGUJtiZaw
	2mQ1Ls0ErcTFz/cXrdbe1PZKpcQlVrn25d4IlREwIQ5lbndlIYEJX2NVuXKvJYNs
	ma7tIBOCLLZp9z/tzRgvCtEUS75mR6Ffk28nv/SzuyAc2Cg5QwH6fX56mmfXbh/L
	HCqERy+j6aaWiUMsaJrn178OMJJZkCvcmmcCBz9e6waH4bhEWDS+1gHlk7+/aHNo
	397yIcMUBQX3ImG+ZHTDPph+J2gB5r1QzTS4JaLVcbWyRpfx5Ysvuh0FMblq0Jzg
	AHMOZIDrL931Ohyk6T9JQ==
X-ME-Sender: <xms:r6-malORMXkKhwjIVJQc_cE04ZzE3IS32XMYlBq8z1efGKisHOaJdw>
    <xme:r6-maoJoeEkWlTFVv0-iWE4ikv1p2jd2i9nOahqYrdRtB1cZbGewRzpe44B5JrcRJ
    TxctYPMRGRJFHv5o7LsIp2IsJiPH8PTlc2ETACQjz-DvybQFZpNfnc>
X-ME-Received: <xmr:r6-mamGU27EaoElMqLLAtuJHnMQfXfuTZ1G-00q6cRXZ7rSmcPsz6Vl6jEgg9lRd4Xpp_E5ltLDoIEEDY0K7M5Dx2GnfyGI5mM0QKYNDjhBHy9Mac55qC_s>
X-ME-Proxy-Cause: dmFkZTGKoTWScxBCAsblTXvwkjVkw57mw3hIGyPx79bEVR/yfD6OdJ4gOG2gXMKUtWDdom
    8NuvkTNrdy1DXO0tRWIgJqpSrVRxCgAA8S0t5QTn8w5qsKhrM2JDwGycVl62IYkChdorJT
    s8m7B7CzETKwG3+i7z42IcxJrN5Twc62ZQ18L07ml/+LIq7l2Zbu/UHPXqwYyRyLRnmusa
    EL+9mfucw0Wng8IkynClopWri7/J0XxJWL57boIxCBtxC38apaR5YoYRYa7ilMessvU8NN
    uZFNSQcig8ftmNkEmXk0Xo8YRbgfjEzX474581tQAlHvGFhYKs/rhKliep15SDo6fGierX
    T2R1K8N6fO/F3l6EaeGSPVJgtiLrbOr6/lfuDUyVf5hAbnTcJHEsIiX4wmXVsPH0OgSDdz
    luo1GuMW42EhLMZ0HUtzriDF1TPq6Apb3uwuDYCk44MDxhuNIq0MJrrmAteRG5tVnEkWBg
    dlhPvIsf9g87r1rropj2exzMf00TanPlrN9E0Ew4z7z0/PET8jQWJ/ZAEUquo34UEUd7UT
    y9WKJyu6hrD1MuQk07TpcOAX+Huw+FcXY7/1dco+hzgmMwwY44MgWVMEqUS73n5O0yyl8r
    xmpmTpFvgipJwCEDexkzXs6acJz9EwmcQ7kHhvh3puTYW9O/eyMs2rMiwtJQ
X-ME-Proxy: <xmx:r6-magTR_9I0Ht5NSf5TuL3D2bIHvLKhnDeouCVuLaLbm9JRR2DhQg>
    <xmx:r6-maiGC_XGu0QCf4Gn-NPp6y8S_G_kPTTCcRUWwoLdhYHFIyMZDmg>
    <xmx:r6-mas_A2rvO1-h1XbA7MQTqvDvGq1snQOOEI2Bu2aaMOLvahAWGbA>
    <xmx:r6-masIJBHim_NmF5ACgDlIAPIy5XIg5VRX_XnxBdS06Cx2lUQDV4g>
    <xmx:r6-manyy3AZrRCa7pAODBiWOQNFsdhLkSsCxBTCnUQAyK6C5IzwLl-6r>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Sep 2026 10:14:07 -0400 (EDT)
Date: Sun, 13 Sep 2026 10:14:05 -0400
From: Todd Zullinger <tmz@pobox.com>
To: =?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] doc lint fixes for pack-refs and refs
Message-ID: <20260913141405.Dcx5xbe-@teonanacatl.net>
References: <20260912191509.844954-1-tmz@pobox.com>
 <Uds1uZlUTZi1p6vFK4zhWg@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Uds1uZlUTZi1p6vFK4zhWg@free.fr>

Hi,

Jean-Noël AVILA wrote:
> When I put this linting in place, I was specifically targeting the options. 
> The other cases of use of definition list could range from commands to real 
> definitions of words (see gitglossary.adoc and git-add.adoc), and extending 
> the match can trigger false positives. Backticked terms are supposed to be 
> immutable for translators, so this formatting should not be used for real 
> definitions. 
> For this reason, the regex is restricted on purpose, but selecting the files 
> to check to allow to extend the range of checks.
> , 
> FWIW, the proposed change triggers false positives for git-add.adoc, git-
> push.adoc, git-difftool.adoc, git-daemon.adoc and git-fetch.adoc.

That's fine, I don't mind dropping that patch if the false
positives will be more annoying than skipping the checks for
commands and missing some of them.

I'll wait a little before sending a re-roll with that
dropped, in case anyone spots issues in the main patches to
the pack-refs and refs docs.

Thanks,

-- 
Todd
