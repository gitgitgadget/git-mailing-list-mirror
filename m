Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388304AE102
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474960; cv=none; b=LWKIyIuEtpacJAqQxboDoXc13VHk7W5M2Ma2ofS+rNhnaRt8QWXYf5CJqpPImFQT4iiwqvimw5qA6P/2T1cYu3F1DXqEDFm0Lk995ESjFcScM02xqiyVsRPmnliin+09+DizlsJYFCayXieySoGd7QBZirrXLW1o8nWfqkm5U6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474960; c=relaxed/simple;
	bh=PxKAngd54g2TgHmfuEXLBA5ywG1q8I5nu9ZgtTrgDbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lWkKmcAUGEoF9/oNfgbDvd8JL9vMj9E7SSzgso6RUXwR7KwhoDkbMqOXRLpRxK+r2s2+srBLKN1L8vCjDzqQJDo3v50aQqJtzbpjD7AqjqYOyGrbPHqISAfALjo+O2WCG1zO9SvKs/BP3nXK0/kZbmIv1Gu/YybBOADYkOhSK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=idF1efCv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KmJm0fTR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="idF1efCv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmJm0fTR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70C587A010E
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 11:55:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 08 Oct 2026 11:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791474957; x=1791561357; bh=i1/PaeG7aO
	CH3wZ87AB347iFzXqqCT9ksJ+9QEKNCcs=; b=idF1efCvxkv5ts/b7ZqZE9PkD4
	6ZyYSehkrt0STCPAkf1kfyTvL30hmiTY3e3+yXbBDl5RYDVkDGg3TopH3pdz5PfL
	KN+4J/WEW6Eyfrbt8GbhY4znujtlHrOonRwwOoiFK1xCyeRq6JQ6NBoXRK5Id/Nv
	QH/Gc1mNlT1WFjjkdeRO27nUWik70bwHd8JAK43NMzqU0sYqFQMFgwANUTgJHFSP
	eE4TPgci8TuECXeM8QeeqdKLjq436edkojbOXxKMRgNwNsj1nZwKsy65OXynqtqX
	VPsUJ7haM7ZL1am4eDu1xSv4rEERGHM9Jezcnv5aTi7DsK5niouSPdIyp5pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791474957; x=1791561357; bh=i1/PaeG7aOCH3wZ87AB347iFzXqqCT9ksJ+
	9QEKNCcs=; b=KmJm0fTRi6y0M6W9iZw4jyfjU6pa39U2JZ8I1k8N9SPYMRc1wh1
	p2+Guz9kLuMA/aRQMMnpazNf2TLo4PJnuNBxEklzHLfGmiqNz78OKBy/jsQEqTEh
	DBOQ1Thin+u4yhjtCPy/lZirKZ6eFAsPZWRNRzuaaHrQE9B5nSs4gVcVFzb/8HFc
	VK2A6VQy5PT5wfDQtu7TWqvkVSsleZbRTmJIhOFKDrEbKDK9wYYKgNhrOPhc1UKS
	2qK5Av0TOFSwPMfPnQcGUSFh9hQWlPOepJHAEHPNG9A90gZxw9CQSxw7u+01ybub
	KPVDr6JwJBrmkeve6cRMEL8BLKvVZ82y1mA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791474957; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ppxBp7COJT/OTknQUSGrMDlPjAj6fDzSKX7uQZWLz9KAllo
	4PpPfdmoDja5ff/kmBXg6bjm+jPRUYxmbTubYZo/xE5+l2XB0o+0qgZ+J4bOIjGN
	C5j1vw0nAKgRPcFiNYMm78fSPyvQccBKD371vw6orkkapNLz7Ju8QYT4ATwJMwVX
	5GCPp2K/kDJsxw96egM9mhHsTOUHED/l8MB4ENgT8RO76RiOftpmqWzx120Dmubb
	ok9X3rm8eHUIJdt5buO8jjg5unAH0+I4URfLfn63Ax/TqIloSnTXU7ihNIQOh2eW
	4ErF6bIoala6zFf50sYkG0XC1UCTo89aWtvxijw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gEx5A7cOhn50pDQIFRgqGqe/ZHSsUTiUqFPhNFi5MEQ=:PxKAngd54g2TgHmfuEXLBA5ywG1q8I5nu9ZgtTrgDbQ=;
X-ME-Sender: <xms:Db3HaseAX5PwuilMss-83CnsXl_wJQe0BhLWnrlyhVKYGljXLoWZfA>
    <xme:Db3Hah7gQc70Y2Dy_p49w7hP9KlIbovEqLhQN1wO3RpYmygWNUjNm0I91kJRuF92h
    nTw4l4sLUMMXAq2ZEgo9RKqokhBhGFfLuv5n-28Z1Ho_aZQysB3fH_W>
X-ME-Received: <xmr:Db3HanW70umKjFhB8m-EONXuaxYtd_awAms2SSMiY8Rbmub3GU7LqZjIIQhIiiVzzEWrMRPjJfEOS9DTSavtDANNl4hjUojdLa-X>
X-ME-Proxy-Cause: dmFkZTGgxtZGkmvYwRLYNtm3v1Ayps5lupG9ZA2STGAn3+7Pnaj77GxU2PQiUiFnhE3mCO
    my6fWWSXhfF1g0HTQ4h+C8DFGlbTDslkAxHpHwLNHfhFsmy2ATsM2iKl1mKoT/6pNo76Ae
    6qHYl2f6Yz1RH7bVNnzuFbf13ppguGXwLcUwPCeD2o9L6tsORgjXd0hI9pbfWE7mW9Xe/B
    eYltUn15BBnszsJSEbGfizTGrKUuxpt6SeurEkYDF85ja4PioVNBx7MZt34v7eXPVybVpT
    ryf9PbrE4F9pxjZGezpWRaePbskph66UoJxyRFmg5bY3HI2qIzKRLNLDBvzut9kkuhhsF3
    rI3f5H1N6ul73Kw0005sYQM8D9HuYAK0aT7CxGqxnESAHgHRVFjWW3bGoZS/16CiSNnCUr
    PzWDPWklNjnFf7E+QHNI48cla3NHs55aTduEoFOaYbO8IUjP1yRUKIpQrGZki62oGbs0W9
    T1GLogtrq9ecE5FhDR3EZTdKLpCtitjHOOha4+c38ruRoTFA7VFaGKwIjetMzohpc1Kl5r
    /EuIasYwiWLuEdY6/wYHaNMUCO3QgzrNPbIAGfDtlAEay3vfTZA2muJ+zGIUw8V0QxKbSq
    TL5RgGIRF9AO6fbTCFAYZhkeau0SBERzkDcdPMd3DQjOPMLyK+W57UEZXrsw
X-ME-Proxy: <xmx:Db3Hao5e7gzQjMcVcvjOS_nPLrnSHRiHCXJzoQL1bqrvQ7UcQaG5-w>
    <xmx:Db3Haqqlz1_dLsh-lRBRkpnzdFB9R0_xUO0noDG2r59X87cqDIsfDA>
    <xmx:Db3HajlkKA7hhjIgLDssUrYEKu7VT8g5Oec20EXzWkRWZxBNQxQ4Zw>
    <xmx:Db3HauNY0jGETp3Cv_yXjaBUXYMzTav2YljPRTxAWYUSTm2Of1lxGg>
    <xmx:Db3Haix-CMVVJ5IRdRvpv8LRhigUICLza3Pjkyc7G99zFX3lzvnGXwYV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 11:55:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sam Reis <sam@opencanopy.dev>
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>,  Scott Chacon
 <schacon@gmail.com>,  Scott Chacon <scott@gitbutler.net>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
In-Reply-To: <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
	(Sam Reis's message of "Thu, 8 Oct 2026 13:20:33 +0200")
References: <20260929112544.86511-1-scott@gitbutler.net>
	<xmqq5wzda0h6.fsf@gitster.g>
	<CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
	<79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com>
	<CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
Date: Thu, 08 Oct 2026 08:55:55 -0700
Message-ID: <xmqqa4oo2nlg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sam Reis <sam@opencanopy.dev> writes:

> Hey everyone. Just for the avoidance of doubt, very happy to see
> Scott's patch here land and for git to benefit from faster sha1dc
> hashing. Let me know if I can do anything to support!

Thanks.  Just to make sure I understand, are you endorsing the idea
of your work geting ported to help Git, or are you also happy with
the actual code Scott submitted?
