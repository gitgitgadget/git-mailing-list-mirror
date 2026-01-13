Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD5145B3E
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337084; cv=none; b=N3fx+j2CaRJHUg/IKvec0RoUqmtEcexagxw2xOyDbxuUOOPfnhrjixlCYCVINzZPbw6AOGEAe7cjawvUA53Vjfr2Rokao2kR0LEvb49qHHLh3yNIpbmAsskhnx9D7fTEaXfB8nCIKP7C5rleCa6WWx+Toaf2kqnsmJ/dXTVdyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337084; c=relaxed/simple;
	bh=+hODvU5TDqoZMWBVdLlm+/5TmS0a+87Yy/NAxYeaeHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=peGYI48igWx1n7xHuj99MSvnZm1lM7H2SRxvjCGHFnfpdhuB99G+kTP7+H7lIXFt1KE1LWbxl6K48hJ3QMFGs7uUX/WaLhkN5mcD3mgd2sE+n+vC7nai8GHPrOHU/4IuzU4cbR1lvGuwE0BvioZWxHNG8y529z+aJpcdcMFU7b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G8yFAcYh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zbELnTFe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G8yFAcYh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zbELnTFe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 48C74EC0222;
	Tue, 13 Jan 2026 15:44:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 15:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768337082; x=1768423482; bh=yp9Pvgyepv
	ewfHUUAn6a4Gs5PsUJ2n9sm8n1c0MwKf4=; b=G8yFAcYhuEbuIRd2wN0sl5mBxw
	uCVaP65RZ0dpll4iEgQ8I1vUaOEfEPeT4g37APX80vjzUfhBjgdzL4GiE96QarFW
	NaAtlywP1BJxaWGl310l/q0Pt67pR69taRtcsG9z5BLcS9SfDrBDau1LczEsv5bc
	qKzyj0YRxbESiMikP/sVB8PnysIFqizvEnkUhv8aGtiaDrv41suo2ZCO3lb0sLvg
	p3bo/1VQl3GkGII1la9+upkmiMVEU9NhAOcDOmi2Epp5QPDq+rCZWH+jo3Ndpq7c
	Oty0Ii0sAyNQYXS9ttqDqs3LmjVSkFpWJ+pIkK047llXX1yGEsQqx49yvAnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768337082; x=1768423482; bh=yp9PvgyepvewfHUUAn6a4Gs5PsUJ2n9sm8n
	1c0MwKf4=; b=zbELnTFeBSF3Pj0v80dOXQGP0VwcS/78xskDM+uYOQC+dqncNTh
	h8C4ymj1gs7GxNnMQghgfiGYpuTAYONo12SGDg0HjHJSsIBGrUwKMSLf/L7bujx7
	HPghr/kyQkyYu0EcnXaB3rr9+vTIJSVWWUercXF+KgiXGRRtYpVXh/dW4fYMVmju
	jCoKOB1Ri9RgNjpdlCOfSglTts6HoH6I+XE8a8/IJB6TwQQMRexsB+7erHZj4CHP
	MDK4KvRUeUwk+cGJsMsIFq20qFMRDzNDdMw0po35inn0hLYQLtmPYNDhYL7bClcl
	MO9YQhcPO717ia0K5WrWWSWVyYnklakoVZQ==
X-ME-Sender: <xms:uq5maWDDNInySEgYVs0082Fi6PVx3dIFx81IOcKYLe7S9jD4gkC64g>
    <xme:uq5maXgwrpKb8BnTXS2X7O9COebYgsvBQ_UPfaV56beZJUgpcidwI0-9KJUxPrnm8
    K1OUxAF72dApGpZIwy4DAxV5pQq9fy-IyHLZz9y7-Q9ELUHSWzx>
X-ME-Received: <xmr:uq5maemAQCBl1Qv7zAgZgV7V6xso4wWL05YbZMWPb6lVFfI32s40sIHSQSMFjM16RP6yRAxrjdJDk4SNdtdEYOZbYHzQjHyClJ1bmEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddufeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurhhirg
    hnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uq5maTpHNG2g7rAJaKnSzIDSk7Q7vCN0Tm7KTE37emqAx6l619PqKw>
    <xmx:uq5maXGl-RmaGkTWqpr2V5jWhPq5eR8wVFD81v5wapadRdWocInVwg>
    <xmx:uq5mafxEsSps6B5T8mq6JnqHK0u0Ibbi3rnighx5CZDvFD_VU0aNMg>
    <xmx:uq5macrarxlzjDZ8IWcys7nJXGmxnyg0kMuHEYAtEt5_7BMG9W7vXw>
    <xmx:uq5mafXR0rAjr6rfUrYvChTrAEti6LAdlcRkzy1YkskHBDAnTLesUVMV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 15:44:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Adrian Ratiu" <adrian.ratiu@collabora.com>
Subject: Re: [BUG] push: pre-push hook that waits for stdin is slow
In-Reply-To: <249f08d1-4457-4a41-8dbe-9725c0c392de@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 13 Jan 2026 21:26:45 +0100")
References: <249f08d1-4457-4a41-8dbe-9725c0c392de@app.fastmail.com>
Date: Tue, 13 Jan 2026 12:44:40 -0800
Message-ID: <xmqq8qe1i6o7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>   Thank you for filling out a Git bug report!
>   Please answer the following questions to help us understand your issue.
>
>   What did you do before the bug happened? (Steps to reproduce your issue)
>
> Used `git push` with a pre-push hook which included a loop over standard
> input (stdin):
> ...
> I bisected using `timeout 3 git push ...` with a local remote to
> 857f047e (hook: allow overriding the ungroup option, 2025-12-26).

A shot in the dark, but it smells somewhat related to what was
discussed in this thread?

    https://lore.kernel.org/git/87h5spimno.fsf@collabora.com/
