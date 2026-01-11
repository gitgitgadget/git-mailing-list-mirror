Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48834D4E4
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768155886; cv=none; b=dbXxKG8lHCVmn2f44D/9krmv26xeamzMQxf6LeLoXixymq5E22yg9ap4PiaSHEDQxBcOJ6jr1FZyoGBeTroW+W50a1V8Qsyr8+fHgpSkLXKwrRlK8Ny8zaD1EHK5stCTHyN62AUIwO6bw5s7WwJsBaiXlvMjgJ+ZvrbPN74S4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768155886; c=relaxed/simple;
	bh=QF4tg04YEjDtRhVhUDIbiJjbunt+nAKyOfFv0Hq1spA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jD3GEirfuEtuUda7Py6+Qm525KC2voYTCjuAvobQNJ3+Nrd2R5SMGdc+KDU6lzFuYtMTlGrOXEPULuAIAVrP9fiod02YDeBpBTI34816+8QomZ5SZ3QF/mjY7TdsDE50CzF5o4KVwHBwrnPArsN/u6ePbM43iiuXnWe9NG2JAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lJsaNFTV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCNzmxC2; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lJsaNFTV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCNzmxC2"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05EB714000CF;
	Sun, 11 Jan 2026 13:24:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 11 Jan 2026 13:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768155884;
	 x=1768242284; bh=d888lwQaD/IAq2oxppeMmVj8vBgDZnP+y1y3iY/VwLU=; b=
	lJsaNFTVYdYcmOqvOQJcU+OpLWqUeLjomg8b4SOf39gdjfn/nrrIWpDOIDEyVSxf
	diXi9RtLhx9E8ik/BCoIFTQN3BC79Eb1N3QONKkdiQfPZDlsQgBGwdQuL9/RAeQH
	iEOjKdyKtTPHKOIfaj5mMp93vj8um1ADXDODDe/q2fSoBomekT/su0tlnsKaf0uE
	NYBpgWII+egbYBgcPIiISaOrhrnoiH4e6RgFCwK347SchhXmdVdedUSM9sHDbXq+
	IhMTCrDu7NtxvVmICNv/JSHZYA8+J4FVy3N39YEKHbz9mf198FZ1t6LEyJG64Ym9
	EwvD8fg4WWPjA/1iwubVtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768155884; x=
	1768242284; bh=d888lwQaD/IAq2oxppeMmVj8vBgDZnP+y1y3iY/VwLU=; b=f
	CNzmxC23ulqLsU+JKXfW9cbal8GYYRwBbU2InETetqoTMNEqxdxAe4FFT148w5bg
	3OfrD0Ml9/U5hA5x1z3fJzbP7PlxUpZxwt1BBmeFHC+QypYdqyrgVYf6NK3V1tCm
	Ua28jGo8x28ulg2jHygQcsq2/zCExnz+lqZf4kYSypGeJfoxIRuUM283jWodxHA4
	wVZk6huHxTU2us/iyqSCR553BEyqA7ccFR6XZQedfPFvA1FhFpt7ZYO5KG20uGnS
	fRBCVcYsep9Rt/W1KDb+MWRI+UEkMiqk3J9o50DYgdQlhz4tpwg2AH3mnmnOEqtA
	TwZUXwe0g5BHcKOQod6rw==
X-ME-Sender: <xms:6-pjaUTaojn0P0Dc4vDJjbnp4kLEDGu-yKzdGaO1qpsS6i7zeiJszQ>
    <xme:6-pjaYzHTmwbIQCKxCQQpW8tn0AqSeNFTs2ije3P36aGyO23xkA5xUcA_jRS6o-Li
    9AlVmQoRK8y33tc2TvWi6OK1cjGjF5W6wJ8KlYSoBz_05wo9P2YzA>
X-ME-Received: <xmr:6-pjaW3MzK_MAtwlnuXBDw5OXLGtmeUp8eGPQZ6JLz9ZNTzAoeC78kPwDNXVOn4fmRaGr__hXx6sl9SHmjbnkJ3ftGKf39Y4RO_qp7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgsohgv
    ghhiseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6-pjaW4Gea1uA9GUWHxzt6cY-JXlSekBKJ-2K6vNcXlBhk3G6oAG3A>
    <xmx:6-pjaZXG95Z782iIXycSlyx3Fb0KmFFxqOX8hsaXv3EuHf2jv51UNQ>
    <xmx:6-pjaVC523kD6B4Y37IPBos1QDIBjzRfhept3IB0mpxkSS38CEHe8g>
    <xmx:6-pjaY7atghgKw0S1PpJ_DAImmtTAnvysxxLrFeQtvUbJz5aDxsTGw>
    <xmx:7OpjaayNwiKoV3ui0F7bORcjfygpr1tqNQATZNT_SxEk_JILI8MGSkAW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 13:24:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  l.s.r@web.de
Subject: Re: [PATCH v1-1 0/2] workaround for iconv under macOS 14/15
In-Reply-To: <20260108174007.471678-1-tboegi@web.de> (tboegi@web.de's message
	of "Thu, 8 Jan 2026 18:40:07 +0100")
References: <20260108174007.471678-1-tboegi@web.de>
Date: Sun, 11 Jan 2026 10:24:42 -0800
Message-ID: <xmqqv7h8ovmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> Add a 'V1-1' of tb/macos-iconv-workarounds
> V1 had the wrong email address
> Especially:
>   Base it on master branch which has 'rs/macos-iconv-workaround'
>
> Torsten Bögershausen (2):
>   utf8.c: Prepare workaround for iconv under macOS 14/15
>   utf8.c: Enable workaround for iconv under macOS 14/15
>
>  Makefile         |  7 +++++++
>  config.mak.uname |  1 +
>  utf8.c           | 13 +++++++++++++
>  3 files changed, 21 insertions(+)

Thanks, will replace on top of 'master'.
