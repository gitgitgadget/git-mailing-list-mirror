Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353423CE
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760425826; cv=none; b=dRgtBAhKC7DZ/lHaiyp0Si1+iHeIbABOydqYyKn2JobWlCcrIU7qsbmBSMFj4y98wwlWkJ/xT7YErk9GHWG5Q418QY/+A+Mk19uBlRvmSi1ZmYcpv+nLJ/yO8BHX9PQW5TEFvvX3AxFEyBGQSv5vvJWSF9QSvjc4dCFGcLv1lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760425826; c=relaxed/simple;
	bh=ZEcmGZ8MJM0hOuF1sDG5NB+NviT/K5uG1+qP855GLtI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WiKFtULmoaRVEUcc6lF6PBrlhtu5Ga5EDTtkEi4rzAiqnD55ImQdw9GcouQiq8x5+4txraSJxKzQEWdiETFFfqWArFG6c6Ucy0bFIzo13aWDonpY04xCXtEiGpNgAZgkF9JnxubAfWoEHTSOxwcan/C8DB5+QLATdH5lRl3Z3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=k3tz6wtA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BAd7kRy0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="k3tz6wtA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BAd7kRy0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A4186EC01FC;
	Tue, 14 Oct 2025 03:10:23 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 03:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760425823;
	 x=1760512223; bh=Uqg50agkUYZHDic653BaHsGOxaE53DCo2Uebky02xW8=; b=
	k3tz6wtArNqngC3t0/uOVpvPd3/fMgmvZhUYIIFRbfGfx8cpQ2hpyhr3lyzAOjG7
	ZU/bYcyIe117VinzGrUNOd5obOByl1P3RB9sAdl3dklN9Tz81CMIJTA/g1PLBqH7
	hcwf3/IZIVxBAkdqUc/wmFpdAly5BsrZo/ZdY3zAtV/HJP2QKZcfUxNv4j6pFNDr
	vsudI5FKraFuz7AnCmKE3kTXXDYsXM0ErhhOYgvq4M3+VUl0e1SY9JO7qGefiSB1
	vn2C+THo15kpIgKIFlGDEI/S5E1Jz6ny4M6NPErUeucAXqnMvMN8niBCN4Omi/4Q
	n/EuI8VepkTcGb03TCtBPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760425823; x=
	1760512223; bh=Uqg50agkUYZHDic653BaHsGOxaE53DCo2Uebky02xW8=; b=B
	Ad7kRy0FuLR7fTEGd9fT1cNS268DjezDF04qnWNm0eWANCYRGiVkkJQX8x4XMuvZ
	1u/2onSysMIohWnchm1yn/TEMLXA1VliAWf2y2ylMqlzldsfA4scLoj6BUkaE7HH
	3dthkmpGxUKml4JO4RN1PypaD4K+4AHJuA0CE84b/UyCtsOJq8xWtL5qSFGgfu0O
	PJPcyHIq0ajpD1eTZSxwH7T/mgyiomI5CyKSLHuCj+a5SQ6xBl2KsQzRm7dbaqtn
	59M5O3sA8dKxZomFIoT164CVuFQe+wVu5agzYLwyOc2/+G9L1UVfenUBOk4sFtkp
	T6qma1c9QX5Z125IMtmqw==
X-ME-Sender: <xms:X_ftaGKktAaK6wjqCQ-PoOSr8vIF9Sp99e-WAZWbQa5ObbjW9xUQo5I>
    <xme:X_ftaI_dgIhB6Sa871JBS94hQdWkZpY3iK9KCFThP5PKZq6ZjN9kCbp23Bzm7PPaP
    UrUbFz-1-S4rpogcYGfQ-zL5zqnfcpdaLWai6oyTMg45b051il1eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghmvghrrdgrsggurghllhgrhhdrtddt
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:X_ftaA3o2FTmSo_6cVBKd14xeR4J8LGgu-OcfidrA0En4as99Xzddg>
    <xmx:X_ftaJDErFrgmTwdXjwQIqB8FxFvWAjKuF31BLmeCdfi5UZoKyvZXA>
    <xmx:X_ftaAePr9J2ujzwYoHXmw51Hq9cAiRpx7DEDI9mM--clRGZmOTzzA>
    <xmx:X_ftaGgbTPkBiMdgPQ9vsLDxOPLdBzqXhmgNCQlWIK_h-7BqqFQ1NA>
    <xmx:X_ftaJuGDtnnS80s99y0yJw-IZlFwlzaS2XUCaEMFm0bdWUsqt5vQwC8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 587341EA0062; Tue, 14 Oct 2025 03:10:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdytnZtU3TV-
Date: Tue, 14 Oct 2025 09:10:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Samer Abdallah" <samer.abdallah.00@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <53f724e7-1525-4a3e-a51f-6225361eee19@app.fastmail.com>
In-Reply-To: <25428D84-1B92-4398-93B2-175231A699B4@gmail.com>
References: <EBCAE8A8-E556-4DE9-9B76-EA4C27EECA01@gmail.com>
 <ae47adc7-7393-4994-9aae-e661c0e36b66@app.fastmail.com>
 <25428D84-1B92-4398-93B2-175231A699B4@gmail.com>
Subject: Re: I still use git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025, at 01:01, Samer Abdallah wrote:
> Hi Kristoffer,
>
> Thank you for your reply.
> I should have added that I use it to see the history of changes for th=
e current
> file I=E2=80=99m editing, using the `-p` option and a file name argume=
nt, (and binding
> it to the command `:Ghist` in vim.)
>
> However, the following seems to produce the same output, as you sugges=
ted
>
> 	git log -p --no-merges =E2=80=94raw <filename>

Good. That=E2=80=99s great.
