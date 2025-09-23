Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F92741C9
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663538; cv=none; b=ciPUJ0FEOsiTkOOhVLO0/Lq5qJbyEtjxF1t4KUU7gfe+BSlUZkbYMVFJx0yDGuQNHpiBQeizRrLO6QE8rioFRmqa7Etlz6HLqF4CAX7QRn9o/SnQhtf9ZHlFj1QieWRlal3FvdJ3WWVN3/Pz492ZRXPCMgJS8Go5hRXMizPBlu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663538; c=relaxed/simple;
	bh=CAj8vfTozMciaFbsKQc//6cDbkoqjbA6b+Vow0gEAOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CTkVKOlOgmwz4jvQZlqZaSaQdRBMB2Dt9Wu4ZPTXtefwgTOFRZeyvKoVuPY7XmTj4dxve89RWLJgBGATu9m1as9f5X4TMf3wSq1wYoQqXdxP1zbiO1ErqxBv9igYat6YdvVzn0AagM1V5sp6dcjl3OiHPgE+O8/UmWAxP2PlbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jPgULx0X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fznmf70q; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jPgULx0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fznmf70q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B47A140007D;
	Tue, 23 Sep 2025 17:38:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 17:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758663535; x=1758749935; bh=7f2vuhsgZg
	sFxmee4hXnVZAtQgCQDvKWPu5lQkYnr80=; b=jPgULx0XFicOGDEDiy3SmokmOO
	3wOxlh2j5xhJX/3cbPIMwFayNtQw2w5m1m3G3DkJUs2fH3s/nw/oitbU0LMqrYq/
	rvvZ6/QF6fBCUc0e/NXTzRyiqFfO+KdNQ0lxAt3ZcRmW/9EAjodQFf6ZZ26bCEId
	aqWctcAZOhsEQbF4P01M7B6kc8QRCoXtLNWAmEhEb+2mCYwaFJbi18rELYuAAf5r
	n5eQzdrTyvMHWP5XVK3HCi3sQdlBRn1anEORd5RlKIrO6v09uqqJav6XSuCW1pAN
	IQCbhDCabh9OCBRbMmLvOguCBnjPM50naWEyv/lwsDwVlzBgiG4a8D1I3WEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758663535; x=1758749935; bh=7f2vuhsgZgsFxmee4hXnVZAtQgCQDvKWPu5
	lQkYnr80=; b=fznmf70qzaVtkoELfbvI5045vaT6lOG2dZOWyg10mOyrXO/AUAv
	Mx0kGVPvF/Ig36RrWDlZ4vswVZd3oqtO9x8qwdAEPjm26QRP5aw3Vl2hMK91ojup
	66mtX+yo+Cjg6Bc5QzfJayGC9TAlUsFnBYpPH7KNbYp+RVHtPvROuTGHWJbkO8rc
	XM2PjtapvspHpuTA/m8rN3A3u8coAzaNgUj7sQDEALzA7FlOKGqVqKlonH3cYUAz
	AP2+aTf2uUl2XysdGR/lVSCpz4KLEkfUhZOoMOAT5ZffIV3s63DdXtg3KSUL8mMG
	oJPfnNyl9SblhmQX9VybiZXButZ/oHsXyFQ==
X-ME-Sender: <xms:bhPTaMycvFOznvi4Rl8qp8jIEPr2uR84awYGemG66MOxJbRtKeVPzw>
    <xme:bhPTaLtY1N6KCnTOFXheXTXfOxNMUsBXFeD7xZbOPfWxffEYFuY1AQFtNMI8_xSps
    hQC8hTf5c6MwS7h0uPgXuW-3soznGDAQEFbyak0IdJXH_lbtzDT>
X-ME-Received: <xmr:bhPTaB3dcCb5o37OlKOgrXa28DZ-g6swTaQtuPEQtXf_E4a-xNUYprNubjg3Wfs5RAU2RNhFYykYflDXoV8PHSjB1VNV_2IqgGbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmsehgihhtrdhsthhrohhvrgdrughkpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bhPTaO8Zn9zm-HNdp0WoDZ_Yka6t-NdmWuxCGcnKufXaVs4QmMmYFg>
    <xmx:bhPTaKNXca5nlC9iLT8seLH2_7kflhbZ0VI4CzccJ7bpngTRVmr6Mw>
    <xmx:bhPTaKfs48Qs6wKAfQADKEJWouSSYh3WyR7lJktV-gl0Id_Ka0PHfA>
    <xmx:bhPTaBWKs8zLivt8CwLVo6SL4q8sAuBx9nrS2CtM75JjfmJDTxohBA>
    <xmx:bxPTaC_I1qkkIk7g5lr-QefysBZFxdzMTomnLm3ygntWTBH8swVK8Et4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 17:38:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mathias Rav" <m@git.strova.dk>
Cc: git@vger.kernel.org,  "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
In-Reply-To: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com> (Mathias
	Rav's message of "Tue, 23 Sep 2025 10:55:02 +0200")
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
Date: Tue, 23 Sep 2025 14:38:53 -0700
Message-ID: <xmqqldm4onma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mathias Rav" <m@git.strova.dk> writes:

> In `git rebase -i` with the fixup command, the -C flag controls whether
> the commit message is taken from the previous or current commit,
> but currently the author name, email and date are always taken from the
> previous commit.

As the name of the command says, you are fixing up the previous one,
so I do not find it a problem if the credit for writing the
resulting combined commit stays with the author of the previous one.
The authorship information both covers the contents recorded in the
commit's tree, as well as the commit message.

Granted, many commits of this project that is a one-liner change
often have 50 lines of explanation in the commit log message, but
still I think it is sensible to give more authorship credit to the
author of the contents the tree of the final commit than to the
author of the log message of the final commit.

> Change the behavior so that fixup with -C takes both message and author
> from the current commit, instead of taking the author from the previous.

I am somewhat negative to this change.  I am perfectly fine to have
a separate "I may have started from that previous one, but that was
so broken that I essentially dismantled the original and replaced
with the new one.  It is better to attribute the credit to whoever
did this last one that is replacing" command.  But the "fixup"
command people have been familiar with would be different, I would
think.
