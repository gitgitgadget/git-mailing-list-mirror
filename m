Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564A44781C
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781714; cv=none; b=P7bSk9UBy+gks6R6SCvOIrm1kCGsUUzBoTZ4IfgLOX8cnoWIraWjznMwsWIeXqek6WKWoeBkBOIPdnS9JVU7lpNxydbQ/XsrDh6G3g3sHEgSIBSz6g9InNEMekJiBv9tHhlZDSlR4wc4K+Z2xkYu0/1Dr57tltFlmMTK/VsbSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781714; c=relaxed/simple;
	bh=ts4CqbKEH65qRlQAo/rDrBU5sLkhKVH+D+Z9rCCjSKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HyMF8u9OHW5komMUKIGedflcqAzqS8kgpJtglGpNY3sH05eF8RgyJxpWgv5WBw508dbKHkIO9LGmZr8OTxR2YauR/Te/obxiTVwsIsW5afyg+MbzlteX+I1x5bcqC3YR4uDGLNIXpFlfO3zM+IcGNcvUbwJFBju1hGagIyZXRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v7XiPVfs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAzyN5/T; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v7XiPVfs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAzyN5/T"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 979727A0077;
	Wed, 26 Aug 2026 18:01:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Aug 2026 18:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787781711; x=1787868111; bh=4fcrouXlIH
	TzI31bDHT1ZwCYLFDw5WtoBWVdtOnKvNs=; b=v7XiPVfsyQCCoqWRcJeRBBKfgc
	IAYVe2JgpTRShB6xY82GGIUkzzySfAd/ZSeDSLFIrlUJvyWxjKCt/uRxCiQtFVNy
	+nWX5yhL1nB4FKwQUeZJc/xaPM85bO6TYBmCM2c7FXXmfRcxevnvHR0Z1FnyChAj
	lnD9TwQ0nZ4ipu1HWHACunNGaELf77JE141dZ1RwQzgoXfDiH7RxeuPO+En4piUG
	kcw2Uw8hAwwRlhVfAsHr0WcpQQC9VSNFEiAIKk988f0hzKQ1vBjuJVf9Q9JkrvIl
	0T3qXWOmqCiwBmlsc/SzCQDlmJUu973hvFPAWI3IDU2cBM47ps28mYQAyYBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787781711; x=1787868111; bh=4fcrouXlIHTzI31bDHT1ZwCYLFDw5WtoBWV
	dtOnKvNs=; b=YAzyN5/TaJpybvYlZTl1WYL86a2I7hmYELK89ukVU/s/qyUp3Pk
	IglErafIFHIRkFIZASDu1XTjLCv71pSKZitMOfVzl7+gXgnas8WBN2wUQLMRSuFB
	QlIVAulFXOt+sNNzyBPUP3ZbpUv8voeQ6bHymBXo9TmSy61SGgqfRVuzkKtfyRRn
	AmVG85Gg/IVCPVogL2Wa+f7n11D1Uq3f9PaLgXsVF5oQX99g6f8Begomh2zVO6qn
	H7NxKt+1Xf8YE6Bf9f2rYM3bVt5GX2DRwpbObSah5QoW4sJIVtJvJl/V1mlt7nq8
	x9P3mEIJ+yBu8efWBLRbil7iujlIwIpciuQ==
X-ME-Sender: <xms:T2KPaixRbXLUVpzHJ-ohKozKt4bUNKsz1YSky9XGE_fsFdg9ohblZA>
    <xme:T2KPah9ZeuOTAZS7oQXIZK-vdaOaqUj39yYHWi1Z8M4hm1ZMVjWtUz0yCGOmYB_er
    5z96qAUyQEisnmL0qNYOdOuBJSnQQuCYrzz_5h2eM4b7d1oO7ZHZg>
X-ME-Received: <xmr:T2KPauImgRrbDNYHNNjeEQkJGGmOK2lc5KbvF1bAInCTiGxj4Y7PlDkfYFV0UFf4PMXveQ5O2yHQK7iAeF3lTKrEr2qRCOdMPA>
X-ME-Proxy-Cause: dmFkZTEQx4uu7tQdrrUXbDsArAVnIAhgFk6/iz6UC0A+exMXK/i/Kd1LDcYtFqSkkFxysC
    E4EGLIjNnW2cTCMa0bBKUDIMqPFtdkXPewV+kWzU5OJYy0j0BrVsvMIDvz+i1o2ZKcD5gx
    fMH3kmlSb+KqB4g7k2wFEztqX/22kKEHGWOJyIHqz4VgqYGKLjlvbSWbwWXvZP70IsAIkw
    yse41enO0DnQyNj5HMGvefzcu0qVTSaOlR3qCzJjgbPpTC01xrZFGr1qsHDodFGA1L9M9J
    2L1IP+zqaFjT2SffmkLV5oWhOlbE0AsglOtU2NFEzynAg2JfOrWcK395Xwtj8xJ7qeylLi
    4qhlPX6VO+pBRj9MxM+M/hTZZ6SOs0qsbw1a0dayZAcvETYRTea70TYPOBdGMkRYIKZXSY
    BcCrHX0O35wr5CweVYcQjQxD8t5DPRAAANBSw0UZ/J6Z8ra75g2B3/A908IcI3ZFilJj5X
    BDADPr4jL/eGxYDO6WYR2mKlhDrCojYbrzDJLur0s4x18fljQ6HCmUauCKQKu88VYZLDqc
    Xs65qJ2Pauu5W7jRxAmg8xhDQZExNpwlHhhlB7vYaoqJRtkmWLgZDJ29YrAvWO795h5xS0
    8Lr5MahxaYoOW2GytGV9EDQpeJXLTi96KMIp2PxIyR5BioQJR/MTgnUUyT4g
X-ME-Proxy: <xmx:T2KPavcJMgo8ZUVQFzxjraeWqocKwV48SOy-oI6aXJh7QSGohVC54Q>
    <xmx:T2KPal_3axS_n6BVKYSU0s8RSRnWxUQPew0NZ0p8ZpU7u43Lxdugxw>
    <xmx:T2KPakrM-65ke_2LWjXrrVvejt_w9QOODYpZZvzAFH58Gkg4XUzadg>
    <xmx:T2KPaiDuAEkPTUGPCK5R-7maxX7AaQc0K0TCfMXVFg1Tz1jLX6YHTg>
    <xmx:T2KPamgdwmHTu4J1qKFKo6iXMSzviyiQ6GOXIJNavBu6XJr27imRSfRh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 18:01:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: graysongordon-gl <graysongordon1@gmail.com>,  peff@peff.net,
  avarab@gmail.com,  ps@pks.im
Subject: Re: [PATCH v6] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <20260818214858.65122-1-ggordon@gitlab.com> (graysongordon-gl's
	message of "Tue, 18 Aug 2026 17:48:58 -0400")
References: <xmqqmruqt36l.fsf@gitster.g>
	<20260818214858.65122-1-ggordon@gitlab.com>
Date: Wed, 26 Aug 2026 15:01:49 -0700
Message-ID: <xmqqpkz4czhu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

graysongordon-gl <graysongordon1@gmail.com> writes:

> From: Grayson Gordon <graysongordon1@gmail.com>
>
> git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
> OCSP "Certificate Status Request" extension and any stapled response a
> server sends is ignored, including responses that explicitly state the
> certificate has been revoked.
>
> Add an http.sslVerifyStatus boolean that maps to
> CURLOPT_SSL_VERIFYSTATUS.
> http_options() is already the collect_fn for a urlmatch config, so the
> per-URL form works with no changes:
>
>     git config http.https://example.com/.sslVerifyStatus true
>
> Defaults to false/"off". This is due to the nature of the OCSP protocol.
> If enabled, git would expect to receive OCSP stapled responses. If the
> stapled responses were not present, the connection would be blocked as
> the status of the server's certificate could not be verified. This would
> break connections to legitimate services that don't use OCSP as their
> certificate revocation mechanism.
>
> If the backend can't check the staple, curl_easy_setopt() returns
> CURLE_NOT_BUILT_IN. Error message includes curl_easy_strerror() with
> the option name to enable users to more easily identify a libcurl
> built without status verification.
>
> CURLOPT_SSL_VERIFYSTATUS has existed since libcurl 7.41.0, below our
> 7.61.0 floor, so no version guard is needed.
>
> Tests are in t5551.
>
> Additional note - I put this in http.adoc:
> "Defaults to false, which
> allows connections to remotes without validating whether or not
> the certificate has been revoked by the certificate authority."
>
> Technically, there are cases with older combinations of GnuTLS
> and curl where the revocation logic actually WILL NOT allow
> such connections. Search "OCSP" in the lore for full details.
>
> Signed-off-by: Grayson Gordon <graysongordon1@gmail.com>
> ---
>  Documentation/config/http.adoc | 14 ++++++++++++++
>  http.c                         | 14 ++++++++++++++
>  t/t5551-http-fetch-smart.sh    | 29 +++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)

Are folks happy with this iteration?  I think we have already
reached the point of diminishing returns before the thread went
dark.

Thanks.
