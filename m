Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD524168D
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977890; cv=none; b=SxRRrX7uP0Qn4jgjmfzPtlYKYSBSc/88/1nCwFM+EqeUyQFv+kopoLsBFN5PZ5dqMUP5ssq1dhQUfYF+n1n8S4wZmVhDJNpUyjIkrsmC63DnGZo3pm6kBPk+F9EqG5vGREesb1/QUIGTKFodJMf0jJnldRlzQnNgPKYpU/uCqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977890; c=relaxed/simple;
	bh=NCThVwdyOGIB6VCtd5bcy84dal1DlDd2NXIfIB5XnXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SMP62iDRceECth09laP6UJ7ErCoy3ry50mdUEgV9104Y/zONaC93vgzgw5d/d+vElRkQ5okB3ohQbVZg/NC3qWrY4/Q3pktRsfd7CvkjL/DtCwxkVa1o+cwp0Hgxfvi0a1bgXdwRvxpOosuiSBSjDp8i54eQyTAnZRMMtSMeF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gN9FNea9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pk4eXVC+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gN9FNea9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pk4eXVC+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0053E1D000E5;
	Mon, 20 Oct 2025 12:31:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 20 Oct 2025 12:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760977887; x=1761064287; bh=svHAz/BFi8
	fuXeRkBT6Hqy/UR+yGh4eQtsexEvxYPfs=; b=gN9FNea9Nv7KjqzMz5+gWTxPtq
	OppOfeOMPGYPz09IgRDmb7wWL8MjFwcENeQmC2TfYyYZsyfGZhUVhbB2IXxEhN+e
	p8ps/DsWeTt7S9d+oSuxBLOCsUnGZJa1OZVz/GhaB1wxFFSNBfk5R/IG5QBbuehy
	xVwIxgNRw5mvtBnit93hS9tGng+y5wDHIzyZaEUrsi0g22S8FtrFRd28F62N4cto
	G1oIUSXENtX1GDN4Ldw4MqCvFTZ+WF3j0nSry2GcB8sSXz35UJnzTW/2YxGPHclp
	GFYvLmX7CYFgU4CwzJQQzR7aZ6DxanIuoqKX3MXrzQxVutbIE0qFm+7Fb9Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760977887; x=1761064287; bh=svHAz/BFi8fuXeRkBT6Hqy/UR+yGh4eQtse
	xEvxYPfs=; b=Pk4eXVC+Au+dP24V8y9+aq3UvZCWU0Ww0qzpB/JoiVxmnCenU3E
	xyslzwzcoa2r3nU0AXD7e3aBSPImjKI0NB67hsmccxnj6yrfss06jJfmXkpgQYhR
	xAXaw8KYDiI67qtYvlx5uF4kpi/10JVKt4UMyYpeGtJUv7zSlBxy6yDY+2kBNd8n
	0bHTpItrlZNNw7grSr+AZr4ku18Cx+r91OFVbEOu3NFqD2en5QpdP+n29C5i4bwh
	anWxZy0K9WR5LG+ZdnK4W8gXgkJr+NLJ0kkVOlZvXGp0r71SO3xgKnxci+GCpZBi
	y1Uzh/PP+dFfODegGtv05/yKxyEx6QFdpgA==
X-ME-Sender: <xms:32P2aEy4Lvc59NmL2hWAwTXcNEkGBDoc80_NG2rl7PDKPaK5utEKfg>
    <xme:32P2aPKmtSGAPAX58_qRxtXchyRj_qNAB_0jF6GlTx2A8Zdo2zoDJgzLcvUFwMXvd
    iN5F_-L0a11NNT6H78O0OQVsDbrOJb7MFJgLuW0UUvT3L4v-n1wpw>
X-ME-Received: <xmr:32P2aOoTgPRvKhUn7X6wcxfWC6gsZjoMDrhf6Lx-KWl8uPL2XvIuMu__Y-vnYlkd6nTN2lt3A3b_wcg0Qu-J58VX_AbbtSFY8wDe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:32P2aOLgxfk16XdluITkI1aBBGEnmz_MTlzVvG8DVrTaO77HjDQxmg>
    <xmx:32P2aDSJuaIRp70jESlkxM_nWUy9lUsG1EAGH83NTvlchNiDoDfbkA>
    <xmx:32P2aNt8MJIP58p4nKlC2Xo7_T5QKvNviRvHOFGk7IzuL1ZzJpCvQw>
    <xmx:32P2aEYz7yilmas_wFLgFx7loQgY-1DDyUgQoh-wuf0Z5iA9E61eOg>
    <xmx:32P2aJZxj4BA3cUG2RRm-ofJFWgAuI2NKrXjClbCVS-ykqx3tsuGSC2q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 12:31:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org,  usmanakinyemi202@gmail.com,
  christian.couder@gmail.com
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*()
 with string_list_split*()
In-Reply-To: <xmqq5xc9390j.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	20 Oct 2025 08:09:16 -0700")
References: <cover.1760869186.git.belkid98@gmail.com>
	<7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
	<xmqqqzuy3n3k.fsf@gitster.g>
	<CAD=f0L8Zc=rRwCo0QHWnf8OCXidubJrQYpeQg=gLXV=npO-T1g@mail.gmail.com>
	<xmqq5xc9390j.fsf@gitster.g>
Date: Mon, 20 Oct 2025 09:31:26 -0700
Message-ID: <xmqq347d1qn5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> What I was missing was that we use fingerprint[1], not
> fingerprint[0].  So we need to do the strchr() twice, i.e.
>
>      char *begin = fingerprint_stdout.buf;
>      char *delim = strchr(begin, ' ');
>      if (!delim)
>          die_errno("Barf!");
>      begin = delim + 1
>      delim = strchr(begin, ' ');
>      if (!delim)
>          die_errno("Barf!");
>      fingerprint_ret = xmemdupz(begin, end - begin);

Ouch, of course "end" is not declared anywhere and it is an obvious
typo of delim.  Sorry for not proofreading enough.
