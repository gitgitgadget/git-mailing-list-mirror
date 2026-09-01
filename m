Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192353603C2
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237312; cv=none; b=BfmqwruGuUcKRvp7qbAnddxIKj51zCpzpda0MkxdLLlMrWbxyMpIOugMLJP6FHg9FBi6fK6A7Ef/ppwhkv4pfMTGEiQoxjfDelsK+1n6N8zdjNGa/7Sx4y5D9tPwwC46rv39dWY6KATaq9dHkKs4Jx5YALQx3FArLYp4BWbLifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237312; c=relaxed/simple;
	bh=24u3Q8SlwW22auf8+uO1jWPuLYUrdiTR5K6aSt/woBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kxYSpjMj1venarfMQ3hQSVSnaDa3lubEfbMGa3Gyoaek0yp00/puTq1jdGx62uFc1vWMdof5mns7cyUUE9JlxJN7hwrBYj4XY4nexhF7Ii36C2aNbkCShzpaeSNj5WNsFHvtOlsWIqrZDt7hLS4lBEszDcw04NJ+FjVShYc3VsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FWzYIoGS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=czGBkVpJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FWzYIoGS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="czGBkVpJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F4661D0010E;
	Tue,  1 Sep 2026 00:35:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 00:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788237309; x=1788323709; bh=uB3sedcgo4
	zj/EMgKpn6ctCgz9CCN9ANKjKCDzXtH2M=; b=FWzYIoGSKknE//cghFG7d/yZUV
	u8H/BvUxLH9y0o01klwakwq00G1cqAZmAHNga/HSQdZebtNNed/vU92YJ/wVL5Is
	9EvKPDFm4ZrprC50j+zD4dj19ZfBrcFevZeeI08LIPEfuK+4s7r5YrAu+fmAMwxx
	wjDIQzDt5+u4NWE0CAq0I0biDOPzjSawpCv2lLH4Hioz9knpEhltw72c1ZH1E5Mv
	qlllnV9NNWkpqaSMCWMAP5UuIKemsctvyg2tcrB/nTzgeij52zEzGUhlCUBo8DqY
	gm6iVsOeff+ouloOYfD36YtJaKJUkbAXF9dsy2p0EvOhqXDQYmt0x4s46kbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788237309; x=1788323709; bh=uB3sedcgo4zj/EMgKpn6ctCgz9CCN9ANKjK
	CDzXtH2M=; b=czGBkVpJ/ZZ6/Ya3F2/4kET5OxO9qpFvu+0Ja3nzdnSwbT2wznI
	KidEctkd0mdo3MTrmTN7nkHumNVtKglaJYJiECnwsh0NyCKRpHsyE007Tf6K2wK2
	QQzJtiNUD/fHW1rOkyZcokCqg33WVRbiMTT9Ry7toZOKv8lyWqvkaA9NK9PXiSFY
	8HMl/QCZnhfJbmeGNgAo3M4u5MrjDE0ljEGBbsLiYCB4iIY8/0z08DbP6JvBTHT3
	WY0UIWrfgJpwUiUHHDZAodEzuE08r+YrZnZSlx9Yi9TQv4oYRuTyo2x24qMEkIsC
	4hjRheZX+Hqy6NFCdG+y4mExlJQKonf82fQ==
X-ME-Sender: <xms:_VWWagwSnxHpXGchmxxtU-XkkpuHmAUDoJIcAbvtklmLBJEllTirGQ>
    <xme:_VWWamh7z3QXlU8TFXcS7hIkji4nxsxQq0Gxp7jj_c-X_1ql8JG8D3vBbHR2deC8U
    4X7a094RLkFmBs-xdCyIhvAQVbOrGe8R9Cb6SS1XvtDWlUvdhGCnU4>
X-ME-Received: <xmr:_VWWaknXWgQWHdLHsai6D_UtGCqzsAdID5R2T52MgWH5zyWg1SFkdRzgraUUFqKOgu3w8nQAQ1rvK9oKrAyiqbSAtUaYZ5bA8g>
X-ME-Proxy-Cause: dmFkZTG4PD6r8yuA9tqoe2Nf/l78p7OszAiS3YrYNK38YkxIdEOpGiN1L781ui5qAG5yyL
    MGOLTg/4geZsOTyjJFIEgjDRWE5o/1rbEUHOS169A173jgwZIAifYLa/0Z+/GkXtqa+XCI
    wB8yufOaIUF6fi5O74PRUKvb1atORe93kznyQwFwlTrBoRiLcTfoXrUISxSle66+494zXL
    YYv7XxRtlZbRkwEh/esC707dvO6F4smIoIlfnaBEtTHK/JIenqEBHQne+TzNRSwiAMIdxe
    BgP21bRUPWdMbvqW5hXMykfJ/RdzLep5U9yQG5JTCPy8D+t7D99EZ6PJUuNGDY12Bqkbql
    oYJSpRx/mN+JLoedjawzyUkQpJ2ZerK0a6mF1s+/4l5JzgQ5+tfSX/EgOMEEEvy3fEDt4Y
    Yakx/uI4d/Ct+w/cEori+ZDlpK7s17/owY5A+LQivVrkTxrZvu4Tt1j5wvadPBsyiwlKyw
    kznqoRIjDk8Rn4gnJvAtPcEHKr7gqmAt4YzOHezkg9qCg9KaPDnL5EWuUMclfooRQsk6/j
    VCqfVRn0LI8dUjNHQ3ukp5miLWJd7aJmswfm6zX+vrqH9PgM8RnxYLpqq9kBGDOV5hFcaf
    ND3mjNF2mafsYvgsCr4x8SQAmgU9UBdSdqnjFbPvFi0Znq4lPfXBQOsJbMOw
X-ME-Proxy: <xmx:_VWWakiuFMznyo1vPeAK_GyfmbQYybBslNhAcbkjSynOHevxE8iSFA>
    <xmx:_VWWag25d9sbQ6QhxddM2CmAaSr-FSw6Ksuyt4krbLOOyy5JhlEulw>
    <xmx:_VWWalLYhDLSMla6coNpb2m0uDS_GbqiHFqGvpQU_G_a_MWJgSJPMw>
    <xmx:_VWWaowiXNgrg7_mQPUdaVSYXTXNlogvkm_uumt_x3X9qnogyt71bw>
    <xmx:_VWWagNR6knXUNMQAx2CrtCTLqtfRah5PV6yIEjGoE3R0Sj1lDsWTtmz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 00:35:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Todd Zullinger
 <tmz@pobox.com>,  Olamide Caleb Bello <belkid98@gmail.com>,  Tian Yuchen
 <cat@malon.dev>
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
In-Reply-To: <0a611f614041b165140da7f2546c058178cdbfce.1788206466.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Mon, 31 Aug 2026 16:01:37 -0400")
References: <cover.1787231825.git.ben.knoble@gmail.com>
	<cover.1788206466.git.ben.knoble@gmail.com>
	<0a611f614041b165140da7f2546c058178cdbfce.1788206466.git.ben.knoble@gmail.com>
Date: Mon, 31 Aug 2026 21:35:07 -0700
Message-ID: <xmqq4ig9vbb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> +core.useNanosec::
> +	If true, use nanosecond precision for ctime and mtime
> +	comparisions between the index and the working tree (if Git

comparisions?

> +	was compiled to respect this option).
> +	This is unsafe on some platforms;
> +	see link:technical/racy-git.html[Racy Git]. False by default.
