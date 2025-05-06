Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D44B1E7D
	for <git@vger.kernel.org>; Tue,  6 May 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571809; cv=none; b=P/u6//85tTRpmNBbEKYHKsLZ1JXLdsmdbZhsSOtZReBm8MIIIUWQSXq61hx3WvYHaSCx2TnctzmP/Zvd/wu2HEsdv4uCDKb11U3+Df8D/wuyspRER3kRtHg7HucmpRjlwemkIX6F9nhSLDBEhZpMDnUTU9WOevXMjw+W6Zing30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571809; c=relaxed/simple;
	bh=/mkH4Gyous9ydfl5CFkS5+VzAouRC2OmB8lYms/Wc3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JdP5K/A6CgtJPzYluSdOFm7WcJJKhunTc+iSdimPRG+C/S1dcKqp95X62CQN3yFBbxMQI20z/EkHhRMe2XdcWFiJDoB9Iku5TD7DCk9PZIxImEYfwhPso7qAGZ5ZROGt6jxLFLJ2STU0jUq1y1PUxTsHBzz5irBN/mL23L+epXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gN2bVUpw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ecMLy6Y7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gN2bVUpw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ecMLy6Y7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9D4725401A4;
	Tue,  6 May 2025 18:50:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 18:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746571804;
	 x=1746658204; bh=65eE6tjV11Ap9sIBsBExGLfvyARgmfcwQulzdKBSJug=; b=
	gN2bVUpwmHyBmcJLGNcluJ+wRKYw98bxOvWlUWGyE3Kl1ksDIuhHdCVHTyTHMFz5
	QpmrVy9S107nCO1vR1LrZ9Ax00VD/8uTKAoS7h0POyR6ABc9NB3ej8qTKsdylLL8
	gixQAVxUeyDRlgH3hvAQgmFvGnoErvFhbCPVYwxPlEjiSXf3hT7QlFVatZVMT5Ds
	9SRxe/9s2zbLCWBr8w9mnkV+EIAUZyHQM0jpv3wyklfyakQ2QVJI6snAzOOGv/Tl
	vc6hbOT12k+3V0QezIqK99wnjYqsemDFDN+wAU6U7N7QZEN4DGPPVcaFExy7WXEz
	k33E5ZHrrDWOH+m0PoSC1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746571804; x=
	1746658204; bh=65eE6tjV11Ap9sIBsBExGLfvyARgmfcwQulzdKBSJug=; b=e
	cMLy6Y7W7Eky80Q60kXyt7ZuHZVd9/4LOBnlssXDyLuMzPFFqLXYCgLmxRQQBqsT
	7JJWOdatCFvf9BHvBz33qRvVrvcMdeS0eUBHCs1wC4cKlTkkMVSf/rdZc0s/fk5n
	1TSaP7ZJbPc5XV8EP/ENhASSe/jprAeThQp4r81EPHp8HJezoDd4oblu/UXJiqWW
	4vtT+EbGbrsntdogYt3gLP9G9jXqFgQ8aJRnvbtCL5cDrVlC7sGxtxprcSA93HJJ
	kQCd/lfCCw1hEj9uK6yCycy5hb38u5WovQhYz1jUmvVZk52ufvOcWZ0s14JAM19b
	QFm5L6Q74Lu98mBaf185A==
X-ME-Sender: <xms:G5IaaDULBSOQfsGcGj1Lwb4wziA6v8QvRijZRq8mSz9toFuon-1e1Q>
    <xme:G5IaaLl_CQRKCDjkBBXVbqwyG6qNVXATjvLJW0towrxOg2W1atvLq1nEcdTEpGYKm
    --yXiSWsXW5Hc2C-g>
X-ME-Received: <xmr:G5IaaPbvt2SDDKFcKUPO5LeQ6S1n1TOTA9n53kyvM_RptQC47wkz9xV_dlnhyoQ9-lnTBI4IYV9rGsPjlHQbZYU2PRMUUNAKvDmZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhdrghhlohgunhih
    segtrghmphhushdrlhhmuhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G5IaaOWbk_N0lgv1CchIPciPzSe57IuGPqDSFu5J_Gt9k3v-LPWpPA>
    <xmx:G5IaaNniSN3epu-oPiFtmCdpNrT449W2gx1TGAaFbyHOr3w3SjwmLw>
    <xmx:G5IaaLcoyoI_qIYd6aEfdu_zdWFEwnmk3o1kuMc5Ohu83q3gl9XReA>
    <xmx:G5IaaHFR-f36u4feyBjzyCdgXZwGqQ1eFl5a_aFJz-NiVbgsXBCmkQ>
    <xmx:HJIaaEzKWlBJewdrLCmDe2OvZi_Fb90vV6nG2FiAfE_mayIuv17EdKkI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 18:50:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Niels Glodny <n.glodny@campus.lmu.de>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk,  johannes.schindelin@gmx.de,  peff@peff.net
Subject: Re: [PATCH v3] xdiff: disable cleanup_records heuristic with --minimal
In-Reply-To: <f2b34e81-fb86-4a30-9aa7-67e6f5758168@gmail.com> (Phillip Wood's
	message of "Tue, 6 May 2025 14:21:01 +0100")
References: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
	<20250429140949.2634935-1-n.glodny@campus.lmu.de>
	<f2b34e81-fb86-4a30-9aa7-67e6f5758168@gmail.com>
Date: Tue, 06 May 2025 15:50:02 -0700
Message-ID: <xmqq4ixxfj6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Niels
>
> On 29/04/2025 15:09, Niels Glodny wrote:
>> The cleanup_records function marks some lines as changed before running
>> the actual diff algorithm. For most lines, this is a good performance
>> optimization, but it also marks lines that are surrounded by many
>> changed lines as changed as well. This can cause redundant changes and
>> longer-than-necessary diffs.
>> Whether this results in better-looking diffs is subjective. However,
>> the
>> --minimal flag explicitly requests the shortest possible diff.
>> The change results in shorter diffs in about 1.3% of all diffs in
>> Git's
>> history. Performance wise, I have measured the impact on
>> "git log -p -3000 --minimal > /dev/null". With this change, I get
>>    Time (mean ± σ): 2.363 s ±  0.023 s (25 runs)
>> and without this patch I measured
>>    Time (mean ± σ): 2.362 s ±  0.035 s (25 runs).
>> As the difference is well within the margin of error, this does not seem
>> to have an impact on performance.
>
> Thanks for adding the performance information, this version looks good
> to me.
>
> Best Wishes
>
> Phillip

Yup, thanks, both of you.
