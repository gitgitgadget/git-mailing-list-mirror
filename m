Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CD27FB37
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391953; cv=none; b=aNPONdyX378Yj6ZBdyGYc/jaS04Q9uQS9UCDBUDU8m+51WJ2bi3JwE9AQkV7Mdp/XRU7NFByCVxe2ose3jtZBx8W3W4Lk7VVQ5JU77K6trgLgsPchEXykDapXPQ2oYD5pOjyOxojMPbwtLb/s5ZG1BS0lAmw1n0RQk34GgMYgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391953; c=relaxed/simple;
	bh=QXq6bYolNF9RaRCHqXBEs9cISGtLSxu1L4MOuqlgONs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKIYxSHGQjXF3pkqSRD6PgRx3QZPCKzBej+/fd9VNbJLllmb868GwCsk21owowgxeJDgsjY7YyAbCQWtDxl56diBFp/EAbA/akfXxtdrYqQ248rGl2+K+PBWOpZp4dL+HEci/3G4jr7nvv/yl0gd5r2ovR2ta3s52CUfPGrgCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iHo4Be9Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hi8ucNkG; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iHo4Be9Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hi8ucNkG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01B127A0183
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:39:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 19 Oct 2026 02:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792391950; x=1792478350; bh=tBGDYtKVGx
	ge0uCiYbh2Kggre2KPsNamOO4eULnN/0w=; b=iHo4Be9QjXIMfLYVdLcbaY91ql
	tFxKlHzHn5doeK+qi53rGZjTIibQVCBRLjmNuM/7uINk4NYbyYHm3kS7hMBWjS1p
	2CDNv5Imy3Gck7gwKywfGk6lXe8zgEP4O8sIqQDLBReBX+tYuMgQ5r6EfZrBXfHa
	r4ku/0lam7bFnXcmodEQsmrRCHb1PrgsrXX1lA4RJNjMtr8nVTjLWcp4BjnPDavf
	2teO/h2ss3vCn2ziBcmYoFuZ6fX5HzmQHSihKVs8jypIJUxFc3fKlA5Bb10OPeND
	Elt9DRgXvSatqDxybW8p9Gkj4jwWb7sD7QATSjiHYBMrT9BCkZSNguEin9ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792391950; x=1792478350; bh=tBGDYtKVGxge0uCiYbh2Kggre2KPsNamOO4
	eULnN/0w=; b=Hi8ucNkGUXvl+uBA0gWYDSML2PbluTOy4fufVraoTIa4wg/tC1i
	Y05ag5SJ5mV9xAdPY4Si8INQu3VpXMDiI8Lw9c37WATlfF3lZ1IvuxxHujhbY30B
	2qntp0FnzbIMsJmuGqEeJw+mf5zvvMkKp2tJpuD9cFxRliG3bz3mu3jikR30s5Kc
	UzArdaFzKdPKVIgHt8m4ixpwugPw6pzpRipXfdOxCjtypBiPlR1vXXUWxXW0HL8s
	u6j+iC0IY+a+a+jpCtDTzJT1OKIsWDQ+UQXQZVrZOo/U7zreLI6XP29s+/CKMhkd
	EdpzKEwXIQzFCnxVwI56SNGBrubdQqZQoWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792391950; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:twN36LHNAUJESiNckwl75R09IdmMPlKBrGApB2GPGsXpU+4
	HUoTp20PjdNUx8FE8JLfFSTcezOrMu/8rdiJA9l1T/di85wF7qGozDiF1ZPSe62s
	xUsGDfyz0EkBH+kcA6eXvyrMvMCmZDbxqAtFecoK6cJcs9XZCRVlC2f3Ycepujqm
	4axW7RyxD4RCipPNBCibC52QH9nTrHeppbvdlofyg+s1tbZ1eURZNyXwUBtoGyVU
	LN/NLrl3vpU+rhRjwafkMJ156nRCSSOyIpJBTa9DIEjAs2oSB/HfkCQ++dUjjJS9
	+aC1tzoK82stLLIHTTr6jb/7DwT/p2aAKud1s9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:K1u7YxbW3KC/iccu0SyRjbcgnp9/aTvelILoCedHkLo=:QXq6bYolNF9RaRCHqXBEs9cISGtLSxu1L4MOuqlgONs=;
X-ME-Sender: <xms:DrvVamAsEOixSF1rQIUVey04eCQzbTYHdjh7hkbt2aPs9zd95-dZbQ>
    <xme:DrvVakNmsnb5NfQ9RRO0ebfxrhQ4TPO5rP3J1WDj2T5RhvWfYFgkrQUwLjwIa9B9a
    dnFS39XlTuZWBzlo1rETJUyPBTObl96UKqHA634x2gBzTQJBKyDG-E>
X-ME-Received: <xmr:DrvVajYXXXra-qxmUCTdGyXXih82K9-RicI8pDULvkaYqjPI4O64Xg>
X-ME-Proxy-Cause: dmFkZTEu2RnnpAxLtBw4//oJHyp+Efyj5C92tFzem99EgIMrLqYIKtDTv74oMsjNhzpjdh
    pW5f10YQF99LjozQF+h03comkHHoIez60XBAI9CP5QQ/NTDtqRMCUMUHJhhcNMgsfz8+ST
    mXtNuJyYAnDiUQ1xcdJwsK5nhmardICLks/As5iBZ91THHdnqJr9zFSkNGJdXnbAs5zgcH
    JS6LS/YBUp3FPQ9/PPJ+awbZJXS+6ahP1ERllfo05K8pQbBAdqJTke0BxnaWXhdrocmZwg
    NMMMyyYCHnQgdwzctwmGRyISE7d39vvZLXeZqknv1SchfuvSrUdjQMPZwuAbFjKL5pDxbX
    gDD9hqocri8hiU6MHaZvQFI65vdUwMbJ/sfzI6JqLPz7pbHF8hRcAvTfVOaZMxQfkPH1aV
    5wLbnge5b857l79EWPj4jSTfWXUSSWHdsp+GIbUcRujxm0CF1Rpis543MqrH//jjKYRRcY
    WDbuquvyCMnjjTxQNMhDMXLfp3DmDDfl9ceEHVrplXmz73klx0vlKydd5bj/2OmxehP6+/
    M9PX1fEIPKpSy/Uk08XDc2Q2xDkU5ndAxO26PzkKeWKPITvNDtA5YOHGLssQaAPKzK8gBd
    Y/I7ftVRJjwI6yDViWdxOz0+VYhyte9sr8lSP7J9ydgAyRzqgqjd+z/w1CPA
X-ME-Proxy: <xmx:DrvVarvVMtp3wDuXi8aQ1B8pXX3oBxWmdrU0HXREVTiLJWgQL3_-Aw>
    <xmx:DrvVatPRhCw55dv4e0qkMpkg5OFbHr0fQZ6P_8dF5-bYeAeZZ6Yqfw>
    <xmx:DrvVaq4HxUBQLRJm9a5X82csPANy0V93hGt8CotUiNc5ZePMjd7GAA>
    <xmx:DrvVarQPO596Mk5DpAZYaUhcLBOU6Lfo6XQ0eF716ZHglPcXNvK86w>
    <xmx:DrvVaiex787pXjfJD1JXPUHIGPt9I0sl1LRNJVknUuym4AkVD_NF5xdy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:39:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49b371dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:39:07 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:39:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Xiangfei Ding <xfding@google.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/3] imap-send: use the recommended TLS_method()
Message-ID: <atW7CLcWmKRk4sMv@pks.im>
References: <20261012203057.969878-1-dev+git@drbeat.li>
 <20261017100956.529225-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017100956.529225-1-dev+git@drbeat.li>

On Sat, Oct 17, 2026 at 12:09:54PM +0200, Beat Bolli wrote:
> SSLv23_method() has been deprecated since OpenSSL 1.1.0, and
> TLS_method() is the recommended function[1].
> 
> Let's use the current function, lest a reader of the code thinks we
> don't support current TLS versions.
> 
> [1]: https://docs.openssl.org/master/man3/SSL_CTX_new/#history
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>

I would have appreciated a cover letter that points out:

  - What this series is doing.

  - What has changed between v2 and v3, ideally including a range-diff.

Like, why is there a third patch now, for example? I have no idea, so
for reviews to go smooth and efficient we require help from the authors
of a given patch series.

I would recommend using b4 going forward, which automatically manages
all of those details for you.

Also, we strongly encourage folks to please reply to review feedback
directly instead of just sending the next version of a patch series.

Patrick
