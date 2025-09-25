Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E33054CE
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817381; cv=none; b=OcaYjVtXWytyVig7DDQqZYZDCzPeW73AXLiztkWLxtYsm3VQFzmiZsUWVuziONJX9juKFiLXjaX6qzN7doJaI4/8vUlGwRSjpvRVVV4GsP25QotoqUbGU68zm5bsMHL1eGRuNsXz/9xyXQlY66J1PqbIsY0GPMF8uI+FzVABhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817381; c=relaxed/simple;
	bh=mxbHVhjLxFwOj2rtjpXmxvyNsCJraVpX2mpQt5d4xl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JQLQ9eDK9dn0RCm80iOoqqgo9EXcBgrQ3hciX1R0djfoB+4/7c5JNub6wyXxcPRVKPTiLbZjr93xj61kpBoZzlHPGNi2PkHymau9J8iY7MvOb+lsmBGvnJYOaxr5ti11H0+FSHcG5doJmATdERXlyQbW5196T4GAncbqwPdMWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FKvQ4kMf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDwwu+jR; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKvQ4kMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDwwu+jR"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D05921D00087;
	Thu, 25 Sep 2025 12:22:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 25 Sep 2025 12:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758817378; x=1758903778; bh=Bxe3lVXFsW
	PD9y6jq6lYMpRxoruNrG33zT9D+rdkpn4=; b=FKvQ4kMfknuhGG+fqQVuw8iSmC
	t5Q2IBxrZ6cgFVmQ+SoyydPDp9Gq8vAZ20SmyTiIjtghw/rrnrtaee8nytG2FtSA
	Sw9q4kCuY0hsCv818hDoTj33eNm24GJ7f25LgqtaRKeVMs5DYAPOZkVJUHlo4byA
	qiiDSxwiTKQzWSDRE7zpxbxRa2igCX/LM86yrTzlxJed+5NjF2O1lxxS10qU2qzx
	SaxZhPkF9PkrMhX69NzfInLi1hI9zYC3MaVs+nHLLMlacidMNKBeMiP560b7Y9IH
	0KE5o5PPiCqvUzgVLL1fqab6OKJcsZaFwaSSVrLpUzg4Eq3IryTns3ahw7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758817378; x=1758903778; bh=Bxe3lVXFsWPD9y6jq6lYMpRxoruNrG33zT9
	D+rdkpn4=; b=GDwwu+jRc09SaXisoxPy5NhJN1ArI+WcsKQmKKnUicx+rx5rkYY
	JIMNrbckBOd5GqVtU7iQLwxb00N/BwHPePUpBUf60n9TkhC4cxMm4Z/tSXREepYM
	SvrsmQuSUkllnuxbJR5KNO7quFCGLQK8gIKpZJiWln/r9WamUEphnO6v2ETH6gdW
	XhHM8bXR+Gg5UBqcTZjM5kFJEPwEzaAbprrjljSof06mWUZOoWgoBWK9ZSKXYuVU
	w2nZclQBoGPrDT5zeILR/igVP4hcuImVCeeKz9MXiKCsG+wfdJAegsZy3pbnaHG7
	Btm6LxVji+8RY8rHfgZ5TmuHGD2dASm3hwQ==
X-ME-Sender: <xms:YmzVaFErf6L5-5nTj2-ojVTlVHpLGMg25DWIRlZQWpZjVYxsBAnWlw>
    <xme:YmzVaBMe6bhyeUigu_mNAULq96I0QFm-UvoyS1HlxdQ8n7Apde9JCfpcM8yJ0trLA
    EhqexYUUqkreuj1vVzwRtmpFlZJvb7jdFIr6E3xjXTA6gdlMfJE>
X-ME-Received: <xmr:YmzVaPdy3QLumUcsFfEkhu728ne1Y0gj6omoJjr9QogfLDi7VCfavywPlmk41L36Seo2qwTODLUKzXkk_S8SgYQZRkVE-u2Yd-XY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YmzVaGsH6eDB_REuRMews39Vz0usa1NwPZhYzZK2C-8twDeLKHYh4A>
    <xmx:YmzVaIkHnPXpC-oOg0xzl4J2eesp_nRCSmKmukyUAq72jNyFbwHj8w>
    <xmx:YmzVaAylfIas4W-rHAp6pWzykj0s1wNpbXj5kXtszvkvUdSp8ssAiw>
    <xmx:YmzVaCNWpCSTqX2rHZfpu6nJMtgpftu9g3pejiKsj2Jw4GNrb-cANw>
    <xmx:YmzVaF-9h9YkN6bmTLGeTuy6oqV73vo_FLXKp1boUrTFigcBh1b0SW2M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 12:22:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  shejialuo@gmail.com
Subject: Re: [PATCH v3 4/8] reftable: ensure tables in a stack use
 sequential update indices
In-Reply-To: <aNTdTu08kKugIr7j@pks.im> (Patrick Steinhardt's message of "Thu,
	25 Sep 2025 08:12:30 +0200")
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
	<20250918-228-reftable-introduce-consistency-checks-v3-4-271af03eb34d@gmail.com>
	<aNOHl65jYyoNXou_@pks.im>
	<CAOLa=ZTf7KL23+=Fggfg=4LXt1Dsd6nRCFg3q_Dhuom2Bk+L7A@mail.gmail.com>
	<xmqqikh7lob7.fsf@gitster.g>
	<CAOLa=ZQxM_iRMLoKt2ZoTSngkQ3EzXiJJ9hiJxRqHSaq2o0Nfw@mail.gmail.com>
	<aNTdTu08kKugIr7j@pks.im>
Date: Thu, 25 Sep 2025 09:22:57 -0700
Message-ID: <xmqqo6qyh57i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Wouldn't 'monotonically increasing' suggest that
>> prev_table.max_update_index can be equal to cur_table.min_update_index?
>> I have locally changed it to 'ascending order' for similar reasons.
>
> I guess the correct phrase here is "strictly monotonically increasing".

Both of you are right and I was wrong.  Thanks for a clarification.

