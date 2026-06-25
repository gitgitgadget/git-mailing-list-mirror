Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A930BF52
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782421773; cv=none; b=cdF8bpvdYjV8fKGlYhwxbIR+H8Wbt7lDMV7ay0xTK5UGtF77f7nODhW8bSvzb8c8bY71vpi8JIK4BbZ/7laZTK+pMufFCsZE49MlKHu3TmGbSIoIs9KvwZI22d9MmVGsdflHehAiL4ELs9uTd4V+Gh6MzYzAc0PNq7iAMhONNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782421773; c=relaxed/simple;
	bh=8V6pg/0iytj3M5FgdyIxzaB2D63qTEcOekxB15jLkL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERWhi1aP/QjA+cpYNBWCIE8Gb76jRwg8+4gZwuXn2GVOGXx9HwFNcWIfa2/m6f9+jPg9iPUgbDecTaBZzLb8ViM4yPgR854qSV4ByLDx3a+8kaMMpwSFqrN+jypt1Ck8qUkMqeY6oXqUgvuy4ywXtdNZz238ndU+oYwAZqYbYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gGAtwADL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JC64Mc21; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gGAtwADL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JC64Mc21"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D8A2EC02B7;
	Thu, 25 Jun 2026 17:09:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 17:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782421771; x=1782508171; bh=joHgwTFG8o
	JdgpPxd35TkajMS52WTetVY1Oqbs1iqrU=; b=gGAtwADL8JA7aOpw2urTd9sCxZ
	7ZvWcGxDL2fkbb+hdtqjHp7n/I7tO7BI3IlrM2nrRhojayMsFvcJvmQfjYT0dk++
	WZd7smF91s+kv1QS2ZqH3OCMPOVtjeHPuKklX3DHols5aNHjCBHOQvBfC8LpkA50
	AIPkSYLRwpplwINM9d0gEHPiqAh17Wr6ko90b8sQOdzi1JG6NMzpqY1pwrbyhW1Z
	YWAa/74T13XAe5lweFg/Qu+hzKpkGvf+KdRfNLPEbKCnX2SWBkiE/TOkIcJrErMh
	Yd5WowQqrbjYWi1LjPA1qFVX7kpSuI9ov7TBRCJ2f3tvSnTAAsc/83NXbN1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782421771; x=1782508171; bh=joHgwTFG8oJdgpPxd35TkajMS52WTetVY1O
	qbs1iqrU=; b=JC64Mc21rg3d4uTZPDN9+XEc2tOLVLB3vuF13ofZZmb+flTlatu
	5I1qtaNPdaHIiUwzN3r1nb+cOum1cwPyC39F6xzOvd9CLO0XXt7xbGZw9im78n9X
	Vy4ZzQ7p9f8pdt+j5ZGXFUiTW4kIvhtx4WwtNbieiCkDQ1NNmiCcuwhFuO3m/Q7S
	jOHhQldUtiRqagJUNkDS+xh67TQXhEKD8RK+QgXx48b3TMwRBK0Tr+pYIE6v0gjq
	RIEtyj6sdgJoXn/03LQGasTvQJ0wQbYCL2Q3qLxWnMF+qEAVthLQeVjDOgrYm/OX
	VYBl5yPXRemoZb25sNvTU4y+DhkN8tbd8Cw==
X-ME-Sender: <xms:Cpk9auiL6mNzFPpkty05Wd_uZ3D5tZrFQIHf85uGahE1iGh4BB4FYA>
    <xme:Cpk9arnoO-bBrM7mLEsn9HLbVV3JFrYdBLr86mlavfrvhQXKVEG5HNZcVLBBqilx6
    0op0OFN9WkPxtexyTm7_nvU_mX0tvLYZLMROV4P0EBC-j1w9uNMVg>
X-ME-Received: <xmr:Cpk9aqiFykb_zwYZ07Lw3-yh9yL6BWqUpiu-dswld_prb5OtYvKHf-Q70blymq5j3ee0QakzPs1kA9uYJcsiUzP7cl7uBYr-yC_DM9I>
X-ME-Proxy-Cause: dmFkZTGKsqVqqcPMzxsP5jzpRG2Jjd82Cf24QOXcsU6jXShVZv6ddtePIiD+3zZvVUgTrA
    Lvq3zzSLvRec8hboBCVIj1YChv4dRTZ7gz8YdoztoZjYTHND1+u6vfkfqZgdChTpPFAaEu
    XgQGmOtZlGK2ctuHWGIQ7SreGbijIeJX1Ls6KAauxC5oX8mp7D4CeS6HUEjbnW5607iLmv
    nKcTtjXxYDk3vv9erWXDNvzxk/QZfiOCfzcV1UKSUTbPuGPQxC0ttO3hS2xwKwVs4Oios7
    Ewyn2Bw+VlC+2S6LB/vUV0rOBx9TUQ/thcVnNqVifkbgLk9Y+Wpi1aQlqUd85gWDDulfl5
    MD4vvR4nZ901OZ0hhJVROTrBHjExUpDfv5kSO3pb7J/SlIBtxTuScjIZC0+i6r3xcCu4so
    9EDSZBurEL/rC6OBZ4EbaIdLcm+mFszUkuMcoF267cAFY2Dpv6y0ANhCeZiiyxyfPNnY3P
    7P9VxHJqM0buSIGSulJDtxddb1ZvrbygENPfUMEFXV9nSZIxrcrRuKPyu5i/xIIqEc9qsY
    llkcQKcLfvVl8+LJpT5y6gyFjpYILT7QsjwAnJctVpOWHSis7hKDJ78LV5Gk6/NwZAIOSI
    +WfVIynhcOP2BLXcTadyRknccZAHJDowzdMBF7DzbNDhjLswdIXYtn05SiuQ
X-ME-Proxy: <xmx:Cpk9auHZpC--FJ--XV8bj5BNCZxQ-8aCXanmGtAQoELKJOLhekn7WA>
    <xmx:Cpk9asvCerq-tyGPWzFgnfcJFU4khhLvj2avlHsVGZcjblVkvixAgA>
    <xmx:Cpk9avfJbSemR61AnTXdb3fjGqf_zUjExdw_oetHP6G3UJ7hNxTUow>
    <xmx:Cpk9ailRp2IvpOSpYdq4LgiJtDEH3ElxrWm_Y6NocDbSadEqqPyaIg>
    <xmx:C5k9atrKaa7V-NaMOjUvxsWZgHNlT9fhCVdOGrctFOy3V22q__u7AKFl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 17:09:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  chriscool@tuxfamily.org,  eric.peijian@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com
Subject: Re: [PATCH GSoC v14 02/13] git-compat-util: add strtoul_szt() with
 error handling
In-Reply-To: <20260625-ps-eric-work-rebase-v14-2-09f7ffe21a53@gmail.com>
	(Pablo Sabater's message of "Thu, 25 Jun 2026 14:13:24 +0200")
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
	<20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
	<20260625-ps-eric-work-rebase-v14-2-09f7ffe21a53@gmail.com>
Date: Thu, 25 Jun 2026 14:09:28 -0700
Message-ID: <xmqqjyrme393.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> From: Eric Ju <eric.peijian@gmail.com>
>
> We already have strtoul_ui() and similar functions that provide proper
> error handling using strtoul from the standard library. However,
> there isn't currently a variant that returns an unsigned long.

But this one no longer returns an unsigned long anymore ;-)

> This variant is needed in a subsequent commit to enable returning an
> size_t with proper error handling.

I think it would allow a lot of code paths that want to deal with
size_t not to worry about "is ulong large enough?" to have a
function like this, but for that to happen, the implementation of
the function must carefully think through if these steps do sensible
things on platforms with too small ulong (which often is OK when we
are coming from decimal string to ulong and then to size_t) and too
large ulong (which is not OK, when coming from decimal string to
ulong which might be fine, but will bust the size of the final
type), etc.

Also, would it make sense to add yet another "static inline" like
this?  After the dust settles, we may want to rethink these strtoX
wrappers we have, benchmark, and possibly make them into a proper
library function, not "static inline" that may bloat the runtime.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8809776407..7f417f1acf 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>  	return 0;
>  }
>  
> +/*
> + * Convert a string to a size_t using the standard library's strtoul, with
> + * additional error handling to ensure robustness.
> + */
> +static inline int strtoul_szt(char const *s, int base, size_t *result)
> +{
> +	unsigned long ul;
> +	char *p;
> +
> +	errno = 0;
> +	/* negative values would be accepted by strtoul */
> +	if (strchr(s, '-'))
> +		return -1;
> +	ul = strtoul(s, &p, base);
> +	if (errno || *p || p == s)
> +		return -1;
> +	*result = ul;
> +	return 0;
> +}
> +
>  static inline int strtol_i(char const *s, int base, int *result)
>  {
>  	long ul;
