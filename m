Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99C231A57
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593083; cv=none; b=j9IebVPkOSAGEr5+tdXOdzqt/zSKje11zGB4nVOSr3AjVWb+iboHE/USCGiJGUjO+StqtqOdvYds5IfkPPwSyxcQN+OfWkexcIJw3VR8f/q3OgstAQ0g1mJvLQGo5inG31NC+Kr3XfkYWxg5asSGvZVw0FYdTLlN6Cjp42pawEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593083; c=relaxed/simple;
	bh=J68aEhSGIbDY2VZfw3CWLqeB4s/resjk65AIP8qMuDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=txI9mxQBoBaK4ejgJoc5gIcbItzbIO4HqpCBT9nenc3Yz/PXpNXhQLWbEAPgEaY5VawwYkZxQMMKlrC7hC6YrN3rFBbuTU70uez6FLPBcuDvRRILubwo0/OeaV8uB0cZv46jr/8Xb1E2Xj4IXrkV3SWskJ3moDzgyvs0F0ElE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ys1sDteg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IlNKRICG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ys1sDteg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IlNKRICG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04F06114013F;
	Wed, 26 Feb 2025 13:04:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 13:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740593078; x=1740679478; bh=J68aEhSGIb
	DY2VZfw3CWLqeB4s/resjk65AIP8qMuDQ=; b=ys1sDteg0jbewvVGqwK9ClnnFl
	SVd3E1A5g3yQC4jTpCzf8SU0FBZR+WetCzfAMe6/vyXSqy8n38h5LFrZcRhiyGkO
	XifKRL31pzofIKt6ZmkPc/0EoGXdJh0PToi/0+P9fR803iD0hGHGT9y94KGqkBlv
	Fb7cotrn1eE+ceMJ7rzBAIrXPkxGbqvnlRjdzkUVZ1CsD1+c2Vr/44rAIhWNT2ZU
	b3I3E8Am5/hBWaavsQNTds1h2M9q2wzOfW8CreTouvkFM+AyVTQSMSVBWx6hbB2F
	Mnpy3RPKoPTmsD2XDLwHT+weuJyovv2RPIgKsNiE0YaVsJDvGTsm/yBpwN5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740593078; x=1740679478; bh=J68aEhSGIbDY2VZfw3CWLqeB4s/resjk65A
	IP8qMuDQ=; b=IlNKRICGDSwXdk/U3mDRdZCtmkf1ASlq6/7jTxWfE0nspHrl/Oj
	/QQTQMmgq2o5uAD16w7lVrSqiuvI62255HQVWxicfY+m4LFBgw5vlCzJaNp+BaIp
	lQcZqOed9EUypCjqVkNwEqA73b6FAiUumHChUC+Zvu6Jp08KZLTNEV429IKfc17F
	znWYd6x/IHo9sIichxxyxFCy95sumQTPuxj2Q+7g/tplCOis5f+mh5nS1vXjBxVX
	HHBAoI+eEaoT5v169etfITFNZ9kTL5PeCmbYSub+XiQBdXcLqA0B8l3XojPKVEEn
	O5L8PALtC1fUHxGecC3Kq2J9+CTZvB12Z0g==
X-ME-Sender: <xms:tVe_Zx-p_c2G8zEzWKTLNvEmVVnqRKezcJO68jg1-2mqeRnkk0y1mQ>
    <xme:tVe_Z1v4fK1UMDGYOB05QPIszqlgZpQz5s6sd-gkdUGqbhHinVMqO8U3-aK3TCnce
    0FgeM090KnBhYC-zQ>
X-ME-Received: <xmr:tVe_Z_DYm_pPiKWE77ra10hyrDUt0azX4LkO6r9Sk9vpm1A_qvJ2smiBoRA4KHRFcvALWmw2e0bI-ZkjbD_Ooo_ePcs1LSqCfc3n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:tVe_Z1dqZhuhLgBhyJEsQ9Xe3Wd4yhLwvSfCuY1OWSZWZJ6jC88BCg>
    <xmx:tVe_Z2M1nWSKFld_yR9j7yUxGwcu-9M_V6b4kBuAoJZp7dcpYgQ68w>
    <xmx:tVe_Z3lJEaeb3zo_caDhooEG4g6xn_DMNb4w5fJpGJRdPt75yRXdKg>
    <xmx:tVe_ZwuQiMadaUTw96aNY0hYg7Rsl--HdvUovQHYPqOwU3_6plsHDg>
    <xmx:tVe_ZyCUMzZK-4CLLQ6_2Bn4ACb6p-9059bcZfTmBXYBVThHuoGRIXJS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 13:04:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 1/3] diff: return diff_filepair from diff queue helpers
In-Reply-To: <20250225233925.1345086-2-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 25 Feb 2025 17:39:23 -0600")
References: <20250212041825.2455031-1-jltobler@gmail.com>
	<20250225233925.1345086-1-jltobler@gmail.com>
	<20250225233925.1345086-2-jltobler@gmail.com>
Date: Wed, 26 Feb 2025 10:04:35 -0800
Message-ID: <xmqq1pvkeg5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> separate functions are implemented instead.

It would have been more assuring to explicitly say that the original
functions that discarded the newly created filepair after adding
them to the queue are reimplemented as thin wrappers, which is the
right thing to do and which is exactly what happens in this patch.

Looking good.
