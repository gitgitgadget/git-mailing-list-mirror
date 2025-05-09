Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5323CEF8
	for <git@vger.kernel.org>; Fri,  9 May 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815050; cv=none; b=Tc5virF8dBbBpfcYc/KYgOE81m90RqBWSPsgg9QdACwbk0oiI5RBtCmtSuxgT0e1Z92duPynKeDswA87FQN9lXgnDsktZEp411YbaemVzNmOPClkwbMG1FAYRMlS3M54Dv5Y2662y3o7waX56xo3psAXKJhDECiA4chQZwd2/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815050; c=relaxed/simple;
	bh=rsrJmut91GEJsLZBARrPG75DzshXozQk0WtqWZtjYp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B5LGBhOZza+D5t0dBQdyKcNuqMQr3wihBketgHpCqAJiA173Do+85vTwxFll6lw+RnQIOi22nDZXpNNKnRSeuZcOFYY1bqsrt+mK00sLxgIVB+iptg1f44V0tdzXAUpQS7X05EqtodhQdbhkqsj9J/mOgWWcCFW9euOMN161HUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=epldUk8H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fvUdJAx9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="epldUk8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fvUdJAx9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AC84613801AB;
	Fri,  9 May 2025 14:24:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 09 May 2025 14:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746815046;
	 x=1746901446; bh=NztiIZRBCO6jU+Tbshv+ON0jadlL6ZgPGpZtWVXhCfQ=; b=
	epldUk8HPLyiSYZuaFiV+u3ZVttILbCMDRilwaBmhkurHnpf+otZZEK6Gx3rxD04
	acH9bfJ70HwWN11HO2hc2J24tknc6geHgFuaZvDDL7kCJAPgZ12j2jMPD5Mm3IRV
	3PamKyDhn1X8QW0pq6588GhVu3iw8ar7ETVfbeYEnHfa2dZ7SzAar3oAp5OUvPF9
	X7aQyQ9tOSrU1qvcvFXKummsxMYaEUt5yQsreJR/yiEW5Yf1ioHCvH6wl+d4sprD
	qjOVbtced1vZ1QC6mmIXk+Ed79pmDh4P5Kfd17gbNADNyrtTRUThzp+lcrqdeYNb
	TgZgG1pHqnP65zO31Dib4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746815046; x=
	1746901446; bh=NztiIZRBCO6jU+Tbshv+ON0jadlL6ZgPGpZtWVXhCfQ=; b=f
	vUdJAx9579ZEacVgTKM/tyHjqIbVjf7qNUMipyhKXd1FLgI7iuQUAEtQJsNPnTwN
	6Lyh756fJ8wyeJ9hdRDXmwPWFqeEAr7BFhwvjSZ6Ud/VG1f6/qj/jYAotPrZYBnA
	cIrbNOu9iC/3rosZhn2CS6MHgsrvmsfxIBDRM5vOpt1NWz38m+p16xioAzqLmUeS
	W08H9/mMM0jCsfDc7evvUt1iJT5cnx5kwd6MqqFqBrUYK8BqOs+9T9glC0wChKOp
	HVFJqaDe6VR6Thm0s2rBzQplqqGFNPATAfGZkbXtTqrkIfR3++XBmQMOv/Sy3ffi
	G6y+eoua+1aW0WuULeyQw==
X-ME-Sender: <xms:RkgeaHIObdNL0zFPbC_-QNg9xwgj-Mc7YxB_D3kOxJ3sHKoXiWRhjw>
    <xme:RkgeaLKud3XFGPCMsYWpaKsurporw21A1i9F-G3Wr8kpJmR0bs465ZCFAmjIzCu6r
    NQyhhluUUy0H2SoFw>
X-ME-Received: <xmr:RkgeaPulYepNYo2QaKzuC75qCG6VdJJ492GipnnMBvp8Vla7V5-jA4Q4029nuYIb627CHGthKbWOIVJ966jn4_O2hFkxQsseNKOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RkgeaAaa-nht8qm4Z3Mi1Sz7WKCd3W1o3GakENBftdyi2mgwVBdkkg>
    <xmx:RkgeaOa84BYoap3vsmJukkQsGza9yQ982Wt_tMoBT_VPMty6bxh9_A>
    <xmx:RkgeaECuVcAWTehoz47rl1Kdcej_ss-eKIucfZXTg9cawKGlSnAz-A>
    <xmx:RkgeaMZCpnSJRVA-5bPKkAdp_4-x6nutSmHmuG8045NxWZ2HDrjCzQ>
    <xmx:RkgeaJcuy30xEf4vtGKeBygA591mqCadMADKg3_Aa7O5OYueff8iC7cE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 14:24:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Additional changes
In-Reply-To: <13790247.uLZWGnKmhe@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Fri, 09 May 2025 19:08:37 +0200")
References: <20250503011537.3035416-1-gitster@pobox.com>
	<5040970.31r3eYUQgx@cayenne> <xmqqr00x3l8h.fsf@gitster.g>
	<13790247.uLZWGnKmhe@cayenne>
Date: Fri, 09 May 2025 11:24:04 -0700
Message-ID: <xmqqmsbl1w3f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> On Friday, 9 May 2025 16:35:42 CEST Junio C Hamano wrote:
>> Surely.  Are there particular things that you were either unsure
>> about (which may lead to possible partial retraction) or want to
>> stress on (which would help other developers and reviewers recall
>> what they need to watch out for when touching the documentation)?
>> 
>
> Now that you're asking, the heavy additional changes to git-var's manpage are 
> mainly targeted at clearing out some misuses of $ENV_VAR vs ENV_VAR as I see 
> them. Others can disagree. 
>
> Maybe these changes should go into a separated patch because they do not 
> really fit with the "new style" changes.

OK, then I'll revert the changes from these three patches I squashed
your additional changes in, so that we can have a separate series to
clean up "$ENV_VAR vs ENV_VAR" (Documentation/CodingGuidelines tells
us when to use and not to use "$", which is quite useful), perhaps?

Thanks.
