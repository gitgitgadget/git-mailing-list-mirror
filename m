Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA784963AF
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136182; cv=none; b=QqkpUdtfCNEd9TWdpYF3K+ML/NsgLh8if9FzR3HfKblulC1GqlY3KLmQ1rVOmhNdrgEdHn7HXl9SsumCj+alGaXZ2e8hgLfiS4dBwPcPACWVdfhdBm4WNkIYm8c+tc1PzX9ocgS2oQwNtDC+w3fnqzl4QsoB/v/KRqBTDB5d0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136182; c=relaxed/simple;
	bh=3JkfTWC99g3t66eJna4hsplFwuNRZaz+v/GJHpEoDBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cFcmOBXeHSl2yNbjMpmHqWzKxjy2zqk1SiCRgXZRSbLgTi/5y3NDfdFh2rEKl8s9DBusaoU+irUZ4gCBWIV0LmK2IIwU5Kp8RUj1AsXwc3D6xXqehFOt4Lan8uirZcWbkk7KnPsmgrNLiLOz2wWkSh1BWGid6JqcEi+7O6aXbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BbQeqK5C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dgRjtSCM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BbQeqK5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dgRjtSCM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A5C5EC0255;
	Wed, 15 Jul 2026 13:22:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 13:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784136177; x=1784222577; bh=SAdBB1H1xi
	DAAn1Z9vlxL7XdTI/bwA50niXwq1/sa5I=; b=BbQeqK5CpoYKjNxrQPUyicRmMY
	fd89zeYIrPSWuSO8afkWVapcSmZ5G7KHlG4oUJdosVjIqF4wxAu9ELxs5koJZiol
	yQLuqOYlDD9gYLR6Qw/gXScFauYDCfZhUrTnR0tO/IAFMACiSyxum7+nCZlJxbS6
	VMQFU1Nt1rdeeFasFg57or/C6SdiDNrqJzhU8uuomQW9oXFuZKOA/2pSDuTQA77K
	VSsb/RefDC+OtoBD/RfvyWeE/Bxy0J/zHqOCb6nO5xQMFxp63ROqr1bb/cCb5XHT
	r+KtMEQFj2Ws0SRD1ZNtdrja0jU0hYeFmZkrRL2vn2fdKVwrZe4YXiehFwOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784136177; x=1784222577; bh=SAdBB1H1xiDAAn1Z9vlxL7XdTI/bwA50niX
	wq1/sa5I=; b=dgRjtSCMgYJi1MU7o2TlJEvFeWit+Gkxbj54XBqbZ+NnoHo0bJb
	YEII87WAXa2ySt2jlPh7JTIVqSBbREiATsLDclnE5wRIxPvw2H3pSwPdvH0nSvY6
	8i0PoWsTE/2r1LGdxGfcIgyNEbR1IH/quZ6EysjdEQGj+p7a5atFpqBQQKyX8qmX
	bFzpB3/j6HOr96LeesZSql5L9BCyvyHlfzqbnPt0FTwaOdPyHCjyerFQxg93zQsx
	01cOGFm1gXSi4XHxzRSCsZ4UPY6WhbvME39yQI5M+JWaFQMbO44gdAfHAUJTL6s3
	hrF5218cpJEW9gmp0RI6cd5uOxxderimPQQ==
X-ME-Sender: <xms:8MFXakJMVbuVqZY-tL3AiY473QBhQ4hQBO3ytZV_M5rLYZsWOSNZtg>
    <xme:8MFXav8u3qvP36y2ru_Ot2KiPZl88sCX1DP0L4y2IWaZFwbbLL3aLPEIocMaQuE8v
    P3SJ2JifmBQGDDiO8ezYPGEHdak9cg8pEkk_vhJu2PkE2tvlb74TAs>
X-ME-Received: <xmr:8MFXagFWOAkY2fzIEioo3_Me0KIWhywtuCpvTGo35msqscOSMfTwf_B39xsBA9YI4v1Qr9fWGx9MBM9By0Fk8Qz8opbfXCG-6kDODcc>
X-ME-Proxy-Cause: dmFkZTGwUtw+VrXiQH/TYx51zHSAwevscLvUIEcb4juaYADLTRGGgUBWXHlCaCc++ZaaNH
    /NnuoKg3FCb+VX5jNCIK4PtguN7c1s3MlY/Jm1dTF9EEtSK9uMDh4SVwc6BNRCrhHH8fGl
    1ft2TrPYCZymC/J8O+PmopNmuJSNpl7wpz+WnX8PHmSjnNa0nk53y05GxGltMuIU21LBQO
    atCpQHGHJxNVgYlbUzuGOx1/PQq4MweXPjfCwdOSXxD0hBVqXFFVnFuHUVAuQHAQi3MYVb
    MJxyvLZTmRRVOGXSrBkYckpMsTDXwJiIH9bAxz2bc12TgpPRLfb64rMpF3cZ7XIaP/VDqv
    B5Gth17jffsDflvuaSWHfRCIueLmszBMbsOeXLJW0n9k5Ddjov9Ivy4dWjfZL4VrDCMJDK
    eRDyHpNOzc58GJYemSdyI10NmEgRb1ycOINulUU0B8dgbjScmb7wmsTTSNw9/5aEEeH3ff
    l+XYRamiGtBOOEV69WA/7/y+OB4ATZg9pZmfKTEeFD3bXBOgbDeG5/UFIox313XIese8ox
    Xnp8JaRMtrM3oWNej/9ZfzjVaGMOHyX8yBWMF4y6j37lBaMyMsUmt43Jyg9elnO+A8xudd
    JoTtoDN3lsAfu2RVcjZydWUArJXqMPqAKxnXZLJ390pviDyQNio9ZWgTYuNg
X-ME-Proxy: <xmx:8MFXaq7B2-P7M5Fdv7AxaIEr0h9vbKon-E1pHbgbxdLvpeUng_3x5w>
    <xmx:8MFXapZhhiuesRWUmn4rpnGfmw0HVVPuzUdd_VvP8MuC-Wv0Ca0WQA>
    <xmx:8MFXaogiK3nyhoF-tY8c_Ml4CeG1cod0xwSzX00Wpjd2mi2sukSaSg>
    <xmx:8MFXarfxXOd-OY79eh61XXy-O9aIGJ9GgZ88KMwy2J-cKa8rlx2BRA>
    <xmx:8cFXainx_UOfo9-65T8U_0aaH75BJZ1hKsLDhW1Kgp1B1GcMHDs6n9dV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 13:22:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  chriscool@tuxfamily.org,  eric.peijian@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com,  Calvin Wan
 <calvinwan@google.com>,  Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH GSoC v18 10/13] transport: add client support for
 object-info
In-Reply-To: <20260715-ps-eric-work-rebase-v18-10-34d7adb051bb@gmail.com>
	(Pablo Sabater's message of "Wed, 15 Jul 2026 11:52:18 +0200")
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	<20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
	<20260715-ps-eric-work-rebase-v18-10-34d7adb051bb@gmail.com>
Date: Wed, 15 Jul 2026 10:22:54 -0700
Message-ID: <xmqqpl0onp5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> +static size_t parse_object_size(const char *s, size_t *res)
> +{
> +	uintmax_t uim;
> +
> +	if (!s[0] || s[strspn(s, "0123456789")])
> +		return -1;
> +	errno = 0;
> +	uim = strtoumax(s, NULL, 10);
> +	if (errno || uim > SIZE_MAX)
> +		return -1;
> +	*res = uim;
> +	return 0;
> +}

Since size_t is unsigned, returning -1 is a bit problematic,
isn't it?  Perhaps this should return a plain 'int' instead.

The sole caller only cares about a boolean "did we succeed or
fail?" result, and more importantly, the actual size parsed
is already returned via the out-parameter.

Thanks.
