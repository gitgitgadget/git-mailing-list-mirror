Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20952CCFE
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169395; cv=none; b=SIUGyjFH8Db+lwKwU19YAfqX7dRSGV25TNUyu2bF+mgZv7RbwmrDi2iv7Qqcah98ab12C4DEtBP1zt+MNDPMzF5CZMDivTbSy4MRXIP8gW55p5Rk+qI4HEP2G4iAqZKEURqK6ovHp67n82II2s9C7Nu4M3jEaBrER5bZAv1SMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169395; c=relaxed/simple;
	bh=4mY0KZGd/cXuW//gF5ELb/MjAv2r/j0m9ozwlDkfsi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1gCZ1tP9XvbCjmYQwHM4XJGy/dDotHu9Si8MUgVqDqvqDTL9AY6iDNJKDrUQPwyKNu+csSazXTubARVPc4CtzMXUG3tdcw9uwdqZQc7FC20wxjnhJUbWzQFeF7frDwoZrhJWfCD3jKE0xQjs9IeS4CxmjW3Yj3fNx1BZzGjkHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fMCUvdD1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VDJJjg2i; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fMCUvdD1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VDJJjg2i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF1607A0129;
	Wed, 23 Sep 2026 09:16:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 23 Sep 2026 09:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790169393; x=1790255793; bh=trqz7UnDAS
	e69cIr1z4T9HTZkigIRYTRbcfE7BBgKOY=; b=fMCUvdD1XZBiiT1jnogIpCGSfQ
	z9E1zZZZ9bDIIWQx7EoydFpy47AzxQIHwQAjMN8pTCc5fgWM6cbnP1byIEdl1yZB
	zeN0bg572EphjhI7UR/WW0ew0+KStCf7Ci2x9uJcNHwecFnjWxDXbLOzRh012QhS
	L20+O0GGmLiyHY/0lSn41tmqEDdKQ3pSpDYj1L17UUvI1hH5eUWcV03PRtjiA419
	xKNttT5XK05rAYuxsEX70+HA5avgc8hXBsjuwjf4vq/+AF4aHxrFqqGlgMNF1ldM
	3yLsEb2JYTRqfC7116FIQcPGFGlsZdSxyY1v41LrtjeXE6fe8fEqmxUP/J+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790169393; x=1790255793; bh=trqz7UnDASe69cIr1z4T9HTZkigIRYTRbcf
	E7BBgKOY=; b=VDJJjg2iZ4ScxTLIT1z/Ftnf49bwDlT0IWKpLnkeBQerwUPIJ3s
	T3mB6ZtRsY1F/LOaHQboNgGYqpOhXcwJ/1DxFPIe92eyHwckckzC1WF/YpW2/9im
	dlnfoVs/XubuOJDWqBU1Lm2Hnp6P8upykZU2ktDczmB2RZKaC2K6pJ0EWZD1eYeH
	TZXjPF9CXptwsksYT8fcB+DAB373VktFe6viDzb8jBMdVjkwKQk4WtTPOn4hF1L+
	mTMfZyPWbgCqrYfHClCNCV6b1B/mdXjIdxo5dqMUoV+X3vmWP6GBTdO5PT3GLjm7
	BOZH36M0tCSGSLZQkNl2C1WrzykjN6vn7lQ==
X-ME-Sender: <xms:MdGzakUEmjH7K1Sp4IokSL-TzUNqo-jU7EFNB5C0k2v4JbZWjtMB3w>
    <xme:MdGzaulumRzRt9VNDGkLx7VkM_cpujtMGRvzOBRUot6_K9C8LPPTfx5k_0qSFFxxa
    ko9C8LSbgsxp824gsqhl52wf2CkihVB1AUO3E4hVxeky6EI_9TGCA>
X-ME-Received: <xmr:MdGzamCFDojP11z7nGUHA_a_RRHUPNgwxSfFrPv4ocLb8nvmKzw67A>
X-ME-Proxy-Cause: dmFkZTFa1hixJCekOmaJB6nWWd1s3QrVXiTY8NHwhWqFBzRieTg1OHaRdoWuNDZz2zskZb
    rfrdf/bNe1nZIKP3Qj7z5lsT3DU/MDgJgg/vumkR3oBFEoycbYKKZjqkcEmkszlFI+6DvO
    CKT/JAULBavls/72OmW2AGizQUUOYNe9ExeMXGbQCdvEpVnBvBuumuL9kXzQPCeMEDYiMO
    wHpw3GAqPNPw7IAg4+hW2CORqN4pYwbHyJudTq1zBGxdEK1OwXVoKY1fPVJnQ5+Y4qjoel
    6Z4UOfphnkoLzQ7oeFz37TpRJSX4xfioiueDKH+S5N8l2WuVlWJ4NNJcRWUZvdAS9629a1
    yxJyO3utKWwMUOhj7YzcQAjqUnLy2NehAVKIKpLv3ZArzeXrEScjvHuZBVuvzF9f0lEQ/X
    iz/Qmr3/r83nRBTreCtTmzRUVRO/Ud89eHiZukOLuvQ7z6YBHoOtMaHUk4KMIpTbsBbVdN
    HaU99wAAzLXHbXOTAfNx1wiObaXU9EOMeQtKrzTdEWin2sQUe3lxD16NrmBWeaBGw6zlbX
    RXYqA827/oOcPmAashzgDqPUyLidKVER7R8q+8/n+TKr6gy8FxzPcYtZcgj3ezOimhE2Fk
    IOjHBgY6hAyQGlBAooid/N2WACcUxjsKpA7PNk0OM9QuNFKpnEl6J926vZ9g
X-ME-Proxy: <xmx:MdGzaudSXVbtKp3-M40WXU09pbk0nkIvBotcHGrgFFeZfy29Z54HiA>
    <xmx:MdGzahJU8kaKoe8HHh7MsNZ9zpsDmZddSwFFF-3HoDQZ3-UO2OIVuQ>
    <xmx:MdGzahfj5aYtIn75JWCLBM1ktS7zriB7UEG288NppdELFjnycymSvA>
    <xmx:MdGzao0NscDWtxKOv85NmJulC5dcv0vIcorccUsqYIglPPTN70Nt2g>
    <xmx:MdGzapH7cEy4Q7JInOfbTx20ic9SUQylKEPNj4l3xwzpvV2JLR0BKpI0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 09:16:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6fe9a72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 13:16:31 +0000 (UTC)
Date: Wed, 23 Sep 2026 15:16:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] object-file: lift ODB reprepare out of packfile flush
Message-ID: <arPQrtYHen3UAvdk@pks.im>
References: <cover.1789328612.git.jltobler@gmail.com>
 <cf14416f224f48475dfc9f79d8ec62756b9fdedf.1789328612.git.jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf14416f224f48475dfc9f79d8ec62756b9fdedf.1789328612.git.jltobler@gmail.com>

On Sun, Sep 13, 2026 at 03:26:21PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index a4cbf8b081df..0f123b79fad1 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -909,8 +907,10 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
>  	 * to zlib compression and is sufficient for this check.
>  	 */
>  	if (state->nr_written && pack_size_limit_cfg &&
> -	    pack_size_limit_cfg < state->offset + stream->size)
> +	    pack_size_limit_cfg < state->offset + stream->size) {
>  		flush_packfile_transaction(transaction);
> +		odb_reprepare(transaction->base.source->odb);
> +	}
>  
>  	CALLOC_ARRAY(idx, 1);
>  	prepare_packfile_transaction(transaction);
> @@ -1260,6 +1260,7 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  {
>  	struct odb_transaction_files *transaction =
>  		container_of(base, struct odb_transaction_files, base);
> +	int have_packfile = !!transaction->packfile.f;
>  
>  	if (transaction->objdir) {
>  		struct strbuf temp_path = STRBUF_INIT;
> @@ -1293,6 +1294,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  
>  	flush_packfile_transaction(transaction);
>  
> +	if (have_packfile)
> +		odb_reprepare(transaction->base.source->odb);
> +
>  	return 0;
>  }

One thing that I'm curious about: we don't have any error checking for
flushing the object directory at alll. So there is actually a change in
behaviour here, where we now also reprepare in case flushing has failed.
It probably doesn't matter much, but it does raise the question whether
we may want to start checking for errors.

Patrick
