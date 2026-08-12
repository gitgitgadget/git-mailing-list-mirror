Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099EC39479F
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515943; cv=none; b=ezRPA8sPdn29JpfzWE8dm+2uTU24/rMr4PoDqDL1IrVXkQbbrugXSUtF/hoAWoDg6iix2LBEupBwy9upGmETN7q+I8EhS0GMYrv47Aa++/NcATfuCL+uMwXlFNh5AZGJ2+wK5hUbgMZ3gmbtO9oH6qcn+szjjR4Zfzpk1BInHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515943; c=relaxed/simple;
	bh=3P4VR4hUlfBSL/4nhkYP1RW23pe5MQM/vIGNffLytmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSZTgkycLIvgpYsOxzxyN/30/PiUS5pNEAwVc9r8KvEfl/hhkWeD9YEAJADAqfRcOckYt7i+yQjrzbC4xxqJHXtMw6varRYAafkty7S9sRwizxYDbiKBKjUb7JP12NvMbmJsz+uPh2KCt0BG1C007NX1SaG9VLXLBVlJARTZ0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JM/zWSjl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8eU2o7C; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JM/zWSjl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8eU2o7C"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 95008EC01E1;
	Wed, 12 Aug 2026 02:25:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 02:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786515938; x=1786602338; bh=Sd4GEhfiF1
	I0nx6icdYw0wLeARgntxyrKKbE9b8wPuc=; b=JM/zWSjlyKLQKPJTe0hHJzkCNL
	tgNQLmy0LRHyebB95oOxauuMN/YOzSokWqMwafuj+zse5dpknu3g2SoXggddDOI/
	rBkIzpUitQa8YkJMr/oHUBj9x+sW5hV1wUKoPoUwKEoQ/iaxq6fykS7Oyugv8j7B
	thDsK9JQIoO0mBQAPa6rVVocGmNnAka2Hh79MwjqhOMewkllHhR1IM4v6nD7F4Y4
	bwSWJ+hD0YJUm7sp6erdRq+7RLmBPo5wRwAVV0rFO3/ENjJQxozQsg5AJVxsNg91
	DcKgfTf6NZq/r/cmIwJixey5FN+bbAwHrOqMBaGejFcv6ebK4NzzOwsxM+Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786515938; x=1786602338; bh=Sd4GEhfiF1I0nx6icdYw0wLeARgntxyrKKb
	E9b8wPuc=; b=E8eU2o7CqbMAuJy/iNWGkr5ZtssqvP3DUV6ovuWpq+jxf5XQcDQ
	D2rruitJ89zsDFE14D0njPw8D9tp0JYwUJc728XIqABqX2OSyiImGYwwEPe9oMPu
	TAuy6t56BHCrUUAsQV4wjRiTBp/bywSqd/6psahSGWvDGFn1e44N98qZuRy7uQ/a
	glU4TcUyncYpW3DfpgbB25SXSS7YFMsZ72lD9vILyJ3l1YGoG/K7qx1/03CbAiPs
	cpLyaW4HrDe1VMiUZs2MhGSkyPd77s7aC+eBgzbcJl2LSUGhiKPFtey3PtZfXBV3
	AAIqwvPtDxuMICNY3mWHyRGni2SXwtD23rg==
X-ME-Sender: <xms:4hF8auXqWyBJXRzhYopWgovFf1U_MvuIqRWhsP95yr4LGElZbOpJSA>
    <xme:4hF8aheodZgtTnlfgUhbOY9H8AS_uklYGr7HWN1FRyyEZhEnPApHtCCsDNWMJpJ4i
    xqCt8soTdJXix_Kl7f_ZZ_fHRS_TJpAfI1mR7aTp1Tci7fHYc4IRg>
X-ME-Received: <xmr:4hF8aqvOYykrLurodAT2IzJshjrII-Wu5kmd1krHsQJf2G3v01qg7pdIbYQw9eGgAp276IgE4Ltbl7UjcHiWpoqg7kvR0_bFGivmWN26RQ>
X-ME-Proxy-Cause: dmFkZTE2MAtyZiknTXCr+t+/zs+lp66ByCh/jlQ08DUTC8aH7jNINpYY8MwHMvIG6FBzWO
    c90TOOd2+I4AENKsWrTzKcCJ05LmCgofkDeHIcK2Ibarm37pXrezbdD+NbQ5LRSrXy4Jsu
    LRdG6FvRxeH+pLvumdB6voQ5KzGdOZ0jUQCbB6moqTG4Q1X1+/IAYikZtdNk3A+a/GmIzq
    K2UyEONB6pb0rQjGGRo5j5owxp0VnEGWVoFYrjfAxlwaZjnALry0p+FZP9fpwQGSBbhMJt
    m22kKPmBvldyo0q5kQ9cIEwwEoOdzeE7CXa98dBAjISSPG9fpJ+ffl6goX1gHuSmT3leEa
    X6FSuTs+mRLMmsdQgO0nKmrWFTmmMae6db0PRhqSGQ9MrfwId08LBra45dSUcaV4MuFGan
    CdBZKT/8txyPEiVhEbddWHh2L/8NSirFDLM8kglGMQSwg0gZ1n/yzNXu7rPQ3olhayxC8o
    Mqn+EzzFIASV9JNSJv+1AyK1WufZy5QHd/rVJSd3E326f2rKb7tTKCP+PlACWhUVdwVh3J
    TA18QTwYvgRbqW/yKwS/+LrkEv52opj8CRqxushAZolTRAZc3Zgh9KrHY+nc9d9ImZ3S/3
    6vGBWKZxTVZsba7V8STM9mC/BoyFYSOUYte3j2pkHUocs/T+zppD3BFIJnLg
X-ME-Proxy: <xmx:4hF8ag_LcaDxrjlFUgrX_eN5KI3RaAmy-gc65NtXQlyCukRWnp85zA>
    <xmx:4hF8al2szPU7l5U5UMXbvqziDEzAaxLn4NXvkaJWCA1yPfx8Y9nVAQ>
    <xmx:4hF8alBLuRpzvmPIdPMTk-BP1qgN4WwuiBE-8Zd27iXDjpPTL1E8tA>
    <xmx:4hF8ahc5iP6LVNpjiHSn3qbNtcJmhKPxPlCyxzu_nPZDTK9is_3fSQ>
    <xmx:4hF8arfYPMEBXA2PdSXUkJL9VstjZwYEkfLumzygYPlnqV5PNVu5urrH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 02:25:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 687eb408 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 06:25:35 +0000 (UTC)
Date: Wed, 12 Aug 2026 08:25:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v2] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <anwR3Inkf-9nLmYm@pks.im>
References: <20260811170200.43097-1-ggordon@gitlab.com>
 <20260811204407.52471-1-ggordon@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811204407.52471-1-ggordon@gitlab.com>

On Tue, Aug 11, 2026 at 04:44:07PM -0400, graysongordon-gl wrote:
> From: Grayson Gordon <graysongordon1@gmail.com>
> 
> git asks libcurl to verify the peer certificate and the hostname, but it
> never sets CURLOPT_SSL_VERIFYSTATUS, so the "Certificate Status Request"
> TLS extension is never requested and any stapled OCSP response the server
> does send is ignored.
> 
> On an OpenSSL-linked build this is silent. OpenSSL hands the stapled
> response to the application and takes no view on it:
> SSL_CTX_set_tlsext_status_cb(3) says the callback "should determine
> whether the returned OCSP response(s) are acceptable or not", and libcurl
> only installs that callback when CURLOPT_SSL_VERIFYSTATUS is set. So git
> will fetch from a server whose own staple says its certificate has been
> revoked.
> 
> A GnuTLS-linked build behaves differently, and the difference does not
> come from curl. GnuTLS consults a stapled response inside
> gnutls_certificate_verify_peers(), so the failure surfaces through the
> verifypeer branch of curl's GnuTLS backend (lib/vtls/gtls.c) whether or
> not CURLOPT_SSL_VERIFYSTATUS was ever set. The same git, against the same

Nit: this is arguably not the same git, as it links against different
libraries. It is not exactly unexpected that using different
dependencies may cause different behaviour, even though we should of
course try to minimize the differences.

> server, therefore enforces revocation or not depending only on how its
> libcurl was built. That difference is documented here rather than papered
> over: this option turns the check on where the backend needs asking, and
> setting it to false does not turn the check off on GnuTLS.
> 
> Add an http.sslVerifyStatus boolean that sets CURLOPT_SSL_VERIFYSTATUS.
> Because http_options() is the collect_fn of a urlmatch config, the
> per-URL form works with no further changes:
> 
>     git config http.https://example.com/.sslVerifyStatus true
> 
> It defaults to false, and has to. The option is fail-closed: libcurl fails
> verification when the server staples nothing at all, so turning this on
> globally would break every remote that does not staple.
> 
> Leaving the default to libcurl is not an option either. The same
> complaint was raised there in https://github.com/curl/curl/issues/15483
> and closed as intentional ("Marked as enhancement since this was done on
> purpose"), with the observation that stapling is expected to see less use
> as Let's Encrypt drops OCSP support. If the check is to be reachable at
> all, the lever has to come from the application.

Okay. One could make the argument that we shouldn't add support for OCSP
either if it's being phased out now. But I assume there's still going to
be enough servers out there that do use it.

The big question to me is why we want to have this change in the first
place. It doesn't help to address the behaviour difference between
GnuTLS and OpenSSL: if set to "false" OpenSSL would continue to ignore
OCSP, whereas GnuTLS would still honor it. If set to "true", OpenSSL
would fail closed, whereas GnuTLS would still behave the same as before.
So nothing really changes here, unless I misunderstand something.

We don't really gain security, either, because the setting is disabled
by default and can only be enabled host-by-host. I doubt anybody out
there is really going to do that though, and consequently we haven't
really made the world a more secure place :/

So is there any specific use case that you're after? Who exactly is this
new feature for?

Thanks!

Patrick
