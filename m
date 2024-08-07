Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235A41C9DF2
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019500; cv=none; b=TKs7crfcg+wfBZc9llLMIk7hNInPEVj6PyVe5WivPg042Jym9YPHAPBzKzBPTV91xJdswWnUC2N02MZL9rlzpiCjTEYtwbc+ilqhC1du/rh28fDPzZsIi+UMaUTuCOMSZF5tTlYjrwSREUhDyYUKPdp1FZgI36kulBujn2HbxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019500; c=relaxed/simple;
	bh=0x/GjSLIWquBBXTih18dvcUoaIqLkhZAoVusiho07yU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=XAVJA76iYOXFEIG2bn9jJvmdj5w6IkVceD+c815JxbP+/+w0SNjSQ+1cN7J0Ehu34sH+ppJZvchsRkLeVchQtUxUtY7Zhw+v0rvG8PaY+2PRikRLOBb9nZuRrhvw3jHzM3jF3P2NAV9uMXJ75I9NMVCgL1Aup1nx7PfazU1FtNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=qnkQeHrv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5tlIXTq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="qnkQeHrv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5tlIXTq"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 00836138FCB5;
	Wed,  7 Aug 2024 04:31:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 04:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723019496;
	 x=1723105896; bh=0x/GjSLIWquBBXTih18dvcUoaIqLkhZAoVusiho07yU=; b=
	qnkQeHrvn9RIwGwMh4b+BdtvJs6wKlfOMG1qZ0QKMMfOKr6rfF0O9CYk8iBuwWzr
	xCSIDgo5hRIL5wC4KD1umh+aHrHTUQLlGOOom2yaJh9SntkyFq2+1lt92xnQBwiq
	/o7414MCnGNnOSgS0y9A1ujg0uWPg3khHzHEozX0x3JdkBaHhVgKt/SXFy86l9HV
	O0bzaoNAnGMpTW/kPpymDZGzofxOqfropVjmhvxfkr7C5Q0AkOhCH/wwRl4s7qU0
	his/GWrt9fDQGwSKe3lZTDmw/OiZc0KXEiJEwhFdiIi8hXemIAmhdfaEfs0q2cnU
	UY9osHQFxZcx45DttQij2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723019496; x=
	1723105896; bh=0x/GjSLIWquBBXTih18dvcUoaIqLkhZAoVusiho07yU=; b=G
	5tlIXTqc99XjFGrFW2dwy05YAbLaRtDV5BobKgbm2CidL6uQ73DUMuqcJisR4GBN
	RfM9ivav9bKS3AiXz6rx4YZkmGWR7yJA/IDVC9LPEXfJrOdHTaFFb8QZpyOT3HUC
	+WA052x5aWYYpQYdY5OwdWFSMjA1SvbswhM63044jGMaEByRMsxnmeBtDVhtun5M
	pV9oEK6bFCx+3lHXQUFwKaxbfUciwgCXqYsJ74z/ojp2KY1rV9btpMcpnMr6A1Ss
	8rur3VrBt5XakQ1ynK6J8iKpJM1O+PteMYBwp2OPZqXWCb8fBW+hUtza8TQc740b
	3HTcU5HLYY8o0x4GAlg9g==
X-ME-Sender: <xms:6DCzZl4k9UhNm2Fi45Lkha3Xzns5GgF5pY1N03GEAUQ37vGdMlvOGA>
    <xme:6DCzZi4Mq6GJpTV8Yi0gl8RBjCZUCTgZGWGPGMux6k-WFJVryMiD3OPBG2G8aAz6q
    3yAs40LMmx8jC0wZA>
X-ME-Received: <xmr:6DCzZsfbjZhVKQPnR5Mk_0wQHGt_R0NnBZbcyrOx87s7eJQ6dvXrQnPxhcOL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhephfetueehudeltedtjeekudelueeihfevheeugfehhedvieektedtvdevgeeileet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:6DCzZuLJMtrTB71mRq9TDBHBwWNA8LIpi8HPNPS2YFUaPIuPqOH2cA>
    <xmx:6DCzZpLFnN215_w5p72O7Jxh66fFuK59V72J2SEEoNvMmTPd6ABjDg>
    <xmx:6DCzZnznv3SM-d_495pz8M4YyLk5_IbWqLbmSgIsbMwqAyOocyAwZw>
    <xmx:6DCzZlKJnICOZao5EsfrNydQqxa1BGES-ipgVsqMTETpkJV6ixsQIA>
    <xmx:6DCzZgUz0Oiu0-1gAkcgPr4hu1eqCeUyVVWdzUOn0ysnaFhXYp6U3Mow>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 04:31:35 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 18:31:33 +1000
Message-Id: <D39JFO40F1FC.2Q22EY440N67N@jamesliu.io>
Subject: Re: [PATCH 13/22] builtin/fast-export: plug leaking tag names
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1722933642.git.ps@pks.im>
 <64366155dee25209ab9c434016c5918d47d7e1d5.1722933642.git.ps@pks.im>
In-Reply-To: <64366155dee25209ab9c434016c5918d47d7e1d5.1722933642.git.ps@pks.im>

On Tue Aug 6, 2024 at 7:00 PM AEST, Patrick Steinhardt wrote:
> Refactor the code to make the lists we put those names into duplicate
> the memory. This allows us to properly free the string as required and
> thus plugs the memory leak.
>
> While this requires us to allocate more data overall, it shouldn't be
> all that bad given that the number of allocations corresponds with the
> number of command line parameters, which typically aren't all that many.

Ahh so using the `STRING_LIST_INIT_DUP` initialiser means that every
time we call `string_list_append()` on the list, we retain ownership of
the string and the list gets its own copy.

That means we're able to free our own copy later on.

