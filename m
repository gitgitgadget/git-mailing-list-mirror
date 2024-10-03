Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C732C8B
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986547; cv=none; b=b2c6S+ocNItFzZwqCa/kNnGpnhqh6fLKfoI3vQNJ65HJFIKpBZ2v+1cOwud4MLxe/VCMn3PrtAQ2xyKpiNMDH1p7lFvkkqyz+9WSp/KTREAMeuf/trUI7wK/493zfxAHoCmPSYgbvMgv74Qt3bK3DuDjKK0lOffqrl4SHdIto8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986547; c=relaxed/simple;
	bh=VI6Nq4dt5OEClDY2MLzFXc3SsqsUcOmfKOdI7d/kqKk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LdcOrP97b38o3yXshY9l0wvKVb5tClYEVUm7QcEc8HR7aueU9G28UykDhnB85lotv24ERHuo7iSDGxsoz4qYq6fGUP3ZcUIt8mi28QnJvVjNGPJ6CuHTiDzs63hR55lXxAH0V/yCnd9fqsc4bAmruliTuK6LAPaYC9pSi5tuH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qoD/0rAU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACIUg7vb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qoD/0rAU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACIUg7vb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 854F21140244;
	Thu,  3 Oct 2024 16:15:42 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 03 Oct 2024 16:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727986542;
	 x=1728072942; bh=22114kLBQreM2e7i+aAcGNE/2H7SMb9sxct6guYg15U=; b=
	qoD/0rAUGYELNNfr+WosrjxL2i0bw35YngpTVeOoCm6Q/8zDnUhaeuKqYm7EgYl7
	NnoizjwFIkxX7oBQhP/STYLT6csgHytZFXG/l/KH7X8ro2ssjeDOcgWQjtvxEIEa
	2azB7hfUJ00dgkLN2tyQU8WCb+7yi9X2K8w/ZW0zNoDXkbWoRXFLiX44kQfUzZvU
	Ze94pSgQX/QUbaWdye9nwceOp/bYd55V/bIr2WueZv55ZS4ePA7W2c+bIYM7V6r9
	AriBVlGClXtVGARKAYg9mIxGsOBLxfvFl8fcboLLLXhVX7jAGU1dl4uCAbonzghR
	BXwh44AztavWqoNai8/wOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727986542; x=
	1728072942; bh=22114kLBQreM2e7i+aAcGNE/2H7SMb9sxct6guYg15U=; b=A
	CIUg7vb5CNP335wGL6S5H7qPBc3Zv3EsEfduZk4UDSU847GBMougcZXCf86koNgl
	2is6Ts5Po0erQCoMWLbIGSrfnpHMW/lcnY4nP2PvwDXD9+EIRTbccQdyFJP7CJMw
	r3GzRVFngYi/ELmw7Jm46q9lnZnFzXc3lvYBoszsivR+5blTr66NahowwlVoK99d
	YeoCUmP2hj1YogbkwJb/ORIpy0zfF/O2dzJS3+rrmjZ/yrS+DSPRkuc6EzQhm0cG
	+QDeSdwqzIY2OXI3uvqd3+EzfzZxVbkmUwpgRAL1xp/SjI9Xi1MH2lzgU8GmNryA
	4jIF0jTMcjTWV80wiylMQ==
X-ME-Sender: <xms:bvv-ZovO39infE1Kd5zWVEocl6KR0iv6m_vxwwMRpDt_ImDbomiSmc8>
    <xme:bvv-Zlfv9aS4e7iRjbes5W_Ob88ubkSzCEygrWW6IdKi3SZXXe3KpXeCFvgOvpLuW
    66FsgR13zWx6pUUDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeghfffteetledu
    veehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprhgviigrgihmsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bvv-ZjxqUz_lFZ1i_bqisx6zOdU2NCqMXE5TLTah3HbebJTQUrw33A>
    <xmx:bvv-ZrOPKSSH0gIarA_nIUr-dZ9wFZd_fx6075JPCdOLLVtkBGfzBw>
    <xmx:bvv-Zo_FFKxLjugU-eeI38OQuTUyS2abbc6GprsiQpBJlAtGbhA4fg>
    <xmx:bvv-ZjU0EZEoh1D2mN0xW2PNDfhvPV6z9Xza-CYDuCI62NVvrjVH6g>
    <xmx:bvv-Zmm-0YZr7zATTypgbLMYvoIntU3sCNVNvBbUpOPdamwc3SCsUauz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4C8ED780069; Thu,  3 Oct 2024 16:15:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 03 Oct 2024 22:15:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: Alireza <rezaxm@gmail.com>, git@vger.kernel.org
Message-Id: <f2ae51a2-95e9-43d4-beba-774d05bfc3e9@app.fastmail.com>
In-Reply-To: 
 <CAD9n_qgBPDQKF=ZEQ6SWvDCmcUXZvz33zSoHFQSwHmQPWS4z_Q@mail.gmail.com>
References: 
 <CAD9n_qgBPDQKF=ZEQ6SWvDCmcUXZvz33zSoHFQSwHmQPWS4z_Q@mail.gmail.com>
Subject: Re: Request for adding a "one-shot" rebase strategy where conflicts are only
 resolved once
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 3, 2024, at 21:06, Alireza wrote:
> Sometimes a clean merge is possible but with a rebase, in-between
> commits may raise conflicts in which case a conflict must be resolved
> for each commit individually, which is not quite productive and at the
> end wouldn't add so much in how the resulting history looks like.
>
> With a "one-shot" rebase, a conflict (if any) is made based on the
> latest revision, then in-between commits approximated based on that
> resolution. This way the history can be roughly preserved with the
> same amount of effort while still using a rebase rather than merge.

How would this compare to using git-rerere(1)?

-- 
Kristoffer Haugsbakk
