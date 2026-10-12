Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149247AF69
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825508; cv=none; b=saouGoMS8CfP71COEFQT90kQQwnkp7gdRk6NbRM2yXZdIH/3yAw21IEOgDx+DWG+CzXJWJ+INdIQQznLXA1bvo06MLqvlfY5SMPAm7w69SVCk5JrqoB5sFwIITwoosV/t/77PXgQJE4Ng5yCRbIvGIMD0cz3rCr/S/48Dgqs2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825508; c=relaxed/simple;
	bh=3yvtziA31Wm8ets8lzrMFDgjaTI441emcisdtzdCfEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bN6voMQkhq+N/uljn93Rv5BU5z+EJsE0HUcWuJwpinR2Qz5d6clhTNaeX8A3Hmn5GzZpsWTPChCRRjYWkHubj01DkINjrUBgHdxxVFYC9FSumVYevNJ6E8elDGXCUFR7fZwkAe8xnmiBh+QecMKg8I2A6o/gZYUnIftYPbvaKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M1lQNJTk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3VJ+9X9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M1lQNJTk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3VJ+9X9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F366140011C
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 13:18:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 12 Oct 2026 13:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791825506; x=1791911906; bh=s94ZCfdGSJ
	uNXvAOcjGzVoUOa22J4+Il5tT0p5Wx6vc=; b=M1lQNJTk1zMpkPeJo0B/V9S0Ah
	mZjg41I0BhMhCsI7poekmpzE31ZvXPqAFFa/1QyREV2c5UlAvrEfe+/qMOi1XtJH
	N0gK/TLUkQPHL03vp+8qTDa9089bUlXNNuKducbB0CXE8Y8/rr1kU22t2z5IO0GB
	fxujtJdtMK2RuPC7mraZM5yHuMNEz2EvNgWdgExqHKe4mJV5W1YvKNYnTPVetaiI
	i+OaKJ6siDAbOVil+QOXGzcsgtsv36XcVHO6BdS6tmTftl8nxg+EFeOZvK8DBJlq
	psQclcTAVo7SfuJAB3EcC+Bd+vvNJGZmk2+ZlVHeFQdcqVDL2W4I55fl3W1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791825506; x=1791911906; bh=s94ZCfdGSJuNXvAOcjGzVoUOa22J4+Il5tT
	0p5Wx6vc=; b=k3VJ+9X9aYsiYH5gYUhLuR9cdJzNa+izpsp4V36rt5Vabanek7s
	iqJys7HscB/LQCf88c0oOXvtgegtRAaj3I6wg8l90uBwQRH7y4wgIYrlno7ockue
	wmE+hBHVH7dw7l3Ep/vOwLLQnCd4tjDhCARI9eXi60apUFTH/Q67+5oKtBNiLrtE
	iTmWv/jKQbiC50JyLvTnI/s4P60N80EYsYUNRtYh+bkJyancFf5TozXs3CpdaSV7
	koOKgFA9DBVej/zJA6gBgfeHnoAO7eFsUwq8fVOGoft/VBFxiFHufdLeYq+a3G8y
	xgimKVNfLDr6dRqNSJ48cDuOk3Jpx1Gdq/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791825506; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Hpu4FZJ51XZyzfWhXnVvJl4aeJl8ULYQ/7jUNUWx9QPznkH
	owQRHfEP9vnL+5N/+nHEoYlTrEDFiReFTQq+LgnNI+y5Njk3xc7DthJSPBe62BHZ
	+YRQOv26HOVMKMDq+MxDxtzE2ekdCl3+17QvQM8Dnf8XJwDrgkrVaget5uQ/odEa
	r/rfxz0U2EJyGkMr8u/+xpv3MwBcqfN22U2HSxPQFOE/87MJfD5ZnxevrZCtvp7w
	qau4WN7heLuzD48XqvJaWkmvuS+ZoEPrrFHHz6Q0cfV6wT4kQuQfjk9uxL47cGDp
	nUlWXq+vCof/233v67Vx5l6m3ls15LJ+gawuAyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:m4FYGCFFby8TZlfPZYSvUDI7n4motuV7mtmhAvBAPqA=:3yvtziA31Wm8ets8lzrMFDgjaTI441emcisdtzdCfEw=;
X-ME-Sender: <xms:YRbNaqpOsXruFEinw0PK-KZjpc-TF6iv5NwAde4KZBHOH8ee2TmvtQ>
    <xme:YRbNans1TAmtni2Ngo45P4Cm2BNuxf0qu9k7IDXMOHnQWjuYXi3VjqjqnOynuiZmf
    MPL-CYD9Wm9Me3MgHJqkF_tnDfnoq-UK-LEY6ViixeFhiRhe8npag>
X-ME-Received: <xmr:YRbNalYFcPiVETFjg0ds6Mj6_b0P47DpFkNGAYPgqbb--YrjHnUyJcr4tJU6gGLd_UcKBkm3JZcMxbInr6v6p7nPJwg0wgIfHnpH>
X-ME-Proxy-Cause: dmFkZTGzJbPuljTIqNWnFT+k02aSHva/lO+FbOXjcclPpHCsNw1KprhvSprSK07RxegrX7
    RL0MxLGs1o+WOY1aZWnDjD/58fWhfDnVGrMfTb2fEwqkY0zo2wmPHaKQ4Eghax54sph6X1
    qpEC6fKvIOODSNrzYa4SYMh87S6m2g1zqzDJMKUQ0jPykoGNuROb65vcjt7xT/yOzjEx2v
    4n0P1V4UlJzkZnxne6VgzYNrhXDEFazqJTmLJuR/iIh/A5KN3Br7bo+fq4fAnI2WUfT9ub
    K12B01Fc0h6uB0GIvKCYP+wzu8avL7IJ7hi9bZ+0393vG9FIdSFSc9syGSw68bblMafTof
    fgxbwEP468H+0DEAptAmYgMU9mMFFcftpRDDQB0gfMUOHt2ymZmNvO/j19VfAf1QBNxqtC
    b5Vv2flDz1AGKb7JuzaVbdfvp3sX/Itgr0vyt1biTfP6g2MlVuNiI4O1Jla1oCFPxNn3YE
    0PzCzTfKnMB6Z6Rp07qFcSssZ8Ezwry4QHqEeIBwJkJg6JIZL/PNjFMpl5apzqRZmWsKdP
    KWwwBZmedHaoNZBpV160pfpa/5AEV9xurItbskA7j91yG9upYcnP3s0bXFpHjmbuxoRJPA
    0qIjp9mlQSh0vCYVSjctFp8G7bWv63KlwsoiH2RhIp2MYoix4aAq65oLGiww
X-ME-Proxy: <xmx:YRbNamanrmCmaW0RBLFjW-eOq21Vnoxb_KQ3RBX2rzpPW3MHjb_RnA>
    <xmx:YRbNaul4CQPHWB1BaKuaKjLYdEpF_7LygkgF97kkw08cqAJYN2Vsgg>
    <xmx:YRbNah3PLTOEagmpZBKTq_dWSTomiUDgO5FxW7et9k33IcdfMWN54Q>
    <xmx:YRbNau2NFIpKPH2yvNCeCdSD1erLVblKpe8BK8OzcUM-OC3viZkDoA>
    <xmx:YhbNav2REB-YuGy1YeFvst4Kp8JgM11eYljEKm4YWbXNo5XJcA_tpGEI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 13:18:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: Xiangfei Ding <xfding@google.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>,
  git@vger.kernel.org,
  dev+git@drbeat.li,
  davidben@google.com,
  dingxiangfei2009@protonmail.ch
Subject: Re: [PATCH] imap-send: use ASN1_STRING_length
In-Reply-To: <20261012151748.62723-1-aniketgupta3001@gmail.com> (Aniket
	Gupta's message of "Mon, 12 Oct 2026 15:17:48 +0000")
References: <20261011210928.3900020-1-xfding@google.com>
	<20261012151748.62723-1-aniketgupta3001@gmail.com>
Date: Mon, 12 Oct 2026 10:18:24 -0700
Message-ID: <xmqqv77696sf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> Hello Xiangfei,
>
>> +	int pat_len = ASN1_STRING_length(asn1_str);
>
> It seems that with OpenSSL 4.1.0-beta2 this is deprecated
> (ASN1_STRING_get_length() is the replacement), so it warns, and
> fails with DEVELOPER=1. The patch adds a second use at the error
> message. Beat Bolli has a series from 7 Sept ("imap-send: future
> proofing and two correctness fixes") that also touches
> host_matches(), maybe we can check how the two can fit together?
>
> Thanks,
> Aniket

[jch: rewrapped long unreadable lines]

That topic also needs rework, unfortunately.

  https://lore.kernel.org/git/20260907211210.2621693-1-dev+git@drbeat.li/

I guess we can salvage the patches 1 and 2 with fairly trivial
changes, namely with the style fix in [1/3], and pointer arithmetic
that breaks later free() fix in [2/3].  I am not sure how involved
it would be to fix [3/3] in such a way suggested by brian in the
thread.

Thanks for reminding us of the old thread.


