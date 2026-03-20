Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211431AF14
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773970569; cv=none; b=HUCOfG/QfKbi8dI7q+K822K6577xDNzlXO0ScTwMTrC9Gr6FCypN/84/k0xQYVVAAWyj6BeZj6EJngAgYXPbvD1+lTJ1MJJp2tKNlILGxlM7M/DkzMcM14AUCe5tYFfwVWs47adbYCCpPMxekO9F1xOPc8uvV12ZbO5QcK1oe5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773970569; c=relaxed/simple;
	bh=8GCGJk2d37SOfI2oNbMRlaBZU5GuVxIoxMjnmV78dq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=befoEZoJOLW7VYNzMPcBLlstQdU1NBceIEiVKiuB1UeuXTR6j0IEB5GnFB8S8fz43s7o67uWyedP2d6G3+IPyx63eLCEwKiWiMF1SDqQSgCilBNEQVab+CrDOGZnvbzyLQYPDo0T324Y4ayk3cye/hZrMtynq4HOUhQlKibZdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g31I0fPV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gxD9y4UB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g31I0fPV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxD9y4UB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B5354EC0143;
	Thu, 19 Mar 2026 21:36:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 21:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773970560;
	 x=1774056960; bh=8GCGJk2d37SOfI2oNbMRlaBZU5GuVxIoxMjnmV78dq4=; b=
	g31I0fPV1nLAOnKxR13bWmGSAR+5vbDvcFIptfEWepHjrTTq77dwWngshTg6Ayiz
	2uvUHfb8HKWiPbUUEtjVmBuhJLxjarjxPyy/iif0b25X+kwO6+cv7ODnDmNd19Fe
	T1xJUVujt3L+kS1cRhlB+0oDNVHJFWm10Is1XXgl7vnGbXKIjR7ELob/Fi+NKw6t
	82YTesUOKz9dkQhVzuy5XS9QFG7EOgaEJHTUno/ienzhK/HTr/4ibV+qY9nqooba
	L+xUonM4l5A5qDauc0+Yx3K8aZ8CnVUjS5MHxymGw3Eb7yxcTPXYxWZ1QbR+WbAh
	VdeGlDVuaRBPZZ9eVFqXRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773970560; x=
	1774056960; bh=8GCGJk2d37SOfI2oNbMRlaBZU5GuVxIoxMjnmV78dq4=; b=g
	xD9y4UBfrm+PSOZIPwpVJMvZNiGr4Jy8NF2Vu0YkIu1MMoEZM50NV2ov78U6PeTb
	tMTExEKY6rka7LNYXYEYlvUiY/Azf1NMbjHnldKgwgDJZ3tLumtOuF/vpjHIhhH8
	QyGy6j1WkOjb7vqiv9OsNluns5OjtBpqOsoE/8hqf1f3nrku25fNow7Nu/8KHKV1
	n1HjJna1HlMomLNObqvrL9ajiPFCTEO9j5Vr+owvEcSBdBaepQjp1hql2yE4oBLQ
	9c5crXnzvzMXbc+DiaKdIzuafA8iWvj8xN99TiCScO75qLghG7MuaxCgIa/c567O
	3XSslDa1Ni/+/p2mtHiRQ==
X-ME-Sender: <xms:gKS8actMufgJFR_K7Cxdf1QVDdQR1DZR92YB4vdFv8jBm3CtXMUXnQ>
    <xme:gKS8aQX7NFJy63JxnnQpkYwmbaOBXV6DKpLVTUuJOhdLnuHxY2COpqCbjc0vWdAKK
    x6sjtqT6_LDLwm5LVCsqKGC7K_qXNtX4pjHBTTV59sRE3E9khtysMk>
X-ME-Received: <xmr:gKS8aQHyw_tU3jgwQYZegIfFXIUR19SHi0xwdPJJdmNz88FSiCdHHNAElGc816vccQPe5fowDIxME9fwS15Rgt06_YaSrED37g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gKS8aa0aaLqeMbgh5jfBD4oBWjrMOsVtYGlMF5xHPFiewTBQSiwAyQ>
    <xmx:gKS8aaOG3LgUEIyIkXMU7BSS2EOX8ZyTIuLL3hPKTb8GAqBuyTK79g>
    <xmx:gKS8aR4fHFNd_C6K7ZcknD-6Fk6nOccmdCnj5jNp8ODcdabLGgjoVw>
    <xmx:gKS8ac17z7AWIBBUkObGv7JlPlLEZT1yDNCHK-KIl2B0aEi_469w-w>
    <xmx:gKS8adlRFZTfAI9kNV7IeFPpKhhazINz5GW2E-E3THYqVv6KX9niHbQK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 21:36:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Jim Cromie
 <jim.cromie@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-send-email.perl: support executable scripts for
 recipient options
In-Reply-To: <CALnO6CAZqAacTPgwTzAyF-ryyQxaWahXmpfCt9R_+vLS0o5uAA@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 19 Mar 2026 12:47:58 -0400")
References: <20260319155148.1145135-1-jim.cromie@gmail.com>
	<14840d8a-a1cb-4499-ba78-295c778e90d1@app.fastmail.com>
	<CALnO6CAZqAacTPgwTzAyF-ryyQxaWahXmpfCt9R_+vLS0o5uAA@mail.gmail.com>
Date: Thu, 19 Mar 2026 18:35:59 -0700
Message-ID: <xmqqms03gu4g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> What’s the difference between this and `--cc-cmd` and similar? I
>> wouldn’t know, I don’t use these `--*cmd` options.
>
> The only difference I can think of is that we have --cc-cmd, --to-cmd,
> but not --bcc-cmd.
>
> (I use --cc-cmd via config set to git-contacts for git.git so that
> patches mostly CC the right folks, but I typically have to manually
> track and add discussion participants, which is a bit of a pain.)

If we were inventing git-send-email today without existing users at
all, we might have appreciated the simplicity of "it is easy to tell
if the argument to --cc and other options is a name of an executable
file on disk, so do the obvious thing depending", but this came way
too late, I would have to say.
