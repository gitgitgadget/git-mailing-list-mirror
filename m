Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C6427FA6
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693823; cv=none; b=JnslUBGb5/zJGPLmVyQjK5SnGMTL5uukd5O0pXD83RmDE4KreLmzIRvVI94Nygnsh/Rzuj5L7KNaQXCr09qREB0TMe42Y7ER+w7qV/Ho9pwJal1eGfcJDcmKCqyNCV9jJiVyiidviyXplh1lkDnWXciU9kC2gp0VLF+YtIqeDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693823; c=relaxed/simple;
	bh=NbA8ckRVscmW8v8SlEWghiPFbRi5Ci0FqaZWEFJMCWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXIvkepFyysMhEKHVBCf05+gDeCFZ4fpP+RbYuRiUTbR1WefxzG1HdfcnAaoZvPoGTpDbY3sMRUnEF3r3LwLiILxojcRDNh4klfJDjogKmhsMjdSlW+EF10bBAphbZEjhSkd4Ve8AqpTRb/73k+IimHmVnb6wsh9APMYxZf/DDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mBpMubhV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZ7+Zk2M; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mBpMubhV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZ7+Zk2M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BEDFE7A00E4;
	Fri, 14 Aug 2026 03:50:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 14 Aug 2026 03:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786693818; x=1786780218; bh=8P9hpdTZQu
	onQK0i18XGtTS9wk9lqz6s9gOt6fXORZI=; b=mBpMubhVe6dG5cARNoN4VcC6fs
	wLow/OFBlj0ik571wgHF0uw8OT2CLUSh/NgF64pX2fjeRSHtnJo9/j0b8IlSOWWB
	PcnJd3rOtKe5/wZoSzDwpm3Ed8N6JUE0CBmo3PAg8mRKrc15TjOPp3mBZUS/GGJL
	Tgymeck9oOGrHwHt8SOwBc0aRBfQV1YE/uSOSTvGVbBHMN/1P0XRtz0janZ86fVR
	Ad5noLXCxhp/vwI+1HNIlux+x/pCfkhgQaQ+7df0pSGZz3SI1kZI7yO9BWkhEgZn
	LRaefxikagMVO/Xo0uJLquuPuE5s1yxSqJvkNFQpQwaZnD6okI+/i6J3oJwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786693818; x=1786780218; bh=8P9hpdTZQuonQK0i18XGtTS9wk9lqz6s9gO
	t6fXORZI=; b=CZ7+Zk2MhbC4ZWEk41Uh1+LFsSt8rcf+pqme0HyK8FIYHZmAMIN
	sy4Z36vqU0J21DE+eT8YokhONb+mr1KxpZDoPz8eEZ8iHFVkXzPQuZGgcPbovJD3
	pCJGgZldqMCVm1gTip5VvPzVAO2ESvRdC63zTX/lEWZdLuT+dC0NFHR6U4PRoSyP
	/fyv6v8h7hAiFavZXe6rVAm1Kb3a/N8j/ZV7t4aLWRLXyp38Fnem95fRA03n8RK0
	sj8oSvlcmspMArbD6SrohOUzVb9cCDeY8/B5uVbA6Gea0KoaB0IBRPdKCvlFF0hm
	CfCrtKt9OlPUjnVy/plB1Z816h3rx1yUb2g==
X-ME-Sender: <xms:ush-alHZ67sfmrHEAeQUVnKriYQXV7bVKhpWEyKzs-2Ea4p0AacSNg>
    <xme:ush-ahM0g5iy_WXsuhkblLxx3UmXcTO4wwnYOCahbRyI-GjgXxS11QK_Dp1fnRWzL
    h-A_XZ8h9fjq87NXDwqd4pTqulJhp04FLmZ1SUAOYbXyWUjZ-P7XA>
X-ME-Received: <xmr:ush-avfQPO_oDkiFbfkNr9DTqymP9PH9kIV-_gNX5ZczCXIde-zTeiYuCdeBcqw2PMYunv0kzuPzhTP39duGQIi9alwd09ueLk6n4I3Cfbg>
X-ME-Proxy-Cause: dmFkZTElrfebw7WXXUI/6KjedN74Vo2BRX5n8aU6YYop926r+Tgj1OPAUaiODVciv6f/Qw
    IJ3Pvk7w3Up/IBzOLpTyCx7CSy1WvaMFZOvgNgoWcvDstE5fGB8QJY2X1zXL1OVohh4jzt
    vIrMrX1yW0slxhLQhLVPoRHgfgsU5wP9tBw2B0vGmooYVq5W4CY/hgEnZJkS9sGm4yHRnr
    u0KPFV7wj8V/t0Obn6B5Fs53jZcV73cDWGJn/7fHenUd4050fJpp2HtdnDL7tZzB6BfBZh
    WD092+nl7Ey4w2Je7ABs42tV0yFDTEGrO63mFbAm7AGSBLesNDSyet+VTNX89gdAb+nKTV
    dVilbduxnuCu37boc2joU7ywvoDeDZKx8hLTNsdq7+MS4SrbwMss5x+zyoJMuIyPEGu3vb
    aiE0tOb0ZXWREl+Ygch0zApXbAgIgho8D973dsPiApZWhf3O5W/Sc6d/0V95YNHW2aZFie
    AMKvKWt4jMnkzzRl2sAK5ZOtL9XXa3582zCQX7z7IS/+uT9vyEKOhsfd1YcuH/aiDFNejw
    tckHwrJ+iswFN2aRM7YppovfSKRIJ7MMhLVlqWRULdtUGAr0+GzFleLnmimmqG3RfZjZhC
    0e0otJ7I2oMO+G77lSTk1bZO1Gmt0IWjTaUTxzjFJuPmLZlRL2IIr8aF9Ecg
X-ME-Proxy: <xmx:ush-amsN-NtajApJbYkkQHRXYy8mL6KVJ1YylPt6asIb3ZOpb5hWCA>
    <xmx:ush-aomVZeKAQLmtun8HJUpqx21L3az0vawntZfQH0FBD99KDX7d-A>
    <xmx:ush-agwb4lWvCdyhK8Vpnvbxz-FKXu1qE05azi7U1QeMZbyBMlz_KQ>
    <xmx:ush-aiOU22Lm_KPEX_LbmZtkX2v3fWUNQmP04-MrFf9PJkOSDhgBBw>
    <xmx:ush-ajLl9BAmTO-QrqZqVPkoEWIjqLi7EiPTzBUK8HUwvf_F_272zwV3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 03:50:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09da8cfc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Aug 2026 07:50:16 +0000 (UTC)
Date: Fri, 14 Aug 2026 09:50:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] packfile: fix perf regression with many packs
Message-ID: <an7ItVYrKZFXg2ci@pks.im>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <pull.2202.v2.git.1786633010179.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2202.v2.git.1786633010179.gitgitgadget@gmail.com>

On Thu, Aug 13, 2026 at 02:56:49PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Changes since v1:
>     
>      * Fixed a typo in the commit message
>      * Dropped the claim that this patch fixes the CI clone perf regression
>        that's still being root-caused.
>      * Renamed the is_new parameter to the more informative skip_dup_check.

Thanks, I'm happy with this version. We can still iterate on the other
patrs of the discussion after this patch has landed, as needed.

Patrick
