Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9B49F138
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186306; cv=none; b=Z22P7JfYDaeJ77Qyko+MY6WS67Edq9mi0R+cJ455XsIwZTUYmkBHKBpouxSCclcQ8hHmooOXHUQeqVHfOohzYVKFdTMPS1DxSIf79RllA+XMRkY3t4JXYRQ4aLMjROR/4r/OFDwwCIbN3RWmH2LiZhdFv2FgdEN7GKMMzUeJmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186306; c=relaxed/simple;
	bh=LMS463Zt2GUw3Med6GUGIKzRqZ0VFwrFA/she6JjLNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFz/4KNbtdnS1qJYXnkqCRyI99lCkzkivARxXsMBUu8jmShzVWJk1iwbOsVdxGel41eIwRYpESXiSOFlxu0cIDLhOgYfIn9ggg6uv3ZMxcCIdw73EZa6rwNFQ14vDTJkR6UTkavwq7eMrXFfesjJpLl59mJWn2XiHRwh4AdRhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DRo2E990; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONph732z; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DRo2E990";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONph732z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DA662EC0128;
	Mon, 31 Aug 2026 10:25:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 10:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788186303; x=1788272703; bh=3jwz8ckf99
	1LOIGJ+kItD00X/3L9hvBlIdOTPnbQbeY=; b=DRo2E990jLCVXVbli4yTNHPnVt
	XpbL8uYaLTe7AsixOUlwwkDwEV2GC9TNWU3ty69r1rNEFBIzMY1cVJauPvThsdU6
	nsO0A1B6s1IqkYbWB4DK9nfIjLJBxINXx25Zk8k2UntPGGx9/9mW/16Zy5eRT56n
	5pEAvJ1o/ZHdB3LfjA+Mi9mLFYkF21fwLEYv+wjrYM55I3zmLlFiy+TNbxTqxk//
	F7n8hVqNvO2gBFpFEKEbNH3XaMvP8wckOl/vtS7ng6Wb2L+4dYrqGe1ZDmLdCzxU
	R5p3DsCqzzYvtfOSuVCMfM4W/l2/oW1J6U89PbBoFE7+PEKBlJQmRFMffzaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788186303; x=1788272703; bh=3jwz8ckf991LOIGJ+kItD00X/3L9hvBlIdO
	TPnbQbeY=; b=ONph732zQZVPi4pyogOHk7vfo/4FMOsI6hCnwvjvLVXMa7k+GBu
	iW7UlTBY4KnqQT4jBYekYxaGSWfJjsOGqxN0kk4LkRyPZZPHjUZ21Vbhlg9f/rQP
	WI6mUalqxrkXsedHY3FvDjMp7f7FlujnvwyrySMX693dwIIKC0VEYO4aPSy4ZQH1
	QpcA5AC/7xoTwcGTCDCqCXJtzyCPJ2GKr5kvvD0BIyIgLMCH3s9N6qcWSXJPkmjS
	djdm+0i2nEyJIndiVOglus2y1SdlQ4GJ/jek7//+ZGVXCaJDsMgzh0sKcI5C7z2I
	V5PjTJbBRJz4jFMZOKjpemcrXbU74E6GKdA==
X-ME-Sender: <xms:v46VatSKMMnEKNt3_DqiztXXbCx0Q8uDVMO3sZbvvMmRwM9HP0Ub1w>
    <xme:v46Vatp6AjWvNx7kJUEjkihWZKzPh7HwDwsEKCv2e0sg25e9-4iiMyn8ezT6tIV_n
    WLZjpZya5rhR-VrlZ3kW-UrE2DzYpNyFof46I27sGLXfiiTf_boxI8>
X-ME-Received: <xmr:v46VarK9eLyQKVxxXZ_sIgMwdpxCHPYa_eSBUzeY9c8b_DI8zcZzyI61BloAxYBDNqCsKQ>
X-ME-Proxy-Cause: dmFkZTFr/mDtZQW6RBjowPg4RzKxAZgvMWhn4znqJnYlqC7nebVW1Wrl/sVu3kW4RjEgTP
    6AuVD7eHGIna9IjwcNqgnILF287w+RXYNRy+jDrYjLhmN2qn7ZNMEfKF7h/l2zgUWUmByS
    zkJM8Vist2qBP56i06fd7eHWAObTYmiQeHc72uslAX+3P+8pnKNau4F5KzdAsgbGhjzzri
    zPWDQIpj4BOdjsED6F6eyqANHHtY+tV3F0hSISjLmcCeS7P5SMDwlY3x14NT2Op/sy031T
    Ql0a2FW7umUkmSINP/yDmpW3IrSOb4G1j3B8lnQo0V1EBUbxoKeqap2mrfCTuchyy3yRVG
    pnJZbxCCCY6IQMEaExRT61LrNrYr+Y6jmGtnl4Q7EdOhKHk0j/N5Tslt09UjMPcelRXRkD
    lbavZIsFRUhvGSvU6mzdxKgGbflkO5fW78dqGpZUYcQvfwez1E2+eVn7Kx6jbNnPE+vHGY
    idhJwXqzk7veFTv1fWZnVTZxZ/r566QlKT/fZre+uFwNYSmmq7qgWtdSD2AacwdFr6wwQM
    tOp/bCshHzNYTlvyt71ZVnQJ4j8KJTyQrPFbLgJo77SjKd8G7oVAZeNFH722UL2w8bmSr7
    mYxa8GC/DFe6oluD7i0fWw+Du+tAAJVBFe3ldnnXhwV4zbOdvZe1AqMXgZcw
X-ME-Proxy: <xmx:v46Vagrbj3tdLLSNIlBfsttzKtLX3LjGazbKxnYD2ZwYs5E39KAK2A>
    <xmx:v46Vajz8WKlFEYMTxKRpXXHhJFKp-MvjBv7pvZTfEstmG4k0HBUs9A>
    <xmx:v46VakOnzaDRNLkdrnumcXk8PMJT9wD2zHNgp5yx4BpCI9vbeLCV2w>
    <xmx:v46Vao6x092SVDu7Voe9eswbt6vMmaoA56WbQ-lTpZIxPeyBUJLl-w>
    <xmx:v46VatKs8IFcQRmHeYgWlQNimrX6Y7MVga432hUWqZBifw24bKJR0-7K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 10:25:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f8588c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 14:25:11 +0000 (UTC)
Date: Mon, 31 Aug 2026 16:24:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Grayson Gordon <graysongordon1@gmail.com>, git@vger.kernel.org,
	peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v6] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <apWOuGbOErZt9jo8@pks.im>
References: <xmqqmruqt36l.fsf@gitster.g>
 <20260818214858.65122-1-ggordon@gitlab.com>
 <xmqqpkz4czhu.fsf@gitster.g>
 <CALgUfNjd_y-e-zTKJ31o8_bQuRw8wFWe=sdsf2KJ7LOmmO21aQ@mail.gmail.com>
 <xmqqld9q40ww.fsf@gitster.g>
 <apUlqvXgChMeCUkp@pks.im>
 <xmqqik4qz86h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik4qz86h.fsf@gitster.g>

On Mon, Aug 31, 2026 at 07:16:54AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> They do look involved but seem to cover the situations we do care
> >> about, except we seem not to test when the server does not explicitly
> >> say "this is still good", or am I not reading the tests correctly?
> >
> > Isn't the following test covering that scenario? Or am I misreading?
> >
> >     test_expect_success SSL_VERIFYSTATUS 'fetch succeeds with stapled "good" OCSP response'
> >            with_ssl_verification git -c http.sslVerifyStatus=true \
> >                    ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> >            test_line_count -gt 0 actual
> >     '
> 
> Probably I misstated.  What I meant was a reaction to "fail close"
> floated earlier.  A server does not explicitly give stapled good,
> and the client says "this is not known-good" and not talking to it.
> I.e. 'fetch fails without stapled "good"'

Ah, I think you're correct, my tests didn't include that. But Grayson's
already did as it doesn't require any setup, so that's why I didn't
include it specifically.

Patrick
