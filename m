Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355825F7B9
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790981237; cv=none; b=BM+CiC+/mbc1DphOm25VpIFbeU+Pl1oNLTq5+bFAMZ/MfXn4KqyKsm+4mv/WTNhIzpU1UyG1mfjnUv5t1dZll7NH9oEpgHT+PSEslCEdtF70VXw6yIM8cuGibXAoDdTVLyDO+nXOlYvdzbzq+BA3Kwu9RWHfPTt6te8hJNlMhTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790981237; c=relaxed/simple;
	bh=8PBqeNF35Yl9A0pDZAKXDPE9RYxdoKxrBzHHg0Qr9y0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uqd7aygGox6vyN3sGmYjwscocWMl4jVVB3Oksc8gfGJcs4KLxMN9e3ZsFC4gg69r7zhmB1lqaOEBepsPP28hluEMdQ+NrDHjLYAzNPhn83EgN7lteXe35BiRvUGexo0yxIpvVIV+3Gg+ZeGuzL+o5BXB/DnhyfIoCf7+oBFUG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kpQj4Toa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pw4hABZd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kpQj4Toa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pw4hABZd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 54D941D00133
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 18:47:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 18:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790981235; x=1791067635; bh=EXAFy3iUsu
	qDRyLMU/2pgYcHkAih4u1s11xJLu5f5KM=; b=kpQj4ToakCPFF61dN80TJ7NR6k
	LHowr+hE7lt7+5XoZcnr5e6+ptpEd7chokj8pvWguNIsI0m6vv6t8HU7dZYN563b
	gdtoaYmMNmjQXZa+5mIFmJtpAc9kT+KmiP/RDNjrqIEYcCyMKuOeGoxs17ARH/2X
	KhBY805SBTCHBkZfo9/ontNA9arpwJWEHL77KZFXHBkyq3zSPXa1nQZzcg+3qRyp
	/r6Xp4AzDYo7Qsnn5H5Nain6gbL6N0U1IZ5d5NoG8VZvDmxEVlrmzX5sf2/d0mrA
	4Th4GPQkF7iuYrUJ6Iy304St6WJr0gEUY9j4bWSw0eX9VO4b+OrGhuiF4kmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790981235; x=1791067635; bh=EXAFy3iUsuqDRyLMU/2pgYcHkAih4u1s11x
	JLu5f5KM=; b=Pw4hABZdhVX8ZhOGUh5OPCfVe9V6QlXM7L95KkOZEv7fmKdo82V
	wU7s9duYKl4tT8PJUPcnq6M1n1iW66M5D/cagJjAQA2p722hd0Q4hTpA8jmx8Gte
	oTokfyzy89NUYaFq2HSQ2jqngzJl58/S4ufVM4lyBxSXV7EDv7fsckjVit34BuDe
	nybBtmvfAJ2KngoZ8zkph0y/BofhYS/6aQqyfEBS4PnU7pJNOfQOLS2FyRDE1kWy
	7Wo8wYU5uWvIyg6i5d+zIC/QSMNbXtbjWMVyAs65FOHz+HzotzDWu/JIT+Y5uF+/
	7TNSuhDk0VasyOiNHreL9iFFMIBopV3yGcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790981235; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:otk2QZR4eQde8g9zG1dwE6LV0E2OROVplJg4rQ+H/no6WSV
	qGwTBo6ktldCqxKtvqOM5hBL+mlW8h1GJbudiijbB9z322OEgSuTUUcFWelyZ51M
	gMiFv5mXg0ZcwumKeKz1li4M5xTbXgWcPJ51flyyQ7/taxcCdLDU8pxShtBoFN3/
	w11ImF4NPddzIZGmUVnSGRUNwzHACkXChccviXycoOZm+FPHi/lSbSA8+3VrEdle
	bNxB9ThWwwg+6C0Osdkd+V5fnBvoPCsULqLzH3kSGDW8xBVnldSsAHJ3hx2bLYSJ
	rcQuyKTqzPRfQi9izK9ZifGsa017RpOqOEjMNVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:eztEGljoXZQbInI2iAEvSEKJ0jQPvqljMnHTFQLO45s=:8PBqeNF35Yl9A0pDZAKXDPE9RYxdoKxrBzHHg0Qr9y0=;
X-ME-Sender: <xms:cjTAas1YBoB3tL5ScfRo1qQZPTnXLC67hYfKWqO-ACqFAc8xZPqhIQ>
    <xme:cjTAauG9pjzeZ-2Px3iMo5N97jcgOu-Gprl5vsV1LB8vLpTvAd9JFWkVcMQyxm227
    Fxb3gocEYYXEwY8ZO0X639KHtnNL4HMvDAqYVYwJCWxptB1saocFRM>
X-ME-Received: <xmr:cjTAap4M7ThvDSyFBW36VVw_0hB-8mrFG9_0xiMPRSGeYcubN7UJlZbyhvcI05HucwpNEj_f76OxpXDmJdD_AFLDWgrzgXee0N3B>
X-ME-Proxy-Cause: dmFkZTEgeM2N9rewWpElACJUsI9e5w4aAWnH7tZq8R2an+glT36qrNSKISaz5ieZe2g0C7
    R48c+ZAQHtH5uyRTlR3Anv9fThsgx5d65XWiHFmX2r+E3nosZZYsUp1UQUYBsvhKl0Cdpp
    rl32qEO3+U0z48tcnfh15WZ7eo/Gh7H/n34nl7zarn0sR9XEkN2bQhBQJxJoA4okry6PuU
    fxkME1ISGSD4pIK75y25FJd5TMxjvOLs1qGUp05hcyb43Xx4hKMiOaPU4Krpkmbxt7iMQ3
    eBdSjTiv4PXIMsZt3KQ/LZ3KLOnn7jbBVTpWk6P41qCPVkqvCQBnbYTSe6oo90gS2ppTWp
    T/HVE4UVm4lkVMNJfGWGahhqWY0lQ9IpIn8sdJDHdFErvvB41W/WgaYh2o5nELe37Pr98i
    vTu/69UCEHXq6TE+DYvFng1TvYMJPn5S4Qfpk5TeZ8upTbj68edSlccY7ad+aZj41YHeYF
    DbgdlGEvJWwF+BMwPMX1oxZzwSFWAydOGuaA22X5WpMlurrZwMAnGHRHfHH8VEYpaqLtbG
    pPSnZeWN1MBlKg29gDsFOjENOUCuKDNy17jGzZHx6Bmsf2gVsPpiIWPyyzw3RZIfyr0lAi
    jFVaz5MtlhMRcWFs1QKbXC2Cgk4Gfa0JH7SFaSI98N8K0BTGMLz56apJpNHg
X-ME-Proxy: <xmx:cjTAakthDLX2lIFplvc0W6YuMV_bWfswF70X6phVLQs3uM-PViMGYw>
    <xmx:cjTAaq4EFJ4Ko0HJE15sMhhwkwo75n--s7AXaTVVT8NoG2MgDskHzw>
    <xmx:cjTAavWfuM1vMYMeXwpK7EMlvuhKK8dQfqhrpVDLCwhbkmN3LsfHzw>
    <xmx:cjTAas9MGes6g1hUOOExxjLVzf3PN2-2JBfdVSxuVtMgUS1zk66j3g>
    <xmx:czTAaggokyyxwSYq6NV89o95kmbN9aTfy0oj0vbDcDaMHYijuQ15AATh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 18:47:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v4 0/2] history: sign rewritten commits
In-Reply-To: <20261002132718.3830-1-git@5ouma.me> (Souma's message of "Fri, 2
	Oct 2026 22:27:16 +0900")
References: <20260703145037.69832-1-git@5ouma.me>
	<20261002132718.3830-1-git@5ouma.me>
Date: Fri, 02 Oct 2026 15:47:13 -0700
Message-ID: <xmqq7bjzvhxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Souma <git@5ouma.me> writes:

> History rewriting creates commits through two paths: the history commands
> write replacement commits directly, while the replay machinery recreates
> descendants above the rewritten range. Neither path currently honors
> `commit.gpgSign` or an explicit signing request, so rewriting signed history
> can leave the resulting commits unsigned.

With this topic merged, 'seen' seems to break t9902.

Also, is this expected?

    $ git history split --git-completion-helper
    --update-refs= --dry-run --gpg-sign --no-dry-run -- --no-gpg-sign

