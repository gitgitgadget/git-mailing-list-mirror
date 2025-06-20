Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750130E848
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750454050; cv=none; b=Sv4O68YswWvMxc0uCIwerS0UtusrmSisPdqEIBj/YLqrNF38Tpxv+DgG3u3bJD5eIOQRKjoXAATNlQBMHU/CI76m4MOnme6qtk+G2+02VBJs2JCN96toefftbJ4dOrQEmdvyxK/Rvx9NblQz0h9Ho43UDrExQjkmjLo0xLT2pZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750454050; c=relaxed/simple;
	bh=v4RQUhqMxGv9TRr3KFf74d01MlNgX9wIL1lBf3DlFYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SFtEaIP/dk8p0ChdFgfauW7i7s+PLOyIHqPw1DafICBkPWldesqiTvn8DdPTVHecktjE/nD/pA/m0zmy9p75XmNvt09ECXf8Bd0JRUgp8ayKsaS4ULISU7YHzRBuiCixH+Co+em1VhTuRErEPqtmsHMuildkL29wBQ+/qZqjrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=igBb/Cw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnAhFBg4; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="igBb/Cw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnAhFBg4"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C4452114017B;
	Fri, 20 Jun 2025 17:14:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 20 Jun 2025 17:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750454047; x=1750540447; bh=r1ZFJx9ERU
	dEC8YBa55m/OaGn+y3tdIESmeh8qB3Y68=; b=igBb/Cw8TCSl0CTHxNXziix1ux
	UvN5fPCO3kqY0Loxe8vb6qEH/7IoXSDoE8SJg00tOyr6UwqyMjoD3YIHvVAhFxqd
	twIr0i4EkFxkAqms7L7Iz2UpFq7Upuv9BToOWtf4LALKQbDFdUfP85LvCwMfVyDf
	0qe9TbVMIWyb6N8jTyafVtJtmHvINhKTmjeply/hX3f9elAFARTmx3+7mPJXEEKs
	gICuby4lTURQC7TUzXlpb76sc1rHQUkFXPdDRchIPLndP4pjri58w4hYJNTdE/9P
	kZqb61jzU4F1B0MHaXw+JCIQEuz4uGdYAFvaWN4Jakf9A83WNyqk5IA8oEtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750454047; x=1750540447; bh=r1ZFJx9ERUdEC8YBa55m/OaGn+y3tdIESme
	h8qB3Y68=; b=OnAhFBg4/KCN4vxmFchYBWyX/8Frn7ihBdCb21wgYwvIXMC01uP
	J4XiNjlp87/umW8DTw/oWrZz7BMICk2PyWIYBSo7adZ4Br2Lb1nC+76Uv1z8JSz1
	TmBP6z15QFQCKuvS9ZOlM0PFEU0f3e9BrBxTW4pYLQG7V33zEEVb91bmRgr8T8bM
	PslnfjNLN+rCmF1VwTTtahi/AmiMO/3/cQJzX96nRV2xwiWLUZcZLe3XuopCcjeD
	uor6YGmkTLcpy1IwZ/p5mhzvfYrfTTnKnnq+F53Nkc0wcVcoDliL3YGR89b8selm
	rX3aZNhyr+Jkwjkm7uKMyE6Cq5hmJPHzfnQ==
X-ME-Sender: <xms:H89VaColz38Y3xcX01JCwsofYwZuNOA-4P2FgJ-GbkQd9WU199SABg>
    <xme:H89VaAqrRH2q8uFGhA1ChM9lbLz_DWsUOK3fmCRbL5sqn5EYukeiUNddPecgZTRCr
    JdGRi2sKAXJLWslgA>
X-ME-Received: <xmr:H89VaHMngFgN2z1t5LYrjjZYUCXizCJJFB0O4CTrTj20v6D1zUzETCHOyivX5uKqTvyahQnn0CGcuBopT7nO3jsX7Rakh9CyPzE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdelgeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:H89VaB6K6S6RRz-8aGXnGJ3BJx4FEbecyC5SmRRPa82pXxds9kcLkw>
    <xmx:H89VaB6Hcl9j0fIA-i60_d9UGegfLyaKA2S4QzP71BxrnzRocNPcoQ>
    <xmx:H89VaBgYt52bt7a56wk_x_aW-11nVbZtqffx7OhUNBQ5j3F6TFwNCg>
    <xmx:H89VaL5jWB_6fgjx1IwLChENLKtmR59EocCzxji15LF-23UZGMmG7g>
    <xmx:H89VaNF6LUdejbkvUpucObWKeY5cB2xpVDbsfOU3ATpmMdxAj6t1PV7U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 17:14:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/10] Use original hash for legacy formats
In-Reply-To: <aFXJunWKq28BeX-a@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 20 Jun 2025 20:51:06 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250620011943.586596-5-sandals@crustytoothpaste.net>
	<xmqqcyay7ale.fsf@gitster.g>
	<aFXJunWKq28BeX-a@fruit.crustytoothpaste.net>
Date: Fri, 20 Jun 2025 14:14:05 -0700
Message-ID: <xmqqmsa215gi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-06-20 at 14:26:37, Junio C Hamano wrote:
>> If we call use a name with SHA-1 in it (e.g., GIT_HASH_MUST_BE_SHA1)
>> from the beginning, perhaps we do not have to rename _ORIGINAL later?
>
> We could call it GIT_HASH_LEGACY_SHA1 if you prefer that.  I originally
> considered something like GIT_HASH_GOOD_OLD_REV (GOOD_OLD_REV comes from
> ext2's much more rigid and less extendable v0 rather than its newer v1
> format), but I felt like that would be too esoteric and not document
> things well enough.
>
> I'm also open to other ideas for naming if someone has them.  After all,
> naming things is one of the hard problems in computer science.

Yup, legacy-sha1 is good enough.  I just did not want a name that
does not have sha1 in it.

Thanks.
