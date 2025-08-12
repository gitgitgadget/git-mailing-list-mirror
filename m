Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928B2FE56C
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014533; cv=none; b=QHc3BC6HNE0Mwld6xn4rUjBp4khFLAdl0EmBoPj4SoY1mqD84OmSsP4sm6nxXiyIWWqzpBtEPW45ubMh41MZ24+A+2zkUniJg+lGejN88Bqc/0PDRIFnDnsCnqxTf/On5aig75dc+AxWD1bXLgfKQK5HV1jVb2pvZSO7/k3d0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014533; c=relaxed/simple;
	bh=iCS8tjesXb7QqFHVuDVj4XhnyCntoZddhkM5QhY6JKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehJ2WdVhB4WMbIFdJ0loEmIp9eGmds04C1Rcfr29sHUi8F1q80blgVC1Vt/29I8jkW5AOGxd9t0PtfUgdjpZhOhGksNl4BdHD9NFc7dlbVKutDrOJGOzqD3a+kQ8x+oP8ighl19Um8K8NA+Z2TssZQy5olS1gnhaT06zPL7zbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UK9EBVpl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+hpciik; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UK9EBVpl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+hpciik"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D613F14000D7;
	Tue, 12 Aug 2025 12:02:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 12 Aug 2025 12:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755014530;
	 x=1755100930; bh=GJNio6niYCkNPpHS/axGGg/kecC69/72p0q4exdXb8s=; b=
	UK9EBVplyCI6cwoc+W2mAfF5bTgBRBah/5zmmPoMcB994aG+cBCscKm3ysfzfyFp
	HgoT4rl1gdqZ4m8rRXPzsRlBB//XkSIUMrb98zU0Fz14ic/paiNmMznZnJvDAaFm
	i9wEF6TNyz1AfIfcdkzrJSI1mZX8aTZalWS6kU30hiJZIqPDnZWii8MPJvgGlfNa
	HUAbWaHteg8Q0jgMMzFnuFJhFVb3n18q1WcbzFkW6mMsAeaKnxPF55vA3QhlIvQ5
	NuAkYe7oiJBs68oZBA9ZWHUa5oarrzAXAb0HVRk8O3jhIWoqQkHEWbf+QjbY6zj6
	0YAVS4yucJt34IJOTPX4kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755014530; x=
	1755100930; bh=GJNio6niYCkNPpHS/axGGg/kecC69/72p0q4exdXb8s=; b=L
	+hpciikWpD6DgA07kA+9GuKZm23qlS5to74nbEpbIoXOjrxv26adcjOxiynp0MKS
	Mz2xvRlXQpGDlMBTWamHIHPtR+IAvHI0B/B0p0QfEr4DIq1oNylihyCKHfqG234x
	ql2DavDSipyasDn+kbtkIOk8JI306FTHT/kntaINYw/rIGaOjZjBA9h2Ipq6T6KK
	HkJ0CwhRlPWq1VYdL8YxZIeL8NPjwM4L9BeqP3MOXV89pBpzr6Nvx60JO2EAOpjt
	tZEZ9J09tMVhYNkN1Yj15aFpUkQRq1Be7LLesVW+JCRIjl9ij3BvIsok+xV0B/uN
	pwx4P9T4NIt2qtveckc5A==
X-ME-Sender: <xms:gmWbaOkS9ExZvsxG450iEMz3JsejhRNupynfAMBOC4UYfu-macqVmQ>
    <xme:gmWbaJFrM76EKm0Jtfeazg1KYjBhApVREIjABZjuxXGXk9tR2fudjVBXPxTOsIw2M
    LQDCxsg-jQx6uU5kA>
X-ME-Received: <xmr:gmWbaGGW__78EnirOHMsEf_3CPTXMwLPrzsatC_0DawEq_h3VA3PtuJgayqC6FMl0KE-blq1Y8CbB3Ly5BP6y-3ZXun6xVolzWfFKys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gmWbaOOou13CwIWwXAjTdTcEWLy2HH-X0SAJS6Q4f2DM5y5wqMhUsA>
    <xmx:gmWbaNFbeBg1HSI6BwhbA2-DbeAqM1GH1H2IEsb8O5t9GXoALiZHUg>
    <xmx:gmWbaNPnO95CjOZ9ioUfHVNgF-x41MEPeKVwcYZKxQhTWqWlD5J-vw>
    <xmx:gmWbaG8HfIVRFlb4a8gWq0s5NufMcWx4arjypR2Z6qukcmBcQ2d5Aw>
    <xmx:gmWbaHWVBS3W6h-0EhoWZbmD6n87gtSYB0iel1pYH96LAJHbHuk5r9Z->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 12:02:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #05; Mon, 11)
In-Reply-To: <5032416.31r3eYUQgx@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Tue, 12 Aug 2025 17:24:16 +0200")
References: <xmqqwm79x7ra.fsf@gitster.g> <5032416.31r3eYUQgx@cayenne>
Date: Tue, 12 Aug 2025 09:02:09 -0700
Message-ID: <xmqqectgv88u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> These patches are designed to not raise false positives, trading it for 
> letting true positives pass through. For instance, the "synopsis" patch cannot 
> catch keywords which are just one word.
>
> If possible, I'd like to see how they behave against upcoming documentation 
> changes described in this "cooking". This is in order to not have to revert 
> them at some point.

The topic being in 'seen' would test other topics in-flight
concurrently with this topic; avoiding false positives while trying
to minimize false negatives is very much appreciated.

