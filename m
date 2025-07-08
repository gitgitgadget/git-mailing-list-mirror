Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27B1DB127
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007525; cv=none; b=IxfNYodbxQSJr9fQPvgod6+lm5g3pDG/Wbtk+Pc8DFekX0rQr8Duxzspdgin3bDLVGrMZglKGFe6puCUuGChBOH9R8fcOnIGvZKN4BQvag2h5V8RpjwHrBfsuA+nJhIyGw92McqY26p/OqefXLIB8ccXzRXTEnKI2nFVvGONKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007525; c=relaxed/simple;
	bh=fRg2FSVRnUqcP7BvLt3ysIK0sM/zfbbjd9HAOaA7JuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E75kLJkzhmslq43tqzKn6UhhUWYMRhmPYOA0M/oXeDGVk7qFTRdph9rYtQ6i6zW/4CVevzc+ij+iwegpyso85QZDdVxBzk1661pnghLad/H9dUYHGLXWu6ZqoPOZv6o6OSRI2jdiac4EhmXSCCvUXv24/RNm5nYA8wR0oWN+sms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ANfRYURz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZoieQqK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ANfRYURz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZoieQqK"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 413D7EC0853;
	Tue,  8 Jul 2025 16:45:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 08 Jul 2025 16:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752007521; x=1752093921; bh=Is5Vr2Qn2Z
	0XrB1SQHEqyDtZn2h5Ij0AH0gMSvRSG5I=; b=ANfRYURzh+mJKfWDI1zLHWqZ3Y
	7Aja6kl5bJRZl2i63qMfyTshxfk3imsXRud7Wu/fiNHkpK/jkm64hRFLB802/Pa3
	l7pNpB4DnwKS4j82NdJzMrNVXJWhyIj6RvTSLPeoQA5SYiwF7yynVmuROB9v+MYR
	vZ9IqpD5atjb6HbBw60lO3K9AFUzuWiK8DCgIxHZZTTvU0evwZFIaR3MDeRITOJW
	2aypWzchSHoCme/ATBaRz5UYIjYqvcWgscGPLKFPDS8SRjFUPD3S+pRprFIzw7if
	6uHpGSN4/TdNo7mCvW2mdz/cypgBLCg4DToSg9KJiRuLL3sWCVOYWVEjTFsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752007521; x=1752093921; bh=Is5Vr2Qn2Z0XrB1SQHEqyDtZn2h5Ij0AH0g
	MSvRSG5I=; b=MZoieQqKbG4LkLRLJ90PmjzN7buXbKlMp2tNMEErU4nqxYCOzX9
	+Dwett6Habxe8qg7SMAoUExSMWVZUb9zZvGMJkBDbOMv/XUQIJGmFmWZ1YxcKdMa
	oFMJyrjXiVA6URU0XXzhSWdea5TSsZEpwis2oVmCG3X3KjmLJrs4ceeNvJVYambb
	+vnt7uP0/4ycUWfCI16LSvhm+h+tdB9Hxb+hjtoCVYciIe9ZwGqt1KNygem8VQ0B
	kBzZG/+FniY8wmOVW4HmV1fNmphcIjPShY/PQ2RwrsHJ1lHJXfCr1PtKTrkR3sM8
	kfP1zuPHnDhBvSZX7H8wa2cCUjbBxI1PfzA==
X-ME-Sender: <xms:YYNtaChkPmErSnE8YSdZavD4z7AlSjLQPfRDZ0lsZy6GrdJJxQs2mQ>
    <xme:YYNtaNmiVujfMBtym-ItH8-4z3bqAUu5GK5__-M-qJKbKC6XBS3y8aZwdcQtLE-Br
    JSlE1Vy5S7_xSIpaw>
X-ME-Received: <xmr:YYNtaGpaXur9O2w-5VLMNtlJhToo_yOC15F0lbu742hMEeZu1hOjj0dQ5ox06zEowUh7Kcv38IBTXvLyKnoxsEEWCNHVG97tXf5AFuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YYNtaOHwYILkj8q-YQjWKQCjPsGgMFCbMXsxZsf1Bs2V14X69so3wQ>
    <xmx:YYNtaKwDsxe6dIWxfksl4N-gF7pyV-uchunINwIpcVl7izjBpeXVHA>
    <xmx:YYNtaLorAP8vE4_mh__YScN5fryRw5OgvbzjOF3US8ERXbGx7yXjxA>
    <xmx:YYNtaMigAHG_aUjQks5i_Zb_0PyuWYHnFs_n1r7i7jOUDu29F3a0Kw>
    <xmx:YYNtaLTwlC-lZbc5vKZwmwFw87qjBydDOPcuCEBNdyDDWL6Ryr-3dmme>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 16:45:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] docs/git-pack-refs: document heuristic used for packing
 loose refs
In-Reply-To: <20250708-b4-pks-pack-refs-document-files-heuristic-v1-1-e28d65a94573@pks.im>
	(Patrick Steinhardt's message of "Tue, 08 Jul 2025 13:23:56 +0200")
References: <20250708-b4-pks-pack-refs-document-files-heuristic-v1-1-e28d65a94573@pks.im>
Date: Tue, 08 Jul 2025 13:45:19 -0700
Message-ID: <xmqqqzyqtns0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Reported-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> a small fix for our out-of-date documentation, as discovered by Karthik.

Thanks, both.  Looks good.  Will queue.

