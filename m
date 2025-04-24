Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C021FC0EA
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519316; cv=none; b=pXYG9uyUf7OQo0ZyeMw/dxNBwlkfIqb73HGBAb9DRarY2p2yJNT+jx2EtZHJHV7FH00mhxvnafs2VMrbQQoR+1znnisANoKCic2VFGRg8qZPfFL+NTLX5kOA2wbhmfBgmwsjaYsE8vrKms1jQP5Cit9/YxnD554D0xEKh98mGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519316; c=relaxed/simple;
	bh=OKvbjJrXu0uQgAp/9mQZCHx4zyk1oisFcjoLvkD5HJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AeJIPXGdGTLVmTrkWn10hbOfPPt9rdXRXh0Ryb/YjzVDaGna1Dk0eFvDzHHp5TSmmTiop2Jhu+pyrbaCqWVvqm3+yCdtSxeAS0dhCewur9UbhoyKxFGCXTMtFYsQIlM1t5VQ4CJt2VJ1eyh5YH6J38+prXXVJ3WntN0UJy1OMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=llyVaA5m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUOAv9PS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="llyVaA5m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUOAv9PS"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A10B41140109;
	Thu, 24 Apr 2025 14:28:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 24 Apr 2025 14:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745519312; x=1745605712; bh=MmrX3U+Jw9
	j5ZfhRZkQ5ei6BqUET45n50C/XGrpxoh4=; b=llyVaA5md0xNTFO47vc/rfw23J
	dGedVe5YmRGlLuvdP0ukU+aJhurfJgZH2V8qqw/BVpIPI+6Uv5fZXb22Zdw12CWY
	lpP+cCt0EVPGxNqKQq4gYWwJnqlEcuyVL9RNdtCm6G55PE9eye9QPCjaLRyVT7/7
	TI/YA+dD/5ELz7xXscm/uuyU4wIIYlZspeZPMORIcFBcS9Httiloj8EYpm/LMwM0
	AOwNkk0+RVZs1jfFbLbXEFHspn3NfcuDcV/H9efEqp19j6HBJ3g/mtGqa/vV5kNB
	45ArP/UiGM+lUrLmLGEoPmzMeX79J2wQUZETsbrY8CayPY+L0uH8i89EyyCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745519312; x=1745605712; bh=MmrX3U+Jw9j5ZfhRZkQ5ei6BqUET45n50C/
	XGrpxoh4=; b=DUOAv9PSDOgGP4uPhMIvtnc/muuslWn5PkQrDIT62X1mwEsiwLg
	WZl/TwK5a7Hii5EvksPwFLhKaouNvGRADH++um2jfajy9DiYPT1tl6VIs2F+1kZu
	y8Rkhvg22VvxZ7V/cKOdY9x99vNTcNAlNd6xwBH2kw01wJxPXQjCGm08IH/GwRyH
	cgFwOaCc+ao0z7jy6AIROW77ddMu5J6OWjsmk+YTq3iYfSSVyfbHp699mvtV4Iex
	7LbKsdnbimTatd/tuGF5aj4o0McSyWQ5hgL8kUkcOLyzXBOES7j+pQbVsX0fIrb5
	u9WqKiaJmXa+aJZigLixvGVf3DAsIa4gvXQ==
X-ME-Sender: <xms:0IIKaKItM37VZ2mmagC6TUeWx4LfeUPPhwInwAXA5EFDK2vY-2JEjg>
    <xme:0IIKaCIWGIwcHz4z9bqOy5KVbTtol3oqvK--AcCu0flvvRa1461lNtocrhqsj1vOr
    5UMVH9oNUNWa3IUFA>
X-ME-Received: <xmr:0IIKaKtQ3CSburbSlah0IAckYGm2pX-MNCaYxNDwOR5BLcvB23MSzdHIf0umiyMwqESoy0TlWp0PxTfIOZHm8acebmX1Vadr5msX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhsrdhrvghpohhrthesghhmgidrnhgvthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0IIKaPZmz45E16RIp4BA5NgFfRbMurGxKKwVOes5DxCP-g4DLsJzaQ>
    <xmx:0IIKaBaf259u8YSrtoLSp_iE9GZ37_HEWJqvyOysq8CvD8ldqMBsQQ>
    <xmx:0IIKaLAcn55VrFSD_WWF97zYZWYyFcyy3DE2c8d6Es5lHwIadehVAw>
    <xmx:0IIKaHboYgI11jKBbi9v8E_QEqagnCcDQdXe2h3ucNt_UVqHT320AQ>
    <xmx:0IIKaPuUpnSZxo5WNyZVJiGnQCTbnvQ29BHl27AuQDNh2aNkVIybdiAs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 14:28:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH 0/2] meson: prefer '/bin/sh' over PATH lookup
In-Reply-To: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
	(Patrick Steinhardt's message of "Thu, 24 Apr 2025 15:38:13 +0200")
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
Date: Thu, 24 Apr 2025 11:28:30 -0700
Message-ID: <xmqq7c39v2gh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> at GitLab, we recently got a couple of bug reports about Git not being
> able to find its shell anymore. The root cause is that with Meson we
> have started to look up the shell via PATH, which may exist on the build
> host, but not on the target host. We have worked around this issue with
> a cross file:
>
>     $ cat >cross.ini <<-EOF
>     [binaries]
>     sh = '/bin/sh'
>     EOF
>     $ meson setup build --cross-file=./cross.ini
>
> But this made me remember the report from Peter [1] that Debian also
> faced this issue. So I decided to address the issue in Meson directly by
> preferring `/bin/sh` over a PATH-based lookup.

Perhaps use the same SHELL_PATH environment Makefile based build
has used for ages?  That way, those who are dipping their toes and
possibly migrating to Meson based build eventually would know what
they want to twaek, no?
