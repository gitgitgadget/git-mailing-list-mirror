Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E419C54E
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931871; cv=none; b=IBJ0BW1IYMzdoIHpgQjstTT8eLHAjEps/suAn0R8BFB7oZq+K+ovYmHQfB4OiQsH01A+ZHJxwKdzHWQQHT/Qc7LPhO2fZ8wkpHNmktUU5jwUNEC5fQcUF3UJJfTfsZBlECbdZ1yKIuzd47DMBBxkN6OW5pBnNoAifudv6EnP++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931871; c=relaxed/simple;
	bh=3Xj/ITcAegJiwDVJ89cnzovmzf3Gnq9OHnt6sAyAtqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=njs4jdVD9OBP12q0R3pOzCjow9PvoLOdbd5LMx5SMiFHQEeu04enw0y02nqi8XPw6RDXvpkE2ICriAWKpiH6ezRCB5YW2BRFFocPsta77ikYW6nYT2M4X1l1F+jdX1hkW0oOTOAJbkYPig4n+NLHuUu2E4fm5NJjimBN0YF096U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vp/DZyxk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jaYJ95Yq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vp/DZyxk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jaYJ95Yq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65F9511401C7;
	Tue, 25 Mar 2025 15:44:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 15:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742931868; x=1743018268; bh=w9GlCWYu2R
	tu3bWi/DTYnyz7rynwzC7/SKbcmcqdMDQ=; b=vp/DZyxkRdpRBIrTqz+WF8E6Uu
	lP+FFNrft7399eLC7+ohRfnVDxJyn135AZ1nNJbrI+hv7PjF9MWANDIqA3T5dn3z
	gcwgYtdWH+3FpN8YywqhSoA1Cc8TnhKfAmLdJtAyAejpo/4OBhTEl4cGH2Lb4KRQ
	59X3N/ZCF/ddl+Crg8SQfFU+WWyv9ix97dPsfS9eGawgwlZuSYc9FbFVSiBfz+ZR
	oDvTvWvHkyBMr8xTBKFf7147h3ezDaVR7bhjA+1TXG1iQioK9uHVazc1uA6mzVjN
	p2L8csWIDP+jVKqn5vDLCPdc2HQiI7K4FPfwQGOESbIlblUfsJvLYxkfaX6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742931868; x=1743018268; bh=w9GlCWYu2Rtu3bWi/DTYnyz7rynwzC7/SKb
	cmcqdMDQ=; b=jaYJ95YqxGVrTS6/UBGhZbQ4t5E9yZcvMxgFpi/bC1JgaoJdIOh
	p+P92cxwOj9FHXq4SPmmRWMeTg/V6prz2WRHNROdVW4i4ghSfE2N1coR1MYJouWa
	ZqFE3eCdtlkag/qZJbix7UOM4LnUb6QF8KYDOuKPE1nkteNsPlExIwgblCtvw+ur
	FRxoEEzfvcUwwpbfpMWnZG9bXjPGwD4hcWWIzYCH0TdWsrKdVKOj3gVYLL0ZxjUY
	XoLas0A1BjU+1Dr13P47it930ZvZL8ZF4GatLKjVSpNbi7G/llxagEYOUcE1QWl/
	/qUgo+f5VHj3iJBipYmcPajkMUurOTeCp/A==
X-ME-Sender: <xms:mwfjZ6SQX-LgJSzLDOZbuQM75Mn8w3E0lPXnrafXTKCB6l_cfuKxyw>
    <xme:mwfjZ_wJyhUHqpuWlAWnPl7-S2iuM2qURFE-9_ccs4hhnXNeQRpoFuOOHPZ4vhySX
    w40GUBcXYDWnaSeQQ>
X-ME-Received: <xmr:mwfjZ30Ar3-QWCD5K548aXTXiZFHg583pfPX_UjMZFVVNXO2E-vKqB0VDiDGgHYG7ZcwRdaFFcdVPL2sRyAJ7OaunZAClLZFIVyivAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mwfjZ2DvErZ53oeTwd7kXwp8HI53MP9EIGbBTbGNH3EqpE7Mj-dLcQ>
    <xmx:mwfjZzjw47GwB3ZKml3VeNke_7eK-ZocIRj6IWc_nMGtly-lRmVTeQ>
    <xmx:mwfjZyo0ZgzmC1li3DPOBUb0rGm7QnN07Ouj596TFEQRvkrZhPW63Q>
    <xmx:mwfjZ2iDtw97skRYy5ABUYKtuTjxn35-nvlmH2N57JhtScXzZ1SgqQ>
    <xmx:nAfjZzgL-hTz0uu-OMgKOO07vzxMBnq2Al-HP5byGDzxy4Ku7MrjjmnD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 15:44:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  jltobler@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
In-Reply-To: <875xjxwlb6.fsf@iotcl.com> (Toon Claes's message of "Tue, 25 Mar
	2025 09:45:17 +0100")
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
	<xmqqzfhbrb78.fsf@gitster.g> <Z-Ew_12NWX_5qATN@pks.im>
	<87a59aww8j.fsf@iotcl.com>
	<CAOLa=ZTHb6ZFmpDpSwzUTiDs44gY-W3aqBooAMyORK8Xs3YQxQ@mail.gmail.com>
	<875xjxwlb6.fsf@iotcl.com>
Date: Tue, 25 Mar 2025 12:44:25 -0700
Message-ID: <xmqqbjtonbdy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> It feels odd to me only the "ignored" info is emitted and the rest
> of the details isn't. But that might be just me...

If we have more per-line (and not per-commit/file tuple) pieces of
information, we would have to treat them just like you had "ignored"
in your illustration above.  It is "ignored" that feels "odd", since
it is the only single oddball right now.
