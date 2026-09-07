Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D556381B1D
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814718; cv=none; b=eUZwyOzWsYjhO4MVyBwruZWjdu2gp1lyb61VkZMnUxYf8K5wbTf7uXOShV7O07Xew6Xx+O0AsKnyuskPwfn2YX9jmY68HoxR6GCltSClVEBkBszV9NaCm2Y6eMsdvinJWQE4R//nEYdwZHW9YITzPW4aovR9PI3D+vGTdAN+hh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814718; c=relaxed/simple;
	bh=qI26owKfxUZ2qjwJ2fGkgHTFwVI/ZxtYGnL85hsB5h8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPLzsOF5jYOBdt+VK7I80YVvYaInpXNNosiIPOyFvrEs27LZ6MgJleevgfUmnnpq1FbwQ3VDBUKjDQiJVq/jtwdBxX8m7kN31ys8fUEaln5fSXteKE3klSaYWLbBLpGi5rCzm/2mh/B4TDnf2G8GK8jurR7hzqHqlrmUhKPItZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sGL9HokM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V8pzgsDq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sGL9HokM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V8pzgsDq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1801140016D;
	Mon,  7 Sep 2026 16:58:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 16:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788814716; x=1788901116; bh=lqD1vl3XL+
	I1U+kNkgj+L8KTOtpGsA0JBDvCLmqjY78=; b=sGL9HokMZW7Xya+HUae9S2aN+9
	rxfQMKW8hKpz3FfqybQ+y8e7s5YfNg2BSbXOjVVDsrcWW18DXv0btuEG10MRH/XR
	Qf3Z4ALXnfjRtqiaCQArnIsTr2cRyfg54PTzbBVl4QMtdCuchslGUIVvNCgS0+x2
	lSgoxMf+WOwzlwBCDdX2VbI/9WEAorVCx49wMa1SZgF8SbiK6/kDP8i0Vzj1yyvu
	PHAeDkNPkCHK32aNrqFm/uF9qibN7WYT0jtMy13P91qxlNVuN3kTQ7MFSoLvOOvl
	T7tY8xvJ4R2dpUhCwRuK536fLdfqJCYQvTEWUjgGJi/vQzyo3DDo182iCVmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788814716; x=1788901116; bh=lqD1vl3XL+I1U+kNkgj+L8KTOtpGsA0JBDv
	CLmqjY78=; b=V8pzgsDqAXe4PKa/HiTC48sZDCAB9ARawekIBEmJy/eenwOX2bm
	0TrTsTp/vJOGyaqgyAcztdwnkFipIMWyfF1zdCSZEaVrIAUSk2dfFB4ZvFOsq5Bc
	ok2SWIcHyv41e4EIdT2aBqUvS1PL03g9S/mqIORiIj/aukSnYRu9xipAb5tMnLvZ
	qtCELGBen3TBmnOcUnoyiOUzKPPp/8REXoduzubea1kMMQiGfwv2x7ustswueVDj
	peaiEuQlESu1H4Qfb0WuvD7svfIDtLkVKhO5gaugwk5SnuNJqnkLnRs2dfxtsDBk
	DN7n/0rdCoj6mhoCnOb2xTvHWAPXiVPU9xw==
X-ME-Sender: <xms:fCWfavYVZrO-hYsCNI7hglJnDMcfbzFleL8jNdgYYPvkkHMxWxMsew>
    <xme:fCWfaiMyr_Q8-F0mKIrfwOhV3jgVpFYLOZzhAF4FyyKr0CRhn_YxVuORoUUJZDDsx
    kgVY_FBYX0zpU_v45518lghZy8Q5kaWQ6hHu3B8d4u0fouCjjTt>
X-ME-Received: <xmr:fCWfarAqNXq1QVWo675DKXiS_GSA2TjNmFI40pN55IKjzaXIHstlYAnxTn3mT4VNIoWph-02fiBhxDRMqqINWO8yw147ALUpurJG>
X-ME-Proxy-Cause: dmFkZTFVjkzS5xycwFW9NTlBkmjVUBIxH6AA2E1HBluhBpMG5cbkRIYecbVh0fjd1uKHIN
    mPZR4m73Fe+at0R45WJ743O/GaAnUmR9L7vrWhX9aNvGwAROue/HS/oEHySuhRLL9NU7Ll
    G9LnYNE4djT4CdmNunpEZ3BI3Gnlb1/bFmZ/jtd5rbgSblvl4cOZpP7upYYV7KVQPwHL27
    IO5elMQI49pB1dOuuD9CaP4ofqzwIxUDiNI1EO5bUV8hncu7dirfl7jNKSMeuoDpNeEZaf
    8JIxJkT3XEOAL9lGJ04OQuMZ5iHPyKCTFYGhpZQ9+l295aMIF2sKNrhYcxNYYXzwDr/vFm
    LfntuPDeADFYwn7X++BpE2W615U9dHDy5Wp3haSqHHXHFVGInEZOgbGthAXvHjMteEHXYz
    pRorSGPcrvnnPrzvOoo6rVNow93PTiLdArV7+l6OHenZd+5BPdqo54v7DZG6hsU0OQmO+H
    Me4676yWbPnfcgXMV7c4YibCXG6FspcpzPAAMHuaQDh/LpLeVYs0crFvJy2Fskelg98Zny
    spvyi+OFCuMjt6m6JWYki8WVn0MrWALB0Gywyxr4aqpUxZqFfBfERRoiuFGmRR9eJiNXYa
    MdR7K3VnAC2Vu2wRuu+YE7A1b06xdteoPd3lakP9YKhmGBl0Br1U987JMSQg
X-ME-Proxy: <xmx:fCWfapKoFzuI3Ic_ROjFT4SOw3NeKM9jBgcmuityDsGQSAi01PC5yw>
    <xmx:fCWfakPthvsBRDd1KKMp1e11g6r0AScRXECsYb887PhD2daWLqxqrg>
    <xmx:fCWfan717bgHhZg6nyaqeLU9ZZciUI1vaM6LIeGp3kLmLZtZqXp-fQ>
    <xmx:fCWfam7Y8ZCp4d31u_Ou_0OewGvo1RvNGfnb33AdY-pqh7PDA-D-JA>
    <xmx:fCWfao8R9TmFJ5VHnUR-M1FrGcf00cnzPcSUtE6ED3-VUnDG9m8W2Zps>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 16:58:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v7 2/4] receive-pack: drop static variables to track
 report status version
In-Reply-To: <20260904-758-introduce-hook-v7-2-6c66f0a3a572@gmail.com>
	(Karthik Nayak's message of "Fri, 04 Sep 2026 23:28:50 +0200")
References: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
	<20260904-758-introduce-hook-v7-2-6c66f0a3a572@gmail.com>
Date: Mon, 07 Sep 2026 13:58:35 -0700
Message-ID: <xmqqv78g22ys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> +enum report_status_version {
> +	REPORT_STATUS_UNKOWN = 0,

Missing 'N'?

