Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE933BBC0
	for <git@vger.kernel.org>; Fri, 22 May 2026 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451142; cv=none; b=RLrR7uC97gmEEtmDyn8CRd8yGh5uGfZ8zTlpO00XCEOp89a2C5ZxC0d7lz6dUhnl3qjSoKXYVZx/EsG8LBCuBZJDjdYiOztCm3GPhCrhd0ajThHyACxojfop+z5XY7omkHK30mIHksAgARVN3ebLqlCrW2IZ6d/XVL5xABd1YsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451142; c=relaxed/simple;
	bh=0eSgfsHXFLUB/kE7rMKFkF/cjEDAXpRCRr3D4HkgMHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X9EKJGm9kaMIneeOfEQCPNgkCPtjlTEEsXiTY+JxUZV2PpOqWuE8AhmicpBR3/wo6TqrXoAVyYyWMS0pNXzGQUdljxUNMySaMj9qxeV0dyFnOWUtOFx28edYwCgBOcKp2InIZISFIvwhzkqr+U/y8nZbmzIzsd+Dy8M5fHelk/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OAwGDr2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UdSZRULf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OAwGDr2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UdSZRULf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 885F2EC00D2;
	Fri, 22 May 2026 07:58:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 22 May 2026 07:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779451139; x=1779537539; bh=QGgUN2Jwsk
	1OUEKkI1EY7ARGKenOTdoQZGy6yixa3eg=; b=OAwGDr2LKP7Lxq0qMxQlvEVBZV
	L1Nr912SRFpel9kuIRYNKjc+KCi16GYmrRgNuDmD7EOitX9UcHwZZgiRsupaJE9w
	QM4gpDaZS9AuYX+iNGIGYH/ecIVHM3RqBReO9z2TEiDJ2oJu1BJAdKX3eCt1e0sV
	i78xdMKP7AQMzbkF0euxeqCTZs+ywtIRUk/1nasUQL1tHewTFbv4SJSa0Zn6rrn3
	IeZhc5EPTJDqzacDXifny+prvSFLPeUNwqJ3Xtn8/HMsAISpx3ltOL9iYj7D41kY
	fa3hdCHKU77pnO3wyvlyS634rmhYAVlZ/82yuFlMTkXP/VilyCIYN1vlSA+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779451139; x=1779537539; bh=QGgUN2Jwsk1OUEKkI1EY7ARGKenOTdoQZGy
	6yixa3eg=; b=UdSZRULfY60IdmBQ4uUIKx8MKFLbNmpUwK/OxLGD3QBbUHEWRaU
	zAKoL0Z0taZmiLa+Hu7I2T4fPtMwsu0O3l87+YsePPBzaT+yi4gX2IC/mUMn6RsD
	tAPWndaWLuEPIWev8EHUn4ahkicmMTAwM/EGwDoFEtVE7gK6af+4Hj9q3pDFVgZN
	72LYVBDNMReuP0fHCecS4vbNU2wQgJEgMWLEHzsGGwkeXhy0p3zJd0S840xXSF1q
	m4f/dGmHfsXuNlFEvI3SmAoth0nWP5lrtfXzROh0Xhr2pG+AP/grzr2BuzVCssnF
	Jlgl/4n4WCDfcErLK5WVsjni74GjhFgF48g==
X-ME-Sender: <xms:A0UQak4qLKrXXamqDxQK_TeuG50c-5ZBbZDW7G2EjQDtS1_LomkilA>
    <xme:A0UQaoIbhsUPOBr5rtANFktjLHIl8uqLXH7UhMsBpCe3B3P8gi2TZNuv4zI-RrMII
    SZRz7CC5onHGFGQTfeQ1F4SMRrOz7EfvqSGDCKQ6BEkdnfpt3JGtg>
X-ME-Received: <xmr:A0UQalte7JnuZc_BnJBg8EC0nClsJ9oSfvAskUS89TN9o4oEmiO5231hCr0oZ3BhKQH3eH8au9Xu0bjwC_N4ik3Ec449GN6Yyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:A0UQavJc_VpUWaLJ3DMbnhx1ZqPxOiuDGKhznTWeRNl_D7ho8SlKIA>
    <xmx:A0UQam_TLjKJwO0AFz7TGJbds2VGj8bQQXC0VegtLq6rmovzl2vIsQ>
    <xmx:A0UQagwgh-5ecvauCzh2_GpSbycwTlria7O7JRTo77_szcoYClb1_g>
    <xmx:A0UQar7IPV1aP4WdbRVIGznq4g62iYqPgSIdy47gBCxNswfMPk2ULw>
    <xmx:A0UQam0zOG1KoCjRqFdBPxl1ppe5AC_nRUp-k9GnK97vMRsjAnkrrI7s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 07:58:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v10 2/4] branch: add --prune-merged <branch>
In-Reply-To: <CAHwyqnXVnFOeKRXQHHZMLbj_WL55A5gPxof=VFhZxDeXTT8kqw@mail.gmail.com>
	(Harald Nordgren's message of "Fri, 22 May 2026 09:59:26 +0200")
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<718e28c7e0120a826385189213cccec1f0fce1af.1779403204.git.gitgitgadget@gmail.com>
	<xmqq8q9cw40a.fsf@gitster.g> <xmqq1pf4w3x5.fsf@gitster.g>
	<CAHwyqnXVnFOeKRXQHHZMLbj_WL55A5gPxof=VFhZxDeXTT8kqw@mail.gmail.com>
Date: Fri, 22 May 2026 20:58:58 +0900
Message-ID: <xmqq4ijzu03h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Please discard this version.  I had unnecessary draft comments that
>> I used as reference in it.
>
> I'm taking this to mean starting over from v9 and implementing the
> 'origin/*' idea again from there. Correct?

No, what I meant was "please discard the review message I was
responding to".

