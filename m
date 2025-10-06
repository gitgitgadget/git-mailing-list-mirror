Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF31DE8B5
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759788566; cv=none; b=Y+i+YWrfOYIKl0U8A0uumRGSeIyhueeDPN73qyzCsWpsvddAsYKh53z4Ol/BQmvUtTK0gMInACVS++rmsVKyDqAEgvxyvonyXN3ISByeUeJXW8GVfg5/SuzzAyt4V8g1S5II/crY3C71kZSEpbL/sqwAjHnT/mYSwq+QvT5eajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759788566; c=relaxed/simple;
	bh=R9BpgEMd+GGZgsjI2Oho9U7WamBNfTOo+Fxk9hu1ZQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bBurYvwpqiGYFdN2WRElBpJdbVGr83+b1GsjPVy8Ksl6OtFrV78KS7sFO4SkjUSSiwDnv+d1wSMjMjNulDF8bRVq/Svkd1IO91iJLUEPX11jNCgiV2spxyu7ekg40qutRh9QVx/CeCZqxPa3iMXm0ctKchzhwwBWgm05Ldn0TJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HgV3aa9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqA4yFHI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HgV3aa9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqA4yFHI"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 66054EC0178;
	Mon,  6 Oct 2025 18:09:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 06 Oct 2025 18:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759788564; x=1759874964; bh=F+4K35PYr+
	ZklHwICkarvyL4QCoSPiFcLYCPW4jZ8Pw=; b=HgV3aa9wknS37GqP+bU+CmHFqw
	cj9hmNqUoPvYpzZAFx3Qu9erwY87Ts+FrFH8YF8cV8WNiWObZtgCkB4YAE2os9FJ
	L99CE7DQhV1R5j3baUn9jp+mCeYL2cQPdp7MqXKryBl0BYRt1hsa5z2fKqsWam2L
	2kg900fOyNtZ5DB+JXNkw7Nl5DqApSE40OeYgQU14TOC85lirsocHsYMSOIk4Mq6
	WF9O/bSktwk7PPv8QZVFZsWh3Hs8r6hwd1O5x9Dv5+MeqPKoZVu+pdMVsNLpHxgc
	KkvAcgZxOvI0Ey7CXS9oRpXXaOjmIdFBVpDdWSIVoyrMaJqkvo40TFeLM8Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759788564; x=1759874964; bh=F+4K35PYr+ZklHwICkarvyL4QCoSPiFcLYC
	PW4jZ8Pw=; b=KqA4yFHIxMc5O7SovD0koRMX9/FegILIoq1HZDgGjl2Hvo4sD+b
	PaZrFSacB7TyY/z3SdPHyY+5KY2BIFxphKB+SAE2Sj6UArAmmSKvQYtB+V18Y9FM
	j2asTeO+oR5av9xnVLFQjOUTzOENxiwgCaBAMdTtHaTOuNPNVEKQdQIIy8p6cEdR
	kgHd3a1+3VsyibqCPUC1nReWmyI5nbx086PxtW32zgEXzqo5OtBRzCzzUPKFL4ak
	x5P2r0AG0NVO8IO0CP/GQzHScdCeeTGZkWNMjS3x60HY+V+Kgti0/J9YPY2ivMQo
	PwUuWoqzFrJJL75XtuUGMNplQH+B4yIPAFg==
X-ME-Sender: <xms:FD7kaD4qPTWowSGZH2Q3Z5HccgSEhFzaHN7mXQFcPT9M9NhlOaNm_w>
    <xme:FD7kaMnxl0vP14KBH_VutgJyQo4OuoK9FqpSNtfBuPcEGrvNP1bllixVL5l4F-hPV
    4n1oqZ2QNNsEiN0QjCEcyUOlqFNd-D9GjybnepP1buoWZ63N-JNkKo>
X-ME-Received: <xmr:FD7kaETj-y5Rrm-JqSSkaMWV_fh58TjNc5-BO3Cm6kk6KB1WyL71SNS82w10u1sjl0SKtFDRMAbhcErUjWS4iOVFkj8r5W547Ap9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FD7kaLFLDK657t_hZS_vUdCe7xZk3lSUEYCUfZJfSFddoFkILIIhag>
    <xmx:FD7kaJEP39IUg9tV0XmLLHfOXnwANCE8b3hNlBP-t8rkzG_n_NQBCw>
    <xmx:FD7kaJQF0tf9Mrzw_gglQu10EAFB7YX0FWhQizi75e_5SCJj9nguIw>
    <xmx:FD7kaKLO5x-qYTUQZSeX-VUjgB6yKHJ7b_ldATMv2rWTojJf1jojdA>
    <xmx:FD7kaFqMMDTRuHg7KbmBz10iGh5gXYjmPaDa62HzXRA_z6bMY6X6avvo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 18:09:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] enhance string-list API to fix sign compare
 warnings
In-Reply-To: <aONhmrE0otiyZ16f@ArchLinux> (shejialuo@gmail.com's message of
	"Mon, 6 Oct 2025 14:28:42 +0800")
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aONhmrE0otiyZ16f@ArchLinux>
Date: Mon, 06 Oct 2025 15:09:22 -0700
Message-ID: <xmqq1pnfof71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> Hi All:
>
> This is a small PATCH to enhance string-list API
> "string_list_find_insert_index" which has introduced sign compare
> warnings.
>
> ---
>
> Changes since v2:
>
> 1. Enhance [PATCH v2 2/4] commit message to express the motivation is
>    avoid overflow.
> 2. Add comments for `string_list_find_insert_index` function.

Thanks.  I didn't see anything glaringly wrong in this round.

Shall we mark the topic for 'next' now?

