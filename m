Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BB17B50A
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898551; cv=none; b=R5vwROBWBAE9CTTAvJwCLAjxA4IPqg4U2xOXmlU96BTY+uC+cScqrm2umWl4KSDnEvsC7MgbsYKwuOsTL3vq4rpQyJXeXBe6JcVKVmEhgetgRXzP44zv6uyiuhHSSN+uPCQF6c6cpdUfFQcf4FGTh+FwX43+F9OTUOfC0hWSjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898551; c=relaxed/simple;
	bh=CvErBWgVQjVJWlC57Lpqn+mz6VlODvHylmjuUOmGqm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hhLRh2ZQZEt1j+qfw5gdzLRQGL6hJ5SCMR7lkb04CZD4dpRXyXQc7Y7p8EAfHaBuQdJHPR+6lWjrJpqJXdFVDjCVJ/JgaUpIstCjmEz7VGoJrTcwzO8Wj+Kx7dGIcju/DcZ2XxgiwEouw5tIB6hPh5q7HJxGfl9Qs8NlvKYFthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mG/Q8C4B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=veB7AtqP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mG/Q8C4B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="veB7AtqP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6CBB01380986;
	Tue, 18 Feb 2025 12:09:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 12:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739898548; x=1739984948; bh=yNLbsKZu1e
	QpkQObMnCYN3wjLwaLRg294SvKS+Earks=; b=mG/Q8C4Bq7v+kpJBslmy4DiD1J
	NQEI8INxjXT14jnox608wpP0jiy1BeC/dq6YC5gZsV1hOnJrAFtDAlQ0gHqg0cWF
	RKiq10VrUuJDDwa1fUxti7VWWUdGP4isskFVLb6UocIzvks7XJyeqKSYC2JEf2m6
	BepswTb1YmA42C2oQvw9lv03e71XaCg1cxM4LpVB9s+xGcig0zUFAnujCA38j6v2
	Qnal7/PxnMLoj2WuCzaXO/R0Vgvw02L4gTJG/C5oSmHR2R27FLkgX7ygEtDvxl7K
	zeop09RvqCxQCvudS7B8Oy27srnMBRaGg9Xy20iqx0b6Sd9n5nRIQYmJGR7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739898548; x=1739984948; bh=yNLbsKZu1eQpkQObMnCYN3wjLwaLRg294Sv
	KS+Earks=; b=veB7AtqPWrQqiVSAqy5/97zqC0fmCFgXALK5agNuIjKDWKMoqb6
	ST8ijz04n1iU7AoNxDis5JuKCa1junHj6VKnRPfg06o94eTl8Yr3xqeKMGQEje2P
	cAaDqDdthHzAJCKm22QKKYd7ZBaBKugXLjUSJuSUL65vZBbakOvBmsNcO3rPffev
	DTpG/SWQ1QP6e8M2cRaonU6MaYkQ0JmFh9kAgq1/okJZF2f8ARhYU8a70SvKvg+R
	IU1z9lP+AwK9MNB1NGHcp4bjXqR481eE9I/HuFyAr12tsPTwAjQdjPbjcEqoD9TX
	AdvCIt+kPBczT9PICKtjguaMNs2b4DPYnwA==
X-ME-Sender: <xms:s760Z7anM-CPOsAhlHUnyGlsV6wXswcXNHZcrrTqxXrDM3uu8KYvVQ>
    <xme:s760Z6YIapbgwVOoPHbVE6-Kxyvd52ZQMcBkB5vyO7HISxk-q26bkUV-Q1uwy1kzj
    tLESmXEYBr5sGM9_w>
X-ME-Received: <xmr:s760Z98qUzO8UNmLblLvchqFX6h9vs5w__jVVZoUvvviDGHiS_MUngyEhZlf1rbXtBP1qyz71P_ngM0fr41_H4IfLWyogxLlUF8D3qc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgr
    nhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:s760ZxoHZb_nIRvlik5P8-Ct9hxHY8x1z7nOl0jGgdebTp4CdnF32Q>
    <xmx:s760Z2omoZZhcuyhNd7dv_ntbEQb9chumuSpxhYtI3Rkjr3J1HT3CA>
    <xmx:s760Z3Qzv8Gr-f0x_FDTVLPgUUL-vBUSPUc8auyhvIs5FOTHjlRwIw>
    <xmx:s760Z-qxMMCwl2IS1jNdcITA1p96aAWOhbOt725fBD90fd_rVoX7tA>
    <xmx:tL60ZzQLGb_ULn-SiPZpqmv-oV2cCDA5lhIYCDdnF40oJlmpgfWjB2Kv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 12:09:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  Johannes.Schindelin@gmx.de,
  git@vger.kernel.org,  johncai86@gmail.com,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v6 0/6][Outreachy] extend agent capability to include OS
 name
In-Reply-To: <20250215155130.1756934-1-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Sat, 15 Feb 2025 21:20:46 +0530")
References: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
	<20250215155130.1756934-1-usmanakinyemi202@gmail.com>
Date: Tue, 18 Feb 2025 09:09:05 -0800
Message-ID: <xmqqa5ajyyby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Changes since v5
> ================
>  - Used "-" instead of " " for seperating "version" and "os" in the agent string.
>
> Usman Akinyemi (6):
>   version: replace manual ASCII checks with isprint() for clarity
>   version: refactor redact_non_printables()
>   version: refactor get_uname_info()
>   version: extend get_uname_info() to hide system details
>   t5701: add setup test to remove side-effect dependency
>   agent: advertise OS name via agent capability

Overall everything looks good.  I spotted just one nit in the
protocol documentation update, which I'll comment on separately.

Thanks.
