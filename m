Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E540243387
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452040; cv=none; b=ezxf/GTijk+6GDwOjxNJM0iMqn5QdfC14xpZUUaqh2NuU/1o6aDWZgHvdJjQGzE4CBFsug+6uimkvZPkI8y0cdzq11gN1dCZcdZZqtpMWwSztY69b+/TyyACZmSu5EeGCffZlu7Yw2Qb6CR2owaJpvsJcpqRlpgyguba0jRIxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452040; c=relaxed/simple;
	bh=MicD++TBYvJr5LXXb36w0Ynwfc3xGFwpumnB5v7vC3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt0is3BBnY1SaN32sw4wVOvzrsRyvtTjPUvVH6umvVy+KAN9j325jvfPUQPrI4c5QVij8X+4k8TMEo9tfenz+xxbwVa4bgFaG6SRIqPvu7BApeGRJazwP00P90ikwopy2xHJ6PqBUhqyxk3cmFR70vecRRIKrcOYoEsUZsnbpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PwdL4YHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O9zAZfIf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PwdL4YHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9zAZfIf"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BFB01400032;
	Tue, 11 Aug 2026 08:40:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 11 Aug 2026 08:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786452038; x=1786538438; bh=1P8ULWg3Mt
	58RAmMgU8Xbp/7VS/wASBzbXTtzlrz/cg=; b=PwdL4YHgqCf8JpSeBal5Vqhnjc
	zO9DteQOMQPEnAbDwpUli7c6OBLsMlC2pLZ6BZ7vv43pNhdxjXflCsbtrjSos6zV
	bBV/foyxVKSz4vQ6UhECAcTm/eklsBp+R22BCVOyBDp5PoOkLiL2Au39ZQM6FLYp
	S6IVX4DYauxntIng++og61/CIkJgDMCDb+J5XKOdTA5k/Th+4xb/3v8ZErSn1o3P
	j2rt5WBY5iXok1yvfI1m0gBeB81OsUBPbB52jkLZIgCxMasZkNPx1UCz3TZ7z38U
	RTjXwOCb8PD9OqjP9XCnRg2VQLqjguGjTXnRqUTawCASaffIQ23CQpsO9jKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786452038; x=1786538438; bh=1P8ULWg3Mt58RAmMgU8Xbp/7VS/wASBzbXT
	tzlrz/cg=; b=O9zAZfIfa16WqvnPq4gZhV6QkGO6hqSxz4dDMukQnzXFoiBX/VX
	YTlOcSb9v+TXzpiBN6r6nRhB29w5gGJJIcyMcFu2/ARpHZfJ/Pw1D9ZRyBF1Jrt+
	qsYlGP3/kIL332OsaYFcU2Uav8FR07w6BYp/Tj2aDDQIdy9KU62qcSV9PvzhJW5h
	juwSmtU2oD4EvThvmvUWF5OcVfF8q8Z2ENCQEArR7ITf3WCtaBxhtBk6VdVpvCP+
	IIH1FTPpCtZiT1Dr0wo7taD3EcZVon/AjPjkZ81YG6uRDgrx4N1ZjGbHdeLeTUxG
	uEBxpvmfBMZuMN0g57JqxLNQnTNu/iDPVSw==
X-ME-Sender: <xms:Rhh7asogoruh0cOdzIg6KCB9PAmWNS8Tx2JuBloj0f3KwfHV0-mlug>
    <xme:Rhh7ak52g_IfHHtsxGn1ow5ahskzZc-5kyStuYvhhUxs3SWOWk4Zb7Q8MQnlKXXW9
    mrso80APJTZoO5PmTfm2J7jA6m8afk8hU5Jgmr-3e9M1ciyVVj8CQ>
X-ME-Received: <xmr:Rhh7ajdPb_3FLOiBZTM_79vosNJd62YO9fxTiFdHOQX7SoavpVI5KsYg16Yq8LzL9tLucULDMKbhsdYGKOf1zg5RwZ-mjvd5VvT3qm-_CA>
X-ME-Proxy-Cause: dmFkZTGUYTtbpVrdQRClQ/x8ro8tu5+IhTWoRs6AH3v/Uat79NPB8688Sty3JYCh1EGVYQ
    Qq0sTCghDe1vsMs/NaA8DN1w2mzBgqtSnHTqhEfB+6xj+0fCw3fKCYtB7of4ZAB05QRyk+
    YG4jGosu/vmC1ZrHZNftfkbOwcMbWi/swsvfvvdsQw1KqselyNu//hWKfqDzhZ3nUpaXWQ
    jX2l8BVV1B+zW+iZuucsRp5sdeRsf5rB9iGNmSZ0mSCULrrPGp0CYBMA24fw6vPe43AEuX
    HoxJoq8HFKWdTAFZvceIWucbN3b+7XKja+qwURaVjt38VwXZ/w+zHIcqoS+7lfTpTjOiTv
    kEDDPhQYd1Pj+bl4+5axZ/tH1DxU0ZApr3I15NLr7eiYHZ2+g1D1nDK7jq2jWJigBRr1af
    fkMC+2jjquYe2vseabvNEJ9xtgNEmntP9MkBPHv5qSEYTdX5BY1MvpmDrqfZgUxopVo53i
    R/q3ZMqUhnGqfcb8bqU+iO1UhBfviNvOJB2TRdD11CWoLwc7Bf/d2HigWCzjKvh2Y4VskC
    YDAB7w218QwJUEJW20flUv7cv71lCdG72Iah7nzo6CTrVuR0STmZeIERwchjMnm0jcf8S+
    3N8P0EGUOwJFeQi1Room67SPBDDjoDDFAwaSNBH/FEmwekmRXxkGIiHwSDDw
X-ME-Proxy: <xmx:Rhh7ap6S8zBZUH8I3UBqiMSB8Od-eONCmcrft5JYLywff40qQkB0sw>
    <xmx:Rhh7aqs1zCLoidYgft-h6btT-xZX5-Gr7WIkkWSz_wNJDcs4ZT0GAw>
    <xmx:Rhh7apjbG1-s1K5it_Cb1PwzaXtjuC6KHxXLRJ2nKYYd-G_ZeOIQrQ>
    <xmx:Rhh7alprITqKoTO95kh5rlya_9gOvxPm-gP9WU7JFFp3Y0-_0OS_vw>
    <xmx:Rhh7ajstGVeEK13C2rNaI8kg0Dnb-KSqUxqSEYMeiqx2x2et9ia5arZt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 08:40:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19d26eb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 12:40:35 +0000 (UTC)
Date: Tue, 11 Aug 2026 14:40:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ron Nazarov <ron@noisytoot.org>
Cc: git@vger.kernel.org,
	Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH] config: add http.sslVerifyHost option
Message-ID: <ansYP7cDvtNWueIz@pks.im>
References: <20260807153315.9586-1-ron@noisytoot.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807153315.9586-1-ron@noisytoot.org>

On Fri, Aug 07, 2026 at 04:33:14PM +0100, Ron Nazarov wrote:
> This allows for disabling host verification without completely
> disabling TLS certificate verification.  This is useful when using TLS
> in a decentralized way (similar to how one would use SSH), where the
> remote endpoint has a self-signed certificate that does not
> necessarily have a valid CN (or any CN at all), and you set
> http.sslCAInfo to that specific certificate.  Without such an option,
> it is impossible to use a certificate with a non-matching hostname
> without completely disabling TLS verification, which is insecure.

Arguably both options are insecure, this new option just pretends to be
secure. If we accept arbitrary certificates for an endpoint, then it
becomes trivial for somebody to perform a man-in-the-middle attack
against you by simply swapping out the certificate against a self-signed
one. And man-in-the-middle attacks are basically what we want to protect
against with TLS.

So sure, using no encryption at all might be even simpler for an
eavesdropper to intercept. But in both cases they'd have to sit between
you and the server, and consequently they are very likely to have the
capability to MITM you.

There are of course going to be exception to this, like for example when
you sit on an unsecured wifi network. Other users might be able to read
your traffic there without also having the ability to modify it. But I'm
still hesitant to add this new option here as it oversells the security
benefit it offers over disabling TLS entirely.

Maybe I'm missing something obvious. But if so, I think both the commit
message and the documentation would need to be amended to document that
gap and state that yes, this is still insecure.

Thanks!

Patrick
