Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703CE3C3F6F
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996931; cv=none; b=XA/NPRxJu/Ji6ulXdEPEd47Y6+wyd7i/Ep4brqxTzbJAEExx8oFWtpWNs1t4ejEOF1HA2bJiDZcY0z3NNfYYuIMUb4A2T7aUEcxBRz9z0N3sXY0FaxwTE6iep/03x/b2D3ak6vB/YIBkhaEFFYxug4su9IqGS93YW4QFbgxM2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996931; c=relaxed/simple;
	bh=/Fvv1CxAT5rtZ0MTtbfYuYdU1I6gykPigz57MlbVWd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA6xUQzfIBp95hOVho1KpIRoIq5lykb8KlAf3+mhknrhr2h+ytB6bwQTLhPXe0FbCF28ZQaFhiZWllkxohFf05pH2RIA39OfarJB0G00NH3SFDqIHC9n116Mx15QYtKla+b7Yrm6gN9zpJT2DEO/bRd50yBlhjQrTyA4hoL09mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dv4AEEmc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FIPoWzM4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dv4AEEmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FIPoWzM4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F9927A0106;
	Thu,  6 Aug 2026 02:15:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 06 Aug 2026 02:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785996929; x=1786083329; bh=QjbGgjWGqd
	rXba3GfeZe0RNkKErwz5idZGbAvmNYzLc=; b=dv4AEEmcJbUfL3E3uUQqXjXX7K
	09gyWweUOnJYmVVKirELmB5Tivovt55cM+/Qu/+wdiG+ovYyQC+HnTMR7N7NIphM
	OSCMQY+7Se1+JE5wfyNL+wh58AsRkCihR15dNrMZwUd4Gzb4eR/oDQA7tLRkHYRf
	zoBuiGVzsBFWgdQJrsbcs9eUbKapkHVIkJzCdSr3fCtkeCviRbK2JDSd6Sv5FdEw
	sloim5jyCxmpu/bmlkcv9Yv0lRkVyI1m6QMMTH2ckn7lcXw/UWMlNkb/fHCKmGy5
	+F8kdwNy8AIu4sU0ZcNBHcbc5aQfynv3u6TWjfta+C+upNi9ite+akOBV41Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785996929; x=1786083329; bh=QjbGgjWGqdrXba3GfeZe0RNkKErwz5idZGb
	AvmNYzLc=; b=FIPoWzM42JJhsyuVb9bPl8LTab5dBpq8arMM+/ZhJRKo21Rg9N+
	zxQil/QvQq6oZufibkfS7+kU+NN8EoO/jMx8rHrobCBuBD5PpbfM+riYCOZyjjYr
	ZjYeiW+QnGFzTJ1cRD61366Af4Y2QVwUrJXNnZTtnZB3cvZYxUnDCVr8UaHM/3F+
	xKtRoqhX9xbwWId6hVGegjXzQV0FNHAm4e98+J2HkhNoJQIkUnk1rvam1TI11FgS
	IgoOzki7Z7Civ+bcMcOvAhGyDUnRlilPMhbYfZoLiXTaFaA3eOt+t3uUFAPEBDN6
	Yurpzp9WD5kmnQHl9lmigJJ6ZQqvt6v5myQ==
X-ME-Sender: <xms:gSZ0amY9_bwotPL5VlH7xMv5LR8DI3q3CY9doP4DJCwlIMVkDwmYdw>
    <xme:gSZ0ag3A1rwIwq5fNdMJcI8k_eneRCnCTw7_N7xR13AxqcxlQzhvU1wtCuql2cdDH
    CTkRk91Ho7ydmAlcVdnPQFcrEKdtM8Ry0KV-F5KIvpBBAoLINr-hw>
X-ME-Received: <xmr:gSZ0auV7dd5wLyyHdxpWG2siNsk4YE2xDNyG4EZuxNjCPhApfi5c6SpFRpPVLtIo-nHEmlYarkH2E6wOACgzi4M7vcO3v3TFckSSVTnlyJE>
X-ME-Proxy-Cause: dmFkZTETQf9dOIaT7zw6phBvd+X9jmiWHaPiV2ErtIV/pgURdgXuioccZ7V/M2uwv6iWsU
    qOM7WiNF2F3K2Sne4Qe9eROqjuvENnLHz97jB4Fp8kLSjzdyB+K3aDfgNIBbY79fltl+sk
    panv6L5iTLFiNKF5RWgjo1ZfShEwL8GKilBDt4/cZ9RBwEOSi4LIhHheDktae5KHpS8LUN
    +R+boZK8AxjiJT+WC9oHznJ6zzBUrUR/PFe+S75KUqC7YeB14zRYSZpUwzRw6N/VvZ5e6Q
    NLCKmvaTyilamT2sYXLFJ92T5yPSKOTumshTmI0pNs+3fFkK2Xg4H08IPA7/ysEIDOsHeE
    IoIdTT6K12iJuWWcvvD5WfW5YiMBRD3po63E3h/XSW+6BvJn3D5FWM673IQN6arb8tXb26
    GK/pCMmpG77JCXpEpIy/JrLCVRWzjlfGZ9Gl6a3P9RdGOA9/142FZHHENrqTVHFDeWaB8d
    zfYq5KWYy1fayPLtxPJ5R4dT8rZf6K17z6cQ84pcI67YEY9fDWW5XybOkubX4YWNDMc/Jj
    70rIreYmAEjc/4VYx4p1shvTqmrxL5DDllP+t4TFOtCP2/zk1LbpCOdo4AKMX9GXIVr8En
    7UJIXrencn/ZOPiqKlHSpkvcLI2+IJCS8Axov/vaC0zbYXxx1l64trmhKnsw
X-ME-Proxy: <xmx:gSZ0aiUCPPvjlRSzyTYqq3VJ4tcq6kK5y5bw8-61bRAOjsYjHGIloA>
    <xmx:gSZ0alej91x84tM3FTMtUGqH6JDGRDrhtxnkDYmUbx_9w8qCMEyW-Q>
    <xmx:gSZ0ajU39iKhCj8kOqZi0q2y2GLq-dZrRGhNo7rGzzLya5aNbNiRrw>
    <xmx:gSZ0amcpHmFwzkhuRVHZ1uWmBV5qVtBLWz_LLBpPoEKWUmBbNeJI8A>
    <xmx:gSZ0ajXmeIGJkVYU9e6DGQhGYSyUypS8xvex8V7d7h91FLmUQ-vEWX8K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:15:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ba3d60f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 06:15:27 +0000 (UTC)
Date: Thu, 6 Aug 2026 08:15:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] Next size_t stop: pack-objects/delta
Message-ID: <anQmffJEhKxttUjO@pks.im>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
 <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>

On Wed, Aug 05, 2026 at 04:14:27PM +0000, Johannes Schindelin via GitGitGadget wrote:
> Changes since v1:
> 
>  * The return value of sizeof_delta_index() is now included in the unsigned
>    long -> size_t work.
>  * To assign correct values to the now-widened max_delta_cache_size, a new
>    pair of helpers are introduced and used: git_parse_size_t() and
>    git_config_size_t()
>  * There are now two references regarding the provenance of the
>    deflateBound() formula in the corresponding commit message.

This addresses all of the comments I had. Thanks!

Patrick
