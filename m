Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550D14286
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601408; cv=none; b=erKKimMNS97M53YMqAX5l1co7zAG91AlK/NaHVdjAj0C5XG4PB8uABf5S1DZ5Bon9M45rBuMKSXVmCZMDtNpptkEsgP1iyw3EY4qxyOpt0Dmzx4cK+WFqYWeiezQYLZ298fYFyylUaPeXEqJ87JD8fu83ZefKhpTcS1RvV7hFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601408; c=relaxed/simple;
	bh=JBhk0OBQbn9ZXJyKVP8OsP0OCExjKUt8q0EbYd5rK4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pgbf6Fak20UoZGsRBj5u3jOmSqK4qboZUZYp54K3YOpWdVR6FALzGnQ4uUsViYIwnz4w3yJPdEWUUhAPGr04ku+vPMzgjWNJSoBORNN1O5pqXQwJiQWY3lMN7dgbbUVS0JJNllQjFDMppvctpCnE92c4to32JZ+ltnYsUN9aJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Aq2UuBsU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ROun+awS; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Aq2UuBsU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ROun+awS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D24347A0077;
	Tue, 15 Jul 2025 13:43:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Jul 2025 13:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752601404;
	 x=1752687804; bh=s/0mBA2Yxs+wlpSmHSsKJa8EBSQJrj/SP4uysw7Be0s=; b=
	Aq2UuBsUmvAtudaQQLSJ0dt/XRf+K0kM0S6bHSMpHoBB2c1uGbgutO4mASp6cHbn
	MQDdJ5Jf2d+gPq9HEkhL8nMGhAIEGU/9J1ZiRx7Ol5e2cL7uRnqeuZkaWPRRNWt3
	VG7mbN3Cb1EAmlQGDeSEJAkFV/oJ0mgmEiZ2Pzeom4vgdocDDN+kYPy1U7u2rE3c
	cHGUnbxfPRfiQKhklopKGiS0Da+24n+DqWOJIEZaD+5CnSk/ARqoudmbsnD261su
	/Tzns0GS+PJzzS3x+a/7AHhO8eJFVkrOWR53efF6j0QPBnhzSFByokoGJUsOWQZa
	SXeSPbcY2yxanZGwRLEj3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752601404; x=
	1752687804; bh=s/0mBA2Yxs+wlpSmHSsKJa8EBSQJrj/SP4uysw7Be0s=; b=R
	Oun+awSxJCqHGHoJLZsWqC7yq9Ys8iN0F44gQ3WsT0nlYrO4ROIG8HyZrKwCzcPW
	BLlR9mA98xkGifevOdmiGM/I2fDcumWTklcXGxtIvStV2lMKH1c+BgIl5eOwHQbq
	4QEMV7CbOguTBWvzS9Dlq4RgrbBq5X3KxozntSvX7Vm1B5DfpVtcodqp9/A7nNIw
	1YFlFFTSKXuwKo+mzB7zHSOJLhvA35MBcbuDpS02+NYvErS4w+NPG17SutCo7ixI
	t1YsUojFa3+L61X8FOHxmN90vRIiwuPFYJflnYAH4k8xxzuMNT6UI+Ia5/kFEo3l
	8/bLWaS4llwrdAnoJrLWQ==
X-ME-Sender: <xms:PJN2aG8gXF47XIT1Cld7Z2KWfzAaQyEA_qzU5vmlthv4QZSj8Hw6nQ>
    <xme:PJN2aJ-RL0_XV5ksbb7pCyZyKWNhcj7ZIDAxQXSSpk3wF-arnACFqnG3MCWVuay0e
    ydHboxdk6LKlVsBLw>
X-ME-Received: <xmr:PJN2aFdedH0-ao3PMkZ-tIZ153s7sNSmFnW6xCIJkSJ38afR-b9VgxUknCzY30vUE10IQbOWw0U8EBNknepNHIC5ygvVuezk-963h0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PJN2aKHQ48uHgaiV1qXUC2pMTlj4sot9JW9IZLwPuxaFUQhaEqvSTg>
    <xmx:PJN2aLf7bXpgxV1E5Nj0Cq-svopXVy18wkVyCmps4_-jTMFIAwtd6A>
    <xmx:PJN2aMGggR2HfkANLJM5Cy3Yib28gYvn-xJY-PDMbb5jUIbqDW2eew>
    <xmx:PJN2aMWYuflp2gh3YP-3KqMBn36wtv2o6IdzlHcVoZ0DHFplmVMEeA>
    <xmx:PJN2aOmib-36OCjHN6rRriFwy_fbikxUcgXLWLjtzZnTPafQLM0bMP-P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 13:43:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #04; Mon, 14)
In-Reply-To: <hm5m7i3vyzimr7afq47uitxl2la2obgetg6arks2mvgafekjfw@ppfqnb5ercsn>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 15 Jul
 2025 06:16:09
	-0700")
References: <xmqqa556sddb.fsf@gitster.g>
	<hm5m7i3vyzimr7afq47uitxl2la2obgetg6arks2mvgafekjfw@ppfqnb5ercsn>
Date: Tue, 15 Jul 2025 10:43:22 -0700
Message-ID: <xmqq5xftic3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> On Mon, Jul 14, 2025 at 01:53:36PM -0800, Junio C Hamano wrote:
>> 
>> * bs/config-mak-freebsd (2025-07-02) 2 commits
>>   (merged to 'next' on 2025-07-07 at d6761aa225)
>>  + build: retire NO_UINTMAX_T
>>  + config.mak.uname: set NO_MEMMEM only for functional version
>> 
>>  Drop FreeBSD 4 support and assume we are at least at FreeBSD 6 with
>>  memmem() supported.
>>  
>>  source: <20250702093736.36074-1-carenas@gmail.com>
>
> Apologies for not mentioning earlier, but the minimum version of
> FreeBSD supported with memmem() by this patch is 12, not 6.

Thanks, I realized the same and updated the draft release notes with
that ;-)

>> * cb/meson-avoid-broken-macos-pcre2 (2025-07-13) 1 commit
>>  - meson: disable PCRE2 dependency by default in macOS
>> 
>>  Build fix for macOS.
>> 
>>  Will merge to 'next'.
>>  source: <20250713174807.32444-1-carenas@gmail.com>
>
> Better hold, as there is a better option posted with a v4 in
> 20250715114407.37955-1-carenas@gmail.com but more importantly
> the discussion is still open and might require further changes.

Again, thanks.  I saw the exchange and your latest round with Eli's
input is what I'll be queuing for today's integration cycle, without
merging it down to 'next' just yet.

