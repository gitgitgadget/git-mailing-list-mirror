Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3263806B3
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936371; cv=none; b=UWHrSkK8wPAIhqeQ+aH+d7cB62CiNIBwAinOVhsKRJ47V5XR6yb7NQesXUv49fbT5GlVKMOFd+UF9AkwcN5BejYsKx+EIvNsiCuaXRcsSCZd9JVQuiD9HUeWys2Z+7ie/xGmFNEoCnEySwd88Phf1zCtawHO0t3cgG0/fxCHe4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936371; c=relaxed/simple;
	bh=AOGc681n6XkX8F6p1/Dvcqmb3hkeBoggVi23l21R3ro=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GQPJJ6SUS/rEr/vUTu2NSNk+0IPM/mhSGkDhTB14gYHItWSuRI0zawtmxFhUQFZ6pIBKL22LrAofnXBXD31OCg7c0G5fh7mYJiYIGQ4o+s5e4e3pHIdtFs4CIcGUj3AVXT83ppddkPYaVDy1i5EFLqeaN/NpwYNrNOY6sbBxIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DjR8xvlK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kXGzjivB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DjR8xvlK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kXGzjivB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C427914001A7;
	Thu, 19 Mar 2026 12:06:08 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 12:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773936368;
	 x=1774022768; bh=AOGc681n6XkX8F6p1/Dvcqmb3hkeBoggVi23l21R3ro=; b=
	DjR8xvlKBZrK7ePA37KB08vo9ln0CzxA2r9z6XCvFoHZ6IylI7ndOYvoklK/l7bN
	Ez43KjWACfCNkciIsB5rBD4b7XR24fJR4K1LJmElHIXFdRMG5gvChvVPLL9smVKv
	OxKskRqRC9a1fON50zPbeEk1xYQWEfxLOVHqqa/20I86cDufUgxLXvDDrS2gt2Kt
	RygLwVrbems1gJD/3zE8dnktri4HjOKFBVCCWE1amsd77IIHpD77+w6N8VbtkSkw
	oCSpbKKTRp/Eqn6ZhfqDRPz2ZoXYltTr/IUmT3dCdvgLsnXMCc3pqjscPMRNwx1R
	f4/mdVYsnpjASL1dZEAEVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773936368; x=
	1774022768; bh=AOGc681n6XkX8F6p1/Dvcqmb3hkeBoggVi23l21R3ro=; b=k
	XGzjivBdPEopfbHn2BPFVQAL7WU+lD++b0rFV//sJiUKTyCdDm5yGDwre/UaxDEA
	ZjbLHbTc/8Ef/PKLXhbz0UKIAc16zVp7i8u85xx+zlgGjHTjiRvhXgKXWwdw2Qem
	SsRWRcsmhwwqkKTB2zpnAgo9BcIMwISAwsXmBtv0Twbq1sfhVc/d3iAvq1mo3Gjg
	AGvl/lDMXZNuTwSsAE7WfN6NDRLZo04le5WWTOB9f0gFOY7yKCaugWftxp0ayR6l
	WZh93pdyN/iexrAlER7XVo9SsIyA474WDBrahYowp0XtWKOubAInuDoF8sjR2aOK
	bX5widJAic3qFoF7HlWRQ==
X-ME-Sender: <xms:8B68abB-aNzjPVfK8RLDZ1rJRTWPH3YDp1fzCTzzpbFsnrY2BG7o88s>
    <xme:8B68acXkHgDgoynAKYEo4SLutGabbPobdC9R-rhbDWbSMD-nImuqr_4nQu3z_CQfi
    lZ8Wk9Vh2LsP_dRbQkiDuJOYKIPFrGom4b_VjR2ba4rvGHL-FIUC2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8B68aYcisb3rg5OLuf8ph-S7W5g6v6beEBD0h3V8hH2qvA9eu7uXmw>
    <xmx:8B68aR-Br7jyXpzH47_9o9-NR25UvV2SEMCBkf1C1nIM7CjjKmklbQ>
    <xmx:8B68aclPsaVyFvJ4R9hvw6xXxFcSRonyNw0c21Ft3rBT53jQ9hoHMA>
    <xmx:8B68ab8PC8BD2dLiYZ9lPZry24Na2V14ImZdIHIep-Jzfec4aIG02A>
    <xmx:8B68ae6gnms1pInOkF5O_TrfoeOAGUe_xDN1TsPHfl-H35y0C-w6PXxB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 90B511EA006B; Thu, 19 Mar 2026 12:06:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFfR1ZykUAFg
Date: Thu, 19 Mar 2026 17:05:37 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jim Cromie" <jim.cromie@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>
Message-Id: <14840d8a-a1cb-4499-ba78-295c778e90d1@app.fastmail.com>
In-Reply-To: <20260319155148.1145135-1-jim.cromie@gmail.com>
References: <20260319155148.1145135-1-jim.cromie@gmail.com>
Subject: Re: [PATCH 1/1] git-send-email.perl: support executable scripts for recipient
 options
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026, at 16:51, Jim Cromie wrote:
> Enhance git-send-email to recognize executable scripts passed to --to,
> --cc, or --bcc. When a recipient argument is an executable file, run it
> in a subshell and use its output as the recipient list.
>
> This allows users to automate recipient selection using scripts like
> get_maintainer.pl in the Linux kernel. The script is called with the
> corresponding flag (--to, --cc, or --bcc) and all remaining command-li=
ne
> arguments (typically the patches being sent).
>
> Modify execute_cmd() to support multiple arguments safely using
> quotemeta. Add test cases to verify the new functionality and ensure
> arguments are correctly passed to the scripts.
>
> Co-developed-by: Gemini CLI <gemini-cli@google.com>

These are for people who can be emailed.

But you=E2=80=99ve CCd them as well. Or was that git-send-email(1)=E2=80=
=99s action?

> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>[snip]

What=E2=80=99s the difference between this and `--cc-cmd` and similar? I
wouldn=E2=80=99t know, I don=E2=80=99t use these `--*cmd` options.
