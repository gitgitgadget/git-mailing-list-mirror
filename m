Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F51E5201
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693275; cv=none; b=WkYU9xApu1VCtBZv/N9a+c58nLKaCGeSqO3CG0ufCzzcAHy37RLxvSvDUQNf7KWvsRoywzG+FDa7r+xznG2t01u0vVovXuyFspv3z1/vPq3H4b+EFNdiK1YARwz5W/xY7d0IH8Gp6kyHpw0BL1JbIemI02hhE0JfhAD3RQ74kR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693275; c=relaxed/simple;
	bh=hd6fIRR50cbkTJKvKkxnFfRnWEs7jTY3/xheJuG7Wr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+X4mUh7yPCX+qiWwkg6wjb0mgk9YIvWs2QSbAnZRycsEKvDlqS890xG8A+X3GVqPVxifBVCo+Eru+2ReIg/YCyFmSp5C1DysG1jsZYjnzZXWfaJuSP2i5gD0XpNywqch0hVRkyskqKcR2t3ao2Gd89lIxPaUDwPwbECYh+eOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F5sPiw4l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbloEP3w; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F5sPiw4l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbloEP3w"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA040140007C;
	Wed, 24 Sep 2025 01:54:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 01:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758693271; x=1758779671; bh=BmPTkoNQmc
	pxKypJ/Mrp6eVb3rHZqAxixh/3uzjeOnY=; b=F5sPiw4lKFkHO2SjpxYgiTtZC5
	UtHH1Y+Jo4xUY3G5zIXJD9Ia3GSMJ1VR3hZbPRKk2hwYpjdrYEv2ks5i2p+1L8EY
	I1cQRn/iLlYsXrzVXu+ArqgkKVtBUBl8Prk24izDmxDpqja9V6KIRA+C/T3Lze0J
	26nLqntkMehIic4L2f0h4A+bUnxMAyxxms9yJxLvJPHc/EEtCgx3UcJCkNajLI9x
	rtHWrGeQ8kSsSSHENIgkRWAzUPXO26jF6Ojp5wjnwbEIp6RjUSVf++FlgGWe6LCI
	Bn/2SLQk4f00SMH8eX2YWSciobjN9TdI+ldX070pwiXrA88a6Z3OIB0X7FEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758693271; x=1758779671; bh=BmPTkoNQmcpxKypJ/Mrp6eVb3rHZqAxixh/
	3uzjeOnY=; b=UbloEP3wIuxJAT2WPlDsxkkIZMJb7iwTgP/Rj5xxKotrCGIV8a9
	yWVLm+38XmedhYLz1d0Y0UVoN4JrNNLYiJMYvql8nat4l/pu0lzMHu8LvA8ofMUi
	Jmy3XMXWByGOlvR2f8V4703i+sZqogYgeVG7AKioandytklAQShM0BbA3yYCHDkZ
	1pZZor4cU3soqJQU/Ceivkdjo7+WmmEfdQ1RN/l5o2RZNF8Es4GDt0YZkIQSi19W
	ZDldh95Yr0jWddkmY97C2Epnk07S47imOGJDJPs++wsquVIRDECKU0OpISF/QDhv
	qQ1DQI5VR0IHaO1WfDC1i5zelXN7On7NYcg==
X-ME-Sender: <xms:l4fTaK0xgRs1vDfPFCg1Oo5y0ZkZCEEchlqJlHHRmV5bzrmMQuDPCQ>
    <xme:l4fTaEFVTv3CYuUcWE6OGP40MNDsmkHIaQ4nwuV26FisWrHtaFIpraI6IGbYHZCZ3
    HcyoIwVqi0sovxG4ZMOaj0ktWAoZcYK8NG5HX8v5_4Au1IgcDO4>
X-ME-Received: <xmr:l4fTaH7AyJ6XQz2EjvEFD6Xk6a5P_h03mlo6r30w74fPkA3S_ClbX7OiZ7blBpr4I9SM7JY5AhWxqR7b0e1kdrmm2yLEVVT5f7ZIlWgVHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:l4fTaKs3s4lrF-6vSd_VLWDG5atbc52L7Q4FCf1AWIVLZJauJOvMAA>
    <xmx:l4fTaI6LN-7zj7CTVnpKb8poqgutkJhDWLUKPHmAer6I0ni43MGf_w>
    <xmx:l4fTaFVNhm7Emv0Z9RUZe9vVPpaX_srPUWsv6hi1HuSdKnTGOdppJg>
    <xmx:l4fTaK9e8EACrCzZRu1a39RshZgw9myKoHl--OKnXDQGhVz2VSgIDA>
    <xmx:l4fTaDYwdLg3uKKhJ1cs9mnsWS-4R5OpiEyb_ZsOus_UtER6cCUYrcLx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 01:54:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a2fdb6e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 05:54:29 +0000 (UTC)
Date: Wed, 24 Sep 2025 07:54:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Subject: Re: [PATCH v3 3/8] reftable: check for trailing newline in
 'tables.list'
Message-ID: <aNOHjdVEbCufSCPw@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>

On Thu, Sep 18, 2025 at 10:11:44AM +0200, Karthik Nayak wrote:
> diff --git a/reftable/basics.c b/reftable/basics.c
> index 9988ebd635..75d4086769 100644
> --- a/reftable/basics.c
> +++ b/reftable/basics.c
> @@ -195,7 +195,7 @@ size_t names_length(const char **names)
>  	return p - names;
>  }
>  
> -char **parse_names(char *buf, int size)
> +char **parse_names(char *buf, int size, int *err)
>  {
>  	char **names = NULL;
>  	size_t names_cap = 0;

Nit: Wouldn't it be more natural to return an `int` and assign the
result to an out-pointer?

> @@ -205,30 +205,40 @@ char **parse_names(char *buf, int size)
>  
>  	while (p < end) {
>  		char *next = strchr(p, '\n');

Not a new issue, but it's kind of broken that we use strchr(3p) here. We
really should be using `memchr(p, '\n', size - (end - p))` as the user
provides the size to us. And the provided size should be `size_t`.

> -		if (next && next < end) {
> +		if (!next) {
> +			*err = REFTABLE_FORMAT_ERROR;
> +			goto done;
> +		} else if (next < end) {
>  			*next = 0;

Can we maybe convert this line to `*next = '\0'` while at it? It made my
reading hiccup a bit.

Patrick
