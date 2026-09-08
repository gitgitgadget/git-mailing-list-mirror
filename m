Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5693417BC3
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856009; cv=none; b=Nhmi59dm2eJvSaPbXhPRi6SNRk1KAs6fhbXKOF1c16DgWTApImYpP0mvwCoslA+oJOJgWUYnkgc1c7EKja57Z+aa+HiGAphrDuJOQCZpNepthjxTCJUGznSLsX7Tzv/jaxrq0ZaH/FPcwps+Mno/08eTs+sPRtg+JGCR8tJpkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856009; c=relaxed/simple;
	bh=Bu+SgGgSh/XWdlFTqJFRzGSyKgbBM7jkBWbmcBJnxow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIw7HslM/zJnkTc6m8YnY1OiTfslEmpA8G3hMu+Q2vpij4XIN6kZl0jFAUp7WyK+d3Oh1JJMbH+o5w3/J3OXgbVMfGE5aqBfQycUn0D/eLTIBhlhmoLERILtQtXIMDt0zS0UelUAJlIfrK63QbtHkAelDQUaWmZQ/PUu/cb98m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NXu5rhhS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVg87BmK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NXu5rhhS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVg87BmK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 993EEEC00C4;
	Tue,  8 Sep 2026 04:26:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 08 Sep 2026 04:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788856006; x=1788942406; bh=0zE4y8qkpQ
	dYxRLNCNIlIKb2GNnGCxgMegJEOHXCFps=; b=NXu5rhhSMzXIipt9Jr+2rvMLRU
	tY3VPaLYoT0dI3RX22FR2fFTquLdqRLV8Iyf1248lKN+BTpC2o2GIqizi1nBgIJQ
	eSMTxydVl680XI9O3JFgqh7QuJunpa6MaeoXzmz4KXwWTpPuuFd2TocCGyN9JbNq
	CLiSHqHHhsxVbxmGwUcPwOVS4FmNjzevrRmrwv6q3FC5luhqU37W98qLd3hzjRFF
	JoMCjIursJrBB5GY0PyWjLNGE1iovY3io1vJwfaGciMYZM8TklmW6TH+SHdtO44V
	kINKAahWPUtJlWghv54aNoZL4BWufMV4AhDOstvjaNHW52iomOanSozyZrvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788856006; x=1788942406; bh=0zE4y8qkpQdYxRLNCNIlIKb2GNnGCxgMegJ
	EOHXCFps=; b=SVg87BmKylf/2FTTXdbK81LdxeXErXRl6vx2IXBG/yKzzyiZQGm
	RsYANscTNryNyBOR0cwLUJlewiB9MOA0h8Vb3/d60RaVaz0g7NOuyOHd6O5jXKGx
	/U/lXvdosELnSDNdcXlXF5YzV3FZ4IEpIZ2e53GzE1OGi0ErLHVkYJ04bvcoSier
	I0BnBomaqfxxR5jCmBM3W+octErjKr2ZG3WUizTjXNwt2Runb3IHw5V76dvqRoAr
	xkBGyOhiJSSwt9D33oOc0nQRZ8k0C6vxWKrYKlrjxiT/e4jNhhdn/XcRL3DEIuWe
	p2VPsYTJbVoG4LKS5HVp8DsidtqK2dqboDg==
X-ME-Sender: <xms:xsafap0XFls_iGglmPEtuAPVrupVt49OiATVuc1wQAWxyIXsNRQ9LQ>
    <xme:xsafangTLT4vJkQXsDwyKvr6pOrcE9IoTwYn4SOtHqYpf95MLItDmuEE_whzzZlGg
    Z7LUSfjbdFxQAdhRLiz_NkLmuro5Jh13bMwAw9IE3kMSRspD2VuEQ>
X-ME-Received: <xmr:xsafanQizS-UZPGKJ4VW5UsZVvFTu0HphN4y856Z1ZXixWDFMdTd1x1B8Kz2_QUOSlJbUkA>
X-ME-Proxy-Cause: dmFkZTEOm+gK5aO+hv0Irl6YDya89JOely9NwcYX7absfeCI/QwjLvWtbMLmromsMi+JOY
    V3TmwOwxiAPWTl15Ya/HBRY0rkOTXAllFAqWu1nlrF9jxkrU2PllLFXh+0++/TrO1DC5cg
    I9kY2muIGCohT0yOcCE4yc54CQgLOo8sEnXH0I0McM0LbnDKIqmUdsvYOeYvFY9Gs+oGrC
    Kqhrgs0zHgCHEhZfXqG0UhjZIJ9Ay3Cz86CzlJI1OaqaT4lHPo0e7/Zcca2YuegJWsetdW
    JbogG2rYC4ISKVZdo2uKOQRIjNTHGjz5mHvG0HXBrX3Pf57o02M4tCOkx7Ty/npfsmgvZI
    kBGHWIVm+GJOREeqpZmkFu3TIxjG0v0+8ULa5LvvGMalmmsC83HSRRuZ0XGjYmF41t6W2T
    sqntsUGgTsOAMvT0C9+wxCMkInOb1bmxCqEYV5poABSmlzjeejGUbdw6iypGRdJ5QEtTw/
    zmIz6tMgFBZUNZ+WxvjyfId8L8eS8hoFghh7rtOX5v6pc3ZgzOaJF/C8E5ID9sAx2/6ZUZ
    0SqRG8pStLPUftJrElxvsLZhnploKTgi7OQoRloSBWuFaB4vIvbUSrA3BQtVoMHolJX5y/
    +BwbuBfuSVx5vVW/b3VJ0kxP/dC9mZSyWf/+mmMDWmQ69xsJUvrGDLTnGBUw
X-ME-Proxy: <xmx:xsafaghnBusuU9SbCHDJiBUqmFOUb8xNXZV7qztIRu6BLbMTxTduqQ>
    <xmx:xsafav6JDCjUZN1DJ_lI1Q1FKHO-xoflKTz56dY284mUXG5cgKdmzg>
    <xmx:xsafalB2CtZ0R-7JATWr9oSsKf5b1hCXFRp9jW09lfXT3p1_k-CWVg>
    <xmx:xsafauZJU2iSBAQ5Rtn_xDK3OoU9WxIY_DZT3mLlBT46xIAiaGE71A>
    <xmx:xsafanqdjzTGWO6kTe_peEiaF27k-Wvg7XCsNqDsiG8lNvPj5PxxqQED>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 04:26:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d9b04e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Sep 2026 08:26:45 +0000 (UTC)
Date: Tue, 8 Sep 2026 10:26:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Oswald Buddenhagen <ossi@kde.org>
Subject: Re: [PATCH 2/3] imap-send: don't expect an ASN1_STRING to be
 NUL-terminated
Message-ID: <ap_Gwx4g7t0vjsj2@pks.im>
References: <20260907211210.2621693-1-dev+git@drbeat.li>
 <20260907211210.2621693-3-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907211210.2621693-3-dev+git@drbeat.li>

On Mon, Sep 07, 2026 at 11:12:09PM +0200, Beat Bolli wrote:
> diff --git a/imap-send.c b/imap-send.c
> index 977d78005c..9a807cdde8 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -226,20 +226,25 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
>  
>  static int host_matches(const char *host, const ASN1_STRING *asn1_str)
>  {
> -	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
> +	int ret = 0;
> +	size_t len = ASN1_STRING_get_length(asn1_str);
> +	char *pattern = xmemdupz(ASN1_STRING_get0_data(asn1_str), len);
>  
>  	/* embedded NUL characters may open a security hole */
> -	if (memchr(pattern, '\0', ASN1_STRING_get_length(asn1_str)))
> -	    return 0;
> +	if (memchr(pattern, '\0', len))
> +	    goto out;
>  
>  	if (pattern[0] == '*' && pattern[1] == '.') {
>  		pattern += 2;
>  		if (!(host = strchr(host, '.')))
> -			return 0;
> +			goto out;
>  		host++;
>  	}
>  
> -	return *host && *pattern && !strcasecmp(host, pattern);
> +	ret = *host && *pattern && !strcasecmp(host, pattern);
> +out:
> +	free(pattern);
> +	return ret;
>  }

I don't quite see a reason why we even have to memdup the string. We
already use memchr, which is bounded by the length of the string. We do
have two other sites though:

  - We use strchr, but that can be adapted to use memchr.

  - Likewise, we use strcasecmp, but that can be adapted to use
    strncasecmp.

So with that, all calls that inspect the string would be bounded by the
length of the encoded string, and that means we don't have to copy the
string first, do we?

Patrick
