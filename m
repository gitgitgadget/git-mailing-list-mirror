Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD719F48D
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404005; cv=none; b=Ak6wTJ9BxUHhMGNKnoOX9U/ckjQUiQ+AE9rxhnyTXrdIPYHZJRt2b3CaDHd6zJT10KgfLKOmr0ZicgM8B2KV5VkuMB0FyWiNb1TrVZTlIrT00Bl3i7TokMfL8bpivDfDhG7N/Q7SuEN3pT/sQj92XldN5GI/pv2plfJ86MTSHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404005; c=relaxed/simple;
	bh=MmX+wpfLgNFhzyb+LRYP7G6ILmpJ0l0cmJeYdKb9Bak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rLVwfb0f2oH8W0+7jNzM/N+YCwJnw6jEchzMcuf28lEYqD78aCM3Zifjyxori4NXLs7YzKj+KKr4ebkvcb/IyHLTkmbdsQHH9DDVq9Wv/NA37aJi8OTleaqF8pWw2QdLK5khWyJ5AdCHA0t5kaqrH77EAddadgSTMfqVsie6gGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MsSg7AUN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdYyUql1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MsSg7AUN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdYyUql1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6DD57A00D2;
	Mon, 13 Oct 2025 21:06:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 13 Oct 2025 21:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760404002;
	 x=1760490402; bh=WWsFAfFqMiG0p8xI++xuWoOT1XG5R/2SCTBqhqHAo9M=; b=
	MsSg7AUNYp1W0djLAAXp6R3Bo3sLfm6gJINoorzlnvjBGqaCVW32mUWdcORYocCe
	vaEsjzfsJnPS2r0MXiopcW7ru04CY1+fIcFEz8VZEgmt0ZFWYanaQXatFoowcTWW
	FbrUh8fgWl/J3zTu7YuMy+iagTI4cEbZt51tjQDOI4SL4BC801QihOFLvZBbokeX
	Ja4D9sSU7Erb1f9iAkRhg1Bgv1wrFKkiMVnxurRy14gsh+hCUsyaL2tJix9qWCx7
	r1JyY2CKhY65t3x2nY8zTkZ5a/5dDG/7ms+ZSDMRDDhVaVX4slHtAQvGVbmRaYyL
	n8EJA8slhdq9ERNoq6Pdcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760404002; x=
	1760490402; bh=WWsFAfFqMiG0p8xI++xuWoOT1XG5R/2SCTBqhqHAo9M=; b=V
	dYyUql1ldv8pqGZVboHDlcH4Mq+mqwJi/1cwSKJrKFcWQpqra40cvPWuYmykYyPf
	NTwNHf+IrFNTw3lIm5Jqypl6iEOutH9CfL2ffO4kOK/0jSTTr/ShGByGMxu6v41V
	dyXg8h5Xt5r3SpPc6NjJYuri7tl555gAXVDEUAJ7mjQjVisbQ33MX9AEUxKlikYZ
	9gzQ9A95/dW73K8GdemwFSF+zT/P7XhSwqL/+fAu9F/yz0z7XYzR/TWLlNRAQd9L
	WV2fVtOa/vwViGqu+FxU9XLRhX/x2kS4p/01iZmuEeGOa6iqswa5OQ00/h55OFn0
	Pps7E3IcGCkhPMnydpWzw==
X-ME-Sender: <xms:IqLtaB-vmLliyQlMeynI0NsBcEB7DyXyFsyzTTsbvsdUSXFdCo_O9w>
    <xme:IqLtaNJhvjc091r_pu_k51FzHKOoGF3ypfL0PLyiIufahfh4y6dv1Bf3_oOlxuOpZ
    HucCFNzqhhgKoCEZN_vzYrW8uBzFSMkj-yrNIFTyRTBZ0m5wahltA>
X-ME-Received: <xmr:IqLtaMZaCEYLgV9WUYPVjsjOEpU3dMnRuJQSIPxHwjVBydJ3hebeaCbSBulZAr9X5SKcgYz9SAYtcS40Yl_P_ag_-XPyjqdeAtNZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IqLtaPINb54HLESCPaT2TX2QRpCiAhBF54SP91tICF-XCOtPXP--Ow>
    <xmx:IqLtaKDXSV3PU8JcdqChuUp8chahZk_UxLmqm-aokg1eVkskMZYCIA>
    <xmx:IqLtaEoQPKIP55hgubiSby3qBhrJc_WzqKty8DAdlpo69LAo00HM9A>
    <xmx:IqLtaFh1QKhSOEZ3Lu1-c94fZOzaxQwrygcS_XiaVnkYDar785cdFA>
    <xmx:IqLtaNQgOd6uqvciy9eoJM57c4sQjLEZXkl5BckVKnQnWwvsD6JZlrNT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 21:06:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: I still use git whatchanged
In-Reply-To: <ae47adc7-7393-4994-9aae-e661c0e36b66@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 14 Oct 2025 00:15:28 +0200")
References: <EBCAE8A8-E556-4DE9-9B76-EA4C27EECA01@gmail.com>
	<ae47adc7-7393-4994-9aae-e661c0e36b66@app.fastmail.com>
Date: Mon, 13 Oct 2025 18:06:40 -0700
Message-ID: <xmqqikgiz3z3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Oct 13, 2025, at 23:59, Samer Abdallah wrote:
>> I still use git whatchanged.
>
> You can replace it with `git log` in this way:
>
> • Given: `git whatchanged <opts>`
> • Replace with: `git log <opts> --no-merges --raw`
>
> Additionally for the sake of readability, you might have more
> use for `--stat` or `--name-only` rather than `--raw` if you are only
> reading the output (not feeding the output to another program).

Thanks for fielding these repeated questions.

Let's do a maintenance release Git 2.51.1 very soon with your 
kh/you-still-use-whatchanged-fix topic, together with other minor
documentation changes and probably a hdnful of ci related fixes.

We haven't had non-security maintenance releases for quite a while,
so I may need to remember and practice the procedure to cut one ;-)


